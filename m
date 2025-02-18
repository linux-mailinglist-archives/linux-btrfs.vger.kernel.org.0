Return-Path: <linux-btrfs+bounces-11543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ABBA3AC5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 00:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78B01734B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 23:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE201D958E;
	Tue, 18 Feb 2025 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JNXHXf9w";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JNXHXf9w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140AB1C7019
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739920203; cv=none; b=sHw1m91pmdpSR9I6hFa2jqvz4lXBZdEpvP5C7E5FVK1HfPIezyWSnzLhUMGWVTwsExy6ln7A3HbeSfBZUB/fLzBGsvHVEkUIDFNGbRKLCCJJ8Ess88eY7XB/+zKo1i9kpqwI0Hsoh+QaovzzBzzx7ZudLipfaRwm46X/RDPnpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739920203; c=relaxed/simple;
	bh=GL3tx27TtPq8IHf1JD7NtYfkhH95QBNh7SGtDYRS1/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C2LkPOEPz9zhCEl5YzY4Eso+u4HRtInwpNMvC8aM0TBSl4aqxW6tdQ+smL9I11hE+aNo/tpd6Tybk+hPY6PKpWvD5W9jkPFJT+p1KSR0Am0c+wcsW13EqSrU5EMDikpPh0QU5jV0yOcmulLNN2Kq78u5HBqcRwYEGfclRxPUuGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=fail smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JNXHXf9w; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JNXHXf9w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4131B2115C;
	Tue, 18 Feb 2025 23:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739920199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pa0wXzXvzkt7HQcr67INpmUz0RDWeuswWEtvYrB0TTM=;
	b=JNXHXf9wxogcoMnEY7QcjXIm/T4VRi0w7WnCamiuxl/Cw13qSZw5TXcfbAyyzCdt7QQqId
	mKDmjm0RPGkgHYPNt7LtQGFYhv0rBs1f2639vg/TEh2FFSeSyof+jG7lXtkPSwfZri7SAf
	CLuCgQaHht9NDjYR+LZfJSb3RMFfRgs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739920199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pa0wXzXvzkt7HQcr67INpmUz0RDWeuswWEtvYrB0TTM=;
	b=JNXHXf9wxogcoMnEY7QcjXIm/T4VRi0w7WnCamiuxl/Cw13qSZw5TXcfbAyyzCdt7QQqId
	mKDmjm0RPGkgHYPNt7LtQGFYhv0rBs1f2639vg/TEh2FFSeSyof+jG7lXtkPSwfZri7SAf
	CLuCgQaHht9NDjYR+LZfJSb3RMFfRgs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F8D513A1D;
	Tue, 18 Feb 2025 23:09:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xOHlAEYTtWerfwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 18 Feb 2025 23:09:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] btrfs: fix data overwriting bug during buffered write when block size < page size
Date: Wed, 19 Feb 2025 09:39:40 +1030
Message-ID: <a50ceebfe3155ab0f1f0018c28ef99bda264c039.1739920169.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[BUG]
When running generic/417 with a btrfs whose block size < page size
(subpage cases), it always fails.

And the following minimal reproducer is more than enough to trigger it
reliably:

workload()
{
        mkfs.btrfs -s 4k -f $dev > /dev/null
        dmesg -C
        mount $dev $mnt
        $fsstree_dir/src/dio-invalidate-cache -r -b 4096 -n 3 -i 1 -f $mnt/diotest
        ret=$?
        umount $mnt
        stop_trace
        if [ $ret -ne 0 ]; then
                fail
        fi
}

for (( i = 0; i < 1024; i++)); do
        echo "=== $i/$runtime ==="
        workload
done

[CAUSE]
With extra trace printk added to the following functions:
- btrfs_buffered_write()
  * Which folio is touched
  * The file offset (start) where the buffered write is at
  * How many bytes are copied
  * The content of the write (the first 2 bytes)

- submit_one_sector()
  * Which folio is touched
  * The position inside the folio

- pagecache_isize_extended()
  * The parameters of the function itself
  * The parameters of the folio_zero_range()

Which are enough to show the problem:

  22.158114: btrfs_buffered_write: folio pos=0 start=0 copied=4096 content=0x0101
  22.158161: submit_one_sector: r/i=5/257 folio=0 pos=0 content=0x0101
  22.158609: btrfs_buffered_write: folio pos=0 start=4096 copied=4096 content=0x0101
  22.158634: btrfs_buffered_write: folio pos=0 start=8192 copied=4096 content=0x0101
  22.158650: pagecache_isize_extended: folio=0 from=4096 to=8192 bsize=4096 zero off=4096 len=8192
  22.158682: submit_one_sector: r/i=5/257 folio=0 pos=4096 content=0x0000
  22.158686: submit_one_sector: r/i=5/257 folio=0 pos=8192 content=0x0101

The tool dio-invalidate-cache will start 3 threads, each doing a buffered
write with 0x01 at 4096 * i (i is 0, 1 ,2), do a fsync, then do a direct read,
and compare the read buffer with the write buffer.

Note that all 3 btrfs_buffered_write() are writing the correct 0x01 into
the page cache.

But at submit_one_sector(), at file offset 4096, the content is zeroed
out, mostly by pagecache_isize_extended().

The race happens like this:
 Thread A is writing into range [4K, 8K).
 Thread B is writing into range [8K, 12k).

               Thread A              |         Thread B
-------------------------------------+------------------------------------
btrfs_buffered_write()               | btrfs_buffered_write()
|- old_isize = 4K;                   | |- old_isize = 4096;
|- btrfs_inode_lock()                | |
|- write into folio range [4K, 8K)   | |
|- pagecache_isize_extended()        | |
|  extend isize from 4096 to 8192    | |
|  no folio_zero_range() called      | |
|- btrfs_inode_lock()                | |
                                     | |- btrfs_inode_lock()
				     | |- write into folio range [8K, 12K)
				     | |- pagecache_isize_extended()
				     | |  calling folio_zero_range(4K, 8K)
				     | |  This is caused by the old_isize is
				     | |  grabbed too early, without any
				     | |  inode lock.
				     | |- btrfs_inode_unlock()

The @old_isize is grabbed without inode lock, causing race between two
buffered write threads and making pagecache_isize_extended() to zero
range which is still containing cached data.

And this is only affecting subpage btrfs, because for regular blocksize
== page size case, the function pagecache_isize_extended() will do
nothing if the block size >= page size.

[FIX]
Grab the old isize with inode lock hold.
This means each buffered write thread will have a stable view of the
old inode size, thus avoid the above race.

Cc: stable@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fd90855fe717..896dc03689d6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1090,7 +1090,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	u64 lockend;
 	size_t num_written = 0;
 	ssize_t ret;
-	loff_t old_isize = i_size_read(inode);
+	loff_t old_isize;
 	unsigned int ilock_flags = 0;
 	const bool nowait = (iocb->ki_flags & IOCB_NOWAIT);
 	unsigned int bdp_flags = (nowait ? BDP_ASYNC : 0);
@@ -1103,6 +1103,13 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * We can only trust the isize with inode lock hold, or it can race with
+	 * other buffered writes and cause incorrect call of
+	 * pagecache_isize_extended() to overwrite existing data.
+	 */
+	old_isize = i_size_read(inode);
+
 	ret = generic_write_checks(iocb, i);
 	if (ret <= 0)
 		goto out;
-- 
2.48.1


