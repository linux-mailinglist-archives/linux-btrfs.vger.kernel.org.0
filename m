Return-Path: <linux-btrfs+bounces-7305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB76F955A74
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2024 02:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FDADB217DA
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2024 00:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4F717D2;
	Sun, 18 Aug 2024 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hr5y4FWf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M9UG9BIU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9587FD
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Aug 2024 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723939478; cv=none; b=fmuZYVmjr7llordYKaqY5hL+8KsgeP+XgcuuwVnEaID754DU8Usz3W2scjIpYpAtdzM7ekqqTNg/XVB0Br747jB5MZMJaecjs5/aMGQpBbrHnaHv9ZUOWpGJwsTTOeew0oeyUFSejBwk5u4gHLMYHEE3rjYO8CzUQPfEk837gEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723939478; c=relaxed/simple;
	bh=CchY44cwaQoNQbUmEzkRz4ZlCqNn5sKCxvWgdaJANDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1MQFIuE/NI7boj326fDnFhBBGlmsW1ALX9XSDRO0ewYMHPYdRntHYW31Yj9MK8Tp9S86P57/TcIQOCHWqsbFBhkZGrjDiaMjs3Z24HJZmAmLN1qc42uOmp+H+HFf7xUp5S7q8cjVPvmC4F7aW5S36je+pw0r4qHvbR7zfBlgkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hr5y4FWf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M9UG9BIU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB41E21EC0;
	Sun, 18 Aug 2024 00:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723939472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uQCrKrh6QSqDnIeCj3Vvr4KJ9Yp+xq/v7NGgKDi1KSo=;
	b=hr5y4FWfQv4m226ydNtkGHjWxOhoWDrYI9NPgIx1TPW+p3lfPudVGAz6VLociVBhs7kUIl
	ZNuw9JQtN9xKrwotpfBKeJe0hKd1G+0D6jKS5y9ddH8v+OXi2fgIhtWUmxds4wmekAqHkG
	s/WA48Vlto+8minGJdG7F1nold6J5BM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723939471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uQCrKrh6QSqDnIeCj3Vvr4KJ9Yp+xq/v7NGgKDi1KSo=;
	b=M9UG9BIUKqU+Gm3jcxEIqzMXLZVaEfvJOah+5EIRgHw0VNOj4MNBn0JAPCLRnMEN3iuejF
	3B84FaUI8gDjGekhnsPTpfSgy8qo/TMAuIB5+gY0P6hUCJF9+764wtoHLiBPkYwYY4HWAA
	SgD3ajWU/z7bAuM+17a028DXB1snGeI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABA6D13A17;
	Sun, 18 Aug 2024 00:04:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v7AjGY46wWYtWgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 18 Aug 2024 00:04:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>
Subject: [PATCH v2] btrfs: fix a use-after-free bug when hitting errors inside btrfs_submit_chunk()
Date: Sun, 18 Aug 2024 09:34:08 +0930
Message-ID: <40aec6703430581de1c987a95121da91c2dc8f19.1723939329.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,opensuse.org:url];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80

[BUG]
There is an internal report that KASAN is reporting use-after-free, with
the following backtrace:

 ==================================================================
 BUG: KASAN: slab-use-after-free in btrfs_check_read_bio+0xa68/0xb70 [btrfs]
 Read of size 4 at addr ffff8881117cec28 by task kworker/u16:2/45
 CPU: 1 UID: 0 PID: 45 Comm: kworker/u16:2 Not tainted 6.11.0-rc2-next-20240805-default+ #76
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
 Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x61/0x80
  print_address_description.constprop.0+0x5e/0x2f0
  print_report+0x118/0x216
  kasan_report+0x11d/0x1f0
  btrfs_check_read_bio+0xa68/0xb70 [btrfs]
  process_one_work+0xce0/0x12a0
  worker_thread+0x717/0x1250
  kthread+0x2e3/0x3c0
  ret_from_fork+0x2d/0x70
  ret_from_fork_asm+0x11/0x20
  </TASK>

 Allocated by task 20917:
  kasan_save_stack+0x37/0x60
  kasan_save_track+0x10/0x30
  __kasan_slab_alloc+0x7d/0x80
  kmem_cache_alloc_noprof+0x16e/0x3e0
  mempool_alloc_noprof+0x12e/0x310
  bio_alloc_bioset+0x3f0/0x7a0
  btrfs_bio_alloc+0x2e/0x50 [btrfs]
  submit_extent_page+0x4d1/0xdb0 [btrfs]
  btrfs_do_readpage+0x8b4/0x12a0 [btrfs]
  btrfs_readahead+0x29a/0x430 [btrfs]
  read_pages+0x1a7/0xc60
  page_cache_ra_unbounded+0x2ad/0x560
  filemap_get_pages+0x629/0xa20
  filemap_read+0x335/0xbf0
  vfs_read+0x790/0xcb0
  ksys_read+0xfd/0x1d0
  do_syscall_64+0x6d/0x140
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

 Freed by task 20917:
  kasan_save_stack+0x37/0x60
  kasan_save_track+0x10/0x30
  kasan_save_free_info+0x37/0x50
  __kasan_slab_free+0x4b/0x60
  kmem_cache_free+0x214/0x5d0
  bio_free+0xed/0x180
  end_bbio_data_read+0x1cc/0x580 [btrfs]
  btrfs_submit_chunk+0x98d/0x1880 [btrfs]
  btrfs_submit_bio+0x33/0x70 [btrfs]
  submit_one_bio+0xd4/0x130 [btrfs]
  submit_extent_page+0x3ea/0xdb0 [btrfs]
  btrfs_do_readpage+0x8b4/0x12a0 [btrfs]
  btrfs_readahead+0x29a/0x430 [btrfs]
  read_pages+0x1a7/0xc60
  page_cache_ra_unbounded+0x2ad/0x560
  filemap_get_pages+0x629/0xa20
  filemap_read+0x335/0xbf0
  vfs_read+0x790/0xcb0
  ksys_read+0xfd/0x1d0
  do_syscall_64+0x6d/0x140
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

[CAUSE]
Although I can not reproduce the error, the report itself is good enough
to pin down the cause.

The call trace is the regular endio workqueue context, but the
free-by-task trace is showing that during btrfs_submit_chunk() we
already hit a critical error, and is calling btrfs_bio_end_io() to error
out.
And the original endio function called bio_put() to free the whole bio.

This means a double freeing thus causing use-after-free, e.g:

1. Enter btrfs_submit_bio() with a read bio
   The read bio length is 128K, crossing two 64K stripes.

2. The first run of btrfs_submit_chunk()

2.1 Call btrfs_map_block(), which returns 64K
2.2 Call btrfs_split_bio()
    Now there are two bios, one referring to the first 64K, the other
    referring to the second 64K.
2.3 The first half is submitted.

3. The second run of btrfs_submit_chunk()

3.1 Call btrfs_map_block(), which by somehow failed
    Now we call btrfs_bio_end_io() to handle the error

3.2 btrfs_bio_end_io() calls the original endio function
    Which is end_bbio_data_read(), and it calls bio_put() for the
    original bio.

    Now the original bio is freed.

4. The submitted first 64K bio finished
   Now we call into btrfs_check_read_bio() and tries to advance the bio
   iter.
   But since the original bio (thus its iter) is already freed, we
   trigger the above use-after free.

   And even if the memory is not poisoned/corrupted, we will later call
   the original endio function, causing a double freeing.

[FIX]
Instead of calling btrfs_bio_end_io(), call btrfs_orig_bbio_end_io(),
which has the extra check on split bios and do the proper refcounting
for cloned bios.

Reported-by: David Sterba <dsterba@suse.cz>
Fixes: 852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Remove the unused variable  @orig_bbio
---
 fs/btrfs/bio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 0ef70fce85ff..088ceaca6ab0 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -668,7 +668,6 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = bbio->fs_info;
-	struct btrfs_bio *orig_bbio = bbio;
 	struct bio *bio = &bbio->bio;
 	u64 logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 length = bio->bi_iter.bi_size;
@@ -762,7 +761,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		btrfs_cleanup_bio(bbio);
 fail:
 	btrfs_bio_counter_dec(fs_info);
-	btrfs_bio_end_io(orig_bbio, ret);
+	bbio->bio.bi_status = ret;
+	btrfs_orig_bbio_end_io(bbio);
 	/* Do not submit another chunk */
 	return true;
 }
-- 
2.46.0


