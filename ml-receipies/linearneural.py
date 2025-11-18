import torch
import torch.nn as nn
import torch.optim as optim

# ---------------------------------------------------------
# 1. Select Device (GPU if available, else CPU)
# ---------------------------------------------------------
device = "mps" if torch.backends.mps.is_available() else "cpu"
print("Using device:", device)

# ---------------------------------------------------------
# 2. Create Fake Training Data
#    (We create a simple linear pattern y = 2x + 1)
# ---------------------------------------------------------
X = torch.linspace(0, 10, 100).unsqueeze(1).to(device)
y = 2 * X + 1

# ---------------------------------------------------------
# 3. Define a Simple Neural Network
# ---------------------------------------------------------
class SimpleNN(nn.Module):
    def __init__(self):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(1, 8),
            nn.ReLU(),
            nn.Linear(8, 1)
        )

    def forward(self, x):
        return self.net(x)

model = SimpleNN().to(device)

# ---------------------------------------------------------
# 4. Loss Function + Optimizer
# ---------------------------------------------------------
loss_fn = nn.MSELoss()
optimizer = optim.Adam(model.parameters(), lr=0.01)

# ---------------------------------------------------------
# 5. Training Loop
# ---------------------------------------------------------
for epoch in range(300):

    # Forward pass
    preds = model(X)
    loss = loss_fn(preds, y)

    # Backward pass + Update weights
    optimizer.zero_grad()
    loss.backward()
    optimizer.step()

    # Print every 50 epochs
    if epoch % 50 == 0:
        print(f"Epoch {epoch}, Loss: {loss.item():.4f}")

# ---------------------------------------------------------
# 6. Test the Model
# ---------------------------------------------------------
test_value = torch.tensor([[5.0]]).to(device)
predicted = model(test_value).item()

print("\nPrediction for x=6.0 :", predicted)
