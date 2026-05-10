<?php
$files = glob(__DIR__ . '/*.png') ?: [];
sort($files);
$images = array_map(fn($f) => basename($f), $files);
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Print Planner — Previews</title>
<style>
  :root { color-scheme: light dark; }
  body { font-family: system-ui, sans-serif; margin: 1.5rem; }
  header { display: flex; gap: 1rem; align-items: baseline; flex-wrap: wrap; }
  h1 { margin: 0; font-size: 1.25rem; }
  #count { color: #888; font-size: 0.9rem; }
  #search { flex: 1 1 300px; padding: 0.5rem 0.75rem; font-size: 1rem; border: 1px solid #888; border-radius: 4px; }
  .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 1rem; margin-top: 1rem; }
  .card { border: 1px solid #ccc; border-radius: 6px; padding: 0.5rem; background: rgba(127,127,127,0.05); }
  .card img { width: 100%; height: auto; display: block; border-radius: 3px; }
  .card .name { margin-top: 0.5rem; font-size: 0.85rem; word-break: break-all; text-align: center; }
  .card a { color: inherit; text-decoration: none; }
  .card.hidden { display: none; }
  .empty { color: #888; margin-top: 2rem; }
</style>
</head>
<body>
<header>
  <h1>Previews</h1>
  <span id="count"><?= count($images) ?> images</span>
  <input id="search" type="search" placeholder="Filter by filename…" autofocus>
</header>

<?php if (empty($images)): ?>
  <p class="empty">No PNG files in <code>build/png/</code> yet. Run <code>ddev preview &lt;model&gt; &lt;preset&gt;</code>.</p>
<?php else: ?>
<div class="grid" id="grid">
  <?php foreach ($images as $name): ?>
    <div class="card" data-name="<?= htmlspecialchars(strtolower($name), ENT_QUOTES) ?>">
      <a href="<?= htmlspecialchars(rawurlencode($name)) ?>" target="_blank">
        <img src="<?= htmlspecialchars(rawurlencode($name)) ?>" alt="<?= htmlspecialchars($name) ?>" loading="lazy">
        <div class="name"><?= htmlspecialchars($name) ?></div>
      </a>
    </div>
  <?php endforeach; ?>
</div>
<p id="noresults" class="empty" hidden>No matches.</p>
<?php endif; ?>

<script>
  const search = document.getElementById('search');
  const cards = document.querySelectorAll('.card');
  const noresults = document.getElementById('noresults');
  const count = document.getElementById('count');
  const total = cards.length;

  search?.addEventListener('input', () => {
    const terms = search.value.toLowerCase().trim().split(/\s+/).filter(Boolean);
    let visible = 0;
    cards.forEach(card => {
      const name = card.dataset.name;
      const match = terms.every(t => name.includes(t));
      card.classList.toggle('hidden', !match);
      if (match) visible++;
    });
    count.textContent = visible === total ? `${total} images` : `${visible} / ${total} images`;
    if (noresults) noresults.hidden = visible !== 0;
  });
</script>
</body>
</html>
