Return-Path: <linux-btrfs+bounces-9005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789FF9A4A1A
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2024 01:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311001F23572
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 23:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3243018E758;
	Fri, 18 Oct 2024 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="I4NFnOI8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QWul7Xik"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128FA14F9D9
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Oct 2024 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729294497; cv=none; b=lxhM3XsXZ9X7qDY7e/34+jgzcc3iDDrZlW+iKoeDR63fmY/Itf0Sv9TrYtSUZr0T/tlHB7Bgu38AlmN+F9MXlS8cWBzZXxAfXSRa5s0sw9HMxGkahmAJeEbz7nxE1QLBFZJPzQjzs5z/rcmL6n9nNrNtyCoiGiIpLFFR7HeYfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729294497; c=relaxed/simple;
	bh=8bIpWhGJ4zShd1hMeEnBOmkoz4qmVX5lJ/OR6LWGBmo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TAH2vARk2RHe8NNOC3gBpmqZ/okQsVRsjOHhKwHWtc2ah4JvueVW1z/5SjOKMQ4R14kmRcAkXFlJrGLQ55n7dun9HG38lJtngOcW+YdxZPneJHN9DAKIAZuRb/i8wvmkmWGtivHAcikP8TMJEH8LolbaR6VSWo9r4/ktM5eQkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=I4NFnOI8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QWul7Xik; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 108151380185;
	Fri, 18 Oct 2024 19:34:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 18 Oct 2024 19:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1729294494; x=1729380894; bh=7kW2Cu0eAOAXfc/xlbZyH
	1oSrfzAuq1+6KxwCwg3hZU=; b=I4NFnOI8YWuqncRI5BuqMol3skE4OsrVGqvwU
	NUoqIPKg6r3jSnuFtXYBjnCaq91aIeesHz2oW6/H4HbL6nQjfpgxPoQ1sAj4IpDM
	waPn+Q0+Xt4Db/bwor2/YoB2sNqGFviNJ4a0J0hlLkaXvLRfIzrMwJOogQMcppJu
	1oSKCuZjFG706iCDOBUX4zb/02kg2rCuoE8ZS9uH9MKD8Kk8Y5c9SBjh+VGEWqOl
	EXwTJBQL9Ivs3BKubJm4rfgpM23u6pZLZiwLjdt9J6Qbf8LbP+K+3VTG/ZWcszgg
	ZoO1xE88yE2zyYH5gmgG9iEkQSmYu2NI3yFgeiyBv5ZHbvPpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729294494; x=1729380894; bh=7kW2Cu0eAOAXfc/xlbZyH1oSrfzA
	uq1+6KxwCwg3hZU=; b=QWul7Xikhsz3v2Zjgih8xNJbBix2ucsJnU4pELOWxCeT
	lj2Y7tABMuQ+z4Q3SHFapsmrDPccMlPGijAvL4FeLARZVknqWABY5Y4clkt+fovr
	6OetXiCMCb+1mirX7dxDGQXHwZsmfK5+cbfyOtiQJ4S3VvBbP0kAnlB2PHt/0+vm
	NRN3iF3ApU+aHlyHkwAKDpu3SpeoKhtPBYJ1EpHv5+6IVbL34bdL+emBkTNTNawJ
	dknd1rglUg4G9i6VQoj6OdZS73TloGTEFWgXl1LZKGQKCd84ZvCI/QmACPKqeCtI
	LC6hGYzyvaxkDgei5lY5aGizQopvh8XIaSFw5fu3BQ==
X-ME-Sender: <xms:nfASZ99Hix5TmoO2u8CyLEoDm3em_tInIkV5O-SyEDM-Nyb68UyTng>
    <xme:nfASZxsQag_-BPzwGMDtNsIVGTsGYNcI8gKBrzaAcdCKomlgs5NYp-yJuzR76VEI3
    jLcYGn1g37Rz6WnrBI>
X-ME-Received: <xmr:nfASZ7B15RQhCszpg9aLCT7m8CESq29foz1_mIUih-re7eiPfW96OCSPaZ7l5oI-mI45UnLwVU9IqnNlq4xvQC-6rw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosgho
    rhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevle
    eifefgjeejieegkeduudetfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsght
    rhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqth
    gvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:nfASZxeoknAREpEEhtgcZSS-T_xqGCqEhNj2mZS0p2ygQB9SSUZFlQ>
    <xmx:nfASZyMA7tToI9LE_rBaMV-EywsRA9itfL6wt2V7mI6v5ndHPQ1A6w>
    <xmx:nfASZzkdoHjUob6wcZ_mFV1SrL1L8GlqfkLTdplErD9CXo1bzLHwHA>
    <xmx:nfASZ8s4lwdYpRuJjnMMIrdq6iCfZEOL66guQOxcqDYnnDz_QsABlQ>
    <xmx:nvASZ7bOncOAwLi24uG1U7FwuLzmzNZnpnC3l-0GVXnVvZ4m_2T3M9I2>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 19:34:53 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs: make dropped merge extent_map immutable
Date: Fri, 18 Oct 2024 16:34:20 -0700
Message-ID: <76ba30ab42dc77209f9cc1274b06619c7d474303.1729294376.git.boris@bur.io>
X-Mailer: git-send-email 2.47.0
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
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v2:
- make 'merge' immutable instead of refcounting it
---
 fs/btrfs/extent_map.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index d58d6fc40da1..a8290724475a 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -252,7 +252,8 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
  * @prev and @next will be both updated to point to the new merged range.
  * Thus one of them should be removed by the caller.
  */
-static void merge_ondisk_extents(struct extent_map *prev, struct extent_map *next)
+static void merge_ondisk_extents(struct extent_map const *prev, struct extent_map const *next,
+				 struct extent_map *merged)
 {
 	u64 new_disk_bytenr;
 	u64 new_disk_num_bytes;
@@ -287,15 +288,10 @@ static void merge_ondisk_extents(struct extent_map *prev, struct extent_map *nex
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
@@ -363,7 +359,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 			em->generation = max(em->generation, merge->generation);
 
 			if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
-				merge_ondisk_extents(merge, em);
+				merge_ondisk_extents(merge, em, em);
 			em->flags |= EXTENT_FLAG_MERGED;
 
 			validate_extent_map(fs_info, em);
@@ -378,7 +374,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
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


