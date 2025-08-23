Return-Path: <linux-btrfs+bounces-16314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D99B32C8C
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Aug 2025 01:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BA85A16CC
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Aug 2025 23:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A212BEFFF;
	Sat, 23 Aug 2025 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JDQQjUOi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JDQQjUOi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF1192B7D
	for <linux-btrfs@vger.kernel.org>; Sat, 23 Aug 2025 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755991506; cv=none; b=NT8nV8vrz7YaZR8UiIKyX8HWWZBPormoHwB4Wm9z2sradZLtO+ajsB2RrTMiQB8YMrIAvtFe131YPKnK/ffm8emqYzj+u0yR3RGWZQd5j4oNYeh2rb2C2cpNMWrLHlK2OLvh6PvbSsJtvGS9fYRpaMT/4fuoh56HBHf7D3ef5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755991506; c=relaxed/simple;
	bh=bx2+xryFIwa8UiQC6Qllw4IEysuWQ3V9OhTs1m323A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hvdTnEx/QZ3jkx3v6cbWGcyFRGvtGqMXcnym7kJToJOvGtqteOPYajrbdejUUvDe7W9qI/K7zJXFIs9Xc+VuuNRV9lu2QHb5mQDcU6Ebak03WAsjF7EZZz7pI7B4ZrceeILzZMbT6nmnRLjmhc37tK22L+bbhVXqzIFITwr52Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JDQQjUOi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JDQQjUOi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCB7921237;
	Sat, 23 Aug 2025 23:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755991494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Jcr8WqC8jT3y6c5os/CIhDFuO2RxzcSGjy9inX0i7bc=;
	b=JDQQjUOi+9itcbIOnviDqPeA/VYkt1+FrCBToj3GW2zmCBxovPOQfGPr8H22cc0pOJV3wh
	dszdjhIhTifM3e9ncaqR1bNNzJ089+qR0mgkiuk9LpHpC6a0Ju+DT1AmzqBh6S6RqO9kzn
	+ALzl1T9eDbsTEuItJu7aHeynZ+DswA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755991494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Jcr8WqC8jT3y6c5os/CIhDFuO2RxzcSGjy9inX0i7bc=;
	b=JDQQjUOi+9itcbIOnviDqPeA/VYkt1+FrCBToj3GW2zmCBxovPOQfGPr8H22cc0pOJV3wh
	dszdjhIhTifM3e9ncaqR1bNNzJ089+qR0mgkiuk9LpHpC6a0Ju+DT1AmzqBh6S6RqO9kzn
	+ALzl1T9eDbsTEuItJu7aHeynZ+DswA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B709513867;
	Sat, 23 Aug 2025 23:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lgJxHcVNqmjLagAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 23 Aug 2025 23:24:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] btrfs: do more strict compressed read merge check
Date: Sun, 24 Aug 2025 08:54:35 +0930
Message-ID: <fe1f1d9e9f2425fa25a2ff9295b4e194125392f6.1755991465.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[BUG]
When running test case generic/457, there is a chance to hit the
following error, with 64K page size and 4K btrfs block size, and
"compress=zstd" mount option:

FSTYP         -- btrfs
PLATFORM      -- Linux/aarch64 btrfs-aarch64 6.17.0-rc2-custom+ #129 SMP PREEMPT_DYNAMIC Wed Aug 20 18:52:51 ACST 2025
MKFS_OPTIONS  -- -s 4k /dev/mapper/test-scratch1
MOUNT_OPTIONS -- -o compress=zstd /dev/mapper/test-scratch1 /mnt/scratch

generic/457 2s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests-dev/results//generic/457.out.bad)
    --- tests/generic/457.out	2024-04-25 18:13:45.160550980 +0930
    +++ /home/adam/xfstests-dev/results//generic/457.out.bad	2025-08-22 16:09:41.039352391 +0930
    @@ -1,2 +1,3 @@
     QA output created by 457
    -Silence is golden
    +testfile6 end md5sum mismatched
    +(see /home/adam/xfstests-dev/results//generic/457.full for details)
    ...
    (Run 'diff -u /home/adam/xfstests-dev/tests/generic/457.out /home/adam/xfstests-dev/results//generic/457.out.bad'  to see the entire diff)

The root problem is, after certain fsx operations the file contents
change just after a mount cycle.

There is a much smaller reproducer based on that test case, which I
mainly used to debug the bug:

workload() {
	mkfs.btrfs -f $dev > /dev/null
	dmesg -C
	trace-cmd clear
	mount -o compress=zstd $dev $mnt
	xfs_io -f -c "pwrite -S 0xff 0 256K" -c "sync" $mnt/base > /dev/null
	cp --reflink=always -p -f $mnt/base $mnt/file
	$fsx -N 4 -d -k -S 3746842 $mnt/file
	if [ $? -ne 0 ]; then
		echo "!!! FSX FAILURE !!!"
		fail
	fi
	csum_before=$(_md5_checksum $mnt/file)
	stop_trace
	umount $mnt
	mount $dev $mnt
	csum_after=$(_md5_checksum $mnt/file)
	umount $mnt
	if [ "$csum_before" != "$csum_after" ]; then
		echo "!!! CSUM MISMATCH !!!"
		fail
	fi
}

This seed value will cause 100% reproducible csum mismatch after a mount
cycle.

The seed value results only 2 real operations:

  Seed set to 3746842
  main: filesystem does not support fallocate mode FALLOC_FL_UNSHARE_RANGE, disabling!
  main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RANGE, disabling!
  main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, disabling!
  main: filesystem does not support exchange range, disabling!
  main: filesystem does not support dontcache IO, disabling!
  2 clone	from 0x3b000 to 0x3f000, (0x4000 bytes) at 0x1f000
  3 write	0x2975b thru	0x2ba20	(0x22c6 bytes)	dontcache=0
  All 4 operations completed A-OK!

[CAUSE]
With extra debug trace_printk(), the following sequence can explain the
root cause:

  fsx-3900290 [002] ..... 161696.160966: btrfs_submit_compressed_read: r/i=5/258 file_off=131072 em start=126976 len=16384

The "r/i" is showing the root id and the ino number.
In this case, my minimal reproducer is indeed using inode 258 of
subvolume 5, and that's the inode with changing contents.

The above trace is from the function btrfs_submit_compressed_read(),
triggered by fsx to read the folio at file offset 128K.

Notice that the extent map, it's at offset 124K, with a length of 16K.
This means the extent map only covers the first 12K (3 blocks) of the
folio 128K.

  fsx-3900290 [002] ..... 161696.160969: trace_dump_cb: btrfs_submit_compressed_read, r/i=5/258 file off start=131072 len=65536 bi_size=65536

This is the line I used to dump the basic info of a bbio, which shows the
bi_size is 64K, aka covering the whole 64K folio at file offset 128K.

But remember, the extent map only covers 3 blocks, definitely not enough
to cover the whole 64K folio at 128K file offset.

  kworker/u19:1-3748349 [002] ..... 161696.161154: btrfs_decompress_buf2page: r/i=5/258 file_off=131072 copy_len=4096 content=ffff
  kworker/u19:1-3748349 [002] ..... 161696.161155: btrfs_decompress_buf2page: r/i=5/258 file_off=135168 copy_len=4096 content=ffff
  kworker/u19:1-3748349 [002] ..... 161696.161156: btrfs_decompress_buf2page: r/i=5/258 file_off=139264 copy_len=4096 content=ffff
  kworker/u19:1-3748349 [002] ..... 161696.161157: btrfs_decompress_buf2page: r/i=5/258 file_off=143360 copy_len=4096 content=ffff

The above lines show that btrfs_decompress_buf2page() called by zstd
decompress code is copying the decompressed content into the filemap.

But notice that, the last line is already beyond the extent map range.

Furthermore, there are no more compressed content copy, as the
compressed bio only has the extent map to cover the first 3 blocks (the
4th block copy is already incorrect).

   kworker/u19:1-3748349 [002] ..... 161696.161161: trace_dump_cb: r/i=5/258 file_pos=131072 content=ffff
   kworker/u19:1-3748349 [002] ..... 161696.161161: trace_dump_cb: r/i=5/258 file_pos=135168 content=ffff
   kworker/u19:1-3748349 [002] ..... 161696.161162: trace_dump_cb: r/i=5/258 file_pos=139264 content=ffff
   kworker/u19:1-3748349 [002] ..... 161696.161162: trace_dump_cb: r/i=5/258 file_pos=143360 content=ffff
   kworker/u19:1-3748349 [002] ..... 161696.161162: trace_dump_cb: r/i=5/258 file_pos=147456 content=0000

This is the extra dumpping of the compressed bio, after file offset
140K (143360), the content is all zero, which is incorrect.
The zero is there because we didn't copy anything into the folio.

The root cause of the corruption is, we are submitting a compressed read
for a whole folio, but the extent map we get only covers the first 3
blocks, meaning the compressed read path is merging reads that shouldn't
be merged.

The involved file extents are:

        item 19 key (258 EXTENT_DATA 126976) itemoff 15143 itemsize 53
                generation 9 type 1 (regular)
                extent data disk byte 13635584 nr 4096
                extent data offset 110592 nr 16384 ram 131072
                extent compression 3 (zstd)
        item 20 key (258 EXTENT_DATA 143360) itemoff 15090 itemsize 53
                generation 9 type 1 (regular)
                extent data disk byte 13635584 nr 4096
                extent data offset 12288 nr 24576 ram 131072
                extent compression 3 (zstd)

Note that, both extents at 124K and 140K are pointing to the same
compressed extent, but with different offset.

This means, we reads of range [124K, 140K) and [140K, 165K) should not
be merged.

But read merge check function, btrfs_bio_is_contig(), is only checking
the disk_bytenr of two compressed reads, as there are not enough info
like the involved extent maps to do more comprehensive checks, resulting
the incorrect compressed read.

Unfortunately this is a long existing bug, way before subpage block size
support.

But subpage block size support (and experimental large folio support)
makes it much easier to detect.

If block size equals page size, regular page read will only read one
block each time, thus no extent map sharing nor merge.

(This means for bs == ps cases, it's still possible to hit the bug with
readahead, just we don't have test coverage with content verification
for readahead)

[FIX]
Save the last hit compressed extent map start/len into btrfs_bio_ctrl,
and check if the current extent map is the same as the saved one.

Here we only save em::start/len to save memory for btrfs_bio_ctrl, as
it's using the stack memory, which is a very limited resource inside the
kernel.

Since the compressed extent maps are never merged, their start/len are
unique inside the same inode, thus just checking start/len will be
enough to make sure they are the same extent map.

If the extent maps do not match, force submitting the current bio, so
that the read will never be merged.

CC: stable@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
v2:
- Only save extent_map::start/len to save memory for btrfs_bio_ctrl
  It's using on-stack memory which is very limited inside the kernel.

- Remove the commit message mentioning of clearing last saved em
  Since we're using em::start/len, there is no need to clear them.
  Either we hit the same em::start/len, meaning hitting the same extent
  map, or we hit a different em, which will have a different start/len.
---
 fs/btrfs/extent_io.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0c12fd64a1f3..418e3bf40f94 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -131,6 +131,22 @@ struct btrfs_bio_ctrl {
 	 */
 	unsigned long submit_bitmap;
 	struct readahead_control *ractl;
+
+	/*
+	 * The start/len of the last hit compressed extent map.
+	 *
+	 * The current btrfs_bio_is_contig() only uses disk_bytenr as
+	 * the condition to check if the read can be merged with previous
+	 * bio, which is not correct. E.g. two file extents pointing to the
+	 * same extent.
+	 *
+	 * So here we need to do extra check to merge reads that are
+	 * covered by the same extent map.
+	 * Just extent_map::start/len will be enough, as they are unique
+	 * inside the same inode.
+	 */
+	u64 last_compress_em_start;
+	u64 last_compress_em_len;
 };
 
 /*
@@ -957,6 +973,32 @@ static void btrfs_readahead_expand(struct readahead_control *ractl,
 		readahead_expand(ractl, ra_pos, em_end - ra_pos);
 }
 
+static void save_compressed_em(struct btrfs_bio_ctrl *bio_ctrl,
+			       const struct extent_map *em)
+{
+	if (btrfs_extent_map_compression(em) == BTRFS_COMPRESS_NONE)
+		return;
+	bio_ctrl->last_compress_em_start = em->start;
+	bio_ctrl->last_compress_em_len = em->len;
+}
+
+static bool is_same_compressed_em(struct btrfs_bio_ctrl *bio_ctrl,
+				  const struct extent_map *em)
+{
+	/*
+	 * Only if the em is completely the same as the previous one we can merge
+	 * the current folio in the read bio.
+	 *
+	 * Here we only need to compare the em->start/len against saved
+	 * last_compress_em_start/len, as start/len inside an inode are unique,
+	 * and compressed extent maps are never merged.
+	 */
+	if (em->start != bio_ctrl->last_compress_em_start ||
+	    em->len != bio_ctrl->last_compress_em_len)
+		return false;
+	return true;
+}
+
 /*
  * basic readpage implementation.  Locked extent state structs are inserted
  * into the tree that are removed when the IO is done (by the end_io
@@ -1080,9 +1122,19 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		    *prev_em_start != em->start)
 			force_bio_submit = true;
 
+		/*
+		 * We must ensure we only merge compressed read when the current
+		 * extent map matches the previous one exactly.
+		 */
+		if (compress_type != BTRFS_COMPRESS_NONE) {
+			if (!is_same_compressed_em(bio_ctrl, em))
+				force_bio_submit = true;
+		}
+
 		if (prev_em_start)
 			*prev_em_start = em->start;
 
+		save_compressed_em(bio_ctrl, em);
 		em_gen = em->generation;
 		btrfs_free_extent_map(em);
 		em = NULL;
-- 
2.50.1


