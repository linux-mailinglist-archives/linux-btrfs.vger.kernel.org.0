Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A733149652
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 16:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAYPop convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 25 Jan 2020 10:44:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41456 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAYPop (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jan 2020 10:44:45 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so2563655oie.8
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jan 2020 07:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=e9S3ChDKKUtyy2WFFi/lSdRNnl9My/21HE6elYbVOeg=;
        b=E9bksT3Tytp/q4vGVYSTGypSDuY0jxdSzGhLNZaTM44Igb9zxCXRGapZkSyw85GcF5
         rQqRerW9tLWw1fp8MKbOwfsV9pz8TT0IMTp+X4JPqQmMTCjZCAwb4xOLqsZ6gYy4h6Up
         JQMnkpRnuBI0XV+EzkV+Xa1LRwAUWlP/h3HKPwtb3iz5ZVsAAFb3ngk3G/B6v6U2n/pJ
         swS9IELHliXpvKAGDtXNlzgsK61rp63llJLto8zENQD2mxCz7KHYiJGrHiL9fg6bNHML
         DyNaR1maKUpVpKJwe2OBGEx0xYRnUq5++9fZ5CxMqcQLHqx8E6AB41k7ru2HwNQxxSNw
         UeXw==
X-Gm-Message-State: APjAAAXS9tA6QehYXcp1hW9EQLF+wNLiWFdMrSk4nM6APW3CzIVLO22E
        HZ49JfBZdULt9EFONA99+U/yiruqR+YpmxjBRc78HnEUqyM=
X-Google-Smtp-Source: APXvYqzPQTjeNquIJtEIKclY2Q2+/5AbyElfSTA2r2vrTkVeOqAHCe9G9ZhzPFbwPzWsvzFpF0lQ0t46JWjOOiTrCOE=
X-Received: by 2002:aca:c383:: with SMTP id t125mr2514527oif.122.1579967083709;
 Sat, 25 Jan 2020 07:44:43 -0800 (PST)
MIME-Version: 1.0
References: <CAH+WbHxsOEt9Z7t=ubtCmoCb2f4nDpMCCSXnT+-k5oR2pQFpOQ@mail.gmail.com>
 <688e0961-c80e-4db0-bf87-dabbfc72adf1@gmail.com> <71251506-88e5-c481-abdf-56dcd625b139@gmx.com>
In-Reply-To: <71251506-88e5-c481-abdf-56dcd625b139@gmx.com>
From:   Thorsten Hirsch <t.hirsch@web.de>
Date:   Sat, 25 Jan 2020 16:44:31 +0100
Message-ID: <CAH+WbHyYpP0ACzc+USAvwQU5SSaTbMLXbQRsc=mUWdCk23LQQg@mail.gmail.com>
Subject: Re: tree first key mismatch detected (reproducible error)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks, guys.

However, checking the RAM with memtest86 hasn't revealed any errors.
Currently I let it run another pass, but so far everything's good.
Here's the output of btrfs check...

[1/7] checking root items
[2/7] checking extents
leaf parent key incorrect 109690880
bad block 109690880
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
root 5 inode 3583162 errors 1040, bad file extent, some csum missing
root 5 inode 3767022 errors 1040, bad file extent, some csum missing
root 5 inode 3819591 errors 1040, bad file extent, some csum missing
root 5 inode 4108194 errors 1040, bad file extent, some csum missing
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p3
UUID: 26717c9f-df62-4c57-a482-b9e4880b31e6
found 6132469760 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 4161536
total fs tree bytes: 0
total extent tree bytes: 3850240
btree space waste bytes: 1115823
file data blocks allocated: 108003328
 referenced 108003328

-- 
Thorsten


Am Sa., 25. Jan. 2020 um 13:23 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
>
>
>
> On 2020/1/25 下午7:46, Andrei Borzenkov wrote:
> > 25.01.2020 14:37, Thorsten Hirsch пишет:
> >> Hi, here's a btrfs problem that started happening today on my main computer:
> >>
> >> BTRFS error (device nvme0n1p3): tree first key mismatch detected,
> >> bytenr=109690880 parent_transid=1329869 key
> >> expected=(48044838912,168,12288) has=(48045363200,168,12288)
> >>
> >
> > This looks like bit flip
> >
> > 48044838912 == B2FB21000
> > 48045363200 == B2FBA1000
> >
> > with usual recommendation to check your RAM.
> >
>
> Ops, forgot the case of bitflip.
>
> Just as mentioned by Andrei, make sure the memory problem is solved,
> then `btrfs check`.
>
> Thanks,
> Qu
>
> >> It always occurs some minutes after booting, sometimes even seconds
> >> after booting. The partition is then remounted read-only. I already
> >> tried scrubbing the partition (aborts itself after some seconds) and
> >> balancing (seems to trigger the error immediately and doesn't even
> >> start).
> >>
> >> I attached some more output of dmesg. The distribution is Arch Linux
> >> and the kernel is the most recent one in Arch's default kernel
> >> package: 5.4.14-arch1-1 (I upgraded from 5.4.13 to 5.4.14 just
> >> yesterday).
> >>
> >> Best regards,
> >> Thorsten
> >>
> >> [Jan25 12:00] BTRFS error (device nvme0n1p3): tree first key mismatch
> >> detected, bytenr=109690880 parent_transid=1329869 key
> >> expected=(48044838912,168,12288) has=(48045363200,168,12288)
> >> [  +0,000003] ------------[ cut here ]------------
> >> [  +0,000001] BTRFS: Transaction aborted (error -117)
> >> [  +0,000041] WARNING: CPU: 7 PID: 382 at fs/btrfs/extent-tree.c:3080
> >> __btrfs_free_extent.isra.0+0x694/0x9e0 [btrfs]
> >> [  +0,000000] Modules linked in: xt_nat xt_tcpudp veth xt_conntrack
> >> xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo
> >> xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack
> >> nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge stp llc edac_mce_amd
> >> kvm_amd snd_hda_codec_ca0110 snd_hda_codec_generic wmi_bmof kvm
> >> ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_nhlt pktcdvd
> >> irqbypass snd_hda_codec uvcvideo snd_hda_core snd_hwdep
> >> videobuf2_vmalloc snd_pcm videobuf2_memops nls_iso8859_1
> >> videobuf2_v4l2 nls_cp437 videobuf2_common snd_timer crct10dif_pclmul
> >> vfat crc32_pclmul videodev fat snd joydev ghash_clmulni_intel
> >> input_leds mousedev mc psmouse aesni_intel r8169 crypto_simd realtek
> >> cryptd ccp glue_helper k10temp i2c_piix4 soundcore libphy rng_core wmi
> >> gpio_amdpt evdev mac_hid pinctrl_amd acpi_cpufreq fuse vboxnetflt(OE)
> >> vboxnetadp(OE) vboxdrv(OE) sg crypto_user ip_tables x_tables sr_mod
> >> cdrom sd_mod hid_generic usbhid hid serio_raw atkbd libps2 ahci
> >> libahci libata xhci_pci
> >> [  +0,000018]  xhci_hcd scsi_mod i8042 serio amdgpu gpu_sched
> >> i2c_algo_bit ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
> >> fb_sys_fops drm agpgart btrfs libcrc32c crc32c_generic crc32c_intel
> >> xor raid6_pq
> >> [  +0,000005] CPU: 7 PID: 382 Comm: btrfs-transacti Tainted: G
> >>   OE     5.4.14-arch1-1 #1
> >> [  +0,000001] Hardware name: Gigabyte Technology Co., Ltd.
> >> AB350M-DS3H/AB350M-DS3H-CF, BIOS F50a 11/27/2019
> >> [  +0,000010] RIP: 0010:__btrfs_free_extent.isra.0+0x694/0x9e0 [btrfs]
> >> [  +0,000001] Code: e8 c1 ee 00 00 8b 4c 24 38 85 c9 0f 84 39 fe ff ff
> >> 48 8b 54 24 48 e9 04 fe ff ff 44 89 fe 48 c7 c7 a0 ce 30 c0 e8 ba 48
> >> c4 d1 <0f> 0b 48 8b 3c 24 44 89 f9 ba 08 0c 00 00 48 c7 c6 a0 20 30 c0
> >> e8
> >> [  +0,000001] RSP: 0018:ffff8fc081363ba0 EFLAGS: 00010286
> >> [  +0,000001] RAX: 0000000000000000 RBX: 0000000000000192 RCX: 0000000000000000
> >> [  +0,000000] RDX: 0000000000000001 RSI: 0000000000000096 RDI: 00000000ffffffff
> >> [  +0,000001] RBP: 0000000b3090a000 R08: 000000000000049b R09: 0000000000000004
> >> [  +0,000000] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8b958a1c9c40
> >> [  +0,000001] R13: 0000000000000000 R14: 0000000000000001 R15: 00000000ffffff8b
> >> [  +0,000001] FS:  0000000000000000(0000) GS:ffff8b958e9c0000(0000)
> >> knlGS:0000000000000000
> >> [  +0,000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [  +0,000001] CR2: 00007fdcf263d000 CR3: 000000032f11a000 CR4: 00000000003406e0
> >> [  +0,000001] Call Trace:
> >> [  +0,000012]  ? __btrfs_run_delayed_refs+0xc9f/0xff0 [btrfs]
> >> [  +0,000009]  __btrfs_run_delayed_refs+0x25e/0xff0 [btrfs]
> >> [  +0,000011]  btrfs_run_delayed_refs+0x6a/0x180 [btrfs]
> >> [  +0,000013]  btrfs_start_dirty_block_groups+0x28e/0x470 [btrfs]
> >> [  +0,000011]  btrfs_commit_transaction+0x116/0x9b0 [btrfs]
> >> [  +0,000003]  ? _raw_spin_unlock+0x16/0x30
> >> [  +0,000010]  ? join_transaction+0x108/0x3a0 [btrfs]
> >> [  +0,000010]  transaction_kthread+0x13a/0x180 [btrfs]
> >> [  +0,000002]  kthread+0xfb/0x130
> >> [  +0,000010]  ? btrfs_cleanup_transaction+0x560/0x560 [btrfs]
> >> [  +0,000001]  ? kthread_park+0x90/0x90
> >> [  +0,000001]  ret_from_fork+0x1f/0x40
> >> [  +0,000002] ---[ end trace 51366456523028bd ]---
> >> [  +0,000001] BTRFS: error (device nvme0n1p3) in
> >> __btrfs_free_extent:3080: errno=-117 unknown
> >> [  +0,000001] BTRFS info (device nvme0n1p3): forced readonly
> >> [  +0,000002] BTRFS: error (device nvme0n1p3) in
> >> btrfs_run_delayed_refs:2188: errno=-117 unknown
> >>
> >
>
