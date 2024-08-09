Return-Path: <linux-btrfs+bounces-7064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABBC94CBB1
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 09:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883561C21B5D
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 07:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DC11741C3;
	Fri,  9 Aug 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kXuuMYOQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674F1552EB
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190068; cv=none; b=PDpxSj42+nbGmLGYq6/H1WqCa1UY81GUUJvtDz9KzjXSH95En8/x1Hh9xKP6r3BrESJl6ynEhLVqcGu7v9vHI2ClsEF5FBsjak6YWXuhPtqsBv6/VojUO8pErpdYqBWkxDf6V1rRN+iLH3encoyjifkUJ083SW74Y3BXytNbApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190068; c=relaxed/simple;
	bh=vRYfd3X3LUwIdrV2CY82yThCrqPF+PrYmh6SEUrPWgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=loAdpDCQF2IKd1KYWPdvvKItqS0WOgKs2k06HcxmoDucLOnPJBzhifNhcyqD6pQz5M0tOtNyxvGvVpWsKc99FylOyoqsedd7ncwuY57w99s+Q0UU+6rnc3yxzegyXatwljQvuELHpnxHBu7qninU0SZxha3u0jNJVVeduhyJT/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kXuuMYOQ; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723190065; x=1754726065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vRYfd3X3LUwIdrV2CY82yThCrqPF+PrYmh6SEUrPWgk=;
  b=kXuuMYOQUu6UnQxdjTyzXqw56TcoSNG2AdsrtBseI3Tl6ohM3XNV/Iu5
   rPAonuedmu58yY3FkcxXszc2jPkFu08bwrCfXMivysmK2JRfxfliE5rQM
   7AZF8CqxMlwW11bCeP9J/wR0EEXrH1ouuz/3lLAX0h5BxcxNJe7tV5Eco
   Ndd0lJzoaNpHHxk3m4LWlk1zSXmGN1OooC599yXtwQ50Pmhh4nU/N0hXs
   kbLBAiWdJzOlFV5i0BAO+/As7cJr3DfkKT5KUFoGkArcZMbdRovs1zRTV
   tkat9E/ZoKBgNClKzTh/mRucO9b8OX6s3Wwim9BGQoIX6THgMPUI/2Z94
   g==;
X-CSE-ConnectionGUID: WXLP/t1HT7Ooyw+h119WZA==
X-CSE-MsgGUID: J2Ju3bB5TlWR9xhVNv2B6A==
X-IronPort-AV: E=Sophos;i="6.09,275,1716220800"; 
   d="scan'208";a="24158585"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2024 15:54:24 +0800
IronPort-SDR: 66b5bd34_+JAggdHD0p08qzVCFuVKBj6u8rF1JFV9HZSMuB6dAlYJxk5
 snTi4K0cDk0ME2bkmJeCwR9zs9/rN8ZmKSt+5pQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2024 23:54:44 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.116])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Aug 2024 00:54:25 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] btrfs: fix invalid mapping xarray state
Date: Fri,  9 Aug 2024 16:54:22 +0900
Message-ID: <cb40bca119cc0519bb5e17f6a9060a35a839ea28.1723189951.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __extent_writepage_io(), we call btrfs_set_range_writeback() ->
folio_start_writeback(), which clears PAGECACHE_TAG_DIRTY mark from the
mapping xarray if the folio is not dirty. This worked fine before commit
97713b1a2ced ("btrfs: do not clear page dirty inside
extent_write_locked_range()").

After the commit, however, the folio is still dirty at this point, so the
mapping DIRTY tag is not cleared anymore. Then, __extent_writepage_io()
calls btrfs_folio_clear_dirty() to clear the folio's dirty flag. That
results in the page beging unlocked with a "strange" state. The page is not
PageDirty, but the mapping tag is set as PAGECACHE_TAG_DIRTY.

This strange state looks like causing a hang with a call trace below when
running fstests generic/091 on a null_blk device. It is waiting for a folio
lock.

While I don't have an exact relation between this hang and the strange
state, fixing the state also fixes the hang. And, that state is worth
fixing anyway.

This commit reorders btrfs_folio_clear_dirty() and
btrfs_set_range_writeback() in __extent_writepage_io(), so that the
PAGECACHE_TAG_DIRTY tag is properly removed from the xarray.

  [ 2464.274674][  T245] task:fsx             state:D stack:0     pid:3034  tgid:3034  ppid:2853   flags:0x00004002
  [ 2464.286991][  T245] Call Trace:
  [ 2464.291683][  T245]  <TASK>
  [ 2464.295876][  T245]  __schedule+0x10ed/0x6260
  [ 2464.301804][  T245]  ? __pfx___blk_flush_plug+0x10/0x10
  [ 2464.308703][  T245]  ? __submit_bio+0x37c/0x450
  [ 2464.314833][  T245]  ? __pfx___schedule+0x10/0x10
  [ 2464.321245][  T245]  ? lock_release+0x567/0x790
  [ 2464.327480][  T245]  ? __pfx_lock_acquire+0x10/0x10
  [ 2464.334033][  T245]  ? __pfx_lock_release+0x10/0x10
  [ 2464.340674][  T245]  ? __pfx_lock_acquire+0x10/0x10
  [ 2464.347254][  T245]  ? __pfx_lock_release+0x10/0x10
  [ 2464.353732][  T245]  ? do_raw_spin_lock+0x12e/0x270
  [ 2464.360305][  T245]  schedule+0xdf/0x3b0
  [ 2464.365705][  T245]  io_schedule+0x8f/0xf0
  [ 2464.371417][  T245]  folio_wait_bit_common+0x2ca/0x6d0
  [ 2464.378260][  T245]  ? folio_wait_bit_common+0x1cc/0x6d0
  [ 2464.385314][  T245]  ? __pfx_folio_wait_bit_common+0x10/0x10
  [ 2464.392658][  T245]  ? __pfx_filemap_get_folios_tag+0x10/0x10
  [ 2464.400173][  T245]  ? __pfx_wake_page_function+0x10/0x10
  [ 2464.407309][  T245]  ? __pfx___might_resched+0x10/0x10
  [ 2464.414120][  T245]  ? do_raw_spin_unlock+0x58/0x1f0
  [ 2464.420688][  T245]  extent_write_cache_pages+0xe49/0x1620 [btrfs]
  [ 2464.428894][  T245]  ? lock_acquire+0x435/0x500
  [ 2464.435024][  T245]  ? __pfx_extent_write_cache_pages+0x10/0x10 [btrfs]
  [ 2464.443736][  T245]  ? btrfs_do_write_iter+0x493/0x640 [btrfs]
  [ 2464.451523][  T245]  ? orc_find.part.0+0x1d4/0x380
  [ 2464.457938][  T245]  ? __pfx_lock_release+0x10/0x10
  [ 2464.464544][  T245]  ? __pfx_lock_release+0x10/0x10
  [ 2464.471066][  T245]  ? btrfs_do_write_iter+0x493/0x640 [btrfs]
  [ 2464.478722][  T245]  btrfs_writepages+0x1cc/0x460 [btrfs]
  [ 2464.485913][  T245]  ? __pfx_btrfs_writepages+0x10/0x10 [btrfs]
  [ 2464.493675][  T245]  ? is_bpf_text_address+0x6e/0x100
  [ 2464.500476][  T245]  ? kernel_text_address+0x145/0x160
  [ 2464.507359][  T245]  ? unwind_get_return_address+0x5e/0xa0
  [ 2464.514709][  T245]  ? arch_stack_walk+0xac/0x100
  [ 2464.521090][  T245]  do_writepages+0x176/0x780
  [ 2464.527189][  T245]  ? lock_release+0x567/0x790
  [ 2464.533402][  T245]  ? __pfx_do_writepages+0x10/0x10
  [ 2464.540069][  T245]  ? __pfx_lock_acquire+0x10/0x10
  [ 2464.546724][  T245]  ? __pfx_stack_trace_save+0x10/0x10
  [ 2464.553598][  T245]  ? do_raw_spin_lock+0x12e/0x270
  [ 2464.560158][  T245]  ? do_raw_spin_unlock+0x58/0x1f0
  [ 2464.566760][  T245]  ? _raw_spin_unlock+0x23/0x40
  [ 2464.573105][  T245]  ? wbc_attach_and_unlock_inode+0x3da/0x7d0
  [ 2464.580664][  T245]  filemap_fdatawrite_wbc+0x113/0x180
  [ 2464.587706][  T245]  ? prepare_pages.constprop.0+0x13c/0x5c0 [btrfs]
  [ 2464.596015][  T245]  __filemap_fdatawrite_range+0xaf/0xf0
  [ 2464.603159][  T245]  ? __pfx___filemap_fdatawrite_range+0x10/0x10
  [ 2464.611102][  T245]  ? trace_irq_enable.constprop.0+0xce/0x110
  [ 2464.618689][  T245]  ? kasan_quarantine_put+0xd7/0x1e0
  [ 2464.625641][  T245]  btrfs_start_ordered_extent+0x46f/0x570 [btrfs]
  [ 2464.633843][  T245]  ? __pfx_btrfs_start_ordered_extent+0x10/0x10 [btrfs]
  [ 2464.642777][  T245]  ? __clear_extent_bit+0x2c0/0x9d0 [btrfs]
  [ 2464.650522][  T245]  btrfs_lock_and_flush_ordered_range+0xc6/0x180 [btrfs]
  [ 2464.659525][  T245]  ? __pfx_btrfs_lock_and_flush_ordered_range+0x10/0x10 [btrfs]
  [ 2464.669173][  T245]  btrfs_read_folio+0x12a/0x1d0 [btrfs]
  [ 2464.676520][  T245]  ? __pfx_btrfs_read_folio+0x10/0x10 [btrfs]
  [ 2464.684449][  T245]  ? __pfx_filemap_add_folio+0x10/0x10
  [ 2464.691733][  T245]  ? __pfx___might_resched+0x10/0x10
  [ 2464.698736][  T245]  ? __filemap_get_folio+0x1c5/0x450
  [ 2464.705739][  T245]  prepare_uptodate_page+0x12e/0x4d0 [btrfs]
  [ 2464.713624][  T245]  prepare_pages.constprop.0+0x13c/0x5c0 [btrfs]
  [ 2464.721758][  T245]  ? fault_in_iov_iter_readable+0xd2/0x240
  [ 2464.729292][  T245]  btrfs_buffered_write+0x5bd/0x12f0 [btrfs]
  [ 2464.737106][  T245]  ? __pfx_btrfs_buffered_write+0x10/0x10 [btrfs]
  [ 2464.745448][  T245]  ? __pfx_lock_release+0x10/0x10
  [ 2464.752085][  T245]  ? generic_write_checks+0x275/0x400
  [ 2464.759126][  T245]  ? down_write+0x118/0x1f0
  [ 2464.765188][  T245]  ? up_write+0x19b/0x500
  [ 2464.770947][  T245]  btrfs_direct_write+0x731/0xba0 [btrfs]
  [ 2464.778148][  T245]  ? __pfx_btrfs_direct_write+0x10/0x10 [btrfs]
  [ 2464.785902][  T245]  ? __pfx___might_resched+0x10/0x10
  [ 2464.792460][  T245]  ? lock_acquire+0x435/0x500
  [ 2464.798466][  T245]  ? lock_acquire+0x435/0x500
  [ 2464.804450][  T245]  btrfs_do_write_iter+0x494/0x640 [btrfs]
  [ 2464.811630][  T245]  ? __pfx_btrfs_do_write_iter+0x10/0x10 [btrfs]
  [ 2464.819386][  T245]  ? __pfx___might_resched+0x10/0x10
  [ 2464.825952][  T245]  ? rw_verify_area+0x6d/0x590
  [ 2464.831937][  T245]  vfs_write+0x5d7/0xf50
  [ 2464.837412][  T245]  ? __might_fault+0x9d/0x120
  [ 2464.843363][  T245]  ? __pfx_vfs_write+0x10/0x10
  [ 2464.849417][  T245]  ? btrfs_file_llseek+0xb1/0xfb0 [btrfs]
  [ 2464.856493][  T245]  ? lock_release+0x567/0x790
  [ 2464.862348][  T245]  ksys_write+0xfb/0x1d0
  [ 2464.867723][  T245]  ? __pfx_ksys_write+0x10/0x10
  [ 2464.873781][  T245]  ? _raw_spin_unlock+0x23/0x40
  [ 2464.879858][  T245]  ? btrfs_getattr+0x4af/0x670 [btrfs]
  [ 2464.886649][  T245]  ? vfs_getattr_nosec+0x79/0x340
  [ 2464.892929][  T245]  do_syscall_64+0x95/0x180
  [ 2464.898578][  T245]  ? __do_sys_newfstat+0xde/0xf0
  [ 2464.904728][  T245]  ? __pfx___do_sys_newfstat+0x10/0x10
  [ 2464.911454][  T245]  ? trace_irq_enable.constprop.0+0xce/0x110
  [ 2464.918797][  T245]  ? syscall_exit_to_user_mode+0xac/0x2a0
  [ 2464.925851][  T245]  ? do_syscall_64+0xa1/0x180
  [ 2464.931715][  T245]  ? trace_irq_enable.constprop.0+0xce/0x110
  [ 2464.939106][  T245]  ? trace_irq_enable.constprop.0+0xce/0x110
  [ 2464.946406][  T245]  ? syscall_exit_to_user_mode+0xac/0x2a0
  [ 2464.953501][  T245]  ? btrfs_file_llseek+0xb1/0xfb0 [btrfs]
  [ 2464.960625][  T245]  ? do_syscall_64+0xa1/0x180
  [ 2464.966482][  T245]  ? btrfs_file_llseek+0xb1/0xfb0 [btrfs]
  [ 2464.973570][  T245]  ? trace_irq_enable.constprop.0+0xce/0x110
  [ 2464.980915][  T245]  ? syscall_exit_to_user_mode+0xac/0x2a0
  [ 2464.987978][  T245]  ? __pfx_btrfs_file_llseek+0x10/0x10 [btrfs]
  [ 2464.995542][  T245]  ? trace_irq_enable.constprop.0+0xce/0x110
  [ 2465.002901][  T245]  ? __pfx_btrfs_file_llseek+0x10/0x10 [btrfs]
  [ 2465.010462][  T245]  ? do_syscall_64+0xa1/0x180
  [ 2465.016429][  T245]  ? lock_release+0x567/0x790
  [ 2465.022388][  T245]  ? __pfx_lock_acquire+0x10/0x10
  [ 2465.028622][  T245]  ? __pfx_lock_release+0x10/0x10
  [ 2465.034894][  T245]  ? trace_irq_enable.constprop.0+0xce/0x110
  [ 2465.042309][  T245]  ? syscall_exit_to_user_mode+0xac/0x2a0
  [ 2465.049458][  T245]  ? do_syscall_64+0xa1/0x180
  [ 2465.055421][  T245]  ? syscall_exit_to_user_mode+0xac/0x2a0
  [ 2465.062429][  T245]  ? do_syscall_64+0xa1/0x180
  [ 2465.068391][  T245]  ? syscall_exit_to_user_mode+0xac/0x2a0
  [ 2465.075416][  T245]  ? do_syscall_64+0xa1/0x180
  [ 2465.081383][  T245]  ? clear_bhb_loop+0x25/0x80
  [ 2465.087346][  T245]  ? clear_bhb_loop+0x25/0x80
  [ 2465.093282][  T245]  ? clear_bhb_loop+0x25/0x80
  [ 2465.099197][  T245]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [ 2465.106399][  T245] RIP: 0033:0x7f093b8ee784
  [ 2465.111990][  T245] RSP: 002b:00007ffc29d31b28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
  [ 2465.122130][  T245] RAX: ffffffffffffffda RBX: 0000000000006000 RCX: 00007f093b8ee784
  [ 2465.131698][  T245] RDX: 000000000001de00 RSI: 00007f093b6ed200 RDI: 0000000000000003
  [ 2465.141390][  T245] RBP: 000000000001de00 R08: 0000000000006000 R09: 0000000000000000
  [ 2465.150994][  T245] R10: 0000000000023e00 R11: 0000000000000202 R12: 0000000000006000
  [ 2465.160533][  T245] R13: 0000000000023e00 R14: 0000000000023e00 R15: 0000000000000001
  [ 2465.170157][  T245]  </TASK>
  [ 2465.174240][  T245] INFO: lockdep is turned off.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 97713b1a2ced ("btrfs: do not clear page dirty inside extent_write_locked_range()")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 040c92541bc9..271a1ad9fe88 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1478,6 +1478,13 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		free_extent_map(em);
 		em = NULL;
 
+		/*
+		 * Although the PageDirty bit might be cleared before entering
+		 * this function, subpage dirty bit is not cleared.
+		 * So clear subpage dirty bit here so next time we won't submit
+		 * page for range already written to disk.
+		 */
+		btrfs_folio_clear_dirty(fs_info, folio, cur, iosize);
 		btrfs_set_range_writeback(inode, cur, cur + iosize - 1);
 		if (!folio_test_writeback(folio)) {
 			btrfs_err(inode->root->fs_info,
@@ -1485,13 +1492,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			       folio->index, cur, end);
 		}
 
-		/*
-		 * Although the PageDirty bit is cleared before entering this
-		 * function, subpage dirty bit is not cleared.
-		 * So clear subpage dirty bit here so next time we won't submit
-		 * folio for range already written to disk.
-		 */
-		btrfs_folio_clear_dirty(fs_info, folio, cur, iosize);
 
 		submit_extent_folio(bio_ctrl, disk_bytenr, folio,
 				    iosize, cur - folio_pos(folio));
-- 
2.45.2


