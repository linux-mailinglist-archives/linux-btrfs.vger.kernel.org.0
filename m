Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4ED35784F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 01:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhDGXN6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 19:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhDGXN6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Apr 2021 19:13:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A4CC061760
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Apr 2021 16:13:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h19so751304lfu.9
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Apr 2021 16:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UnKtXe+3+qbL8wJsW64lMnIOVGL8xmnwUmB7xPZxckM=;
        b=fWPFQoro2Obqje2w8jiXh1FgQ0XBIRox3hbXRZjaNQ2Zj0304wq+NaBsTcfo5uCp8D
         Ta0JFxOSFU/n/ihD71rqCHP2Aqz0jhbDm1L9p5qqw4XzpH5kmsJ88MpxU6Mhg2Quuadr
         BZhRJj8W07wVX0qyR4WFtFNEcNJNerHe35bA+q/MBFi8/aN2JwiMVEekxMhKJu5UoxkH
         tpccyS6veiA66L2tEWw44MpcZHIx9HMoNm5iJxtek4MNLhGlpfGuaBNYcFmp6E0ZbT91
         nbZfRH9GFXi9ILV0fnkG90VzkPBM+SitC1bwoaVQg6FTm+8rTJpa4HrZCCaN9a++WKFI
         HLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UnKtXe+3+qbL8wJsW64lMnIOVGL8xmnwUmB7xPZxckM=;
        b=fQovPE0I9y8rBGQ19BYSwyKYU4AWFL4byA5OPzDK1erNSPMiB58QNcecfJJ6anoi64
         04D/uZ46BTYOkz6FghQKiBPLqjQ2lftmoPAzbe2hsVRa7fiJnD58q/vgQ6yaBfd0CFO3
         2E8oU0kb/vnlAMqLhemqCTwXKH0iNn5wd28oCzF1pvS8Lpvvv7N0ZxRnJQYbTTqjXKk9
         Dr6LAVRd38bP55bpY10eZEgFW4bLwO8h5L7YoTMXxI7I/lGMpZJwnkTpVbbJpSeoI3MP
         cVIPSbMwpmxS4VOdo5halAqRDkJ55nlpVvobwjQldyj1uBEyEVeNDFyFKEfvE6qQwmWH
         8uUQ==
X-Gm-Message-State: AOAM533tCP+AZjCW/oUNq9jjg7GRUh/Oa5QWpqXHpC3R7WHtfZmCcOVW
        vubDDiudow7rNLyYF26uDPKjq492vXWEhNMcUciILY2k4qlq
X-Google-Smtp-Source: ABdhPJxwWPlddcKg431MRX5MmQswr2i7NPwmPU17kg6AAc+zQG5MC7paMBBEhOxgIzWQ26Hy9xakDX4OuoWfpwojFuk=
X-Received: by 2002:a05:6512:94d:: with SMTP id u13mr3701759lft.368.1617837226092;
 Wed, 07 Apr 2021 16:13:46 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Martinez <danielsmartinez@gmail.com>
Date:   Wed, 7 Apr 2021 20:13:09 -0300
Message-ID: <CAMmfObadj37E9r4k4jMHACZtWY26Mp6PR6WxzmJB8t-FbgtQpw@mail.gmail.com>
Subject: RAID 1 filesystem hangs on device remove
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I have a RAID 1 (data and metadata) filesystem with 3x 8TB + 1x 2TB. I
cleared about 1.3TB of data and tried to remove the 2TB disk. All data
extents seem to relocate fine, but when it gets to a metadata extent,
it hangs for a while and I get something like "btrfs-transacti:825
blocked for more than 724 seconds." but it seemed to finally move
after all this time.

Eventually, when it tried to move another metadata block group, it
segfaulted and I got this on dmesg:

[49400.614585] BTRFS info (device sdg2): relocating block group
20241137532928 flags metadata|raid1
[49431.919115] ------------[ cut here ]------------
[49431.919125] kernel BUG at fs/btrfs/relocation.c:911!
[49431.919315] invalid opcode: 0000 [#1] SMP NOPTI
[49431.919460] CPU: 2 PID: 20205 Comm: btrfs Not tainted
5.10.0-5-amd64 #1 Debian 5.10.24-1
[49431.919704] Hardware name: Dell Inc. PowerEdge 2900/0NX642, BIOS
2.7.0 10/30/2010
[49431.919986] RIP: 0010:btrfs_update_reloc_root+0x1f8/0x240 [btrfs]
[49431.920166] Code: 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 76 29 48
8b 5b 08 e9 ed fe ff ff f0 80 4b 21 04 4c 89 ff e8 9d d7 ff ff e9 96
fe ff ff <0f> 0b 31 f6 e8 1f 7c 26 f8 e9 69 fe ff ff 48 8d b2 98 05 00
00 48
[49431.920708] RSP: 0018:ffffbb7305d5bb50 EFLAGS: 00010286
[49431.920870] RAX: 00000000ffffffe4 RBX: 0000000000000000 RCX: 0000000002845fbd
[49431.921078] RDX: 0000000002845fbc RSI: ffffffffc0987b32 RDI: 0000000000032170
[49431.921285] RBP: ffff9e900412c478 R08: 0000000000000000 R09: 0000000000000000
[49431.921492] R10: 0000000000000001 R11: 0000000000000000 R12: ffff9e90f3d215a0
[49431.921699] R13: ffff9e91790f0028 R14: ffff9e9003f80000 R15: ffff9e91790f0000
[49431.921907] FS:  00007f0d006b69c0(0000) GS:ffff9e932fc80000(0000)
knlGS:0000000000000000
[49431.922151] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[49431.922319] CR2: 00007fd8e1154888 CR3: 00000003072fa000 CR4: 00000000000006e0
[49431.937165] Call Trace:
[49431.951986]  prepare_to_merge+0x1b6/0x280 [btrfs]
[49431.966843]  relocate_block_group+0x2fe/0x630 [btrfs]
[49431.981713]  btrfs_relocate_block_group+0x15c/0x300 [btrfs]
[49431.996694]  btrfs_relocate_chunk+0x27/0xc0 [btrfs]
[49432.011627]  btrfs_shrink_device+0x1fa/0x550 [btrfs]
[49432.026417]  btrfs_rm_device+0x17e/0x570 [btrfs]
[49432.041050]  ? __check_object_size+0x136/0x150
[49432.055539]  ? _copy_from_user+0x28/0x60
[49432.069972]  btrfs_ioctl+0x2c5c/0x3050 [btrfs]
[49432.084335]  ? __x64_sys_ioctl+0x83/0xb0
[49432.098934]  __x64_sys_ioctl+0x83/0xb0
[49432.113334]  do_syscall_64+0x33/0x80
[49432.127671]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[49432.141881] RIP: 0033:0x7f0d00879cc7
[49432.155740] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89
01 48
[49432.185764] RSP: 002b:00007fff13d41728 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[49432.200814] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0d00879cc7
[49432.215813] RDX: 00007fff13d42748 RSI: 000000005000943a RDI: 0000000000000003
[49432.230570] RBP: 00007fff13d438d8 R08: 00007fff13d42780 R09: 000000000000000f
[49432.245240] R10: fffffffffffff284 R11: 0000000000000246 R12: 0000000000000003
[49432.259831] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000003
[49432.274377] Modules linked in: ipt_REJECT nf_reject_ipv4
xt_multiport veth xt_nat xt_tcpudp nf_conntrack_netlink xfrm_user
xfrm_algo xt_addrtype br_netfilter wireguard tun libchacha20poly1305
chacha_x86_64 poly1305_x86_64 ip6_udp_tunnel udp_tunnel libblake2s
blake2s_x86_64 curve25519_x86_64 libcurve25519_generic libchacha
libblake2s_generic cfg80211 nft_chain_nat xt_MASQUERADE nf_nat bridge
xt_state nft_counter xt_conntrack nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 8021q garp stp mrp llc nft_compat nf_tables nfnetlink
rfkill overlay ipmi_ssif coretemp xxhash_generic kvm_intel iTCO_wdt
intel_pmc_bxt iTCO_vendor_support watchdog dcdbas kvm irqbypass
ipmi_si pcspkr ipmi_devintf i5000_edac serio_raw rng_core i5k_amb sg
ipmi_msghandler evdev squashfs loop nfsd auth_rpcgss parport_pc
nfs_acl lockd ppdev grace lp parport fuse sunrpc configfs ip_tables
x_tables autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic raid10
raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
[49432.274467]  raid6_pq libcrc32c crc32c_generic raid1 raid0
multipath linear md_mod hid_logitech_hidpp hid_logitech_dj hid_generic
usbhid hid sd_mod t10_pi crc_t10dif crct10dif_generic ses enclosure
crct10dif_common ata_generic radeon i2c_algo_bit ttm drm_kms_helper
ehci_pci cec uhci_hcd mpt3sas ata_piix megaraid_sas ehci_hcd drm
libata bnx2 usbcore raid_class scsi_transport_sas psmouse scsi_mod
lpc_ich usb_common button
[49432.406812] ---[ end trace c440d288d26eba37 ]---
[49432.425118] RIP: 0010:btrfs_update_reloc_root+0x1f8/0x240 [btrfs]
[49432.443036] Code: 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 76 29 48
8b 5b 08 e9 ed fe ff ff f0 80 4b 21 04 4c 89 ff e8 9d d7 ff ff e9 96
fe ff ff <0f> 0b 31 f6 e8 1f 7c 26 f8 e9 69 fe ff ff 48 8d b2 98 05 00
00 48
[49432.480750] RSP: 0018:ffffbb7305d5bb50 EFLAGS: 00010286
[49432.499764] RAX: 00000000ffffffe4 RBX: 0000000000000000 RCX: 0000000002845fbd
[49432.518626] RDX: 0000000002845fbc RSI: ffffffffc0987b32 RDI: 0000000000032170
[49432.537504] RBP: ffff9e900412c478 R08: 0000000000000000 R09: 0000000000000000
[49432.556338] R10: 0000000000000001 R11: 0000000000000000 R12: ffff9e90f3d215a0
[49432.575084] R13: ffff9e91790f0028 R14: ffff9e9003f80000 R15: ffff9e91790f0000
[49432.593766] FS:  00007f0d006b69c0(0000) GS:ffff9e932fc80000(0000)
knlGS:0000000000000000
[49432.612447] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[49432.631028] CR2: 00007fd8e1154888 CR3: 00000003072fa000 CR4: 00000000000006e0
[49433.584749] ------------[ cut here ]------------
[49433.603242] BTRFS: Transaction aborted (error -28)
[49433.621799] WARNING: CPU: 0 PID: 825 at fs/btrfs/extent-tree.c:2144
btrfs_run_delayed_refs+0x1aa/0x200 [btrfs]
[49433.640407] Modules linked in: ipt_REJECT nf_reject_ipv4
xt_multiport veth xt_nat xt_tcpudp nf_conntrack_netlink xfrm_user
xfrm_algo xt_addrtype br_netfilter wireguard tun libchacha20poly1305
chacha_x86_64 poly1305_x86_64 ip6_udp_tunnel udp_tunnel libblake2s
blake2s_x86_64 curve25519_x86_64 libcurve25519_generic libchacha
libblake2s_generic cfg80211 nft_chain_nat xt_MASQUERADE nf_nat bridge
xt_state nft_counter xt_conntrack nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 8021q garp stp mrp llc nft_compat nf_tables nfnetlink
rfkill overlay ipmi_ssif coretemp xxhash_generic kvm_intel iTCO_wdt
intel_pmc_bxt iTCO_vendor_support watchdog dcdbas kvm irqbypass
ipmi_si pcspkr ipmi_devintf i5000_edac serio_raw rng_core i5k_amb sg
ipmi_msghandler evdev squashfs loop nfsd auth_rpcgss parport_pc
nfs_acl lockd ppdev grace lp parport fuse sunrpc configfs ip_tables
x_tables autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic raid10
raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
[49433.640489]  raid6_pq libcrc32c crc32c_generic raid1 raid0
multipath linear md_mod hid_logitech_hidpp hid_logitech_dj hid_generic
usbhid hid sd_mod t10_pi crc_t10dif crct10dif_generic ses enclosure
crct10dif_common ata_generic radeon i2c_algo_bit ttm drm_kms_helper
ehci_pci cec uhci_hcd mpt3sas ata_piix megaraid_sas ehci_hcd drm
libata bnx2 usbcore raid_class scsi_transport_sas psmouse scsi_mod
lpc_ich usb_common button
[49433.802693] CPU: 0 PID: 825 Comm: btrfs-transacti Tainted: G      D
          5.10.0-5-amd64 #1 Debian 5.10.24-1
[49433.823456] Hardware name: Dell Inc. PowerEdge 2900/0NX642, BIOS
2.7.0 10/30/2010
[49433.844301] RIP: 0010:btrfs_run_delayed_refs+0x1aa/0x200 [btrfs]
[49433.865250] Code: 54 24 50 f0 48 0f ba aa 40 0a 00 00 02 72 20 83
f8 fb 74 3c 83 f8 e2 74 37 89 c6 48 c7 c7 68 6b a4 c0 89 04 24 e8 9a
36 6f f8 <0f> 0b 8b 04 24 89 c1 ba 60 08 00 00 4c 89 e7 89 04 24 48 c7
c6 c0
[49433.908626] RSP: 0018:ffffbb730032be08 EFLAGS: 00010286
[49433.930589] RAX: 0000000000000000 RBX: 00000000003f83d0 RCX: 0000000000000000
[49433.952571] RDX: ffff9e932fc28760 RSI: ffff9e932fc18a00 RDI: ffff9e932fc18a00
[49433.974526] RBP: ffff9e91c56a8978 R08: 0000000000000000 R09: ffffbb730032bc28
[49433.996419] R10: ffffbb730032bc20 R11: ffffffffb9ebb288 R12: ffff9e9198575e38
[49434.018275] R13: ffff9e9003f80340 R14: ffff9e902228e000 R15: 0000000000097577
[49434.040203] FS:  0000000000000000(0000) GS:ffff9e932fc00000(0000)
knlGS:0000000000000000
[49434.062266] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[49434.084319] CR2: 000055715ff9b000 CR3: 0000000137aba000 CR4: 00000000000006f0
[49434.106496] Call Trace:
[49434.128709]  btrfs_commit_transaction+0x57/0xb40 [btrfs]
[49434.150993]  ? start_transaction+0xd2/0x580 [btrfs]
[49434.173286]  ? schedule_timeout+0x80/0x140
[49434.195613]  transaction_kthread+0x14c/0x170 [btrfs]
[49434.217969]  ? btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
[49434.240393]  kthread+0x11b/0x140
[49434.263049]  ? __kthread_bind_mask+0x60/0x60
[49434.285953]  ret_from_fork+0x1f/0x30
[49434.308780] ---[ end trace c440d288d26eba38 ]---
[49434.331549] BTRFS: error (device sdg2) in
btrfs_run_delayed_refs:2144: errno=-28 No space left
[49434.353973] BTRFS info (device sdg2): forced readonly


After that, btrfs check is showing some errors and space cache problems:

# btrfs check --readonly --force /dev/sdg2
Opening filesystem to check...
WARNING: filesystem mounted, continuing because of --force
Checking filesystem on /dev/sdg2
UUID: 9b09b4a0-0651-470c-960a-ae5d08fd4989
[1/7] checking root items
[2/7] checking extents
checksum verify failed on 22607496871936 found 00000064 wanted 00000024
checksum verify failed on 22607497494528 found 00000064 wanted 00000024
checksum verify failed on 22607498772480 found 00000064 wanted 00000024
[3/7] checking free space tree
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
  checksum verify failed on 22607496871936 found 00000064 wanted 00000024
checksum verify failed on 22607497494528 found 00000064 wanted 00000024
checksum verify failed on 22607498772480 found 00000064 wanted 00000024
[5/7] checking only csums items (without verifying data)
checksum verify failed on 22607496871936 found 00000064 wanted 00000024
checksum verify failed on 22607497494528 found 00000064 wanted 00000024
checksum verify failed on 22607498772480 found 00000064 wanted 00000024
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 11633705783296 bytes used, no error found
total csum bytes: 11096202872
total tree bytes: 20408123392
total fs tree bytes: 7229865984
total extent tree bytes: 1068351488
btree space waste bytes: 2394320610
file data blocks allocated: 24082831237120
 referenced 12169744596992

I've rebooted the system and I'm now running a scrub to try to repair
those issues before trying again, but otherwise the filesystem is back
to being writeable and seems fine.

I'm on the Debian kernel 5.10.24-1, btrfs-progs v5.10.1.

Did that only happen because I ran out of space? Or is there some
underlying problem here? SMART data seems fine for all drives.

This is my output for btrfs fi usage, it looks like it has more than
enough space to remove the drive:
# btrfs fi usage /mnt/btrfs_pool/
Overall:
    Device size:                  23.64TiB
    Device allocated:             21.20TiB
    Device unallocated:            2.44TiB
    Device missing:                  0.00B
    Used:                         21.17TiB
    Free (estimated):              1.24TiB      (min: 1.24TiB)
    Free (statfs, df):             1.18TiB
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,RAID1: Size:10.58TiB, Used:10.56TiB (99.86%)
   /dev/sdg2       6.10TiB
   /dev/sdf2       7.26TiB
   /dev/sda1     540.00GiB
   /dev/sde1       7.26TiB

Metadata,RAID1: Size:20.00GiB, Used:19.00GiB (95.02%)
   /dev/sdg2      13.00GiB
   /dev/sdf2      12.00GiB
   /dev/sda1       2.00GiB
   /dev/sde1      13.00GiB

System,RAID1: Size:32.00MiB, Used:1.91MiB (5.96%)
   /dev/sdg2      32.00MiB
   /dev/sda1      32.00MiB

Unallocated:
   /dev/sdg2       1.16TiB
   /dev/sdf2       1.00MiB
   /dev/sda1       1.28TiB
   /dev/sde1       1.00MiB


Thanks,
Daniel.
