Return-Path: <linux-btrfs+bounces-8921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D708799D9F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 01:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0538A282D46
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 23:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A521D6DA1;
	Mon, 14 Oct 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YOXoFwqR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pHwjt7Aj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEF8137776
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728947343; cv=none; b=usTQuCEpUUOpXn4s8Mbb+LVslYptbGh/2LIzRBv1NAOlSBG0ZXqofMhenCYT8HDLUy++/3B7XmoesdeNVfp3S2y4qQi9KjYroCt4eA3ZtKRah0/wNHvFNf/1EzrjjeNIk2lHydY3j+0P927X4WA31Wgq/G05YAhb7VLv71+MU88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728947343; c=relaxed/simple;
	bh=RK2q5mQiJ7jT07j6LSPJu+MrXm4Y9ITccjufc/evGTw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L6Y9koLmb8rDG+yHMKf3pVja3HMKkqGgPBoRb77C5bJSNgZboCE2sKEx8w1YgrEgbSQmA97s1bEDdK53rrHEEga5Uik5eDXKuM1pL9M/x+DmX6PuWNcUSE5xRJaf3GMf1q+rWRcWcLN86tb0m0gS1c3VMDPKs0NUNzFqFm9isQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YOXoFwqR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pHwjt7Aj; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9907114014F;
	Mon, 14 Oct 2024 19:08:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 14 Oct 2024 19:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1728947338; x=1729033738; bh=cYMY8+8ZPzP4mN/TVreE6
	l7eEBSe/NPTeLme30Re3hQ=; b=YOXoFwqRL43JU/Lm/769qy6baeVOmWvXgRvg1
	KprPgY504OhZJRZ14tkmAORpTdYCO1q+8GUpEp/sXnqQgLpuNo/tZ6oAuYJLD9De
	Yhbik5B2uOSbyf0v51DeX6dvBZPHYjHaUqv8GfUtOwfX6hycv7Thipqj/7P47m1t
	yiVqav7HF01klPXJJ4ZNu8PI+TlU+NY9kENRfE9vjCpjgfMMBtN4h4YzTLQedNPa
	VnF4A1Mupea96m7uLVFKtxpLD6eBrjyE+hzCCULcwhUMfKmQdQQMAy/Rm7dpo4w3
	dWEfsbfosYEb8xDagGLb+tnFypsLoR6EO0NId+GYWaCiwMVaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728947338; x=1729033738; bh=cYMY8+8ZPzP4mN/TVreE6l7eEBSe
	/NPTeLme30Re3hQ=; b=pHwjt7AjHKrMllVEQTCpH3EsE4LFWBNgBCF46ZiQ7rv1
	SJJ/HFmoSs/5Wvdkj1Trvg+DkX2w1Ex4ys1r6LMLwwq6MjgGd3yaXAi5WZR/tvnc
	ng3wpvyYtb6DXlOaSFD2rX3U5FZqoadBY6moA/+G9ESI/WgJc9JKYyy7Cuxym76H
	/ilgTOG/skAVZaReFECtjz8jXbshuz0KOEFZbKT6xRKqjScHT1kErUHMavKZAZLz
	fBN3hvfdgSiJZqXacGmpnDkPRO6s9SI5Bk5rlgY2PcQVbl2DCPCOfstAHvoTysGN
	Z9Q3WCZC2OCe7lkQaL0qGeeEVaaFGa02yTU6EVf01Q==
X-ME-Sender: <xms:iqQNZ22wujes8LWhTeDWOidhoSZf-JbJmkeu4I6re3RmFXEoqvkt0g>
    <xme:iqQNZ5EoceeJYykZPmp6T_KjiZKr1vn8cHozcAfL_FhWDaNA5Z8YoE0wL59I0xYBS
    vywBlMj_k-VwAAw0-0>
X-ME-Received: <xmr:iqQNZ-7jrFB4BVKvSD4RYF0fY6doXgX0cQ-7Hpr4QnKZ3jVKSEEj7231U3BNGSbaxt843qkMSoUYcK3QYepMEX5QOpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegiedgudelucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:iqQNZ31MsHZzlRNp7TwpWKon3n9hUBTs7IucvA6v-fHf51a2f2GcNQ>
    <xmx:iqQNZ5GjSBP8UhQ1xoCEv-RFiVk8EarzSMI6HlJ_d-pyq4ZHPTi14w>
    <xmx:iqQNZw-HdIEVcX-Kx6ZYcXYZG2PJrUik-isdOhEELGt_VUATbN0dEQ>
    <xmx:iqQNZ-mMZsa1kNFwAL6KmM8mnDmHgX92WxKv0yOJ0uUSpE9kXC56gw>
    <xmx:iqQNZ-QxtAlOktCZJiE9K8-u_fcE0DyEJp1O51nqFjlpvihmkQZRZ3MW>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 19:08:58 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3] btrfs: try to search for data csums in commit root
Date: Mon, 14 Oct 2024 16:08:31 -0700
Message-ID: <01721e6680b4a05c06cea8afc98b1726102ba5f5.1728947030.git.boris@bur.io>
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
 fs/btrfs/bio.c       | 20 ++++++++++++++++++++
 fs/btrfs/bio.h       |  7 +++++++
 fs/btrfs/extent_io.c | 21 +++++++++++++++++++++
 fs/btrfs/file-item.c | 10 ++++++++++
 4 files changed, 58 insertions(+)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 5d3f8bd406d9..24c159ef3854 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -71,6 +71,25 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 	return bbio;
 }
 
+void btrfs_bio_set_private_flag(struct btrfs_bio *bbio, unsigned short flag) {
+	ASSERT(flag & BTRFS_BIO_PRIVATE_FLAG_MASK);
+	bbio->bio.bi_flags |= flag;
+}
+
+void btrfs_bio_clear_private_flag(struct btrfs_bio *bbio, unsigned short flag) {
+	ASSERT(flag & BTRFS_BIO_PRIVATE_FLAG_MASK);
+	bbio->bio.bi_flags &= ~flag;
+}
+
+void btrfs_bio_clear_private_flags(struct btrfs_bio *bbio) {
+	bbio->bio.bi_flags &= ~BTRFS_BIO_PRIVATE_FLAG_MASK;
+}
+
+bool btrfs_bio_private_flagged(struct btrfs_bio *bbio, unsigned short flag) {
+	ASSERT(flag & BTRFS_BIO_PRIVATE_FLAG_MASK);
+	return bbio->bio.bi_flags & flag;
+}
+
 static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 					 struct btrfs_bio *orig_bbio,
 					 u64 map_length)
@@ -493,6 +512,7 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
 			     struct btrfs_io_stripe *smap, int mirror_num)
 {
+	btrfs_bio_clear_private_flags(btrfs_bio(bio));
 	if (!bioc) {
 		/* Single mirror read/write fast path. */
 		btrfs_bio(bio)->mirror_num = mirror_num;
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index e48612340745..749004ffdc1c 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -101,6 +101,13 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 				  btrfs_bio_end_io_t end_io, void *private);
 void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
 
+#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT	1U << (BIO_FLAG_LAST + 1)
+#define BTRFS_BIO_PRIVATE_FLAG_MASK	(BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT)
+void btrfs_bio_set_private_flag(struct btrfs_bio *bbio, unsigned short flag);
+void btrfs_bio_clear_private_flag(struct btrfs_bio *bbio, unsigned short flag);
+void btrfs_bio_clear_private_flags(struct btrfs_bio *bbio);
+bool btrfs_bio_private_flagged(struct btrfs_bio *bbio, unsigned short flag);
+
 /* Submit using blkcg_punt_bio_submit. */
 #define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 09c0d18a7b5a..b1b5dce05728 100644
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
+		if (btrfs_op(&bio_ctrl->bbio->bio) == BTRFS_MAP_READ &&
+		    is_data_inode(inode) && bio_ctrl->commit_root_csum)
+			btrfs_bio_set_private_flag(bio_ctrl->bbio, BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT);
 
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
index 886749b39672..52db43bdd623 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -401,6 +401,13 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		path->skip_locking = 1;
 	}
 
+	/* See the comment on btrfs_bio_ctrl->commit_root_csum. */
+	if (btrfs_bio_private_flagged(bbio, BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT)) {
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
 
+	if (btrfs_bio_private_flagged(bbio, BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT))
+		up_read(&fs_info->commit_root_sem);
+
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.46.2


