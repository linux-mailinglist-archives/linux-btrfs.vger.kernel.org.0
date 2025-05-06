Return-Path: <linux-btrfs+bounces-13732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F1AAACB76
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 18:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B53F1C228B0
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B17280004;
	Tue,  6 May 2025 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="WDwz7Keh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tjRzR400"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E023F404
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550011; cv=none; b=rDIa1/FXhGfSEJnZUgRBuoLrDkWnVhDSLY9xkNgINjVmpS/arVaWU5CR+a6RDnVxzrwIgnGDrVzxIIJeAL2UTvyyRgyKeww7JqWi8cxhcvSQV54FlN2OOEHAI6UD7Y3WC+tuyuP07YEKnMTPP7KfyN2QwrHO4iYUWSwYFxpczA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550011; c=relaxed/simple;
	bh=7rKo0PAn8k6cjdS79Nx21TygBb6yQ7QjW8RbyLkZ3Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYqkZgI5lygmfB458wTYuqXlO0Bs1xK7A/tajdJ1LabJl8FoA/jclSioZgfYxEowVRwaJHG6xMJhmIhecsyOinv/EG4kvIfrvQ1sEvtG50OYU8N1MMRFXaldbiF3mRPz+duZIQwp9FgdDUJRiKUw7Xy9kVzpeAizcNY7WnpZoMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=WDwz7Keh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tjRzR400; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1658F2540198;
	Tue,  6 May 2025 12:46:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 06 May 2025 12:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1746550007; x=1746636407; bh=Trwsg4BxwirnlWOyV335X
	bwsjogzYQ+gx52C8aKaWU8=; b=WDwz7Keh8Skzsw9Nno9ox8DdsfXb1zXK3nqc4
	FrctTnaDXSsuim+/rATJO8HHwCw4G6yYi2WT8ZFIY4dmNFypU4DSki9O0lwpZGiZ
	Aln940C0Q7ws9am08KDo6khDNyrhLx5cHzi9bmgioyLvNDl3p77rVYwxvfnIqCSv
	YBIt4cjrqNxJ6p81lqYV4mAKRfg1DL/ysY8CX61GDZGNgcc/MR/PjbdZjXUqm7iO
	+TQlfOGziwDYgXmDGvO7kQhl+W3Oo6cTuuYhMV8NIWyKctRnmlsKFv5k9efRqzPl
	9JfWfACtlpYOnPH5vzA2np8vvvSNYo218vk9ONS4d4n1iAjKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746550007; x=1746636407; bh=Trwsg4BxwirnlWOyV335XbwsjogzYQ+gx52
	C8aKaWU8=; b=tjRzR400O/1bzpEgN2A2bhUqNdwX7RALB+6CEj77fZAcavC6xaL
	9Gjv9Kn0eW4L5uA2OdHk/xfo8VoUmgwXvyXFhequw1k/jRzbZeSt3fj4bK9APJ9Q
	Otnv6DK8/rhoEItSB/RyCuE+DQw/ABfp/jKxweEBtFDjzcoQ9g3h/pEBawqR0ucI
	HKxm54WVt30ti+664VrgRfFII2BDCZonhiIINQVPb44dvnCE5HA4yX0tBKKAamlg
	xLPbIUMC5+OwImMjCe/W76dQN62qDwSCb0AX+VBhhVR9Iwm/olD1RR4H32lYlq3g
	aLGx3n6jREw0grRLv4/KzKAWw9oECsoL6+g==
X-ME-Sender: <xms:9zwaaIjSThe3VS0M_gn-fzoqua26302iXd7sGPS-DEeLB6pUWcLBtg>
    <xme:9zwaaBDwCwtDyhWXUzwjltzlGRQuD-SW886UwGzVOwtxPzMA2s2bxDJYz1wq7I2mR
    hO3Bsbp-JiOKS13iCE>
X-ME-Received: <xmr:9zwaaAHv45MJC-kASm5zItAVKwMo7q2XHLM9SHM1hCKTWn4cMF_rZfAqaLsFoXcB8gQPaNRHVwwDWfMJxSLTP1K_GRM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeggeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcu
    oegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepieegleehjeelfeeife
    eiuefhfefgvefgkedtjefhiedvveetgfduleejheeifffgnecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomhdprhgt
    phhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvg
    hlgiesshhushgvrdgtohhm
X-ME-Proxy: <xmx:9zwaaJQVlzgVewj4UuPqNWFNIygTJjHcpAgpT3VhO5f3nMKWwOy2Cg>
    <xmx:9zwaaFzsak6EatXM4GXK5RsX4ls0IaPBT1NkM9FPDPbWgMYJZ6BobA>
    <xmx:9zwaaH7nl6FTYijD1zVKW2A6EXTdcY_MwGzdlRdIHCJ0sj8OWVS_fg>
    <xmx:9zwaaCxWbmZA5Iy3I_AfIniHHFz-NolkhEC6d-0MGESJ9T1gzOxOSQ>
    <xmx:9zwaaMTsZ0Z88uFcClQkH_zmdMZj3dHCGJ8yq3HnzCwZcK93VJ9TzhQJ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 12:46:47 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: fdmanana@kernel.org,
	neelx@suse.com
Subject: [PATCH v5] btrfs: fix broken drop_caches on extent buffer folios
Date: Tue,  6 May 2025 09:47:32 -0700
Message-ID: <78713bfb50cb72321bd6026dd2e29cfef0b2b047.1746549760.git.boris@bur.io>
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
Changelog:
v5:
* fix num_extent_folios() iteration bug in cleanup_extent_buffer_folios()
* make usage of num_extent_folios() clearer in clone_extent_buffer()
* make some code style fixes in alloc_extent_buffer
* remove extra link in commit message
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


 fs/btrfs/extent_io.c | 115 ++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cbaee10e2ca8..0b6017d9d223 100644
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
 
@@ -2852,9 +2850,27 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
 	return eb;
 }
 
+/*
+ * For use in eb allocation error cleanup paths, as btrfs_release_extent_buffer()
+ * does not call folio_put(), and we need to set the folios to NULL so that
+ * btrfs_release_extent_buffer() will not detach them a second time.
+ */
+static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
+{
+	int num_folios = num_extent_folios(eb);
+
+	for (int i = 0; i < num_folios; i++) {
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
+	int num_folios;
 	int ret;
 
 	new = __alloc_extent_buffer(src->fs_info, src->start);
@@ -2869,25 +2885,33 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
 	ret = alloc_eb_folio_array(new, false);
-	if (ret) {
-		btrfs_release_extent_buffer(new);
-		return NULL;
-	}
+	if (ret)
+		goto release_eb;
 
-	for (int i = 0; i < num_extent_folios(src); i++) {
+	ASSERT(num_extent_folios(src) == num_extent_folios(new),
+	       "%d != %d", num_extent_folios(src), num_extent_folios(new));
+	num_folios = num_extent_folios(src);
+	for (int i = 0; i < num_folios; i++) {
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
+	for (int i = 0; i < num_folios; i++)
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
@@ -2902,13 +2926,15 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 
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
@@ -2916,15 +2942,10 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 
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
 
@@ -3357,8 +3378,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
@@ -3371,27 +3399,22 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
+		} else if (!folio) {
+			continue;
+		}
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
 	if (ret < 0)
 		return ERR_PTR(ret);
-- 
2.49.0


