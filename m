Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C8D48F246
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 23:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiANWMw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jan 2022 17:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiANWMv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jan 2022 17:12:51 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF6C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 14:12:51 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id g81so27572096ybg.10
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 14:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoKQu1lorn0VpotvQhi4LA4yQk+HKMv2Nvwn+8fgUCU=;
        b=HdNJbRUKVzSo66zH1TcGa0KL4OHkDl0+bGoXTH3HmgACPGNr/CIPYE1y4mPWPEJ6hS
         bISK+pXlyfflw67SS4iBUnYeOSTjTXhYfw2GjOCtAY9DAnvm5YxVddpEBmehd9y+6xuS
         YPa4eYOYq69NggyOCTzLxwrS7TFJ4EYQNFPDU4xi67l8aPMNLzknwvQFVv6lzPvRMXiS
         4q91qhquNRu5ExISo1PwY2GNc+jxubE/HsFS6TY7s/Kj1xHg06RhKjq6W0tESfYYHbXI
         K7+Xz2KppX5s33Zf4NuiQU2O2Colo1Qh/4CHI4n3KmA86CTqEx6hlj8OtXf0cPUpedGf
         vIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoKQu1lorn0VpotvQhi4LA4yQk+HKMv2Nvwn+8fgUCU=;
        b=XcU8PzTJNGnQFZEgCEd2yJaVkCWYNRJKPB6jEZH/IyrGxDO5a51RVH9HT1V+0C1vBE
         sTdz8oAVKA/pnruPddb98joVlUXXbGgK/rPN0zi2i81k9yCQeDiogLPTdnpj4U7ZiGJG
         TBUd3ntqFfpXbq8NmXfd+ASTEwR+lVbD/IYeXZihbyfP/4yFOEftCr2DLhi1fmhvRdKF
         W/y4HsHNjDl8j+YYeZaya9uP6qPXyDZHT8lJikxyn4YtHCu2YQgKNa6KcCiBD/faDuEB
         vlxXmerkdgFDx0gJ1cBj+0jhKTdBh/3scKlRGcQKu23ByeOsKMtODC6XqOx+78tmAnBR
         sjLg==
X-Gm-Message-State: AOAM53024ELYmDAnevLXOSUvss3Gm1IGj1spttEGZZea+l8jfjA5DzQt
        Tnh5q9zENWBlfT5REVZzGSYUWEGvS+S1WKZmvRD3l2yS+N0M7A==
X-Google-Smtp-Source: ABdhPJx0LNuhOR2IUAUfL23RssCjoJNIW4Q8IEVCay0kg0yYTQOJu37n746d91YSrRL7iXvVQZAAmmT4g9Ep2cbBTgQ=
X-Received: by 2002:a05:6902:110:: with SMTP id o16mr15045642ybh.385.1642198369936;
 Fri, 14 Jan 2022 14:12:49 -0800 (PST)
MIME-Version: 1.0
References: <b717a01c-c152-97e9-5485-2f0a95a5d4f5@petezilla.co.uk>
In-Reply-To: <b717a01c-c152-97e9-5485-2f0a95a5d4f5@petezilla.co.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 14 Jan 2022 15:12:34 -0700
Message-ID: <CAJCQCtTexbZf0TTPsW1Rd-nmooNvsT+MbT1AYZX66WeDeB-5SA@mail.gmail.com>
Subject: Re: ENOSPC on file system with nearly empty 12TB drive
To:     Peter Chant <pete@petezilla.co.uk>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 14, 2022 at 1:30 PM Peter Chant <pete@petezilla.co.uk> wrote:
>
> I have a file system that was _very_ full.  Not ideal, but there were
> reasons.
>
> It comprised of 2x3TB drives and 2x4TB drives.  I added a 12 TB drive
> and tried to rebalance only to
>
> hit ENOSPC.  Surely adding a drive to a full file system fixes this?

Not necessarily, in fact depending on the profile of the block group
type being balanced, e.g. if it's raid1 or raid10, you might need 2 or
4 drives added at once.


> Especially one that nearly doubles its capacity?  Yet I kept hitting
> this issue when
>
> trying to rebalance and also remove a 4TB  full drive.
>
> Yet I have a drive with 11TB of free space. (24TB array)!?

Sounds like metadata block groups are raid1. But it still can't add a
new metadata block group on *two* separate devices, so there's enospc.
>
>
> Some info, the kernel message:
>
> [86348.556169] ------------[ cut here ]------------
> [86348.556175] BTRFS: Transaction aborted (error -28)
> [86348.556197] WARNING: CPU: 5 PID: 8736 at fs/btrfs/extent-tree.c:2150
> btrfs_run_delayed_refs+0x1ab/0x1c0
> [86348.556205] Modules linked in: nfsd bridge ipv6 8021q garp mrp stp
> llc saa7134_alsa mt20xx tea5767 tda9887 tda8290 tuner uas usb_storage
> edac_mce_amd saa7134 tveeprom kvm_amd wmi_bmof videobuf2_dma_sg
> videobuf2_memops evdev videobuf2_v4l2 ccp videobuf2_common kvm radeon
> videodev snd_hda_codec_via irqbypass snd_hda_codec_generic mc
> ledtrig_audio drm_ttm_helper rc_core psmouse ttm snd_hda_codec_hdmi
> snd_pcsp serio_raw via_rhine drm_kms_helper snd_hda_intel mii k10temp
> snd_intel_dspcfg i2c_piix4 snd_intel_sdw_acpi snd_hda_codec drm
> snd_hda_core agpgart snd_hwdep i2c_algo_bit snd_pcm fb_sys_fops
> syscopyarea ohci_pci sysfillrect sysimgblt r8169 snd_timer realtek
> i2c_core snd mdio_devres soundcore libphy atl1e ehci_pci ohci_hcd
> ehci_hcd asus_atk0110 wmi button acpi_cpufreq loop
> [86348.556252] CPU: 5 PID: 8736 Comm: btrfs Tainted: G W         5.15.14 #1
> [86348.556255] Hardware name: System manufacturer System Product
> Name/M4A78 PRO, BIOS 1701    08/16/2010
> [86348.556257] RIP: 0010:btrfs_run_delayed_refs+0x1ab/0x1c0
> [86348.556260] Code: 03 0f 82 44 74 6c 00 83 f8 fb 0f 84 3b 74 6c 00 83
> f8 e2 0f 84 32 74 6c 00 89 c6 48 c7 c7 f8 12 5e a8 89 04 24 e8 4c 27 6b
> 00 <0f> 0b 8b 04 24 e9 17 74 6c 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f
> [86348.556262] RSP: 0018:ffff9d5c03837b30 EFLAGS: 00010286
> [86348.556264] RAX: 0000000000000000 RBX: ffff8e6493e2c800 RCX:
> 0000000000000000
> [86348.556266] RDX: 0000000000000001 RSI: ffffffffa85a6db3 RDI:
> 00000000ffffffff
> [86348.556267] RBP: ffff8e6594cb9c98 R08: 0000000000000000 R09:
> ffff9d5c03837968
> [86348.556268] R10: ffff9d5c03837960 R11: ffffffffa8912680 R12:
> ffff8e65c3761178
> [86348.556269] R13: ffff8e6494452000 R14: ffff8e6494452000 R15:
> 0000000000051dc3
> [86348.556271] FS:  00007f1ccfeb48c0(0000) GS:ffff8e6698140000(0000)
> knlGS:0000000000000000
> [86348.556272] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [86348.556273] CR2: 00007f4239364427 CR3: 000000017f41e000 CR4:
> 00000000000006e0
> [86348.556275] Call Trace:
> [86348.556278]  <TASK>
> [86348.556281]  btrfs_commit_transaction+0x60/0xa00
> [86348.556285]  ? start_transaction+0xd2/0x600
> [86348.556287]  relocate_block_group+0x334/0x580
> [86348.556290]  btrfs_relocate_block_group+0x175/0x340
> [86348.556292]  btrfs_relocate_chunk+0x27/0xe0
> [86348.556296]  btrfs_shrink_device+0x260/0x530
> [86348.556298]  btrfs_rm_device+0x15b/0x4c0

Looks like a device in the process of being removed, the file system
is undergoing shrink, and a bg is being relocated...


> [86348.556301]  ? btrfs_ioctl+0xe91/0x2df0
> [86348.556302]  ? __check_object_size+0x136/0x150
> [86348.556305]  ? preempt_count_add+0x68/0xa0
> [86348.556308]  btrfs_ioctl+0xf27/0x2df0
> [86348.556310]  ? __handle_mm_fault+0xbf9/0x1450
> [86348.556313]  ? handle_mm_fault+0xc5/0x290
> [86348.556315]  ? __x64_sys_ioctl+0x83/0xb0
> [86348.556318]  __x64_sys_ioctl+0x83/0xb0
> [86348.556320]  do_syscall_64+0x3b/0xc0
> [86348.556324]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [86348.556328] RIP: 0033:0x7f1ccffc54b7
> [86348.556331] Code: 00 00 90 48 8b 05 d9 29 0d 00 64 c7 00 26 00 00 00
> 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a9 29 0d 00 f7 d8 64 89 01 48
> [86348.556333] RSP: 002b:00007ffe1f70abe8 EFLAGS: 00000206 ORIG_RAX:
> 0000000000000010
> [86348.556335] RAX: ffffffffffffffda RBX: 00007ffe1f70cd90 RCX:
> 00007f1ccffc54b7
> [86348.556336] RDX: 00007ffe1f70bc10 RSI: 000000005000943a RDI:
> 0000000000000003
> [86348.556337] RBP: 0000000000000001 R08: 1999999999999999 R09:
> 0000000000000000
> [86348.556338] R10: 000000000040838b R11: 0000000000000206 R12:
> 0000000000000000
> [86348.556339] R13: 00007ffe1f70bc10 R14: 0000000000493660 R15:
> 0000000000000003
> [86348.556341]  </TASK>
> [86348.556342] ---[ end trace c8c92460c79df13b ]---
> [86348.556344] BTRFS: error (device dm-1) in
> btrfs_run_delayed_refs:2150: errno=-28 No space left
> [86348.556349] BTRFS info (device dm-1): forced readonly

And it gets confused because it can't successfully relocate the block
group, and it shuts down the file system to prevent confusion being
written to the file system.




>
> btrfs balance start  -dusage=94 -musage=94  . -v
>
> root@dodo:/usr/local/sbin# btrfs fi u /mnt/backup-pool/
> Overall:
>      Device size:                  23.65TiB
>      Device allocated:             13.24TiB
>      Device unallocated:           10.41TiB
>      Device missing:                  0.00B
>      Used:                         13.19TiB
>      Free (estimated):              5.23TiB      (min: 5.23TiB)
>      Data ratio:                       2.00
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>
> Data,RAID1: Size:6.60TiB, Used:6.58TiB (99.62%)
>     /dev/mapper/backup_disk_AC8F    3.59TiB
>     /dev/mapper/backup_disk_CCDZ    2.69TiB
>     /dev/mapper/backup_disk_XVN6    2.69TiB
>     /dev/mapper/backup_disk_E4U5    3.59TiB
>     /dev/mapper/backup_disk_4RNH  660.09GiB
>
> Metadata,RAID1: Size:21.00GiB, Used:20.10GiB (95.74%)
>     /dev/mapper/backup_disk_AC8F   13.00GiB
>     /dev/mapper/backup_disk_CCDZ    9.00GiB
>     /dev/mapper/backup_disk_XVN6    9.00GiB
>     /dev/mapper/backup_disk_E4U5   10.00GiB
>     /dev/mapper/backup_disk_4RNH    1.00GiB
>
> System,RAID1: Size:32.00MiB, Used:1.14MiB (3.56%)
>     /dev/mapper/backup_disk_E4U5   32.00MiB
>     /dev/mapper/backup_disk_4RNH   32.00MiB
>
> Unallocated:
>     /dev/mapper/backup_disk_AC8F   37.00GiB
>     /dev/mapper/backup_disk_CCDZ   34.00GiB
>     /dev/mapper/backup_disk_XVN6   34.00GiB
>     /dev/mapper/backup_disk_E4U5   36.00GiB
>     /dev/mapper/backup_disk_4RNH   10.27TiB
>     /dev/mapper/backup-temp        84.00MiB
> root@dodo:/usr/local/sbin#

OK metadata is raid1, and it's nearly full. But there's multiple
devices with at least a couple GiB unallocated such that at least 2
metadata block groups could be created.

Are you trying to do balance and device remove at the same time?


-- 
Chris Murphy
