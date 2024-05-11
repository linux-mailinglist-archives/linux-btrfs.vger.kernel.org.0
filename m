Return-Path: <linux-btrfs+bounces-4912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3FE8C2DE7
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 02:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B224A1C21474
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 00:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E599D52F;
	Sat, 11 May 2024 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aWxLSPKw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aWxLSPKw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622FA2579
	for <linux-btrfs@vger.kernel.org>; Sat, 11 May 2024 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386546; cv=none; b=bgIxLDFFDOGvpOdDXEgsa5qnmVusWIvBBn1zTFnQV2K4ndq8d5SVgcu9NY6FX5QN5Ebw4VC5EgTSMNijL86Q1vEPbZK8t14EsGXl1LOsNqfHaoFoK/hsACX8B7n4pxfgtrCmzv24FzfDUjvB6GfjEsqqtdSEY3lYPReff3aCFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386546; c=relaxed/simple;
	bh=8RE5u48OaLSjbwuFbUX+VXcV2qwvy46vn95bkOkoR1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXMvyN9UogaohPZncgojHw9q0OTZjcn4sxAXF+TN+2uNyuFI7NToL5UY3b7e2iR13bFczvX80vJDiBdzTmBDb0DjTR2d9SKaIBn52fIUcRs+BrI9XpVJKUzhjfwHhyFf5P/tAB+NmWiHk0OcFgl7OgOFcCt7M7YNAhLIVe6aqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aWxLSPKw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aWxLSPKw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77FE6200E6;
	Sat, 11 May 2024 00:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715386542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NjQWlMjKw3a13eY2ro98JsfeGagobDlTPi7sQ0/V61M=;
	b=aWxLSPKwfoZrOOj3kKYCGozg2fLf5xqOpczO4QvxYp9afC9VUXlS06z51LEntBlGibm29S
	osIESAjixa29VJe/5uAtH+CEJ7oNaqQ97NbvolX5IQsDb1Mf63/e24inAlKzr4O8B9sCRS
	zf82w5k9adUc5uGSl0ipQMLzqL88Njs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=aWxLSPKw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715386542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NjQWlMjKw3a13eY2ro98JsfeGagobDlTPi7sQ0/V61M=;
	b=aWxLSPKwfoZrOOj3kKYCGozg2fLf5xqOpczO4QvxYp9afC9VUXlS06z51LEntBlGibm29S
	osIESAjixa29VJe/5uAtH+CEJ7oNaqQ97NbvolX5IQsDb1Mf63/e24inAlKzr4O8B9sCRS
	zf82w5k9adUc5uGSl0ipQMLzqL88Njs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0104713A3D;
	Sat, 11 May 2024 00:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YFqZKay4PmYcPAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 11 May 2024 00:15:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: josef@toxicpanda.com,
	Johannes.Thumshirn@wdc.com
Subject: [PATCH v4 5/6] btrfs: do not clear page dirty inside extent_write_locked_range()
Date: Sat, 11 May 2024 09:45:21 +0930
Message-ID: <c694de05f9778dba1aeef99ad880c59da95ab9ed.1715386434.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715386434.git.wqu@suse.com>
References: <cover.1715386434.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 77FE6200E6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

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

  |///| is the dirtied range using subpage bitmaps.

  Meanwhile all three pages (704K, 768K, 832K) all have its PageDirty
  flag set.

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
832K) according to subpage bitmaps.
But the page 768K no longer has PageDirty flag set anymore.

This means we will no longer writeback range [820K, 832K), thus the
reserved data/metadata space would never be properly released.

 > extent_write_cache_pages: r/i=5/259 skip non-dirty folio=786432

Now even we try to start wrteiback for range [820K, 832K), since the
page is not dirty, we completely skip it at extent_write_cache_pages()
time.

 > btrfs_direct_write: r/i=5/259 dio done filepos=696320 len=0

Now the direct IO finished.

 > cow_file_range: r/i=5/259 add ordered extent filepos=851968 len=36864
 > extent_write_locked_range: r/i=5/259 locked page=851968 start=851968 len=36864

Now we writeback the remaining dirty range, which is [832K, 868K).
Causing the range [820K, 832K) never be submitted, thus leaking the
reserved space.

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
index b6dc9308105d..08556db4b4de 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2313,10 +2313,8 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 
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
2.45.0


