Return-Path: <linux-btrfs+bounces-11278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DE9A28374
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 05:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F57C7A2BE5
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 04:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AEA21519B;
	Wed,  5 Feb 2025 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5ZB2p1k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD025A647
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 04:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738731059; cv=none; b=Si7tldRvSULcxbKlwm1uNJZkyiY0Cq5fBsMHVSzPc0ROtG/2dVVnekVqY7lqtlTUHUVQuI5Jo332oxoKroZURLwZGea/8DSHz3Cb37GFBAwSARtPs9lukBy/StfNSVM/i6wMDk9AREJO1YoofSy2tRDTCLbXAnCxEOe1ovttHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738731059; c=relaxed/simple;
	bh=FWvXApcFcdjIYd+oJ+uB4FIF8WD0z32r7QFhmSjI2TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YZ8is/BwXa+6TxCxhLPliHQOpw18sl5QTeIUzLFjRl8Rl2quhKeQD9+hGX9qcqd3GxyrhnTIoITq38BeHlpWuufcRo3l96C57rjxOGjJxhNkZ9es/wd7RDFNj/FXH3xxq1Vm6fiwJu9IT2moaKEwvgDcBEp6kFRObt4zUddduM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5ZB2p1k; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216406238f9so14659735ad.2
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2025 20:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738731056; x=1739335856; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZFIx6B896enfLVnIPXT0b4ibpnAnUBo+UD8ROLHBz0=;
        b=B5ZB2p1kU1/ILogFsk++F35kML9liwm8P3qX2CACvuwJpbMH0VOTFFFO+GXwVrSgA4
         IiCggQIiwqXdIBhKL3/jfVU/sZkh20VYoZuPK4l4NitheFfWAm0vRFATqaqRhgwh+M1j
         CtRh2HGdREUSCJf+QDIwmOeKRIRjV4Fi+MLB3OE3Wbytuld6Q2zjfq2T/P+WJuYDDLOJ
         0oGLUBhWch+4ZoHSJjkM6OFyFWx0faw02InqWv7ec4NoOFiIHTloezoWurfrMjcNPNGd
         oS9yOi+yEH7OyD7gvAHTbdMc7R+YqFEavzqkRLPcKkqyfe2Nh5v/SKZhj/pXbZcTjmJy
         4rVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738731056; x=1739335856;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZFIx6B896enfLVnIPXT0b4ibpnAnUBo+UD8ROLHBz0=;
        b=CvVbNX4mPIkgNqYtw0WgxpXRzVtxUOumSbhZcFJnNgO5kHy2wnPfWhsrGeE0Yy+8xf
         XprcJIKmvowvTSzmA62R+MSz4AMdfU0pr4uUX34Rnemu58jvDsrYoETuUizDurkIBjjq
         YHLeEVq+ot4j5rxhYehwMbxV0PCEemc7SpZz8yj/GmAWDPwhHDvbbe2Tr/HJFLFjIbsk
         rWyoV4Evdz1+lePGuFoJKtibSLj9f4cjcwHKdc5EHUvdULAGEPitzoSeiHIZ3nPpMEPI
         LynlVyuKyk5PsnL6Wp9S6AXBQXhO/5XoPDCI3CEuzROqPynjXTn3StbsxP8xNpGuYJHA
         q2DA==
X-Gm-Message-State: AOJu0YxqVZNtW5eSdINdcqfSkyV/4+x/TuLO89ZdGEKj4anDBtpWT1pK
	I782yuBqPZfz0xNedecLEya/PpO5RP9Y1SmT6lu9Ur6IMfZClGlU47zKlUj03w/vSboM/YbnqDW
	Q39+XMeYRCLLeRwoxURIaWewGb8zem21H
X-Gm-Gg: ASbGnctJk/nAIsTwjRYdlcBuP2sGVLffEso+E8rPdnPs0TedJgUF70O55V1j6niWdSm
	5PA6L7FYvFghYnCMhwy9mtioGKUZtdKXyQXwEl4b+MYhyRv3teQTMhork4HBhw8wbc37x7iI=
X-Google-Smtp-Source: AGHT+IHCexj0614w2gpC7h0eNs31WCKOy2k5cx+zx7Ikf+z30o/H2caP8fTHX143yVPGiKpvJZaOqaANa4m+KjZPe6k=
X-Received: by 2002:a05:6a00:2906:b0:725:e499:5b9d with SMTP id
 d2e1a72fcca58-730351e9bbemr964092b3a.3.1738731055598; Tue, 04 Feb 2025
 20:50:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAwmOLyY8=0_=Mddw5rPnRbxz_Lm6iVde9QVr-3SO3Qy2krP7g@mail.gmail.com>
In-Reply-To: <CAAwmOLyY8=0_=Mddw5rPnRbxz_Lm6iVde9QVr-3SO3Qy2krP7g@mail.gmail.com>
From: Eugen Konkov <konkove@gmail.com>
Date: Tue, 4 Feb 2025 23:50:44 -0500
X-Gm-Features: AWEUYZmldxAapW7ZTzjjLtTBUdeh3pye-yMFl8P3I2boFfUWeoRLDZ0DgCEKbP0
Message-ID: <CAAwmOLzSqWbQuZBVBA63N0cqiOpqpmbq5pXDDHQE2wBgiuhVVA@mail.gmail.com>
Subject: Re: Issue mounting device in degraded mode
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The info from dmesg:
[20983.596051] BTRFS info (device loop10): dev_replace from <missing
disk> (devid 2) to /dev/loop12 started
[20983.613249] BTRFS warning (device loop10): failed setting block group ro=
: -28
[20983.615450] BTRFS error (device loop10): btrfs_scrub_dev(<missing
disk>, 2, /dev/loop12) failed -28

On Tue, Feb 4, 2025 at 11:48=E2=80=AFPM Eugen Konkov <konkove@gmail.com> wr=
ote:
>
> ```
> [19989.390121] ------------[ cut here ]------------
> [19989.390123] BTRFS: Transaction aborted (error -28)
> [19989.390178] WARNING: CPU: 4 PID: 25509 at
> fs/btrfs/extent-tree.c:3257 __btrfs_free_extent.isra.0+0xc21/0x11a0
> [btrfs]
> [19989.390269] Modules linked in: xfs jfs nls_ucs2_utils overlay
> binfmt_misc snd_hda_codec_hdmi snd_sof_pci_intel_tgl
> snd_sof_intel_hda_common soundwire_intel snd_sof_intel_hda_mlink
> soundwire_cadence snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp
> snd_sof intel_rapl_msr intel_rapl_common snd_sof_utils
> snd_hda_codec_realtek intel_uncore_frequency snd_soc_hdac_hda
> intel_uncore_frequency_common snd_hda_codec_generic snd_hda_ext_core
> snd_soc_acpi_intel_match snd_soc_acpi soundwire_generic_allocation
> soundwire_bus snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine
> x86_pkg_temp_thermal uvcvideo intel_powerclamp snd_hda_intel
> videobuf2_vmalloc coretemp snd_intel_dspcfg uvc snd_intel_sdw_acpi
> videobuf2_memops videobuf2_v4l2 snd_usb_audio snd_hda_codec kvm_intel
> videodev snd_hda_core snd_usbmidi_lib 8821au(OE) snd_hwdep
> videobuf2_common snd_ump mei_pxp mei_hdcp mc nls_iso8859_1
> snd_seq_midi snd_pcm cfg80211 kvm input_leds joydev snd_seq_midi_event
> irqbypass snd_rawmidi snd_seq rapl intel_cstate snd_seq_device
> snd_timer
> [19989.390309]  eeepc_wmi cmdlinepart snd spi_nor wmi_bmof mtd ee1004
> soundcore mei_me mei intel_pmc_core intel_vsec pmt_telemetry acpi_tad
> acpi_pad pmt_class mac_hid sch_fq_codel nfsd msr auth_rpcgss
> parport_pc nfs_acl ppdev lockd lp grace parport efi_pstore sunrpc
> ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456
> async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> raid6_pq libcrc32c raid1 raid0 dm_mirror dm_region_hash dm_log
> hid_logitech_hidpp hid_logitech_dj xe drm_gpuvm drm_exec hid_generic
> gpu_sched drm_suballoc_helper usbhid drm_ttm_helper hid i915
> crct10dif_pclmul crc32_pclmul nvme mfd_aaeon polyval_clmulni drm_buddy
> asus_wmi i2c_algo_bit polyval_generic ledtrig_audio nvme_core
> ghash_clmulni_intel ttm sparse_keymap sha256_ssse3 spi_intel_pci
> platform_profile sha1_ssse3 drm_display_helper i2c_i801 spi_intel
> intel_lpss_pci nvme_auth e1000e cec ahci intel_lpss i2c_smbus xhci_pci
> libahci idma64 vmd xhci_pci_renesas rc_core video wmi
> pinctrl_alderlake aesni_intel crypto_simd cryptd
> [19989.390374] CPU: 4 PID: 25509 Comm: btrfs-balance Tainted: G
> W  OE      6.8.0-51-generic #52~22.04.1-Ubuntu
> [19989.390376] Hardware name: ASUS System Product Name/PRIME H610M-A
> D4, BIOS 0412 09/29/2021
> [19989.390378] RIP: 0010:__btrfs_free_extent.isra.0+0xc21/0x11a0 [btrfs]
> [19989.390432] Code: 9d 60 ff ff ff 44 8b 85 7c ff ff ff ba fb 0c 00
> 00 89 d9 e9 e7 f8 ff ff 8b b5 7c ff ff ff 48 c7 c7 18 8c 0b c1 e8 7f
> 22 5e f0 <0f> 0b e9 4c f9 ff ff 8b bd 58 ff ff ff e8 bd d7 fe ff 84 c0
> 0f 85
> [19989.390434] RSP: 0018:ffffad3ea1f6b980 EFLAGS: 00010246
> [19989.390436] RAX: 0000000000000000 RBX: 0000000001d44000 RCX: 000000000=
0000000
> [19989.390438] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [19989.390439] RBP: ffffad3ea1f6ba48 R08: 0000000000000000 R09: 000000000=
0000000
> [19989.390440] R10: 0000000000000000 R11: 0000000000000000 R12: fffffffff=
ffffff7
> [19989.390441] R13: 0000000000000001 R14: ffff9bd962d5b8f0 R15: ffff9bd94=
7403540
> [19989.390443] FS:  0000000000000000(0000) GS:ffff9bdaef600000(0000)
> knlGS:0000000000000000
> [19989.390444] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19989.390446] CR2: 00007a0cf1b22c14 CR3: 00000003412da005 CR4: 000000000=
0f70ef0
> [19989.390447] PKRU: 55555554
> [19989.390448] Call Trace:
> [19989.390450]  <TASK>
> [19989.390453]  ? show_regs+0x6d/0x80
> [19989.390458]  ? __warn+0x89/0x160
> [19989.390461]  ? __btrfs_free_extent.isra.0+0xc21/0x11a0 [btrfs]
> [19989.390510]  ? report_bug+0x17e/0x1b0
> [19989.390514]  ? handle_bug+0x46/0x90
> [19989.390518]  ? exc_invalid_op+0x18/0x80
> [19989.390521]  ? asm_exc_invalid_op+0x1b/0x20
> [19989.390526]  ? __btrfs_free_extent.isra.0+0xc21/0x11a0 [btrfs]
> [19989.390571]  run_delayed_tree_ref+0x92/0x200 [btrfs]
> [19989.390616]  btrfs_run_delayed_refs_for_head+0x2db/0x530 [btrfs]
> [19989.390654]  __btrfs_run_delayed_refs+0xf9/0x1a0 [btrfs]
> [19989.390687]  btrfs_run_delayed_refs+0x84/0x130 [btrfs]
> [19989.390723]  btrfs_commit_transaction+0x6a/0xbe0 [btrfs]
> [19989.390768]  prepare_to_relocate+0x141/0x1d0 [btrfs]
> [19989.390823]  relocate_block_group+0x6a/0x540 [btrfs]
> [19989.390872]  ? btrfs_wait_ordered_roots+0x1f8/0x230 [btrfs]
> [19989.390920]  ? btrfs_wait_nocow_writers+0x29/0xd0 [btrfs]
> [19989.390965]  btrfs_relocate_block_group+0x28c/0x3e0 [btrfs]
> [19989.391007]  btrfs_relocate_chunk+0x40/0x1b0 [btrfs]
> [19989.391051]  __btrfs_balance+0x325/0x550 [btrfs]
> [19989.391115]  btrfs_balance+0x52e/0x990 [btrfs]
> [19989.391161]  ? __pfx_balance_kthread+0x10/0x10 [btrfs]
> [19989.391201]  balance_kthread+0x74/0x120 [btrfs]
> [19989.391239]  kthread+0xef/0x120
> [19989.391243]  ? __pfx_kthread+0x10/0x10
> [19989.391245]  ret_from_fork+0x44/0x70
> [19989.391256]  ? __pfx_kthread+0x10/0x10
> [19989.391260]  ret_from_fork_asm+0x1b/0x30
> [19989.391265]  </TASK>
> [19989.391267] ---[ end trace 0000000000000000 ]---
> [19989.391270] BTRFS info (device loop10: state A): dumping space info:
> [19989.391273] BTRFS info (device loop10: state A): space_info DATA
> has 42926080 free, is full
> [19989.391276] BTRFS info (device loop10: state A): space_info
> total=3D462422016, used=3D419430400, pinned=3D0, reserved=3D0, may_use=3D=
0,
> readonly=3D65536 zone_unusable=3D0
> [19989.391281] BTRFS info (device loop10: state A): space_info
> METADATA has -11010048 free, is full
> [19989.391283] BTRFS info (device loop10: state A): space_info
> total=3D52428800, used=3D589824, pinned=3D0, reserved=3D16384,
> may_use=3D11010048, readonly=3D51822592 zone_unusable=3D0
> [19989.391287] BTRFS info (device loop10: state A): space_info SYSTEM
> has 8372224 free, is not full
> [19989.391289] BTRFS info (device loop10: state A): space_info
> total=3D8388608, used=3D16384, pinned=3D0, reserved=3D0, may_use=3D0, rea=
donly=3D0
> zone_unusable=3D0
> [19989.391292] BTRFS info (device loop10: state A): global_block_rsv:
> size 5767168 reserved 5767168
> [19989.391294] BTRFS info (device loop10: state A): trans_block_rsv:
> size 0 reserved 0
> [19989.391296] BTRFS info (device loop10: state A): chunk_block_rsv:
> size 0 reserved 0
> [19989.391299] BTRFS info (device loop10: state A): delayed_block_rsv:
> size 0 reserved 0
> [19989.391302] BTRFS info (device loop10: state A): delayed_refs_rsv:
> size 1048576 reserved 1048576
> [19989.391305] BTRFS: error (device loop10: state A) in
> __btrfs_free_extent:3257: errno=3D-28 No space left
> [19989.391310] BTRFS info (device loop10: state EA): forced readonly
> [19989.391312] BTRFS error (device loop10: state EA): failed to run
> delayed ref for logical 30687232 num_bytes 16384 type 176 action 2
> ref_mod 1: -28
> [19989.391318] BTRFS: error (device loop10: state EA) in
> btrfs_run_delayed_refs:2261: errno=3D-28 No space left
> [19989.391346] BTRFS info (device loop10: state EA): 2 enospc errors
> during balance
> [19989.391350] BTRFS info (device loop10: state EA): balance: ended
> with status: -30
> ```
>
> The one of disks gone. I mounted btrfs in degraded mode and trying to
> replace device
>
> ```
> kes@work /mnt $ sudo btrfs filesystem show  /mnt/raid_test
> Label: none  uuid: 1829435a-a68c-464f-9e78-e9ad71ade889
> Total devices 2 FS bytes used 400.58MiB
> devid    1 size 500.00MiB used 479.00MiB path /dev/loop10
> devid    2 size 500.00MiB used 479.00MiB path /dev/loop11
>
> kes@work /mnt $ sudo umount /mnt/raid_test
> kes@work /mnt $
> kes@work /mnt $ sudo losetup -d /dev/loop10
> sudo losetup -d /dev/loop11kes@work /mnt $
> kes@work /mnt $ sudo losetup -d /dev/loop10
> sudo losetup -d /dev/loop11
> losetup: /dev/loop10: detach failed: No such device or address
> kes@work /mnt $ sudo losetup -d /dev/loop10
> sudo losetup -d /dev/loop11
> losetup: /dev/loop10: detach failed: No such device or address
> losetup: /dev/loop11: detach failed: No such device or address
> kes@work /mnt $
> kes@work /mnt $ sudo losetup -d /dev/loop10
> sudo losetup -d /dev/loop11
> losetup: /dev/loop10: detach failed: No such device or address
> losetup: /dev/loop11: detach failed: No such device or address
> kes@work /mnt $
> kes@work /mnt $
> kes@work /mnt $ losetup -a
> /dev/loop2: [0042]:5036995 (/home/kes/work/projects/raid/disk3.img)
> kes@work /mnt $ sudo losetup -a
> /dev/loop2: [0042]:5036995 (/home/kes/work/projects/raid/disk3.img)
> kes@work /mnt $
> kes@work /mnt $ sudo losetup -a
> /dev/loop2: [0042]:5036995 (/home/kes/work/projects/raid/disk3.img)
> kes@work /mnt $ sudo losetup -d /dev/loop12
> losetup: /dev/loop12: detach failed: No such device or address
> kes@work /mnt $ sudo losetup -a
> /dev/loop2: [0042]:5036995 (/home/kes/work/projects/raid/disk3.img)
> kes@work /mnt $ sudo losetup -d /dev/loop1^C
> kes@work /mnt $
> kes@work /mnt $
> kes@work /mnt $ sudo losetup /dev/loop10 disk1.img
> losetup: disk1.img: failed to set up loop device: No such file or directo=
ry
> kes@work /mnt $
> kes@work /mnt $
> kes@work /mnt $
> kes@work ~/work/projects/raid $ sudo losetup /dev/loop10 disk1.img
> kes@work ~/work/projects/raid $
> kes@work ~/work/projects/raid $
> kes@work ~/work/projects/raid $ sudo mount /dev/loop10 /mnt/raid_test
> mount: /mnt/raid_test: mount(2) system call failed: No such file or direc=
tory.
> kes@work ~/work/projects/raid $
> kes@work ~/work/projects/raid $ sudo mount -o degraded /dev/loop10
> /mnt/raid_test
> kes@work ~/work/projects/raid $
> kes@work ~/work/projects/raid $ mount | grep loop
> /dev/loop10 on /mnt/raid_test type btrfs
> (rw,relatime,degraded,ssd,discard=3Dasync,space_cache=3Dv2,subvolid=3D5,s=
ubvol=3D/)
> kes@work ~/work/projects/raid $ sudo btrfs filesystem show  /mnt/raid_tes=
t
> Label: none  uuid: 1829435a-a68c-464f-9e78-e9ad71ade889
> Total devices 2 FS bytes used 400.58MiB
> devid    1 size 500.00MiB used 479.00MiB path /dev/loop10
> *** Some devices missing
>
> kes@work ~/work/projects/raid $ dd if=3D/dev/urandom of=3Dreplace.img
> bs=3D1M count=3D500
> 500+0 records in
> 500+0 records out
> 524288000 bytes (524 MB, 500 MiB) copied, 0,973095 s, 539 MB/s
> kes@work ~/work/projects/raid $
> kes@work ~/work/projects/raid $ sudo btrfs replace start -B 2
> /dev/loop12 /mnt/raid_test/
> ERROR: cannot check mount status of /dev/loop12: No such device or addres=
s
> kes@work ~/work/projects/raid $ sudo losetup /dev/loop12 replace.img
> kes@work ~/work/projects/raid $
> kes@work ~/work/projects/raid $ sudo btrfs replace start -B 2
> /dev/loop12 /mnt/raid_test/
> Performing full device TRIM /dev/loop12 (500.00MiB) ...
> ERROR: ioctl(DEV_REPLACE_START) failed on "/mnt/raid_test/": No space
> left on device
> ```
>
> I am not expecting: No space left on device, because I want to replace
> the old device.

