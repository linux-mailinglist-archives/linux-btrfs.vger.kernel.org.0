Return-Path: <linux-btrfs+bounces-2356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BBB853974
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 19:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141741C20F48
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 18:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36F2605A3;
	Tue, 13 Feb 2024 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="K59BKrj5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C7605B1
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847669; cv=none; b=tbNLHys6WVAAWi9U9vz2RJ1lwyFrdRQO2RAGJfLBompJ6vBSpwJd41bxDl1u+WVsWCCGF7JgZDuXdxeEOBeqC8HOiCfqjkkuJNWwxGL9lUrtxNITZo84WUgqL5YlqcMqQEf/pQpx8xDwohmZEtnaOG5Kk74mFf/ypBK8eCZPFGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847669; c=relaxed/simple;
	bh=GKVeNrA9yuils+2G1kWhycghjhExE/bUly47ujemGG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mV6OVf30o5pw84m6YOG4KmUk7veWSJMK+NI8MC5KGaDswKK1zKJY/Kg/HHaj2JjlxLD2QvXlTLQ+vCcaObfmTaiQnQ1iAyjVXJYCXAu6zzPv2uEIiKXUT5/XKKfgkrGoM4GR7rildIaGzk7NzUw6ISAplGViAqSI7bY9VRtBZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=K59BKrj5; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-686b389b5d6so5254826d6.0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 10:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1707847667; x=1708452467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMEwNuvV8xSHSr9S+h0y0ng7UuVWFwl3nH5xpOumk9E=;
        b=K59BKrj5qyhuTw9OG/NhKlwi08QikmXRWZoVtLSyytgeq7gJlMZFR6X7HNamFWf+99
         R3ODCC4w6TUCYRM/tHO2al92gidnsUaAXeBkeGybZYjzxDpPjUn/i63GaU5uL7MX276Y
         ZFGiWulYcSMRDPJ6Q5TbpLAJbVdVrjtfXgTpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847667; x=1708452467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMEwNuvV8xSHSr9S+h0y0ng7UuVWFwl3nH5xpOumk9E=;
        b=hYSdC8su40Si1QIYK2P7drmY8kS+rnqKREN8iua329sCjLHoHwLd1sKuD1fKJ7r43S
         puArVA4EUpkq7yKc4UhUR+r9zX5AQemL6E8Jhl4gKeJX3O7UYUUX1VTMiDKTpAnNw8OG
         oN4YSoey7ZM4Rl5vJyxU/lEBOoz/zz4EzSi08cwWfm84fujTuO/nxVfJi/oR1SdK9rMU
         pXv+AZfj5apYfL6ycod07yH/7W5lp4TgZxBCKRN/+XkpRuamg/PABlSN1RtH3EU5Td1k
         4v/yRQTD1S3m0D7j6s80uYgiz1dee7PKsFiCZ2+7Ziu5ZJPVSWMtkaxN4kKZyj5eGmIx
         aSKA==
X-Gm-Message-State: AOJu0YxQa1OBX6UuoRzmUa/dLwT+KieJ4SfMnICbBFAbrCmD22HLn9ZX
	yczZjAs+1HVsgkDj34m5pLCL7xZh5ysOtfYggMXnFTZK9JXa3HxBQ0CMvwH5cvJK4VdUSKIOdxW
	mRf80njD64cuPPvj9H2q+rQUZh9KzlBK8kD0=
X-Google-Smtp-Source: AGHT+IEyA7TVLorUYZRSqmmY9HHKXZTSFYCJ+r/nZYrMMoItBZTkzsxBf8udKKFiSUwadJXoiprqIK99T5C5pIqY89I=
X-Received: by 2002:a05:6214:2b05:b0:68c:40d2:2031 with SMTP id
 jx5-20020a0562142b0500b0068c40d22031mr308455qvb.19.1707847666796; Tue, 13 Feb
 2024 10:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8932de78-729c-431a-b371-a858e986066d@gmx.com> <20240206201247.4120-1-tavianator@tavianator.com>
 <60724d87-293d-495f-92ed-80032dab5c47@gmx.com> <CABg4E-=A+Ga2RtTW4tdJUhTQSNtg3HAvSYmGQaoPKJ-qh-UVJA@mail.gmail.com>
 <2cddff2a-ac98-44b3-a689-3f640d0e4427@gmx.com>
In-Reply-To: <2cddff2a-ac98-44b3-a689-3f640d0e4427@gmx.com>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Tue, 13 Feb 2024 13:07:35 -0500
Message-ID: <CABg4E-kqfkX3nyVdcSsgucmcxdcJRMfH+ahVBR+bYXJyd0y53g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit
 something wrong
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 4:53=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
> On 2024/2/7 08:18, Tavian Barnes wrote:
> > On Tue, Feb 6, 2024 at 3:40=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
> >> On 2024/2/7 06:42, Tavian Barnes wrote:
> >>> On Tue, 6 Feb 2024 16:24:32 +1030, Qu Wenruo wrote:
> >>>> Maybe it's missing some fixes not yet in upstream?
> >>>> My current guess is related to my commit 09e6cef19c9f ("btrfs: refac=
tor
> >>>> alloc_extent_buffer() to allocate-then-attach method"), but since I =
can
> >>>> not reproduce it, it's only a guess...
> >>>
> >>> That's possible!  I tried to follow the existing code in
> >>> alloc_extent_buffer() but didn't see any obvious races.  I will try a=
gain
> >>> with the for-next tree and report back.
> >>
> >> The most obvious way to proof is, if you can reproduce it really
> >> reliably, then just go back to that commit and verify (it can still
> >> cause the problem).
> >> Then go one commit before for, and verify it doesn't cause the problem
> >> anymore.
> >
> > I just tried the tip of btrfs/for-next (6a1dc34172e0, "btrfs: move
> > transaction abort to the error site btrfs_rebuild_free_space_tree()"),
> > plus the dump_page() patch, and it still reproduces:
> >
> >      BTRFS critical (device dm-2): inode mode mismatch with dir: inode
> > mode=3D0142721 btrfs type=3D6 dir type=3D1
> >      page:000000004209c922 refcount:4 mapcount:0
> > mapping:000000007cadbbf5 index:0x8379d17c pfn:0x13ca315
> >      memcg:ffff8f2cba7d0000
> >      aops:btree_aops [btrfs] ino:1
> >      flags: 0x12ffff180000820c(referenced|uptodate|workingset|private|n=
ode=3D2|zone=3D2|lastcpupid=3D0xffff)
> >      page_type: 0xffffffff()
> >      raw: 12ffff180000820c 0000000000000000 dead000000000122 ffff8f1d44=
6218a0
> >      raw: 000000008379d17c ffff8f2faa26ea50 00000004ffffffff ffff8f2cba=
7d0000
> >      page dumped because: eb page dump
> >      BTRFS critical (device dm-2): corrupted leaf, root=3D518
> > block=3D9034951802880 owner mismatch, have 15999665770497355816 expect
> > [256, 18446744073709551360]
> >
> > Is it still worth trying that specific commit?  I'm guessing not.
>
> Yes, still worthy.
>
> The btrfs/for-next contains that commit (which is already upstreamed).
> That patch itself has some bugs fixed early (before hitting upstream),
> but since it's touching the whole memory management of tree blocks, it
> is still the best possible culprit.

Ah okay, I see what you mean.  Unfortunately it still reproduces on
both that commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer()
to allocate-then-attach method"), and the commit before it
2b0122aaa800 ("btrfs: sysfs: validate scrub_speed_max value").

I tried to bisect but I don't know where to start from.  It still
reproduces all the way back to v6.5, although with a different splat:

    RIP: 0010:btrfs_bin_search+0xd7/0x1d0 [btrfs]
    Code: c2 65 48 89 d0 25 ff 0f 00 00 48 83 c0 11 48 3d 00 10 00 00
0f 87 ae 00 00 00 48 89 d0 48 03 13 48 c1 e8 0c 81 e2 ff 0f 00 00 <48>
8b 44 c3 70 48 2b 05 35 3c c3 fa 48 c1 f8 06 48 c1 e0 0c 48 03
    RSP: 0018:ffffbd8d5d7537c0 EFLAGS: 00010206
    RAX: 000ffffffff9a33e RBX: ffff99872a9e6690 RCX: ffffbd8d5d753860
    RDX: 00000000000000d1 RSI: 0000000000000000 RDI: ffff99872a9e6690
    RBP: 0000000061c382ec R08: ffff99872a9e6690 R09: 0000083e36760000
    R10: ffffbd8d5d753758 R11: 0000000000001000 R12: 00000000c38705d9
    R13: 0000000000000000 R14: ffffbd8d5d75392f R15: 0000000000000021
    FS:  00007f3d627f96c0(0000) GS:ffff99a57ecc0000(0000) knlGS:00000000000=
00000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007f3d65db3010 CR3: 000000010fcd6000 CR4: 0000000000350ee0
    Call Trace:
     <TASK>
     ? die_addr+0x36/0x90
     ? exc_general_protection+0x1c5/0x430
     ? asm_exc_general_protection+0x26/0x30
     ? btrfs_bin_search+0xd7/0x1d0 [btrfs
698563e3c4412867d9f65411f4b3f353931d836b]
     btrfs_search_slot+0x458/0xd00 [btrfs
698563e3c4412867d9f65411f4b3f353931d836b]
     btrfs_lookup_inode+0x55/0xe0 [btrfs
698563e3c4412867d9f65411f4b3f353931d836b]
     btrfs_read_locked_inode+0x52a/0x610 [btrfs
698563e3c4412867d9f65411f4b3f353931d836b]
     btrfs_iget_path+0x93/0xe0 [btrfs 698563e3c4412867d9f65411f4b3f353931d8=
36b]
     btrfs_lookup_dentry+0x394/0x630 [btrfs
698563e3c4412867d9f65411f4b3f353931d836b]
     ? d_alloc_parallel+0x230/0x3f0
     btrfs_lookup+0x12/0x30 [btrfs 698563e3c4412867d9f65411f4b3f353931d836b=
]
     __lookup_slow+0x86/0x130
     walk_component+0xdb/0x150
     path_lookupat+0x6a/0x1a0
     filename_lookup+0xe8/0x1f0
     vfs_statx+0x9e/0x180
     do_statx+0x66/0xb0
     io_statx+0x27/0x40
     io_issue_sqe+0x63/0x3c0
     io_wq_submit_work+0x89/0x2c0
     io_worker_handle_work+0x189/0x560
     io_wq_worker+0x10a/0x360
     ? srso_return_thunk+0x5/0x10
     ? __pfx_io_wq_worker+0x10/0x10
     ret_from_fork+0x34/0x50
     ? __pfx_io_wq_worker+0x10/0x10
     ret_from_fork_asm+0x1b/0x30
     </TASK>
    Modules linked in: xt_conntrack xt_comment veth rpcrdma rdma_cm
iw_cm ib_cm ib_core cmac algif_hash algif_skcipher nct6775 af_alg
nct6775_core hwmon_vid bnep lm92 nls_iso8859_1 vfat fat intel_rapl_msr
intel_rapl_common amd64_edac edac_mce_amd snd_hda_codec_hdmi kvm_amd
uvcvideo snd_hda_intel snd_intel_dspcfg uvc snd_intel_sdw_acpi
snd_usb_audio gspca_vc032x snd_hda_codec gspca_main btusb
snd_usbmidi_lib snd_hda_core kvm btrtl videobuf2_vmalloc snd_ump btbcm
videobuf2_memops snd_rawmidi snd_hwdep btintel videobuf2_v4l2
snd_seq_device btmtk videodev snd_pcm bluetooth mxm_wmi wmi_bmof
videobuf2_common snd_timer irqbypass rapl snd mc ecdh_generic pcspkr
acpi_cpufreq sp5100_tco crc16 soundcore i2c_piix4 k10temp mousedev
joydev wmi mac_hid nfsd auth_rpcgss nfs_acl lockd usbip_host
usbip_core pkcs8_key_parser grace i2c_dev sg sunrpc crypto_user fuse
loop btrfs blake2b_generic xor raid6_pq dm_crypt cbc encrypted_keys
trusted asn1_encoder tee xt_MASQUERADE xt_tcpudp xt_mark uas
usb_storage hid_logitech_hidpp dm_mod
     tun hid_logitech_dj usbhid crct10dif_pclmul crc32_pclmul
polyval_clmulni polyval_generic gf128mul ghash_clmulni_intel
sha512_ssse3 iwlwifi igb aesni_intel nvme crypto_simd ccp cryptd
sr_mod i2c_algo_bit nvme_core xhci_pci cdrom dca xhci_pci_renesas
bridge nf_tables stp llc ip6table_nat ip6table_filter ip6_tables
cfg80211 iptable_nat nf_nat nf_conntrack rfkill nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c crc32c_generic crc32c_intel iptable_filter
nfnetlink ip_tables x_tables
    ---[ end trace 0000000000000000 ]---
    RIP: 0010:btrfs_bin_search+0xd7/0x1d0 [btrfs]
    Code: c2 65 48 89 d0 25 ff 0f 00 00 48 83 c0 11 48 3d 00 10 00 00
0f 87 ae 00 00 00 48 89 d0 48 03 13 48 c1 e8 0c 81 e2 ff 0f 00 00 <48>
8b 44 c3 70 48 2b 05 35 3c c3 fa 48 c1 f8 06 48 c1 e0 0c 48 03
    RSP: 0018:ffffbd8d5d7537c0 EFLAGS: 00010206
    RAX: 000ffffffff9a33e RBX: ffff99872a9e6690 RCX: ffffbd8d5d753860
    RDX: 00000000000000d1 RSI: 0000000000000000 RDI: ffff99872a9e6690
    RBP: 0000000061c382ec R08: ffff99872a9e6690 R09: 0000083e36760000
    R10: ffffbd8d5d753758 R11: 0000000000001000 R12: 00000000c38705d9
    R13: 0000000000000000 R14: ffffbd8d5d75392f R15: 0000000000000021
    FS:  00007f3d627f96c0(0000) GS:ffff99a57ecc0000(0000) knlGS:00000000000=
00000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007feb3489f960 CR3: 000000010fcd6000 CR4: 0000000000350ee0
    BTRFS critical (device dm-3): corrupted node, root=3D518
block=3D17613216952440067356 owner mismatch, have 16303017448389165215
expect [256, 18446744073709551360]

--=20
Tavian Barnes

