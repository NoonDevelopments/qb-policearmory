window.addEventListener('message', function(event) {
    if (event.data.action === 'open') {
        document.getElementById('items').innerHTML = '';
        event.data.items.sort((a, b) => a.name.localeCompare(b.name)).forEach(item => {
            const label = item.label || item.name; // Fallback to name if label doesn't exist
            document.getElementById('items').innerHTML += `
                <div class="item">
                    <img src="nui://ox_inventory/web/images/${item.name}.png" alt="${label}">
                    <span>${label}</span>
                    <span class="cost-label">$${item.price}</span>
                    <button onclick="buyItem('${item.name}', ${item.price})">Buy</button>
                </div>
            `;
        });
        document.getElementById('armory').style.display = 'block';
    } else if (event.data.action === 'close') {
        document.getElementById('armory').style.display = 'none';
    }
});

function buyItem(item, price) {
    fetch(`https://${GetParentResourceName()}/buyItem`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ item, price })
    });
}

function closeArmory() {
    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(() => {
        document.getElementById('armory').style.display = 'none';
    });
}

document.onkeyup = function (data) {
    if (data.which == 27) { // ESC key
        closeArmory();
    }
};
