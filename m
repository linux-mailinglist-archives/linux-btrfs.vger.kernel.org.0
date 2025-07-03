Return-Path: <linux-btrfs+bounces-15228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AC8AF81E4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 22:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E1C1BC7F82
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 20:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5A629B21C;
	Thu,  3 Jul 2025 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="dv7eKUbE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AGCWEEyq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F9829CB59
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751574115; cv=none; b=tinAHl0FKpiGaxrw11+oT6qeXAJcCSbT7rhGwviKo9mIe1Xl65jDNNNs7/rnpYBaelg7HSlVi3DagzWalLFA/cex4ibhqsW1eFSo1pWNzE9ZYgLGASOjMO21zg94afVRFvT2SkJVwaECf/tlqWFt8jdHDw0MemziN27Hr0js3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751574115; c=relaxed/simple;
	bh=T70T2iJgsYqSf200qcBFqkvYdGM9TirThJfy08IvodY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y2zE8IpGslrrmgCG5JpNuDFLjOMQ6DHtX6YACfUeTZTGCq+lObDxanEpQbwRBKgY8PEzEtvb0zA7Zflnb5iTvSTE8iXGMgesnicDOkdSxf+loWTz6QOu0NGPjU1eAtc8w0zLyyrHJCseHu7VoDY0X99cUke9OTxkKCY7D+0sIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=dv7eKUbE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AGCWEEyq; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id B5645EC096B;
	Thu,  3 Jul 2025 16:21:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 03 Jul 2025 16:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1751574111; x=1751660511; bh=zYVsHUB8e8U9LbSdX3UK4
	1kHHDCfyjrUNegIHciZt6I=; b=dv7eKUbEWApa/ClzU507jeyv1Apv2Gk51RbRd
	C+Rs+Ze25CCCvP79be8bqKviBexzYwEwsrFqq3T5ukLcFLxeGRWAe6OFNJEUXtW3
	bNHnGUObQcSzrx2K5zteBuBldFvCqPeLefhtelVDgkN7Hk0prvdH++Zl63Juv/ad
	OvM/FXkrDy+n2xEaLdH6O2tyySHQH97Rs28deXHIdJ8VusgXREorga2Vswk+pNu2
	b+tfgkHf357xVO6nMFxu89T9F7XGmF5afUpuj0GJH0hLSeXJOVJg9XgNptyWzgy/
	4quI7xQReM2Rtc7Z7xYbnB+aOzT9h9YvnhTZr4QImto5xM15w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751574111; x=1751660511; bh=zYVsHUB8e8U9LbSdX3UK41kHHDCfyjrUNeg
	IHciZt6I=; b=AGCWEEyq+VLA+PjyKpMBO317a72MA2BE9uRAdOVYjEp7N5ACFyS
	tmj5cfB093jDApjY4RX6pZf7NQ66v4v1OygiSS7RjUF0vWYnyWyJvrNNY9FFdsba
	ZplxEtfqUw6KERSSzIh+W4Pa8JLB4gRGOztrZd/vM61tupbm6uqxhnepNawfu/JD
	vRNgB69MH+kAulzPJ5baCK+SywCy8z/1bZqVi+K1+Pzfsf3xHE7vNDzDxjIbcWJx
	4qYqTO0LqdDDrwaMVzPEBjAlh5SHV+URfdCcgqRRRd9ObzpigJ+vhMgGzs7tRIe2
	pvUeakVzsbzDXEDlGv8ylniKk/gL+FAL1ZA==
X-ME-Sender: <xms:X-ZmaIp816KT-VcLFfWChZrbtHkFNZbb-ZFLO3ZyIpsU_lAlxUoTJg>
    <xme:X-ZmaOoe0rLUntD2OcoxOGh3chSUZELvbTkhl5d3gcEgXdbrgrkQa6tCct_csHXhD
    807vNuma0c84esdCVw>
X-ME-Received: <xmr:X-ZmaNO9VU4PBzGLJYi7J0aMzEy8KttPCThVmjcX_3bAVMdZn-SFKvWbuhlGQWyJsMqIB8LsAsGpX6-nWSVytst3mAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvuddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecu
    ggftrfgrthhtvghrnhepkeejhfeugfeglefftdegueevteduudffffeiieffgfetgfeigf
    elveduveeggfdtnecuffhomhgrihhnpehlphgtrdgvvhgvnhhtshdpsghipghithgvrhdr
    sghinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    horhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:X-ZmaP7QdKA-F2G0t7SUyz5STZ4P-Dw6Bo9EMRLFJxO5aEnFaHzntA>
    <xmx:X-ZmaH707G94gywanvIBu6Cz0VKKJD0NawpS0x0q2gQ8XBdPUusjrw>
    <xmx:X-ZmaPjpm7RsSg-SVcqLRGqPS74umWPsapCxrrBrKCp0Ym3_2r8o5w>
    <xmx:X-ZmaB4A1S1byTGn_ejfwNqyNnQjYPqeZBcfbn6XZD3WV-gIZJC7yQ>
    <xmx:X-ZmaDNvlj8K-khAB3j-hJu6zgZ6IJk4nXYTrL5sE-Rtt2RFWkzDc3kZ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 16:21:51 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v6] btrfs: try to search for data csums in commit root
Date: Thu,  3 Jul 2025 13:23:24 -0700
Message-ID: <8142f4eb91ae32eed53c5ae7121296b44b52d627.1751574142.git.boris@bur.io>
X-Mailer: git-send-email 2.49.0
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

then what quickly occurs is:
- a high degree of contention on the csum root node eb rwsem
- memory starved cgroup doing tons of reclaim on CPU.
- many reader threads in the memory starved cgroup "holding" the sem
  as readers, but not scheduling promptly. i.e., task __state == 0, but
  not running on a cpu.
- btrfs_commit_transaction stuck trying to acquire the sem as a writer.

This results in arbitrarily long transactions. This then results in
seriously degraded performance for any cgroup using the filesystem (the
victim cgroup in the script).

It isn't an academic problem, as we see this exact problem in production
at Meta with one cgroup over its memory limit ruining btrfs performance
for the whole system, stalling critical system services that depend on
btrfs syncs.

The underlying scheduling "problem" with global rwsems is sort of thorny
and apparently well known and was discussed at LPC 2024, for example.

As a result, our main lever in the short term is just trying to reduce
contention on our various rwsems. In the case of the csum tree, we can
either redesign btree locking (hard...) or try to use the commit root
when we can. Luckily, it seems likely that many reads are for old extents
written many transactions ago, and that for those we *can* in fact
search the commit root!

This change detects when we are trying to read an old extent (according
to extent map generation) and then wires that through bio_ctrl to the
btrfs_bio, which unfortunately isn't allocated yet when we have this
information. Luckily, we don't need this flag in the bio after
submitting, so we can save space by setting it on bbio->bio.bi_flags
and clear before submitting, so the block layer is unaffected.

When we go to lookup the csums in lookup_bio_sums we can check this
condition on the btrfs_bio and do the commit root lookup accordingly.

Note that a single bio_ctrl might collect a few extent_maps into a single
bio, so it is important to track a maximum generation across all the
extent_maps used for each bio to make an accurate decision on whether it
is valid to look in the commit root. If any extent_map is updated in the
current generation, we can't use the commit root.

To test and reproduce this issue, I wrote a script that does the
following:
- creates 512 20MiB files (10GiB) each in it's own subvolume (important
  to avoid any contention on the fs-tree root lock)
- spawns 512 processes that loop using dd to read 1GiB at a random GiB
  aligned offset of each file. These "villains" run in a cgroup with
  memory.high set to 1GiB. Obviously this will generate a lot of memory
  pressure on this cgroup.
- spawns 32 processes that loop creating new small files, to trigger a
  decent amount of csum writes to create the csum root lock contention.
  These run in a cgroup restricted to just one cpu with cpuset, but no
  memory restriction. This cpu overlaps with the cpus available to the
  bad neighbor villain cgroup.
- attempts to sync every 10 seconds
- after 60s, it waits for the final sync and kills all the processes via
  their cg cgroup.kill file.

Without this patch, that reproducer:
hung indefinitely, I killed manually via the cgroup.kill file. At this
time, it had racked up 200s and counting in a btrfs commit critical
section and had 200+ threads stuck in D state on the csum reader lock:

elapsed: 914
commits 3
cur_commit_ms 0
last_commit_ms 233784
max_commit_ms 233784
total_commit_ms 235056
214 hits state D, R comms dd
                 btrfs_tree_read_lock_nested
                 btrfs_read_lock_root_node
                 btrfs_search_slot
                 btrfs_lookup_csum
                 btrfs_lookup_bio_sums
                 btrfs_submit_bbio

With the patch, the reproducer exits naturally, in 75s, completing a
pretty decent 5 commits, depsite heavy memory pressure:

elapsed: 76
commits 5
cur_commit_ms 0
last_commit_ms 1801
max_commit_ms 3901
total_commit_ms 8727
pressure
some avg10=99.49 avg60=69.22 avg300=21.64 total=72068757
full avg10=44.81 avg60=24.18 avg300=6.97 total=23015022

some random rwalker samples showed the most common stack in reclaim,
rather than the csum tree:
145 hits state R comms bash, sleep, dd, shuf
                 shrink_folio_list
                 shrink_lruvec
                 shrink_node
                 do_try_to_free_pages
                 try_to_free_mem_cgroup_pages
                 reclaim_high

Link: https://lpc.events/event/18/contributions/1883/
Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v6:
- properly handle bio_ctrl submitting a bbio spanning multiple
  extent_maps with different generations. This was causing csum errors
  on the previous versions.
v5:
- static inline flag functions
- make bbio const for the getter
- move around and improve the comments
v4:
- replace generic private flag machinery with specific function for the
  one flag
- move the bio_ctrl field to take advantage of alignment
v3:
- add some simple machinery for setting/getting/clearing btrfs private
  flags in bi_flags
- clear those flags before bio_submit (ensure no-op wrt block layer)
- store the csum commit root flag there to save space
v2:
- hold the commit_root_sem for the duration of the entire lookup, not
  just per btrfs_search_slot. Note that we can't naively do the thing
  where we release the lock every loop as that is exactly what we are
  trying to avoid. Theoretically, we could re-grab the lock and fully
  start over if the lock is write contended or something. I suspect the
  rwsem fairness features will let the commit writer get it fast enough
  anyway.

---
 fs/btrfs/bio.c         | 10 ++++++++++
 fs/btrfs/bio.h         | 17 +++++++++++++++++
 fs/btrfs/compression.c |  2 ++
 fs/btrfs/extent_io.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/file-item.c   | 29 +++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 50b5fc1c06d7..789cb3e5ba6d 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -93,6 +93,8 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 		refcount_inc(&orig_bbio->ordered->refs);
 		bbio->ordered = orig_bbio->ordered;
 	}
+	if (btrfs_bio_csum_search_commit_root(orig_bbio))
+		btrfs_bio_set_csum_search_commit_root(bbio);
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
 }
@@ -479,6 +481,14 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
 			     struct btrfs_io_stripe *smap, int mirror_num)
 {
+	/*
+	 * It is important to clear the bits we used in bio->bi_flags.
+	 * Because bio->bi_flags belongs to the block layer, we should
+	 * avoid leaving stray bits set when we transfer ownership of
+	 * the bio by submitting it.
+	 */
+	btrfs_bio_clear_csum_search_commit_root(btrfs_bio(bio));
+
 	if (!bioc) {
 		/* Single mirror read/write fast path. */
 		btrfs_bio(bio)->mirror_num = mirror_num;
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index dc2eb43b7097..9f4bcbe0a76c 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -104,6 +104,23 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 				  btrfs_bio_end_io_t end_io, void *private);
 void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
 
+#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT	(1U << (BIO_FLAG_LAST + 1))
+
+static inline void btrfs_bio_set_csum_search_commit_root(struct btrfs_bio *bbio)
+{
+	bbio->bio.bi_flags |= BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
+}
+
+static inline void btrfs_bio_clear_csum_search_commit_root(struct btrfs_bio *bbio)
+{
+	bbio->bio.bi_flags &= ~BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
+}
+
+static inline bool btrfs_bio_csum_search_commit_root(const struct btrfs_bio *bbio)
+{
+	return bbio->bio.bi_flags & BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
+}
+
 /* Submit using blkcg_punt_bio_submit. */
 #define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index d09d622016ef..cadf5eccc640 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -602,6 +602,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	cb->compressed_len = compressed_len;
 	cb->compress_type = btrfs_extent_map_compression(em);
 	cb->orig_bbio = bbio;
+	if (btrfs_bio_csum_search_commit_root(bbio))
+		btrfs_bio_set_csum_search_commit_root(&cb->bbio);
 
 	btrfs_free_extent_map(em);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7ad4f10bb55a..7a19c257fd4a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -101,6 +101,16 @@ struct btrfs_bio_ctrl {
 	enum btrfs_compression_type compress_type;
 	u32 len_to_oe_boundary;
 	blk_opf_t opf;
+	/*
+	 * For data read bios, we attempt to optimize csum lookups if the extent
+	 * generation is older than the current one. To make this possible, we
+	 * need to track the maximum generation of an extent in a bio_ctrl to
+	 * make the decision when submitting the bio.
+	 *
+	 * See the comment in btrfs_lookup_bio_sums for more detail on the
+	 * need for this optimization.
+	 */
+	u64 generation;
 	btrfs_bio_end_io_t end_io_func;
 	struct writeback_control *wbc;
 
@@ -113,6 +123,30 @@ struct btrfs_bio_ctrl {
 	struct readahead_control *ractl;
 };
 
+/*
+ * Helper to set the csum search commit root option for a bio_ctrl's bbio
+ * before submitting the bio.
+ *
+ * Only for use by submit_one_bio().
+ */
+static void bio_set_csum_search_commit_root(struct btrfs_bio_ctrl *bio_ctrl)
+{
+	struct btrfs_bio *bbio = bio_ctrl->bbio;
+	struct btrfs_fs_info *fs_info;
+
+	ASSERT(bbio);
+	fs_info = bbio->inode->root->fs_info;
+
+	if (!(btrfs_op(&bbio->bio) == BTRFS_MAP_READ && is_data_inode(bbio->inode)))
+		return;
+
+	if (bio_ctrl->generation &&
+	    bio_ctrl->generation < btrfs_get_fs_generation(fs_info))
+		btrfs_bio_set_csum_search_commit_root(bio_ctrl->bbio);
+	else
+		btrfs_bio_clear_csum_search_commit_root(bio_ctrl->bbio);
+}
+
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_bio *bbio = bio_ctrl->bbio;
@@ -123,6 +157,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bbio->bio.bi_iter.bi_size);
 
+	bio_set_csum_search_commit_root(bio_ctrl);
+
 	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
 		btrfs_submit_compressed_read(bbio);
@@ -131,6 +167,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	/* The bbio is owned by the end_io handler now */
 	bio_ctrl->bbio = NULL;
+	/* Reset the generation for the next bio */
+	bio_ctrl->generation = 0;
 }
 
 /*
@@ -1026,6 +1064,8 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		if (prev_em_start)
 			*prev_em_start = em->start;
 
+		bio_ctrl->generation = max(bio_ctrl->generation, em->generation);
+
 		btrfs_free_extent_map(em);
 		em = NULL;
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index c09fbc257634..3d2403941d97 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -397,6 +397,33 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		path->skip_locking = 1;
 	}
 
+	/*
+	 * If we are searching for a csum of an extent from a past
+	 * transaction, we can search in the commit root and reduce
+	 * lock contention on the csum tree root node's extent buffer.
+	 *
+	 * This is important because that lock is an rwswem which gets
+	 * pretty heavy write load, unlike the commit_root_csum.
+	 *
+	 * Due to how rwsem is implemented, there is a possible
+	 * priority inversion where the readers holding the lock don't
+	 * get scheduled (say they're in a cgroup stuck in heavy reclaim)
+	 * which then blocks writers, including transaction commit. By
+	 * using a semaphore with fewer writers (only a commit switching
+	 * the roots), we make this issue less likely.
+	 *
+	 * Note that we don't rely on btrfs_search_slot to lock the
+	 * commit root csum. We call search_slot multiple times, which would
+	 * create a potential race where a commit comes in between searches
+	 * while we are not holding the commit_root_csum, and we get csums
+	 * from across transactions.
+	 */
+	if (btrfs_bio_csum_search_commit_root(bbio)) {
+		path->search_commit_root = 1;
+		path->skip_locking = 1;
+		down_read(&fs_info->commit_root_sem);
+	}
+
 	while (bio_offset < orig_len) {
 		int count;
 		u64 cur_disk_bytenr = orig_disk_bytenr + bio_offset;
@@ -442,6 +469,8 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		bio_offset += count * sectorsize;
 	}
 
+	if (btrfs_bio_csum_search_commit_root(bbio))
+		up_read(&fs_info->commit_root_sem);
 	return ret;
 }
 
-- 
2.49.0


