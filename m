Return-Path: <linux-btrfs+bounces-18055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6A9BF1CD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 16:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B91734D7F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E96F320A1D;
	Mon, 20 Oct 2025 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="blncU3ba"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D21C84DE
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969982; cv=none; b=czN5or/JSPvfW4BEIjSXBCHh/Jfu/H+i1LSJB7blJY1vLG0drVbYhVW3MlRaHPn3kiVWTsi6ssSTnh6P+QDLufaciSujVhlll09hypus6t86dLWSlIGFzLe81T21u0E0kD9OLonPqjJFBEsZmquk/PCINr2+DwKF7464WdUqOPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969982; c=relaxed/simple;
	bh=Tvn8flydXO5BgEpGdLDX2qbchMU5IfUEiIzCWWU7ttE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jos9LbuuEtshN6KsG3HaCsN99d/q6UgsRdybjY7JlNzHuoStjyZKN8Yezt8sxy7YjsUhrvNiYIvgwY17zhFMeVknmjWrjL3on7pdKCynvApnD9zBmGz9c6NY+D6iD34XTngxAi3P4gUqVhQsWdXAYHlf7j3LsU5lhBP7GLgmY28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=blncU3ba; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Gw4SLJmNdolfcYBH9+G+Nz4u4XlSmcvZM+Ji9A5Gwys=; b=blncU3baZo3ThCRmxd89C75Til
	0YZ94B0STMX9+wRLC1s+4Bdkpoa7pTG//wknbmr+rTyacUIR79TMNu64PUCw5Tz8zWneu3+k9uiV0
	RjgnYFqWHLfLccbLWvRc1n5PTWpst1b+uE1qZ3lbaIoZNCPFC5l9KyMV3wtZT9ZzFRywABG6vnTXT
	cusgnX7s7EsZg3Xe4Xmnk3y3JDAluVZdvZD71IcLDQD+tCwSBP/AQRutlFKRIaT77E/kdyYp+iJzB
	+J2cW+93/rD5F5EqiBIg4kPmnJDnMEzvqeJuyTHmDKHR6tD4pbVFGSGr70Fy+nYqHuqwzusShFmTc
	swUb0yKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAqjb-0000000DwYU-3va8;
	Mon, 20 Oct 2025 14:19:39 +0000
Date: Mon, 20 Oct 2025 07:19:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs/071 is unhappy on 6.18-rc2
Message-ID: <aPZE--T-nj0dKB0A@infradead.org>
References: <aPXjTw8WN5Jlv2ho@infradead.org>
 <9093d4c3-b707-4ef1-be48-36578ac1d2f3@gmx.com>
 <aPYFECiBrh36AwtB@infradead.org>
 <cc22f604-25f2-407c-bbb8-887e18630819@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc22f604-25f2-407c-bbb8-887e18630819@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

KASAN output:

[   75.341543] ==================================================================
[   75.341824] BUG: KASAN: slab-use-after-free in btrfs_kill_all_delayed_nodes+0x46f/0x4c0
[   75.342082] Read of size 8 at addr ffff88812389f380 by task btrfs-cleaner/4493
[   75.342310] 
[   75.342369] CPU: 1 UID: 0 PID: 4493 Comm: btrfs-cleaner Tainted: G                 N  6.18.0-rc2+ #4115 PREEMPT(f 
[   75.342372] Tainted: [N]=TEST
[   75.342373] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   75.342374] Call Trace:
[   75.342375]  <TASK>
[   75.342376]  dump_stack_lvl+0x4b/0x70
[   75.342379]  print_report+0x174/0x4e7
[   75.342382]  ? __virt_addr_valid+0x1bb/0x2f0
[   75.342384]  ? btrfs_kill_all_delayed_nodes+0x46f/0x4c0
[   75.342385]  kasan_report+0xd2/0x100
[   75.342387]  ? btrfs_kill_all_delayed_nodes+0x46f/0x4c0
[   75.342388]  btrfs_kill_all_delayed_nodes+0x46f/0x4c0
[   75.342389]  ? _raw_spin_unlock+0x13/0x30
[   75.342392]  ? __pfx_btrfs_kill_all_delayed_nodes+0x10/0x10
[   75.342393]  ? do_raw_spin_lock+0x128/0x260
[   75.342395]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   75.342397]  ? list_lru_add_obj+0xfb/0x1a0
[   75.342399]  ? do_raw_spin_lock+0x128/0x260
[   75.342401]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   75.342402]  btrfs_clean_one_deleted_snapshot+0x143/0x370
[   75.342405]  cleaner_kthread+0x1ee/0x300
[   75.342406]  ? __pfx_cleaner_kthread+0x10/0x10
[   75.342407]  kthread+0x37f/0x6f0
[   75.342409]  ? __pfx_kthread+0x10/0x10
[   75.342411]  ? __pfx_kthread+0x10/0x10
[   75.342412]  ? __pfx_kthread+0x10/0x10
[   75.342413]  ret_from_fork+0x17d/0x240
[   75.342415]  ? __pfx_kthread+0x10/0x10
[   75.342416]  ret_from_fork_asm+0x1a/0x30
[   75.342419]  </TASK>
[   75.342419] 
[   75.345517] Allocated by task 4527:
[   75.345517]  kasan_save_stack+0x22/0x40
[   75.345517]  kasan_save_track+0x14/0x30
[   75.345517]  __kasan_slab_alloc+0x6e/0x70
[   75.345517]  kmem_cache_alloc_noprof+0x14c/0x400
[   75.345517]  btrfs_get_or_create_delayed_node+0x9e/0x9e0
[   75.345517]  btrfs_insert_delayed_dir_index+0xe4/0x8a0
[   75.345517]  btrfs_insert_dir_item+0x4c1/0x720
[   75.345517]  btrfs_add_link+0x173/0xa30
[   75.345517]  btrfs_create_new_inode+0x1551/0x2650
[   75.345517]  btrfs_create_common+0x17b/0x200
[   75.345517]  vfs_mknod+0x3a7/0x600
[   75.345517]  do_mknodat+0x34e/0x520
[   75.345517]  __x64_sys_mknodat+0xaa/0xe0
[   75.345517]  do_syscall_64+0x50/0xfa0
[   75.345517]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   75.345517] 
[   75.345517] Freed by task 4493:
[   75.345517]  kasan_save_stack+0x22/0x40
[   75.345517]  kasan_save_track+0x14/0x30
[   75.345517]  __kasan_save_free_info+0x3b/0x70
[   75.345517]  __kasan_slab_free+0x43/0x70
[   75.345517]  kmem_cache_free+0x172/0x610
[   75.345517]  btrfs_kill_all_delayed_nodes+0x2db/0x4c0
[   75.345517]  btrfs_clean_one_deleted_snapshot+0x143/0x370
[   75.345517]  cleaner_kthread+0x1ee/0x300
[   75.345517]  kthread+0x37f/0x6f0
[   75.345517]  ret_from_fork+0x17d/0x240
[   75.345517]  ret_from_fork_asm+0x1a/0x30
[   75.345517] 
[   75.345517] The buggy address belongs to the object at ffff88812389f370
[   75.345517]  which belongs to the cache btrfs_delayed_node of size 440
[   75.345517] The buggy address is located 16 bytes inside of
[   75.345517]  freed 440-byte region [ffff88812389f370, ffff88812389f528)
[   75.345517] 
[   75.345517] The buggy address belongs to the physical page:
[   75.345517] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12389e
[   75.345517] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   75.345517] flags: 0x4000000000000040(head|zone=2)
[   75.345517] page_type: f5(slab)
[   75.345517] raw: 4000000000000040 ffff88810bcaadc0 ffffea0004487a10 ffff88810c6e6d80
[   75.345517] raw: 0000000000000000 00000000000e000e 00000000f5000000 0000000000000000
[   75.345517] head: 4000000000000040 ffff88810bcaadc0 ffffea0004487a10 ffff88810c6e6d80
[   75.345517] head: 0000000000000000 00000000000e000e 00000000f5000000 0000000000000000
[   75.345517] head: 4000000000000001 ffffea00048e2781 00000000ffffffff 00000000ffffffff
[   75.345517] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
[   75.345517] page dumped because: kasan: bad access detected
[   75.345517] 
[   75.345517] Memory state around the buggy address:
[   75.345517]  ffff88812389f280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   75.345517]  ffff88812389f300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fa fb
[   75.345517] >ffff88812389f380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   75.345517]                    ^
[   75.345517]  ffff88812389f400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   75.345517]  ffff88812389f480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   75.345517] ==================================================================
[   75.501545] Disabling lock debugging due to kernel taint


gdb) l *(btrfs_kill_all_delayed_nodes+0x46f)
0xffffffff82f2422f is in btrfs_kill_all_delayed_nodes (fs/btrfs/delayed-inode.h:219).
214		ref_tracker_dir_exit(&node->ref_dir.dir);
215	}
216	
217	static inline void btrfs_delayed_node_ref_tracker_dir_print(struct btrfs_delayed_node *node)
218	{
219		if (!btrfs_test_opt(node->root->fs_info, REF_TRACKER))
220			return;
221	
222		ref_tracker_dir_print(&node->ref_dir.dir,
223				      BTRFS_DELAYED_NODE_REF_TRACKER_DISPLAY_LIMIT);


