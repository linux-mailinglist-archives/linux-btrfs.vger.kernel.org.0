Return-Path: <linux-btrfs+bounces-3006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A5871816
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 09:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940F71F22316
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8B8061B;
	Tue,  5 Mar 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q2PrLqnX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q2PrLqnX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE380604
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626789; cv=none; b=BcnQLsy7NQlUP42yu+pqb1RR2kCV/FqbFMxCc0UNwgmV/9GdEekR5zW2XYFzOuZ3WpCDxtZ1d8biZw+7vuBSey1JnWaF/H7o1MIKD58D95gkME0iCSBj3sNLQA4Q8j+1TyZXx4BTz9ZOM0KcN+GFc2SFlwW+AVH3cWmREXSsoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626789; c=relaxed/simple;
	bh=JY5EBeH2DfKu4ybnFRTqK4DQmZiZqWzF8d71HqkQD3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+M74LUX7Z8Ib3uEMfjKSwRzXFvxZ/mUvOFvbmovuPSUG0SUEL0fY15+DaaTOHLeDXca2OLsMBmY9zkz+nue4RepHtq4RyvJxJFvAjZyojyJh7zvR2QpA/jc9e+EYd5WkKNWZ1V9IUVuV8ojnrszlXN9olGvsmTHba0d33NwXPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q2PrLqnX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q2PrLqnX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1311A1F7C0;
	Tue,  5 Mar 2024 08:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709626785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L08X7LpjxesAPAing2YVA69qEGw9onhTCyJUQivVv94=;
	b=Q2PrLqnXhSNW24Z0cl0MB/Ym+AqCHykCUr+GNkLho5UPbXvHo41I6dy8Mv1xKEF9+0Lh8V
	5+UD/eqMV7rnI0cLnwitSa4e/BBRUuEUmigwWsr/91TnLZPNx2G7nZDG9GWF0LdkOsScz9
	nglrAtZOnQIk4Ku1uuTzrBOrNsfr1zY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709626785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L08X7LpjxesAPAing2YVA69qEGw9onhTCyJUQivVv94=;
	b=Q2PrLqnXhSNW24Z0cl0MB/Ym+AqCHykCUr+GNkLho5UPbXvHo41I6dy8Mv1xKEF9+0Lh8V
	5+UD/eqMV7rnI0cLnwitSa4e/BBRUuEUmigwWsr/91TnLZPNx2G7nZDG9GWF0LdkOsScz9
	nglrAtZOnQIk4Ku1uuTzrBOrNsfr1zY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A397C13A5D;
	Tue,  5 Mar 2024 08:19:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GjfWGJ/V5mU3VgAAn2gu4w
	(envelope-from <wqu@suse.com>); Tue, 05 Mar 2024 08:19:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH RFC] btrfs: make extent_write_locked_range() to handle subpage dirty correctly
Date: Tue,  5 Mar 2024 18:49:25 +1030
Message-ID: <7737c2e976c0bb2d36339ed0563cdbd07d846363.1709626757.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Q2PrLqnX
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 1311A1F7C0
X-Spam-Flag: NO

[BUG]
Even with my previous subpage delalloc rework, the following workload
can easily lead to leaked reserved space:

 # mkfs.btrfs -f $dev -s 4k > /dev/null
 # mount $dev $mnt
 # fsstress -v -w -n 8 -d $mnt -s 1709539240
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

The $dev is a tcmu-runner emulated zoned HDD, with 80 zones, and append
max size is 64K.

[CAUSE]
Before the dwrite(), writev() would dirty the following 3 pages:

    720896           +64K           +128K             +192K
    |            |///|//////////////|/////|           |
                 +52K                     +164K

Then the dwrite() would try to drop the page caches for the first two
pages starting at 720896.

Now we trigger delalloc for the above two pages.
Firstly find_lock_delalloc_range() would return the range
[774144, 774144 +64K], not the full dirty range as non-zoned case.

This is due to find_lock_delalloc_range() is using the max zone append
size (64K).
The range would end in the 2nd page.

Then we start writeback through extent_write_locked_range(), which for
the range in the second patch [+52K, +116K), it would clear the page
dirty for the whole page.

    720896           +64K           +128K             +192K
    |            |///|//////////|   |/////|           |
                 +52K           +116K     +164K

This is due to the fact that extent_write_locked_range() is using the
non-subpage compatible call to clear the folio dirty flags.

Now at this stage,we leak reserved space for the remaining dirty part
inside the second page.

[PREMATURE FIX]
For now, just change all the page/folio flag operations to subpage
version.

But this would not fully solve the problem, as we still have other
problems, like triggering the BUG_ON() inside mm/truncate on the second
page of the above range:

 ------------[ cut here ]------------
 kernel BUG at mm/truncate.c:577!
 Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
 Dumping ftrace buffer:
 ---------------------------------
    <...>-2055      1d..2. 16142us : invalidate_inode_pages2_range: !!! folio=786432 !!!
 ---------------------------------
 Call trace:
  invalidate_inode_pages2_range+0x378/0x430
  kiocb_invalidate_pages+0x60/0x98
  __iomap_dio_rw+0x350/0x5d8
  btrfs_dio_write+0x50/0x88 [btrfs]
  btrfs_direct_write+0x128/0x328 [btrfs]
  btrfs_do_write_iter+0x174/0x1e8 [btrfs]
  btrfs_file_write_iter+0x1c/0x30 [btrfs]
  vfs_write+0x258/0x380
  ksys_write+0x80/0x120
  __arm64_sys_write+0x24/0x38
  invoke_syscall+0x78/0x100
  el0_svc_common.constprop.0+0x48/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x3c/0x138
  el0t_64_sync_handler+0x120/0x130
  el0t_64_sync+0x194/0x198
 Code: 97fbf380 f9400380 f271041f 54fff7e0 (d4210000)
 ---[ end trace 0000000000000000 ]---

[REASON FOR RFC]
I really want a formal answer why zoned buffered writes need such
a dedicated (while completely incompatible with subpage)
run_dealloc_cow().

It looks like we have already more than enough infrastructure for zoned
devices, as find_lock_delalloc_range() would already return a range
no larger than max zone append size.

Thus it looks to me that, we're fine to go without a dedicated
run_delalloc_cow() just for zoned.

And since the delalloc range would be locked during
find_lock_delalloc_range(), the content of all the pages won't be
changed, thus I didn't see much reason why we can not go the regular
cow_file_range() + __extent_writepage_io() path.

Of course I'll try to dig deeper to fully solve all the subpage + zoned
bugs, but if we have more shared code paths, it would make our lives
much easier.

Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fb63055f42f3..e9850be26bb7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2286,13 +2286,15 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
 		u32 cur_len = cur_end + 1 - cur;
 		struct page *page;
+		struct folio *folio;
 		int nr = 0;
 
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
 		ASSERT(PageLocked(page));
+		folio = page_folio(page);
 		if (pages_dirty && page != locked_page) {
 			ASSERT(PageDirty(page));
-			clear_page_dirty_for_io(page);
+			btrfs_folio_clear_dirty(fs_info, folio, cur, cur_len);
 		}
 
 		ret = __extent_writepage_io(BTRFS_I(inode), page, cur, cur_len,
@@ -2302,8 +2304,8 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 
 		/* Make sure the mapping tag for page dirty gets cleared. */
 		if (nr == 0) {
-			set_page_writeback(page);
-			end_page_writeback(page);
+			btrfs_folio_set_writeback(fs_info, folio, cur, cur_len);
+			btrfs_folio_clear_writeback(fs_info, folio, cur, cur_len);
 		}
 		if (ret) {
 			btrfs_mark_ordered_io_finished(BTRFS_I(inode), page,
-- 
2.44.0


