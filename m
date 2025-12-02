Return-Path: <linux-btrfs+bounces-19442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03979C99AD8
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 01:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 330A63450B0
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 00:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7841AAE17;
	Tue,  2 Dec 2025 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqtqkQOg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E211FD4
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764636713; cv=none; b=TVHXuGsKqEsExg/ueVPw8l/MM6Ac4Ng6M1XVFfPQU64FcnsG6GyYGtLy7cFyUCd31BpNzsRm5XOYZsfk3LoHXUPyoooRXuqydCj0+b6ckLTWWihxaF9kkFMT+ncQGx5atYx5K0rJ0CctjzT6TNhA337s4HNMp9PH+Ae7EO2jZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764636713; c=relaxed/simple;
	bh=6edQxffvF4UyMBaQ9uyOb0pLg4HLk7JhkBX1GSxj9Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F26KtHBFFyBRkP4U/3l2vwl9MwuVY/3TO3i7ACb5UJeHsoJj74n34BzhPto9+zqGcSCrls4ai+KloPHs/64QKKYi2/GtB4+ECikaU2rM3ZTugCAXfL//CACNdjtNzMdwxLNhE3Fd6SdXEbCTJ8kEK3zfOfH2Cc5Y7a1TYlhl2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqtqkQOg; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-640d790d444so4060800d50.0
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Dec 2025 16:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764636710; x=1765241510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw4llkamKQGy9EEOzB2HCnc6Q6LrGhDG7WsSasDgkxc=;
        b=YqtqkQOgyjixwyWA6iISMyJlBYQ2rRFG80tgruJz+ttZXnC8F25QDZHbss/T3TO0TX
         KdK2SMEPNxt8pl7NQTCB7ecVJ8+92eoDT0fOsl/2riahSR2SHqnPHRFz7cBnKbQYF+GJ
         K1jswpRn7ZfPA3S9EZdJpL72XYcJYnzyZHuDfNkWdZ4h/+T5jhOFVFCafMK+eTUU5Ygc
         x9jJTvKzRvIbZw7rcJpVA+mvEMZEaZdwHJx8kJFuwaXxqaYAeoNWm8zBNH5LUjFaUcsi
         FsFbfp/j1OnMBTRLKDAKSH6lwwoVIz0vfiMTwZSqesCMqqwMJZDBJ0Fixb/Y1uAoEmk9
         uqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764636710; x=1765241510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sw4llkamKQGy9EEOzB2HCnc6Q6LrGhDG7WsSasDgkxc=;
        b=phyNoVZY+ZV12lSJFIVHQ52i4aUwrD8wyRuuru/i0Pfvn7d4tGB3Xo75aU86Scwp91
         57ReoludzCEVLAukSHHC8fkjg4rJVQh/VXCsMD+uk36Z2xDYo68xKL4L6eF6zmHpruqs
         T3Q2lBcExVznmLbd06t51OpIpLYY+nUF6PdWxuYRbIqzPVTy3LMj7Ts9WEHwOxQ6KNGg
         AtJXXDHYB1oeOE6MDC754XgbOig4KMpsz6uJN1mocgKlN3MOAhee1U7suNXY8N3b7nIy
         rXLgv1uz7xD2DoGpQJbIKHHlUu33JsO6m5cMXMUpLfKlUIjfiehMlVlboLn6w0fhekdy
         uLVw==
X-Forwarded-Encrypted: i=1; AJvYcCW4rXOM7xAoAJUXt6k/zg24EZ2dK2BjELfO28HmxWCztUtIRRTkVnBeO+223XrsSNrTTEokbocO8c9v2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHoY5xfPAIp8qEnHyx7/tmcUOWPkbS0a4hopqL+VH1qhKm4DDu
	Sr9TqQiyxsLopqxiAQclKaNyq/7T40OYeotxb8gr0F07aCe8VWM+K+NH
X-Gm-Gg: ASbGncsxoSQS4zlpaUyy6ktO0KzlDuHUHouTCVI4AHaZyzg4zcnWP5aOXacmGm1IVjZ
	aMjVeQ81CPGeV0exaSFfyxE/vdShsP4dbc2nevmh1uKnNeHH2zb6ol/ZDKQmFPv0nv4HkpsmX8N
	DQvklJezSw3rGWpmmhzUFHGsBl6OaSj+2tFs5lH+Pt0SqFTX58od2FcxfBoSRCbh0Mv+b6EvCqt
	J0fp5RZCS2WQw+BvnSB9tKQmmndbicj7GV5gFHTa7Gf4m4kPfyYm+Jfa5aNbE7V/24trwOxPBLC
	ast6LvF0cTd1w2T/N3QxZEIkussHnXhMzBP0rif18MIswnbqAqOlTOWn3vKbDa1yYBf0G7n9Pz8
	Fd35QeYuIuQkcLu5ultu4+bxkXVF9hMyEjYg0kx59fDnDyNY1i7XFIFW365YG9WKZsnNpP0zY5L
	VOHC5Gil18EgXTE3ZPWhnuW23HQ4M=
X-Google-Smtp-Source: AGHT+IFLZZeOr+0GiYq7jqrzjZRrnQEzcSy9Bi5f8cLEJxba6K44yWPBtHueyhU+P/t9YpCsgNrCEA==
X-Received: by 2002:a05:690e:1688:b0:63f:b634:5b3c with SMTP id 956f58d0204a3-6430296c57bmr31214283d50.0.1764636709988;
        Mon, 01 Dec 2025 16:51:49 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d42041sm56941477b3.2.2025.12.01.16.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 16:51:49 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev,
	lkp@intel.com,
	linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [linus:master] [btrfs]  e8513c012d: addition_on#;use-after-free
Date: Mon,  1 Dec 2025 16:51:41 -0800
Message-ID: <20251202005146.3723457-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202511262228.6dda231e-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 26 Nov 2025 22:23:21 +0800 kernel test robot <oliver.sang@intel.com> wrote:

> 
> 
> Hello,
> 
> kernel test robot noticed "addition_on#;use-after-free" on:
> 
> commit: e8513c012de75fd65e2df5499572bc6ef3f6e409 ("btrfs: implement ref_tracker for delayed_nodes")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on      linus/master 30f09200cc4aefbd8385b01e41bde2e4565a6f0e]
> [test failed on linux-next/master 92fd6e84175befa1775e5c0ab682938eca27c0b2]
> 
> in testcase: blogbench
> version: blogbench-x86_64-1.2-1_20251009
> with following parameters:
> 
> 	disk: 1SSD
> 	fs: btrfs
> 	cpufreq_governor: performance
> 
> 
> 
> config: x86_64-rhel-9.4
> compiler: gcc-14
> test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 176G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.com
> 
> 
> [   92.359770][ T1319] ------------[ cut here ]------------
> [   92.365399][ T2115]       1513       283338         42318        194834         39930        140043         83712
> [   92.365683][ T1319] refcount_t: addition on 0; use-after-free.
> [   92.371060][ T2115]
> [   92.381336][ T1319] WARNING: CPU: 29 PID: 1319 at lib/refcount.c:25 refcount_warn_saturate (lib/refcount.c:25 (discriminator 1))
> [   92.389049][ T2115]       2174       291211         39936        202785         36246        141919         76774
> [   92.389356][ T1319] Modules linked in:
> [   92.398571][ T2115]
> [   92.419599][ T1319]  dm_mod intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp btrfs kvm_intel blake2b_generic xor kvm raid6_pq snd_pcm irqbypass ipmi_ssif snd_timer ghash_clmulni_intel ahci ast rapl snd intel_cstate libahci acpi_power_meter nvme drm_client_lib binfmt_misc drm_shmem_helper mei_me soundcore intel_uncore ioatdma ipmi_si i2c_i801 pcspkr nvme_core acpi_ipmi libata mei drm_kms_helper i2c_smbus lpc_ich intel_pch_thermal dca ipmi_devintf wmi ipmi_msghandler acpi_pad joydev drm fuse nfnetlink
> [   92.477068][ T1319] CPU: 29 UID: 0 PID: 1319 Comm: kworker/u770:33 Tainted: G S                  6.17.0-rc7-00022-ge8513c012de7 #1 VOLUNTARY
> [   92.490808][ T1319] Tainted: [S]=CPU_OUT_OF_SPEC
> [   92.495958][ T1319] Hardware name: Intel Corporation ............/S9200WKBRD2, BIOS SE5C620.86B.0D.01.0552.060220191912 06/02/2019
> [   92.508765][ T1319] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [   92.516545][ T1319] RIP: 0010:refcount_warn_saturate (lib/refcount.c:25 (discriminator 1))
> [   92.523057][ T1319] Code: 95 95 ff 0f 0b e9 4b 45 90 00 80 3d d3 40 98 01 00 0f 85 5e ff ff ff 48 c7 c7 88 fe ad 82 c6 05 bf 40 98 01 01 e8 9b 95 95 ff <0f> 0b c3 cc cc cc cc 48 c7 c7 e0 fe ad 82 c6 05 a3 40 98 01 01 e8
> All code
> ========
>    0:	95                   	xchg   %eax,%ebp
>    1:	95                   	xchg   %eax,%ebp
>    2:	ff 0f                	decl   (%rdi)
>    4:	0b e9                	or     %ecx,%ebp
>    6:	4b                   	rex.WXB
>    7:	45 90                	rex.RB xchg %eax,%r8d
>    9:	00 80 3d d3 40 98    	add    %al,-0x67bf2cc3(%rax)
>    f:	01 00                	add    %eax,(%rax)
>   11:	0f 85 5e ff ff ff    	jne    0xffffffffffffff75
>   17:	48 c7 c7 88 fe ad 82 	mov    $0xffffffff82adfe88,%rdi
>   1e:	c6 05 bf 40 98 01 01 	movb   $0x1,0x19840bf(%rip)        # 0x19840e4
>   25:	e8 9b 95 95 ff       	call   0xffffffffff9595c5
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	c3                   	ret
>   2d:	cc                   	int3
>   2e:	cc                   	int3
>   2f:	cc                   	int3
>   30:	cc                   	int3
>   31:	48 c7 c7 e0 fe ad 82 	mov    $0xffffffff82adfee0,%rdi
>   38:	c6 05 a3 40 98 01 01 	movb   $0x1,0x19840a3(%rip)        # 0x19840e2
>   3f:	e8                   	.byte 0xe8
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	c3                   	ret
>    3:	cc                   	int3
>    4:	cc                   	int3
>    5:	cc                   	int3
>    6:	cc                   	int3
>    7:	48 c7 c7 e0 fe ad 82 	mov    $0xffffffff82adfee0,%rdi
>    e:	c6 05 a3 40 98 01 01 	movb   $0x1,0x19840a3(%rip)        # 0x19840b8
>   15:	e8                   	.byte 0xe8
> [   92.543676][ T1319] RSP: 0018:ffffc9000fcabca0 EFLAGS: 00010282
> [   92.550187][ T1319] RAX: 0000000000000000 RBX: ffff888e3d2c8d68 RCX: 0000000000000000
> [   92.558625][ T1319] RDX: ffff88984f36a3c0 RSI: 0000000000000001 RDI: ffff88984f35c200
> [   92.567066][ T1319] RBP: ffff8881069c6368 R08: 00000000000008fd R09: 000000000000001d
> [   92.575508][ T1319] R10: 5b5d393933353633 R11: 205d353131325420 R12: ffff888cd91ced20
> [   92.583960][ T1319] R13: 0000000000081087 R14: ffff888ed98c2ba8 R15: ffff8881069c6000
> [   92.592397][ T1319] FS:  0000000000000000(0000) GS:ffff8898cb53c000(0000) knlGS:0000000000000000
> [   92.601843][ T1319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   92.608920][ T1319] CR2: 0000000000000800 CR3: 0000002c7de24001 CR4: 00000000007726f0
> [   92.617398][ T1319] PKRU: 55555554
> [   92.621442][ T1319] Call Trace:
> [   92.625216][ T1319]  <TASK>
> [   92.628645][ T1319] btrfs_get_delayed_node+0xda/0x1b0 btrfs
> [   92.636027][ T1319] btrfs_get_or_create_delayed_node+0x12a/0x1b0 btrfs
> [   92.644356][ T1319] btrfs_delayed_update_inode (fs/btrfs/delayed-inode.c:1957) btrfs
> [   92.651387][ T1319]  ? btrfs_update_root_times (fs/btrfs/root-tree.c:488) btrfs
> [   92.658201][ T1319] btrfs_update_inode (fs/btrfs/inode.c:4174) btrfs
> [   92.664431][ T1319] btrfs_finish_one_ordered (fs/btrfs/inode.c:4188 fs/btrfs/inode.c:3226) btrfs
> [   92.671351][ T1319] btrfs_work_helper (fs/btrfs/async-thread.c:313) btrfs
> [   92.677606][ T1319]  process_one_work (arch/x86/include/asm/jump_label.h:36 include/trace/events/workqueue.h:110 kernel/workqueue.c:3241)
> [   92.682972][ T1319]  worker_thread (kernel/workqueue.c:3313 (discriminator 2) kernel/workqueue.c:3400 (discriminator 2))
> [   92.688065][ T1319]  ? __pfx_worker_thread (kernel/workqueue.c:3346)
> [   92.693679][ T1319]  kthread (kernel/kthread.c:463)
> [   92.698145][ T1319]  ? __pfx_kthread (kernel/kthread.c:412)
> [   92.703205][ T1319]  ret_from_fork (arch/x86/kernel/process.c:148)
> [   92.708102][ T1319]  ? __pfx_kthread (kernel/kthread.c:412)
> [   92.713169][ T1319]  ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
> [   92.718420][ T1319]  </TASK>
> [   92.721904][ T1319] ---[ end trace 0000000000000000 ]---
> [   92.772617][ T2117] [ perf record: Woken up 232 times to write data ]
> [   92.772626][ T2117]
> [   97.041836][ T2115]       2696       307116         30435        210930         28018        143529         49252
> [   97.041848][ T2115]
> [  107.042097][ T2115]       3311       309408         37927        214378         34672        141593         71871
> [  107.042111][ T2115]
> [  107.492140][ T2117] Warning:
> [  107.492150][ T2117]
> [  107.504083][ T2117] 174 out of order events recorded.
> [  107.504089][ T2117]
> [  107.572544][ T2117] [ perf record: Captured and wrote 680.421 MB /tmp/lkp/perf-sched.data (2685986 samples) ]
> [  107.572552][ T2117]
> [  116.735824][    C3] perf: interrupt took too long (2518 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
> [  116.747160][    C3] perf: interrupt took too long (3163 > 3147), lowering kernel.perf_event_max_sample_rate to 63000
> [  116.760698][ T2117] Events enabled
> [  116.760708][ T2117]
> [  116.763935][    C3] perf: interrupt took too long (3955 > 3953), lowering kernel.perf_event_max_sample_rate to 50000
> [  116.796549][   C67] perf: interrupt took too long (4953 > 4943), lowering kernel.perf_event_max_sample_rate to 40000
> [  116.866088][  C131] perf: interrupt took too long (6210 > 6191), lowering kernel.perf_event_max_sample_rate to 32000
> [  117.042049][ T2115]       3836       310809         30767        213835         28646        137339         48846
> [  117.042057][ T2115]
> [  117.739156][   C25] perf: interrupt took too long (7763 > 7762), lowering kernel.perf_event_max_sample_rate to 25000
> [  119.838008][ T2117] [ perf record: Woken up 399 times to write data ]
> [  119.838018][ T2117]
> [  124.613970][ T2117] Warning:
> [  124.613980][ T2117]
> [  124.625324][ T2117] Processed 1601669 events and lost 6 chunks!
> [  124.625332][ T2117]
> [  124.635344][ T2117]
> [  124.635349][ T2117]
> [  124.642513][ T2117] Check IO/CPU overload!
> [  124.642518][ T2117]
> [  124.649994][ T2117]
> [  124.649999][ T2117]
> [  124.656077][ T2117] Warning:
> [  124.656082][ T2117]
> [  124.664342][ T2117] 35 out of order events recorded.
> [  124.664347][ T2117]
> [  124.678444][ T2117] [ perf record: Captured and wrote 252.317 MB /tmp/lkp/perf_c2c.data (1412807 samples) ]
> [  124.678450][ T2117]
> [  127.042332][ T2115]       4407       303071         35022        208647         31346        136630         47202
> [  127.042344][ T2115]
> [  137.042250][ T2115]       4943       299584         31810        208626         30129        128390         56528
> [  137.042263][ T2115]
> [  147.042441][ T2115]       5385       300009         27874        208644         24778        132677         46221
> [  147.042453][ T2115]
> [  157.042433][ T2115]       5910       307972         30431        216088         28665        137389         57696
> [  157.042445][ T2115]
> [  167.042628][ T2115]       6460       304663         35022        213949         31758        139786         62225
> [  167.042640][ T2115]
> [  177.042573][ T2115]       6967       307323         30606        213465         26983        141516         63168
> [  177.042587][ T2115]
> [  187.042733][ T2115]       7407       307075         26787        213546         24994        142923         41523
> [  187.042745][ T2115]
> [  197.042791][ T2115]       7927       308105         34190        214356         29643        140592         52914
> [  197.042803][ T2115]
> [  207.042918][ T2115]       8549       301948         38038        210474         34706        141120         67811
> [  207.042931][ T2115]
> [  217.042636][ T2115]       8955       297050         25135        208501         22518        135881         44260
> [  217.042648][ T2115]
> [  227.038865][ T2115]       9471       304296         32936        210610         29938        137844         62809
> [  227.038870][ T2115]
> [  237.038945][ T2115]       9964       305929         31628        213754         28012        141671         62429
> [  237.038951][ T2115]
> [  247.039008][ T2115]      10440       307726         30685        214830         28062        140111         62249
> [  247.039015][ T2115]
> [  257.039183][ T2115]      10802       292789         23345        205882         20689        138434         48453
> [  257.039188][ T2115]
> [  267.043497][ T2115]      11273       306881         30725        212403         27270        143693         60639
> [  267.043508][ T2115]
> [  277.043510][ T2115]      11797       302806         33279        211710         30071        142609         64344
> [  277.043519][ T2115]
> [  287.039432][ T2115]      12205       264441         24852        186434         24016        129256         56311
> [  287.039437][ T2115]
> [  297.043412][ T2115]      12673       310406         27331        217050         25960        146991         54571
> [  297.043421][ T2115]
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251126/202511262228.6dda231e-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Hello,

I believe I have identified the root cause of the warning.
However, I'm having some troubles running the reproducer as I
haven't setup lkp-tests yet. Could you test the patch below
against your reproducer to see if it fixes the issue?

---8<---

[PATCH] btrfs: fix use-after-free in btrfs_get_or_create_delayed_node

Previously, btrfs_get_or_create_delayed_node sets the delayed_node's
refcount before acquiring the root->delayed_nodes lock.
Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
moves refcount_set inside the critical section which means
there is no longer a memory barrier between setting the refcount and
setting btrfs_inode->delayed_node = node.

This allows btrfs_get_or_create_delayed_node to set
btrfs_inode->delayed_node before setting the refcount.
A different thread is then able to read and increase the refcount
of btrfs_inode->delayed_node leading to a refcounting bug and
a use-after-free warning.

The fix is to move refcount_set back to where it was to take
advantage of the implicit memory barrier provided by lock
acquisition.

Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.com
Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/delayed-inode.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 364814642a91..f61f10000e33 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 		return ERR_PTR(-ENOMEM);
 	btrfs_init_delayed_node(node, root, ino);
 
+	/* Cached in the inode and can be accessed. */
+	refcount_set(&node->refs, 2);
+	btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
+	btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
+
 	/* Allocate and reserve the slot, from now it can return a NULL from xa_load(). */
 	ret = xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
-	if (ret == -ENOMEM) {
-		btrfs_delayed_node_ref_tracker_dir_exit(node);
-		kmem_cache_free(delayed_node_cache, node);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (ret == -ENOMEM)
+		goto cleanup;
+
 	xa_lock(&root->delayed_nodes);
 	ptr = xa_load(&root->delayed_nodes, ino);
 	if (ptr) {
 		/* Somebody inserted it, go back and read it. */
 		xa_unlock(&root->delayed_nodes);
-		btrfs_delayed_node_ref_tracker_dir_exit(node);
-		kmem_cache_free(delayed_node_cache, node);
-		node = NULL;
-		goto again;
+		goto cleanup;
 	}
 	ptr = __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
 	ASSERT(xa_err(ptr) != -EINVAL);
 	ASSERT(xa_err(ptr) != -ENOMEM);
 	ASSERT(ptr == NULL);
-
-	/* Cached in the inode and can be accessed. */
-	refcount_set(&node->refs, 2);
-	btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
-	btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
-
-	btrfs_inode->delayed_node = node;
+	WRITE_ONCE(btrfs_inode->delayed_node, node);
 	xa_unlock(&root->delayed_nodes);
 
 	return node;
+cleanup:
+	btrfs_delayed_node_ref_tracker_free(node, tracker);
+	btrfs_delayed_node_ref_tracker_free(node, &node->inode_cache_tracker);
+	btrfs_delayed_node_ref_tracker_dir_exit(node);
+	kmem_cache_free(delayed_node_cache, node);
+	if (ret)
+		return ERR_PTR(ret);
+	goto again;
 }
 
 /*
-- 
2.47.3

