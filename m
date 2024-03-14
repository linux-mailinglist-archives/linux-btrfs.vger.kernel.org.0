Return-Path: <linux-btrfs+bounces-3309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6387C43F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 21:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40F7B2189E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 20:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2414762C6;
	Thu, 14 Mar 2024 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="HZmvRiYu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2E73196
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710447931; cv=none; b=a/zJ7QzykussMFa5s/vlW1nrEC+FLrrlEgRXroRv4QbNtOlXEUIgLPgXJSdmnB6uwPzY7lB/qqMdar1CRkG2dZl1pAPxGvAZBTH2/rZxpZsJeMFnb2SVblJuAhX1Iuxg197dmNmUVWb4GvtAxUD/fFkjzhKP8wVmd255HwKHUdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710447931; c=relaxed/simple;
	bh=P3AfzyoIK8U4GSuKdrtS9IqBzh2JTijJXZbxDBschsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLSvqBNIdniehzXlimgRssHyHFRuLucMLV/7bTHx4oA6PY/rb9hblejR9e+Y4FUvycOP+7hCIgd4mOikEsEfqnFhLULXJkABftmy1y6/32MKUGvkHf+Dk0sl8JeFqDIYv/hALb+CkPpQ8pEhBbGZY/kNjh+Xs6kG7lCA03p4o/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=HZmvRiYu; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7db1a21e83fso664554241.2
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1710447929; x=1711052729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pPsCfapRfbrazGqznBlcJ+ih3d+4HxRKDCUstoyeoA=;
        b=HZmvRiYuXB3opkXjJAzJod2doC8pj2yVuHlUW0OlupPZd4DhFFEqTPxsNy7d8+0REb
         kj+LtHOz1BVJl+K2tN8iXOH/QZ1k+DBMqnj5QdD6lvNVMNrLpmcHIL1aLXqfTUE0PSeR
         Ql1u2tO7vwDm9oQ/A695nuZce5tUq0QsWKSTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710447929; x=1711052729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pPsCfapRfbrazGqznBlcJ+ih3d+4HxRKDCUstoyeoA=;
        b=BwJceLQiVnS5MYGr9HG+toLAmom0TfQyM2c5dYGsI+mjKj1ZN6uw5oJ01SSNzPb2Ux
         Cysiq4wsTsAyYKfCmtFdCa34PSIavWKeeTHnnatS7qHOOLHtUGL58Wkmjfs0jnC6hnxs
         s4rzRP8KfQB4iCiU/vjF7FViFnun3kMrESmua6lYYmOWJnryLMwQ1PZpcaSg3Li95W/p
         RjVZsmgw+ga/CRQESFkBVyn6VOGqybj2d2xCOaOJKXza/u5EpcnP1VhhkS67hft+Y2zD
         3vhqkrAJwrjoV/iHa//uyIEvAuP+h1/EfrupuSq8jePwdIEjGXN5Mi/L19+sgDq8N2pj
         uDLw==
X-Gm-Message-State: AOJu0YyjSYIqizFpVXoDY6P+eAnInZ44yzEN/i+g+KJQdQzWDWeSTpsY
	0LUbc+HPVg4KJJfgYIVBZO/cymGOXaTLm4AGfMb7inTlXkNxYJ4sPYMajHFwhi5OXw6vUhLqezO
	0JcJIEfYg7NNHHinKQ9A2qThx5gVsTgg50qc=
X-Google-Smtp-Source: AGHT+IHBDOreVbhaRz/6PUAsvKbaJdiIqGHiARcuOvW0AetuBC99KPOY50YEnhbIqSDrBWRom9rw0gmcQVM2CJ0PkCA=
X-Received: by 2002:a05:6102:c48:b0:474:cea1:86b3 with SMTP id
 y8-20020a0561020c4800b00474cea186b3mr1798272vss.0.1710447928809; Thu, 14 Mar
 2024 13:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7241ea4-fcc6-48d2-98c8-b5ea790d6c89@gmx.com> <CABg4E-=y_rCMSsA8=T7zXzfHJwNLMROGpVbKOW68jzLqLcTLGw@mail.gmail.com>
 <CABg4E-nJ8MDOdBDEpJFhZtjUPtqGTmRPieGSg-NMceJ7EZCD-A@mail.gmail.com>
In-Reply-To: <CABg4E-nJ8MDOdBDEpJFhZtjUPtqGTmRPieGSg-NMceJ7EZCD-A@mail.gmail.com>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Thu, 14 Mar 2024 16:25:17 -0400
Message-ID: <CABg4E-nFJs01tYpxB_D=tYz0OaRJ_euq45CKFJtcuD=xWbsxBw@mail.gmail.com>
Subject: Re: About the weird tree block corruption
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 2:42=E2=80=AFPM Tavian Barnes <tavianator@tavianato=
r.com> wrote:
> On Thu, Mar 14, 2024 at 1:44=E2=80=AFPM Tavian Barnes <tavianator@taviana=
tor.com> wrote:
> > On Wed, Mar 13, 2024 at 2:07=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
> > > Hi Tavian,
> > >
> > > Thanks for all the awesome help debugging the weird tree block corrup=
tion.
> > > And sorry for the late reply.
> >
> > No worries, thanks for your help!
> >
> > > Unfortunately I still failed to reproduce the bug, so I can only craf=
t a
> > > debug patchset for you to test.
> >
> > Good news: I also failed to reproduce the bug on the latest
> > btrfs/for-next branch (ec616f34eba1 "btrfs: do not skip
> > re-registration for the mounted device").  It was still reproducing
> > the last time I pulled btrfs/for-next (09e6cef19c9f "btrfs: refactor
> > alloc_extent_buffer() to allocate-then-attach method").

Actually I have to walk all of this back.  I can still reproduce the
bug on ec616f34eba1.  I can't reproduce it on that commit *plus your
debugging patch* (btrfs: add extra debug for eb read path), which
points to maybe a timing issue/race window closing.

Additionally, shortly after reproducing the bug on ec616f34eba1, I got
this splat:

[  119.257741] BTRFS critical (device dm-2): corrupted node, root=3D518
block=3D16438782945911875046 owner mismatch, have 4517169229596899607
expect [256, 18446744073709551360]
[  119.257764] BTRFS critical (device dm-2): corrupted node, root=3D518
block=3D16438782945911875046 owner mismatch, have 4517169229596899607
expect [256, 18446744073709551360]
[  119.257775] BTRFS critical (device dm-2): corrupted node, root=3D518
block=3D16438782945911875046 owner mismatch, have 4517169229596899607
expect [256, 18446744073709551360]
[  119.257773] BTRFS critical (device dm-2): corrupted node, root=3D518
block=3D16438782945911875046 owner mismatch, have 4517169229596899607
expect [256, 18446744073709551360]
[  119.257782] BTRFS critical (device dm-2): corrupted node, root=3D518
block=3D16438782945911875046 owner mismatch, have 4517169229596899607
expect [256, 18446744073709551360]
[  119.257787] BTRFS critical (device dm-2): corrupted node, root=3D518
block=3D16438782945911875046 owner mismatch, have 4517169229596899607
expect [256, 18446744073709551360]
[  178.564993] ------------[ cut here ]------------
[  178.567792] BTRFS: Transaction aborted (error -17)
[  178.570606] WARNING: CPU: 2 PID: 5191 at fs/btrfs/inode.c:6450
btrfs_create_new_inode+0xa46/0xa70 [btrfs]
[  178.573433] Modules linked in: vhost_net vhost vhost_iotlb tap
xt_addrtype xt_conntrack xt_comment veth rpcrdma rdma_cm cmac iw_cm
algif_hash nct6775 algif_skcipher ib_cm nct6775_core af_alg ib_core
bnep hwmon_vid lm92 uvcvideo uvc intel_rapl_msr intel_rapl_common
amd64_edac edac_mce_amd snd_hda_codec_hdmi kvm_amd snd_hda_intel btusb
snd_intel_dspcfg btrtl snd_intel_sdw_acpi gspca_vc032x btintel
snd_usb_audio snd_hda_codec btbcm gspca_main kvm btmtk
videobuf2_vmalloc snd_usbmidi_lib nls_iso8859_1 videobuf2_memops
snd_ump videobuf2_v4l2 snd_hda_core snd_rawmidi vfat videodev
bluetooth irqbypass snd_hwdep snd_seq_device fat videobuf2_common mc
snd_pcm ecdh_generic crc16 snd_timer rapl wmi_bmof acpi_cpufreq
sp5100_tco pcspkr snd soundcore k10temp i2c_piix4 mousedev joydev
mac_hid nfsd usbip_host usbip_core pkcs8_key_parser auth_rpcgss
i2c_dev sg nfs_acl lockd crypto_user grace fuse loop sunrpc btrfs
blake2b_generic xor raid6_pq dm_crypt cbc encrypted_keys trusted
asn1_encoder tee xt_MASQUERADE xt_tcpudp xt_mark
[  178.573514]  hid_logitech_hidpp hid_logitech_dj dm_mod tun uas
crct10dif_pclmul crc32_pclmul polyval_clmulni usb_storage
polyval_generic gf128mul ghash_clmulni_intel sha512_ssse3 usbhid
sha256_ssse3 sha1_ssse3 aesni_intel nvme igb bridge iwlwifi
crypto_simd nvme_core mxm_wmi ccp sr_mod cryptd dca xhci_pci cdrom
i2c_algo_bit xhci_pci_renesas nvme_auth stp wmi llc nf_tables cfg80211
ip6table_nat ip6table_filter ip6_tables iptable_nat nf_nat
nf_conntrack rfkill nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c
crc32c_generic crc32c_intel iptable_filter nfnetlink ip_tables
x_tables
[  178.600199] CPU: 2 PID: 5191 Comm: git Not tainted
6.8.0-rc7-euclean+ #15 6731aa79f7b285a380c42229104b62a18d4313c1
[  178.603981] Hardware name: Micro-Star International Co., Ltd.
MS-7C60/TRX40 PRO WIFI (MS-7C60), BIOS 2.80 05/17/2022
[  178.607815] RIP: 0010:btrfs_create_new_inode+0xa46/0xa70 [btrfs]
[  178.611667] Code: cc 0a 00 c7 44 24 0c 01 00 00 00 e9 fc fb ff ff
41 bc f4 ff ff ff e9 a4 f8 ff ff 44 89 e6 48 c7 c7 48 00 3b c1 e8 1a
e7 c4 c2 <0f> 0b eb a4 44 89 e6 48 c7 c7 48 00 3b c1 e8 07 e7 c4 c2 0f
0b eb
[  178.615664] RSP: 0018:ffffbb8edf8afad8 EFLAGS: 00010282
[  178.619577] RAX: 0000000000000000 RBX: ffffbb8edf8afbb8 RCX: 00000000000=
00000
[  178.623516] RDX: ffff8fe8beeae780 RSI: ffff8fe8beea19c0 RDI: ffff8fe8bee=
a19c0
[  178.627458] RBP: ffffbb8edf8afba0 R08: 0000000000000000 R09: ffffbb8edf8=
af960
[  178.631370] R10: 0000000000000003 R11: ffff8fe8bf1df668 R12: 00000000fff=
fffef
[  178.635281] R13: ffff8fc9cdc57d88 R14: ffff8fcb654541f8 R15: ffff8fc9d7c=
07110
[  178.639187] FS:  00007f86d59d9740(0000) GS:ffff8fe8bee80000(0000)
knlGS:0000000000000000
[  178.643131] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  178.647061] CR2: 000055c7d0a7a938 CR3: 000000023e8a8000 CR4: 00000000003=
50ef0
[  178.650998] Call Trace:
[  178.654898]  <TASK>
[  178.658761]  ? btrfs_create_new_inode+0xa46/0xa70 [btrfs
0221bef32b31f5d5536e63a0526995bec5247918]
[  178.662770]  ? __warn+0x81/0x130
[  178.666696]  ? btrfs_create_new_inode+0xa46/0xa70 [btrfs
0221bef32b31f5d5536e63a0526995bec5247918]
[  178.670749]  ? report_bug+0x171/0x1a0
[  178.674761]  ? prb_read_valid+0x1b/0x30
[  178.678786]  ? srso_return_thunk+0x5/0x5f
[  178.682786]  ? handle_bug+0x3c/0x80
[  178.686779]  ? exc_invalid_op+0x17/0x70
[  178.690769]  ? asm_exc_invalid_op+0x1a/0x20
[  178.694773]  ? btrfs_create_new_inode+0xa46/0xa70 [btrfs
0221bef32b31f5d5536e63a0526995bec5247918]
[  178.698925]  ? btrfs_create_new_inode+0xa46/0xa70 [btrfs
0221bef32b31f5d5536e63a0526995bec5247918]
[  178.703008]  btrfs_create_common+0xc4/0x130 [btrfs
0221bef32b31f5d5536e63a0526995bec5247918]
[  178.707133]  path_openat+0xe9f/0x1190
[  178.711196]  do_filp_open+0xb3/0x160
[  178.715254]  do_sys_openat2+0xab/0xe0
[  178.719294]  __x64_sys_openat+0x57/0xa0
[  178.723321]  do_syscall_64+0x89/0x170
[  178.727336]  ? srso_return_thunk+0x5/0x5f
[  178.731356]  ? do_syscall_64+0x96/0x170
[  178.735373]  ? srso_return_thunk+0x5/0x5f
[  178.739387]  ? syscall_exit_to_user_mode+0x80/0x230
[  178.743420]  ? srso_return_thunk+0x5/0x5f
[  178.747434]  ? do_syscall_64+0x96/0x170
[  178.751441]  ? srso_return_thunk+0x5/0x5f
[  178.755450]  ? srso_return_thunk+0x5/0x5f
[  178.759405]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  178.763406] RIP: 0033:0x7f86d5ad6dc0
[  178.767424] Code: 48 89 44 24 20 75 94 44 89 54 24 0c e8 d9 c9 f8
ff 44 8b 54 24 0c 89 da 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00
00 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 89 44 24 0c e8 2c ca f8 ff
8b 44
[  178.771580] RSP: 002b:00007ffcc4791f50 EFLAGS: 00000293 ORIG_RAX:
0000000000000101
[  178.775720] RAX: ffffffffffffffda RBX: 00000000000000c1 RCX: 00007f86d5a=
d6dc0
[  178.779865] RDX: 00000000000000c1 RSI: 000055c7d0a77140 RDI: 00000000fff=
fff9c
[  178.784014] RBP: 000055c7d0a77140 R08: 0000000000000000 R09: 000055c7d0a=
77140
[  178.788152] R10: 00000000000001b6 R11: 0000000000000293 R12: 00007ffcc47=
92360
[  178.792210] R13: 00007ffcc4792000 R14: 000055c7d06bb788 R15: 000055c7d0a=
77140
[  178.796192]  </TASK>
[  178.800079] ---[ end trace 0000000000000000 ]---
[  178.804024] BTRFS: error (device dm-2: state A) in
btrfs_create_new_inode:6450: errno=3D-17 Object already exists

--=20
Tavian Barnes

