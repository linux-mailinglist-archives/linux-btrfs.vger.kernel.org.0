Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E55F6EC057
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Apr 2023 16:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjDWOWY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Apr 2023 10:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjDWOWX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Apr 2023 10:22:23 -0400
Received: from out28-68.mail.aliyun.com (out28-68.mail.aliyun.com [115.124.28.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8BD212B
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Apr 2023 07:22:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436477|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0104697-0.000360135-0.98917;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.SOGMFG0_1682259732;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.SOGMFG0_1682259732)
          by smtp.aliyun-inc.com;
          Sun, 23 Apr 2023 22:22:13 +0800
Date:   Sun, 23 Apr 2023 22:22:14 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: fstests(generic/251) triggered a warn(bad key order, sibling blocks)
Message-Id: <20230423222213.5391.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

fstests(generic/251) triggered a warn(bad key order, sibling blocks).

reproduce frequency: 
	less than 1/40 on one server (with ECC memory)
	yet not happen on another server( with ECC memory).

kernel/btrfs version:
	kernel 6.1.25 with  btrfs 6.2+ some patch of btrfs-6.3 & misc-next

dmesg output:
[95208.397520] run fstests generic/251 at 2023-04-23 11:38:26
[95208.626388] BTRFS: device fsid 5cd6f309-8a61-4203-88f9-bc58e80daf9a devid 1 transid 19610 /dev/sdb1 scanned by mount (1243199)
[95208.638229] BTRFS info (device sdb1): using crc32c (crc32c-intel) checksum algorithm
[95208.646037] BTRFS info (device sdb1): using free space tree
[95208.654233] BTRFS info (device sdb1): enabling ssd optimizations
[95209.206352] BTRFS: device fsid f718f145-3e2a-4661-8926-d816cfa932bf devid 1 transid 6 /dev/sdb2 scanned by systemd-udevd (1242250)
[95209.249678] BTRFS info (device sdb2): using crc32c (crc32c-intel) checksum algorithm
[95209.257467] BTRFS info (device sdb2): using free space tree
[95209.264687] BTRFS info (device sdb2): enabling ssd optimizations
[95209.271018] BTRFS info (device sdb2): checking UUID tree
[95307.052841] ------------[ cut here ]------------
[95307.057492] BTRFS: Transaction aborted (error -2)
[95307.062268] WARNING: CPU: 3 PID: 1228225 at fs/btrfs/delayed-inode.c:1158 __btrfs_run_delayed_items.cold.40+0x44/0x6d [btrfs]

        ret = __btrfs_commit_inode_delayed_items(trans, path,
                             curr_node);
        if (ret) {
            btrfs_release_delayed_node(curr_node);
            curr_node = NULL;
L1158:      btrfs_abort_transaction(trans, ret);
            break;
        }

[95307.073711] Modules linked in: overlay dm_zero dm_thin_pool dm_persistent_data dm_bio_prison dm_snapshot dm_bufio dm_dust dm_flakey ext4 mbcache jbd2 loop rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache netfs rpcrdma rdma_cm iw_cm ib_cm ib_core rfkill vfat fat dm_multipath amdgpu iommu_v2 gpu_sched drm_buddy intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_realtek coretemp snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg kvm_intel snd_intel_sdw_acpi btrfs radeon snd_hda_codec kvm snd_hda_core snd_hwdep snd_seq blake2b_generic xor raid6_pq video snd_seq_device irqbypass zstd_compress drm_display_helper snd_pcm rapl dcdbas mei_wdt iTCO_wdt cec dm_mod dell_smm_hwmon intel_cstate iTCO_vendor_support snd_timer drm_ttm_helper intel_uncore snd mei_me pcspkr ttm i2c_i801 mei soundcore i2c_smbus lpc_ich nfsd auth_rpcgss nfs_acl lockd grace fuse sunrpc xfs sd_mod t10_pi sr_mod cdrom sg bnx2x ahci crct10dif_pclmu
 l
[95307.073785]  crc32_pclmul
[95307.108316] BTRFS critical (device sdb2: state A): bad key order, sibling blocks, left last (1542257 12 1542193) right first (1542216 108 0)
[95307.161054]  libahci
[95307.161062] BTRFS: error (device sdb2: state A) in btrfs_finish_ordered_io:3337: errno=-117 Filesystem corrupted
[95307.161069] BTRFS critical (device sdb2: state A): bad key order, sibling blocks, left last (1542257 12 1542193) right first (1542216 108 0)
[95307.161075] BTRFS: error (device sdb2: state A) in btrfs_finish_ordered_io:3337: errno=-117 Filesystem corrupted
[95307.161078] BTRFS info (device sdb2: state EA): forced readonly
[95307.161086] BTRFS critical (device sdb2: state EA): bad key order, sibling blocks, left last (1542257 12 1542193) right first (1542216 108 0)
[95307.161093] BTRFS: error (device sdb2: state EA) in btrfs_finish_ordered_io:3337: errno=-117 Filesystem corrupted
[95307.161095] BTRFS critical (device sdb2: state EA): bad key order, sibling blocks, left last (1542257 12 1542193) right first (1542216 108 0)
[95307.161102] BTRFS: error (device sdb2: state EA) in btrfs_finish_ordered_io:3337: errno=-117 Filesystem corrupted
[95307.161104] BTRFS critical (device sdb2: state EA): bad key order, sibling blocks, left last (1542257 12 1542193) right first (1542216 108 0)
[95307.161112] BTRFS: error (device sdb2: state EA) in btrfs_finish_ordered_io:3337: errno=-117 Filesystem corrupted
[95307.161117] BTRFS critical (device sdb2: state EA): bad key order, sibling blocks, left last (1542257 12 1542193) right first (1542216 108 0)
[95307.161125] BTRFS: error (device sdb2: state EA) in btrfs_finish_ordered_io:3337: errno=-117 Filesystem corrupted
[95307.161140] BTRFS critical (device sdb2: state EA): bad key order, sibling blocks, left last (1542257 12 1542193) right first (1542216 108 0)
[95307.161149] BTRFS: error (device sdb2: state EA) in btrfs_finish_ordered_io:3337: errno=-117 Filesystem corrupted
[95307.163695]  crc32c_intel mpt3sas
[95307.312949] BTRFS warning (device sdb2: state EA): failed to trim 6 block group(s), last error -512
[95307.322543]  libata ghash_clmulni_intel e1000e mdio raid_class scsi_transport_sas wmi i2c_dev [last unloaded: scsi_debug]
[95307.356279] CPU: 3 PID: 1228225 Comm: kworker/u81:0 Not tainted 6.1.25-0.4.el7.x86_64 #1
[95307.364412] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 09/11/2019
[95307.371843] Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
[95307.379366] RIP: 0010:__btrfs_run_delayed_items.cold.40+0x44/0x6d [btrfs]
[95307.386248] Code: 89 f4 e8 9f 79 ff ff e9 ba ce fa ff 44 89 f7 e8 0a 28 ff ff 41 89 c4 84 c0 74 13 44 89 f6 48 c7 c7 08 8f d0 c4 e8 72 03 a1 c6 <0f> 0b eb bb 66 90 41 bc 01 00 00 00 eb b1 48 8b 7b 50 44 89 f2 48
[95307.405098] RSP: 0018:ffffad28a51e7d68 EFLAGS: 00010282
[95307.410346] RAX: 0000000000000000 RBX: ffff9bdbc9f429c0 RCX: 0000000000000000
[95307.417513] RDX: ffff9bfaaf8ec300 RSI: ffff9bfaaf8df860 RDI: ffff9bfaaf8df860
[95307.424680] RBP: ffff9bdcca504a10 R08: 0000000000000000 R09: c0000000ffff598d
[95307.431849] R10: 0000000000343938 R11: ffffad28a51e7bf0 R12: 0000000006fd3001
[95307.439016] R13: ffff9c0010358918 R14: 00000000fffffffe R15: ffff9c00103588c0
[95307.446185] FS:  0000000000000000(0000) GS:ffff9bfaaf8c0000(0000) knlGS:0000000000000000
[95307.454314] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[95307.460086] CR2: 00007f010367a4f4 CR3: 0000002dd6210002 CR4: 00000000001706e0
[95307.467251] Call Trace:
[95307.469714]  <TASK>
[95307.471826]  flush_space+0x418/0x5f0 [btrfs]
[95307.476208]  ? pick_next_task_fair+0xb0/0x410
[95307.480588]  ? put_prev_entity+0x22/0xe0
[95307.484532]  ? btrfs_get_alloc_profile+0xc9/0x1b0 [btrfs]
[95307.490020]  btrfs_async_reclaim_metadata_space+0xfb/0x240 [btrfs]
[95307.496290]  process_one_work+0x1b0/0x390
[95307.500321]  worker_thread+0x3c/0x370
[95307.504000]  ? process_one_work+0x390/0x390
[95307.508204]  kthread+0xe3/0x110
[95307.511361]  ? kthread_complete_and_exit+0x20/0x20
[95307.516180]  ret_from_fork+0x1f/0x30
[95307.519774]  </TASK>
[95307.521974] ---[ end trace 0000000000000000 ]---
[95307.526615] BTRFS: error (device sdb2: state EA) in __btrfs_run_delayed_items:1158: errno=-2 No such entry

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/04/23


