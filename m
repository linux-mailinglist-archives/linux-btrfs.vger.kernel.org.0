Return-Path: <linux-btrfs+bounces-7303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CB39557C3
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 14:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C9D1C21134
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 12:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B719914B07E;
	Sat, 17 Aug 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Be00bQJh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Be00bQJh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA787DA97
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Aug 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723897314; cv=none; b=ZXCOsjUBai6drVrwL0PfhQun9v8RDCoiXWruBjZI2ITWPJQwM3x8i5Ojd4WUuFr8gaHrXB0ZZ3xjexL7o0LrEoNQVuRn06Z+IezF9ZfZGs4hraQMaTle5ZSResBf9Gbr2Zinm+iwJ2S4X84B7/LIuYZa9IXmp9eKKvJNFn0whfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723897314; c=relaxed/simple;
	bh=az/ZuY+I96r0ZELenEvN8sRIOUuVRMFQKLW5U1oeC9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lj02baa4GOBYd5ZwXFuNg5IwFokXKRJedzVHU9Mei3RhMi3/LHl5Td2aAzVUluAqGacV/P7q/Cd8F4hK0xiayO+tJyUQjr9CjxC56BxJIWW5WXf2KXWylKdlNATHfptGG9jh7gLceH+KssDD31VYKdyCJQUmAbq/oCKislVn9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Be00bQJh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Be00bQJh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86DCE21FF7;
	Sat, 17 Aug 2024 12:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723897310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KpErxIPCFErSZ6WcqDp2kRUihkFpLdNFnJR5EAaDCHo=;
	b=Be00bQJhzASoBNq9JB4BRfoGH79CdHJjCJNUZCriqpK38hOxwGskVel1M75P4c9qga9qYr
	EEsC3D1ES1RrKJKRbIZsMI4OY/F9flfPv43wMkRSAIHtsuxZBXpgWzcVlhzwIjcaow1X1y
	Vytv2K68qv7ZmxVl0EQVbKwE+uydAUs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723897310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KpErxIPCFErSZ6WcqDp2kRUihkFpLdNFnJR5EAaDCHo=;
	b=Be00bQJhzASoBNq9JB4BRfoGH79CdHJjCJNUZCriqpK38hOxwGskVel1M75P4c9qga9qYr
	EEsC3D1ES1RrKJKRbIZsMI4OY/F9flfPv43wMkRSAIHtsuxZBXpgWzcVlhzwIjcaow1X1y
	Vytv2K68qv7ZmxVl0EQVbKwE+uydAUs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 657471397F;
	Sat, 17 Aug 2024 12:21:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xXQHCN2VwGYIPQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 17 Aug 2024 12:21:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>
Subject: [PATCH] btrfs: fix a use-after-free bug when hitting errors inside btrfs_submit_chunk()
Date: Sat, 17 Aug 2024 21:51:27 +0930
Message-ID: <25987ba63d6e11a6983bf2c57eb2ac8efe059d8e.1723897285.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.cz:email,opensuse.org:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
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
 fs/btrfs/bio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 0ef70fce85ff..4a0e97a56475 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -762,7 +762,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
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


