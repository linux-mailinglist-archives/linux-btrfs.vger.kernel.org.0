Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F98156D09
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 00:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgBIXO7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Feb 2020 18:14:59 -0500
Received: from mx1.riseup.net ([198.252.153.129]:37280 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgBIXO6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 Feb 2020 18:14:58 -0500
Received: from capuchin.riseup.net (unknown [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48G4cy2BcxzDrjm
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Feb 2020 15:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1581290098; bh=9TYR7iKXx1AcY+MPCW4RPYk/yRQVVlA3wa/RsInePs0=;
        h=To:From:Subject:Date:From;
        b=nNLIgUVsC2fQBfMJvCz8kvozvSHId3lTfNO/vcwEHjvadLeO09ctx5txmXPXougH+
         w/lRYandTx7uJ9v4927co1NylyJJDTK0HoI+qva0kYfTHMEAYN5N+pp/5J/POrU5+l
         W2/JnB7etWjVv8y20s+5wD2JgHMuzDM2ONQ95Seo=
X-Riseup-User-ID: 1B300D555D7E30CB316A3FD5F304685FCF2E3DE1558A4EB5A61BB975C456EB0E
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 48G4cx2yHvz8tGv
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Feb 2020 15:14:57 -0800 (PST)
To:     linux-btrfs@vger.kernel.org
From:   =?UTF-8?B?S2FpIEzDvGtl?= <kailueke@riseup.net>
Subject: Bug 206477 - kernel NULL pointer dereference when replaying log after
 mounting
Autocrypt: addr=kailueke@riseup.net; prefer-encrypt=mutual; keydata=
 mQGiBEg1zjsRBADrKh2BN4A4Tf84/hx+Xu4LuB7D/kHZ+e41kWrxBW7yLfYSi7uwywFrpzGD
 pkX5AFCzZoGsq2KNUXdaEM04euqAtLLkTPgbQkvdE7mZJT45uyi/TWdkfQeNSqFudTs4ntPC
 lnC1knBFNKVEbX+LAo7UBlQAH2hYcGKr+Nl+6QK0VwCguEtPhO2tAzlcVt4ek+dVGZ+R2FEE
 AKqLifsrXA9MkX0J0gQ0Dr5ZZfOnFiKMreP6aU2IxkCH/iQjJ7rzy5kv77pJG9/5+QQy+wmj
 3ZxMELWQW9b7opeYoflJNpUUCvSFe26HCNFTIRXDcth0BAtFCtePGMI+6jBmBt1OdA01AmI9
 +zyKKsTV0WM7CcYZfLXNtkeOJpscBACTHzj1rqiOVPbupwvGiCD6zfSioeaFP45NmPoa/zMx
 9rkUy0xejv+2zP8l2iE9h4aQKi5GQ2kj9/fDReNQ6tBtCWclzKywf4i3ooEEvZKSL9kPGHWi
 wqlZLddV+CQHycUxs+DzHOuu+HNrmgaZqNaRcEYD9GOzgq3BaQY5M5qoqbQnS2FpIEzDvGtl
 IChhbGlhcykgPGthaWx1ZWtlQHJpc2V1cC5uZXQ+iGMEExECACMCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCS4yLYwIZAQAKCRAYX+GgjAuzxKWjAKCcSmACEe82PT5d2673Nmw+vsp+
 cgCgt97VHCvoD2uFWvz03atsWMKOsgy5Ag0ESDXOOxAIAIHtCjczBjEcmca1T1H2/pKnX3cE
 6dQ3rjHzEe+LwhgfvB1OF4U2QhVJsEWUyIfhYqNBFzUs0v/qXIvRpJm848bEvkObN+QkuC1R
 nY0TLOiuhT/uCiSClxyQLP7WTGwWvUXp34vEyaSGYuqY2R2YvbppyuXI+PxOuNjwp5/6I6eQ
 Q1tpdl8ALj3y/jntaCe/WZodUgJQXzxHeSxtQwnVLj/79ZhIuMrW/IVw+Co3ODWhjgzGTaCI
 M7ifB/Ya/ryTvwZsCnogrzz8Ze1fjWXJckAdO2hm9gxUQ1wsc41scUmWr5E9RS8uJrYxvXBy
 tyLxn3cvLYGRcZ4YnKT4IyPtJv8AAwUH/RSBm8lLuE57wyWoDF89tq+2ddYwQR6w74VUVhvh
 H5igExvtEhHdFsIlPpkyPv2KcHzYSmmppDbAxwj6V2xnW0CHqyjlL5WkMgTDqd3uxkVJR+it
 OluF66sdTL87X4PZeDPsR1dxPv5+J+u5Ly66+r7LhsOlirKwg0JaJ6kUg0xFLrwZvjJBU5g3
 t8ObRQERckWg3L2kWSIw0hRkQIDJXUdAU40ufBHfve0oQhqwkxeOKlvKs/FIn345+1Uso5+l
 SbBM2yCm41oRJP4/l8jlNMhJbPFjQ/Zpeox+0JzFR19I5cZEgBR8+9DyzDVk9gfSkLeV4n2M
 zxo3Qavs+6173d6ISQQYEQIACQUCSDXOOwIbDAAKCRAYX+GgjAuzxEeNAJ0betUOuaQHSZ1N
 8Sfa5HCHeoCVlACfSobIewkUfAwbJLNrG3162sm8Pf0=
Message-ID: <0b5eda7b-6129-7a2b-aefa-0cc09fa3167b@riseup.net>
Date:   Mon, 10 Feb 2020 00:14:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I had to use "btrfs rescue zero-log" to be able to use my filesystem
again because the kernel had a NULL pointer dereference during replaying
the log when mounting the filesystem (it had a corruption due to a
forced power off):

[ 8796.810595] Btrfs loaded, crc32c=crc32c-intel
[ 8796.813282] BTRFS: device label root devid 1 transid 2606395 /dev/dm-2
[ 8817.625148] BTRFS info (device dm-2): disk space caching is enabled
[ 8817.625150] BTRFS info (device dm-2): has skinny extents
[ 8817.631571] BTRFS info (device dm-2): bdev
/dev/mapper/luks-xxxx-xxx-xxx-xxx-xxx errs: wr 0, rd 352, flush 0,
corrupt 0, gen 0
[ 8817.814444] BTRFS info (device dm-2): enabling ssd optimizations
[ 8818.553036] BUG: kernel NULL pointer dereference, address:
0000000000000008
[ 8818.553040] #PF: supervisor read access in kernel mode
[ 8818.553041] #PF: error_code(0x0000) - not-present page
[ 8818.553043] PGD 0 P4D 0
[ 8818.553046] Oops: 0000 [#1] SMP PTI
[ 8818.553048] CPU: 3 PID: 7824 Comm: pool-udisksd Tainted: G       
W         5.3.7-301.fc31.x86_64 #1
[ 8818.553050] Hardware name: LENOVO xxx/xxx, BIOS N10ET38W (1.17 )
08/20/2015
[ 8818.553090] RIP: 0010:write_extent_buffer+0xa0/0x160 [btrfs]
[ 8818.553092] Code: 85 c0 74 0f 41 0f b6 14 24 88 11 a8 02 0f 85 c0 00
00 00 49 01 c4 49 83 c5 08 45 31 ff 48 29 c5 0f 84 88 00 00 00 49 8b 4d
00 <48> 8b 51 08 48 8d 42 ff 83 e2 01 48 0f 44 c1 48 8b 00 a8 04 0f 84
[ 8818.553094] RSP: 0018:ffffa91383ed3628 EFLAGS: 00010212
[ 8818.553096] RAX: 000000000000002e RBX: ffff9b98dad7f188 RCX:
0000000000000000
[ 8818.553097] RDX: 000000000000002e RSI: ffff9b9880b9909a RDI:
ffff9b98a59d8000
[ 8818.553098] RBP: 0000000000000008 R08: ffffa91383ed3620 R09:
ffffa91383ed3628
[ 8818.553099] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff9b9880b9909a
[ 8818.553100] R13: ffff9b98dad7f230 R14: 0000000000001000 R15:
0000000000000000
[ 8818.553102] FS:  00007fccce7fc700(0000) GS:ffff9b9985ac0000(0000)
knlGS:0000000000000000
[ 8818.553103] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8818.553104] CR2: 0000000000000008 CR3: 000000023eecc004 CR4:
00000000003606e0
[ 8818.553106] Call Trace:
[ 8818.553136]  __btrfs_commit_inode_delayed_items+0x108/0x7d0 [btrfs]
[ 8818.553161]  ? btrfs_set_token_32+0x70/0x130 [btrfs]
[ 8818.553165]  ? _cond_resched+0x15/0x30
[ 8818.553189]  __btrfs_run_delayed_items+0x8c/0x180 [btrfs]
[ 8818.553216]  add_inode_ref+0x40a/0x1030 [btrfs]
[ 8818.553240]  replay_one_buffer+0x1f9/0x8b0 [btrfs]
[ 8818.553261]  ? mark_extent_buffer_accessed+0x5c/0x70 [btrfs]
[ 8818.553281]  ? btrfs_get_token_64+0x10a/0x130 [btrfs]
[ 8818.553304]  walk_down_log_tree+0x19a/0x380 [btrfs]
[ 8818.553327]  walk_log_tree+0xce/0x1e0 [btrfs]
[ 8818.553351]  btrfs_recover_log_trees+0x226/0x410 [btrfs]
[ 8818.553374]  ? replay_one_extent+0x740/0x740 [btrfs]
[ 8818.553392]  open_ctree+0x1abd/0x1bf0 [btrfs]
[ 8818.553407]  btrfs_mount_root+0x570/0x6a0 [btrfs]
[ 8818.553411]  ? fs_parse+0x4e/0x390
[ 8818.553415]  ? selinux_fs_context_parse_param+0x33/0x80
[ 8818.553418]  legacy_get_tree+0x27/0x40
[ 8818.553421]  vfs_get_tree+0x25/0xd0
[ 8818.553424]  fc_mount+0xe/0x30
[ 8818.553426]  vfs_kern_mount.part.0+0x71/0x90
[ 8818.553441]  btrfs_mount+0x155/0x8b0 [btrfs]
[ 8818.553444]  ? fs_lookup_key.isra.0+0x31/0x50
[ 8818.553446]  ? fs_parse+0x4e/0x390
[ 8818.553448]  ? cred_has_capability+0x7c/0x120
[ 8818.553451]  ? legacy_get_tree+0x27/0x40
[ 8818.553464]  ? btrfs_remount+0x490/0x490 [btrfs]
[ 8818.553466]  legacy_get_tree+0x27/0x40
[ 8818.553468]  vfs_get_tree+0x25/0xd0
[ 8818.553471]  do_mount+0x741/0x9a0
[ 8818.553474]  ? memdup_user+0x45/0x80
[ 8818.553476]  ksys_mount+0x7e/0xc0
[ 8818.553479]  __x64_sys_mount+0x21/0x30
[ 8818.553481]  do_syscall_64+0x5f/0x1a0
[ 8818.553485]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 8818.553487] RIP: 0033:0x7fccdf2c71be
[ 8818.553490] Code: 48 8b 0d cd fc 0b 00 f7 d8 64 89 01 48 83 c8 ff c3
66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9a fc 0b 00 f7 d8 64 89 01 48
[ 8818.553491] RSP: 002b:00007fccce7fb2e8 EFLAGS: 00000246 ORIG_RAX:
00000000000000a5
[ 8818.553493] RAX: ffffffffffffffda RBX: 00007fccdf8ea1e4 RCX:
00007fccdf2c71be
[ 8818.553494] RDX: 00007fccb800e400 RSI: 00007fccb8004c30 RDI:
00007fccb800cce0
[ 8818.553495] RBP: 00007fccb80079c0 R08: 0000000000000000 R09:
00007fccb8000800
[ 8818.553496] R10: 0000000000000006 R11: 0000000000000246 R12:
0000000000000000
[ 8818.553497] R13: 00007fccb800cce0 R14: 00007fccb800e400 R15:
0000000000000000
[ 8818.553499] Modules linked in: btrfs xor zstd_compress raid6_pq xfs
dm_crypt rfcomm nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT
ip6t_REJECT nf_reject_ipv6 ip6t_rpfilter ipt_REJECT nf_reject_ipv4
xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_mangle
ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle
iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c ip_set nfnetlink ebtable_filter ebtables ip6table_filter
ip6_tables iptable_filter cmac bnep rpcrdma ib_isert iscsi_target_mod
ib_iser ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib
rdma_ucm ib_umad iw_cxgb4 rdma_cm iw_cm ib_cm iw_cxgb3 ib_uverbs ib_core
snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common iwlmvm mac80211
x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_realtek coretemp
snd_hda_codec_generic uvcvideo kvm_intel snd_hda_intel rmi_smbus libarc4
videobuf2_vmalloc rmi_core videobuf2_memops snd_hda_codec btusb i915
videobuf2_v4l2 kvm videobuf2_common
[ 8818.553525]  btrtl snd_hda_core iwlwifi btbcm btintel snd_hwdep
videodev irqbypass snd_seq bluetooth mei_hdcp mei_wdt intel_cstate
iTCO_wdt snd_seq_device iTCO_vendor_support intel_uncore snd_pcm mc
rtsx_pci_ms i2c_algo_bit memstick thinkpad_acpi drm_kms_helper cfg80211
intel_rapl_perf ecdh_generic ledtrig_audio ecc snd_timer snd joydev drm
soundcore mei_me rfkill mei intel_pch_thermal i2c_i801 lpc_ich wmi_bmof
ip_tables nls_utf8 isofs squashfs zstd_decompress dm_multipath 8021q
garp mrp stp llc rtsx_pci_sdmmc crct10dif_pclmul crc32_pclmul mmc_core
crc32c_intel e1000e ghash_clmulni_intel serio_raw rtsx_pci wmi video uas
usb_storage sunrpc be2iscsi bnx2i cnic uio cxgb4i cxgb4 cxgb3i cxgb3
mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp
libiscsi scsi_transport_iscsi loop fuse
[ 8818.553555] CR2: 0000000000000008
[ 8818.553557] ---[ end trace 24deae9fc95cefbc ]---
[ 8818.553578] RIP: 0010:write_extent_buffer+0xa0/0x160 [btrfs]
[ 8818.553580] Code: 85 c0 74 0f 41 0f b6 14 24 88 11 a8 02 0f 85 c0 00
00 00 49 01 c4 49 83 c5 08 45 31 ff 48 29 c5 0f 84 88 00 00 00 49 8b 4d
00 <48> 8b 51 08 48 8d 42 ff 83 e2 01 48 0f 44 c1 48 8b 00 a8 04 0f 84
[ 8818.553582] RSP: 0018:ffffa91383ed3628 EFLAGS: 00010212
[ 8818.553585] RAX: 000000000000002e RBX: ffff9b98dad7f188 RCX:
0000000000000000
[ 8818.553586] RDX: 000000000000002e RSI: ffff9b9880b9909a RDI:
ffff9b98a59d8000
[ 8818.553587] RBP: 0000000000000008 R08: ffffa91383ed3620 R09:
ffffa91383ed3628
[ 8818.553588] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff9b9880b9909a
[ 8818.553589] R13: ffff9b98dad7f230 R14: 0000000000001000 R15:
0000000000000000
[ 8818.553591] FS:  00007fccce7fc700(0000) GS:ffff9b9985ac0000(0000)
knlGS:0000000000000000
[ 8818.553592] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8818.553593] CR2: 0000000000000008 CR3: 000000023eecc004 CR4:
00000000003606e0


It is a single device filesystem on a LUKS partition:

btrfs-progs v5.4.1

Label: 'root'  uuid: xxxxx
    Total devices 1 FS bytes used 397.94GiB
    devid    1 size 454.58GiB used 454.58GiB path /dev/mapper/luksroot

Data, single: total=444.57GiB, used=391.03GiB
System, single: total=4.00MiB, used=80.00KiB
Metadata, single: total=10.01GiB, used=6.92GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

Linux 5.4.0-2-amd64 #1 SMP Debian 5.4.8-1 (2020-01-05) x86_64 GNU/Linux


Reported in https://bugzilla.kernel.org/show_bug.cgi?id=206477


