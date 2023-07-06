Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DA674A3A2
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 20:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGFSQq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 14:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjGFSQq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 14:16:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4501BEE
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 11:16:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8baa836a5so6533275ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jul 2023 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688667404; x=1691259404;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKgP5yLWAalQJVHI05pbUId0PMyy/eRkrR7JyB8dYRg=;
        b=i8JfPWEJThbJpTaxuB3ultzP0gV3HCe6TXOscT7dC8OFMS+asB+PkE03niKLZDex0H
         b/eWQILtpoS7qnmO3pATqpVNNe+oCK/MFIcqWP9eQWsW17Xz8+Avi64BZD+YUn+PMBbn
         +f/biegIvGtKIsavSCmVTJloBdWgnvczfORY+i+yKAwICDNgIfCEynkmSl4VO2FaHvch
         hTh0dOlmIqNXNNs0MnF719kzw+bNlH593DJMXHOFgu6BaMFZwt4j1AqRkmGZ5n/SOFJM
         xPf9qmRrZD3zFDgXE5TpqS7mEcks0CHL1onBGOR6djG50VQrYMYNQCre8wo5rUDkMMws
         TnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688667404; x=1691259404;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yKgP5yLWAalQJVHI05pbUId0PMyy/eRkrR7JyB8dYRg=;
        b=kgTuyURmpDoXPKKCf4G9GITtJZQamtyURWnvLPNPXa9nPgCfsOlPsI30t/W80QQSlm
         vQNmpSKLUMEQ5ok91RYgI/UNTjywofceFLUBTYYtO8POF5PEMePaeE++cYQaCQFXMxEL
         ixmIpo29gZ2Yg/o5VnTI5sabYYH+HIRaB57c0cYtkwOk9Souana9hKnIQS4QK1Rmani2
         9UD7fJ5XZioRSIsrU6nNrwQUTjd8XdTffd2y6dkoBd+Dq5m8xIWL7G08DuOKl/ox6r+S
         u/+9MGMSmHL9DWH8fzVmEBOhUNP9Eq5P0JBTAvFlcuxmV8m0G2WxSZkUVJ0oZDKQYuVo
         Xf7g==
X-Gm-Message-State: ABy/qLaTjFwBI0EkcfemFm6wBK6BWl3LRSN/JNVnaJ2rkjJrKT9wGIel
        5gsZShN4ct5G3LjacQZ6jSY/ykr6u195PQ==
X-Google-Smtp-Source: APBJJlHtVecdNYfe03RBPySCOTJpsHuuONq4afzbCcHp07czAkIz6MEwdozLWBkQwX+SaeECYqYGpQ==
X-Received: by 2002:a17:902:7007:b0:1b8:ae11:bf5b with SMTP id y7-20020a170902700700b001b8ae11bf5bmr2615391plk.62.1688667403464;
        Thu, 06 Jul 2023 11:16:43 -0700 (PDT)
Received: from ?IPV6:240d:1a:893:4200:76db:f39e:4397:7a26? ([240d:1a:893:4200:76db:f39e:4397:7a26])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b001b7f40a8959sm1729766plb.76.2023.07.06.11.16.41
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 11:16:42 -0700 (PDT)
Message-ID: <1ec0c424-3ede-53e1-3ea3-8b25b63b909d@gmail.com>
Date:   Fri, 7 Jul 2023 03:15:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Jiachen YANG <farseerfc@gmail.com>
Subject: ENOSPC Cannot add device or resize max due to Global reserve hit 512M
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, dear btrfs developers

I have a server using btrfs RAID1 for metadata and RAID0 for data:

# btrfs filesystem usage /mnt
Overall:
     Device size:                   1.72TiB
     Device allocated:              1.72TiB
     Device unallocated:            2.09MiB
     Device missing:                  0.00B
     Device slack:                 20.00GiB
     Used:                          1.49TiB
     Free (estimated):            238.78GiB      (min: 238.78GiB)
     Free (statfs, df):           238.78GiB
     Data ratio:                       1.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)
     Multiple profiles:                  no

Data,RAID0: Size:1.60TiB, Used:1.36TiB (85.40%)
    /dev/nvme0n1p3        817.50GiB
    /dev/nvme1n1p2        817.50GiB

Metadata,RAID1: Size:64.00GiB, Used:63.30GiB (98.91%)
    /dev/nvme0n1p3         64.00GiB
    /dev/nvme1n1p2         64.00GiB

System,RAID1: Size:8.00MiB, Used:144.00KiB (1.76%)
    /dev/nvme0n1p3          8.00MiB
    /dev/nvme1n1p2          8.00MiB

Unallocated:
    /dev/nvme0n1p3          1.05MiB
    /dev/nvme1n1p2          1.05MiB

It hit ENOSPC and was forced read-only.

I have been trying with these things without success:

1. btrfs rescue zero-log to drop the log tree
2. mount with 
ro,noatime,skip_balance,nodiscard,clear_cache,nospace_cache , and apply 
operations immediately following mount -oremount,rw
3. trying to balance -dusage after remount,rw
4. trying to `device add` 2 other devices after remount,rw
5. moving the partitions 10G forward using sfdisk, and trying to `btrfs 
filesystem resize max` after remount,rw

After mounting rw, the cleaner picked up an orphan snapshot deletion and 
the global reserve spaces started to go up until it hit around 511.48MiB 
and stopped by transaction commit failure.
I can confirm the orphaning by `btrfs-orphan-cleaner-progress` command 
from `python-btrfs`

# btrfs-orphan-cleaner-progress /mnt
1 orphans left to clean
dropping root 36480 for at least 0 sec drop_progress (439534 EXTENT_DATA 0)


`btrfs resize max` can enlarge one device and failed afterwards:

Overall:
     Device size:                   1.73TiB
     Device allocated:              1.72TiB
     Device unallocated:           10.00GiB
     Device missing:                  0.00B
     Device slack:                 10.00GiB
     Used:                          1.49TiB
     Free (estimated):            248.79GiB      (min: 243.79GiB)
     Free (statfs, df):           248.78GiB
     Data ratio:                       1.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 511.48MiB)
     Multiple profiles:                  no

Data,RAID0: Size:1.60TiB, Used:1.36TiB (85.40%)
    /dev/nvme0n1p3        817.50GiB
    /dev/nvme1n1p2        817.50GiB

Metadata,RAID1: Size:64.00GiB, Used:63.20GiB (98.76%)
    /dev/nvme0n1p3         64.00GiB
    /dev/nvme1n1p2         64.00GiB

System,RAID1: Size:8.00MiB, Used:144.00KiB (1.76%)
    /dev/nvme0n1p3          8.00MiB
    /dev/nvme1n1p2          8.00MiB

Unallocated:
    /dev/nvme0n1p3         10.00GiB
    /dev/nvme1n1p2          1.05MiB


The dmesg output like this:

[Jul 6 17:57] BTRFS info (device nvme0n1p3): using crc32c (crc32c-intel) 
checksum algorithm
[  +0.000019] BTRFS info (device nvme0n1p3): force clearing of disk cache
[  +0.000006] BTRFS info (device nvme0n1p3): disabling tree log
[  +0.373237] BTRFS info (device nvme0n1p3): checking UUID tree
[ +18.385270] ------------[ cut here ]------------
[  +0.000006] BTRFS: Transaction aborted (error -28)
[  +0.002486] WARNING: CPU: 0 PID: 15054 at fs/btrfs/extent-tree.c:3053 
__btrfs_free_extent+0xb26/0x11a0 [btrfs]
[  +0.000215] Modules linked in: pktcdvd ccm qrtr algif_aead cbc 
des_generic libdes ecb algif_skcipher cmac md4 algif_hash af_alg 
intel_rapl_msr intel_rapl_common intel_uncore_frequency
  intel_uncore_frequency_common isst_if_common skx_edac nfit 
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass 
ipmi_ssif crct10dif_pclmul polyval_clmulni polyval_gen
eric gf128mul acpi_ipmi ghash_clmulni_intel cfg80211 iTCO_wdt 
intel_pmc_bxt iTCO_vendor_support rapl mei_me joydev ipmi_si dell_smbios 
rfkill wmi_bmof intel_cstate dell_wmi_descriptor m
ousedev pcspkr ipmi_devintf mei intel_uncore i2c_i801 intel_pch_thermal 
spi_nor dcdbas ipmi_msghandler acpi_power_meter mac_hid lpc_ich mtd 
i2c_smbus pkcs8_key_parser fuse dm_mod bpf_pr
eload ip_tables x_tables overlay squashfs loop isofs sr_mod cdrom uas 
usb_storage usbhid btrfs blake2b_generic xor raid6_pq libcrc32c 
crc32c_generic crc32_pclmul crc32c_intel sha512_sss
e3 ixgbe aesni_intel nvme mdio_devres crypto_simd igb nvme_core cryptd 
spi_intel_pci libphy nvme_common dca
[  +0.000207]  spi_intel mgag200 mdio xhci_pci i2c_algo_bit 
xhci_pci_renesas wmi
[  +0.000020] CPU: 0 PID: 15054 Comm: btrfs Tainted: G        W 
6.4.1-arch2-1 #1 cf34d70ffed66439727ee92a8197bd2b3e0b11de
[  +0.000013] Hardware name: Dell Inc. PowerEdge C6420/0K2TT6, BIOS 
2.4.8 11/27/2019
[  +0.000004] RIP: 0010:__btrfs_free_extent+0xb26/0x11a0 [btrfs]
[  +0.000189] Code: ff ff 84 c0 0f 85 0e 02 00 00 0f 1f 44 00 00 41 b8 
01 00 00 00 e9 cc fd ff ff 8b 74 24 0c 48 c7 c7 e8 e8 c6 c0 e8 4a 77 fa 
c9 <0f> 0b e9 1a fa ff ff 89 df e8 4c 21 f
f ff 84 c0 0f 85 d7 02 00 00
[  +0.000007] RSP: 0018:ffffb49f0cd17a70 EFLAGS: 00010286
[  +0.000008] RAX: 0000000000000000 RBX: 000000a00b4f8000 RCX: 
0000000000000027
[  +0.000006] RDX: ffff9d82ffea16c8 RSI: 0000000000000001 RDI: 
ffff9d82ffea16c0
[  +0.000006] RBP: ffff9d73ee9f7d68 R08: 0000000000000000 R09: 
ffffb49f0cd17900
[  +0.000005] R10: 0000000000000003 R11: ffff9d933ff6ab28 R12: 
0000000000000001
[  +0.000004] R13: 0000000000000000 R14: ffff9d7ee24c6410 R15: 
ffff9d73ce844930
[  +0.000005] FS:  00007f600bb03900(0000) GS:ffff9d82ffe00000(0000) 
knlGS:0000000000000000
[  +0.000007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000005] CR2: 0000564b74903890 CR3: 00000002acc02005 CR4: 
00000000007706f0
[  +0.000006] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  +0.000004] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  +0.000005] PKRU: 55555554
[  +0.000003] Call Trace:
[  +0.000006]  <TASK>
[  +0.000004]  ? __btrfs_free_extent+0xb26/0x11a0 [btrfs 
ba0d149848218bf804d988954b86cfb98d7e0e76]
[  +0.000189]  ? __warn+0x81/0x130
[  +0.000015]  ? __btrfs_free_extent+0xb26/0x11a0 [btrfs 
ba0d149848218bf804d988954b86cfb98d7e0e76]
[  +0.000189]  ? report_bug+0x171/0x1a0
[  +0.000019]  ? handle_bug+0x3c/0x80
[  +0.000010]  ? exc_invalid_op+0x17/0x70
[  +0.000009]  ? asm_exc_invalid_op+0x1a/0x20
[  +0.000020]  ? __btrfs_free_extent+0xb26/0x11a0 [btrfs 
ba0d149848218bf804d988954b86cfb98d7e0e76]
[  +0.000193]  __btrfs_run_delayed_refs+0x7a2/0x11d0 [btrfs 
ba0d149848218bf804d988954b86cfb98d7e0e76]
[  +0.000196]  btrfs_run_delayed_refs+0x91/0x200 [btrfs 
ba0d149848218bf804d988954b86cfb98d7e0e76]
[  +0.000189]  btrfs_commit_transaction+0x654/0xf00 [btrfs 
ba0d149848218bf804d988954b86cfb98d7e0e76]
[  +0.000209]  ? __pfx_autoremove_wake_function+0x10/0x10
[  +0.000019]  btrfs_ioctl_resize+0x450/0x480 [btrfs 
ba0d149848218bf804d988954b86cfb98d7e0e76]
[  +0.000254]  btrfs_ioctl+0x1e5/0x2420 [btrfs 
ba0d149848218bf804d988954b86cfb98d7e0e76]
[  +0.000244]  ? __wake_up_common_lock+0x8f/0xd0
[  +0.000016]  ? file_tty_write.isra.0+0x22a/0x350
[  +0.000012]  ? __pfx_n_tty_write+0x10/0x10
[  +0.000016]  __x64_sys_ioctl+0x91/0xd0
[  +0.000012]  do_syscall_64+0x5d/0x90
[  +0.000018]  ? syscall_exit_to_user_mode+0x1b/0x40
[  +0.000009]  ? do_syscall_64+0x6c/0x90
[  +0.000012]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  +0.000010] RIP: 0033:0x7f600bc5e76f
[  +0.000041] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 2
4 18 64 48 2b 04 25 28 00 00
[  +0.000006] RSP: 002b:00007fff6f81dd60 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  +0.000009] RAX: ffffffffffffffda RBX: 00007fff6f81f590 RCX: 
00007f600bc5e76f
[  +0.000005] RDX: 00007fff6f81def0 RSI: 0000000050009403 RDI: 
0000000000000003
[  +0.000005] RBP: 0000000000000003 R08: 0000000000000410 R09: 
0000000000000001
[  +0.000004] R10: 0000000000000003 R11: 0000000000000246 R12: 
00007fff6f81f594
[  +0.000005] R13: 000055a2cd8a3350 R14: 000055a2cca89872 R15: 
00007fff6f81def0
[  +0.000012]  </TASK>
[  +0.000002] ---[ end trace 0000000000000000 ]---
[  +0.000008] BTRFS info (device nvme0n1p3: state A): dumping space info:
[  +0.000007] BTRFS info (device nvme0n1p3: state A): space_info DATA 
has 256392597504 free, is not full
[  +0.000007] BTRFS info (device nvme0n1p3: state A): space_info 
total=1755577581568, used=1499184852992, pinned=0, reserved=0, 
may_use=0, readonly=131072 zone_unusable=0
[  +0.000010] BTRFS info (device nvme0n1p3: state A): space_info 
METADATA has -540672 free, is full
[  +0.000006] BTRFS info (device nvme0n1p3: state A): space_info 
total=68719476736, used=67883679744, pinned=355762176, 
reserved=479903744, may_use=540672, readonly=131072 zone_unusable
=0
[  +0.000009] BTRFS info (device nvme0n1p3: state A): space_info SYSTEM 
has 8208384 free, is not full
[  +0.000006] BTRFS info (device nvme0n1p3: state A): space_info 
total=8388608, used=147456, pinned=32768, reserved=0, may_use=0, 
readonly=0 zone_unusable=0
[  +0.000008] BTRFS info (device nvme0n1p3: state A): global_block_rsv: 
size 536870912 reserved 540672
[  +0.000006] BTRFS info (device nvme0n1p3: state A): trans_block_rsv: 
size 0 reserved 0
[  +0.000005] BTRFS info (device nvme0n1p3: state A): chunk_block_rsv: 
size 0 reserved 0
[  +0.000005] BTRFS info (device nvme0n1p3: state A): delayed_block_rsv: 
size 0 reserved 0
[  +0.000004] BTRFS info (device nvme0n1p3: state A): delayed_refs_rsv: 
size 14152892416 reserved 0
[  +0.000010] BTRFS: error (device nvme0n1p3: state A) in 
__btrfs_free_extent:3053: errno=-28 No space left
[  +0.001688] BTRFS info (device nvme0n1p3: state EA): forced readonly
[  +0.000008] BTRFS error (device nvme0n1p3: state EA): failed to run 
delayed ref for logical 687384526848 num_bytes 16384 type 176 action 2 
ref_mod 1: -28
[  +0.003143] BTRFS: error (device nvme0n1p3: state EA) in 
btrfs_run_delayed_refs:2127: errno=-28 No space left
[  +0.001079] BTRFS warning (device nvme0n1p3: state EA): Skipping 
commit of aborted transaction.
[  +0.000004] BTRFS: error (device nvme0n1p3: state EA) in 
cleanup_transaction:1978: errno=-28 No space left
[  +0.163882] BTRFS info (device nvme0n1p3: state EA): resize device 
/dev/nvme0n1p3 (devid 1) from 946517753856 to 957255172096

Is there anything else I can try to solve this situation? Can I somehow 
suspend the orphaning of the snapshot, to let it add more devices or 
space for the metadata?

I have exported the data through btrfs send when it is read-only.

Thank you

