Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD8667913C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jan 2023 07:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjAXGrZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 01:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjAXGrZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 01:47:25 -0500
Received: from out28-83.mail.aliyun.com (out28-83.mail.aliyun.com [115.124.28.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E6E27D55
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 22:47:19 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436362|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0121186-0.000453841-0.987428;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.R.HhAF1_1674542836;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.R.HhAF1_1674542836)
          by smtp.aliyun-inc.com;
          Tue, 24 Jan 2023 14:47:16 +0800
Date:   Tue, 24 Jan 2023 14:47:18 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 0/9] extent buffer dirty cleanups
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
In-Reply-To: <cover.1674164991.git.josef@toxicpanda.com>
References: <cover.1674164991.git.josef@toxicpanda.com>
Message-Id: <20230124144717.371A.409509F4@e16-tech.com>
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

> v1->v2:
> - Added "btrfs: do not call btrfs_clean_tree_block in update_ref_for_cow", Qu
>   noticed some corruption with the original patchset, this turned out to be
>   because we were clearing the extent buffer dirty at cow time, which doesn't
>   make sense as we're not free'ing the current block in our current transaction.

With these 9 patches,  fstest btrfs/001 will fail.
Without these 9 patches,  fstest btrfs/001 passed.

kernel version:  linux kernel 6.1.8-rc2 with btrfs code of 6.2.0.
dmesg of 'fstest btrfs/001'
[  207.961928] run fstests btrfs/001 at 2023-01-24 14:33:30
[  208.153611] BTRFS info (device sdb1): using crc32c (crc32c-intel) checksum algorithm
[  208.161357] BTRFS info (device sdb1): using free space tree
[  208.168863] BTRFS info (device sdb1): enabling ssd optimizations
[  208.712457] BTRFS: device fsid a08f4da5-62be-4516-84d6-4a29b7d1b075 devid 1 transid 6 /dev/sdb2 scanned by systemd-udevd (3737)
[  208.745894] BTRFS info (device sdb2): using crc32c (crc32c-intel) checksum algorithm
[  208.753615] BTRFS info (device sdb2): using free space tree
[  208.760818] BTRFS info (device sdb2): enabling ssd optimizations
[  208.767016] BTRFS info (device sdb2): checking UUID tree
[  208.799067] ------------[ cut here ]------------
[  208.803671] WARNING: CPU: 5 PID: 3771 at fs/btrfs/extent-tree.c:3333 btrfs_free_tree_block+0x2a1/0x2b0 [btrfs]
[  208.813709] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache netfs rpcrdma rdma_cm iw_cm ib_cm rfkill ib_core dm_multipath dm_mod intel_rapl_msr intel_rapl_common sb_edac snd_hda_codec_realtek x86_pkg_temp_thermal snd_hda_codec_generic intel_powerclamp snd_hda_codec_hdmi ledtrig_audio coretemp snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi kvm_intel snd_hda_codec btrfs kvm snd_hda_core snd_hwdep snd_seq irqbypass mei_wdt dcdbas iTCO_wdt crct10dif_pclmul snd_seq_device iTCO_vendor_support crc32_pclmul dell_smm_hwmon blake2b_generic ghash_clmulni_intel xor snd_pcm raid6_pq rapl snd_timer intel_cstate zstd_compress mei_me snd i2c_i801 intel_uncore pcspkr lpc_ich i2c_smbus mei soundcore nfsd auth_rpcgss nfs_acl lockd grace sunrpc xfs sd_mod t10_pi amdgpu iommu_v2 gpu_sched drm_buddy sr_mod cdrom sg radeon ahci libahci video bnx2x drm_ttm_helper mpt3sas ttm libata e1000e drm_display_helper crc32c_intel mdio cec raid_class scsi_transport_sas wmi i2c_dev
[  208.898933] CPU: 5 PID: 3771 Comm: btrfs Not tainted 6.1.8-0.5.el7.x86_64 #1
[  208.905948] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 09/11/2019
[  208.913308] RIP: 0010:btrfs_free_tree_block+0x2a1/0x2b0 [btrfs]
[  208.919243] Code: 01 00 00 00 4c 89 e6 e8 3d a2 ff ff 4c 89 e7 e8 25 b4 0a 00 e9 7d fe ff ff 49 8b 7d 20 48 89 ee e8 d4 cc 0b 00 e9 6c fe ff ff <0f> 0b e9 11 ff ff ff e8 83 2c 51 c1 0f 1f 00 0f 1f 44 00 00 8b 06
[  208.937913] RSP: 0018:ffffb43e63e5f7d8 EFLAGS: 00010202
[  208.943117] RAX: 0000000000000213 RBX: ffff9b9207576000 RCX: ffff9b92a16cd8d8
[  208.950220] RDX: 0000000000000000 RSI: 0000000000540000 RDI: ffff9b9207576088
[  208.957321] RBP: ffff9b9208e7d500 R08: 0000000000000000 R09: 0000000000480000
[  208.964425] R10: 0000000000000000 R11: ffff9b9207576a40 R12: ffff9b92a16cd800
[  208.971525] R13: ffff9b923abaa548 R14: 0000000000000001 R15: ffff9b9208e7cd00
[  208.978627] FS:  00007f390b354a00(0000) GS:ffff9bb0ef940000(0000) knlGS:0000000000000000
[  208.986680] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  208.992398] CR2: 00000000015b59e8 CR3: 0000000108efe006 CR4: 00000000001706e0
[  208.999501] Call Trace:
[  209.001940]  <TASK>
[  209.004037]  __btrfs_cow_block+0x48b/0x510 [btrfs]
[  209.008853]  btrfs_cow_block+0xf2/0x190 [btrfs]
[  209.013426]  btrfs_search_slot+0x6d6/0xbc0 [btrfs]
[  209.018238]  btrfs_insert_empty_items+0x31/0x70 [btrfs]
[  209.023482]  btrfs_insert_delayed_items+0x22f/0x430 [btrfs]
[  209.029097]  __btrfs_run_delayed_items+0x9c/0x190 [btrfs]
[  209.034539]  ? create_pending_snapshots+0x92/0xc0 [btrfs]
[  209.039958]  btrfs_commit_transaction+0x28d/0xba0 [btrfs]
[  209.045379]  ? start_transaction+0xd0/0x5e0 [btrfs]
[  209.050279]  btrfs_mksubvol+0x364/0x570 [btrfs]
[  209.054848]  btrfs_mksnapshot+0x7c/0xb0 [btrfs]
[  209.059442]  __btrfs_ioctl_snap_create+0x17b/0x190 [btrfs]
[  209.064957]  btrfs_ioctl_snap_create_v2+0x11c/0x140 [btrfs]
[  209.070557]  btrfs_ioctl+0x91c/0x26b0 [btrfs]
[  209.074952]  ? __mod_memcg_lruvec_state+0x66/0xd0
[  209.079645]  ? __mod_lruvec_page_state+0x85/0x130
[  209.084333]  ? page_add_new_anon_rmap+0x8c/0x1f0
[  209.088937]  ? folio_add_lru+0x7d/0xe0
[  209.092677]  ? do_anonymous_page+0x283/0x320
[  209.096938]  ? __x64_sys_ioctl+0x89/0xc0
[  209.100853]  __x64_sys_ioctl+0x89/0xc0
[  209.104594]  do_syscall_64+0x58/0x80
[  209.108164]  ? handle_mm_fault+0xfb/0x2f0
[  209.112167]  ? do_user_addr_fault+0x1eb/0x6a0
[  209.116512]  ? exc_page_fault+0x64/0x140
[  209.120426]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  209.125463] RIP: 0033:0x7f39090397cb
[  209.129030] Code: 73 01 c3 48 8b 0d bd 66 38 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8d 66 38 00 f7 d8 64 89 01 48
[  209.147702] RSP: 002b:00007ffd86214868 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  209.155238] RAX: ffffffffffffffda RBX: 00000000015a4920 RCX: 00007f39090397cb
[  209.162342] RDX: 00007ffd862148b0 RSI: 0000000050009417 RDI: 0000000000000003
[  209.169445] RBP: 0000000000000004 R08: 0000000000000000 R09: 00007f3909180d40
[  209.176549] R10: 0000000000000010 R11: 0000000000000202 R12: 00000000015a4940
[  209.183653] R13: 00000000015a4940 R14: 00007ffd862148b0 R15: 0000000000000000
[  209.190758]  </TASK>
[  209.192938] ---[ end trace 0000000000000000 ]---
[  209.197624] ------------[ cut here ]------------
[  209.202230] WARNING: CPU: 25 PID: 3771 at fs/btrfs/extent-tree.c:3333 btrfs_free_tree_block+0x2a1/0x2b0 [btrfs]
[  209.212311] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache netfs rpcrdma rdma_cm iw_cm ib_cm rfkill ib_core dm_multipath dm_mod intel_rapl_msr intel_rapl_common sb_edac snd_hda_codec_realtek x86_pkg_temp_thermal snd_hda_codec_generic intel_powerclamp snd_hda_codec_hdmi ledtrig_audio coretemp snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi kvm_intel snd_hda_codec btrfs kvm snd_hda_core snd_hwdep snd_seq irqbypass mei_wdt dcdbas iTCO_wdt crct10dif_pclmul snd_seq_device iTCO_vendor_support crc32_pclmul dell_smm_hwmon blake2b_generic ghash_clmulni_intel xor snd_pcm raid6_pq rapl snd_timer intel_cstate zstd_compress mei_me snd i2c_i801 intel_uncore pcspkr lpc_ich i2c_smbus mei soundcore nfsd auth_rpcgss nfs_acl lockd grace sunrpc xfs sd_mod t10_pi amdgpu iommu_v2 gpu_sched drm_buddy sr_mod cdrom sg radeon ahci libahci video bnx2x drm_ttm_helper mpt3sas ttm libata e1000e drm_display_helper crc32c_intel mdio cec raid_class scsi_transport_sas wmi i2c_dev
[  209.297508] CPU: 25 PID: 3771 Comm: btrfs Tainted: G        W          6.1.8-0.5.el7.x86_64 #1
[  209.306076] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 09/11/2019
[  209.313433] RIP: 0010:btrfs_free_tree_block+0x2a1/0x2b0 [btrfs]
[  209.319367] Code: 01 00 00 00 4c 89 e6 e8 3d a2 ff ff 4c 89 e7 e8 25 b4 0a 00 e9 7d fe ff ff 49 8b 7d 20 48 89 ee e8 d4 cc 0b 00 e9 6c fe ff ff <0f> 0b e9 11 ff ff ff e8 83 2c 51 c1 0f 1f 00 0f 1f 44 00 00 8b 06
[  209.338034] RSP: 0018:ffffb43e63e5f818 EFLAGS: 00010202
[  209.343233] RAX: 0000000000000213 RBX: ffff9b9207576000 RCX: ffff9b92a16cd8d8
[  209.350332] RDX: 0000000000000000 RSI: 0000000000560000 RDI: ffff9b9207576088
[  209.357431] RBP: ffff9b9208e7cd00 R08: 0000000000000001 R09: 0000000000000000
[  209.364529] R10: 00000000c4ed3201 R11: 0000000000000001 R12: ffff9b92a16cd800
[  209.371628] R13: ffff9b923abaa548 R14: 0000000000000001 R15: ffff9b92a35fd100
[  209.378724] FS:  00007f390b354a00(0000) GS:ffff9bb0efbc0000(0000) knlGS:0000000000000000
[  209.386773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  209.392489] CR2: 000056301d9aaae0 CR3: 0000000108efe006 CR4: 00000000001706e0
[  209.399588] Call Trace:
[  209.402024]  <TASK>
[  209.404116]  __btrfs_cow_block+0x48b/0x510 [btrfs]
[  209.408926]  btrfs_cow_block+0xf2/0x190 [btrfs]
[  209.413476]  btrfs_search_slot+0x6d6/0xbc0 [btrfs]
[  209.418285]  ? btrfs_block_rsv_release+0x194/0x2e0 [btrfs]
[  209.423806]  btrfs_lookup_inode+0x3a/0xc0 [btrfs]
[  209.428535]  __btrfs_update_delayed_inode+0x73/0x260 [btrfs]
[  209.434225]  __btrfs_run_delayed_items+0x10b/0x190 [btrfs]
[  209.439749]  ? create_pending_snapshots+0x92/0xc0 [btrfs]
[  209.445168]  btrfs_commit_transaction+0x28d/0xba0 [btrfs]
[  209.450587]  ? start_transaction+0xd0/0x5e0 [btrfs]
[  209.455486]  btrfs_mksubvol+0x364/0x570 [btrfs]
[  209.460058]  btrfs_mksnapshot+0x7c/0xb0 [btrfs]
[  209.464622]  __btrfs_ioctl_snap_create+0x17b/0x190 [btrfs]
[  209.470145]  btrfs_ioctl_snap_create_v2+0x11c/0x140 [btrfs]
[  209.475754]  btrfs_ioctl+0x91c/0x26b0 [btrfs]
[  209.480157]  ? __mod_memcg_lruvec_state+0x66/0xd0
[  209.484839]  ? __mod_lruvec_page_state+0x85/0x130
[  209.489521]  ? page_add_new_anon_rmap+0x8c/0x1f0
[  209.494121]  ? folio_add_lru+0x7d/0xe0
[  209.497854]  ? do_anonymous_page+0x283/0x320
[  209.502105]  ? __x64_sys_ioctl+0x89/0xc0
[  209.506013]  __x64_sys_ioctl+0x89/0xc0
[  209.509747]  do_syscall_64+0x58/0x80
[  209.513309]  ? handle_mm_fault+0xfb/0x2f0
[  209.517301]  ? do_user_addr_fault+0x1eb/0x6a0
[  209.521641]  ? exc_page_fault+0x64/0x140
[  209.525549]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  209.530577] RIP: 0033:0x7f39090397cb
[  209.534137] Code: 73 01 c3 48 8b 0d bd 66 38 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8d 66 38 00 f7 d8 64 89 01 48
[  209.552806] RSP: 002b:00007ffd86214868 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  209.560337] RAX: ffffffffffffffda RBX: 00000000015a4920 RCX: 00007f39090397cb
[  209.567436] RDX: 00007ffd862148b0 RSI: 0000000050009417 RDI: 0000000000000003
[  209.574537] RBP: 0000000000000004 R08: 0000000000000000 R09: 00007f3909180d40
[  209.581634] R10: 0000000000000010 R11: 0000000000000202 R12: 00000000015a4940
[  209.588731] R13: 00000000015a4940 R14: 00007ffd862148b0 R15: 0000000000000000
[  209.595830]  </TASK>
[  209.598009] ---[ end trace 0000000000000000 ]---
[  209.627004] BTRFS info (device sdb2): setting incompat feature flag for DEFAULT_SUBVOL (0x2)
[  209.646478] BTRFS info (device sdb2): using crc32c (crc32c-intel) checksum algorithm
[  209.654195] BTRFS info (device sdb2): using free space tree
[  209.661661] BTRFS info (device sdb2): enabling ssd optimizations
[  209.676674] BTRFS info (device sdb2): using crc32c (crc32c-intel) checksum algorithm
[  209.684389] BTRFS info (device sdb2): using free space tree
[  209.691756] BTRFS info (device sdb2): enabling ssd optimizations
[  209.709825] BTRFS info (device sdb2): using crc32c (crc32c-intel) checksum algorithm
[  209.717539] BTRFS info (device sdb2): using free space tree
[  209.724810] BTRFS info (device sdb2): enabling ssd optimizations
[  209.748422] BTRFS info (device sdb2): using crc32c (crc32c-intel) checksum algorithm
[  209.756155] BTRFS info (device sdb2): using free space tree
[  209.763554] BTRFS info (device sdb2): enabling ssd optimizations
[  209.814801] BTRFS info (device sdb2): using crc32c (crc32c-intel) checksum algorithm
[  209.822530] BTRFS info (device sdb2): using free space tree
[  209.830248] BTRFS info (device sdb2): enabling ssd optimizations



Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/01/24

> 
> --- Original email ---
> Hello,
> 
> While sync'ing ctree.c to btrfs-progs I noticed we have some oddities when it
> comes to how we deal with the extent buffer being dirty.  We have
> btrfs_clean_tree_block, which is sort of meant to be run against extent buffers
> we've modified in this transaction.  However we have some other places where
> we've open coded the same work without the generation check.  This makes it kind
> of confusing, and is inconsistent with how we deal with the
> fs_info->dirty_metadata_bytes.
> 
> So clean this stuff up so we have one helper we use for setting the extent
> buffer dirty (btrfs_mark_buffer_dirty) and one for clearing dirty
> (btrfs_clear_buffer_dirty).  This makes everything more consistent and clean
> across the board.  I've additionally cleaned up a random writeback thing we had
> in tree-log that I noticed while doing these cleanups.  Thanks,
> 
> Josef
> 
> Josef Bacik (9):
>   btrfs: do not call btrfs_clean_tree_block in update_ref_for_cow
>   btrfs: always lock the block before calling btrfs_clean_tree_block
>   btrfs: do not check header generation in btrfs_clean_tree_block
>   btrfs: do not set the header generation before btrfs_clean_tree_block
>   btrfs: replace clearing extent buffer dirty bit with btrfs_clean_block
>   btrfs: do not increment dirty_metadata_bytes in set_btree_ioerr
>   btrfs: rename btrfs_clean_tree_block => btrfs_clear_buffer_dirty
>   btrfs: combine btrfs_clear_buffer_dirty and clear_extent_buffer_dirty
>   btrfs: remove btrfs_wait_tree_block_writeback
> 
>  fs/btrfs/ctree.c           | 15 +++++++-------
>  fs/btrfs/disk-io.c         | 25 +++++-------------------
>  fs/btrfs/disk-io.h         |  2 +-
>  fs/btrfs/extent-tree.c     | 12 ++++--------
>  fs/btrfs/extent_io.c       | 18 +++++++++--------
>  fs/btrfs/extent_io.h       |  2 +-
>  fs/btrfs/free-space-tree.c |  2 +-
>  fs/btrfs/ioctl.c           |  2 +-
>  fs/btrfs/qgroup.c          |  2 +-
>  fs/btrfs/tree-log.c        | 40 ++++++++++++++------------------------
>  10 files changed, 46 insertions(+), 74 deletions(-)
> 
> -- 
> 2.26.3


