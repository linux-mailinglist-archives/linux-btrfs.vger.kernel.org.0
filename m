Return-Path: <linux-btrfs+bounces-21823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CpQChR3m2mzzwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21823-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 22:37:24 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8984F17077B
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 22:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7014301455C
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 21:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C61335C18D;
	Sun, 22 Feb 2026 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUzPV+5k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0377B1FB1
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771796223; cv=none; b=OXy4yOsZAUzmK8CTDB4bAiqp2hKVigIrSof8D0K62d2daUxQ+qr4ieLeNCt411M+Z1XW1lHBOVKZar5IgJ9nS0jEEmX5BLi/i9Mqrv6a++7ujXTpTHPHWl/Plnl8BS3BFjjBhX1AcmhIbUm0xCrTU0EFUv4uIA+Pid2oxIxLfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771796223; c=relaxed/simple;
	bh=h+OEpoBBa1ADH57BXePsw6Vi9bn8KecLwOhRCWkEW3w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=epd0soIgHxORw05DNiKYHyd9w0d6BvnCbb70nbU3os2SbLkIbQz2/hj8929ePUM9EkH47nIrjgMq94Pisc9Y4mqDdK/CEz+5UYuD599xn6GI8b/HJ4xT0Um3wtDIuukn78xWYS1TtYucM33c8LniCgXh8Rrn6aaEhMvhifZOjDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUzPV+5k; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4833115090dso35308935e9.3
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 13:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771796220; x=1772401020; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYcB3zGjT8GKDiCMJj3SvE8SHtPoZo7cQxEGocwC61o=;
        b=hUzPV+5kP41ic0hFjBKMRMNEopiXOVuYKbttNskFGF61KUu+gXQGBogeZPhC5jZukk
         Od1lKUkaKRhHpcLAnNAylIgrv0aNYvEdzOFDHgWBvD13uJ4g/IEIWrzE+uwomtaP/Fgd
         7b5+nM0yajVCuob6aRft95nNrpWr2BOzEZTfFa/i2uhG54JxJ2moxVKm6sHFHT2ZLxap
         +qCeh2DYOoFF6U+ByS4z2nWkD5ajco9AzyJ8ahFuCCNRbGVHtB5x5QbiZzPaT0jw7DRp
         iC76Kk3ZBWMvnRLaPQoUQqDjLj0ZpfEs77J4kQPqYH2HWXex/25u4KvKPLn3LwuzIe2m
         VbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771796220; x=1772401020;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYcB3zGjT8GKDiCMJj3SvE8SHtPoZo7cQxEGocwC61o=;
        b=TijJSPVQROn49jGgDRN39+hJEEPf043/+SU3Ogcg0i/MFsEH8lwAM/meyUdHFa+xOw
         kESw7nbmZaJHs9zx026+5yjkxIGq5tCJ7eqRYcz5+CAqXvo7sAu/geIuXEdVLfsIIauU
         uzn4YqhjoISEbP8tHtQcjSQvtjT1Z99VNoEWAabKdTHKOjwJ95fcfDcRhbJu7aufY+jw
         o4ezQw1i3dRNt1wZbL8joghDFc4zNZOybBU3IPK8aFQel4rXcOwNa1PASe4iCKFnirag
         Rh8rdhoEB6GNwsW2YBIGbP/ZRjA0I/UQHZhh1JASzsPnV/629yYkVTPrHRxb6QBkN8yA
         A+lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQkZU+yxDhueb3EVf5cCAkRQDAIsl7RB2tQ4NVR+Qcnj3+Cu0UMozUJdXCCxNctTz2bUTHym5ymy2q0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQbvyYvpVGwxVl1//VASuJqtORpUPZmjJitGvWFYJVn2cGz0Ha
	8PUf4lg7STDxQwWkBWpe9qYnoNpXDXZtxUR//AEjTGsOfjnZyDKi2kn9
X-Gm-Gg: AZuq6aIk03ofp27suwBlFhutei/izZkFvafQX78KPRzVjzTqYCr5edugx2ckVnla+ZL
	bPlw74Vk3Jc+xSsA1p+7VhpOec/8rs/sOQFIFa5VrzvrUkt60SeCE8/jh6JxMagOZdRWrRixmLP
	R9tNTvF/yNwRKnb/6ftFuvU2c4cpqyAll3HT+iV5mBQ++NEwZnsuQYR72r37Tgn/4TraXP03Uxs
	nDtzLw6OdkmrSEkRIiKdMLv9beddX8WNqhgnivgWq3K0vMFWqA03L/+vp3jGbR4PQ/H1Mh07EDu
	+UbKILLYP7eELUrNsvD+EhRWFWwqUT9Y6mZtwmtpsh92d3FisJn3r2A3uC45rSB9Ma+VMVlU2SM
	Hp/ToR4cMKA4q30Nxs9aYeNeCmFVy4b82qH4oJugTjWl8Vq49xuwnU3la90luz0Q/IjmhBfrqYp
	pyuyNx7c7UggbFE+FN2h0GBT7bdX1i792Tdteqm4Fr5g==
X-Received: by 2002:a05:600c:4e02:b0:482:ef72:5781 with SMTP id 5b1f17b1804b1-483a95f5843mr112802835e9.25.1771796220150;
        Sun, 22 Feb 2026 13:37:00 -0800 (PST)
Received: from debian.local ([90.243.35.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a316eb08sm246605715e9.0.2026.02.22.13.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 13:36:59 -0800 (PST)
Date: Sun, 22 Feb 2026 21:36:58 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: vbabka@suse.cz
Cc: surenb@google.com, harry.yoo@oracle.com, hao.li@linux.dev,
	leitao@debian.org, Liam.Howlett@oracle.com, zhao1.liu@intel.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-btrfs@vger.kernel.org, regressions@lists.linux.dev
Subject: [REGRESSION] kswapd0: page allocation failure (bisected to "slab:
 add sheaves to most caches")
Message-ID: <aZt2-oS9lkmwT7Ch@debian.local>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21823-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisbainbridge@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,debian.local:mid]
X-Rspamd-Queue-Id: 8984F17077B
X-Rspamd-Action: no action

Hi,

The latest mainline kernel (v6.19-11831-ga95f71ad3e2e) has page
allocation failures when doing things like compiling a kernel. I can
also reproduce this with a stress test like
`stress-ng --vm 2 --vm-bytes 110% --verify -v`


[  104.032925] kswapd0: page allocation failure: order:0, mode:0xc0c40(GFP_NOFS|__GFP_COMP|__GFP_NOMEMALLOC), nodemask=(null),cpuset=/,mems_allowed=0
[  104.033307] CPU: 4 UID: 0 PID: 156 Comm: kswapd0 Not tainted 6.19.0-rc5-00027-g40fd0acc45d0 #435 PREEMPT(voluntary) 
[  104.033312] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
[  104.033314] Call Trace:
[  104.033316]  <TASK>
[  104.033319]  dump_stack_lvl+0x6a/0x90
[  104.033328]  warn_alloc.cold+0x95/0x1af
[  104.033334]  ? zone_watermark_ok+0x80/0x80
[  104.033350]  __alloc_frozen_pages_noprof+0xec3/0x2470
[  104.033353]  ? __lock_acquire+0x489/0x2600
[  104.033359]  ? stack_access_ok+0x1c0/0x1c0
[  104.033367]  ? warn_alloc+0x1d0/0x1d0
[  104.033371]  ? __lock_acquire+0x489/0x2600
[  104.033375]  ? _raw_spin_unlock_irqrestore+0x48/0x60
[  104.033379]  ? _raw_spin_unlock_irqrestore+0x48/0x60
[  104.033382]  ? lockdep_hardirqs_on+0x78/0x100
[  104.033394]  allocate_slab+0x2b7/0x510
[  104.033399]  refill_objects+0x25d/0x380
[  104.033407]  __pcs_replace_empty_main+0x193/0x5f0
[  104.033412]  kmem_cache_alloc_noprof+0x5b6/0x6f0
[  104.033415]  ? alloc_extent_state+0x1b/0x210 [btrfs]
[  104.033479]  alloc_extent_state+0x1b/0x210 [btrfs]
[  104.033527]  btrfs_clear_extent_bit_changeset+0x2be/0x9c0 [btrfs]
[  104.033575]  btrfs_clear_record_extent_bits+0x10/0x20 [btrfs]
[  104.033615]  btrfs_qgroup_check_reserved_leak+0xbd/0x2b0 [btrfs]
[  104.033659]  ? lock_release+0x17b/0x2a0
[  104.033663]  ? btrfs_qgroup_convert_reserved_meta+0xe90/0xe90 [btrfs]
[  104.033703]  ? do_raw_spin_unlock+0x54/0x1e0
[  104.033707]  ? _raw_spin_unlock+0x29/0x40
[  104.033710]  ? btrfs_lookup_first_ordered_extent+0x1d4/0x370 [btrfs]
[  104.033762]  ? preempt_count_add+0x73/0x140
[  104.033768]  btrfs_destroy_inode+0x301/0x6a0 [btrfs]
[  104.033820]  ? __destroy_inode+0x194/0x570
[  104.033826]  destroy_inode+0xb9/0x190
[  104.033830]  evict+0x4d8/0x900
[  104.033832]  ? lock_release+0x17b/0x2a0
[  104.033835]  ? find_held_lock+0x2b/0x80
[  104.033839]  ? destroy_inode+0x190/0x190
[  104.033842]  ? __list_lru_walk_one+0x30d/0x440
[  104.033849]  ? _raw_spin_unlock+0x29/0x40
[  104.033851]  ? __list_lru_walk_one+0x30d/0x440
[  104.033854]  ? __wait_on_freeing_inode+0x2a0/0x2a0
[  104.033860]  dispose_list+0xf0/0x1b0
[  104.033866]  prune_icache_sb+0xde/0x150
[  104.033869]  ? list_lru_count_one+0x13f/0x270
[  104.033873]  ? dump_mapping+0x250/0x250
[  104.033875]  ? lock_release+0x17b/0x2a0
[  104.033882]  super_cache_scan+0x302/0x4d0
[  104.033889]  do_shrink_slab+0x32e/0xd30
[  104.033898]  shrink_slab+0x7b6/0xda0
[  104.033902]  ? shrink_slab+0x4b1/0xda0
[  104.033908]  ? reparent_shrinker_deferred+0x330/0x330
[  104.033914]  ? trace_event_raw_event_sched_switch+0x410/0x410
[  104.033921]  shrink_node+0xac4/0x36e0
[  104.033933]  ? lru_gen_release_memcg+0x3c0/0x3c0
[  104.033940]  ? pgdat_balanced+0x15f/0x4b0
[  104.033943]  ? __cond_resched+0x23/0x30
[  104.033950]  ? balance_pgdat+0x739/0x1530
[  104.033952]  balance_pgdat+0x739/0x1530
[  104.033960]  ? shrink_node+0x36e0/0x36e0
[  104.033962]  ? __timer_delete_sync+0x177/0x240
[  104.033966]  ? __timer_delete_sync+0x177/0x240
[  104.033970]  ? _raw_spin_unlock_irqrestore+0x48/0x60
[  104.033975]  ? __lock_acquire+0x489/0x2600
[  104.033979]  ? call_timer_fn+0x3b0/0x3b0
[  104.033981]  ? schedule+0x2ba/0x390
[  104.033990]  ? lock_is_held_type+0xd5/0x130
[  104.033997]  ? kswapd+0x364/0x7f0
[  104.034004]  kswapd+0x445/0x7f0
[  104.034010]  ? balance_pgdat+0x1530/0x1530
[  104.034013]  ? _raw_spin_unlock_irqrestore+0x48/0x60
[  104.034016]  ? finish_wait+0x280/0x280
[  104.034022]  ? __kthread_parkme+0xb4/0x200
[  104.034027]  ? balance_pgdat+0x1530/0x1530
[  104.034029]  kthread+0x3ad/0x760
[  104.034033]  ? kthread_is_per_cpu+0xb0/0xb0
[  104.034035]  ? ret_from_fork+0x70/0x850
[  104.034039]  ? ret_from_fork+0x70/0x850
[  104.034042]  ? _raw_spin_unlock_irq+0x24/0x50
[  104.034045]  ? kthread_is_per_cpu+0xb0/0xb0
[  104.034049]  ret_from_fork+0x6dc/0x850
[  104.034053]  ? exit_thread+0x70/0x70
[  104.034057]  ? __switch_to+0x36f/0xd80
[  104.034061]  ? kthread_is_per_cpu+0xb0/0xb0
[  104.034065]  ret_from_fork_asm+0x11/0x20
[  104.034077]  </TASK>
[  104.034078] Mem-Info:
[  104.034111] active_anon:511 inactive_anon:2355672 isolated_anon:0
                active_file:77595 inactive_file:204731 isolated_file:0
                unevictable:7150 dirty:925 writeback:57
                slab_reclaimable:20227 slab_unreclaimable:201840
                mapped:121227 shmem:10197 pagetables:9634
                sec_pagetables:733 bounce:0
                kernel_misc_reclaimable:0
                free:36223 free_pcp:529 free_cma:0
[  104.034119] Node 0 active_anon:2044kB inactive_anon:9422688kB active_file:310380kB inactive_file:818924kB unevictable:28600kB isolated(anon):0kB isolated(file):0kB mapped:484908kB dirty:3700kB writeback:228kB shmem:40788kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:8534016kB kernel_stack:31616kB pagetables:38536kB sec_pagetables:2932kB all_unreclaimable? no Balloon:0kB
[  104.034126] Node 0 DMA free:13316kB boost:0kB min:84kB low:104kB high:124kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zspages:0kB present:15996kB managed:15364kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[  104.034135] lowmem_reserve[]: 0 2862 11990 11990 11990
[  104.034147] Node 0 DMA32 free:52184kB boost:0kB min:15860kB low:19824kB high:23788kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:2871780kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zspages:0kB present:2997084kB managed:2931416kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[  104.034155] lowmem_reserve[]: 0 0 9127 9127 9127
[  104.034166] Node 0 Normal free:79392kB boost:28672kB min:80308kB low:93216kB high:106124kB reserved_highatomic:2048KB free_highatomic:32KB active_anon:2044kB inactive_anon:6550896kB active_file:310380kB inactive_file:818924kB unevictable:28600kB writepending:4252kB zspages:0kB present:13077504kB managed:9346788kB mlocked:28600kB bounce:0kB free_pcp:2116kB local_pcp:0kB free_cma:0kB
[  104.034174] lowmem_reserve[]: 0 0 0 0 0
[  104.034185] Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 2*2048kB (UM) 2*4096kB (M) = 13316kB
[  104.034308] Node 0 DMA32: 3*4kB (U) 5*8kB (UM) 5*16kB (UM) 8*32kB (UM) 11*64kB (UM) 15*128kB (UM) 11*256kB (UM) 9*512kB (UM) 9*1024kB (UM) 0*2048kB 8*4096kB (UM) = 52420kB
[  104.034348] Node 0 Normal: 1024*4kB (UMEH) 534*8kB (UEH) 409*16kB (UME) 1301*32kB (UME) 154*64kB (UME) 39*128kB (UME) 14*256kB (UM) 1*512kB (U) 2*1024kB (UM) 1*2048kB (U) 0*4096kB = 79584kB
[  104.034390] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[  104.034393] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[  104.034396] 299766 total pagecache pages
[  104.034398] 0 pages in swap cache
[  104.034401] Free swap  = 8387580kB
[  104.034403] Total swap = 8387580kB
[  104.034405] 4022646 pages RAM
[  104.034407] 0 pages HighMem/MovableOnly
[  104.034410] 949254 pages reserved
[  104.034412] 0 pages hwpoisoned


The page allocation failures bisect to:

e47c897a29491ade20b27612fdd3107c39a07357 slab: add sheaves to most caches

#regzbot introduced: e47c897a29491ade20b27612fdd3107c39a07357
#regzbot title: kswapd0: page allocation failure

