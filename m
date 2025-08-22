Return-Path: <linux-btrfs+bounces-16266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E40B3100B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 09:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FDF68566F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 07:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B8393DE4;
	Fri, 22 Aug 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MNgWOa2t";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MNgWOa2t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F181632C8
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846848; cv=none; b=bVUKjZ+ms+Rznn5fxcAtWsR0n/YYX+e52gMefVxERwcCmtyTidKPbJDo/6J0iHHliopt182M9Uz65uSgWdQEEMDiksZNxLa5a4NWQZsZbLNu0581sMIlFnumojqXgQg+KegrwHzNGcGTd+E12y55MIysDOFNh7zYIvWjhKmZ1rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846848; c=relaxed/simple;
	bh=zj3uJA9bnMCaAtG/HGKWXZAEAHl9gjhfcKAOom5kyFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7deEjsdHVp8dyl+Z+esLdnFnr28rwzQfKxXvMvBSwYJ6681034PI85xRV8urUhsHou3KNwjek1DFJadx5rtnuGQcdbPvLYrPvPHUxq8LmI2wuR0oLxsEYWzPyAEIqaMd6y0lfPONAXwx4cATJkSFHAz0x58dvcawgIA7bqLiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MNgWOa2t; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MNgWOa2t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 425D022258;
	Fri, 22 Aug 2025 07:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755846844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=98/s6RoSNAtWg2H2Kh1oGZdaT8L5qBifPF/oxKRJE7g=;
	b=MNgWOa2tcyeaY7WaYy6bMASYT7xz3WMVha51dJnrwf16Cpc9rgyIzsz6Vh/nj8XusxRs+D
	1KubK19DzdDWfsQ61I08jZlePcqQVg1iG7yyD3dkx40lUGJ5LiL0cAVDP2U+1XzxhlvMWS
	0sjU5Xi+skwDIHOtM6KrX9wYwBvCC+E=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MNgWOa2t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755846844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=98/s6RoSNAtWg2H2Kh1oGZdaT8L5qBifPF/oxKRJE7g=;
	b=MNgWOa2tcyeaY7WaYy6bMASYT7xz3WMVha51dJnrwf16Cpc9rgyIzsz6Vh/nj8XusxRs+D
	1KubK19DzdDWfsQ61I08jZlePcqQVg1iG7yyD3dkx40lUGJ5LiL0cAVDP2U+1XzxhlvMWS
	0sjU5Xi+skwDIHOtM6KrX9wYwBvCC+E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34454139B7;
	Fri, 22 Aug 2025 07:14:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lw9QOboYqGiBBQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 22 Aug 2025 07:14:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] btrfs: do more strict compressed read merge check
Date: Fri, 22 Aug 2025 16:43:41 +0930
Message-ID: <ca8d574888d830061b38c3df3dad5af47dbfefcf.1755846792.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 425D022258
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

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
Save the last hit compressed extent map into btrfs_bio_ctrl, and check
if the last compressed extent map is completely the same as the current
one.

If not, force submitting the current bio, so that the read will never be
merged.

And after submitting a bio, clear btrfs_bio_ctrl::last_compressed_em to
avoid incorrect detection.

CC: stable@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0c12fd64a1f3..bc42b88b10ed 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -131,6 +131,13 @@ struct btrfs_bio_ctrl {
 	 */
 	unsigned long submit_bitmap;
 	struct readahead_control *ractl;
+
+	/*
+	 * The extent map of the last hit compressed extent map.
+	 * The current btrfs_bio_is_contig() doesn't have enough info to
+	 * determine if we can really merge compressed read.
+	 */
+	struct extent_map last_compressed_em;
 };
 
 /*
@@ -957,6 +964,37 @@ static void btrfs_readahead_expand(struct readahead_control *ractl,
 		readahead_expand(ractl, ra_pos, em_end - ra_pos);
 }
 
+static void save_compressed_em(struct btrfs_bio_ctrl *bio_ctrl,
+			       const struct extent_map *em)
+{
+	if (btrfs_extent_map_compression(em) == BTRFS_COMPRESS_NONE)
+		return;
+	memcpy(&bio_ctrl->last_compressed_em, em, sizeof(*em));
+}
+
+static bool is_same_compressed_em(struct btrfs_bio_ctrl *bio_ctrl,
+				  const struct extent_map *em)
+{
+	const struct extent_map *cur_em = &bio_ctrl->last_compressed_em;
+
+	/*
+	 * Only if the em is completely the same as the previous one we cna merge
+	 * the current folio in the read bio.
+	 *
+	 * If such merge happened incorrectly, we will have a bio which is
+	 * larger than the compressed bio, resulting the tailing part not to be
+	 * read out correctly.
+	 */
+	if (em->flags != cur_em->flags ||
+	    em->start != cur_em->start ||
+	    em->len != cur_em->len ||
+	    em->disk_bytenr != cur_em->disk_bytenr ||
+	    em->disk_num_bytes != cur_em->disk_num_bytes ||
+	    em->offset != cur_em->offset)
+		return false;
+	return true;
+}
+
 /*
  * basic readpage implementation.  Locked extent state structs are inserted
  * into the tree that are removed when the IO is done (by the end_io
@@ -1080,9 +1118,19 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
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


