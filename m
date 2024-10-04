Return-Path: <linux-btrfs+bounces-8567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3B59912F4
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2024 01:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881221C22982
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 23:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A9D1514F8;
	Fri,  4 Oct 2024 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="g+268hv4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NPCfezmE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0514B061
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084199; cv=none; b=qKPgXqlaf7nPUy3OJnFagXxA7m7ngqwFxQNlX4WxCMYw08YI49ljb3olaw/scA/2+QhZxjm6EUOe5ecAPgdDQZkfKBa5eeLPGOYZ/t3xydP9t7pK/4nRIqAhISLajcuHZ/FeyJTsuN+pk1CTKJdeXwk5R/YSolzm6SPmbWHsJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084199; c=relaxed/simple;
	bh=uQUAoSop/bMNP2gBcV0HJbwkIepIY6tOaP+pf8iFHrI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=J0OT+XVARwQ+Aur+n0jrVYQ4VEa3CfWOGC+va1new1VUVgMrJ51lxlIQizLilpEsMEo3qkO8CMB3PzMAFg2Ier/9k7cJNb+Va+MO6xMSFQ99eBn57YPe5EEu0DppFmyCq1OpDGqWhKxMXNxxiC09G1Dpz2xosD/PQ5Czq4Sp07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=g+268hv4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NPCfezmE; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 00D661140179;
	Fri,  4 Oct 2024 19:23:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 04 Oct 2024 19:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1728084195; x=1728170595; bh=rfvgSJcrr8sO97cg2pk/f
	fP1AeCOXvjpbe3X/U59qGM=; b=g+268hv4RFD8c4Sbf6uNxmhjX/yYg9ls0RlQi
	8fBSyYqPGAP6Id3DK0fX8lBgqrawjO2mf5mvV/5265gU4ZfbJCaaDLZcze8cjcUZ
	QYSo98MoE6MnJFrPsLStBkuBr3GaCDvtWqiwbyof5/SukB/dVfA2gb78/qkO8Ugf
	YmbK6nA9D07vcBElo484kMhLZjFiCOSAHcmfgRddWLT7Ppa0lUYvpWeoG8RDp+Qo
	czpDT1QEwiW8O8/jdG5px1fRITAS1vp8tHd+AxbxNDoyAgVBNplb/gDwdU7ufRxY
	iiDoT7yxZ6zlY3o76rlfn7qb4gT9vGyPu79gkKbbEs4NHdITg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728084195; x=1728170595; bh=rfvgSJcrr8sO97cg2pk/ffP1AeCO
	Xvjpbe3X/U59qGM=; b=NPCfezmELOrzQLaxvp2v4zZUnGbQruU2o5tPYQdwJJTL
	CEG+JaPBPE5IFBjrPQTJnFyzNF4uYVwKm2QU14l3BTRh68a07SQEux4NmTiSoPM/
	+aaYiGK/zEga16HJ64EkwuH0xrzCeGHmnxdYJMH3v1bMkYpyvztl5fkYVfIKuflc
	OAeiwC9Y4iO0d8Jvzyksf91UAspfR3lgqLOm5+O7y+UdgQgqLbCoWMNFQExqZ4+b
	x713pf19JoWIWihx2bgCf+GarLrfTPkVdXpVG6KnSslP4UHjBhqwSuUOUW0zxaSm
	d2Ko4rTUZkJp+rRaKBUdFdI9Qg82woddjHd8W3ne6g==
X-ME-Sender: <xms:43gAZ9nX-0lvyl_Eqxf8qeAwcElVTA2xWifdaGXm29eFMFZ47KHiYw>
    <xme:43gAZ435KTYlYQC0TjFB4DYWA0TcWlla9sEeEv0Di9PnOwq-v-VeWd2IdTXe4bpsE
    spdMLmmdIgcgGxqbu4>
X-ME-Received: <xmr:43gAZzpHcBEFgtQskBz0NZHx2SKoag2B9rqHW7RwYyFBhfRGtD-bIl4Pw4ufdZZSX7JDKEYMtFOchE0XO-ZVupXFlU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosgho
    rhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpedtjeekhfekvdduleefveeuje
    ejjefhteffueevtdeftdekfeeugeeggefhheehffenucffohhmrghinhepghhithhhuhgs
    rdgtohhmpdhruhhnrdhshhdplhhptgdrvghvvghnthhsnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggp
    rhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghl
    qdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:43gAZ9nbJ4ctMYqy7ir38UdDTxUTSM07ZE7qno1lNY3OPwxVsKcxoQ>
    <xmx:43gAZ71VzXFKrtew_AgFPnDzPPvDefMLJJLg4ugnUPVJJC2qH_NKLA>
    <xmx:43gAZ8vrl2A59DRtMhSGujQXMSX2K9uTZPrljLDQinsxoFGBU3uobw>
    <xmx:43gAZ_VYSXoKOZTqHk2cC-w6u9upRRWBjnNSR3faFh0phlY7m3DLBg>
    <xmx:43gAZ5B91LcJ1s9Txpk1NakuG7Z_ymKxLpSAv82GA_YivVVuzC5OnoY2>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 19:23:15 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: try to search for data csums in commit root
Date: Fri,  4 Oct 2024 16:23:05 -0700
Message-ID: <9d12c373a49184e84897ff2d6df601f2c7c66a32.1728084164.git.boris@bur.io>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If you run a workload like:
- a cgroup that does tons of data reading, with a harsh memory limit
- a second cgroup that tries to write new files
e.g.:
https://github.com/boryas/scripts/blob/main/sh/noisy-neighbor/run.sh

then what quickly occurs is:
- a high degree of contention on the csum root node eb rwsem
- memory starved cgroup doing tons of reclaim on CPU.
- many reader threads in the memory starved cgroup "holding" the sem
  as readers, but not scheduling promptly. i.e., task __state == 0, but
  not running on a cpu.
- btrfs_commit_transaction stuck trying to acquire the sem as a writer.

This results in VERY long transactions. On my test system, that script
produces 20-30s long transaction commits. This then results in
seriously degraded performance for any cgroup using the filesystem (the
victim cgroup in the script).

This reproducer is a bit silly, as the villanous cgroup is using almost
all of its memory.max for kernel memory (specifically pagetables) but it
sort of doesn't matter, as I am most interested in the btrfs locking
behavior. It isn't an academic problem, as we see this exact problem in
production at Meta with one cgroup over memory.max ruining btrfs
performance for the whole system.

The underlying scheduling "problem" with global rwsems is sort of thorny
and apparently well known. e.g.
https://lpc.events/event/18/contributions/1883/

As a result, our main lever in the short term is just trying to reduce
contention on our various rwsems. In the case of the csum tree, we can
either redesign btree locking (hard...) or try to use the commit root
when we can. Luckily, it seems likely that many reads are for old extents
written many transactions ago, and that for those we *can* in fact
search the commit root!

This change detects when we are trying to read an old extent (according
to extent map generation) and then wires that through bio_ctrl to the
btrfs_bio, which unfortunately isn't allocated yet when we have this
information. When we go to lookup the csums in lookup_bio_sums we can
check this condition on the btrfs_bio and do the commit root lookup
accordingly.

With the fix, on that same test case, commit latencies no longer exceed
~400ms on my system.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/bio.h       |  1 +
 fs/btrfs/extent_io.c | 21 +++++++++++++++++++++
 fs/btrfs/file-item.c |  7 +++++++
 3 files changed, 29 insertions(+)

diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index e48612340745..159f6a4425a6 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -48,6 +48,7 @@ struct btrfs_bio {
 			u8 *csum;
 			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
 			struct bvec_iter saved_iter;
+			bool commit_root_csum;
 		};
 
 		/*
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cb0a39370d30..8544fe2302ff 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -108,6 +108,21 @@ struct btrfs_bio_ctrl {
 	 * This is to avoid touching ranges covered by compression/inline.
 	 */
 	unsigned long submit_bitmap;
+	/*
+	 * If this is a data read bio, we set this to true if it is safe to
+	 * search for csums in the commit root. Otherwise, it is set to false.
+	 *
+	 * This is an optimization to reduce the contention on the csum tree
+	 * root rwsem. Due to how rwsem is implemented, there is a possible
+	 * priority inversion where the readers holding the lock don't get
+	 * scheduled (say they're in a cgroup stuck in heavy reclaim) which
+	 * then blocks btrfs transactions. The only real help is to try to
+	 * reduce the contention on the lock as much as we can.
+	 *
+	 * Do this by detecting when a data read is reading data from an old
+	 * transaction so it's safe to look in the commit root.
+	 */
+	bool commit_root_csum;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
@@ -770,6 +785,9 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
 			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
 				      folio_pos(folio) + pg_offset);
 		}
+		if (btrfs_op(&bio_ctrl->bbio->bio) == BTRFS_MAP_READ && is_data_inode(inode))
+			bio_ctrl->bbio->commit_root_csum = bio_ctrl->commit_root_csum;
+
 
 		/* Cap to the current ordered extent boundary if there is one. */
 		if (len > bio_ctrl->len_to_oe_boundary) {
@@ -1048,6 +1066,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		if (prev_em_start)
 			*prev_em_start = em->start;
 
+		if (em->generation < btrfs_get_fs_generation(fs_info))
+			bio_ctrl->commit_root_csum = true;
+
 		free_extent_map(em);
 		em = NULL;
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 886749b39672..2433b169a4e6 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -401,6 +401,13 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		path->skip_locking = 1;
 	}
 
+	/* See the comment on btrfs_bio_ctrl->commit_root_csum. */
+	if (bbio->commit_root_csum) {
+		path->search_commit_root = 1;
+		path->skip_locking = 1;
+		path->need_commit_sem = 1;
+	}
+
 	while (bio_offset < orig_len) {
 		int count;
 		u64 cur_disk_bytenr = orig_disk_bytenr + bio_offset;
-- 
2.46.2


