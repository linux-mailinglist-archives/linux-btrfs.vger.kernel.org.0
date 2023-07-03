Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5166746086
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 18:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjGCQOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 12:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjGCQOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 12:14:09 -0400
Received: from relay.archworks.co (relay.archworks.co [65.21.53.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEC9E42
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 09:14:07 -0700 (PDT)
Received: from mail.archworks.co (62-178-168-195.cable.dynamic.surfer.at [62.178.168.195])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: mailserver@archworks.co)
        by relay.archworks.co (Postfix) with ESMTPSA id C9A29A0AC
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 18:14:06 +0200 (CEST)
Received: from [10.0.0.210] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: norbert.morawski@archworks.co)
        by mail.archworks.co (Postfix) with ESMTPSA id 9CCFC1038C7
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 18:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=archworks.co; s=k2;
        t=1688400844; bh=8vLANZ/Kt8+uwkOO3nPa/q6hfg3p+VMzlWEyswzIofk=;
        h=Date:Subject:References:To:From:In-Reply-To;
        b=Gp+JWRFxKURkgdYa5PkcNmZpRvicKDjad5ec8C+I1gKizXWl/MVg9YVcjRQVVgApT
         U3BPV3KInfEkOdWJ4QtrOa8q0gk0GldO76IuMNH/urRetqXp1wuFgtPFhP4xvr8kwY
         IkSOfoMecLIo5J3ERCtT/4G7R6oGKQxxEcc/SNck=
Message-ID: <976ad555-24f8-b357-ed9d-5c2433a9dc19@archworks.co>
Date:   Mon, 3 Jul 2023 18:14:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Balance "error (device sda: state A) in __btrfs_free_extent"
Content-Language: de-AT, en-US
References: <015b689d-d27f-29f6-30e3-d130b5744196@archworks.co>
To:     linux-btrfs@vger.kernel.org
From:   Norbert Morawski <norbert.morawski@archworks.co>
In-Reply-To: <015b689d-d27f-29f6-30e3-d130b5744196@archworks.co>
X-Forwarded-Message-Id: <015b689d-d27f-29f6-30e3-d130b5744196@archworks.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, extending on my previous message, this is the full Kernel Trace.

I will soon migrate the File system away and will not be able to provide future information.

```
[47387.587073] BTRFS info (device sda): using crc32c (crc32c-intel) checksum algorithm
[47387.587083] BTRFS info (device sda): using free space tree
[47401.979578] BTRFS info (device sda): auto enabling async discard
[47402.033163] BTRFS info (device sda): checking UUID tree
[47407.000728] BTRFS info (device sda): balance: resume -dconvert=raid6,soft -mconvert=raid1c3,soft -sconvert=raid1c3,soft
[47407.011120] BTRFS info (device sda): relocating block group 9808661970944 flags data
[47417.744167] BTRFS info (device sda): found 8 extents, stage: move data extents
[47422.816645] BTRFS info (device sda): found 8 extents, stage: update data pointers
[47426.122255] BTRFS info (device sda): relocating block group 9807588229120 flags data
[47435.838979] BTRFS info (device sda): found 19 extents, stage: move data extents
[47437.382312] ------------[ cut here ]------------
[47437.382315] BTRFS: Transaction aborted (error -28)
[47437.382347] WARNING: CPU: 9 PID: 797356 at fs/btrfs/extent-tree.c:3077 __btrfs_free_extent+0xb51/0x1140 [btrfs]
[47437.382398] Modules linked in: tcp_diag inet_diag veth ebtable_filter ebtables ip_set ip6table_raw iptable_raw ip6table_filter ip6_tables iptable_filter sctp ip6_udp_tunnel udp_tunnel ipmi_devintf ipmi_msghandler scsi_transport_iscsi nf_tables nvme_fabrics iptable_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp bpfilter softdog binfmt_misc bonding tls nfnetlink_log nfnetlink intel_rapl_msr intel_rapl_common edac_mce_amd snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi kvm_amd snd_hda_codec snd_hda_core ppdev kvm crct10dif_pclmul snd_hwdep polyval_clmulni polyval_generic zfs(PO) ghash_clmulni_intel snd_pcm sha512_ssse3 aesni_intel zunicode(PO) snd_timer crypto_simd zzstd(O) cryptd snd rapl zlua(O) soundcore wmi_bmof ccp pcspkr k10temp zavl(PO) parport_pc parport icp(PO) mac_hid zcommon(PO) znvpair(PO) spl(O) vhost_net vhost vhost_iotlb tap vfio_pci vfio_pci_core irqbypass vfio_iommu_type1 nfsd vfio iommufd auth_rpcgss nfs_acl nct6775 lockd 
nct6775_core grace
[47437.382449]  hwmon_vid drm efi_pstore sunrpc dmi_sysfs ip_tables x_tables autofs4 btrfs blake2b_generic xor raid6_pq simplefb uas usb_storage hid_generic usbhid hid dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio libcrc32c xhci_pci nvme xhci_pci_renesas crc32_pclmul i2c_piix4 r8169 nvme_core ahci realtek xhci_hcd libahci nvme_common wmi gpio_amdpt
[47437.382472] CPU: 9 PID: 797356 Comm: btrfs-balance Tainted: P        W  O       6.2.16-3-pve #1
[47437.382474] Hardware name: Micro-Star International Co., Ltd. MS-7B79/X470 GAMING PLUS MAX (MS-7B79), BIOS H.F0 05/24/2022
[47437.382476] RIP: 0010:__btrfs_free_extent+0xb51/0x1140 [btrfs]
[47437.382520] Code: 48 c7 c6 e8 54 6f c0 48 8b 78 50 e8 c9 69 0e 00 41 b8 01 00 00 00 e9 9b fd ff ff 8b 75 94 48 c7 c7 10 55 6f c0 e8 af 11 6f f9 <0f> 0b e9 f3 f9 ff ff 89 df e8 11 11 ff ff 84 c0 0f 85 6d 02 00 00
[47437.382522] RSP: 0018:ffffac1d642d79d8 EFLAGS: 00010246
[47437.382524] RAX: 0000000000000000 RBX: 00001b7ff9248000 RCX: 0000000000000000
[47437.382526] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[47437.382527] RBP: ffffac1d642d7a78 R08: 0000000000000000 R09: 0000000000000000
[47437.382528] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[47437.382529] R13: 0000000000000000 R14: ffff9cb834030a90 R15: ffff9caed94c4700
[47437.382530] FS:  0000000000000000(0000) GS:ffff9cc4bec40000(0000) knlGS:0000000000000000
[47437.382532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[47437.382533] CR2: 00007fe383fbe000 CR3: 000000058fe48000 CR4: 00000000003506e0
[47437.382535] Call Trace:
[47437.382536]  <TASK>
[47437.382540]  __btrfs_run_delayed_refs+0x7e6/0x1220 [btrfs]
[47437.382586]  btrfs_run_delayed_refs+0x6d/0x1f0 [btrfs]
[47437.382630]  btrfs_commit_transaction+0x7a6/0xf40 [btrfs]
[47437.382677]  ? btrfs_update_reloc_root+0x137/0x250 [btrfs]
[47437.382735]  prepare_to_merge+0x2c5/0x410 [btrfs]
[47437.382792]  relocate_block_group+0x12e/0x510 [btrfs]
[47437.382849]  btrfs_relocate_block_group+0x2a4/0x440 [btrfs]
[47437.382905]  btrfs_relocate_chunk+0x40/0x190 [btrfs]
[47437.382960]  btrfs_balance+0x926/0x1580 [btrfs]
[47437.383015]  ? raw_spin_rq_unlock+0x10/0x40
[47437.383021]  ? __pfx_balance_kthread+0x10/0x10 [btrfs]
[47437.383076]  balance_kthread+0x74/0x120 [btrfs]
[47437.383131]  kthread+0xe9/0x110
[47437.383134]  ? __pfx_kthread+0x10/0x10
[47437.383137]  ret_from_fork+0x2c/0x50
[47437.383141]  </TASK>
[47437.383142] ---[ end trace 0000000000000000 ]---
[47437.383144] BTRFS info (device sda: state A): dumping space info:
[47437.383146] BTRFS info (device sda: state A): space_info DATA has 3075251683328 free, is not full
[47437.383148] BTRFS info (device sda: state A): space_info total=28382127390720, used=25064631922688, pinned=0, reserved=0, may_use=0, readonly=242243784704 zone_unusable=0
[47437.383151] BTRFS info (device sda: state A): space_info METADATA has 3441164288 free, is full
[47437.383152] BTRFS info (device sda: state A): space_info total=32212254720, used=28214706176, pinned=17399808, reserved=1523712, may_use=537133056, readonly=327680 zone_unusable=0
[47437.383155] BTRFS info (device sda: state A): space_info SYSTEM has 39403520 free, is not full
[47437.383156] BTRFS info (device sda: state A): space_info total=41943040, used=2539520, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
[47437.383159] BTRFS info (device sda: state A): global_block_rsv: size 536870912 reserved 536854528
[47437.383160] BTRFS info (device sda: state A): trans_block_rsv: size 0 reserved 0
[47437.383161] BTRFS info (device sda: state A): chunk_block_rsv: size 0 reserved 0
[47437.383163] BTRFS info (device sda: state A): delayed_block_rsv: size 0 reserved 0
[47437.383164] BTRFS info (device sda: state A): delayed_refs_rsv: size 109051904 reserved 16384
[47437.383165] BTRFS: error (device sda: state A) in __btrfs_free_extent:3077: errno=-28 No space left
[47437.383172] BTRFS info (device sda: state EA): forced readonly
[47437.383173] BTRFS error (device sda: state EA): failed to run delayed ref for logical 30236454715392 num_bytes 16384 type 176 action 2 ref_mod 1: -28
[47437.383176] BTRFS: error (device sda: state EA) in btrfs_run_delayed_refs:2151: errno=-28 No space left
[47437.383181] BTRFS warning (device sda: state EA): Skipping commit of aborted transaction.
[47437.383182] BTRFS: error (device sda: state EA) in cleanup_transaction:1984: errno=-28 No space left
[47437.385536] BTRFS info (device sda: state EA): balance: ended with status: -30
[47966.557827] BTRFS info (device sda): using crc32c (crc32c-intel) checksum algorithm
[47966.557838] BTRFS info (device sda): use zstd compression, level 15
[47966.557841] BTRFS info (device sda): turning on async discard
[47966.557844] BTRFS info (device sda): using free space tree

```

On 6/29/23 11:03, Norbert Morawski wrote:
> Hello People,
> this is my first mail to a mailing list, so please give me constructive feedback.
> I am also not a native English speaker, so please excuse my mistakes.
>
> I have started a BTRFS profile conversion from array to "RAID6 for Data and RAID1C3 for Metadata".
>
> Steps I did:
>
> 1. Created an BTRFS Array 6 x 8TB "This happened sequentially since I had to move the Data from a LVM"
> 2. Filled the Storage to 24TB out of 44TB
> 3. Proceeded with the RAID6 conversion -> "btrfs balance start -dconvert=raid6 -mconvert=raid1c3 /mnt/Data --background"
> 4. About 40% into the balance, the METADATA is full and does not extend.
> 5. BTRFS goes into forced Read-only mode.
> 6. Mounted with "skip_balance"
> 7. Added disk "/dev/nvme1n1" into the Array.
> 8. Started "btrfs scrub"
> 9. Resumed BTFS Balance -> Metadata extended once from 16GB to 17GB at 99.7% usage. -> Second Extend does not happen.
> 10. BTRFS goes into forced Read-only mode.
>
> This is the Kernel-log:
> '''
> [114905.372197] BTRFS: error (device sda: state A) in find_free_extent_update_loop:4129: errno=-22 unknown
> [114905.372205] BTRFS info (device sda: state EA): forced readonly
> [114905.372211] BTRFS: error (device sda: state EA) in reset_balance_state:3595: errno=-22 unknown
> [114905.372221] BTRFS info (device sda: state EA): balance: canceled
> '''
>
> After some troubleshooting, I mounted the FS with the option "skip_balance".
> This pauses the balance process and allowed me to remove the least important files and also start the "btrfs scrub" process.
>
> After that and another balance attempt, I managed to get more Kernel Info, and it appears that the Metadata does not want to extend.
> '''
> [133728.876517] BTRFS info (device sda: state A): dumping space info:
> [133728.876520] BTRFS info (device sda: state A): space_info DATA has 5050423623680 free, is not full
> [133728.876522] BTRFS info (device sda: state A): space_info total=30382508408832, used=25064527589376, pinned=0, reserved=0, may_use=0, readonly=267557195776 zone_unusable=0
> [133728.876526] BTRFS info (device sda: state A): space_info METADATA has 3459383296 free, is full
> [133728.876528] BTRFS info (device sda: state A): space_info total=32212254720, used=28193619968, pinned=21725184, reserved=32768, may_use=537165824, readonly=327680 zone_unusable=0
> [133728.876532] BTRFS info (device sda: state A): space_info SYSTEM has 39206912 free, is not full
> [133728.876534] BTRFS info (device sda: state A): space_info total=41943040, used=2736128, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
> [133728.876537] BTRFS info (device sda: state A): global_block_rsv: size 536870912 reserved 536854528
> [133728.876539] BTRFS info (device sda: state A): trans_block_rsv: size 0 reserved 0
> [133728.876540] BTRFS info (device sda: state A): chunk_block_rsv: size 0 reserved 0
> [133728.876541] BTRFS info (device sda: state A): delayed_block_rsv: size 0 reserved 0
> [133728.876542] BTRFS info (device sda: state A): delayed_refs_rsv: size 16777216 reserved 16384
> [133728.876544] BTRFS: error (device sda: state A) in __btrfs_free_extent:3077: errno=-28 No space left
> [133728.876550] BTRFS info (device sda: state EA): forced readonly
> [133728.876552] BTRFS error (device sda: state EA): failed to run delayed ref for logical 54198081880064 num_bytes 16384 type 176 action 2 ref_mod 1: -28
> [133728.876555] BTRFS: error (device sda: state EA) in btrfs_run_delayed_refs:2151: errno=-28 No space left
> [133728.876560] BTRFS warning (device sda: state EA): Skipping commit of aborted transaction.
> [133728.876561] BTRFS: error (device sda: state EA) in cleanup_transaction:1984: errno=-28 No space left
> [133728.879119] BTRFS info (device sda: state EA): balance: ended with status: -30
> '''
> *Canceling the balance is not possible, FS goes into forced read-only mode.*
>
> ## Information
> OS: Proxmox 8.0
> Kernel: 6.2.16-3-pve
> Btrfs: btrfs-progs v6.2
>
> btrfs fi show:
> '''
> Label: 'Backup'  uuid: 450ead52-9143-45d7-9326-4cba501700ed
>         Total devices 1 FS bytes used 313.18GiB
>         devid    1 size 465.76GiB used 341.03GiB path /dev/sdh
>
> Label: 'Data'  uuid: c2c74dd4-a471-4ac5-9321-597fb39ba992
>         Total devices 7 FS bytes used 22.82TiB
>         devid    1 size 7.28TiB used 5.16TiB path /dev/sda
>         devid    2 size 7.28TiB used 5.47TiB path /dev/sdb
>         devid    3 size 7.28TiB used 6.48TiB path /dev/sde
>         devid    4 size 7.28TiB used 6.49TiB path /dev/sdd
>         devid    5 size 7.28TiB used 6.49TiB path /dev/sdc
>         devid    6 size 7.28TiB used 6.49TiB path /dev/sdf
>         devid    7 size 953.87GiB used 110.00GiB path /dev/nvme1n1
> '''
> btrfs fi df /mnt/Data
>
> '''
>
> Data, single: total=8.65TiB, used=8.40TiB
> Data, RAID6: total=15.02TiB, used=14.39TiB
> System, DUP: total=8.00MiB, used=896.00KiB
> System, RAID1C3: total=32.00MiB, used=1.48MiB
> Metadata, DUP: total=13.00GiB, used=9.28GiB
> Metadata, RAID1C3: total=17.00GiB, used=16.98GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'
> WARNING:    Data: single, raid6
> WARNING:    Metadata: dup, raid1c3
> WARNING:    System: dup, raid1c3
>
> '''
>
> I hope this helps further improving BTRFS, and maybe we even find a solution for me.
>
> Best Regards
> Norbert Morawski
>
