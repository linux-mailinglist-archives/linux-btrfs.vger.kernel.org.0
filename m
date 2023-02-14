Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2D2696283
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 12:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjBNLfZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 06:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBNLfY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 06:35:24 -0500
Received: from out28-69.mail.aliyun.com (out28-69.mail.aliyun.com [115.124.28.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B7A22A35
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 03:35:21 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04446501|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.011069-0.000208504-0.988723;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.RLw1o0J_1676374518;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.RLw1o0J_1676374518)
          by smtp.aliyun-inc.com;
          Tue, 14 Feb 2023 19:35:19 +0800
Date:   Tue, 14 Feb 2023 19:35:18 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: a problem of 'clear_cache,space_cache=v2' when block-group-tree is enabled
Message-Id: <20230214193518.E569.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a problem of 'clear_cache,space_cache=v2' when block-group-tree is enabled.

reproducer:
# mkfs.btrfs -R quota,block-group-tree /dev/nvme0n1p1 -f
# mount /dev/nvme0n1p1  /mnt/test/  #OK
# umount /mnt/test
# dmesg -C
# mount -o clear_cache,space_cache=v2 /dev/nvme0n1p1 /mnt/test/  #failed

'mount -o clear_cache,space_cache=v2' failed with the dmesg output.

Should we check block-group-tree feature status before 'clearing free space tree'?

[  661.709894] BTRFS: device fsid f89d03fb-860c-4822-acc0-b18b7dbabd98 devid 1 transid 11 /dev/nvme0n1p1 scanned by mount (2113)
[  661.721643] BTRFS info (device nvme0n1p1): using crc32c (crc32c-intel) checksum algorithm
[  661.729981] BTRFS info (device nvme0n1p1): force clearing of disk cache
[  661.736726] BTRFS info (device nvme0n1p1): using free space tree
[  661.750885] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[  661.757672] BTRFS info (device nvme0n1p1): clearing free space tree
[  661.764076] BTRFS info (device nvme0n1p1): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
[  661.773288] BTRFS info (device nvme0n1p1): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
[  661.783397] BTRFS error (device nvme0n1p1): block-group-tree feature requires fres-space-tree and no-holes
[  661.793128] BTRFS error (device nvme0n1p1): super block corruption detected before writing it to disk
[  661.802418] BTRFS: error (device nvme0n1p1) in write_all_supers:4454: errno=-117 Filesystem corrupted (unexpected superblock corruption detected)
[  661.815482] BTRFS warning (device nvme0n1p1: state E): Skipping commit of aborted transaction.
[  661.824170] ------------[ cut here ]------------
[  661.828906] BTRFS: Transaction aborted (error -117)
[  661.833942] WARNING: CPU: 2 PID: 2113 at fs/btrfs/transaction.c:1984 btrfs_commit_transaction.cold.41+0xd4/0x330 [btrfs]
[  661.844908] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs lockd grace fscache netfs rfkill ib_core dm_multipath intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp nouveau snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi kvm_intel ledtrig_audio btrfs snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec mxm_wmi video kvm snd_hda_core snd_hwdep mei_wdt snd_seq drm_display_helper snd_seq_device blake2b_generic xor irqbypass cec snd_pcm raid6_pq dcdbas mei_me iTCO_wdt iTCO_vendor_support rapl drm_ttm_helper dell_smm_hwmon zstd_compress intel_cstate snd_timer i2c_i801 dm_mod pcspkr i2c_smbus snd intel_uncore soundcore ttm mei lpc_ich ses enclosure auth_rpcgss fuse sunrpc xfs sd_mod sg nvme ahci crct10dif_pclmul crc32_pclmul crc32c_intel nvme_core libahci ata_generic ghash_clmulni_intel nvme_common libata e1000e smartpqi scsi_transport_sas t10_pi wmi i2c_dev
[  661.928933] CPU: 2 PID: 2113 Comm: mount Tainted: G        W          6.1.12-0.1.el7.x86_64 #1
[  661.937644] Hardware name: Dell Inc. Precision T3610/09M8Y8, BIOS A19 09/11/2019
[  661.945152] RIP: 0010:btrfs_commit_transaction.cold.41+0xd4/0x330 [btrfs]
[  661.952107] Code: f0 48 0f ba ad 20 0a 00 00 03 72 60 44 89 ff e8 fc a7 ff ff 41 89 c5 84 c0 74 56 44 89 fe 48 c7 c7 98 d2 e5 c0 e8 f5 fd b0 d8 <0f> 0b 44 89 f9 45 0f b6 c5 ba c0 07 00 00 4c 89 e7 48 c7 c6 f0 b8
[  661.971525] RSP: 0018:ffffaf8c0358fa80 EFLAGS: 00010282
[  661.976895] RAX: 0000000000000000 RBX: ffff8e67b5272600 RCX: 0000000000000000
[  661.984150] RDX: ffff8e6ecf92c300 RSI: ffff8e6ecf91f860 RDI: ffff8e6ecf91f860
[  661.991405] RBP: ffff8e678ade9000 R08: 0000000000000000 R09: c0000000fffdffff
[  661.998684] R10: 0000000000000001 R11: ffffaf8c0358f918 R12: ffff8e67abfa09c0
[  662.005962] R13: 0000000000000001 R14: ffff8e67abfa0900 R15: 00000000ffffff8b
[  662.013224] FS:  00007efec3c4f540(0000) GS:ffff8e6ecf900000(0000) knlGS:0000000000000000
[  662.021446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  662.027342] CR2: 000055bbc7de5398 CR3: 000000011e45c005 CR4: 00000000001706e0
[  662.034622] Call Trace:
[  662.037273]  <TASK>
[  662.039568]  ? release_extent_buffer+0x4c/0xb0 [btrfs]
[  662.044945]  btrfs_clear_free_space_tree+0x234/0x250 [btrfs]
[  662.050829]  btrfs_start_pre_rw_mount.cold.83+0x7e/0xfd [btrfs]
[  662.056974]  open_ctree+0x12eb/0x1548 [btrfs]
[  662.061577]  btrfs_mount_root.cold.76+0x13/0x136 [btrfs]
[  662.067123]  ? legacy_parse_param+0x26/0x220
[  662.071584]  ? vfs_parse_fs_string+0x5b/0xb0
[  662.076060]  legacy_get_tree+0x24/0x50
[  662.079987]  vfs_get_tree+0x22/0xc0
[  662.083660]  fc_mount+0xe/0x40
[  662.086936]  vfs_kern_mount.part.44+0x5c/0x90
[  662.091461]  btrfs_mount+0x128/0x3c0 [btrfs]
[  662.095936]  ? vfs_parse_fs_param_source+0xa0/0xa0
[  662.100875]  ? legacy_parse_param+0x26/0x220
[  662.105302]  legacy_get_tree+0x24/0x50
[  662.109211]  vfs_get_tree+0x22/0xc0
[  662.112858]  path_mount+0x696/0x9b0
[  662.116507]  do_mount+0x79/0x90
[  662.119813]  __x64_sys_mount+0xd0/0xf0
[  662.123709]  do_syscall_64+0x58/0x80
[  662.127460]  ? syscall_exit_to_user_mode+0x12/0x30
[  662.132392]  ? do_syscall_64+0x67/0x80
[  662.136285]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  662.141466] RIP: 0033:0x7efec3a3f7be
[  662.145189] Code: 48 8b 0d 65 a6 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 32 a6 1b 00 f7 d8 64 89 01 48
[  662.164638] RSP: 002b:00007ffd2892e258 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  662.172343] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efec3a3f7be
[  662.179589] RDX: 000055bbc7ddbc20 RSI: 000055bbc7dd74a0 RDI: 000055bbc7dd5670
[  662.186862] RBP: 000055bbc7dd53b0 R08: 000055bbc7dd5610 R09: 0000000000000000
[  662.194127] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  662.201397] R13: 000055bbc7ddbc20 R14: 000055bbc7dd5670 R15: 000055bbc7dd53b0
[  662.208672]  </TASK>
[  662.211063] ---[ end trace 0000000000000000 ]---
[  662.215836] BTRFS: error (device nvme0n1p1: state EA) in cleanup_transaction:1984: errno=-117 Filesystem corrupted
[  662.226329] BTRFS warning (device nvme0n1p1: state EA): failed to clear free space tree: -117
[  662.235036] BTRFS error (device nvme0n1p1: state EA): commit super ret -30
[  662.242615] BTRFS error (device nvme0n1p1: state EA): open_ctree failed


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/02/14


