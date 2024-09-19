Return-Path: <linux-btrfs+bounces-8127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1C97CCA0
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 18:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6CF284DE9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747441A01B4;
	Thu, 19 Sep 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyj184Sv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D15A18EB1
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726764420; cv=none; b=LaTkxmK1Ve52gSqirRuHeEGY6yBbfexpNCSoMAXp9TytHVUmscsMxSmsXBqN2zY/S2QC/NqVE+9Jf02Xl0liNnj6hKTJvv+rplrMFjtICjQkAIzdow4rKK/qzm23VWUe4WUMFnRioS+PWxnn9/4hICGPssT3hBH0BF5fz4kYYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726764420; c=relaxed/simple;
	bh=qolEqizsV9MzrdTMm629EEYsyC2txI1vja4SbpfBjRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sZ5Cgx8EGpluPl0cF3TLz+oTxBPk5AQPy9qrqrjsQX+bfP3fAfBYARNd5+4QqVId+0sA4tCkt9aXBgJGd5tZVG0PyB0sJJOGhxPLhxYe/czIabZ2h9caXZuu79Fao3XRWOYd/5s1l7cD1+X+8bJZfjENQSwVtKD0TrZMhvMsLIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyj184Sv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ABFC4CEC4
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 16:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726764420;
	bh=qolEqizsV9MzrdTMm629EEYsyC2txI1vja4SbpfBjRg=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=lyj184SvdX9jpQOA5gxB2j5CgdlB5x2r8fDtobBM9g1FqVwQ34qtms3Z5vxaUTrQa
	 tuDlCpL90wf+VpZT/pRSBsRn2dBD9ZZoDcuGawRJk6J3YTBTHfZqSFAS2KCErlCrQ1
	 Pog0zDQ8xEiA/0JYM63F1PvWj+Zp61BOUcCYH83p5FH2c9YspW/UxskGXezl2E+R8o
	 7/00w6vh8Q0nMj2bQEFROLWbowvGh6exljg4ut1eHMXpr2HSpMibtb6hWet9bVKrvM
	 dEWQBynagdiPQz5kZnTH5gdpddumq+U9wkMvblZgmhPbXSPH40HaRgUVQTJ2DpANWi
	 jR9JMbXfJT5tQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d2daa2262so126348166b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 09:47:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YybL/c9sk2cSCK3j1/iRBhnXA1wvQfYTv+IZPTByw9PznYes95x
	qqTIKQtamfJDlZ3L9aZ6P4SX2VIrEr0XEJVuadt58Wbd/636ONmTduj2it++N4fS4YfvWl6ws3G
	U0AWJXrGmLXn9I/RB+wvqUb+M2aQ=
X-Google-Smtp-Source: AGHT+IEeb4XYlI1NXuTurYAZsaMpjFVl+5Rqgd10vqkW/D/RVRrxvk4H+94nvXA7iXGyAN5znQWENX7GMCGENjpakkA=
X-Received: by 2002:a17:906:794f:b0:a8d:2faf:d341 with SMTP id
 a640c23a62f3a-a9047b47d7amr2168603166b.10.1726764418675; Thu, 19 Sep 2024
 09:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fbbc0efa2ad81b3dcc00c6dcb15af8189d343af3.1726692825.git.fdmanana@suse.com>
In-Reply-To: <fbbc0efa2ad81b3dcc00c6dcb15af8189d343af3.1726692825.git.fdmanana@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 19 Sep 2024 17:46:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7xQObC5GVpL+yAwXiy44P3A3bTeRRrFG9xKPRyTGTgww@mail.gmail.com>
Message-ID: <CAL3q7H7xQObC5GVpL+yAwXiy44P3A3bTeRRrFG9xKPRyTGTgww@mail.gmail.com>
Subject: Re: [PATCH] btrfs: send: fix buffer overflow when reversing path that
 is full
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 9:57=E2=80=AFPM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> When unreversing a path we are doing a memmove() for a length that
> corresponds to the length of the path's content plus 1. This is incorrect
> as we shouldn't add the extra 1, that is, the length of our content is
> the difference between the path's end offset and the path's start offset,
> and there's no NULL termination as we always use the length for all
> operations. Most of the time this ends up being harmless because the
> path's content is less than the path's buffer length, however when the
> content's length matches the size of the buffer, we end up doing a buffer
> overflow, which results in a crash like the following on a fortified
> kernel:
>
>    Sep 15 23:32:17 sdslinux1 kernel: ------------[ cut here ]------------
>    Sep 15 23:32:17 sdslinux1 kernel: strcpy: detected buffer overflow: 20
>    byte write of buffer size 19
>    Sep 15 23:32:17 sdslinux1 kernel: WARNING: CPU: 3 PID: 3310 at
>    __fortify_report+0x45/0x50
>    Sep 15 23:32:17 sdslinux1 kernel: Modules linked in: nfsd auth_rpcgss
>    lockd grace nfs_acl bridge stp llc bonding tls vfat fat binfmt_misc
>    snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common x8
>    6_pkg_temp_thermal intel_powerclamp kvm_intel iTCO_wdt intel_pmc_bxt
>    spi_intel_platform kvm at24 mei_wdt spi_intel mei_pxp
>    iTCO_vendor_support mei_hdcp btusb snd_hda_codec_realtek btbcm btinte
>    l snd_hda_scodec_component i915 rapl iwlwifi snd_hda_codec_generic btr=
tl
>    intel_cstate btmtk cec snd_hda_intel intel_uncore cfg80211
>    snd_intel_dspcfg drm_buddy coretemp snd_intel_sdw_acpi bluet
>    ooth ttm pcspkr snd_hda_codec rfkill snd_hda_core snd_hwdep intel_vbtn
>    snd_pcm mei_me drm_display_helper snd_timer sparse_keymap i2c_i801 mei
>    snd i2c_smbus lpc_ich soundcore cdc_mbim cdc_wdm cdc_ncm cdc_ether
>    usbnet crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
>    polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_sss=
e3
>    igb r8152 serio_raw i2c_algo_bit mii dca e1000e video wmi sunrpc
>    Sep 15 23:32:17 sdslinux1 kernel: CPU: 3 UID: 0 PID: 3310 Comm: btrfs
>    Not tainted 6.11.0-prnet #1
>    Sep 15 23:32:17 sdslinux1 kernel: Hardware name: CompuLab Ltd.
>    sbc-ihsw/Intense-PC2 (IPC2), BIOS IPC2_3.330.7 X64 03/15/2018
>    Sep 15 23:32:17 sdslinux1 kernel: RIP: 0010:__fortify_report+0x45/0x50
>    Sep 15 23:32:17 sdslinux1 kernel: Code: 48 8b 34 (...)
>    Sep 15 23:32:17 sdslinux1 kernel: RSP: 0018:ffff97ebc0d6f650 EFLAGS:
>    00010246
>    Sep 15 23:32:17 sdslinux1 kernel: RAX: 7749924ef60fa600 RBX:
>    ffff8bf5446a521a RCX: 0000000000000027
>    Sep 15 23:32:17 sdslinux1 kernel: RDX: 00000000ffffdfff RSI:
>    ffff97ebc0d6f548 RDI: ffff8bf84e7a1cc8
>    Sep 15 23:32:17 sdslinux1 kernel: RBP: ffff8bf548574080 R08:
>    ffffffffa8c40e10 R09: 0000000000005ffd
>    Sep 15 23:32:17 sdslinux1 kernel: R10: 0000000000000004 R11:
>    ffffffffa8c70e10 R12: ffff8bf551eef400
>    Sep 15 23:32:17 sdslinux1 kernel: R13: 0000000000000000 R14:
>    0000000000000013 R15: 00000000000003a8
>    Sep 15 23:32:17 sdslinux1 kernel: FS:  00007fae144de8c0(0000)
>    GS:ffff8bf84e780000(0000) knlGS:0000000000000000
>    Sep 15 23:32:17 sdslinux1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>    0000000080050033
>    Sep 15 23:32:17 sdslinux1 kernel: CR2: 00007fae14691690 CR3:
>    00000001027a2003 CR4: 00000000001706f0
>    Sep 15 23:32:17 sdslinux1 kernel: Call Trace:
>    Sep 15 23:32:17 sdslinux1 kernel:  <TASK>
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __warn+0x12a/0x1d0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __fortify_report+0x45/0x50
>    Sep 15 23:32:17 sdslinux1 kernel:  ? report_bug+0x154/0x1c0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? handle_bug+0x42/0x70
>    Sep 15 23:32:17 sdslinux1 kernel:  ? exc_invalid_op+0x1a/0x50
>    Sep 15 23:32:17 sdslinux1 kernel:  ? asm_exc_invalid_op+0x1a/0x20
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __fortify_report+0x45/0x50
>    Sep 15 23:32:17 sdslinux1 kernel:  __fortify_panic+0x9/0x10
>    Sep 15 23:32:17 sdslinux1 kernel: __get_cur_name_and_parent+0x3bc/0x3c=
0
>    Sep 15 23:32:17 sdslinux1 kernel:  get_cur_path+0x207/0x3b0
>    Sep 15 23:32:17 sdslinux1 kernel:  send_extent_data+0x709/0x10d0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? find_parent_nodes+0x22df/0x25d0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? mas_nomem+0x13/0x90
>    Sep 15 23:32:17 sdslinux1 kernel:  ? mtree_insert_range+0xa5/0x110
>    Sep 15 23:32:17 sdslinux1 kernel:  ? btrfs_lru_cache_store+0x5f/0x1e0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? iterate_extent_inodes+0x52d/0x5a0
>    Sep 15 23:32:17 sdslinux1 kernel:  process_extent+0xa96/0x11a0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_lookup_backref_cache+0x10/0=
x10
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_store_backref_cache+0x10/0x=
10
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_iterate_backrefs+0x10/0x10
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_check_extent_item+0x10/0x10
>    Sep 15 23:32:17 sdslinux1 kernel:  changed_cb+0x6fa/0x930
>    Sep 15 23:32:17 sdslinux1 kernel:  ? tree_advance+0x362/0x390
>    Sep 15 23:32:17 sdslinux1 kernel:  ? memcmp_extent_buffer+0xd7/0x160
>    Sep 15 23:32:17 sdslinux1 kernel:  send_subvol+0xf0a/0x1520
>    Sep 15 23:32:17 sdslinux1 kernel:  btrfs_ioctl_send+0x106b/0x11d0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx___clone_root_cmp_sort+0x10/=
0x10
>    Sep 15 23:32:17 sdslinux1 kernel:  _btrfs_ioctl_send+0x1ac/0x240
>    Sep 15 23:32:17 sdslinux1 kernel:  btrfs_ioctl+0x75b/0x850
>    Sep 15 23:32:17 sdslinux1 kernel:  __se_sys_ioctl+0xca/0x150
>    Sep 15 23:32:17 sdslinux1 kernel:  do_syscall_64+0x85/0x160
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __count_memcg_events+0x69/0x100
>    Sep 15 23:32:17 sdslinux1 kernel:  ? handle_mm_fault+0x1327/0x15c0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __se_sys_rt_sigprocmask+0xf1/0x18=
0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? syscall_exit_to_user_mode+0x75/0x=
a0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? do_syscall_64+0x91/0x160
>    Sep 15 23:32:17 sdslinux1 kernel:  ? do_user_addr_fault+0x21d/0x630
>    Sep 15 23:32:17 sdslinux1 kernel: entry_SYSCALL_64_after_hwframe+0x76/=
0x7e
>    Sep 15 23:32:17 sdslinux1 kernel: RIP: 0033:0x7fae145eeb4f
>    Sep 15 23:32:17 sdslinux1 kernel: Code: 00 48 89 (...)
>    Sep 15 23:32:17 sdslinux1 kernel: RSP: 002b:00007ffdf1cb09b0 EFLAGS:
>    00000246 ORIG_RAX: 0000000000000010
>    Sep 15 23:32:17 sdslinux1 kernel: RAX: ffffffffffffffda RBX:
>    0000000000000004 RCX: 00007fae145eeb4f
>    Sep 15 23:32:17 sdslinux1 kernel: RDX: 00007ffdf1cb0ad0 RSI:
>    0000000040489426 RDI: 0000000000000004
>    Sep 15 23:32:17 sdslinux1 kernel: RBP: 00000000000078fe R08:
>    00007fae144006c0 R09: 00007ffdf1cb0927
>    Sep 15 23:32:17 sdslinux1 kernel: R10: 0000000000000008 R11:
>    0000000000000246 R12: 00007ffdf1cb1ce8
>    Sep 15 23:32:17 sdslinux1 kernel: R13: 0000000000000003 R14:
>    000055c499fab2e0 R15: 0000000000000004
>    Sep 15 23:32:17 sdslinux1 kernel:  </TASK>
>    Sep 15 23:32:17 sdslinux1 kernel: ---[ end trace 0000000000000000 ]---
>    Sep 15 23:32:17 sdslinux1 kernel: ------------[ cut here ]------------
>
> Fix this passing the actual length to memmove(), not summing 1.
>
> Reported-by: David Arendt <admin@prnet.org>
> Link: https://lore.kernel.org/linux-btrfs/cee4591a-3088-49ba-99b8-d86b424=
2b8bd@prnet.org/
> Fixes: 31db9f7c23fb ("Btrfs: introduce BTRFS_IOC_SEND for btrfs send/rece=
ive")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/send.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 7f48ba6c1c77..0c5a62da802d 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -620,7 +620,7 @@ static void fs_path_unreverse(struct fs_path *p)
>         len =3D p->end - p->start;
>         p->start =3D p->buf;
>         p->end =3D p->start + len;
> -       memmove(p->start, tmp, len + 1);
> +       memmove(p->start, tmp, len);

Scratch this, the problem is elsewhere, reversed paths always end with
a nul terminator.

>         p->reversed =3D 0;
>  }
>
> --
> 2.43.0
>
>

