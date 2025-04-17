Return-Path: <linux-btrfs+bounces-13150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891F3A92DDD
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 01:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C8E448098
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 23:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA40C214813;
	Thu, 17 Apr 2025 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ATLWMah5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="feCjMcKB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8987E18BC0C
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 23:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931740; cv=none; b=NhTbcwnqvvTCDk174U+X2Rzrw3IsOhq6BWHuWEAP5eEJIPxxrPkJi//G4HJTyYkRfNM32a3EjyU38yevdJINDcjZkvOt6rhCL0lpv/XtOSB4nmaFaFQRfpTecS7iRxZR/GxzbLc8nd5MFbmodeYY5EX+fNK9ev780jGvOp9Nyno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931740; c=relaxed/simple;
	bh=796A8lKayBmYTRY9Tb8rAkscH1dnuWUnXQramwOoGPE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Xtc4CGN2kIi3vtG8ZQ7dqgVG1SK7xlxkw7R6Q4ElIjycmJZinW1y/Dq7t29xzGmU7h0MK9x9odjvdui1B6TWBW74Z5XaI/kamOsaWE95tvFEVJw645yhuG79wV4oEl3iOu7p8QBXXEhgfv4U1oehQteCm4S+N5Hc6vaPrzg1/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ATLWMah5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=feCjMcKB; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 7992211400D1;
	Thu, 17 Apr 2025 19:15:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 17 Apr 2025 19:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1744931736; x=1745018136; bh=jAhTPPZ3HZiqabawQCgns
	Nhabm7aljr9d9vT5dg136g=; b=ATLWMah5/drZSsrQtMqc71m0jor3dCBT8+70b
	2KQ22PKl7O/5Laz3GvI3J8t7/wrjEtibODIAcS9KxGjqEKE/GzJqAndgCsoliXx/
	cMHQ3fuC3e3NMK4PFT7Re9cuWDdefvBf947e+zFW8d4XduB6TZkejoQkesCkGGCS
	Z1OAOZ3o42g3WNbQ93arWZLgXxLEhwkfXVYDJRoOAxzgYt6LSms5q96klveezFoc
	OpDPkWWm/ufrSJ27TvhrZY0+XXLRqObCS8e26jgHG5S6Z9kmLJTB+jDOhvvtFVhb
	RdiZS4tIKo/vZxuTUmY8j9L8STy30owhN8T4dy7O7N/p12wtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744931736; x=1745018136; bh=jAhTPPZ3HZiqabawQCgnsNhabm7aljr9d9v
	T5dg136g=; b=feCjMcKBv6QPdIAK6u4+DnL+dEUmuxz6re8EccuBM4iNFVXRJIM
	k/9g0sXCpN604navgI/a9gGsT8elHbfNcjVhvj8/8dsMQcNLmN1ofA+wkQfSm4Pz
	PDLyu6Q2IIYu2uX3CzfZu24DMbX8tIrg0o0MXyIor+WZwFPZIEaoNHK5+aLSQpRP
	1lszBUsveeW4POSEMmB9lkpucFB/KbUnzKxNwkSztm9WK+ULuKzNMpEFWTZIfDvq
	b/dWOIowNKdSTAspQI6iM2Uz5ggbQAmfqiqCfuepwZ1GT3Cfmbyo9fWkHYD7fFZt
	c49Wilh/DhwkYEdvRFHcNkZfsP/GQDjXG0Q==
X-ME-Sender: <xms:l4sBaN2-VONbge1AgK4pQyLrIHoxVUkuYToFkYPfhoGE4gu98VDprg>
    <xme:l4sBaEHuQdABDYAD5m3-ktHHKVsbs6cNiihgDK2l6XCBCb2ykc5w13Io-xXJfXc9q
    n-uS-6MVWm4h5cew94>
X-ME-Received: <xmr:l4sBaN4vbeGuuUF97rGkXJt9OgdtA8IL7KgcnS6QM8rgKH_HCcy_jVRR8JSN5MbQxUd_V3XpD0Zkxw6gvWA0E0eC3fk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedtheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiledtfffhhfdvtdefge
    dvieetleeijeejiedthfefgeekheevheekjeelkeegkeenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:l4sBaK1BCv600iaE3vtuFVkCiQixXMSCqgn9NaF4UbSO6C6uHA00lA>
    <xmx:l4sBaAEpHy86tmlL-6xSVwqA1ZPuCmQ6jcAAzq7XA9ZHVYVw387HKw>
    <xmx:l4sBaL_37TpEVWushGFoVuxHB5gRjlT2oYz3ARAL-EMNbwDUUcGW-A>
    <xmx:l4sBaNmnmVyss9bkbKhjC-z2jovA9UX-Yad9CEq2IufIR4ZUyNv9cA>
    <xmx:mIsBaDYhRH8TKh-DUz2SgApCm3eBaKEVbAz_GjuRNY1TgPjjPhPtybdH>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 19:15:35 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs: fix broken drop_caches on extent_buffer folios
Date: Thu, 17 Apr 2025 16:16:40 -0700
Message-ID: <f5a3cbb2f51851dc55ff51647a214f912d6d5043.1744931654.git.boris@bur.io>
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
Therefore, they still need a folio_put() as before.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v2:
* Used Filipe's suggestion to simplify detach_extent_buffer_folio and
  lose the extra folio_get()/folio_put() pair
* Noticed a memory leak causing failures in fstests on smaller vms.
  Fixed a bug where I was missing a folio_put() for ebs that never got
  their folios added to the mapping.

 fs/btrfs/extent_io.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5f08615b334f..90499124b8a5 100644
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
@@ -2821,9 +2822,13 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
 			continue;
 
 		detach_extent_buffer_folio(eb, folio);
-
-		/* One for when we allocated the folio. */
-		folio_put(folio);
+		/*
+		 * We only release the allocated refcount for mapped extent_buffer
+		 * folios. If the folio is unmapped, we have to release its allocated
+		 * refcount here.
+		 */
+		if (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))
+			folio_put(folio);
 	}
 }
 
@@ -3365,8 +3370,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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


