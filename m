Return-Path: <linux-btrfs+bounces-18084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A56BBF404B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 01:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C43994F3157
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 23:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D7221F39;
	Mon, 20 Oct 2025 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXiDqjsb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FB5303C8D
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002755; cv=none; b=ubhT/84+A2T2KkAzVo4crH0INQ+J5zDzw7Xm2yzbeEUBjP9JEsIne/sX7DI70kaIj+68brratAljkWbNGBAc5/jmFgvpwRp1Ao47Uu99qcQkKNx2KiTBm1NhQBfroK2QqIQ/VKMUBNa1V5tl97BI7DzzTeVS+6gjlTiS0N2Gz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002755; c=relaxed/simple;
	bh=ZKlsj+ZzewsZaMbK2u2yENlNnuijAhUR2SL+DgM9mFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlAAIdWXMunbY7ykrzf0GhIYuxtbLAqhoO/x5stn0BGljOqHiAQ5YsOPvgwNvmtroO1CxqU9VdnfsPgXhK/IwSBfe8HKctc34MmOe01p/K5xRQPxU3OK8XW120eZ6mH7CojFB8j0B466hSZkEbLnlFOqAUa1ecct6s8naZOq2sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXiDqjsb; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-63e1a326253so3852567d50.2
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 16:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761002752; x=1761607552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEcOaElqsgD/5ZPpgTMLonQf4kYhRnqURB+bR+Jr16Q=;
        b=ZXiDqjsb27Y7oPof6nNBdbTyLLvzV6JEz3110Q5j1NvoWACluXfwKmGX6pkCvXiAXc
         XNODK8Q4BOlRR7skqDb+5FcRA7TsMX1l0EZjoBzbvwmxDywjUDSIXLyjbPPBVvCP7NDz
         7kHeqama8broMb0+2ttWvLDEE9i2GjECwLgn3EKjHMcWrSX8HLDkEASewCb30IIb20du
         g8VdjpY2hnIIiwy1PB9uVOu9PmKmX6D8YE7Zi12d3WwY5CRjRVNDFX45JFMDzutVzicm
         SaWzRHoWAbDIQxOCoosIBIjo888QsSQB4bfPf0Yl6Z7zRWA0p/ZfLAwtASPnQJa858cT
         Pzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761002752; x=1761607552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEcOaElqsgD/5ZPpgTMLonQf4kYhRnqURB+bR+Jr16Q=;
        b=QTch0lsuw69j1k1225h2nyc7gMPD92ehJuu4ko1QsXoEGhwpvC4HmtexbhOW6jZKKQ
         2192VhPUE712I11vuUMgh5SBmy+NdfBmI0V0Lhp3OO1leFF+JOkXcJbPXwd6V9Qn1WaU
         4/McOqea6RqVVPE7pOdTT5GIFPyVhRwx8kr/179bx2KDCD7ahfBNqbHOnpt6lT1FJ6FN
         O3WyWByjLfPd0IUqOhHYWTvQn2swmRk/g33fPRjR75zgNMdpv7CM8a3rQvd+54HiRt2y
         mOjH5TaIMcH27aAX5SgU40ddP7sd8WNDYhSxZHlLcmGY6CnxhL7egGLvMImzdaa8caRO
         k7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUn7L4mpzDyFJPAEXBWSeATleWqk+fw5pmMdG6Gphh47ImaBWMk83v77DIrQlh+I+mLXb+l+lEVzbnlZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0RbgQY1uYLQJRtaflVRsRnMQ2914HQ8rGEfP1TSm2ukgqrqUd
	FOtxGFEukl5dzDfYuhP/LcNnc0m5mv5BJKu5E2EDNm0iFhUDpHxyXjAX
X-Gm-Gg: ASbGnctZo7vRI8mxdtI/rPIN494NlEGXqI6Y0Yu96Jet8r8eX1KlKYNperZc+f1eE92
	rvjBU1mzkwhFwuMvrCguTulRlVYAay0fE1vhSokRBE2WGprzMhdiy8b9IiGI2FejOlVyvpOL+C/
	I/NDPWer8KuGkHcMVY3zBri2bvnovR9/QqHMDCXpdSgkoj//qex37fiXZUEWvzTjqhVycw5H77G
	7ijX7Jz94rGcZFklncB3MjRbO73h1zy9PBK8VGcNXOBSk5HjgO0W9YkH7PrTNGbUraMTzqPpLeV
	clJIuJPRHuhJ5SCPAb3s+HzuHjqCiNnMxDwhpJi4rI4lut8DGMrKD+pCQ+eyMjUGM6kv5q+WBtp
	jJBbc1WF8GTa1vgihiIDvifjxabdTU99zgJxghupxbmlsehvqbqv2YW0KrE26NzCZNAhpe6Zrca
	GBuGAACfP90y9+ErQ/WB78OfFGwSTa
X-Google-Smtp-Source: AGHT+IFMBgQZJDk+23X71dXsX/HJXbIon63aL1w286vQiquJ0X//0wZXEweKqHWwYN22iOwchwAf/A==
X-Received: by 2002:a05:690e:2506:10b0:636:149a:f579 with SMTP id 956f58d0204a3-63e1610c69amr11036899d50.23.1761002751726;
        Mon, 20 Oct 2025 16:25:51 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-784673b9a12sm25007537b3.17.2025.10.20.16.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:25:51 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: Leo Martins <loemra.dev@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: btrfs/071 is unhappy on 6.18-rc2
Date: Mon, 20 Oct 2025 16:25:29 -0700
Message-ID: <20251020232548.3519220-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020165512.3843091-1-loemra.dev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Oct 2025 09:55:10 -0700 Leo Martins <loemra.dev@gmail.com> wrote:

> On Mon, 20 Oct 2025 07:19:39 -0700 Christoph Hellwig <hch@infradead.org> wrote:
> 
> > KASAN output:
> > 
> > [   75.341543] ==================================================================
> > [   75.341824] BUG: KASAN: slab-use-after-free in btrfs_kill_all_delayed_nodes+0x46f/0x4c0
> > [   75.342082] Read of size 8 at addr ffff88812389f380 by task btrfs-cleaner/4493
> > [   75.342310] 
> > [   75.342369] CPU: 1 UID: 0 PID: 4493 Comm: btrfs-cleaner Tainted: G                 N  6.18.0-rc2+ #4115 PREEMPT(f 
> > [   75.342372] Tainted: [N]=TEST
> > [   75.342373] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [   75.342374] Call Trace:
> > [   75.342375]  <TASK>
> > [   75.342376]  dump_stack_lvl+0x4b/0x70
> > [   75.342379]  print_report+0x174/0x4e7
> > [   75.342382]  ? __virt_addr_valid+0x1bb/0x2f0
> > [   75.342384]  ? btrfs_kill_all_delayed_nodes+0x46f/0x4c0
> > [   75.342385]  kasan_report+0xd2/0x100
> > [   75.342387]  ? btrfs_kill_all_delayed_nodes+0x46f/0x4c0
> > [   75.342388]  btrfs_kill_all_delayed_nodes+0x46f/0x4c0
> > [   75.342389]  ? _raw_spin_unlock+0x13/0x30
> > [   75.342392]  ? __pfx_btrfs_kill_all_delayed_nodes+0x10/0x10
> > [   75.342393]  ? do_raw_spin_lock+0x128/0x260
> > [   75.342395]  ? __pfx_do_raw_spin_lock+0x10/0x10
> > [   75.342397]  ? list_lru_add_obj+0xfb/0x1a0
> > [   75.342399]  ? do_raw_spin_lock+0x128/0x260
> > [   75.342401]  ? __pfx_do_raw_spin_lock+0x10/0x10
> > [   75.342402]  btrfs_clean_one_deleted_snapshot+0x143/0x370
> > [   75.342405]  cleaner_kthread+0x1ee/0x300
> > [   75.342406]  ? __pfx_cleaner_kthread+0x10/0x10
> > [   75.342407]  kthread+0x37f/0x6f0
> > [   75.342409]  ? __pfx_kthread+0x10/0x10
> > [   75.342411]  ? __pfx_kthread+0x10/0x10
> > [   75.342412]  ? __pfx_kthread+0x10/0x10
> > [   75.342413]  ret_from_fork+0x17d/0x240
> > [   75.342415]  ? __pfx_kthread+0x10/0x10
> > [   75.342416]  ret_from_fork_asm+0x1a/0x30
> > [   75.342419]  </TASK>
> > [   75.342419] 
> > [   75.345517] Allocated by task 4527:
> > [   75.345517]  kasan_save_stack+0x22/0x40
> > [   75.345517]  kasan_save_track+0x14/0x30
> > [   75.345517]  __kasan_slab_alloc+0x6e/0x70
> > [   75.345517]  kmem_cache_alloc_noprof+0x14c/0x400
> > [   75.345517]  btrfs_get_or_create_delayed_node+0x9e/0x9e0
> > [   75.345517]  btrfs_insert_delayed_dir_index+0xe4/0x8a0
> > [   75.345517]  btrfs_insert_dir_item+0x4c1/0x720
> > [   75.345517]  btrfs_add_link+0x173/0xa30
> > [   75.345517]  btrfs_create_new_inode+0x1551/0x2650
> > [   75.345517]  btrfs_create_common+0x17b/0x200
> > [   75.345517]  vfs_mknod+0x3a7/0x600
> > [   75.345517]  do_mknodat+0x34e/0x520
> > [   75.345517]  __x64_sys_mknodat+0xaa/0xe0
> > [   75.345517]  do_syscall_64+0x50/0xfa0
> > [   75.345517]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   75.345517] 
> > [   75.345517] Freed by task 4493:
> > [   75.345517]  kasan_save_stack+0x22/0x40
> > [   75.345517]  kasan_save_track+0x14/0x30
> > [   75.345517]  __kasan_save_free_info+0x3b/0x70
> > [   75.345517]  __kasan_slab_free+0x43/0x70
> > [   75.345517]  kmem_cache_free+0x172/0x610
> > [   75.345517]  btrfs_kill_all_delayed_nodes+0x2db/0x4c0
> > [   75.345517]  btrfs_clean_one_deleted_snapshot+0x143/0x370
> > [   75.345517]  cleaner_kthread+0x1ee/0x300
> > [   75.345517]  kthread+0x37f/0x6f0
> > [   75.345517]  ret_from_fork+0x17d/0x240
> > [   75.345517]  ret_from_fork_asm+0x1a/0x30
> > [   75.345517] 
> > [   75.345517] The buggy address belongs to the object at ffff88812389f370
> > [   75.345517]  which belongs to the cache btrfs_delayed_node of size 440
> > [   75.345517] The buggy address is located 16 bytes inside of
> > [   75.345517]  freed 440-byte region [ffff88812389f370, ffff88812389f528)
> > [   75.345517] 
> > [   75.345517] The buggy address belongs to the physical page:
> > [   75.345517] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12389e
> > [   75.345517] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > [   75.345517] flags: 0x4000000000000040(head|zone=2)
> > [   75.345517] page_type: f5(slab)
> > [   75.345517] raw: 4000000000000040 ffff88810bcaadc0 ffffea0004487a10 ffff88810c6e6d80
> > [   75.345517] raw: 0000000000000000 00000000000e000e 00000000f5000000 0000000000000000
> > [   75.345517] head: 4000000000000040 ffff88810bcaadc0 ffffea0004487a10 ffff88810c6e6d80
> > [   75.345517] head: 0000000000000000 00000000000e000e 00000000f5000000 0000000000000000
> > [   75.345517] head: 4000000000000001 ffffea00048e2781 00000000ffffffff 00000000ffffffff
> > [   75.345517] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
> > [   75.345517] page dumped because: kasan: bad access detected
> > [   75.345517] 
> > [   75.345517] Memory state around the buggy address:
> > [   75.345517]  ffff88812389f280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > [   75.345517]  ffff88812389f300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fa fb
> > [   75.345517] >ffff88812389f380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > [   75.345517]                    ^
> > [   75.345517]  ffff88812389f400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > [   75.345517]  ffff88812389f480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > [   75.345517] ==================================================================
> > [   75.501545] Disabling lock debugging due to kernel taint
> > 
> > 
> > gdb) l *(btrfs_kill_all_delayed_nodes+0x46f)
> > 0xffffffff82f2422f is in btrfs_kill_all_delayed_nodes (fs/btrfs/delayed-inode.h:219).
> > 214		ref_tracker_dir_exit(&node->ref_dir.dir);
> > 215	}
> > 216	
> > 217	static inline void btrfs_delayed_node_ref_tracker_dir_print(struct btrfs_delayed_node *node)
> > 218	{
> > 219		if (!btrfs_test_opt(node->root->fs_info, REF_TRACKER))
> > 220			return;
> > 221	
> > 222		ref_tracker_dir_print(&node->ref_dir.dir,
> > 223				      BTRFS_DELAYED_NODE_REF_TRACKER_DISPLAY_LIMIT);
> 
> This is a use after free bug with my ref_tracker patch, it's trying to print delayed_node ref_tracker
> stats after the delayed node has been freed. Will send a fix in a second.

I wasn't able to reproduce the crash by running btrfs/071. I sent out a fix,
if you have time it would be great if you could check it against your reproducer.

Link: https://lore.kernel.org/linux-btrfs/e5d6dd45f720f2543ca4ea7ee3e66454ef55f639.1761001854.git.loemra.dev@gmail.com/T/#u

