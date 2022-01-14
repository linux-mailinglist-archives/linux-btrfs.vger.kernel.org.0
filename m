Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD8848F107
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 21:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244272AbiANUas (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jan 2022 15:30:48 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:30278 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244276AbiANUao (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jan 2022 15:30:44 -0500
X-Sender-Id: 9wt3zsp42r|x-authuser|pete@petezilla.co.uk
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2AAB9921A2F
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 20:24:42 +0000 (UTC)
Received: from kamino.krystal.uk (unknown [127.0.0.6])
        (Authenticated sender: 9wt3zsp42r)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3536E9220F2
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 20:24:41 +0000 (UTC)
X-Sender-Id: 9wt3zsp42r|x-authuser|pete@petezilla.co.uk
Received: from kamino.krystal.uk (kamino.krystal.uk [77.72.1.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.124.31.69 (trex/6.4.3);
        Fri, 14 Jan 2022 20:24:41 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: 9wt3zsp42r|x-authuser|pete@petezilla.co.uk
X-MailChannels-Auth-Id: 9wt3zsp42r
X-Plucky-Trouble: 37043aee773d69ee_1642191881843_1523414280
X-MC-Loop-Signature: 1642191881843:1855050519
X-MC-Ingress-Time: 1642191881843
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=petezilla.co.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bj73ExerB7nwzLJ1n7aRO4E80Ms5DgbWRib5q6AY3dg=; b=Gfu7L//MNyxqm3ewwoi89vBHZo
        rRjztB4QDDbrifD8oGVJ1lCbge69xDVn4iouzWQfrfUKk/2ChtuL+muQgmhY8rp9vpElXzhFs7qer
        qHqu2pHAstZceq4o1P94KufhomnJ4a/WSGs2CXGuiMBcfxgS/iytt7ZJ/4EVfaUSgSz7lQby3+Zpt
        dV4rMMaog2kUqOXKdkmVqWCaXg9HH8TZRrDtLkPfHi7EA+eq+ojvnjod4G2AO3FHosJGYH0/URyek
        E4UEjIO46ouziSk0yg1SOn2j0GKeCOQ0ssLCSMQp+A07bq2uNKql2lFz1cTcntpln+DvzszhHb11Z
        08IDklOg==;
Received: from cpc75872-ando7-2-0-cust919.15-1.cable.virginm.net ([86.13.79.152]:54150 helo=[172.16.100.1])
        by kamino.krystal.uk with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pete@petezilla.co.uk>)
        id 1n8T7n-0009QC-Ns
        for linux-btrfs@vger.kernel.org; Fri, 14 Jan 2022 20:24:39 +0000
Message-ID: <b717a01c-c152-97e9-5485-2f0a95a5d4f5@petezilla.co.uk>
Date:   Fri, 14 Jan 2022 20:24:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Peter Chant <pete@petezilla.co.uk>
Subject: ENOSPC on file system with nearly empty 12TB drive
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AuthUser: pete@petezilla.co.uk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a file system that was _very_ full.  Not ideal, but there were 
reasons.

It comprised of 2x3TB drives and 2x4TB drives.  I added a 12 TB drive 
and tried to rebalance only to

hit ENOSPC.  Surely adding a drive to a full file system fixes this?  
Especially one that nearly doubles its capacity?  Yet I kept hitting 
this issue when

trying to rebalance and also remove a 4TB  full drive.

Yet I have a drive with 11TB of free space. (24TB array)!?


The kernel was a 5.4.x series so I updated to 5.15.14.

I kept hitting the issue, however, after some filtered rebalancing I got 
a little data

off the old drives and onto the new.  I then decided, that since I had a 
 >90% empty 12TB drive

I could safely remove a 4TB drive, surely this would not be an issue?  
Surely it would simply

simply it to the drive with most space, the new 12TB one?  But despite a 
nearly empty 12TB

drive it failed with ENOSPC.


I'm currently running a full rebalance (slow) to see if I can do this 
without hitting ENOSPC and then remove a drive.


Some info, the kernel message:

[86348.556169] ------------[ cut here ]------------
[86348.556175] BTRFS: Transaction aborted (error -28)
[86348.556197] WARNING: CPU: 5 PID: 8736 at fs/btrfs/extent-tree.c:2150 
btrfs_run_delayed_refs+0x1ab/0x1c0
[86348.556205] Modules linked in: nfsd bridge ipv6 8021q garp mrp stp 
llc saa7134_alsa mt20xx tea5767 tda9887 tda8290 tuner uas usb_storage 
edac_mce_amd saa7134 tveeprom kvm_amd wmi_bmof videobuf2_dma_sg 
videobuf2_memops evdev videobuf2_v4l2 ccp videobuf2_common kvm radeon 
videodev snd_hda_codec_via irqbypass snd_hda_codec_generic mc 
ledtrig_audio drm_ttm_helper rc_core psmouse ttm snd_hda_codec_hdmi 
snd_pcsp serio_raw via_rhine drm_kms_helper snd_hda_intel mii k10temp 
snd_intel_dspcfg i2c_piix4 snd_intel_sdw_acpi snd_hda_codec drm 
snd_hda_core agpgart snd_hwdep i2c_algo_bit snd_pcm fb_sys_fops 
syscopyarea ohci_pci sysfillrect sysimgblt r8169 snd_timer realtek 
i2c_core snd mdio_devres soundcore libphy atl1e ehci_pci ohci_hcd 
ehci_hcd asus_atk0110 wmi button acpi_cpufreq loop
[86348.556252] CPU: 5 PID: 8736 Comm: btrfs Tainted: G W         5.15.14 #1
[86348.556255] Hardware name: System manufacturer System Product 
Name/M4A78 PRO, BIOS 1701    08/16/2010
[86348.556257] RIP: 0010:btrfs_run_delayed_refs+0x1ab/0x1c0
[86348.556260] Code: 03 0f 82 44 74 6c 00 83 f8 fb 0f 84 3b 74 6c 00 83 
f8 e2 0f 84 32 74 6c 00 89 c6 48 c7 c7 f8 12 5e a8 89 04 24 e8 4c 27 6b 
00 <0f> 0b 8b 04 24 e9 17 74 6c 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f
[86348.556262] RSP: 0018:ffff9d5c03837b30 EFLAGS: 00010286
[86348.556264] RAX: 0000000000000000 RBX: ffff8e6493e2c800 RCX: 
0000000000000000
[86348.556266] RDX: 0000000000000001 RSI: ffffffffa85a6db3 RDI: 
00000000ffffffff
[86348.556267] RBP: ffff8e6594cb9c98 R08: 0000000000000000 R09: 
ffff9d5c03837968
[86348.556268] R10: ffff9d5c03837960 R11: ffffffffa8912680 R12: 
ffff8e65c3761178
[86348.556269] R13: ffff8e6494452000 R14: ffff8e6494452000 R15: 
0000000000051dc3
[86348.556271] FS:  00007f1ccfeb48c0(0000) GS:ffff8e6698140000(0000) 
knlGS:0000000000000000
[86348.556272] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[86348.556273] CR2: 00007f4239364427 CR3: 000000017f41e000 CR4: 
00000000000006e0
[86348.556275] Call Trace:
[86348.556278]  <TASK>
[86348.556281]  btrfs_commit_transaction+0x60/0xa00
[86348.556285]  ? start_transaction+0xd2/0x600
[86348.556287]  relocate_block_group+0x334/0x580
[86348.556290]  btrfs_relocate_block_group+0x175/0x340
[86348.556292]  btrfs_relocate_chunk+0x27/0xe0
[86348.556296]  btrfs_shrink_device+0x260/0x530
[86348.556298]  btrfs_rm_device+0x15b/0x4c0
[86348.556301]  ? btrfs_ioctl+0xe91/0x2df0
[86348.556302]  ? __check_object_size+0x136/0x150
[86348.556305]  ? preempt_count_add+0x68/0xa0
[86348.556308]  btrfs_ioctl+0xf27/0x2df0
[86348.556310]  ? __handle_mm_fault+0xbf9/0x1450
[86348.556313]  ? handle_mm_fault+0xc5/0x290
[86348.556315]  ? __x64_sys_ioctl+0x83/0xb0
[86348.556318]  __x64_sys_ioctl+0x83/0xb0
[86348.556320]  do_syscall_64+0x3b/0xc0
[86348.556324]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[86348.556328] RIP: 0033:0x7f1ccffc54b7
[86348.556331] Code: 00 00 90 48 8b 05 d9 29 0d 00 64 c7 00 26 00 00 00 
48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a9 29 0d 00 f7 d8 64 89 01 48
[86348.556333] RSP: 002b:00007ffe1f70abe8 EFLAGS: 00000206 ORIG_RAX: 
0000000000000010
[86348.556335] RAX: ffffffffffffffda RBX: 00007ffe1f70cd90 RCX: 
00007f1ccffc54b7
[86348.556336] RDX: 00007ffe1f70bc10 RSI: 000000005000943a RDI: 
0000000000000003
[86348.556337] RBP: 0000000000000001 R08: 1999999999999999 R09: 
0000000000000000
[86348.556338] R10: 000000000040838b R11: 0000000000000206 R12: 
0000000000000000
[86348.556339] R13: 00007ffe1f70bc10 R14: 0000000000493660 R15: 
0000000000000003
[86348.556341]  </TASK>
[86348.556342] ---[ end trace c8c92460c79df13b ]---
[86348.556344] BTRFS: error (device dm-1) in 
btrfs_run_delayed_refs:2150: errno=-28 No space left
[86348.556349] BTRFS info (device dm-1): forced readonly
root@dodo:/home/pete#

I was also getting ENOSPC errors when trying to rebalance, which I 
corrected by adding a loop device on a temporary basis and using dusage 
& musage filters with low values and progressively increasing them. So, 
info from earlier on in this process:



btrfs balance start  -dusage=94 -musage=94  . -v

root@dodo:/usr/local/sbin# btrfs fi u /mnt/backup-pool/
Overall:
     Device size:                  23.65TiB
     Device allocated:             13.24TiB
     Device unallocated:           10.41TiB
     Device missing:                  0.00B
     Used:                         13.19TiB
     Free (estimated):              5.23TiB      (min: 5.23TiB)
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)

Data,RAID1: Size:6.60TiB, Used:6.58TiB (99.62%)
    /dev/mapper/backup_disk_AC8F    3.59TiB
    /dev/mapper/backup_disk_CCDZ    2.69TiB
    /dev/mapper/backup_disk_XVN6    2.69TiB
    /dev/mapper/backup_disk_E4U5    3.59TiB
    /dev/mapper/backup_disk_4RNH  660.09GiB

Metadata,RAID1: Size:21.00GiB, Used:20.10GiB (95.74%)
    /dev/mapper/backup_disk_AC8F   13.00GiB
    /dev/mapper/backup_disk_CCDZ    9.00GiB
    /dev/mapper/backup_disk_XVN6    9.00GiB
    /dev/mapper/backup_disk_E4U5   10.00GiB
    /dev/mapper/backup_disk_4RNH    1.00GiB

System,RAID1: Size:32.00MiB, Used:1.14MiB (3.56%)
    /dev/mapper/backup_disk_E4U5   32.00MiB
    /dev/mapper/backup_disk_4RNH   32.00MiB

Unallocated:
    /dev/mapper/backup_disk_AC8F   37.00GiB
    /dev/mapper/backup_disk_CCDZ   34.00GiB
    /dev/mapper/backup_disk_XVN6   34.00GiB
    /dev/mapper/backup_disk_E4U5   36.00GiB
    /dev/mapper/backup_disk_4RNH   10.27TiB
    /dev/mapper/backup-temp        84.00MiB
root@dodo:/usr/local/sbin#


root@dodo:/usr/local/sbin# btrfs fi show
Label: 'backup_store'  uuid: 2e4162a8-ac38-4d1c-9a10-be873da6fbcc
         Total devices 6 FS bytes used 6.59TiB
         devid    1 size 3.64TiB used 3.60TiB path 
/dev/mapper/backup_disk_AC8F
         devid    2 size 2.73TiB used 2.70TiB path 
/dev/mapper/backup_disk_CCDZ
         devid    3 size 2.73TiB used 2.70TiB path 
/dev/mapper/backup_disk_XVN6
         devid    4 size 3.64TiB used 3.60TiB path 
/dev/mapper/backup_disk_E4U5
         devid    5 size 10.91TiB used 661.12GiB path 
/dev/mapper/backup_disk_4RNH
         devid    6 size 84.00MiB used 0.00B path /dev/mapper/backup-temp

root@dodo:/usr/local/sbin#



-- 
Pete
Peter Chant
07887 748492

