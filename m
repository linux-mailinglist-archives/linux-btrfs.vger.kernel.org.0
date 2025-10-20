Return-Path: <linux-btrfs+bounces-18072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB96BF2904
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 18:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF20342632F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9B32F76D;
	Mon, 20 Oct 2025 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+7HNRRX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE40275105
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979319; cv=none; b=WMWbn64CdU8byV8oGUZdLBS+sXjD9ehYMW+uPbD9urGtM/2nVdoq8rUodVqG5z2vUq8MKXoFoJJZvg0UOzdgcUs7+udMrvWPYl5Skk/LsuSiVIsT51R2VO6RwuyQMRFktCvO2RbPXhSfdgYzgC9ax3M0c+5+jbXeaH+51Q7cd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979319; c=relaxed/simple;
	bh=sj8Ha+PaHudrw+RxWgiG/cOSxOluNy8tlYGNsr6XkQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9V2UYUCAboKqHMz95EjfGOI6wx2nDp3AEALOJGA1PniAuuw2ZEWSfHJX8BSu7vRo47fJUDRoeLJMDxc8cWSwlezGNJ7LNTm15Vj90D9Tl0ma8HbwPpoOpc7G0c9zF2IndwMgxTNR32kxx3mQ2GIhxHtzT4PvGuXw6EgJqfqI2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+7HNRRX; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-63e19642764so3289708d50.1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760979316; x=1761584116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baogYE/pJxur92rQFsMIOoWneZpU9ddUJMMY8yB8enE=;
        b=m+7HNRRXXwGu85uJGrMAITvhDkNPenkrlgDCpO6L99I4YHcP994u397ISIWGfVgTc6
         v94BoxvqYV3f2EUU0TbYQbW8kC3AFhiciXmxLpoO4Mq71Hi6q3ll7IzubRw2YjKRR4bS
         2JHp+OOoA8bW7KdNk2zyKUkIO/gUU9kZ5miv4/tgAXa/1dsrlEk45wQtsRIrbqma16Hr
         gDp/2qQ129ejtlawB7MI4rpMoRC7OWR/2gr3wsfr1ByFEoSdZj5hi1Bxyv4WmECaPZru
         6eHvwxbbwUOIUDc14xq1wEiTh9hv8pgKm2chRYsPkTSezvLeAOiBIINR3Ox0UdbyUey0
         nSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979316; x=1761584116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baogYE/pJxur92rQFsMIOoWneZpU9ddUJMMY8yB8enE=;
        b=SfKKZEQP/vXxEAEGZPpo2ga1KS5bpzB9c1PlS7/LkNlPozpyfzn05WxljN8M+BKMEu
         5wm1fqGUSJEfyqVQNzlobIGKF3QXk1Ny3AEMQov2RO/AG/kl0KUmj3HRhm23xUrvADeb
         +EtsWfiGxBgPSo44Q04nIaqOU30n/5vDtO4aLtyPu9/wfe0xsBRy2F8zTngfzf6o+0aB
         cge92z2YEge7LZkz8XQDjmiu9J36KiWbYLdHgm3TIZfZ+/O5/HAh5gNQxx0ctGZL+/11
         ND4HI6QrGsVBvwRsJpehNrDKi/J960LnMBrkVqGF1z5yG78nsrW5xviM6mwJsDKNDeYN
         n90A==
X-Forwarded-Encrypted: i=1; AJvYcCU2RXVCMlk1CwfE0d/OZ2aSbetZ4INdJY3N+MK2UeHEmAzN65aU7Fch4Edyp2MWDfTt04OhTMdDOg8PVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YypfVry3pqd4KlczUwj9JvQjkl/JEqKQ6/7LBC82ERG+vpbiBs8
	JJ69U5n33Jf7o5yRR1AUblN/L04PgZzXlVgk3h0pElPw7ShISQpqyuqt
X-Gm-Gg: ASbGncv9kaJTPRruHzZm+rFzMdkxLL1yZ5zXl6CK/P1xZBlsresW1YyxUq6iKJDShzd
	MdKM1HwJWmCrn5qJArDdf380dl6wBPzJk/lh57Bupf5kgAAmzkvmHMdOHdgw/k4nqF1VNTaOJ/0
	MUK1O2M3b/LvnIMASR1qfPtiJShCGpY92J0iN4wDJn1Uj0DYwol8hvIcXRtC2bYgXWOQQrQjB0N
	E9A/KnSe7WJY3nNln1Kv3xEHoLXIEyHwSIKG+3KSDSq9lQqcWVNFBQsZBwZVhGSgj+WzWm+sY9M
	tP0qnrTUPMYvfG1FYSnxBdlyIN5lHL6AJu7mD5Y/tw7PSaAbipVGyAiqtZ6IYEiOuToHyJ5ywgQ
	iu/C4qoQGjT0xrHnhhdWH7cpp43GN6XyKDWY8M7E45RRhlkCSCI1d3YLx/+xWtKyGPJesIuhAYD
	2YI+MTzA==
X-Google-Smtp-Source: AGHT+IFPRN8rlOxQGn7biHmvtlUZcnH+GYslXMqDpWWbpylMcFLpjgSgGmNV/JqmNUfDlWI3Q6z9gA==
X-Received: by 2002:a53:acc2:0:10b0:63e:1ca0:be6e with SMTP id 956f58d0204a3-63e1ca0c087mr7164181d50.0.1760979316426;
        Mon, 20 Oct 2025 09:55:16 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63e267c60f8sm2506939d50.16.2025.10.20.09.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:55:16 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: btrfs/071 is unhappy on 6.18-rc2
Date: Mon, 20 Oct 2025 09:55:10 -0700
Message-ID: <20251020165512.3843091-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aPZE--T-nj0dKB0A@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Oct 2025 07:19:39 -0700 Christoph Hellwig <hch@infradead.org> wrote:

> KASAN output:
> 
> [   75.341543] ==================================================================
> [   75.341824] BUG: KASAN: slab-use-after-free in btrfs_kill_all_delayed_nodes+0x46f/0x4c0
> [   75.342082] Read of size 8 at addr ffff88812389f380 by task btrfs-cleaner/4493
> [   75.342310] 
> [   75.342369] CPU: 1 UID: 0 PID: 4493 Comm: btrfs-cleaner Tainted: G                 N  6.18.0-rc2+ #4115 PREEMPT(f 
> [   75.342372] Tainted: [N]=TEST
> [   75.342373] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   75.342374] Call Trace:
> [   75.342375]  <TASK>
> [   75.342376]  dump_stack_lvl+0x4b/0x70
> [   75.342379]  print_report+0x174/0x4e7
> [   75.342382]  ? __virt_addr_valid+0x1bb/0x2f0
> [   75.342384]  ? btrfs_kill_all_delayed_nodes+0x46f/0x4c0
> [   75.342385]  kasan_report+0xd2/0x100
> [   75.342387]  ? btrfs_kill_all_delayed_nodes+0x46f/0x4c0
> [   75.342388]  btrfs_kill_all_delayed_nodes+0x46f/0x4c0
> [   75.342389]  ? _raw_spin_unlock+0x13/0x30
> [   75.342392]  ? __pfx_btrfs_kill_all_delayed_nodes+0x10/0x10
> [   75.342393]  ? do_raw_spin_lock+0x128/0x260
> [   75.342395]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [   75.342397]  ? list_lru_add_obj+0xfb/0x1a0
> [   75.342399]  ? do_raw_spin_lock+0x128/0x260
> [   75.342401]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [   75.342402]  btrfs_clean_one_deleted_snapshot+0x143/0x370
> [   75.342405]  cleaner_kthread+0x1ee/0x300
> [   75.342406]  ? __pfx_cleaner_kthread+0x10/0x10
> [   75.342407]  kthread+0x37f/0x6f0
> [   75.342409]  ? __pfx_kthread+0x10/0x10
> [   75.342411]  ? __pfx_kthread+0x10/0x10
> [   75.342412]  ? __pfx_kthread+0x10/0x10
> [   75.342413]  ret_from_fork+0x17d/0x240
> [   75.342415]  ? __pfx_kthread+0x10/0x10
> [   75.342416]  ret_from_fork_asm+0x1a/0x30
> [   75.342419]  </TASK>
> [   75.342419] 
> [   75.345517] Allocated by task 4527:
> [   75.345517]  kasan_save_stack+0x22/0x40
> [   75.345517]  kasan_save_track+0x14/0x30
> [   75.345517]  __kasan_slab_alloc+0x6e/0x70
> [   75.345517]  kmem_cache_alloc_noprof+0x14c/0x400
> [   75.345517]  btrfs_get_or_create_delayed_node+0x9e/0x9e0
> [   75.345517]  btrfs_insert_delayed_dir_index+0xe4/0x8a0
> [   75.345517]  btrfs_insert_dir_item+0x4c1/0x720
> [   75.345517]  btrfs_add_link+0x173/0xa30
> [   75.345517]  btrfs_create_new_inode+0x1551/0x2650
> [   75.345517]  btrfs_create_common+0x17b/0x200
> [   75.345517]  vfs_mknod+0x3a7/0x600
> [   75.345517]  do_mknodat+0x34e/0x520
> [   75.345517]  __x64_sys_mknodat+0xaa/0xe0
> [   75.345517]  do_syscall_64+0x50/0xfa0
> [   75.345517]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   75.345517] 
> [   75.345517] Freed by task 4493:
> [   75.345517]  kasan_save_stack+0x22/0x40
> [   75.345517]  kasan_save_track+0x14/0x30
> [   75.345517]  __kasan_save_free_info+0x3b/0x70
> [   75.345517]  __kasan_slab_free+0x43/0x70
> [   75.345517]  kmem_cache_free+0x172/0x610
> [   75.345517]  btrfs_kill_all_delayed_nodes+0x2db/0x4c0
> [   75.345517]  btrfs_clean_one_deleted_snapshot+0x143/0x370
> [   75.345517]  cleaner_kthread+0x1ee/0x300
> [   75.345517]  kthread+0x37f/0x6f0
> [   75.345517]  ret_from_fork+0x17d/0x240
> [   75.345517]  ret_from_fork_asm+0x1a/0x30
> [   75.345517] 
> [   75.345517] The buggy address belongs to the object at ffff88812389f370
> [   75.345517]  which belongs to the cache btrfs_delayed_node of size 440
> [   75.345517] The buggy address is located 16 bytes inside of
> [   75.345517]  freed 440-byte region [ffff88812389f370, ffff88812389f528)
> [   75.345517] 
> [   75.345517] The buggy address belongs to the physical page:
> [   75.345517] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12389e
> [   75.345517] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [   75.345517] flags: 0x4000000000000040(head|zone=2)
> [   75.345517] page_type: f5(slab)
> [   75.345517] raw: 4000000000000040 ffff88810bcaadc0 ffffea0004487a10 ffff88810c6e6d80
> [   75.345517] raw: 0000000000000000 00000000000e000e 00000000f5000000 0000000000000000
> [   75.345517] head: 4000000000000040 ffff88810bcaadc0 ffffea0004487a10 ffff88810c6e6d80
> [   75.345517] head: 0000000000000000 00000000000e000e 00000000f5000000 0000000000000000
> [   75.345517] head: 4000000000000001 ffffea00048e2781 00000000ffffffff 00000000ffffffff
> [   75.345517] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
> [   75.345517] page dumped because: kasan: bad access detected
> [   75.345517] 
> [   75.345517] Memory state around the buggy address:
> [   75.345517]  ffff88812389f280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   75.345517]  ffff88812389f300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fa fb
> [   75.345517] >ffff88812389f380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   75.345517]                    ^
> [   75.345517]  ffff88812389f400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   75.345517]  ffff88812389f480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   75.345517] ==================================================================
> [   75.501545] Disabling lock debugging due to kernel taint
> 
> 
> gdb) l *(btrfs_kill_all_delayed_nodes+0x46f)
> 0xffffffff82f2422f is in btrfs_kill_all_delayed_nodes (fs/btrfs/delayed-inode.h:219).
> 214		ref_tracker_dir_exit(&node->ref_dir.dir);
> 215	}
> 216	
> 217	static inline void btrfs_delayed_node_ref_tracker_dir_print(struct btrfs_delayed_node *node)
> 218	{
> 219		if (!btrfs_test_opt(node->root->fs_info, REF_TRACKER))
> 220			return;
> 221	
> 222		ref_tracker_dir_print(&node->ref_dir.dir,
> 223				      BTRFS_DELAYED_NODE_REF_TRACKER_DISPLAY_LIMIT);

This is a use after free bug with my ref_tracker patch, it's trying to print delayed_node ref_tracker
stats after the delayed node has been freed. Will send a fix in a second.


