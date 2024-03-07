Return-Path: <linux-btrfs+bounces-3045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5523F87469E
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 04:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B407285822
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 03:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C80EF9D6;
	Thu,  7 Mar 2024 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b8G0VxiL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b8G0VxiL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9936D4C83
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781423; cv=none; b=WPu8XbykisZuw8srfYkM9K7Ydo5ExWX96SazNVauNUgTS9FsFfm3vnQMSmuxLoNWYLqEi2crPDUZA99K8I7saUm8+o5EmiJBUaWqpT87VJCtgOces2WWv633pcu+8a/7F3upxejLlZHMgG11H2ah/r/FcAu3zSW8b0KTCwcvT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781423; c=relaxed/simple;
	bh=R5QUuuxoIdF/yC5Swn05tvaMP6dP5H6bKNN4jVrjWgQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CP25TTHs81TqsEAG0yN9INAEMvc7Z6VeC7PcQwLHX0r390+KicsvaglTCZumTQPPgV3hPU4FrrF0z3faUL1LPl1DnqP6/VHhUaDzlQCw/7ptY3T/xohXqw+C2LXBOdHTz8Q03SDvPplPk76L6LUJ4+nelPvBwsecDJ37sG3wc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b8G0VxiL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b8G0VxiL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A10038B897
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 03:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709781419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISIJRmFPP2UpTUofZHGXz4cJxO5OfrzIcJkSUKygVnE=;
	b=b8G0VxiLmDSCN9EbacwUv+HNYBbuEay4rEkE8x9rP/729lKeh4jNi/2dEs7YMjSou63nkt
	mG24sqCGc3qe7VumyLrqZVTEvn9AB/hFvKwpy0g2r/JapMfPOFflcBBF1LjirZFw7fsyhr
	8BBcHR1Qio/DCL3z3G8jo+1qSU8FTh4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709781419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISIJRmFPP2UpTUofZHGXz4cJxO5OfrzIcJkSUKygVnE=;
	b=b8G0VxiLmDSCN9EbacwUv+HNYBbuEay4rEkE8x9rP/729lKeh4jNi/2dEs7YMjSou63nkt
	mG24sqCGc3qe7VumyLrqZVTEvn9AB/hFvKwpy0g2r/JapMfPOFflcBBF1LjirZFw7fsyhr
	8BBcHR1Qio/DCL3z3G8jo+1qSU8FTh4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CDC2313466
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 03:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AHr8H6ox6WUqDgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 07 Mar 2024 03:16:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/2] btrfs: do not clear page dirty inside extent_write_locked_range()
Date: Thu,  7 Mar 2024 13:46:38 +1030
Message-ID: <650b46e68949ad2dbf3dd3dd16eca3714b5f428d.1709781158.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709781158.git.wqu@suse.com>
References: <cover.1709781158.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=b8G0VxiL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: A10038B897
X-Spam-Flag: NO

[BUG]
For subpage + zoned case, the following workload can lead to rsv data
leak at unmount time:

 # mkfs.btrfs -f -s 4k $dev
 # mount $dev $mnt
 # fsstress -w -n 8 -d $mnt -s 1709539240
 0/0: fiemap - no filename
 0/1: copyrange read - no filename
 0/2: write - no filename
 0/3: rename - no source filename
 0/4: creat f0 x:0 0 0
 0/4: creat add id=0,parent=-1
 0/5: writev f0[259 1 0 0 0 0] [778052,113,965] 0
 0/6: ioctl(FIEMAP) f0[259 1 0 0 224 887097] [1294220,2291618343991484791,0x10000] -1
 0/7: dwrite - xfsctl(XFS_IOC_DIOINFO) f0[259 1 0 0 224 887097] return 25, fallback to stat()
 0/7: dwrite f0[259 1 0 0 224 887097] [696320,102400] 0
 # umount $mnt

The dmesg would include the following rsv leak detection wanring (all
call trace skipped):

 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 4528 at fs/btrfs/inode.c:8653 btrfs_destroy_inode+0x1e0/0x200 [btrfs]
 ---[ end trace 0000000000000000 ]---
 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 4528 at fs/btrfs/inode.c:8654 btrfs_destroy_inode+0x1a8/0x200 [btrfs]
 ---[ end trace 0000000000000000 ]---
 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 4528 at fs/btrfs/inode.c:8660 btrfs_destroy_inode+0x1a0/0x200 [btrfs]
 ---[ end trace 0000000000000000 ]---
 BTRFS info (device sda): last unmount of filesystem 1b4abba9-de34-4f07-9e7f-157cf12a18d6
 ------------[ cut here ]------------
 WARNING: CPU: 3 PID: 4528 at fs/btrfs/block-group.c:4434 btrfs_free_block_groups+0x338/0x500 [btrfs]
 ---[ end trace 0000000000000000 ]---
 BTRFS info (device sda): space_info DATA has 268218368 free, is not full
 BTRFS info (device sda): space_info total=268435456, used=204800, pinned=0, reserved=0, may_use=12288, readonly=0 zone_unusable=0
 BTRFS info (device sda): global_block_rsv: size 0 reserved 0
 BTRFS info (device sda): trans_block_rsv: size 0 reserved 0
 BTRFS info (device sda): chunk_block_rsv: size 0 reserved 0
 BTRFS info (device sda): delayed_block_rsv: size 0 reserved 0
 BTRFS info (device sda): delayed_refs_rsv: size 0 reserved 0
 ------------[ cut here ]------------
 WARNING: CPU: 3 PID: 4528 at fs/btrfs/block-group.c:4434 btrfs_free_block_groups+0x338/0x500 [btrfs]
 ---[ end trace 0000000000000000 ]---
 BTRFS info (device sda): space_info METADATA has 267796480 free, is not full
 BTRFS info (device sda): space_info total=268435456, used=131072, pinned=0, reserved=0, may_use=262144, readonly=0 zone_unusable=245760
 BTRFS info (device sda): global_block_rsv: size 0 reserved 0
 BTRFS info (device sda): trans_block_rsv: size 0 reserved 0
 BTRFS info (device sda): chunk_block_rsv: size 0 reserved 0
 BTRFS info (device sda): delayed_block_rsv: size 0 reserved 0
 BTRFS info (device sda): delayed_refs_rsv: size 0 reserved 0

Above $dev is a tcmu-runner emulated zoned HDD, which has a max zone
append size of 64K, and the system has 64K page size.

[CAUSE]
I have added several trace_printk() to show the events (header skipped):

 > btrfs_dirty_pages: r/i=5/259 dirty start=774144 len=114688
 > btrfs_dirty_pages: r/i=5/259 dirty part of page=720896 off_in_page=53248 len_in_page=12288
 > btrfs_dirty_pages: r/i=5/259 dirty part of page=786432 off_in_page=0 len_in_page=65536
 > btrfs_dirty_pages: r/i=5/259 dirty part of page=851968 off_in_page=0 len_in_page=36864

The above lines shows our buffered write has dirtied 3 pages of inode
259 of root 5:

  704K             768K              832K              896K
  |           |////|/////////////////|///////////|     |
              756K                               868K

  |///| is the dirtied range.

 > btrfs_direct_write: r/i=5/259 start dio filepos=696320 len=102400

Then direct IO write starts, since the range [680K, 780K) covers the
beginning part of the above dirty range, btrfs needs to writeback the
two pages at 704K and 768K.

 > cow_file_range: r/i=5/259 add ordered extent filepos=774144 len=65536
 > extent_write_locked_range: r/i=5/259 locked page=720896 start=774144 len=65536

Now the above 2 lines shows that, we're writing back for dirty range
[756K, 756K + 64K).
We only writeback 64K because the zoned device has max zone append size
as 64K.

 > extent_write_locked_range: r/i=5/259 clear dirty for page=786432

!!! The above line shows the root cause. !!!
We're calling clear_page_dirty_for_io() inside extent_write_locked_range(),
for the page 768K.

After the writeback of range [756K, 820K), the dirty flags looks like
this:

  704K             768K              832K              896K
  |                |      |          |/////////////|   |
                          820K                     868K

Note the range inside page 768K, we should still have dirty range [820K,
832K).
This means we will no longer writeback range [820K, 832K), thus the
reserved data/metadata space would never be properly released.

 > extent_write_cache_pages: r/i=5/259 skip non-dirty folio=786432

Now even we try to start wrteiback for range [820K, 832K), since the
page is not dirty, we completely skip it.

 > btrfs_direct_write: r/i=5/259 dio done filepos=696320 len=0

Now the direct IO finished.

 > cow_file_range: r/i=5/259 add ordered extent filepos=851968 len=36864
 > extent_write_locked_range: r/i=5/259 locked page=851968 start=851968 len=36864

Now we writeback the remaining dirty range, which is [832K, 868K).

This bug only affects subpage and zoned case.
For non-subpage and zoned case, find_next_dirty_byte() just return the
whole page no matter if it has dirty flags or not.

For subpage and non-zoned case, we never go into
extent_write_locked_range().

[FIX]
Just do not clear the page dirty at all.
As __extent_writepage_io() would do a more accurate, subpage compatible
clear for page dirty anyway.

Now the correct trace would look like this:

 > btrfs_dirty_pages: r/i=5/259 dirty start=774144 len=114688
 > btrfs_dirty_pages: r/i=5/259 dirty part of page=720896 off_in_page=53248 len_in_page=12288
 > btrfs_dirty_pages: r/i=5/259 dirty part of page=786432 off_in_page=0 len_in_page=65536
 > btrfs_dirty_pages: r/i=5/259 dirty part of page=851968 off_in_page=0 len_in_page=36864

The page dirty part is still the same 3 pages.

 > btrfs_direct_write: r/i=5/259 start dio filepos=696320 len=102400
 > cow_file_range: r/i=5/259 add ordered extent filepos=774144 len=65536
 > extent_write_locked_range: r/i=5/259 locked page=720896 start=774144 len=65536

And the writeback for the first 64K is still correct.

 > cow_file_range: r/i=5/259 add ordered extent filepos=839680 len=49152
 > extent_write_locked_range: r/i=5/259 locked page=786432 start=839680 len=49152

Now with the fix, we can properly writeback the range [820K, 832K), and
properly release the reserved data/metadata space.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fb63055f42f3..bdd0e29ba848 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2290,10 +2290,8 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
 		ASSERT(PageLocked(page));
-		if (pages_dirty && page != locked_page) {
+		if (pages_dirty && page != locked_page)
 			ASSERT(PageDirty(page));
-			clear_page_dirty_for_io(page);
-		}
 
 		ret = __extent_writepage_io(BTRFS_I(inode), page, cur, cur_len,
 					    &bio_ctrl, i_size, &nr);
-- 
2.44.0


