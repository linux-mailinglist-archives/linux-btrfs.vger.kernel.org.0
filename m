Return-Path: <linux-btrfs+bounces-13670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4063AA9E5E
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 23:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37651A801D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB682741C5;
	Mon,  5 May 2025 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="tVWYNLNO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b47mvu0O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB51C6FF5
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746481707; cv=none; b=toCfJuwSnp8jxl09JeK86/DSgQpRI/T5syuqT9bjgWQdWF33jnf0XnwfOu10foJD2idD5bc31wlrMa6m5YdPCOIyjxs1BGt1xavkHPHh4Gb3C8tvJMjLKzVQaBlmRL5OZVROSNeMv4FQHPDUdPllHR25hk+RripjBsKc/aOXRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746481707; c=relaxed/simple;
	bh=KGedMPzKATO9kznKNu1zh+cLCb2cPXKKeGtPcRV86qI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YUKbfOTwHJuaWFbyZJhDaimKVpZEIrrm1DFU+Ed5bORdNHvTc4AMzHV+tx4yT08PLZYSDkKnIoHfSfVAjoAoOMs80Fc8NuEMrO7yRuYfrQ0QDai+W5+wz6YOg6F/Wx780Eb0U8s7/ntaYIh8dd0c3WZ1uIazegK1070bZ15wNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=tVWYNLNO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b47mvu0O; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A1962540223;
	Mon,  5 May 2025 17:48:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 05 May 2025 17:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1746481703; x=1746568103; bh=lUK297scc08D387oarkC7
	AkSUKL2I4/1ozsmtq/5hcM=; b=tVWYNLNOs0yt/8xOInrS1816JgVhUgxfbh134
	21Jdxq0PsusrVMyC1LBvDwJ/5UenZMjJbrA6+VqDkl3ZrfGig3J9k85CzVDNaGEz
	u1UiQAkJgdP/RLnVFSiEjBT7COWoIWbribt7RkQYw+aGHu4jsMph8M0Y5U9L3pzy
	FHIuFJ87nqotnDDQwV39vqDBkDfnmSj+GifWeHAo25uHVhfjdaK080jgGQQmEcSZ
	2SQxUPHTknmqgqcrQG79I/3ak1SsXs0xuynACi+p/vlFHeWMoP3dDSzei3g2pW8A
	j7D70zmGrBzLjOhXkmM4BNwXC5f7t98se1orPb175gHkMaPNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746481703; x=1746568103; bh=lUK297scc08D387oarkC7AkSUKL2I4/1ozs
	mtq/5hcM=; b=b47mvu0OZ/KFHil0L3Igkb/zqVp5uTewy3wQyQPaLJLiEFFDWCY
	q5dyc11SIv+XzG/4ni/h0f3RP7FIdaRn//frVqMJA+yjSOAzHA+jWIvWnrjqj8YC
	NeJl1Qmqvs7P6Go9w3eUa0vTla2CuByEihbNfVk4AGBQvqaUmWfHlhNrC6mhdjIo
	/hqEuNF9bR+v4WTh/tfvUKh+nQCKGQPt2gD036zuK+A+p2o+ojTLuvHCaL+WUFxY
	xOBXiFng3fos/qPPX+HQ+8w3HwKZDGYqSFD/XX6B+w+9MJ8fZX9yPPEjd6Sp4xcT
	Rrg13YxmU+PUpMnFV3Y7rnOQl5+Ke5WEbYg==
X-ME-Sender: <xms:JjIZaATJmtrDrjRVT1gQwjapUMdYZJMjb32k5u5A76-6cx7rsxf3eQ>
    <xme:JjIZaNxKJzSYRkMTv1ljFOd-5xRvr8snclqiCYwB4L5Ls3tdHRPgNFb5X25-ewjlV
    Axa6AOnk-ZF8J6Qmjk>
X-ME-Received: <xmr:JjIZaN3fLEQO0tAH-8K3nb5nfeGRMEVQBCLc3mUsfW-ymEjdvoxXzzjD2ByWxG7qh9x6qOti_zLRXlbEjOfXwG44eBs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedvvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiledtfffhhfdvtdefge
    dvieetleeijeejiedthfefgeekheevheekjeelkeegkeenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:JjIZaEBL26JIYVuzp9Dn3qASlEF9OoY4oedapHN_BXQ4cBdFV-nXjA>
    <xmx:JzIZaJhOPniFL6KbcYeRK28Orc-l3z2YTpk8eNF2HS0oxiQpScPQ2g>
    <xmx:JzIZaAqjKvLTtF1IsoGUVsya1eJFe0A-BVU1VTh48m-6vKFGZKzXXA>
    <xmx:JzIZaMj4d9Yn-W9Fkg_VpOaq6j8Ezz6XCAVqqIOE8o41ud4e0roqdg>
    <xmx:JzIZaNAcPQN19jiFwG7MEy0mawmH4t33CkezwT6o78Mck21AsB07bHxo>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 17:48:22 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4] btrfs: fix broken drop_caches on extent buffer folios
Date: Mon,  5 May 2025 14:49:08 -0700
Message-ID: <b1fd74c27ccbc9f967f68e17a443c50411987e19.1746481493.git.boris@bur.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The (correct) commit e41c81d0d30e ("mm/truncate: Replace page_mapped()
call in invalidate_inode_page()") replaced the page_mapped(page) check
with a refcount check. However, this refcount check does not work as
expected with drop_caches for btrfs's metadata pages.

Btrfs has a per-sb metadata inode with cached pages, and when not in
active use by btrfs, they have a refcount of 3. One from the initial
call to alloc_pages(), one (nr_pages == 1) from filemap_add_folio(), and
one from folio_attach_private(). We would expect such pages to get dropped
by drop_caches. However, drop_caches calls into mapping_evict_folio() via
mapping_try_invalidate() which gets a reference on the folio with
find_lock_entries(). As a result, these pages have a refcount of 4, and
fail this check.

For what it's worth, such pages do get reclaimed under memory pressure,
so I would say that while this behavior is surprising, it is not really
dangerously broken.

When I asked the mm folks about the expected refcount in this case, I
was told that the correct thing to do is to donate the refcount from the
original allocation to the page cache after inserting it.
https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.org/

Therefore, attempt to fix this by adding a put_folio() to the critical
spot in alloc_extent_buffer() where we are sure that we have really
allocated and attached new pages. We must also adjust
folio_detach_private() to properly handle being the last reference to the
folio and not do a use-after-free after folio_detach_private().

extent_buffers allocated by clone_extent_buffer() and
alloc_dummy_extent_buffer() are unmapped, so this transfer of ownership
from allocation to insertion in the mapping does not apply to them.
However, we can still folio_put() them safely once they are finished
being allocated and have called folio_attach_private().

Finally, removing the generic put_folio() for the allocation from
btrfs_detach_extent_buffer_folios() means we need to be careful to do
the appropriate put_folio() in allocation failure paths in
alloc_extent_buffer(), clone_extent_buffer() and
alloc_dummy_extent_buffer.

Link: https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.org/
Tested-by: Klara Modin <klarasmodin@gmail.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
Note: Resending as V4 because of the convoluted history of this patch,
the contributions from multiple reviewers/testers, and the non-trivial
nature of the two merged patches.

Changelog:
v4:
* merge Daniel Vacek's patch
  "btrfs: put all allocated extent buffer folios in failure case"
  which fixes the outstanding missing folio_put() calls on the partial
  failure path of alloc_extent_buffer.
v3:
* call folio_put() before using extent_buffers allocated with
  clone_extent_buffer() and alloc_dummy_extent_buffer() to get rid of
  the UNMAPPED exception in btrfs_release_extent_buffer_folios().
v2:
* Used Filipe's suggestion to simplify detach_extent_buffer_folio and
  lose the extra folio_get()/folio_put() pair
* Noticed a memory leak causing failures in fstests on smaller vms.
  Fixed a bug where I was missing a folio_put() for ebs that never got
  their folios added to the mapping.


 fs/btrfs/extent_io.c | 108 +++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cbaee10e2ca8..884adc4d4f9d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2747,6 +2747,7 @@ static bool folio_range_has_eb(struct folio *folio)
 static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct folio *folio)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct address_space *mapping = folio->mapping;
 	const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
 	/*
@@ -2754,11 +2755,11 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 	 * be done under the i_private_lock.
 	 */
 	if (mapped)
-		spin_lock(&folio->mapping->i_private_lock);
+		spin_lock(&mapping->i_private_lock);
 
 	if (!folio_test_private(folio)) {
 		if (mapped)
-			spin_unlock(&folio->mapping->i_private_lock);
+			spin_unlock(&mapping->i_private_lock);
 		return;
 	}
 
@@ -2777,7 +2778,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 			folio_detach_private(folio);
 		}
 		if (mapped)
-			spin_unlock(&folio->mapping->i_private_lock);
+			spin_unlock(&mapping->i_private_lock);
 		return;
 	}
 
@@ -2800,7 +2801,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 	if (!folio_range_has_eb(folio))
 		btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_METADATA);
 
-	spin_unlock(&folio->mapping->i_private_lock);
+	spin_unlock(&mapping->i_private_lock);
 }
 
 /* Release all folios attached to the extent buffer */
@@ -2815,9 +2816,6 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
 			continue;
 
 		detach_extent_buffer_folio(eb, folio);
-
-		/* One for when we allocated the folio. */
-		folio_put(folio);
 	}
 }
 
@@ -2852,6 +2850,21 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
 	return eb;
 }
 
+/*
+ * For use in eb allocation error cleanup paths, as btrfs_release_extent_buffer()
+ * does not call folio_put(), and we need to set the folios to NULL so that
+ * btrfs_release_extent_buffer() will not detach them a second time.
+ */
+static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
+{
+	for (int i = 0; i < num_extent_folios(eb); i++) {
+		ASSERT(eb->folios[i]);
+		detach_extent_buffer_folio(eb, eb->folios[i]);
+		folio_put(eb->folios[i]);
+		eb->folios[i] = NULL;
+	}
+}
+
 struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 {
 	struct extent_buffer *new;
@@ -2869,25 +2882,30 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
 	ret = alloc_eb_folio_array(new, false);
-	if (ret) {
-		btrfs_release_extent_buffer(new);
-		return NULL;
-	}
+	if (ret)
+		goto release_eb;
 
 	for (int i = 0; i < num_extent_folios(src); i++) {
 		struct folio *folio = new->folios[i];
 
 		ret = attach_extent_buffer_folio(new, folio, NULL);
-		if (ret < 0) {
-			btrfs_release_extent_buffer(new);
-			return NULL;
-		}
+		if (ret < 0)
+			goto cleanup_folios;
 		WARN_ON(folio_test_dirty(folio));
 	}
+	for (int i = 0; i < num_extent_folios(src); i++)
+		folio_put(new->folios[i]);
+
 	copy_extent_buffer_full(new, src);
 	set_extent_buffer_uptodate(new);
 
 	return new;
+
+cleanup_folios:
+	cleanup_extent_buffer_folios(new);
+release_eb:
+	btrfs_release_extent_buffer(new);
+	return NULL;
 }
 
 struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
@@ -2902,13 +2920,15 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	ret = alloc_eb_folio_array(eb, false);
 	if (ret)
-		goto out;
+		goto release_eb;
 
 	for (int i = 0; i < num_extent_folios(eb); i++) {
 		ret = attach_extent_buffer_folio(eb, eb->folios[i], NULL);
 		if (ret < 0)
-			goto out_detach;
+			goto cleanup_folios;
 	}
+	for (int i = 0; i < num_extent_folios(eb); i++)
+		folio_put(eb->folios[i]);
 
 	set_extent_buffer_uptodate(eb);
 	btrfs_set_header_nritems(eb, 0);
@@ -2916,15 +2936,10 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	return eb;
 
-out_detach:
-	for (int i = 0; i < num_extent_folios(eb); i++) {
-		if (eb->folios[i]) {
-			detach_extent_buffer_folio(eb, eb->folios[i]);
-			folio_put(eb->folios[i]);
-		}
-	}
-out:
-	kmem_cache_free(extent_buffer_cache, eb);
+cleanup_folios:
+	cleanup_extent_buffer_folios(eb);
+release_eb:
+	btrfs_release_extent_buffer(eb);
 	return NULL;
 }
 
@@ -3357,8 +3372,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * btree_release_folio will correctly detect that a page belongs to a
 	 * live buffer and won't free them prematurely.
 	 */
-	for (int i = 0; i < num_extent_folios(eb); i++)
+	for (int i = 0; i < num_extent_folios(eb); i++) {
 		folio_unlock(eb->folios[i]);
+		/*
+		 * A folio that has been added to an address_space mapping
+		 * should not continue holding the refcount from its original
+		 * allocation indefinitely.
+		 */
+		folio_put(eb->folios[i]);
+	}
 	return eb;
 
 out:
@@ -3371,30 +3393,26 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * we'll lookup the folio for that index, and grab that EB.  We do not
 	 * want that to grab this eb, as we're getting ready to free it.  So we
 	 * have to detach it first and then unlock it.
-	 *
-	 * We have to drop our reference and NULL it out here because in the
-	 * subpage case detaching does a btrfs_folio_dec_eb_refs() for our eb.
-	 * Below when we call btrfs_release_extent_buffer() we will call
-	 * detach_extent_buffer_folio() on our remaining pages in the !subpage
-	 * case.  If we left eb->folios[i] populated in the subpage case we'd
-	 * double put our reference and be super sad.
 	 */
-	for (int i = 0; i < attached; i++) {
-		ASSERT(eb->folios[i]);
-		detach_extent_buffer_folio(eb, eb->folios[i]);
-		folio_unlock(eb->folios[i]);
-		folio_put(eb->folios[i]);
+	for (int i = 0; i < num_extent_pages(eb); i++) {
+		struct folio *folio = eb->folios[i];
+
+		if (i < attached) {
+			ASSERT(folio);
+			detach_extent_buffer_folio(eb, folio);
+			folio_unlock(folio);
+		} else if (!folio)
+			continue;
+
+		ASSERT(!folio_test_private(folio));
+		folio_put(folio);
 		eb->folios[i] = NULL;
 	}
-	/*
-	 * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
-	 * so it can be cleaned up without utilizing folio->mapping.
-	 */
-	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
-
 	btrfs_release_extent_buffer(eb);
+
 	if (ret < 0)
 		return ERR_PTR(ret);
+
 	ASSERT(existing_eb);
 	return existing_eb;
 }
-- 
2.49.0


