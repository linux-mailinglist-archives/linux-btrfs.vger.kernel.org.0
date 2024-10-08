Return-Path: <linux-btrfs+bounces-8655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF3A9957BA
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 21:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0259289087
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 19:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7736A213EDF;
	Tue,  8 Oct 2024 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="SH5CQefg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVjNvqKX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA7770E2
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416215; cv=none; b=gkeaRocKgnh0XZWpLB/B3ZDkGmCqdlKEkkIocsUnDQgopULJ+oxDjhSzwumg/HfohYJeXfFX0+tsr7oGV0q/Nhxmsv7YZ1iJKH6pmp7AHKEfDuUNvJEo9MWRgUoylMj/jF2UwgMhRU+YRDOEZwyH+KiMC3UFBrA83niMi6Es3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416215; c=relaxed/simple;
	bh=FxpxfRmvg2bFelwPhjVQ2HKFLuHyWU1NMVmiYXskfxA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RnXLoKNxvvDOGoOtL8wApzjJ7ryEl0n8h7sgX9Aeu5PwQYv659emieOwpH14VEJJuypDPX4ovtiTrjk/ImOYW4iZkEJR7BbzdFzMqmc2at7bVvqFtAnswPfbhKM2jmUOcR0XAOmDUoVsLwbE4GZhA0dGOdZ8h5VJ06zyLm+u+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=SH5CQefg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iVjNvqKX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07F1111401C5;
	Tue,  8 Oct 2024 15:36:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 08 Oct 2024 15:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1728416212; x=1728502612; bh=0cseSP+5yTgWRCS9krYh+
	w9EodfUUhE6xgCHyCsLLE4=; b=SH5CQefg89/5xwdK++RdzfmwGj3F7ka50xVZM
	ZA52rDFFMT1AwcHv4eqThOfYs/ySzWkC1B336WMot01l36JGtEQ4UlY8vcevLarl
	DTtdGJevS34ULXA5aemid/PB//htlh5psjJH7jrdkSXBYeYSdULmdj56D7IcYJ4h
	xhiNUINYvH8AGns1kGZy7kU1t9RFawAR2++mLeh3Q99UJYeKqzI27c3DJJRLUOr3
	BXQH9sPaqm8HDFEJQDPLUo0Kgd61qhuWyN4kcAFv43rWh0FZDcjjMeYHRMJ0P5qo
	NvT9hPG7EwED5OFRmwxu3hivAnN31Q4O8GudQMFIhTYVHSung==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728416212; x=1728502612; bh=0cseSP+5yTgWRCS9krYh+w9EodfU
	UhE6xgCHyCsLLE4=; b=iVjNvqKXc+hZG9hcMoZzkG0NdWSqCHnF5+yzJgWAEOIb
	wvhhzqSHwxLSBOJHwikaLqKMWYX1y/lUGveZC01KurEnm4goQkym/sCAWQk6P2T+
	/JicR7Bo9Vpg2Z4MfsIGfFf2ia+ngS3YsaLuc+ZIRfrRMqKdP95Tiw+hPgFG9O30
	DX+n3nqS7Ji1q8NCCm6PkR4H9WFcc50+MAVQNQV04HkwaikxK6HtvhK63FKX505W
	AOJQBebPqnkbO3+RibjDBI8PyN681SJR72w0PamIjughxHfgh8ca2cJexyHUJjjD
	n2b12AV+EH/4J9sYKucdxVCvJ4vk5JFt7liMgZZ4CA==
X-ME-Sender: <xms:04kFZ_ji7CyH0ierlz8RPQtd5B0tTrI-sO2B_-LyilGvJ9t5ojECSg>
    <xme:04kFZ8CPXYmuuM6fg7d4s3bmo7ZJ-zH7ex_zr8dCb6mrro19AK7amgrbey2NJ41C8
    49sugA2IL_Xbu_8OJs>
X-ME-Received: <xmr:04kFZ_EMXYh-BJ0j5s9vVvdr-jpnsHSClFik27OfsLsnokLFvwcERMHxpS4n92QrFCyLrZdzyvG1d9a2g4tF2M-2C5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegs
    ohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnheptdejkefhkedvudelfeevue
    ejjeejhfetffeuvedtfedtkeefueeggeeghfehheffnecuffhomhgrihhnpehgihhthhhu
    sgdrtghomhdprhhunhdrshhhpdhlphgtrdgvvhgvnhhtshenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgs
    pghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugi
    dqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgv
    lhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:04kFZ8R0TtqJFmFRRYiUsCUi685vfl24VUmrzYF9hBt_TdHD4FTuBw>
    <xmx:04kFZ8yTQ0mPniQJpSV0rIgsZchUeYNBeGcvS5semBn3sH0Yo-gRqg>
    <xmx:04kFZy7ShZFpCOiFbeIUg2Gv3vcbDeWdcihrQmUogbqFovfKwalzgw>
    <xmx:04kFZxxj1UnbzfAaX5YpTmeSlTKJFFyuhZUT8HNrhq7-1ov9uYPFbg>
    <xmx:04kFZ3_OyDe6cvhVpFPY-lp8LdTn9jmH95SLUdNliHOkbp3ILk2F-aCY>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 15:36:51 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs: try to search for data csums in commit root
Date: Tue,  8 Oct 2024 12:36:34 -0700
Message-ID: <0a59693a70f542120a0302e9864e7f9b86e1cb4c.1728415983.git.boris@bur.io>
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
Changelog:
v2:
- hold the commit_root_sem for the duration of the entire lookup, not
  just per btrfs_search_slot. Note that we can't naively do the thing
  where we release the lock every loop as that is exactly what we are
  trying to avoid. Theoretically, we could re-grab the lock and fully
  start over if the lock is write contended or something. I suspect the
  rwsem fairness features will let the commit writer get it fast enough
  anyway.

---
 fs/btrfs/bio.h       |  1 +
 fs/btrfs/extent_io.c | 21 +++++++++++++++++++++
 fs/btrfs/file-item.c | 10 ++++++++++
 3 files changed, 32 insertions(+)

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
index 9fbc83c76b94..b1c0a531b26a 100644
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
index 886749b39672..c59f9e84e314 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -401,6 +401,13 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		path->skip_locking = 1;
 	}
 
+	/* See the comment on btrfs_bio_ctrl->commit_root_csum. */
+	if (bbio->commit_root_csum) {
+		path->search_commit_root = 1;
+		path->skip_locking = 1;
+		down_read(&fs_info->commit_root_sem);
+	}
+
 	while (bio_offset < orig_len) {
 		int count;
 		u64 cur_disk_bytenr = orig_disk_bytenr + bio_offset;
@@ -446,6 +453,9 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		bio_offset += count * sectorsize;
 	}
 
+	if (bbio->commit_root_csum)
+		up_read(&fs_info->commit_root_sem);
+
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.46.2


