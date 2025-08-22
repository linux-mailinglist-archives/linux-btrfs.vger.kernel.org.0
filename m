Return-Path: <linux-btrfs+bounces-16304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F5CB32111
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 19:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE731D61677
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 17:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DA62FDC31;
	Fri, 22 Aug 2025 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="NVYO0s45"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE2312804
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882481; cv=none; b=KgVdYKHMFneCku080DYf0qab5wiHwItqBY2RmOqiSMabi3/kmoaycnte7M1L36M2xDxGqTFML6ULTisfQkgDWREl0RLoyfpvFMRERhKfjZpte5CfGy6jU7B7PI43vG33XsjqKmGkvRXfx6otXGQVS1au34eXByo/GLiIQT4RPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882481; c=relaxed/simple;
	bh=0rD/q6UZZUC20txTy94aiG2VWTT16VUwbkGtnJAxjJ8=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mj5h9RCtgzgfDDNQ4uWWLHdzXa4WzmiVytMZAmhC15DuTAkFQRXzvxC8v7eQAt17T1cia5B2GqgqiR91AEOGnst/mYD8u627e9z1g5gb+NDoEEPaUyAkcjLCXzhZRhzWxOeZ/5NGjbkcgIxl3ARkZzxh+1nRVV8/iuIw1jHZ5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=NVYO0s45; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 4B16E2ABD9A;
	Fri, 22 Aug 2025 18:07:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755882476;
	bh=17vgsAwmtoFbJH+ql6Hsf0ZQIPxWz8baFylDeA5Q81c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NVYO0s45GXdpvWP1ACMDUpOCPkQpMhoPq24Nqb3jsvbQA5QeSKCbZYKXrKSzD0YYe
	 +nlr/MiyuZ5s6gzd0xbXmiZvTHtx5U5H5qqW2SDmS+pXZqbnjCso2Nye2N5Au+J6C3
	 Fehr9lb7p8HN5CCmpyH1tNXXvqVpCJx/7JTbtrj8=
Message-ID: <e9aac724-e156-4fe8-a00a-a5cefd43f96b@harmstone.com>
Date: Fri, 22 Aug 2025 18:07:56 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 03/16] btrfs: allow remapped chunks to have zero
 stripes
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-btrfs@vger.kernel.org
References: <202508181031.5f89d7-lkp@intel.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <202508181031.5f89d7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It looks like this is because the new valid_stripe_count() function BUG_ONs
for RAID0 - I'll fix this for v3.

On 19/08/2025 2.05 am, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel_BUG_at_fs/btrfs/tree-checker.c" on:
> 
> commit: 7ec33e314b27be8996378a9601527017b6ebba95 ("[PATCH v2 03/16] btrfs: allow remapped chunks to have zero stripes")
> url: https://github.com/intel-lab-lkp/linux/commits/Mark-Harmstone/btrfs-add-definitions-and-constants-for-remap-tree/20250813-224507
> base: v6.17-rc1
> patch link: https://lore.kernel.org/all/20250813143509.31073-4-mark@harmstone.com/
> patch subject: [PATCH v2 03/16] btrfs: allow remapped chunks to have zero stripes
> 
> in testcase: xfstests
> version: xfstests-x86_64-e1e4a0ea-1_20250714
> with following parameters:
> 
> 	disk: 6HDD
> 	fs: btrfs
> 	test: btrfs-group-02
> 
> 
> 
> config: x86_64-rhel-9.4-func
> compiler: gcc-12
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202508181031.5f89d7-lkp@intel.com
> 
> 
> [   65.722045][ T7549] ------------[ cut here ]------------
> [   65.727330][ T7549] kernel BUG at fs/btrfs/tree-checker.c:847!
> [   65.733149][ T7549] Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> [   65.739195][ T7549] CPU: 5 UID: 0 PID: 7549 Comm: mount Tainted: G S                  6.17.0-rc1-00003-g7ec33e314b27 #1 PREEMPT(voluntary)
> [   65.751607][ T7549] Tainted: [S]=CPU_OUT_OF_SPEC
> [   65.756182][ T7549] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
> [ 65.764022][ T7549] RIP: 0010:btrfs_check_chunk_valid (fs/btrfs/tree-checker.c:847 fs/btrfs/tree-checker.c:1004) btrfs
> [ 65.770855][ T7549] Code: 24 18 4c 8b 5c 24 10 e9 81 f9 ff ff 48 89 4c 24 18 4c 89 5c 24 10 e8 78 9f 52 bf 48 8b 4c 24 18 4c 8b 5c 24 10 e9 2c fd ff ff <0f> 0b 48 c7 c7 a3 99 51 c2 48 89 4c 24 10 e8 f6 9e 52 bf 48 8b 4c
> All code
> ========
>     0:	24 18                	and    $0x18,%al
>     2:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
>     7:	e9 81 f9 ff ff       	jmp    0xfffffffffffff98d
>     c:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
>    11:	4c 89 5c 24 10       	mov    %r11,0x10(%rsp)
>    16:	e8 78 9f 52 bf       	call   0xffffffffbf529f93
>    1b:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
>    20:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
>    25:	e9 2c fd ff ff       	jmp    0xfffffffffffffd56
>    2a:*	0f 0b                	ud2		<-- trapping instruction
>    2c:	48 c7 c7 a3 99 51 c2 	mov    $0xffffffffc25199a3,%rdi
>    33:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
>    38:	e8 f6 9e 52 bf       	call   0xffffffffbf529f33
>    3d:	48                   	rex.W
>    3e:	8b                   	.byte 0x8b
>    3f:	4c                   	rex.WR
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	48 c7 c7 a3 99 51 c2 	mov    $0xffffffffc25199a3,%rdi
>     9:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
>     e:	e8 f6 9e 52 bf       	call   0xffffffffbf529f09
>    13:	48                   	rex.W
>    14:	8b                   	.byte 0x8b
>    15:	4c                   	rex.WR
> [   65.790121][ T7549] RSP: 0018:ffffc9002239f960 EFLAGS: 00010283
> [   65.795985][ T7549] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000001500000
> [   65.803738][ T7549] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88814af8e0bc
> [   65.811492][ T7549] RBP: ffff88814af8e33c R08: 0000000000000001 R09: 0000000000000005
> [   65.819246][ T7549] R10: e400000000000001 R11: 0000000000000000 R12: 000000000000000a
> [   65.826998][ T7549] R13: 0000000000000008 R14: 0000000000000005 R15: 0000000000ff0000
> [   65.834749][ T7549] FS:  00007f8edf369840(0000) GS:ffff8882182db000(0000) knlGS:0000000000000000
> [   65.843446][ T7549] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   65.849838][ T7549] CR2: 0000562e34dee000 CR3: 0000000201f00005 CR4: 00000000001726f0
> [   65.857589][ T7549] Call Trace:
> [   65.860704][ T7549]  <TASK>
> [ 65.863474][ T7549] ? set_extent_bit (fs/btrfs/extent-io-tree.c:1099) btrfs
> [ 65.869002][ T7549] btrfs_validate_super (fs/btrfs/disk-io.c:2369 fs/btrfs/disk-io.c:2558) btrfs
> [ 65.874869][ T7549] ? crypto_alloc_tfmmem+0x92/0xf0
> [ 65.880390][ T7549] ? __pfx_btrfs_validate_super (fs/btrfs/disk-io.c:2393) btrfs
> [ 65.886682][ T7549] ? btrfs_release_disk_super (include/linux/page-flags.h:226 include/linux/page-flags.h:288 include/linux/mm.h:1424 fs/btrfs/volumes.c:1337) btrfs
> [ 65.892995][ T7549] open_ctree (fs/btrfs/disk-io.c:3373) btrfs
> [ 65.897997][ T7549] ? __pfx_open_ctree (fs/btrfs/disk-io.c:3282) btrfs
> [ 65.903426][ T7549] ? mutex_unlock (arch/x86/include/asm/atomic64_64.h:101 include/linux/atomic/atomic-arch-fallback.h:4329 include/linux/atomic/atomic-long.h:1506 include/linux/atomic/atomic-instrumented.h:4481 kernel/locking/mutex.c:167 kernel/locking/mutex.c:533)
> [ 65.907740][ T7549] ? __pfx_mutex_unlock (kernel/locking/mutex.c:531)
> [ 65.912572][ T7549] btrfs_get_tree_super (fs/btrfs/super.c:978 fs/btrfs/super.c:1937) btrfs
> [ 65.918346][ T7549] btrfs_get_tree_subvol (fs/btrfs/super.c:2074) btrfs
> [ 65.924203][ T7549] vfs_get_tree (fs/super.c:1816)
> [ 65.928432][ T7549] do_new_mount (fs/namespace.c:3806)
> [ 65.932749][ T7549] ? __pfx_do_new_mount (fs/namespace.c:3760)
> [ 65.937580][ T7549] ? __pfx_map_id_range_up (kernel/user_namespace.c:382)
> [ 65.942669][ T7549] ? security_capable (security/security.c:1142)
> [ 65.947330][ T7549] path_mount (fs/namespace.c:4120)
> [   65.951561][ T7549]  ? 0xffffffff81000000
> [ 65.955533][ T7549] ? __pfx_path_mount (fs/namespace.c:4047)
> [ 65.960193][ T7549] ? kmem_cache_free (mm/slub.c:4680 mm/slub.c:4782)
> [ 65.964939][ T7549] ? user_path_at (fs/namei.c:3131)
> [ 65.969259][ T7549] __x64_sys_mount (fs/namespace.c:4134 fs/namespace.c:4344 fs/namespace.c:4321 fs/namespace.c:4321)
> [ 65.973843][ T7549] ? __pfx___x64_sys_mount (fs/namespace.c:4321)
> [ 65.978934][ T7549] ? do_user_addr_fault (arch/x86/include/asm/atomic.h:93 include/linux/atomic/atomic-arch-fallback.h:949 include/linux/atomic/atomic-instrumented.h:401 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:143 include/linux/mmap_lock.h:267 arch/x86/mm/fault.c:1338)
> [ 65.983938][ T7549] do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
> [ 65.988257][ T7549] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:114 arch/x86/mm/fault.c:1484 arch/x86/mm/fault.c:1532)
> [ 65.992749][ T7549] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [   65.998441][ T7549] RIP: 0033:0x7f8edf568e0a
> [ 66.002672][ T7549] Code: 48 8b 0d f9 7f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c6 7f 0c 00 f7 d8 64 89 01 48
> All code
> ========
>     0:	48 8b 0d f9 7f 0c 00 	mov    0xc7ff9(%rip),%rcx        # 0xc8000
>     7:	f7 d8                	neg    %eax
>     9:	64 89 01             	mov    %eax,%fs:(%rcx)
>     c:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
>    10:	c3                   	ret
>    11:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>    18:	00 00 00
>    1b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>    20:	49 89 ca             	mov    %rcx,%r10
>    23:	b8 a5 00 00 00       	mov    $0xa5,%eax
>    28:	0f 05                	syscall
>    2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>    30:	73 01                	jae    0x33
>    32:	c3                   	ret
>    33:	48 8b 0d c6 7f 0c 00 	mov    0xc7fc6(%rip),%rcx        # 0xc8000
>    3a:	f7 d8                	neg    %eax
>    3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>    3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>     6:	73 01                	jae    0x9
>     8:	c3                   	ret
>     9:	48 8b 0d c6 7f 0c 00 	mov    0xc7fc6(%rip),%rcx        # 0xc7fd6
>    10:	f7 d8                	neg    %eax
>    12:	64 89 01             	mov    %eax,%fs:(%rcx)
>    15:	48                   	rex.W
> [   66.021939][ T7549] RSP: 002b:00007ffe66b952e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> [   66.030126][ T7549] RAX: ffffffffffffffda RBX: 0000557c5d7619e0 RCX: 00007f8edf568e0a
> [   66.037879][ T7549] RDX: 0000557c5d761c10 RSI: 0000557c5d761c50 RDI: 0000557c5d761c30
> [   66.045631][ T7549] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000557c5d762940
> [   66.053384][ T7549] R10: 0000000000000000 R11: 0000000000000246 R12: 0000557c5d761c30
> [   66.061140][ T7549] R13: 0000557c5d761c10 R14: 00007f8edf6d0264 R15: 0000557c5d761af8
> [   66.068895][ T7549]  </TASK>
> [   66.071750][ T7549] Modules linked in: snd_hda_codec_intelhdmi snd_hda_codec_hdmi btrfs blake2b_generic xor intel_rapl_msr zstd_compress intel_rapl_common snd_hda_codec_alc269 x86_pkg_temp_thermal snd_hda_scodec_component raid6_pq snd_hda_codec_realtek_lib intel_powerclamp i915 snd_hda_codec_generic coretemp snd_hda_intel sd_mod snd_hda_codec kvm_intel intel_gtt sg snd_hda_core drm_buddy ipmi_devintf ipmi_msghandler platform_profile kvm snd_intel_dspcfg ttm snd_intel_sdw_acpi dell_wmi snd_hwdep irqbypass drm_display_helper dell_smbios ghash_clmulni_intel mei_wdt snd_pcm cec dell_wmi_descriptor drm_client_lib rapl ahci sparse_keymap rfkill snd_timer libahci drm_kms_helper intel_cstate mei_me pcspkr dcdbas intel_uncore libata mei video snd i2c_i801 lpc_ich soundcore i2c_smbus wmi binfmt_misc loop fuse drm dm_mod
> [   66.142949][ T7549] ---[ end trace 0000000000000000 ]---
> [ 66.148220][ T7549] RIP: 0010:btrfs_check_chunk_valid (fs/btrfs/tree-checker.c:847 fs/btrfs/tree-checker.c:1004) btrfs
> [ 66.155057][ T7549] Code: 24 18 4c 8b 5c 24 10 e9 81 f9 ff ff 48 89 4c 24 18 4c 89 5c 24 10 e8 78 9f 52 bf 48 8b 4c 24 18 4c 8b 5c 24 10 e9 2c fd ff ff <0f> 0b 48 c7 c7 a3 99 51 c2 48 89 4c 24 10 e8 f6 9e 52 bf 48 8b 4c
> All code
> ========
>     0:	24 18                	and    $0x18,%al
>     2:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
>     7:	e9 81 f9 ff ff       	jmp    0xfffffffffffff98d
>     c:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
>    11:	4c 89 5c 24 10       	mov    %r11,0x10(%rsp)
>    16:	e8 78 9f 52 bf       	call   0xffffffffbf529f93
>    1b:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
>    20:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
>    25:	e9 2c fd ff ff       	jmp    0xfffffffffffffd56
>    2a:*	0f 0b                	ud2		<-- trapping instruction
>    2c:	48 c7 c7 a3 99 51 c2 	mov    $0xffffffffc25199a3,%rdi
>    33:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
>    38:	e8 f6 9e 52 bf       	call   0xffffffffbf529f33
>    3d:	48                   	rex.W
>    3e:	8b                   	.byte 0x8b
>    3f:	4c                   	rex.WR
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	48 c7 c7 a3 99 51 c2 	mov    $0xffffffffc25199a3,%rdi
>     9:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
>     e:	e8 f6 9e 52 bf       	call   0xffffffffbf529f09
>    13:	48                   	rex.W
>    14:	8b                   	.byte 0x8b
>    15:	4c                   	rex.WR
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250818/202508181031.5f89d7-lkp@intel.com
> 
> 
> 


