Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661EA4AA936
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 14:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiBENwr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 5 Feb 2022 08:52:47 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:49642 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiBENwr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Feb 2022 08:52:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 8AA7A3F3E9;
        Sat,  5 Feb 2022 14:52:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.909
X-Spam-Level: 
X-Spam-Status: No, score=-1.909 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, T_SCC_BODY_TEXT_LINE=-0.01, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KVmf3IMZFbwf; Sat,  5 Feb 2022 14:52:42 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id C46D03F35C;
        Sat,  5 Feb 2022 14:52:42 +0100 (CET)
Received: from [2a00:801:749:64d3::3bed:ab61] (port=43602 helo=[10.88.124.246])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nGLUd-00097v-PQ; Sat, 05 Feb 2022 14:52:41 +0100
Date:   Sat, 5 Feb 2022 14:52:39 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     Sylvain Falardeau <sylvainf@xsoli.com>, linux-btrfs@vger.kernel.org
Message-ID: <af3d001.f997db31.17eca28822d@tnonline.net>
In-Reply-To: <5bf0501f-c0ae-98f8-9dba-93603af5ed26@tnonline.net>
References: <a12e234f-7085-03af-eaa9-1e1e4b3ad03f@xsoli.com> <5bf0501f-c0ae-98f8-9dba-93603af5ed26@tnonline.net>
Subject: Re: ENOSPC during balance with filesystem switching read-only
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Forza <forza@tnonline.net> -- Sent: 2022-02-05 - 11:01 ----

> Hi,
> 
> 
> On 2022-02-03 16:24, Sylvain Falardeau wrote:
>> Hi,
>> 
>> I have a 6 drive raid1 and wanted to balance it to raid10 with (4x8T, 
>> 2x16T drives):
>> 
> In your other email you state :
> 
> Label: none  uuid: c56123f0-7b5f-46b2-b53a-60f2657e9bf1
>          Total devices 6 FS bytes used 17.70TiB
>          devid    2 size 7.28TiB used 7.23TiB path /dev/sdd1
>          devid    3 size 7.28TiB used 7.28TiB path /dev/sde1
>          devid    4 size 7.28TiB used 7.28TiB path /dev/sdf1
>          devid    5 size 7.26TiB used 7.26TiB path /dev/sdb3
>          devid    6 size 7.24TiB used 5.62TiB path /dev/sda4
>          devid    7 size 14.55TiB used 793.51GiB path /dev/sdc1
> 
> This is 5x8T and 1x16T and it will lead to unbalanced allocations.
> 
>> btrfs balance -dconvert=raid10,soft -mconvert=raid10,soft /srv/backups
>> 
>> It started well but I got the ENOSPC error in the kernel log. After the 
>> error, the filesystem went read-only. I tried unmounting it but the 
>> command hanged. I rebooted and even this was really long before 
>> everything could reboot.
>> 
>> After the reboot I can manually mount the drives but before I can do the 
>> `btrfs balance -dusage=0 -musage=0 /srv/backups` command, the filesystem 
>> becomes read-only again.
>> 
>> Here is `btrfs fi usage -T /srv/backups`:
>> 
>> Overall:
>> 
>>      Device size:                  50.89TiB
>> 
>>      Device allocated:             35.44TiB
>> 
>>      Device unallocated:           15.45TiB
>> 
>>      Device missing:                  0.00B
>> 
>>      Used:                         35.41TiB
>> 
>>      Free (estimated):              7.73TiB      (min: 7.73TiB)
>>      Data ratio:                       2.00
>>      Metadata ratio:                   2.00
>>      Global reserve:              512.00MiB      (used: 0.00B)
>> 
>>               Data      Data      Metadata  Metadata System
>> Id Path      RAID1     RAID10    RAID1     RAID10   RAID1  Unallocated
>> -- --------- --------- --------- --------- -------- -------- -----------
>> 2 /dev/sdd1   6.78TiB 380.44GiB  89.00GiB 40.00MiB        -    43.56GiB
>> 3 /dev/sde1   6.91TiB 302.03GiB  73.00GiB        -        -     1.01MiB
>> 4 /dev/sdf1   6.85TiB 364.03GiB  78.00GiB  8.00MiB        -     1.01MiB 
>> 5 /dev/sdb3   6.88TiB 318.45GiB  65.00GiB 32.00MiB        -     7.26TiB
>> 6 /dev/sda4   5.18TiB 380.44GiB  73.00GiB 40.00MiB 32.00MiB     1.62TiB 
>> 7 /dev/sdc1 401.00GiB 380.44GiB  12.00GiB 40.00MiB 32.00MiB    13.78TiB
>> -- --------- --------- --------- --------- -------- -------- -----------
>>     Total      16.49TiB   1.04TiB 195.00GiB 80.00MiB 32.00MiB    22.71TiB
>>     Used       16.49TiB   1.04TiB 182.21GiB 57.50MiB  3.59MiB
>> 
>> I see devid 3 and 4 missing unallocated space.
> 
> Yes. Without unallocated space, btrfs is unable to allocate a new RAID10 
> block group as it requires 4 devices with 1GiB unallocated each.
> 
> You can see from 
> https://carfax.org.uk/btrfs-usage/?c=2&slo=2&shi=100&p=0&d=1455&d=726&d=728&d=728&d=728&d=728 
> that you will end up with 7.2TiB unusable space in this configuration. 
> However if you switch to RAID1 you can utilize all space.
> 
> Your best bet to solve this is to convert to RAID1. There is unallocated 
> space on dev 2,5,6,7 for RAID1 block groups.
> 
> # btrfs balance start -d convert=raid1 /srv/backups
> 
I was too quick in my answer... 

It is probably better to use "-dconvert=raid1, soft -mconvert=raid1,soft" as it avoids rewriting chunks that  already are using raid1. 

You can actually try this before trying with additional devices:

# mount /srv/backups && btrfs balance start -mconvert=raid1,soft /srv/backups

The idea here is that next metadata allocation should be a raid1 block group instead of a raid10. Raid1 only needs space on 2 devices, whereas raid10 requires space on 4 devices. 

> However, before doing this read below
> 
> 
>> 
>> I mounted with enospc_debug and here are the kernel errors:
>> 
>> Feb 03 08:58:23 jbak100 kernel: BTRFS info (device sdd1): flagging fs 
>> with big metadata feature
>> Feb 03 08:58:23 jbak100 kernel: BTRFS info (device sdd1): metadata ratio 1
>> Feb 03 08:58:23 jbak100 kernel: BTRFS info (device sdd1): disk space 
>> caching is enabled
>> Feb 03 08:58:23 jbak100 kernel: BTRFS info (device sdd1): has skinny 
>> extents
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): checking UUID 
>> tree
>> Feb 03 08:59:55 jbak100 kernel: BTRFS error (device sdd1): allocation 
>> failed flags 68, wanted 16384 tree-log 0, relocation: 0
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): space_info 4 
>> has 13198475264 free, is full
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): space_info 
>> total=209463541760, used=195704438784, pinned=147456, reserved=23592960, 
>> may_use=536887296, readonly=0 zone_unusa
>> ble=0
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): 
>> global_block_rsv: size 536870912 reserved 536870912
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): 
>> trans_block_rsv: size 0 reserved 0
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): 
>> chunk_block_rsv: size 0 reserved 0
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): 
>> delayed_block_rsv: size 0 reserved 0
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): 
>> delayed_refs_rsv: size 816054272 reserved 0
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): block group 
>> 47442697322496 has 67108864 bytes, 60293120 used 0 pinned 6815744 
>> reserved 0 zone_unusable
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): block group 
>> has cluster?: no
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): 0 blocks of 
>> free space at or bigger than bytes is
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): block group 
>> 47442831540224 has 16777216 bytes, 0 used 0 pinned 16777216 reserved 0 
>> zone_unusable
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): block group 
>> has cluster?: no
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): 0 blocks of 
>> free space at or bigger than bytes is
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): block group 
>> 17490243485696 has 1073741824 bytes, 1039826944 used 0 pinned 0 reserved 
>> 0 zone_unusable
>> Feb 03 08:59:55 jbak100 kernel: BTRFS info (device sdd1): block group 
>> has cluster?: no
>> ... some entries deleted
>> Feb 03 08:59:55 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499907162112, bytes 16384, bitmap no
>> Feb 03 08:59:55 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499907162112, bytes 5701632, bitmap yes
>> Feb 03 08:59:55 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499907309568, bytes 16384, bitmap no
>> Feb 03 08:59:55 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499907342336, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499907801088, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499907981312, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499908210688, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499908407296, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499908538368, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499908571136, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499908751360, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499909488640, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499909554176, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499909849088, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499909881856, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499909914624, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499909980160, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499910062080, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499910324224, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499910455296, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499910537216, bytes 16384, bitmap no
>> Feb 03 08:59:56 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499910701056, bytes 16384, bitmap no
>> Feb 03 08:59:57 jbak100 kernel: BTRFS critical (device sdd1): entry 
>> offset 17499910766592, bytes 16384, bitmap no
>> 
>> ... some entries deleted ...
>> 
>> Feb 03 09:00:03 jbak100 kernel: ------------[ cut here ]------------
>> Feb 03 09:00:03 jbak100 kernel: BTRFS: Transaction aborted (error -28)
>> Feb 03 09:00:03 jbak100 kernel: WARNING: CPU: 0 PID: 14685 at 
>> fs/btrfs/extent-tree.c:3084 __btrfs_free_extent.isra.0+0x5fb/0xa60 [btrfs]
>> Feb 03 09:00:03 jbak100 kernel: Modules linked in: cpuid nfsv3 nfs_acl 
>> rpcsec_gss_krb5 auth_rpcgss wireguard curve25519_x86_64 
>> libchacha20poly1305 chacha_x86_64 poly1305_x86_64 libbl
>> ake2s blake2s_x86_64 nfsv4 libcurve25519_generic libchacha 
>> libblake2s_generic ip6_udp_tunnel udp_tunnel nfs lockd grace fscache 
>> netfs zram snd_hda_codec_hdmi i915 snd_hda_codec_realt
>> ek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg 
>> snd_intel_sdw_acpi snd_hda_codec drm_kms_helper snd_hda_core 
>> intel_rapl_msr intel_rapl_common x86_pkg_temp_therm
>> al intel_powerclamp snd_hwdep coretemp snd_pcm cec snd_timer 
>> crct10dif_pclmul snd mei_hdcp ghash_clmulni_intel rc_core mei_me 
>> aesni_intel i2c_algo_bit soundcore fb_sys_fops syscopyar
>> ea mei crypto_simd sysfillrect input_leds sysimgblt at24 wmi_bmof cryptd 
>> eeepc_wmi mac_hid rapl intel_cstate binfmt_misc sch_fq_codel drm sunrpc 
>> ip_tables x_tables autofs4 btrfs blak
>> e2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy 
>> async_pq async_xor async_tx xor
>> Feb 03 09:00:03 jbak100 kernel:  raid6_pq libcrc32c raid0 multipath 
>> linear raid1 hid_generic usbhid uas mfd_aaeon hid usb_storage asus_wmi 
>> sparse_keymap xhci_pci r8169 ahci i2c_i801
>> crc32_pclmul libahci lpc_ich i2c_smbus realtek xhci_pci_renesas wmi video
>> Feb 03 09:00:03 jbak100 kernel: CPU: 0 PID: 14685 Comm: btrfs-balance 
>> Tainted: G        W         5.13.0-28-generic #31~20.04.1-Ubuntu
>> Feb 03 09:00:03 jbak100 kernel: Hardware name: ASUS All 
>> Series/Z87M-PLUS, BIOS 1107 11/04/2014
>> Feb 03 09:00:03 jbak100 kernel: RIP: 
>> 0010:__btrfs_free_extent.isra.0+0x5fb/0xa60 [btrfs]
>> Feb 03 09:00:03 jbak100 kernel: Code: 55 a0 48 c7 c6 20 43 41 c0 e8 1a 
>> 4a 0b 00 44 8b 55 a0 e9 9a fe ff ff 44 89 d6 48 c7 c7 f8 07 42 c0 44 89 
>> 55 a0 e8 90 b4 04 cc <0f> 0b 44 8b 55 a
>> 0 48 8b 7d 90 44 89 d1 ba 0c 0c 00 00 44 89 55 a0
>> Feb 03 09:00:03 jbak100 kernel: RSP: 0018:ffffa03c8948fab8 EFLAGS: 00010286
>> Feb 03 09:00:03 jbak100 kernel: RAX: 0000000000000000 RBX: 
>> ffff922289549368 RCX: 0000000000000027
>> Feb 03 09:00:03 jbak100 kernel: RDX: 0000000000000027 RSI: 
>> 00000000ffffdfff RDI: ffff92268fc209c8
>> Feb 03 09:00:03 jbak100 kernel: RBP: ffffa03c8948fb58 R08: 
>> ffff92268fc209c0 R09: ffffa03c8948f890
>> Feb 03 09:00:03 jbak100 kernel: R10: 0000000000000001 R11: 
>> 0000000000000001 R12: 000028cb4e900000
>> Feb 03 09:00:03 jbak100 kernel: R13: ffff92238a10bf50 R14: 
>> 00000feab8868000 R15: 0000000000000001
>> Feb 03 09:00:03 jbak100 kernel: FS:  0000000000000000(0000) 
>> GS:ffff92268fc00000(0000) knlGS:0000000000000000
>> Feb 03 09:00:03 jbak100 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
>> 0000000080050033
>> Feb 03 09:00:03 jbak100 kernel: CR2: 00007f3a2832f290 CR3: 
>> 0000000053a10004 CR4: 00000000001706f0
>> Feb 03 09:00:03 jbak100 kernel: Call Trace:
>> Feb 03 09:00:03 jbak100 kernel:  <TASK>
>>                               [281/1906]
>> Feb 03 09:00:03 jbak100 kernel:  ? 
>> btrfs_run_delayed_refs_for_head+0x371/0xa30 [btrfs]
>> Feb 03 09:00:03 jbak100 kernel: 
>> btrfs_run_delayed_refs_for_head+0x45f/0xa30 [btrfs]
>> Feb 03 09:00:03 jbak100 kernel:  ? btrfs_block_rsv_release+0xc0/0x2a0 
>> [btrfs]
>> Feb 03 09:00:03 jbak100 kernel:  __btrfs_run_delayed_refs+0x9f/0x5f0 
>> [btrfs]
>> Feb 03 09:00:03 jbak100 kernel:  ? unlock_up+0x15f/0x180 [btrfs]
>> Feb 03 09:00:03 jbak100 kernel:  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
>> Feb 03 09:00:03 jbak100 kernel:  btrfs_commit_transaction+0x64/0xac0 
>> [btrfs]
>> Feb 03 09:00:03 jbak100 kernel:  ? btrfs_free_path+0x27/0x30 [btrfs]
>> Feb 03 09:00:03 jbak100 kernel:  ? kmem_cache_free+0x11a/0x2d0
>> Feb 03 09:00:03 jbak100 kernel:  insert_balance_item.isra.0+0xb8/0x380 
>> [btrfs]
>> Feb 03 09:00:03 jbak100 kernel:  ? psi_task_switch+0xd2/0x250
>> Feb 03 09:00:03 jbak100 kernel:  ? __switch_to+0x11d/0x460
>> Feb 03 09:00:03 jbak100 kernel:  ? __switch_to_asm+0x36/0x70
>> Feb 03 09:00:03 jbak100 kernel:  btrfs_balance+0x328/0x4c0 [btrfs]
>> Feb 03 09:00:03 jbak100 kernel:  ? btrfs_balance+0x4c0/0x4c0 [btrfs]
>> Feb 03 09:00:03 jbak100 kernel:  balance_kthread+0x3b/0x60 [btrfs]
>> Feb 03 09:00:03 jbak100 kernel:  kthread+0x12b/0x150
>> Feb 03 09:00:03 jbak100 kernel:  ? set_kthread_struct+0x40/0x40
>> Feb 03 09:00:03 jbak100 kernel:  ret_from_fork+0x22/0x30
>> Feb 03 09:00:03 jbak100 kernel:  </TASK>
>> Feb 03 09:00:03 jbak100 kernel: ---[ end trace 2b7366758c0507a1 ]---
>> Feb 03 09:00:03 jbak100 kernel: BTRFS: error (device sdd1) in 
>> __btrfs_free_extent:3084: errno=-28 No space left
>> Feb 03 09:00:03 jbak100 kernel: BTRFS: error (device sdd1) in 
>> btrfs_run_delayed_refs:2163: errno=-28 No space left
>> Feb 03 09:00:03 jbak100 kernel: BTRFS error (device sdd1): allocation 
>> failed flags 68, wanted 16384 tree-log 0, relocation: 0
>> Feb 03 09:00:03 jbak100 kernel: BTRFS: error (device sdd1) in 
>> btrfs_create_pending_block_groups:2259: errno=-28 No space left
>> Feb 03 09:00:03 jbak100 kernel: BTRFS error (device sdd1): allocation 
>> failed flags 68, wanted 16384 tree-log 0, relocation: 0
>> Feb 03 09:00:03 jbak100 kernel: BTRFS: error (device sdd1) in 
>> btrfs_create_pending_block_groups:2270: errno=-28 No space left
>> 
>> 
>> 
>> Every time I mount it switches to read-only. I had time to do some `rm` 
>> of files but it did not free space for the balance to at least allocate 
>> the extent it's trying to allocate. I tried mounting with `skip_balance` 
>> but the filesystem still switch to read-only quickly. Any other 
>> `balance` operation complains the filesystem is read-only.
> 
> Btrfs continues a balance operation as soon as it is mounted. You have 
> to mount with skip_balance to stop it.
> 
> 'rm' files may require additional allocations, especially if you have 
> snapshots. A better way is to use "truncate -s 0 somefile". Now the 
> problem is that your filesystem is unable to finish the last transaction 
> without ENOSPC.
> 
> You should seek advise on the #btrfs IRC channel 
> (https://web.libera.chat/#btrfs) on how to get out of this situation, 
> but I believe the only possibility is to add two more devices so that 
> the aborted allocation of a RAID10 block group can finish. Then you can 
> convert back to RAID1 and then delete the two additional devices.
> 
> The devices can be USB sticks or loop files hosted on another 
> filesystem. Never use RAM-disks.
> 
> # mount UUID=c56123f0-7b5f-46b2-b53a-60f2657e9bf1 /srv/backups && btrfs 
> device add /mnt/someotherfs/loop1 /mnt/someotherfs/loop2
> 
> # btrfs balance start -mconvert=raid1,soft /srv/backups
> # btrfs balance start -dconvert=raid1,soft /srv/backups
> # btrfs device remove /mnt/someotherfs/loop1 /srv/backups
> # btrfs device remove /mnt/someotherfs/loop2 /srv/backups
> 
> Good luck!
> 
> Thanks
> Forza
> 
>> 
>> I tried a `btrfs check` during the night and this morning it was killed 
>> by the OOM killer in step 2 of 7. No other error was shown before the 
>> kill. (I have 16G of RAM on this machine).
>> 
>> I also tried to add a 4T USB drive as suggested when you lack space for 
>> balance to continue but the filesystem goes read-only before the `btrfs 
>> dev add` is able to work.
>> 
>> I don't know how to solve this catch-22 problem. I did get the ENOSPC 
>> error before but was able to recover. This time I would certainly 
>> appreciate any help.
>> 
>> Thank you for your time.
>> 


