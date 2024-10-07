Return-Path: <linux-btrfs+bounces-8578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CBC992944
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 12:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929DD1F23DC8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 10:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FCB1C6F6D;
	Mon,  7 Oct 2024 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiMOp9aX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6986718B473
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297216; cv=none; b=WbhFKE42FAw1lRnpwAfTLY+aZ63qmXxIsXL7a8Kky8LxkLJbt9Zmxk9XxP+I/YldLJoIKkdWr1uTdtPlAJIn9L73Dn4fTMQgKe8ajGQcwt0XobpTM6fGEJjzbmYxcaEXChpC1VGpKUo5z3mrHv3jQoW//DajjFP8eK3QSzCPGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297216; c=relaxed/simple;
	bh=GQLAC9pUQvk/JxuuZUESfcS84a7im52V17cXDytr0aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZWYfwqedS7LmraMYYGKtsPx/7FHzJ726ar+uy2lOV+clhbRZs2EwlUNocetwOt8sAAV5/OgmX2FZwDVlEI5UZQa4GjVk4Rd/0YXzhnmOcFjqK2ZHh6jRlwt5CkhJhzRVNjxGdrxxLdScwG/Sj6ICdIVSgeddZsl9q5KF0/Qjs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiMOp9aX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54C4C4CEC6
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 10:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728297216;
	bh=GQLAC9pUQvk/JxuuZUESfcS84a7im52V17cXDytr0aw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KiMOp9aX9gCJARVmgQW1j8Ev2f942iYQsoX1qyj2lZl95eGIDOl7l2kcZUySOrTu2
	 sCccI4hBBMlib1PCL6v7llvc1OX7W0xYHxlrMIddrnLw/e1wnbiW2zJzk5MVcMRtyW
	 15T9ZfT/h4Kv89Q6Y45KYaoVc9HuZeUBLb1yrzPIYg6e4vM+HJRLsnxK9/tY5D3fK2
	 /GVR7eqFG5zWFmlGolaUw1KvDoO35wLDcDglLUJ7AnNWlJdvWUpwXizo9xluYjH0ux
	 IIxCb/XQroMdL5t10Pu/wuHBYX4nU1A/aUTDkI9yRlv4bGmOHFVat61/I7hKVIELxE
	 RVCkc2fWvl39A==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso56730871fa.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 03:33:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YwEvdSV9ppoKRcB2L/GAlYyN6dwuSdvSe3UyggGs1T7UQxglfvG
	6EepMJYhhyvQlRAxkIGcmD2EJcHwImI448obBbGKvT17PWRsVu4J/2CN/+HpqMAdHGp9K4SAnLQ
	wjYbYXqR33699+b67LCn8+ByYdg4=
X-Google-Smtp-Source: AGHT+IES0bYoiq3Dbx4AAdSw1smOR+ZzU9pdcj1/4Dtp/ND2Hod/NTF3sqkr3ffU010Ijn9WEwZoc/SjqhL29xdnYyw=
X-Received: by 2002:a05:6512:33ca:b0:536:a4f1:d214 with SMTP id
 2adb3069b0e04-539ab86693emr8041815e87.19.1728297214186; Mon, 07 Oct 2024
 03:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cee4591a-3088-49ba-99b8-d86b4242b8bd@prnet.org>
 <CAL3q7H7NCN_FHcSjYs+OVuw-D-0XfxHNBs2NsCjzNAe_=XHisQ@mail.gmail.com>
 <7ac09d6b-a073-45c5-b35a-b4424b6d9a4f@prnet.org> <CAL3q7H63hqrf3X6PAtmWc1yAJxW3YC3mJ5_7sMLDEZLCTZZxEg@mail.gmail.com>
 <c9373aab-24b5-4cc1-bc3e-3cdb4b28f067@prnet.org> <12c0cc92-39b2-4676-b771-256b7a67f647@prnet.org>
In-Reply-To: <12c0cc92-39b2-4676-b771-256b7a67f647@prnet.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 7 Oct 2024 11:32:57 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7iGo+59B1d=8etxN_UXOruBzj3=MbA8yZftSkqjC+L3Q@mail.gmail.com>
Message-ID: <CAL3q7H7iGo+59B1d=8etxN_UXOruBzj3=MbA8yZftSkqjC+L3Q@mail.gmail.com>
Subject: Re: btrfs send crash on kernel 6.11.0
To: David Arendt <admin@prnet.org>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 10:22=E2=80=AFPM David Arendt <admin@prnet.org> wrot=
e:
>
> On 9/20/24 11:11 PM, David Arendt wrote:
> > On 9/19/24 11:54 PM, Filipe Manana wrote:
> >> On Thu, Sep 19, 2024 at 9:23=E2=80=AFPM David Arendt <admin@prnet.org>=
 wrote:
> >>> On 9/18/24 10:57 PM, Filipe Manana wrote:
> >>>> On Wed, Sep 18, 2024 at 7:59=E2=80=AFPM David Arendt <admin@prnet.or=
g> wrote:
> >>>>> Hi,
> >>>>>
> >>>>> I am experiencing the following crash when doing an incremental btr=
fs
> >>>>> send (started by btrbk) on kernel 6.11.0:
> >>>>>
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: ------------[ cut here
> >>>>> ]------------
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: strcpy: detected buffer
> >>>>> overflow: 20
> >>>>> byte write of buffer size 19
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: WARNING: CPU: 3 PID: 3310 at
> >>>>> __fortify_report+0x45/0x50
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: Modules linked in: nfsd auth_rpcg=
ss
> >>>>> lockd grace nfs_acl bridge stp llc bonding tls vfat fat binfmt_misc
> >>>>> snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common x8
> >>>>> 6_pkg_temp_thermal intel_powerclamp kvm_intel iTCO_wdt intel_pmc_bx=
t
> >>>>> spi_intel_platform kvm at24 mei_wdt spi_intel mei_pxp
> >>>>> iTCO_vendor_support mei_hdcp btusb snd_hda_codec_realtek btbcm btin=
te
> >>>>> l snd_hda_scodec_component i915 rapl iwlwifi snd_hda_codec_generic
> >>>>> btrtl
> >>>>> intel_cstate btmtk cec snd_hda_intel intel_uncore cfg80211
> >>>>> snd_intel_dspcfg drm_buddy coretemp snd_intel_sdw_acpi bluet
> >>>>> ooth ttm pcspkr snd_hda_codec rfkill snd_hda_core snd_hwdep
> >>>>> intel_vbtn
> >>>>> snd_pcm mei_me drm_display_helper snd_timer sparse_keymap i2c_i801
> >>>>> mei
> >>>>> snd i2c_smbus lpc_ich soundcore cdc_mbim cdc_wdm cdc_ncm cdc_ether
> >>>>> usbnet crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
> >>>>> polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3
> >>>>> sha1_ssse3
> >>>>> igb r8152 serio_raw i2c_algo_bit mii dca e1000e video wmi sunrpc
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: CPU: 3 UID: 0 PID: 3310 Comm: btr=
fs
> >>>>> Not tainted 6.11.0-prnet #1
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: Hardware name: CompuLab Ltd.
> >>>>> sbc-ihsw/Intense-PC2 (IPC2), BIOS IPC2_3.330.7 X64 03/15/2018
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: RIP:
> >>>>> 0010:__fortify_report+0x45/0x50
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: Code: 48 8b 34 c5 e0 a9 97 a8 40
> >>>>> f6 c7
> >>>>> 01 48 c7 c0 51 5d 86 a8 48 c7 c1 c0 61 84 a8 48 0f 44 c8 48 c7 c7
> >>>>> 60 9d
> >>>>> 8a a8 e8 4b f6 88 ff <0f> 0b c3 cc cc cc cc cc cc cc cc 90 90 90
> >>>>> 90 90
> >>>>> 90 90 90 90 90 90
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: RSP: 0018:ffff97ebc0d6f650 EFLAGS=
:
> >>>>> 00010246
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: RAX: 7749924ef60fa600 RBX:
> >>>>> ffff8bf5446a521a RCX: 0000000000000027
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: RDX: 00000000ffffdfff RSI:
> >>>>> ffff97ebc0d6f548 RDI: ffff8bf84e7a1cc8
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: RBP: ffff8bf548574080 R08:
> >>>>> ffffffffa8c40e10 R09: 0000000000005ffd
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: R10: 0000000000000004 R11:
> >>>>> ffffffffa8c70e10 R12: ffff8bf551eef400
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: R13: 0000000000000000 R14:
> >>>>> 0000000000000013 R15: 00000000000003a8
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: FS: 00007fae144de8c0(0000)
> >>>>> GS:ffff8bf84e780000(0000) knlGS:0000000000000000
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> >>>>> 0000000080050033
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: CR2: 00007fae14691690 CR3:
> >>>>> 00000001027a2003 CR4: 00000000001706f0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: Call Trace:
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  <TASK>
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? __warn+0x12a/0x1d0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? __fortify_report+0x45/0x50
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? report_bug+0x154/0x1c0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? handle_bug+0x42/0x70
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? exc_invalid_op+0x1a/0x50
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? asm_exc_invalid_op+0x1a/0x20
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? __fortify_report+0x45/0x50
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: __fortify_panic+0x9/0x10
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:
> >>>>> __get_cur_name_and_parent+0x3bc/0x3c0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: get_cur_path+0x207/0x3b0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: send_extent_data+0x709/0x10d0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? find_parent_nodes+0x22df/0x25d=
0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? mas_nomem+0x13/0x90
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? mtree_insert_range+0xa5/0x110
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? btrfs_lru_cache_store+0x5f/0x1=
e0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ?
> >>>>> iterate_extent_inodes+0x52d/0x5a0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: process_extent+0xa96/0x11a0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ?
> >>>>> __pfx_lookup_backref_cache+0x10/0x10
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ?
> >>>>> __pfx_store_backref_cache+0x10/0x10
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_iterate_backrefs+0x10/0x=
10
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ?
> >>>>> __pfx_check_extent_item+0x10/0x10
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  changed_cb+0x6fa/0x930
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? tree_advance+0x362/0x390
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? memcmp_extent_buffer+0xd7/0x16=
0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: send_subvol+0xf0a/0x1520
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: btrfs_ioctl_send+0x106b/0x11d0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ?
> >>>>> __pfx___clone_root_cmp_sort+0x10/0x10
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: _btrfs_ioctl_send+0x1ac/0x240
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  btrfs_ioctl+0x75b/0x850
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: __se_sys_ioctl+0xca/0x150
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: do_syscall_64+0x85/0x160
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? __count_memcg_events+0x69/0x10=
0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? handle_mm_fault+0x1327/0x15c0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ?
> >>>>> __se_sys_rt_sigprocmask+0xf1/0x180
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ?
> >>>>> syscall_exit_to_user_mode+0x75/0xa0
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? do_syscall_64+0x91/0x160
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  ? do_user_addr_fault+0x21d/0x630
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:
> >>>>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: RIP: 0033:0x7fae145eeb4f
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: Code: 00 48 89 44 24 18 31 c0 48
> >>>>> 8d 44
> >>>>> 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44
> >>>>> 24 10
> >>>>> b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77
> >>>>> 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: RSP: 002b:00007ffdf1cb09b0 EFLAGS=
:
> >>>>> 00000246 ORIG_RAX: 0000000000000010
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: RAX: ffffffffffffffda RBX:
> >>>>> 0000000000000004 RCX: 00007fae145eeb4f
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: RDX: 00007ffdf1cb0ad0 RSI:
> >>>>> 0000000040489426 RDI: 0000000000000004
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: RBP: 00000000000078fe R08:
> >>>>> 00007fae144006c0 R09: 00007ffdf1cb0927
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: R10: 0000000000000008 R11:
> >>>>> 0000000000000246 R12: 00007ffdf1cb1ce8
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: R13: 0000000000000003 R14:
> >>>>> 000055c499fab2e0 R15: 0000000000000004
> >>>>> Sep 15 23:32:17 sdslinux1 kernel:  </TASK>
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: ---[ end trace 0000000000000000
> >>>>> ]---
> >>>>> Sep 15 23:32:17 sdslinux1 kernel: ------------[ cut here
> >>>>> ]------------
> >>>>>
> >>>>> The same btrfs send is working without any problem on kernel 6.10.1=
0.
> >>>> Try this:
> >>>>
> >>>> https://lore.kernel.org/linux-btrfs/fbbc0efa2ad81b3dcc00c6dcb15af818=
9d343af3.1726692825.git.fdmanana@suse.com/
> >>>>
> >>>>
> >>>> Thanks.
> >>>>
> >>>>> Thanks in advance,
> >>>>>
> >>>>> David Arendt
> >>>>>
> >>>>>
> >>> Hi,
> >>>
> >>> Unfortunately the crash is still happening with the patch applied.
> >> Yeah, I realized later that the problem is different from what I
> >> thought initially.
> >>
> >> Try this:
> >>
> >> https://lore.kernel.org/linux-btrfs/ee24884b0255f717071ca932bda1ab3987=
07d9cf.1726782272.git.fdmanana@suse.com/
> >>
> >>
> >> That should fix it and it's indeed a regression introduced in 6.11.
> >>
> >> Thanks.
> >
> > Hi,
> >
> > Many thanks. I can confirm that the problem is fixed by applying this
> > patch.
> >
> > Bye,
> >
> > David Arendt
> >
> >
> >>> Here is the btrfs send command executed by btrbk:
> >>>
> >>> btrfs send -p '/u02/btrbk_snapshots/psdslinux1.20240919T2200'
> >>> '/u02/btrbk_snapshots/psdslinux1.20240919T2209'
> >>>
> >>> Sep 19 22:09:41 sdslinux1 kernel: ------------[ cut here ]-----------=
-
> >>> Sep 19 22:09:41 sdslinux1 kernel: strcpy: detected buffer overflow: 2=
0
> >>> byte write of buffer size 19
> >>> Sep 19 22:09:41 sdslinux1 kernel: WARNING: CPU: 2 PID: 3316 at
> >>> __fortify_report+0x45/0x50
> >>> Sep 19 22:09:41 sdslinux1 kernel: Modules linked in: nfsd auth_rpcgss
> >>> lockd grace nfs_acl bridge stp llc bonding tls vfat fat binfmt_misc
> >>> snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common
> >>> x86_pkg_temp_thermal
> >>> intel_powerclamp kvm_intel kvm snd_hda_codec_realtek iTCO_wdt
> >>> snd_hda_scodec_component intel_pmc_bxt snd_hda_codec_generic mei_pxp
> >>> spi_intel_platform btusb rapl at24 spi_intel mei_wdt mei_hdcp
> >>> iTCO_vendor_support btbcm intel_cstate btintel i915 btrtl intel_uncor=
e
> >>> snd_hda_intel btmtk coretemp snd_intel_dspcfg iwlwifi
> >>> snd_intel_sdw_acpi
> >>> snd_hda_codec i2c_i801 cfg80211 pcspkr i2c_smbus bluetooth snd_hda_co=
re
> >>> snd_hwdep cec drm_buddy ttm rfkill snd_pcm snd_timer mei_me intel_vbt=
n
> >>> snd sparse_keymap drm_display_helper lpc_ich mei soundcore cdc_mbim
> >>> cdc_wdm cdc_ncm cdc_ether usbnet crct10dif_pclmul crc32_pclmul
> >>> crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel
> >>> sha512_ssse3 sha256_ssse3 sha1_ssse3 serio_raw r8152 igb mii
> >>> i2c_algo_bit dca e1000e video wmi sunrpc
> >>> Sep 19 22:09:41 sdslinux1 kernel: CPU: 2 UID: 0 PID: 3316 Comm: btrfs
> >>> Not tainted 6.11.0-prnet #2
> >>> Sep 19 22:09:41 sdslinux1 kernel: Hardware name: CompuLab Ltd.
> >>> sbc-ihsw/Intense-PC2 (IPC2), BIOS IPC2_3.330.7 X64 03/15/2018
> >>> Sep 19 22:09:41 sdslinux1 kernel: RIP: 0010:__fortify_report+0x45/0x5=
0
> >>> Sep 19 22:09:41 sdslinux1 kernel: Code: 48 8b 34 c5 10 a3 97 8f 40
> >>> f6 c7
> >>> 01 48 c7 c0 49 57 86 8f 48 c7 c1 b8 5b 84 8f 48 0f 44 c8 48 c7 c7 35 =
97
> >>> 8a 8f e8 db 85 88 ff <0f> 0b c3 cc cc cc cc cc cc cc cc 90 90 90 90 9=
0
> >>> 90 90 90 90 90 90
> >>> Sep 19 22:09:41 sdslinux1 kernel: RSP: 0018:ffffb9e780d6f580 EFLAGS:
> >>> 00010246
> >>> Sep 19 22:09:41 sdslinux1 kernel: RAX: e21c8dd82a268800 RBX:
> >>> ffff8c3d02f7ad1a RCX: 0000000000000027
> >>> Sep 19 22:09:41 sdslinux1 kernel: RDX: 00000000ffffdfff RSI:
> >>> ffffb9e780d6f478 RDI: ffff8c400e721cc8
> >>> Sep 19 22:09:41 sdslinux1 kernel: RBP: ffff8c3d05803080 R08:
> >>> ffffffff8fc40e10 R09: 0000000000005ffd
> >>> Sep 19 22:09:41 sdslinux1 kernel: R10: 0000000000000004 R11:
> >>> ffffffff8fc70e10 R12: ffff8c3d13898000
> >>> Sep 19 22:09:41 sdslinux1 kernel: R13: 0000000000000000 R14:
> >>> 0000000000000013 R15: 00000000000003a8
> >>> Sep 19 22:09:41 sdslinux1 kernel: FS:  00007f8ea78128c0(0000)
> >>> GS:ffff8c400e700000(0000) knlGS:0000000000000000
> >>> Sep 19 22:09:41 sdslinux1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> >>> 0000000080050033
> >>> Sep 19 22:09:41 sdslinux1 kernel: CR2: 00007fc355bb5ef0 CR3:
> >>> 0000000102e5c001 CR4: 00000000001706f0
> >>> Sep 19 22:09:41 sdslinux1 kernel: Call Trace:
> >>> Sep 19 22:09:41 sdslinux1 kernel:  <TASK>
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? __warn+0x12a/0x1d0
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? __fortify_report+0x45/0x50
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? report_bug+0x154/0x1c0
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? handle_bug+0x3f/0x70
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? exc_invalid_op+0x1a/0x50
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? asm_exc_invalid_op+0x1a/0x20
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? __fortify_report+0x45/0x50
> >>> Sep 19 22:09:41 sdslinux1 kernel:  __fortify_panic+0x9/0x10
> >>> Sep 19 22:09:41 sdslinux1 kernel: __get_cur_name_and_parent+0x3c1/0x3=
d0
> >>> Sep 19 22:09:41 sdslinux1 kernel:  get_cur_path+0x223/0x3c0
> >>> Sep 19 22:09:41 sdslinux1 kernel: send_extent_data+0x6c9/0x11b0
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? find_parent_nodes+0x231f/0x2610
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? mas_nomem+0x13/0x90
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? mtree_insert_range+0xb5/0x120
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? btrfs_lru_cache_store+0x5f/0x1e0
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? iterate_extent_inodes+0x52d/0x5a=
0
> >>> Sep 19 22:09:41 sdslinux1 kernel:  process_extent+0xa8e/0x11b0
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ?
> >>> __pfx_lookup_backref_cache+0x10/0x10
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ?
> >>> __pfx_store_backref_cache+0x10/0x10
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? __pfx_iterate_backrefs+0x10/0x10
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? __pfx_check_extent_item+0x10/0x1=
0
> >>> Sep 19 22:09:41 sdslinux1 kernel:  changed_cb+0x6c1/0x930
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? tree_advance+0x39b/0x3c0
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? memcmp_extent_buffer+0xe3/0x170
> >>> Sep 19 22:09:41 sdslinux1 kernel:  send_subvol+0x1217/0x1620
> >>> Sep 19 22:09:41 sdslinux1 kernel: _btrfs_ioctl_send+0x1ac/0x240
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? place_entity+0x147/0x190
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? enqueue_entity+0x269/0x610
> >>> Sep 19 22:09:41 sdslinux1 kernel:  btrfs_ioctl+0x759/0x850
> >>> Sep 19 22:09:41 sdslinux1 kernel:  __se_sys_ioctl+0xca/0x150
> >>> Sep 19 22:09:41 sdslinux1 kernel:  do_syscall_64+0x85/0x170
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? kernel_clone+0x1f9/0x500
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? __x64_sys_clone3+0x22b/0x240
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ?
> >>> syscall_exit_to_user_mode+0x75/0xa0
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? __se_sys_rt_sigprocmask+0xf1/0x1=
80
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ?
> >>> syscall_exit_to_user_mode+0x75/0xa0
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? do_syscall_64+0x91/0x170
> >>> Sep 19 22:09:41 sdslinux1 kernel:  ? do_user_addr_fault+0x21d/0x630
> >>> Sep 19 22:09:41 sdslinux1 kernel:
> >>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>> Sep 19 22:09:41 sdslinux1 kernel: RIP: 0033:0x7f8ea7922b4f
> >>> Sep 19 22:09:41 sdslinux1 kernel: Code: 00 48 89 44 24 18 31 c0 48
> >>> 8d 44
> >>> 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 =
10
> >>> b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 4=
8
> >>> 2b 04 25 28 00 00
> >>> Sep 19 22:09:41 sdslinux1 kernel: RSP: 002b:00007ffd2a143770 EFLAGS:
> >>> 00000246 ORIG_RAX: 0000000000000010
> >>> Sep 19 22:09:41 sdslinux1 kernel: RAX: ffffffffffffffda RBX:
> >>> 0000000000000004 RCX: 00007f8ea7922b4f
> >>> Sep 19 22:09:41 sdslinux1 kernel: RDX: 00007ffd2a143890 RSI:
> >>> 0000000040489426 RDI: 0000000000000004
> >>> Sep 19 22:09:41 sdslinux1 kernel: RBP: 00000000000079c2 R08:
> >>> 00007f8ea78006c0 R09: 00007ffd2a1436e7
> >>> Sep 19 22:09:41 sdslinux1 kernel: R10: 0000000000000008 R11:
> >>> 0000000000000246 R12: 00007ffd2a144aa8
> >>> Sep 19 22:09:41 sdslinux1 kernel: R13: 0000000000000003 R14:
> >>> 0000559b669962e0 R15: 0000000000000004
> >>> Sep 19 22:09:41 sdslinux1 kernel:  </TASK>
> >>> Sep 19 22:09:41 sdslinux1 kernel: ---[ end trace 0000000000000000 ]--=
-
> >>>
> >>> Thanks in advance,
> >>>
> >>> David Arendt
> >>>
> >
> >
> Hi,
>
> I have seen that your patch has not been included in 6.11.1 and 6.11.2.
>
> I don't know if it has been forgotten somewhere or if there is another
> reason for it ?

The patch was sent to Linus on friday:

https://lore.kernel.org/linux-btrfs/cover.1728050979.git.dsterba@suse.com/

In order for a patch to reach a stable release, first a maintainer has
to pick it, send a pull request to Linus, Linus has to merge it, than
after a rc is released with that fix (in this case 6.12-rc2), the
stable maintainers will pick the patch for the next stable releases.
So yes, it takes some time. Maybe by the end of this week there will
be a 6.11.3 with the fix included.
Sorry can't do anything about that to speedup the process.


>
> Thanks in advance,
>
> David Arendt
>

