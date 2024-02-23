Return-Path: <linux-btrfs+bounces-2656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E6D86090A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 03:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0461C21BF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 02:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22936101C1;
	Fri, 23 Feb 2024 02:51:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-79.mail.aliyun.com (out28-79.mail.aliyun.com [115.124.28.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14DF9EB
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 02:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708656711; cv=none; b=OTqs3KW39zG1d2dSbaG+BWLi6csZKZM/WEIvFey5CJYhrGAZFoaqhmtE0bIRzh6bpk606i1TCxSAp64ohKEpSS7atcsznK/ntmKpfXwwrPoT5eqRNlLBKfKQktpjScPLizZRP3OKLIZ+qLKfbMVBCoPKRIRvrLXY2GBYXhdl674=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708656711; c=relaxed/simple;
	bh=RpLErHXrzuw1NXzp0sasNbQbY2x4JpocQ1Ot8tYcH1I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=aOAAVKtDoD7jYYXV0eQ5ZsYuU2zu6VsPPRr+A+UKVSMyqw2jB3LFxnp6lYeX1ynBnabBSKagr9zW+DEVMXTta/hl5thc64gjCzNaeoZ7taJKDHGcCw2a6x60NyyoBmMlu3icuKY+9XRPdhl3HNplGmzvT3QRV+3xDG2N21wCVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04437151|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0114264-0.00023752-0.988336;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.WXRsQbi_1708656378;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.WXRsQbi_1708656378)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 10:46:19 +0800
Date: Fri, 23 Feb 2024 10:46:20 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] btrfs: fix deadlock with fiemap and extent locking
Cc: linux-btrfs@vger.kernel.org,
 kernel-team@fb.com,
 Filipe Manana <fdmanana@suse.com>
In-Reply-To: <49c34d4ede23d28d916eab4a22d4ec698f77f498.1707756893.git.josef@toxicpanda.com>
References: <49c34d4ede23d28d916eab4a22d4ec698f77f498.1707756893.git.josef@toxicpanda.com>
Message-Id: <20240223104619.701F.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Becky! ver. 2.81.05 [en]

Hi,

> While working on the patchset to remove extent locking I got a lockdep
> splat with fiemap and pagefaulting with my new extent lock replacement
> lock.
>=20
> This deadlock exists with our normal code, we just don't have lockdep
> annotations with the extent locking so we've never noticed it.
>=20
> Since we're copying the fiemap extent to user space on every iteration
> we have the chance of pagefaulting.  Because we hold the extent lock for
> the entire range we could mkwrite into a range in the file that we have
> mmap'ed.  This would deadlock with the following stack trace
>=20
> [<0>] lock_extent+0x28d/0x2f0
> [<0>] btrfs_page_mkwrite+0x273/0x8a0
> [<0>] do_page_mkwrite+0x50/0xb0
> [<0>] do_fault+0xc1/0x7b0
> [<0>] __handle_mm_fault+0x2fa/0x460
> [<0>] handle_mm_fault+0xa4/0x330
> [<0>] do_user_addr_fault+0x1f4/0x800
> [<0>] exc_page_fault+0x7c/0x1e0
> [<0>] asm_exc_page_fault+0x26/0x30
> [<0>] rep_movs_alternative+0x33/0x70
> [<0>] _copy_to_user+0x49/0x70
> [<0>] fiemap_fill_next_extent+0xc8/0x120
> [<0>] emit_fiemap_extent+0x4d/0xa0
> [<0>] extent_fiemap+0x7f8/0xad0
> [<0>] btrfs_fiemap+0x49/0x80
> [<0>] __x64_sys_ioctl+0x3e1/0xb50
> [<0>] do_syscall_64+0x94/0x1a0
> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
>=20
> I wrote an fstest to reproduce this deadlock without my replacement lock
> and verified that the deadlock exists with our existing locking.
>=20
> To fix this simply don't take the extent lock for the entire duration of
> the fiemap.  This is safe in general because we keep track of where we
> are when we're searching the tree, so if an ordered extent updates in
> the middle of our fiemap call we'll still emit the correct extents
> because we know what offset we were on before.
>=20
> The only place we maintain the lock is searching delalloc.  Since the
> delalloc stuff can change during writeback we want to lock the extent
> range so we have a consistent view of delalloc at the time we're
> checking to see if we need to set the delalloc flag.
>=20
> With this patch applied we no longer deadlock with my testcase.

After I applied this patch(upstream b0ad381fa7690244802aed119b478b4bdafc31d=
d )
into 6.6.18-rc1, fstests generic/561 will trigger a WARNING.

reproduce frequency:  about 1/5

Or we need some other patches too?

[22281.809944] ------------[ cut here ]------------
[22281.816133] WARNING: CPU: 12 PID: 2995743 at fs/btrfs/extent_io.c:2457 e=
mit_fiemap_extent+0x84/0x90 [btrfs]
[22281.827552] Modules linked in: dm_thin_pool dm_persistent_data dm_bio_pr=
ison dm_snapshot dm_bufio dm_dust dm_flakey ext4 mbcache jbd2 loop rpcsec_g=
ss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs nfnetl=
ink overlay rfkill vfat fat drm_exec amdxcp drm_buddy gpu_sched intel_rapl_=
msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretem=
p snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_au=
dio kvm_intel snd_hda_intel radeon kvm snd_intel_dspcfg snd_intel_sdw_acpi =
snd_hda_codec snd_hda_core i2c_algo_bit snd_hwdep irqbypass drm_suballoc_he=
lper snd_seq drm_display_helper rapl snd_seq_device cec intel_cstate snd_pc=
m mei_wdt drm_ttm_helper dcdbas snd_timer iTCO_wdt ttm mei_me dell_smm_hwmo=
n iTCO_vendor_support intel_uncore mei snd video pcspkr i2c_i801 soundcore =
lpc_ich i2c_smbus fuse xfs sd_mod sg nvme_tcp nvme_fabrics nvme_core ahci l=
ibahci nvme_common mpt3sas t10_pi libata e1000e crct10dif_pclmul crc32_pclm=
ul crc32c_intel ghash_clmulni_intel raid_class
[22281.827650]  scsi_transport_sas wmi dm_multipath btrfs blake2b_generic x=
or zstd_compress raid6_pq sunrpc dm_mirror dm_region_hash dm_log dm_mod be2=
iscsi bnx2i cnic uio cxgb4i cxgb4 tls libcxgbi libcxgb qla4xxx iscsi_boot_s=
ysfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi i2c_dev [last unl=
oaded: scsi_debug]
[22281.958863] CPU: 12 PID: 2995743 Comm: pool Tainted: G        W         =
 6.6.18-0.1.el7.x86_64 #1
[22281.969394] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 09=
/11/2019
[22281.978405] RIP: 0010:emit_fiemap_extent+0x84/0x90 [btrfs]
[22281.985631] Code: 2b 4c 89 63 08 4c 89 73 10 44 89 6b 18 5b 5d 41 5c 41 =
5d 41 5e c3 cc cc cc cc 45 39 c1 75 cc 4c 01 f1 31 c0 48 89 4b 10 eb e3 <0f=
> 0b b8 ea ff ff ff eb da 0f 1f 00 90 90 90 90 90 90 90 90 90 90
[22282.007771] RSP: 0018:ffffc90026767c28 EFLAGS: 00010206
[22282.014681] RAX: 00000000001d1000 RBX: ffffc90026767d08 RCX: 00000000000=
05000
[22282.023469] RDX: 00000000001cd000 RSI: 00000000001cc000 RDI: ffffc900267=
67d90
[22282.032256] RBP: 00000000001cd000 R08: 0000000000008000 R09: 00000000000=
00000
[22282.041016] R10: 0000000000000000 R11: ffff88a0feeb20e0 R12: 0000000043e=
c2000
[22282.049759] R13: 0000000000000000 R14: 0000000000008000 R15: ffff88a10e2=
ca8c0
[22282.058636] FS:  00007fbedbfff640(0000) GS:ffff88b08f500000(0000) knlGS:=
0000000000000000
[22282.068287] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[22282.075624] CR2: 00007fbfb401a000 CR3: 0000000512642001 CR4: 00000000001=
706e0
[22282.084242] Call Trace:
[22282.088280]  <TASK>
[22282.091954]  ? __warn+0x85/0x140
[22282.096772]  ? emit_fiemap_extent+0x84/0x90 [btrfs]
[22282.103359]  ? report_bug+0xfc/0x1e0
[22282.108505]  ? handle_bug+0x3f/0x70
[22282.113545]  ? exc_invalid_op+0x17/0x70
[22282.118902]  ? asm_exc_invalid_op+0x1a/0x20
[22282.124639]  ? emit_fiemap_extent+0x84/0x90 [btrfs]
[22282.131140]  extent_fiemap+0x7d9/0xae0 [btrfs]
[22282.137198]  btrfs_fiemap+0x49/0x80 [btrfs]
[22282.143001]  do_vfs_ioctl+0x177/0x900
[22282.148220]  __x64_sys_ioctl+0x6e/0xd0
[22282.153502]  do_syscall_64+0x5c/0x90
[22282.158616]  ? __might_fault+0x26/0x30
[22282.163911]  ? _copy_to_user+0x49/0x70
[22282.169209]  ? do_vfs_ioctl+0x197/0x900
[22282.174579]  ? __x64_sys_ioctl+0xab/0xd0
[22282.180035]  ? syscall_exit_to_user_mode+0x26/0x40
[22282.186375]  ? do_syscall_64+0x6b/0x90
[22282.191650]  ? exc_page_fault+0x6b/0x150
[22282.197128]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[22282.203714] RIP: 0033:0x7fbfde23ec6b
[22282.208882] Code: 73 01 c3 48 8b 0d b5 b1 1b 00 f7 d8 64 89 01 48 83 c8 =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 85 b1 1b 00 f7 d8 64 89 01 48
[22282.231063] RSP: 002b:00007fbedbffeb98 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[22282.240383] RAX: ffffffffffffffda RBX: 00007fbec4801378 RCX: 00007fbfde2=
3ec6b
[22282.249283] RDX: 00007fbec4801378 RSI: 00000000c020660b RDI: 00000000000=
00003
[22282.258180] RBP: 00007fbec4801370 R08: 00007fbedbffec90 R09: 00007fbedbf=
fec7c
[22282.266974] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbedbf=
fec7c
[22282.275703] R13: 00007fbedbffec88 R14: 00007fbedbffec80 R15: 00007fbedbf=
fec90
[22282.284443]  </TASK>
[22282.288165] ---[ end trace 0000000000000000 ]---

static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
    if (cache->offset + cache->len > offset) {
L2457:  WARN_ON(1);
        return -EINVAL;
    }

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/02/23



