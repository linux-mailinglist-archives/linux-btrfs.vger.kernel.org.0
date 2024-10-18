Return-Path: <linux-btrfs+bounces-9007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABDB9A4A4B
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2024 01:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276E01F234E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 23:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12A91917EE;
	Fri, 18 Oct 2024 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="VuIDXePv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/I56xyn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F220E33E
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Oct 2024 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729295509; cv=none; b=PFzjewdH14UNagGRyu9IlOj1hO5sr6ZD6De4W9GYXUEaXwtkhX4SunZdmbtiqc03lAw7g77EYV130RkIngHBOP3Bq10J7VCMfnioW7gVyMR1esCD2IBwcrkFVCGcNdeyJmTVF1HUSE0BHjKnyCYyK7tWVcRX+yyhenMgaACZbT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729295509; c=relaxed/simple;
	bh=BgccdewMrUOuutR1416IJEaCGiu9YvXfZcDoQnzGoWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dp2fDChHE8vgjDeVI66ypjrRg6qk6lHMGcu4IgGQmlimYsEltSI4gDmUeKOwRrbO7/9skv97zmth3qlWqJIWrgr2Z0X6jZsqAUI4Bg3DwSkzwLH1P47WEd7/dhPgwJGVtc+YP33zSf8jkwEMNZmaKyhkVHqbv7INzkJJ4pWLQJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=VuIDXePv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/I56xyn; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55D7411401A1;
	Fri, 18 Oct 2024 19:51:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 18 Oct 2024 19:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1729295506; x=
	1729381906; bh=i+SwnjnWNbw/7lzx5F2bLJOug1bKHlOXBvcSZ1v1eGo=; b=V
	uIDXePvMMlI51iFoKPnnoVS9jvbCLorP32++c2ptJ7zc0jrPIHnpme8syfm9W6Os
	pKDbrv9qXXJcUsPQG7os3n64102g9gp282h1F0bcaNNDQ9LvLqkltCmuxbtPu67h
	Kuc/ntD9c8adVce+OJSGGf7JAqKKRIMQSiZky3Jvvikafdd2nroQJN+ncDetvF2X
	jRRnhp8JQFJh6NcBy2e2RkI9FF2iWxLzXbIEOBcQ63eDlKf5GYoqlbLS4ttcR+Cd
	n322Bmc/MZbLZwRcwUqA/oy9wdEIfPSvH3xmcDgk8A6IKdOWjVmloEo6zVr07mvF
	imaZCmhsC3XlEy8BNRiYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1729295506; x=1729381906; bh=i+SwnjnWNbw/7
	lzx5F2bLJOug1bKHlOXBvcSZ1v1eGo=; b=E/I56xynLEAk4Xx+sAdOT4LqNrgET
	Dm01pCXD0R5cLJ/cUQBSlJYVeguOLJkStVXcL/4xV5MSlWcFZoG0TO3bEuUSHZ+6
	b0kmOJMXgGoDdugi+6haYt5f4688F4Mk9jGDwVzgxA1TMe+/rIUAMfk+Vx9zPYJV
	8S5pkl1QJegd9aqtdVsBnd29YR4b0hCcs3JdxCjTykhmKXHQxjVyT7L195vS6Cc0
	LZC2uTi08+DjgbtVqTACXJetOZxkei3pXsfsJ6ggQDoFJi6AO1AyE9rZkNqhGJV0
	52Jt02n6fAL3UCQHKFyo18wRs43Tw9r4Jtl+FgyyPmm+Uoy36qODoPWZQ==
X-ME-Sender: <xms:kvQSZwbQcRaWyos7teV0wvy8FMwYdyzjaWyFrvCLWUjLosTvVzctAQ>
    <xme:kvQSZ7YS2RBAOHTjvg1wmzxeogdVYmH9HXD2f3lLqM_yNg6qbtuuek8VYor8bnpKt
    N3N8TBXfEbOGzp6TpA>
X-ME-Received: <xmr:kvQSZ6_TZD4pXLglzWvzZGfxE3QIOq86_X2vIRzt6IoDY6BgOoyTBPlNiPkVNphyLQ43XXaIBMpK5jjECL_I6YKIxsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhhe
    eigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidq
    sghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlh
    dqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:kvQSZ6rHVFOmsgJhMINQJErygj7cVPe06nV9IfiCq2YCzE343j49ig>
    <xmx:kvQSZ7qDd19_NfKqk2JPAkfrwPwGM91NmnnbJQ2HqN3w3eyoWJDzKw>
    <xmx:kvQSZ4TOmkK_G5hlTgdcifrX_WHj2plMWUe3jmMmvIEF8HzhPvPi8Q>
    <xmx:kvQSZ7oXwr0iWz-PqlgzMykMTn6ux7iKQtsqxeEEbW-00fyn6EBpCQ>
    <xmx:kvQSZy2O5dWc-n0QGz9wcvCWQMncLc622iD-N0GVhq3YkL-rf-rCrwMe>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 19:51:45 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3] btrfs: make dropped merge extent_map immutable
Date: Fri, 18 Oct 2024 16:50:13 -0700
Message-ID: <f443abf2897eea14639ec11f077ae510a9448a2e.1729295368.git.boris@bur.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <'01b1cb0e-4642-452d-894d-bc14607c94c5@gmx.com'>
References: <'01b1cb0e-4642-452d-894d-bc14607c94c5@gmx.com'>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In debugging some corrupt squashfs files, we observed symptoms of
corrupt page cache pages but correct on-disk contents. Further
investigation revealed that the exact symptom was a correct page
followed by an incorrect, duplicate, page. This got us thinking about
extent maps.

commit ac05ca913e9f ("Btrfs: fix race between using extent maps and merging them")
enforces a reference count on the primary `em` extent_map being merged,
as that one gets modified.

However, since,
commit 3d2ac9922465 ("btrfs: introduce new members for extent_map")
both 'em' and 'merge' get modified, which started modifying 'merge'
and thus introduced the same race.

We were able to reproduce this by looping the affected squashfs workload
in parallel on a bunch of separate btrfs-es while also dropping caches.
We are still working on a simple enough reproducer to make into an fstest.

The simplest fix is to stop modifying 'merge', which is not essential,
as it is dropped immediately after the merge. This behavior is simply
a consequence of the order of the two extent maps being important in
computing the new values. Modify merge_ondisk_extents to take prev and
next by const* and also take a third merged parameter that it puts the
results in. Note that this introduces the rather odd behavior of passing
'em' to merge_ondisk_extents as a const * and as a regular ptr.

Fixes: 3d2ac9922465 ("btrfs: introduce new members for extent_map")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v3:
- use correct const pointer
- update comment
v2:
- make 'merge' immutable instead of refcounting it
---
 fs/btrfs/extent_map.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index d58d6fc40da1..f8e6f2e42381 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -244,15 +244,21 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
 }
 
 /*
- * Handle the on-disk data extents merge for @prev and @next.
+ * Handle the on-disk data extents merge for @prev and @next
+ *
+ * @prev: left extent to merge
+ * @next: right extent to merge
+ * @merged: the extent we will not discard after the merge; updated with new values
+ *
+ * After this, one of the two extents is the new merged extent and the other is
+ * removed from the tree and likely freed. Note that @merged is one of @prev/@next
+ * so there is const/non-const aliasing occurring here.
  *
  * Only touches disk_bytenr/disk_num_bytes/offset/ram_bytes.
  * For now only uncompressed regular extent can be merged.
- *
- * @prev and @next will be both updated to point to the new merged range.
- * Thus one of them should be removed by the caller.
  */
-static void merge_ondisk_extents(struct extent_map *prev, struct extent_map *next)
+static void merge_ondisk_extents(const struct extent_map *prev, const struct extent_map *next,
+				 struct extent_map *merged)
 {
 	u64 new_disk_bytenr;
 	u64 new_disk_num_bytes;
@@ -287,15 +293,10 @@ static void merge_ondisk_extents(struct extent_map *prev, struct extent_map *nex
 			     new_disk_bytenr;
 	new_offset = prev->disk_bytenr + prev->offset - new_disk_bytenr;
 
-	prev->disk_bytenr = new_disk_bytenr;
-	prev->disk_num_bytes = new_disk_num_bytes;
-	prev->ram_bytes = new_disk_num_bytes;
-	prev->offset = new_offset;
-
-	next->disk_bytenr = new_disk_bytenr;
-	next->disk_num_bytes = new_disk_num_bytes;
-	next->ram_bytes = new_disk_num_bytes;
-	next->offset = new_offset;
+	merged->disk_bytenr = new_disk_bytenr;
+	merged->disk_num_bytes = new_disk_num_bytes;
+	merged->ram_bytes = new_disk_num_bytes;
+	merged->offset = new_offset;
 }
 
 static void dump_extent_map(struct btrfs_fs_info *fs_info, const char *prefix,
@@ -363,7 +364,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 			em->generation = max(em->generation, merge->generation);
 
 			if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
-				merge_ondisk_extents(merge, em);
+				merge_ondisk_extents(merge, em, em);
 			em->flags |= EXTENT_FLAG_MERGED;
 
 			validate_extent_map(fs_info, em);
@@ -378,7 +379,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
 		em->len += merge->len;
 		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
-			merge_ondisk_extents(em, merge);
+			merge_ondisk_extents(em, merge, em);
 		validate_extent_map(fs_info, em);
 		em->generation = max(em->generation, merge->generation);
 		em->flags |= EXTENT_FLAG_MERGED;
-- 
2.47.0


