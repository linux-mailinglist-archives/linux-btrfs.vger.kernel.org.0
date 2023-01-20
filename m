Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511DF67602A
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 23:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjATWal (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 17:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATWak (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 17:30:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38E81630E
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 14:30:38 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m15so5112148wms.4
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 14:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G68lrUnrxaPocVtqPjLEqgL2T7EGp36iz91zUUrwOWQ=;
        b=Kg41+C27sfbopD8XKfnLRti3HqjCMdNQzC43gFFnJ2lVdXYwLuqVSMobBh3zBL6juJ
         vnwDSlpM6yM4JQDhVpVDy+aicc4sKYPFkGR5fGm2+vylHFHw3Tzai0x5lRxxdBU44kWz
         RsYowv3AAcPXCdmgmKdI9Vjr9A8B3QwzapRmBmTJrsfAbQ8sNV/RYvCz6AXJSPvuL8FR
         kLRK9FXz1iAA34vTSTVh41vB8iWVcbFwwYQ1ItDDn8CJhMjE9e0RInIDGX4yfXnemYPv
         jGxkuj3QGPRW9j7CDgMy/mED5sWPn4nGpbYbbIityqoCqgsQC5gy2uXSE3wmLQeN5L6z
         t5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G68lrUnrxaPocVtqPjLEqgL2T7EGp36iz91zUUrwOWQ=;
        b=J4BZOhpqFfYgtNgJAHkpcI8aWbpP8wqRBx5PRk43cqexSmTOqFlzAMXOerrH1GGloA
         1NsTgHYicfcX8garomNWeEIvlHI6EV/hk3tWnvpLT057Igq72oxepmZY1noTKEBlUjvw
         y4tShJCGJh/kK8LfSn1dWcbVErVDKMo5bA8rGe1XIZMBlrtMIouA0TWZitOJJ2mz1LbP
         HZPJsrqIWSeryQI2Wk+5Jwx21rT4nAIpWc0hH0WP+dxIh01nvqnDInMHJBUO+cpCfcDp
         L49MtDed9cJNc2M0Yh2mjyznF9DWfpJqj+CWvLY3iKdSGR16c7EyR5y9a6RAy+BKrrla
         qXeA==
X-Gm-Message-State: AFqh2kpD7IAXk64v9RqOAWMXrRCx/ov/dMmM9HmWY2rXrP8siZTFWzWs
        HdWBujCwZUenWwPqfbYv70iEf3pjYa0=
X-Google-Smtp-Source: AMrXdXvusLtMKRgwX8BtXArerGKS0CHh+JkXDatwaDHGuA+pQ6pcRswsEvwPeTKJXsuwLB3VxA3u1w==
X-Received: by 2002:a05:600c:3296:b0:3cf:82b9:2fe6 with SMTP id t22-20020a05600c329600b003cf82b92fe6mr16568444wmp.8.1674253837168;
        Fri, 20 Jan 2023 14:30:37 -0800 (PST)
Received: from [192.168.178.76] (p57a6005b.dip0.t-ipconnect.de. [87.166.0.91])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003dafb0c8dfbsm3890571wmi.14.2023.01.20.14.30.36
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 14:30:36 -0800 (PST)
Message-ID: <e8915874-0fef-66f5-172d-0720bfe41736@gmail.com>
Date:   Fri, 20 Jan 2023 23:30:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   =?UTF-8?B?QmrDtnJuIEXDn3dlaW4=?= <bjoern.esswein@gmail.com>
Subject: btrfs balance -musage segfaulted
To:     linux-btrfs@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

in order to free some disk space on my small disk, I ran btrfs balance 
start -musage=20 / and it worked fine.
The second run with increased musage to 25 segfaulted.
I tried again with musage 21 and got stuck at 50%.

The reason why I wanted to balance metadata is that the docker btrfs 
backend, some year ago when my disk was full, created thousands of 
subvolumes and I thought that maybe this caused allocation of metadata 
space that I would never need again.
Back then I had to delete all of them manually and reinstall docker to 
clean this up. The only reminders of this are that the largest subvolume 
id is 42411 and that my metadata is only 37.75% used.

btrfs check --readonly complains about missing backrefs (Output see 
http://cwillu.com:8080/84.181.170.52/1).

As far as I can see all my files are still available, so how critical is 
this?
Can this be repaired?

Kind regards
Björn

-----------------------------------------------------------------
Debug output:

# uname -a
Linux <hostname> 5.10.0-19-amd64 #1 SMP Debian 5.10.149-2 (2022-10-21) 
x86_64 GNU/Linux


# btrfs --version
btrfs-progs v5.10.1


# btrfs fi show /
Label: none  uuid: 97bd86f9-fe75-45c3-b622-04774046c232
         Total devices 1 FS bytes used 25.25GiB
         devid    1 size 38.00GiB used 29.57GiB path /dev/sda1


# btrfs fi df /
Data, single: total=26.01GiB, used=24.59GiB
System, DUP: total=32.00MiB, used=16.00KiB
Metadata, DUP: total=1.75GiB, used=676.08MiB
GlobalReserve, single: total=99.52MiB, used=0.00B


# btrfs fi usage /
Overall:
     Device size:                  38.00GiB
     Device allocated:             29.57GiB
     Device unallocated:            8.43GiB
     Device missing:                  0.00B
     Used:                         25.90GiB
     Free (estimated):              9.86GiB      (min: 5.65GiB)
     Free (statfs, df):             9.86GiB
     Data ratio:                       1.00
     Metadata ratio:                   2.00
     Global reserve:               99.52MiB      (used: 0.00B)
     Multiple profiles:                  no

Data,single: Size:26.01GiB, Used:24.58GiB (94.50%)
    /dev/sda1      26.01GiB

Metadata,DUP: Size:1.75GiB, Used:676.52MiB (37.75%)
    /dev/sda1       3.50GiB

System,DUP: Size:32.00MiB, Used:16.00KiB (0.05%)
    /dev/sda1      64.00MiB

Unallocated:
    /dev/sda1       8.43GiB


# dmesg
[5831866.035782] BTRFS info (device sda1): balance: start -musage=20 
-susage=20
[5831866.036045] BTRFS info (device sda1): relocating block group 
59160657920 flags system|dup
[5831866.092503] BTRFS info (device sda1): balance: ended with status: 0
[5831870.275442] BTRFS info (device sda1): balance: start -musage=25 
-susage=25
[5831870.275600] BTRFS info (device sda1): relocating block group 
59194212352 flags system|dup
[5831870.316230] BTRFS info (device sda1): relocating block group 
30408704 flags metadata|dup
[5831878.470193] general protection fault, probably for non-canonical 
address 0xa07c44df2996f647: 0000 [#1] SMP PTI
[5831878.470488] CPU: 1 PID: 3639391 Comm: btrfs Not tainted 
5.10.0-19-amd64 #1 Debian 5.10.149-2
[5831878.470651] Hardware name: netcup KVM Server, BIOS VPS 500 G7 SE 
11/15/2018
[5831878.471011] RIP: 0010:btrfs_backref_cleanup_node+0x51/0x1f0 [btrfs]
[5831878.471126] Code: 00 00 48 8d 46 40 49 89 fe 49 bd 00 01 00 00 00 
00 ad de 49 bc 22 01 00 00 00 00 ad de 48 89 04 24 eb 73 4c 8b 7d 40 4c 
89 ff <49> 8b 5f 28 e8 56 d0 06 de 84 c0 74 0e 49 8b 17 49 8b 47 08 48 89
[5831878.471388] RSP: 0018:ffffacc982ae7c78 EFLAGS: 00010212
[5831878.471558] RAX: a07c44df2996f647 RBX: ffff9fcf8278c820 RCX: 
000000000020000a
[5831878.471667] RDX: 000000000020000b RSI: ffff9fcf81f49280 RDI: 
a07c44df2996f647
[5831878.471784] RBP: ffff9fcf81f49280 R08: 0000000000000001 R09: 
0000000000000000
[5831878.471893] R10: 0000000000000000 R11: 0000000000034300 R12: 
dead000000000122
[5831878.472008] R13: dead000000000100 R14: ffff9fcf8278c820 R15: 
a07c44df2996f647
[5831878.472122] FS:  00007f8cd3fd79c0(0000) GS:ffff9fcffdd00000(0000) 
knlGS:0000000000000000
[5831878.472234] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[5831878.472338] CR2: 00007fdcb1be5000 CR3: 0000000009cb6001 CR4: 
00000000000606e0
[5831878.472474] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[5831878.472579] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[5831878.472683] Call Trace:
[5831878.472846]  btrfs_backref_release_cache+0x62/0xd0 [btrfs]
[5831878.472976]  relocate_block_group+0x2d9/0x640 [btrfs]
[5831878.473132]  btrfs_relocate_block_group+0x160/0x310 [btrfs]
[5831878.473272]  btrfs_relocate_chunk+0x27/0xc0 [btrfs]
[5831878.473455]  btrfs_balance+0x6fe/0xed0 [btrfs]
[5831878.473610]  btrfs_ioctl_balance+0x2ca/0x380 [btrfs]
[5831878.473788]  __x64_sys_ioctl+0x8b/0xc0
[5831878.473987]  do_syscall_64+0x33/0x80
[5831878.474111]  entry_SYSCALL_64_after_hwframe+0x61/0xc6
[5831878.474234] RIP: 0033:0x7f8cd41985f7
[5831878.474368] Code: 00 00 00 48 8b 05 99 c8 0d 00 64 c7 00 26 00 00 
00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 c8 0d 00 f7 d8 64 89 01 48
[5831878.474638] RSP: 002b:00007ffe62324a28 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[5831878.474746] RAX: ffffffffffffffda RBX: 00007ffe62324ac8 RCX: 
00007f8cd41985f7
[5831878.474857] RDX: 00007ffe62324ac8 RSI: 00000000c4009420 RDI: 
0000000000000003
[5831878.474960] RBP: 0000000000000003 R08: 0000000000000000 R09: 
000000000000000f
[5831878.475063] R10: 00007f8cd41dfa90 R11: 0000000000000246 R12: 
0000000000000000
[5831878.475167] R13: 0000000000000000 R14: 00007ffe6232581a R15: 
0000000000000001
[5831878.475285] Modules linked in: binfmt_misc ufs qnx4 hfsplus hfs 
minix vfat msdos fat jfs xfs ext4 crc16 mbcache jbd2 dm_mod sctp xt_nat 
xt_tcpudp veth xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat 
nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
xfrm_user xfrm_algo nft_counter xt_addrtype nft_compat nf_tables 
crc32c_generic nfnetlink br_netfilter bridge stp llc overlay 
ghash_clmulni_intel aesni_intel bochs_drm drm_vram_helper libaes 
drm_ttm_helper crypto_simd cryptd glue_helper ttm joydev evdev 
drm_kms_helper qemu_fw_cfg sg virtio_balloon pcspkr cec virtio_console 
serio_raw button drm fuse configfs ip_tables x_tables autofs4 btrfs xor 
raid6_pq libcrc32c hid_generic usbhid hid sd_mod t10_pi crc_t10dif 
crct10dif_generic virtio_net sr_mod cdrom net_failover failover 
virtio_scsi ata_generic ata_piix uhci_hcd libata crct10dif_pclmul 
crct10dif_common crc32_pclmul ehci_hcd crc32c_intel usbcore scsi_mod 
psmouse virtio_pci virtio_ring virtio i2c_piix4 usb_common floppy
[5831878.477547] ---[ end trace 83851f7d785704df ]---
[5831878.478417] RIP: 0010:btrfs_backref_cleanup_node+0x51/0x1f0 [btrfs]
[5831878.479248] Code: 00 00 48 8d 46 40 49 89 fe 49 bd 00 01 00 00 00 
00 ad de 49 bc 22 01 00 00 00 00 ad de 48 89 04 24 eb 73 4c 8b 7d 40 4c 
89 ff <49> 8b 5f 28 e8 56 d0 06 de 84 c0 74 0e 49 8b 17 49 8b 47 08 48 89
[5831878.480885] RSP: 0018:ffffacc982ae7c78 EFLAGS: 00010212
[5831878.481640] RAX: a07c44df2996f647 RBX: ffff9fcf8278c820 RCX: 
000000000020000a
[5831878.482425] RDX: 000000000020000b RSI: ffff9fcf81f49280 RDI: 
a07c44df2996f647
[5831878.483202] RBP: ffff9fcf81f49280 R08: 0000000000000001 R09: 
0000000000000000
[5831878.484003] R10: 0000000000000000 R11: 0000000000034300 R12: 
dead000000000122
[5831878.484727] R13: dead000000000100 R14: ffff9fcf8278c820 R15: 
a07c44df2996f647
[5831878.485449] FS:  00007f8cd3fd79c0(0000) GS:ffff9fcffdd00000(0000) 
knlGS:0000000000000000
[5831878.486229] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[5831878.486979] CR2: 00007fdcb1be5000 CR3: 0000000009cb6001 CR4: 
00000000000606e0
[5831878.496751] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[5831878.498033] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400

