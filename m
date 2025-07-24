Return-Path: <linux-btrfs+bounces-15651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29939B0FEB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 04:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BE9581A3E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 02:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0817F2AF0A;
	Thu, 24 Jul 2025 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6ITygNA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186972E36E3
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Jul 2025 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753323346; cv=none; b=fEAeRE4KfA3SEYyF6ynBTpnq0wxB37R1Sh26Lld+2WXtlyNIv0OuaSTLfbNtG3KoohgS6pXaibIOjXkaHQ47y64xx1WOsUUwngzliGC+kVYc5X1LhaLzWoV8VKSdmHVBOwzZpDDQF+m9Mq+togb3irGLV28vQo/3qVobKw+tIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753323346; c=relaxed/simple;
	bh=Ey76gmob6YKQwctKwXUGCQ5PlyFW8hbO7dMYu0mk8LA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=akmsgS/CknJEi1P9q4ta1qUWiTpsclarSRt/9jgFAK3UlQkBecWkhR1FkDeFJkddOvrk/mFJIYIGlcn3gY3VrMDT/NPbmM1hH9tnYjpy70S+VCzTo+TlTJtk8DuIRwGkQWYOKq85X8ntXD+21dtkEiJZqcoLzERzRCNpSC1uWX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6ITygNA; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-73e88bc3728so120518a34.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 19:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753323343; x=1753928143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zpCOpGCz2nkhDsaBXc4cq6PuaZg2MAdayJo+mRe1Ic=;
        b=U6ITygNATaWi+4i8bizxouFdiqYHFbJYADDud3W43c4f2lQuoICEqdeeIzhRRc+XfA
         ZvJ5NwTP9v9rcmMUu1Xgn5teu0REYaeKNfzjE2w1xRAlreSMpY13UoKGJPBJvKXvq+kV
         h8kvNk6jXHR4jZ9Er5QoGNPaxgpaBcwgyQRwlOqzGAOjFEWM9nI9WE5C+IwYw/ANHtDy
         4/N5FFbiteabf6bGbr4kT3Oq0N34Cl7J9i+dhXxykZCOgA4vvVclQ6nejaoLHnlktzvM
         V0atS9NQWA//Y4XDVLbKFq3vMloGKLClqQIi4bZd+61TD/20KBcbN5JbPRywMzFDZKt4
         NnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753323343; x=1753928143;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zpCOpGCz2nkhDsaBXc4cq6PuaZg2MAdayJo+mRe1Ic=;
        b=QAYHCiKmkZoPzCjUEUHH/2t3MgX5J4pTVkqD+vo1ZXsbhjKgjLs7zH6A3OAkVmviFf
         29BbDjfOH6HOOY2DksV8mOxeWYfQtIDODvX+bd22vWHtRDCnf/UIf++dVH7Z6TgvOxnk
         KoJvLPtaqAatCsYr3WWuwUWHkl1q3mt85cmjhSwYRm1m0C1QtmwtgEsCGFmhiDSjIVmF
         oNPH3443nCC8Roeke4nkpiN+XpZkydQTHesN72m3tewgRUeG9sZ57SGHWLAsbJefKUVr
         CaxZC791ylyyHhsXLO7UsCGWa/ss7zEJ/46amvZ7iqtr721hYnYJgau97LJnCVo5Wrw2
         Z6JQ==
X-Gm-Message-State: AOJu0YxjPtIUlHTSgDGcCS+sykF4mXMHEn2vzeyfbY2+H/NsGFOGBnRG
	4oVwILypBUD1FPKJSt3yGG1h0ucz6Y5aONk47EtPGxfyFPQdBtaSt+fE7j+c3A==
X-Gm-Gg: ASbGnctKVJHPI+XWbUIJHDNs2RGnq5FK1ociFYttAlaEE3SKDjr4/CHa69B5WRKaZvI
	YJnKBzJsw9p4CmCtADUdty+qSBm8+IgRGP2njwSXUoktVuWKNuvwY6/5JkErqmaxsR93uC5oNNO
	z1JG57Nwa/1NOvQDcDBuPohUck1ZznCdTluG7l71Ya6alUTr1/lT5jZDbSD+09Mn+jAvuOrYPp7
	8R3ZTUevwNaxyfq2VjK3RZvXNyEjYJ99D17O6wi8vdnZabZSnWSHS0MrzF3ut2g9+dJxGKDgqMD
	GQF83/tguPx95MFf8ALvkG4JFggf9ZgEMtfW1Jme1tzr0Iaw1RhTm+lzHgMkTI4s4uUcbktK6r6
	gxkPDHjX43ObKgLff2q1rfaBuV6IDAj44PnMJwg==
X-Google-Smtp-Source: AGHT+IEM/9JR82JTjnMBgmC2s5YBl6sm7ZJx5Jvm3Nov4HOasF32z/8lgp0XA+3xuqGwLICv7qD3XQ==
X-Received: by 2002:a05:6830:349b:b0:73e:93a2:3ab1 with SMTP id 46e09a7af769-74088990089mr3858783a34.18.1753323342232;
        Wed, 23 Jul 2025 19:15:42 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-306e3971332sm158466fac.0.2025.07.23.19.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 19:15:41 -0700 (PDT)
Message-ID: <c9a94a06-4e1c-431c-bfc2-74371493eb8a@gmail.com>
Date: Wed, 23 Jul 2025 21:15:40 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Null deref during attempted replay of corrupt TREE_LOG in newer
 kernel
From: Russell Haley <yumpusamongus@gmail.com>
To: linux-btrfs@vger.kernel.org
References: <598ecc75-eb80-41b3-83c2-f2317fbb9864@gmail.com>
Content-Language: en-US
Cc: fdmanana@suse.com
In-Reply-To: <598ecc75-eb80-41b3-83c2-f2317fbb9864@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gentle ping.

@Filipe You've recently submitted a cleanup of the log replay code, so I
assume you're familiar with it. Is there anything Funny Lookin' in the
path that handles a corrupt TREE_LOG? Would've changed sometime between
6.14.9 and 6.15.4.

Thanks,

Russell

On 7/13/25 12:02 PM, Russell Haley wrote:
> Howdy,
>=20
> After a power outage, my computer booted into emergency mode, apparentl=
y
> due to a corrupt log tree on the root SSD (WD Blue, WDC
> WDS500G2B0C-00PXH0). Symptoms basically identical to [1], and I was
> eventually able to fix it the same way, with btrfs rescue zero-log.
>=20
> *However*, troubleshooting was complicated by the fact that, on kernel
> 6.15.4, attempting to mount the corrupt FS even once OOPSed the kernel
> and locked the device, making it impossible to run btrfs commands
> against it or try different mount options.  This would've been a
> showstopper if I didn't have Fedora's backup kernels to try and see tha=
t
> the dmesg error was different. That led me to boot into a live USB with=

> kernel 6.14.0, from which I was able to investigate.  I then booted int=
o
> backup kernel 6.14.9 (the newest non-problematic) and zeroed the log.
>=20
> Facts:
>=20
> 1. Kernel 6.15.4 has the null deref.
>=20
> 2. Kernel 6.14.9 does not.
>=20
> 3. mount -o ro,rescue=3Dnologreplay succeeds on kernel 6.14.0 (from liv=
e
> USB) and 6.15.4 (newer live USB). On 6.15.4, it succeeds if it is the
> first mount command run.
>=20
> Here's all the evidence I collected before zeroing the log so I could
> have a working PC again. It's the log from the bad kernel, one good
> kernel, and btrfs inspect-internal dump-super and dump-tree of the
> corrupted disk
>=20
> Log from kernel 6.15.4:
>=20
>> Jul 13 04:25:26 localhost-live kernel: BTRFS: device label fedora_hogw=
arts devid 1 transid 456817 /dev/mapper/hogwarts-root (252:1) scanned by =
mount (4794)
>> Jul 13 04:25:26 localhost-live kernel: BTRFS info (device dm-1): first=
 mount of filesystem a6999502-9362-4fa7-b7b4-28095790217d
>> Jul 13 04:25:26 localhost-live kernel: BTRFS info (device dm-1): using=
 crc32c (crc32c-x86_64) checksum algorithm
>> Jul 13 04:25:26 localhost-live kernel: BTRFS info (device dm-1): using=
 free-space-tree
>> Jul 13 04:25:26 localhost-live kernel: BTRFS info (device dm-1): bdev =
/dev/mapper/hogwarts-root errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
>> Jul 13 04:25:26 localhost-live kernel: BTRFS info (device dm-1): start=
 tree-log replay
>> Jul 13 04:25:26 localhost-live kernel: BUG: kernel NULL pointer derefe=
rence, address: 0000000000000219
>> Jul 13 04:25:26 localhost-live kernel: #PF: supervisor read access in =
kernel mode
>> Jul 13 04:25:26 localhost-live kernel: #PF: error_code(0x0000) - not-p=
resent page
>> Jul 13 04:25:26 localhost-live kernel: PGD 0 P4D 0
>> Jul 13 04:25:26 localhost-live kernel: Oops: Oops: 0000 [#1] SMP PTI
>> Jul 13 04:25:26 localhost-live kernel: CPU: 0 UID: 0 PID: 4794 Comm: m=
ount Not tainted 6.15.4-200.fc42.x86_64 #1 PREEMPT(lazy)
>> Jul 13 04:25:26 localhost-live kernel: Hardware name: To Be Filled By =
O.E.M. To Be Filled By O.E.M./Z87 Extreme4, BIOS P3.50 03/11/2018
>> Jul 13 04:25:26 localhost-live kernel: RIP: 0010:iput+0x20/0x230
>> Jul 13 04:25:26 localhost-live kernel: Code: 90 90 90 90 90 90 90 90 9=
0 90 f3 0f 1e fa 0f 1f 44 00 00 48 85 ff 0f 84 86 01 00 00 41 54 55 48 8d=
 af 50 01 00 00 53 48 89 fb <f6> 87 91 00 00 00 01 74 3a e9 68 01 00 00 8=
b 53 48 8b 83 90 00 00
>> Jul 13 04:25:26 localhost-live kernel: RSP: 0018:ffffd43c0b893740 EFLA=
GS: 00010206
>> Jul 13 04:25:26 localhost-live kernel: RAX: 0000000000000000 RBX: 0000=
000000000188 RCX: 000000000092a000
>> Jul 13 04:25:26 localhost-live kernel: RDX: 0000000000000000 RSI: ffff=
ffff93bcea60 RDI: 0000000000000188
>> Jul 13 04:25:26 localhost-live kernel: RBP: 00000000000002d8 R08: 0000=
000000000000 R09: ffffffff90db25b6
>> Jul 13 04:25:26 localhost-live kernel: R10: ffff8c4aa9480000 R11: ffff=
f60205a52000 R12: ffffd43c0b8938bf
>> Jul 13 04:25:26 localhost-live kernel: R13: 0000000000000000 R14: ffff=
8c4aa9476690 R15: 00000000fffffffb
>> Jul 13 04:25:26 localhost-live kernel: FS:  00007f1b5f3f9840(0000) GS:=
ffff8c4fc3a71000(0000) knlGS:0000000000000000
>> Jul 13 04:25:26 localhost-live kernel: CS:  0010 DS: 0000 ES: 0000 CR0=
: 0000000080050033
>> Jul 13 04:25:26 localhost-live kernel: CR2: 0000000000000219 CR3: 0000=
00016abc8003 CR4: 00000000001726f0
>> Jul 13 04:25:26 localhost-live kernel: Call Trace:
>> Jul 13 04:25:26 localhost-live kernel:  <TASK>
>> Jul 13 04:25:26 localhost-live kernel:  replay_one_extent+0xba/0x740
>> Jul 13 04:25:26 localhost-live kernel:  ? release_extent_buffer+0xb5/0=
xd0
>> Jul 13 04:25:26 localhost-live kernel:  ? copy_extent_buffer+0x126/0x1=
60
>> Jul 13 04:25:26 localhost-live kernel:  ? btrfs_release_path+0x2b/0x1b=
0
>> Jul 13 04:25:26 localhost-live kernel:  replay_one_buffer+0x2ee/0x500
>> Jul 13 04:25:26 localhost-live kernel:  ? alloc_extent_buffer+0x97/0x5=
00
>> Jul 13 04:25:26 localhost-live kernel:  ? read_extent_buffer+0x102/0x1=
40
>> Jul 13 04:25:26 localhost-live kernel:  walk_down_log_tree+0x1d8/0x4c0=

>> Jul 13 04:25:26 localhost-live kernel:  ? kmem_cache_alloc_noprof+0x14=
1/0x410
>> Jul 13 04:25:26 localhost-live kernel:  walk_log_tree+0xe6/0x280
>> Jul 13 04:25:26 localhost-live kernel:  btrfs_recover_log_trees+0x1cc/=
0x5a0
>> Jul 13 04:25:26 localhost-live kernel:  ? __pfx_replay_one_buffer+0x10=
/0x10
>> Jul 13 04:25:26 localhost-live kernel:  open_ctree+0x912/0xb98
>> Jul 13 04:25:26 localhost-live kernel:  btrfs_get_tree_super.cold+0xb/=
0xbf
>> Jul 13 04:25:26 localhost-live kernel:  vfs_get_tree+0x29/0xd0
>> Jul 13 04:25:26 localhost-live kernel:  fc_mount+0x12/0x40
>> Jul 13 04:25:26 localhost-live kernel:  btrfs_get_tree_subvol+0x10d/0x=
210
>> Jul 13 04:25:26 localhost-live kernel:  vfs_get_tree+0x29/0xd0
>> Jul 13 04:25:26 localhost-live kernel:  vfs_cmd_create+0x57/0xd0
>> Jul 13 04:25:26 localhost-live kernel:  __do_sys_fsconfig+0x4b1/0x640
>> Jul 13 04:25:26 localhost-live kernel:  do_syscall_64+0x7b/0x160
>> Jul 13 04:25:26 localhost-live kernel:  ? __check_object_size.part.0+0=
x59/0xc0
>> Jul 13 04:25:26 localhost-live kernel:  ? _copy_from_user+0x27/0x60
>> Jul 13 04:25:26 localhost-live kernel:  ? lookup_constant+0x35/0x50
>> Jul 13 04:25:26 localhost-live kernel:  ? vfs_parse_fs_param+0x30/0x10=
0
>> Jul 13 04:25:26 localhost-live kernel:  ? __do_sys_fsconfig+0x354/0x64=
0
>> Jul 13 04:25:26 localhost-live kernel:  ? syscall_exit_to_user_mode+0x=
10/0x210
>> Jul 13 04:25:26 localhost-live kernel:  ? do_syscall_64+0x87/0x160
>> Jul 13 04:25:26 localhost-live kernel:  ? syscall_exit_to_user_mode+0x=
10/0x210
>> Jul 13 04:25:26 localhost-live kernel:  ? do_syscall_64+0x87/0x160
>> Jul 13 04:25:26 localhost-live kernel:  ? __do_sys_newfstatat+0x4b/0x8=
0
>> Jul 13 04:25:26 localhost-live kernel:  ? syscall_exit_to_user_mode+0x=
10/0x210
>> Jul 13 04:25:26 localhost-live kernel:  ? do_syscall_64+0x87/0x160
>> Jul 13 04:25:26 localhost-live kernel:  ? syscall_exit_to_user_mode+0x=
10/0x210
>> Jul 13 04:25:26 localhost-live kernel:  ? do_syscall_64+0x87/0x160
>> Jul 13 04:25:26 localhost-live kernel:  ? do_syscall_64+0x87/0x160
>> Jul 13 04:25:26 localhost-live kernel:  ? do_syscall_64+0x87/0x160
>> Jul 13 04:25:26 localhost-live kernel:  ? exc_page_fault+0x7e/0x1a0
>> Jul 13 04:25:26 localhost-live kernel:  entry_SYSCALL_64_after_hwframe=
+0x76/0x7e
>> Jul 13 04:25:26 localhost-live kernel: RIP: 0033:0x7f1b5f5d7abe
>> Jul 13 04:25:26 localhost-live kernel: Code: 73 01 c3 48 8b 0d 4a 33 0=
f 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49=
 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1a 33 0=
f 00 f7 d8 64 89 01 48
>> Jul 13 04:25:26 localhost-live kernel: RSP: 002b:00007ffe53604898 EFLA=
GS: 00000246 ORIG_RAX: 00000000000001af
>> Jul 13 04:25:26 localhost-live kernel: RAX: ffffffffffffffda RBX: 0000=
556b3a8eb560 RCX: 00007f1b5f5d7abe
>> Jul 13 04:25:26 localhost-live kernel: RDX: 0000000000000000 RSI: 0000=
000000000006 RDI: 0000000000000003
>> Jul 13 04:25:26 localhost-live kernel: RBP: 00007ffe536049e0 R08: 0000=
000000000000 R09: 0000000000000003
>> Jul 13 04:25:26 localhost-live kernel: R10: 0000000000000000 R11: 0000=
000000000246 R12: 0000000000000000
>> Jul 13 04:25:26 localhost-live kernel: R13: 0000556b3a8eba00 R14: 0000=
7f1b5f754b00 R15: 0000556b3a8ed498
>> Jul 13 04:25:26 localhost-live kernel:  </TASK>
>> Jul 13 04:25:26 localhost-live kernel: Modules linked in: f2fs dm_cryp=
t uinput rfcomm snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conn=
track_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject=
_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_na=
t nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr snd_hda_codec=
_realtek snd_hda_codec_generic snd_hda_codec_hdmi bnep snd_hda_scodec_com=
ponent snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi btusb snd_hda_co=
dec btrtl btintel intel_rapl_msr snd_hda_core btbcm uvcvideo intel_rapl_c=
ommon snd_usb_audio btmtk snd_usbmidi_lib snd_ump snd_rawmidi x86_pkg_tem=
p_thermal snd_hwdep intel_powerclamp bluetooth snd_seq uvc videobuf2_vmal=
loc coretemp videobuf2_memops videobuf2_v4l2 kvm_intel snd_seq_device vid=
eobuf2_common snd_pcm videodev mei_hdcp mei_pxp iTCO_wdt intel_pmc_bxt at=
24 snd_timer mei_me iTCO_vendor_support kvm snd mei mc i2c_i801 joydev i2=
c_smbus pcspkr lpc_ich rfkill apple_mfi_fastcharge irqbypass rapl intel_c=
state intel_uncore soundcore nfnetlink
>> Jul 13 04:25:26 localhost-live kernel:  zram lz4hc_compress lz4_compre=
ss overlay erofs netfs hid_logitech_hidpp isofs amdgpu hid_logitech_dj i9=
15 mxm_wmi amdxcp polyval_clmulni gpu_sched polyval_generic drm_panel_bac=
klight_quirks ghash_clmulni_intel drm_ttm_helper drm_buddy sha512_ssse3 t=
tm drm_exec sha256_ssse3 i2c_algo_bit uas drm_suballoc_helper sha1_ssse3 =
hid_apple usb_storage drm_display_helper e1000e nvme cec nvme_tcp nvme_fa=
brics nvme_core video wmi nvme_keyring nvme_auth sunrpc be2iscsi bnx2i cn=
ic uio cxgb4i cxgb4 tls cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_=
boot_sysfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi loop fuse=
 i2c_dev
>> Jul 13 04:25:26 localhost-live kernel: CR2: 0000000000000219
>> Jul 13 04:25:26 localhost-live kernel: ---[ end trace 0000000000000000=
 ]---
>> Jul 13 04:25:26 localhost-live kernel: RIP: 0010:iput+0x20/0x230
>> Jul 13 04:25:26 localhost-live kernel: Code: 90 90 90 90 90 90 90 90 9=
0 90 f3 0f 1e fa 0f 1f 44 00 00 48 85 ff 0f 84 86 01 00 00 41 54 55 48 8d=
 af 50 01 00 00 53 48 89 fb <f6> 87 91 00 00 00 01 74 3a e9 68 01 00 00 8=
b 53 48 8b 83 90 00 00
>> Jul 13 04:25:26 localhost-live kernel: RSP: 0018:ffffd43c0b893740 EFLA=
GS: 00010206
>> Jul 13 04:25:26 localhost-live kernel: RAX: 0000000000000000 RBX: 0000=
000000000188 RCX: 000000000092a000
>> Jul 13 04:25:26 localhost-live kernel: RDX: 0000000000000000 RSI: ffff=
ffff93bcea60 RDI: 0000000000000188
>> Jul 13 04:25:26 localhost-live kernel: RBP: 00000000000002d8 R08: 0000=
000000000000 R09: ffffffff90db25b6
>> Jul 13 04:25:26 localhost-live kernel: R10: ffff8c4aa9480000 R11: ffff=
f60205a52000 R12: ffffd43c0b8938bf
>> Jul 13 04:25:26 localhost-live kernel: R13: 0000000000000000 R14: ffff=
8c4aa9476690 R15: 00000000fffffffb
>> Jul 13 04:25:26 localhost-live kernel: FS:  00007f1b5f3f9840(0000) GS:=
ffff8c4fc3a71000(0000) knlGS:0000000000000000
>> Jul 13 04:25:26 localhost-live kernel: CS:  0010 DS: 0000 ES: 0000 CR0=
: 0000000080050033
>> Jul 13 04:25:26 localhost-live kernel: CR2: 0000000000000219 CR3: 0000=
00016abc8003 CR4: 00000000001726f0
>=20
> Log from kernel 6.14.0:
>=20
>> Jul 13 04:02:25 localhost-live kernel: BTRFS: device label fedora_hogw=
arts devid 1 transid 456817 /dev/mapper/hogwarts-root (252:1) scanned by =
mount (4785)
>> Jul 13 04:02:25 localhost-live kernel: BTRFS info (device dm-1): first=
 mount of filesystem a6999502-9362-4fa7-b7b4-28095790217d
>> Jul 13 04:02:25 localhost-live kernel: BTRFS info (device dm-1): using=
 crc32c (crc32c-x86_64) checksum algorithm
>> Jul 13 04:02:25 localhost-live kernel: BTRFS info (device dm-1): using=
 free-space-tree
>> Jul 13 04:02:25 localhost-live kernel: BTRFS info (device dm-1): bdev =
/dev/mapper/hogwarts-root errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
>> Jul 13 04:02:25 localhost-live kernel: BTRFS info (device dm-1): start=
 tree-log replay
>> Jul 13 04:02:26 localhost-live kernel: BTRFS: error (device dm-1) in b=
trfs_replay_log:2104: errno=3D-5 IO failure (Failed to recover log tree)
>> Jul 13 04:02:26 localhost-live kernel: ------------[ cut here ]-------=
-----
>> Jul 13 04:02:26 localhost-live kernel: WARNING: CPU: 0 PID: 4785 at fs=
/btrfs/block-rsv.c:452 btrfs_release_global_block_rsv+0xb0/0xd0
>> Jul 13 04:02:26 localhost-live kernel: Modules linked in: dm_crypt uin=
put rfcomm snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack=
_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet=
 nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_=
conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables intel_rapl_msr i=
ntel_rapl_common x86_pkg_temp_thermal intel_powerclamp qrtr coretemp kvm_=
intel snd_hda_codec_realtek snd_hda_codec_generic bnep snd_hda_codec_hdmi=
 kvm snd_usb_audio btusb snd_hda_scodec_component snd_hda_intel btrtl bti=
ntel snd_intel_dspcfg snd_intel_sdw_acpi btbcm snd_hda_codec btmtk blueto=
oth uvcvideo snd_hda_core snd_usbmidi_lib snd_ump snd_rawmidi snd_hwdep s=
nd_seq uvc videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 snd_seq_devi=
ce videobuf2_common snd_pcm videodev mei_hdcp mei_pxp iTCO_wdt at24 snd_t=
imer mei_me intel_pmc_bxt iTCO_vendor_support mei snd rapl intel_cstate i=
ntel_uncore mc i2c_i801 lpc_ich rfkill i2c_smbus pcspkr soundcore apple_m=
fi_fastcharge joydev nfnetlink zram
>> Jul 13 04:02:26 localhost-live kernel:  lz4hc_compress lz4_compress ov=
erlay erofs netfs isofs hid_logitech_hidpp uas hid_logitech_dj usb_storag=
e hid_apple amdgpu i915 amdxcp gpu_sched drm_panel_backlight_quirks drm_b=
uddy drm_ttm_helper mxm_wmi ttm polyval_clmulni drm_exec polyval_generic =
ghash_clmulni_intel i2c_algo_bit drm_suballoc_helper sha512_ssse3 sha256_=
ssse3 drm_display_helper sha1_ssse3 nvme e1000e nvme_tcp cec nvme_fabrics=
 video nvme_keyring wmi nvme_core nvme_auth sunrpc be2iscsi bnx2i cnic ui=
o cxgb4i cxgb4 tls cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_boot_=
sysfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi loop fuse i2c_=
dev
>> Jul 13 04:02:26 localhost-live kernel: CPU: 0 UID: 0 PID: 4785 Comm: m=
ount Not tainted 6.14.0-63.fc42.x86_64 #1
>> Jul 13 04:02:26 localhost-live kernel: Hardware name: To Be Filled By =
O.E.M. To Be Filled By O.E.M./Z87 Extreme4, BIOS P3.50 03/11/2018
>> Jul 13 04:02:26 localhost-live kernel: RIP: 0010:btrfs_release_global_=
block_rsv+0xb0/0xd0
>> Jul 13 04:02:26 localhost-live kernel: Code: 01 00 00 00 74 aa 0f 0b 4=
8 83 bb 40 01 00 00 00 74 a8 0f 0b 48 83 bb 48 01 00 00 00 74 a6 0f 0b 48=
 83 bb 70 01 00 00 00 74 a4 <0f> 0b 48 83 bb 78 01 00 00 00 74 a2 0f 0b 4=
8 83 bb a8 01 00 00 00
>> Jul 13 04:02:26 localhost-live kernel: RSP: 0018:ffffb1918a49bc38 EFLA=
GS: 00010286
>> Jul 13 04:02:26 localhost-live kernel: RAX: 0000000020000000 RBX: ffff=
9271822e3000 RCX: 0000000000000000
>> Jul 13 04:02:26 localhost-live kernel: RDX: 0000000020000000 RSI: ffff=
92723e622c00 RDI: ffff92723e622c08
>> Jul 13 04:02:26 localhost-live kernel: RBP: ffff927555127000 R08: ffff=
927555127000 R09: 0000000000100000
>> Jul 13 04:02:26 localhost-live kernel: R10: ffff9271c30575c8 R11: 0000=
000000000036 R12: ffff9271822e3090
>> Jul 13 04:02:26 localhost-live kernel: R13: ffff9271822e36c8 R14: 0000=
000000000000 R15: dead000000000100
>> Jul 13 04:02:26 localhost-live kernel: FS:  00007f67bbcda840(0000) GS:=
ffff927697600000(0000) knlGS:0000000000000000
>> Jul 13 04:02:26 localhost-live kernel: CS:  0010 DS: 0000 ES: 0000 CR0=
: 0000000080050033
>> Jul 13 04:02:26 localhost-live kernel: CR2: 00007fc484069000 CR3: 0000=
000175292002 CR4: 00000000001726f0
>> Jul 13 04:02:26 localhost-live kernel: Call Trace:
>> Jul 13 04:02:26 localhost-live kernel:  <TASK>
>> Jul 13 04:02:26 localhost-live kernel:  ? show_trace_log_lvl+0x1d3/0x3=
00
>> Jul 13 04:02:26 localhost-live kernel:  ? show_trace_log_lvl+0x1d3/0x3=
00
>> Jul 13 04:02:26 localhost-live kernel:  ? show_trace_log_lvl+0x1d3/0x3=
00
>> Jul 13 04:02:26 localhost-live kernel:  ? btrfs_free_block_groups+0x34=
a/0x420
>> Jul 13 04:02:26 localhost-live kernel:  ? btrfs_release_global_block_r=
sv+0xb0/0xd0
>> Jul 13 04:02:26 localhost-live kernel:  ? __warn.cold+0x93/0xfa
>> Jul 13 04:02:26 localhost-live kernel:  ? btrfs_release_global_block_r=
sv+0xb0/0xd0
>> Jul 13 04:02:26 localhost-live kernel:  ? report_bug+0x103/0x150
>> Jul 13 04:02:26 localhost-live kernel:  ? handle_bug+0x58/0x90
>> Jul 13 04:02:26 localhost-live kernel:  ? exc_invalid_op+0x17/0x70
>> Jul 13 04:02:26 localhost-live kernel:  ? asm_exc_invalid_op+0x1a/0x20=

>> Jul 13 04:02:26 localhost-live kernel:  ? btrfs_release_global_block_r=
sv+0xb0/0xd0
>> Jul 13 04:02:26 localhost-live kernel:  ? btrfs_release_global_block_r=
sv+0x22/0xd0
>> Jul 13 04:02:26 localhost-live kernel:  btrfs_free_block_groups+0x34a/=
0x420
>> Jul 13 04:02:26 localhost-live kernel:  open_ctree+0xb40/0xbce
>> Jul 13 04:02:26 localhost-live kernel:  btrfs_get_tree_super.cold+0xb/=
0xbb
>> Jul 13 04:02:26 localhost-live kernel:  vfs_get_tree+0x29/0xd0
>> Jul 13 04:02:26 localhost-live kernel:  fc_mount+0x12/0x40
>> Jul 13 04:02:26 localhost-live kernel:  btrfs_get_tree_subvol+0x10d/0x=
210
>> Jul 13 04:02:26 localhost-live kernel:  vfs_get_tree+0x29/0xd0
>> Jul 13 04:02:26 localhost-live kernel:  vfs_cmd_create+0x59/0xe0
>> Jul 13 04:02:26 localhost-live kernel:  __do_sys_fsconfig+0x511/0x6f0
>> Jul 13 04:02:26 localhost-live kernel:  do_syscall_64+0x7f/0x170
>> Jul 13 04:02:26 localhost-live kernel:  ? syscall_exit_to_user_mode+0x=
10/0x210
>> Jul 13 04:02:26 localhost-live kernel:  ? do_syscall_64+0x8c/0x170
>> Jul 13 04:02:26 localhost-live kernel:  ? do_readlinkat+0x12e/0x180
>> Jul 13 04:02:26 localhost-live kernel:  ? syscall_exit_to_user_mode+0x=
10/0x210
>> Jul 13 04:02:26 localhost-live kernel:  ? do_syscall_64+0x8c/0x170
>> Jul 13 04:02:26 localhost-live kernel:  ? do_syscall_64+0x8c/0x170
>> Jul 13 04:02:26 localhost-live kernel:  ? exc_page_fault+0x7e/0x1a0
>> Jul 13 04:02:26 localhost-live kernel:  entry_SYSCALL_64_after_hwframe=
+0x76/0x7e
>> Jul 13 04:02:26 localhost-live kernel: RIP: 0033:0x7f67bbeb9abe
>> Jul 13 04:02:26 localhost-live kernel: Code: 73 01 c3 48 8b 0d 4a 33 0=
f 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49=
 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1a 33 0=
f 00 f7 d8 64 89 01 48
>> Jul 13 04:02:26 localhost-live kernel: RSP: 002b:00007ffd51c98aa8 EFLA=
GS: 00000246 ORIG_RAX: 00000000000001af
>> Jul 13 04:02:26 localhost-live kernel: RAX: ffffffffffffffda RBX: 0000=
55ecc1aaa560 RCX: 00007f67bbeb9abe
>> Jul 13 04:02:26 localhost-live kernel: RDX: 0000000000000000 RSI: 0000=
000000000006 RDI: 0000000000000003
>> Jul 13 04:02:26 localhost-live kernel: RBP: 00007ffd51c98bf0 R08: 0000=
000000000000 R09: 0000000000000003
>> Jul 13 04:02:26 localhost-live kernel: R10: 0000000000000000 R11: 0000=
000000000246 R12: 0000000000000000
>> Jul 13 04:02:26 localhost-live kernel: R13: 000055ecc1aaaa00 R14: 0000=
7f67bc036b00 R15: 000055ecc1aac498
>> Jul 13 04:02:26 localhost-live kernel:  </TASK>
>> Jul 13 04:02:26 localhost-live kernel: ---[ end trace 0000000000000000=
 ]---
>> Jul 13 04:02:26 localhost-live kernel: BTRFS error (device dm-1 state =
E): open_ctree failed: -5
>>
>=20
> Superblock dump collected with btrfs-tools 6.15 on live USB:
>=20
>>  btrfs inspect-internal dump-super --full /dev/mapper/hogwarts-root
>> superblock: bytenr=3D65536, device=3D/dev/mapper/hogwarts-root
>> ---------------------------------------------------------
>> csum_type               0 (crc32c)
>> csum_size               4
>> csum                    0x3e3b7bc2 [match]
>> bytenr                  65536
>> flags                   0x1
>>                         ( WRITTEN )
>> magic                   _BHRfS_M [match]
>> fsid                    a6999502-9362-4fa7-b7b4-28095790217d
>> metadata_uuid           00000000-0000-0000-0000-000000000000
>> label                   fedora_hogwarts
>> generation              456817
>> root                    202624811008
>> sys_array_size          97
>> chunk_root_generation   433110
>> root_level              0
>> chunk_root              368550690816
>> chunk_root_level        1
>> log_root                202650910720
>> log_root_transid (deprecated)   0
>> log_root_level          0
>> total_bytes             498382929920
>> bytes_used              227109515264
>> sectorsize              4096
>> nodesize                16384
>> leafsize (deprecated)   16384
>> stripesize              4096
>> root_dir                6
>> num_devices             1
>> compat_flags            0x0
>> compat_ro_flags         0x3
>>                         ( FREE_SPACE_TREE |
>>                           FREE_SPACE_TREE_VALID )
>> incompat_flags          0x171
>>                         ( MIXED_BACKREF |
>>                           COMPRESS_ZSTD |
>>                           BIG_METADATA |
>>                           EXTENDED_IREF |
>>                           SKINNY_METADATA )
>> cache_generation        0
>> uuid_tree_generation    456817
>> dev_item.uuid           0721004b-8c3e-4ae7-bb3b-4b2bb5d313f7
>> dev_item.fsid           a6999502-9362-4fa7-b7b4-28095790217d [match]
>> dev_item.type           0
>> dev_item.total_bytes    498382929920
>> dev_item.bytes_used     253453402112
>> dev_item.io_align       4096
>> dev_item.io_width       4096
>> dev_item.sector_size    4096
>> dev_item.devid          1
>> dev_item.dev_group      0
>> dev_item.seek_speed     0
>> dev_item.bandwidth      0
>> dev_item.generation     0
>> sys_chunk_array[2048]:
>>         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 368550346752)
>>                 length 33554432 owner 2 stripe_len 65536 type SYSTEM|s=
ingle
>>                 io_align 65536 io_width 65536 sector_size 4096
>>                 num_stripes 1 sub_stripes 1
>>                         stripe 0 devid 1 offset 79512469504
>>                         dev_uuid 0721004b-8c3e-4ae7-bb3b-4b2bb5d313f7
>> backup_roots[4]:
>>         backup 0:
>>                 backup_tree_root:       202624811008    gen: 456817   =
  level: 0
>>                 backup_chunk_root:      368550690816    gen: 433110   =
  level: 1
>>                 backup_extent_root:     202621485056    gen: 456817   =
  level: 2
>>                 backup_fs_root:         29755916288     gen: 36186    =
  level: 0
>>                 backup_dev_root:        1283227648      gen: 453657   =
  level: 1
>>                 csum_root:      202621796352    gen: 456817     level:=
 2
>>                 backup_total_bytes:     498382929920
>>                 backup_bytes_used:      227109515264
>>                 backup_num_devices:     1
>>
>>         backup 1:
>>                 backup_tree_root:       202407755776    gen: 456814   =
  level: 0
>>                 backup_chunk_root:      368550690816    gen: 433110   =
  level: 1
>>                 backup_extent_root:     202402742272    gen: 456814   =
  level: 2
>>                 backup_fs_root:         29755916288     gen: 36186    =
  level: 0
>>                 backup_dev_root:        1283227648      gen: 453657   =
  level: 1
>>                 csum_root:      202403151872    gen: 456814     level:=
 2
>>                 backup_total_bytes:     498382929920
>>                 backup_bytes_used:      227106684928
>>                 backup_num_devices:     1
>>
>>         backup 2:
>>                 backup_tree_root:       202472538112    gen: 456815   =
  level: 0
>>                 backup_chunk_root:      368550690816    gen: 433110   =
  level: 1
>>                 backup_extent_root:     202447388672    gen: 456815   =
  level: 2
>>                 backup_fs_root:         29755916288     gen: 36186    =
  level: 0
>>                 backup_dev_root:        1283227648      gen: 453657   =
  level: 1
>>                 csum_root:      202378985472    gen: 456815     level:=
 2
>>                 backup_total_bytes:     498382929920
>>                 backup_bytes_used:      227107676160
>>                 backup_num_devices:     1
>>
>>         backup 3:
>>                 backup_tree_root:       202539106304    gen: 456816   =
  level: 0
>>                 backup_chunk_root:      368550690816    gen: 433110   =
  level: 1
>>                 backup_extent_root:     202537730048    gen: 456816   =
  level: 2
>>                 backup_fs_root:         29755916288     gen: 36186    =
  level: 0
>>                 backup_dev_root:        1283227648      gen: 453657   =
  level: 1
>>                 csum_root:      202537861120    gen: 456816     level:=
 2
>>                 backup_total_bytes:     498382929920
>>                 backup_bytes_used:      227108405248
>>                 backup_num_devices:     1
>=20
> Corrupt tree log dump collected with btrfs-tools 6.15 on live USB:
>=20
>> # btrfs inspect-internal dump-tree -t TREE_LOG /dev/mapper/hogwarts-ro=
ot
>> btrfs-progs v6.15
>> log root tree
>> leaf 202650910720 items 2 free space 15355 generation 456818 owner TRE=
E_LOG
>> leaf 202650910720 flags 0x1(WRITTEN) backref revision 1
>> fs uuid a6999502-9362-4fa7-b7b4-28095790217d
>> chunk uuid 710679da-fb76-4a51-9c84-8600a6e58c43
>>         item 0 key (TREE_LOG ROOT_ITEM 256) itemoff 15844 itemsize 439=

>>                 generation 456818 root_dirid 0 bytenr 202645028864 byt=
e_limit 0 bytes_used 0
>>                 last_snapshot 0 flags 0x0(none) refs 0
>>                 drop_progress key (0 UNKNOWN.0 0) drop_level 0
>>                 level 0 generation_v2 456818
>>                 uuid 00000000-0000-0000-0000-000000000000
>>                 parent_uuid 00000000-0000-0000-0000-000000000000
>>                 received_uuid 00000000-0000-0000-0000-000000000000
>>                 ctransid 0 otransid 0 stransid 0 rtransid 0
>>                 ctime 0.0 (1970-01-01 00:00:00)
>>                 otime 0.0 (1970-01-01 00:00:00)
>>                 stime 0.0 (1970-01-01 00:00:00)
>>                 rtime 0.0 (1970-01-01 00:00:00)
>>         item 1 key (TREE_LOG ROOT_ITEM 258) itemoff 15405 itemsize 439=

>>                 generation 456818 root_dirid 0 bytenr 202650877952 byt=
e_limit 0 bytes_used 65536
>>                 last_snapshot 0 flags 0x0(none) refs 0
>>                 drop_progress key (0 UNKNOWN.0 0) drop_level 0
>>                 level 1 generation_v2 456818
>>                 uuid 00000000-0000-0000-0000-000000000000
>>                 parent_uuid 00000000-0000-0000-0000-000000000000
>>                 received_uuid 00000000-0000-0000-0000-000000000000
>>                 ctransid 0 otransid 0 stransid 0 rtransid 0
>>                 ctime 0.0 (1970-01-01 00:00:00)
>>                 otime 0.0 (1970-01-01 00:00:00)
>>                 stime 0.0 (1970-01-01 00:00:00)
>>                 rtime 0.0 (1970-01-01 00:00:00)
>=20
> If I'm interpreting correctly, the corrupt tree log is zeroed, so that
> kind of gestures in the direction of what the log replay code might be
> mishandling.
>  [1]
> https://discussion.fedoraproject.org/t/btrfs-error-emergency-mode-enter=
ed-every-time-i-boot/141179
>=20
> Thanks,
>=20
> Russell


