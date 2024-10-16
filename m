Return-Path: <linux-btrfs+bounces-8977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C9B9A12E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 21:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956B41C22264
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 19:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96467212F1B;
	Wed, 16 Oct 2024 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="iCy4QWtU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gcuwwvvr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8E125B9
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108012; cv=none; b=tRVE1hFRLqnNf0fQQUPxZldbDb6Hp0p5Mt1XPwe7yV7P+NScfmoSiOiJOwc6MG2h4DiRPO6b7iREwlXnSUVeMYk5rpJ9GObt2Y/8Vkgwu0sujCAofm8r5z+Uk5dh78vCYgNwA+RHvPpDfQeCF2XT2L5AVOsXd2xnwy883dusOOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108012; c=relaxed/simple;
	bh=y9Kuupe+sneJjTU/yl0Vk8XOOIACPG4Wo1Xh6bJnyqQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hfonvLlcs7ITvOwBScnWE0vlzgT/NXEASIuFCivcmWumwFB0yqOZ/o6KWwXw8tlrnQk/MModgJeKwx2+NxPdwFYG1mf/zrK8Qe0n7GJxTlE3qlhqsCGMtAhf4/JyejAi9SAqPc0eDr+uBWRycpqAC6PFuFK5bpnOZOQOd/R54RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=iCy4QWtU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gcuwwvvr; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1EC2711401DD;
	Wed, 16 Oct 2024 15:46:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 16 Oct 2024 15:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1729108009; x=1729194409; bh=/0jkweHZw0oMs0fYxwW5q
	OeXWx2kOkrhLuczAMf+EhI=; b=iCy4QWtUnY8m4uWcfbLNkqJKyOuYIUx4Q9fZ/
	DH9EWf3W2WqJnEEDQTRKJ1AH30L49ySUEDo2BsNMsrSRIb8+Tss0/8RKHIwgoh2u
	AWPO8xaU+V+MTGN9ZYMgwXCboyF6AwGbsAiNjRC9w0u6LZKMexjO8yb22WDLbvOx
	VG9DeP9qHHr1Wa7+4ELPnhkxvnoZvkMj8/MBPXxXokQhO8rdCGKPckX5andul4ak
	FI10pHq4DRtOHAx3ksNanEjrFF4pM7aPs7XIzp5jo2YRPbyPSC0wy6GJfpvIhL96
	Me+BhjqTanTWdvUgv72h+0p52ykBYvKaqAlBBh+1hXT7sMRrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729108009; x=1729194409; bh=/0jkweHZw0oMs0fYxwW5qOeXWx2k
	OkrhLuczAMf+EhI=; b=gcuwwvvr1CjFff92wPbIXOxPJxIwrxVz0hJCjF5wO4/w
	zVVe+oOAnDjk9NT+1kbsdJgELhLV/OHhjPh9yUT2ZkH1ck1oZJPu5ySk2EsfufvX
	dmrUO8gjluf5a2fHaU8fm3jej997TtRCGTlpT/lNXoL1sEvs+x8WdS8ovmeFUJQE
	vqshCed+ifM8F8er4H41h8TD3SOQG+Vbo3G7ZRBerm7WGrQIXEA7vQ7N0l9/XJpV
	ri1ij7Iur5yArZhozqk7rmWo8cBkGskWQMvUd7rQlFdejVORPOsVfmU67ZtUclA+
	iZZBDX8IIN2u3XaHHqHkA4GS8oHTaum+DGS4d32s1g==
X-ME-Sender: <xms:KBgQZ2b5URxmBPUT86BOUKK9V-6CyWFAK9FUGqxFKKc7xODsHhj_Tw>
    <xme:KBgQZ5bw9lodZO2KyY8WYfZUKEGcdMsJWSFxL89GlBEvQnQappnSl44VILC3aeStZ
    mnbMKsXG6vFItJGCAY>
X-ME-Received: <xmr:KBgQZw-M82ydct6-Y_Kg_aCLSPd9cA0kE_KkWk1ewq_DLSgYAatDMjN70Q7VWoejPwBwWLr8vv3pQZc_BZ_LzISMeFk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgudegvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:KBgQZ4qIP5gFbjEO94Wj2Ih80NZ8A8TgGmUVHTLYEF7ORXSuxr189g>
    <xmx:KBgQZxrjNK-2AvrMDPZzyf9RRlaSYm3SDt5TYna4vBk5BGfGkkXRNg>
    <xmx:KBgQZ2SqbIZkxaXAPdqafJyWP_FY9RwL9VeLdqzjgdDDRsMCURjtWQ>
    <xmx:KBgQZxr2Jxzrchy1rfXjJqj1WDQuzULq-t-clWnNL2-8etdNBMMHdA>
    <xmx:KRgQZ415ayTjUaWrBS19DwDAqGgjOpFcf4TOqzB51EstO3rhT_77DZib>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 15:46:48 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4] btrfs: try to search for data csums in commit root
Date: Wed, 16 Oct 2024 12:46:18 -0700
Message-ID: <00aada8468cfc74d696dd98f9b8c603271905029.1729107891.git.boris@bur.io>
X-Mailer: git-send-email 2.47.0
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
information. Luckily, we don't need this flag in the bio after
submitting, so we can save space by setting it on bbio->bio.bi_flags
and clear before submitting, so the block layer is unaffected.

When we go to lookup the csums in lookup_bio_sums we can check this
condition on the btrfs_bio and do the commit root lookup accordingly.

With the fix, on that same test case, commit latencies no longer exceed
~400ms on my system.

Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
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
 fs/btrfs/bio.c       | 18 ++++++++++++++++++
 fs/btrfs/bio.h       |  5 +++++
 fs/btrfs/extent_io.c | 21 +++++++++++++++++++++
 fs/btrfs/file-item.c | 10 ++++++++++
 4 files changed, 54 insertions(+)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 1f216d07eff6..ca5f8a29acea 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -72,6 +72,21 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 	return bbio;
 }
 
+void btrfs_bio_set_csum_search_commit_root(struct btrfs_bio *bbio)
+{
+	bbio->bio.bi_flags |= BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
+}
+
+void btrfs_bio_clear_csum_search_commit_root(struct btrfs_bio *bbio)
+{
+	bbio->bio.bi_flags &= ~BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
+}
+
+bool btrfs_bio_csum_search_commit_root(struct btrfs_bio *bbio)
+{
+	return bbio->bio.bi_flags & BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
+}
+
 static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 					 struct btrfs_bio *orig_bbio,
 					 u64 map_length)
@@ -482,6 +497,9 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
 			     struct btrfs_io_stripe *smap, int mirror_num)
 {
+	/* Clear the flag we stored in bio->bi_flags before submission. */
+	btrfs_bio_clear_csum_search_commit_root(btrfs_bio(bio));
+
 	if (!bioc) {
 		/* Single mirror read/write fast path. */
 		btrfs_bio(bio)->mirror_num = mirror_num;
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index e2fe16074ad6..5a8159966135 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -104,6 +104,11 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 				  btrfs_bio_end_io_t end_io, void *private);
 void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
 
+#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT	(1U << (BIO_FLAG_LAST + 1))
+void btrfs_bio_set_csum_search_commit_root(struct btrfs_bio *bbio);
+void btrfs_bio_clear_csum_search_commit_root(struct btrfs_bio *bbio);
+bool btrfs_bio_csum_search_commit_root(struct btrfs_bio *bbio);
+
 /* Submit using blkcg_punt_bio_submit. */
 #define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0a0c84eb1c42..aaec9a67e146 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -99,6 +99,21 @@ struct btrfs_bio_ctrl {
 	enum btrfs_compression_type compress_type;
 	u32 len_to_oe_boundary;
 	blk_opf_t opf;
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
+	bool csum_search_commit_root;
 	btrfs_bio_end_io_t end_io_func;
 	struct writeback_control *wbc;
 
@@ -770,6 +785,9 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
 			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
 				      folio_pos(folio) + pg_offset);
 		}
+		if (btrfs_op(&bio_ctrl->bbio->bio) == BTRFS_MAP_READ &&
+		    is_data_inode(inode) && bio_ctrl->csum_search_commit_root)
+			btrfs_bio_set_csum_search_commit_root(bio_ctrl->bbio);
 
 		/* Cap to the current ordered extent boundary if there is one. */
 		if (len > bio_ctrl->len_to_oe_boundary) {
@@ -1048,6 +1066,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		if (prev_em_start)
 			*prev_em_start = em->start;
 
+		if (em->generation < btrfs_get_fs_generation(fs_info))
+			bio_ctrl->csum_search_commit_root = true;
+
 		free_extent_map(em);
 		em = NULL;
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 886749b39672..fac5a83ace84 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -401,6 +401,13 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		path->skip_locking = 1;
 	}
 
+	/* See the comment on btrfs_bio_ctrl->commit_root_csum. */
+	if (btrfs_bio_csum_search_commit_root(bbio)) {
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
 
+	if (btrfs_bio_csum_search_commit_root(bbio))
+		up_read(&fs_info->commit_root_sem);
+
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.47.0


