Return-Path: <linux-btrfs+bounces-13167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EFBA93CBC
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 20:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8934217B990
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 18:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26336222592;
	Fri, 18 Apr 2025 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="diCsvCBY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K5BXdvUe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1310433C4
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745000639; cv=none; b=UYyotXDSnY18CIBlXZulfOcDO2Lt1p3GjN+XFjyhQ48wrQA2BJHD7kUiF3NAba8wJQD38YpRW+W01bdFFlCT6+ZWItQlwoZ6QH2j0V2c+o9wmoEEp7KJQcPDwCN+69BU/nvj3PElmvO9TtNMuMzTZoHXJLXqi4WofhEiqo5Sxog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745000639; c=relaxed/simple;
	bh=SkLpLRs1YOt/LvySWO93buJ566LzP0jPjwHfzo94ryE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pyldctrO2+zYb6THed/TGFvlFQFpNPk/AA2b5uxbvPs/cCE+aAms86Wc1FEyxVpcKj1a16h8s4iCEiMYQ+W/fG/f+FAbP9N1FTEqAbhMjOyqQDYIlukyYBmfyQP6k8bKGAqBhgs187onIdMNPOwyakArpmrzh303U/ysfXj2Hjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=diCsvCBY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K5BXdvUe; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 949EB11400FC;
	Fri, 18 Apr 2025 14:23:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 18 Apr 2025 14:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1745000634; x=1745087034; bh=DDLXbse0F31cecCppT8Ss
	O9R6DJMt/n0gAA9CY8TGsE=; b=diCsvCBYhWMbHbXoqkogd/Hu5XVDZHdDTWC7z
	KFWTJcnovDqEG+QjpktLk+FhSWv9aTnICSuqcChy8wj9X+WWXl3G/2/rqncttQSk
	GoZ58Wcb0UbD6CnJZePgFHZTX9ojyqjFPiYX6+sHVMjAJohUVPrUVoh6NtgqTxnD
	b0yNiqcQWG1UUtelbbspebNm4ujLhM/xAV/6axF/MU8Yev1eQbz9xIvnALZPT4aw
	WnQrI5kur8ai/D8WJffIHVJpGsMFoIbLn37XRjMKp99kG2KKo0SIVJubinphmm1p
	9kyRoJnkyHn8P/fnvn922Y/8V5upPk/KTOZHV25UvVgVZD2xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745000634; x=1745087034; bh=DDLXbse0F31cecCppT8SsO9R6DJMt/n0gAA
	9CY8TGsE=; b=K5BXdvUeFEFWIvY6YpFRGbDwgUlZSYtjCMktmiecxdBJMvEsrel
	s2OeC4XVnOrFWMsjSRnwOkxvKQvDVLg0MBSBKAcbXUsDB/VYzbsX2TwdL0iJ6POT
	q78tSaPqkwpHbQZUZs4SrKtP0LjFFDXtl0lbSztz90MfxkQu+fzQsN7gRO702G/i
	1yXHOTyN1ejXCdktZgjiIxDumqqPedukUvMleEf+cQS7PSCp0jCUTw7dYgoM/kZk
	YxYGXOdFEpWV8Wn4Cv9Xokc9EEubhhUbAQwQi/O4zfmFiTO9BLxlxW8YS4l6q4YE
	DW4OKAdQqZLMOCWVCwS0HobgXT+lREuFVxQ==
X-ME-Sender: <xms:uZgCaM_DMj2opgXXrr9xlYgmUuStDDDC8QfjWRMjcEazc_mXpk2xpg>
    <xme:uZgCaEt1U_dUYsyLwZsudk5_qYtrA9eenuKjZYsc9YAGJmcgMk6viiT4H7vygYt9v
    HOZjyT6_HCIYhxjVVM>
X-ME-Received: <xmr:uZgCaCCrbmwmywAlbhn6e-aw90x9AEpxXQ_ZlyLpiHZ80sxgxxWxWksg9AvvG1cO2MJdN4tIzaa9NT74iXEx_QlwBrk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiledtfffhhfdvtdefge
    dvieetleeijeejiedthfefgeekheevheekjeelkeegkeenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:upgCaMcIQV-s2zE88YPjpC0J3P9pZBhEZ66YNigUQcWev-3VEK6R4g>
    <xmx:upgCaBNLS-JAaUMxMPQjLe0yytcXCvbxWmkZrz3fw22Rn2is8-YJzQ>
    <xmx:upgCaGml7C956jD-MkZZLOr0c-Rp_yyRHRC3vp3rtclx3xJbBEA-Jw>
    <xmx:upgCaDtVyAFrAKPArXCO9gPE9h5KUs5ivTsddS5c_l1DuFPqpxesUg>
    <xmx:upgCaEi01PkSkJJL6yoAdvxCpMSYT3cIRxzZy2-sdzLK3D33LjOug5Bl>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 14:23:53 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3] btrfs: fix broken drop_caches on extent_buffer folios
Date: Fri, 18 Apr 2025 11:25:02 -0700
Message-ID: <9441faad18d711ba7bccd2818e6762df0e948761.1745000301.git.boris@bur.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The (correct) commit
e41c81d0d30e ("mm/truncate: Replace page_mapped() call in invalidate_inode_page()")
replaced the page_mapped(page) check with a refcount check. However,
this refcount check does not work as expected with drop_caches for
btrfs's metadata pages.

Btrfs has a per-sb metadata inode with cached pages, and when not in
active use by btrfs, they have a refcount of 3. One from the initial
call to alloc_pages, one (nr_pages == 1) from filemap_add_folio, and one
from folio_attach_private. We would expect such pages to get dropped by
drop_caches. However, drop_caches calls into mapping_evict_folio via
mapping_try_invalidate which gets a reference on the folio with
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
spot in alloc_extent_buffer where we are sure that we have really
allocated and attached new pages. We must also adjust
folio_detach_private to properly handle being the last reference to the
folio and not do a UAF after folio_detach_private().

Finally, extent_buffers allocated by clone_extent_buffer() and
alloc_dummy_extent_buffer() are unmapped, so this transfer of ownership
from allocation to insertion in the mapping does not apply to them.
However, we can still folio_put() them safely once they are finished
being allocated and have called folio_attach_private().

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
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


 fs/btrfs/extent_io.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5f08615b334f..a6c74c1957ff 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2752,6 +2752,7 @@ static bool folio_range_has_eb(struct folio *folio)
 static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct folio *folio)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct address_space *mapping = folio->mapping;
 	const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
 	/*
@@ -2759,11 +2760,11 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
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
 
@@ -2783,7 +2784,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 			folio_detach_private(folio);
 		}
 		if (mapped)
-			spin_unlock(&folio->mapping->i_private_lock);
+			spin_unlock(&mapping->i_private_lock);
 		return;
 	}
 
@@ -2806,7 +2807,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 	if (!folio_range_has_eb(folio))
 		btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_METADATA);
 
-	spin_unlock(&folio->mapping->i_private_lock);
+	spin_unlock(&mapping->i_private_lock);
 }
 
 /* Release all folios attached to the extent buffer */
@@ -2821,9 +2822,6 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
 			continue;
 
 		detach_extent_buffer_folio(eb, folio);
-
-		/* One for when we allocated the folio. */
-		folio_put(folio);
 	}
 }
 
@@ -2889,6 +2887,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 			return NULL;
 		}
 		WARN_ON(folio_test_dirty(folio));
+		folio_put(folio);
 	}
 	copy_extent_buffer_full(new, src);
 	set_extent_buffer_uptodate(new);
@@ -2915,6 +2914,8 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 		if (ret < 0)
 			goto out_detach;
 	}
+	for (int i = 0; i < num_extent_folios(eb); i++)
+		folio_put(eb->folios[i]);
 
 	set_extent_buffer_uptodate(eb);
 	btrfs_set_header_nritems(eb, 0);
@@ -3365,8 +3366,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
-- 
2.49.0


