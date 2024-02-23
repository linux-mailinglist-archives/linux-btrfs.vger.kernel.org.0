Return-Path: <linux-btrfs+bounces-2662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47900860BE7
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 09:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEEF1F2621A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA62171B8;
	Fri, 23 Feb 2024 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKEfKBtN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B214015
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675906; cv=none; b=Q6bQHg5MO6bW0mwj+2BwuOPpwV4yBJEyu6R/5cXa2CumvrD4nYlwExQw6Ag/qwRmlWci5K4yZ3gD+is3h3TugTiAZmVdfmB5djH4RzuvptVJThR/BZP/L0r3omT0OZ1ycrojz/1PaayfL8WN5AtpgBoM17LhDj/58FszMmpWObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675906; c=relaxed/simple;
	bh=NMGrgg/ma0FYNv5hNpdTYPkPA5bCQKGv7eyckvsMpIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7XtESXg7h8AM40t/lp47x1Dcm5UIAbessKoL6lbVyHNaavzyizLXe8Vqk8hoO684zOvKJRDI4wBajD9mWx+1eR1mwHlPocJkz/5H4omWvoRuusjZ7+FxJyksppbw+YuS4wUbGgKq12MwOlMk7iIhzEJ8cTupQv7yKr+agV5izE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKEfKBtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B1DC433F1
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 08:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708675905;
	bh=NMGrgg/ma0FYNv5hNpdTYPkPA5bCQKGv7eyckvsMpIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dKEfKBtNnlNYskF7W2shBudLgmGchrejI9HHJntUBN3nPWI/TyNXlmdQi2JG4/8Eh
	 +lR1vi0W5dbko8RIiNgVOKXqLwNTBxOtN2Y0nJpX3cq5zlllAYuLwXoEPWl5n49OTD
	 CZ06Vm5qsPT/c5d9JBhWnmpfLVSVsG4JHwAntoHPoAy3nRC8oXiDd7ayczsLSQPpDg
	 zVtWxFejRiJcI2+NiSwRb/X3iMH0J33F42AtUEB224rZINYBLASCTEw2DLXljoc//m
	 ttIffLkEA74alle2JuPA7m28rhjKwOSJaP8mJpZcsXSUq+4Nw5/nU9sTTdLWnyz9Y9
	 OngTWb/Sboodg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3d484a58f6so75610666b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 00:11:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeZWtabdw5bdZ/oVsidBnoZA5oLm8WOjDmHpDFNeC5M3xmu+vE46WsWPR9YovdbStN1bQrHmGIJ178/ujnhUxOxkudor5FHE6tfBE=
X-Gm-Message-State: AOJu0YwGtXnOd5c+wb4qaJ13iiQoCSbIWWDZc3EDERgfiWdR4SIACPsq
	g6tpMBY3LzSg//73k3FAfkfB/lwMPMFnVUkjDvvDB2t6EdwrpJ2yPad5jYDg3XL0DmqeTj2UFNo
	askwWLEed59VDlxEWq+0nTt1ilGI=
X-Google-Smtp-Source: AGHT+IFyArQr18600mu5LCPpKgkHlX/OvDCvh/86nITePZPkFM7k16vqe1pvjVpHZmBKtSD0RJmN4vRy3QjolmNZXWM=
X-Received: by 2002:a17:906:8d2:b0:a3f:384a:73ab with SMTP id
 o18-20020a17090608d200b00a3f384a73abmr687274eje.71.1708675904146; Fri, 23 Feb
 2024 00:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49c34d4ede23d28d916eab4a22d4ec698f77f498.1707756893.git.josef@toxicpanda.com>
 <20240223104619.701F.409509F4@e16-tech.com>
In-Reply-To: <20240223104619.701F.409509F4@e16-tech.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 23 Feb 2024 08:11:06 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6t+bWCXskDckDxxQH9B9DkJi3yOGEN4AS-mSgvw4HR1A@mail.gmail.com>
Message-ID: <CAL3q7H6t+bWCXskDckDxxQH9B9DkJi3yOGEN4AS-mSgvw4HR1A@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix deadlock with fiemap and extent locking
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:52=E2=80=AFAM Wang Yugui <wangyugui@e16-tech.com>=
 wrote:
>
> Hi,
>
> > While working on the patchset to remove extent locking I got a lockdep
> > splat with fiemap and pagefaulting with my new extent lock replacement
> > lock.
> >
> > This deadlock exists with our normal code, we just don't have lockdep
> > annotations with the extent locking so we've never noticed it.
> >
> > Since we're copying the fiemap extent to user space on every iteration
> > we have the chance of pagefaulting.  Because we hold the extent lock fo=
r
> > the entire range we could mkwrite into a range in the file that we have
> > mmap'ed.  This would deadlock with the following stack trace
> >
> > [<0>] lock_extent+0x28d/0x2f0
> > [<0>] btrfs_page_mkwrite+0x273/0x8a0
> > [<0>] do_page_mkwrite+0x50/0xb0
> > [<0>] do_fault+0xc1/0x7b0
> > [<0>] __handle_mm_fault+0x2fa/0x460
> > [<0>] handle_mm_fault+0xa4/0x330
> > [<0>] do_user_addr_fault+0x1f4/0x800
> > [<0>] exc_page_fault+0x7c/0x1e0
> > [<0>] asm_exc_page_fault+0x26/0x30
> > [<0>] rep_movs_alternative+0x33/0x70
> > [<0>] _copy_to_user+0x49/0x70
> > [<0>] fiemap_fill_next_extent+0xc8/0x120
> > [<0>] emit_fiemap_extent+0x4d/0xa0
> > [<0>] extent_fiemap+0x7f8/0xad0
> > [<0>] btrfs_fiemap+0x49/0x80
> > [<0>] __x64_sys_ioctl+0x3e1/0xb50
> > [<0>] do_syscall_64+0x94/0x1a0
> > [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >
> > I wrote an fstest to reproduce this deadlock without my replacement loc=
k
> > and verified that the deadlock exists with our existing locking.
> >
> > To fix this simply don't take the extent lock for the entire duration o=
f
> > the fiemap.  This is safe in general because we keep track of where we
> > are when we're searching the tree, so if an ordered extent updates in
> > the middle of our fiemap call we'll still emit the correct extents
> > because we know what offset we were on before.
> >
> > The only place we maintain the lock is searching delalloc.  Since the
> > delalloc stuff can change during writeback we want to lock the extent
> > range so we have a consistent view of delalloc at the time we're
> > checking to see if we need to set the delalloc flag.
> >
> > With this patch applied we no longer deadlock with my testcase.
>
> After I applied this patch(upstream b0ad381fa7690244802aed119b478b4bdafc3=
1dd )
> into 6.6.18-rc1, fstests generic/561 will trigger a WARNING.
>
> reproduce frequency:  about 1/5
>
> Or we need some other patches too?
>
> [22281.809944] ------------[ cut here ]------------
> [22281.816133] WARNING: CPU: 12 PID: 2995743 at fs/btrfs/extent_io.c:2457=
 emit_fiemap_extent+0x84/0x90 [btrfs]
> [22281.827552] Modules linked in: dm_thin_pool dm_persistent_data dm_bio_=
prison dm_snapshot dm_bufio dm_dust dm_flakey ext4 mbcache jbd2 loop rpcsec=
_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs nfne=
tlink overlay rfkill vfat fat drm_exec amdxcp drm_buddy gpu_sched intel_rap=
l_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coret=
emp snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_=
audio kvm_intel snd_hda_intel radeon kvm snd_intel_dspcfg snd_intel_sdw_acp=
i snd_hda_codec snd_hda_core i2c_algo_bit snd_hwdep irqbypass drm_suballoc_=
helper snd_seq drm_display_helper rapl snd_seq_device cec intel_cstate snd_=
pcm mei_wdt drm_ttm_helper dcdbas snd_timer iTCO_wdt ttm mei_me dell_smm_hw=
mon iTCO_vendor_support intel_uncore mei snd video pcspkr i2c_i801 soundcor=
e lpc_ich i2c_smbus fuse xfs sd_mod sg nvme_tcp nvme_fabrics nvme_core ahci=
 libahci nvme_common mpt3sas t10_pi libata e1000e crct10dif_pclmul crc32_pc=
lmul crc32c_intel ghash_clmulni_intel raid_class
> [22281.827650]  scsi_transport_sas wmi dm_multipath btrfs blake2b_generic=
 xor zstd_compress raid6_pq sunrpc dm_mirror dm_region_hash dm_log dm_mod b=
e2iscsi bnx2i cnic uio cxgb4i cxgb4 tls libcxgbi libcxgb qla4xxx iscsi_boot=
_sysfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi i2c_dev [last u=
nloaded: scsi_debug]
> [22281.958863] CPU: 12 PID: 2995743 Comm: pool Tainted: G        W       =
   6.6.18-0.1.el7.x86_64 #1
> [22281.969394] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 =
09/11/2019
> [22281.978405] RIP: 0010:emit_fiemap_extent+0x84/0x90 [btrfs]
> [22281.985631] Code: 2b 4c 89 63 08 4c 89 73 10 44 89 6b 18 5b 5d 41 5c 4=
1 5d 41 5e c3 cc cc cc cc 45 39 c1 75 cc 4c 01 f1 31 c0 48 89 4b 10 eb e3 <=
0f> 0b b8 ea ff ff ff eb da 0f 1f 00 90 90 90 90 90 90 90 90 90 90
> [22282.007771] RSP: 0018:ffffc90026767c28 EFLAGS: 00010206
> [22282.014681] RAX: 00000000001d1000 RBX: ffffc90026767d08 RCX: 000000000=
0005000
> [22282.023469] RDX: 00000000001cd000 RSI: 00000000001cc000 RDI: ffffc9002=
6767d90
> [22282.032256] RBP: 00000000001cd000 R08: 0000000000008000 R09: 000000000=
0000000
> [22282.041016] R10: 0000000000000000 R11: ffff88a0feeb20e0 R12: 000000004=
3ec2000
> [22282.049759] R13: 0000000000000000 R14: 0000000000008000 R15: ffff88a10=
e2ca8c0
> [22282.058636] FS:  00007fbedbfff640(0000) GS:ffff88b08f500000(0000) knlG=
S:0000000000000000
> [22282.068287] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [22282.075624] CR2: 00007fbfb401a000 CR3: 0000000512642001 CR4: 000000000=
01706e0
> [22282.084242] Call Trace:
> [22282.088280]  <TASK>
> [22282.091954]  ? __warn+0x85/0x140
> [22282.096772]  ? emit_fiemap_extent+0x84/0x90 [btrfs]
> [22282.103359]  ? report_bug+0xfc/0x1e0
> [22282.108505]  ? handle_bug+0x3f/0x70
> [22282.113545]  ? exc_invalid_op+0x17/0x70
> [22282.118902]  ? asm_exc_invalid_op+0x1a/0x20
> [22282.124639]  ? emit_fiemap_extent+0x84/0x90 [btrfs]
> [22282.131140]  extent_fiemap+0x7d9/0xae0 [btrfs]
> [22282.137198]  btrfs_fiemap+0x49/0x80 [btrfs]
> [22282.143001]  do_vfs_ioctl+0x177/0x900
> [22282.148220]  __x64_sys_ioctl+0x6e/0xd0
> [22282.153502]  do_syscall_64+0x5c/0x90
> [22282.158616]  ? __might_fault+0x26/0x30
> [22282.163911]  ? _copy_to_user+0x49/0x70
> [22282.169209]  ? do_vfs_ioctl+0x197/0x900
> [22282.174579]  ? __x64_sys_ioctl+0xab/0xd0
> [22282.180035]  ? syscall_exit_to_user_mode+0x26/0x40
> [22282.186375]  ? do_syscall_64+0x6b/0x90
> [22282.191650]  ? exc_page_fault+0x6b/0x150
> [22282.197128]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [22282.203714] RIP: 0033:0x7fbfde23ec6b
> [22282.208882] Code: 73 01 c3 48 8b 0d b5 b1 1b 00 f7 d8 64 89 01 48 83 c=
8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 85 b1 1b 00 f7 d8 64 89 01 48
> [22282.231063] RSP: 002b:00007fbedbffeb98 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
> [22282.240383] RAX: ffffffffffffffda RBX: 00007fbec4801378 RCX: 00007fbfd=
e23ec6b
> [22282.249283] RDX: 00007fbec4801378 RSI: 00000000c020660b RDI: 000000000=
0000003
> [22282.258180] RBP: 00007fbec4801370 R08: 00007fbedbffec90 R09: 00007fbed=
bffec7c
> [22282.266974] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbed=
bffec7c
> [22282.275703] R13: 00007fbedbffec88 R14: 00007fbedbffec80 R15: 00007fbed=
bffec90
> [22282.284443]  </TASK>
> [22282.288165] ---[ end trace 0000000000000000 ]---
>
> static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
>     if (cache->offset + cache->len > offset) {
> L2457:  WARN_ON(1);
>         return -EINVAL;
>     }

Yes, this patch triggers a race. I was just working on a fix for it yesterd=
ay.
I've just sent it to the list, it's the first patch in this series:

https://lore.kernel.org/linux-btrfs/cover.1708635463.git.fdmanana@suse.com/

Thanks.

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2024/02/23
>
>
>

