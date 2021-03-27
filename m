Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE0434B59F
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Mar 2021 10:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhC0J0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Mar 2021 05:26:07 -0400
Received: from out20-87.mail.aliyun.com ([115.124.20.87]:41514 "EHLO
        out20-87.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhC0JZr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Mar 2021 05:25:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0118132-8.39027e-05-0.988103;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.Jr2OQgv_1616837142;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Jr2OQgv_1616837142)
          by smtp.aliyun-inc.com(10.147.41.199);
          Sat, 27 Mar 2021 17:25:42 +0800
Date:   Sat, 27 Mar 2021 17:25:48 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: xfstests generic/476 failed on btrfs(errno=-12 Out of memory, kernel 5.11.10)
In-Reply-To: <20210326230058.2574.409509F4@e16-tech.com>
References: <20210326230058.2574.409509F4@e16-tech.com>
Message-Id: <20210327172547.1BAA.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

SSD/SAS is easy than SSD/NVMe to reproduce this problem.

Yet not able to reproduce this problem on another server.
CPU:  Xeon(R) CPU E5-2680 v2(10 core)  *2
memory:  192G, no swap
disk: SSD/NVMe with same partition size as SSD/SAS.


And this problem happened in kernel 5.10.26 + btrfs backport from
5.12.0-rc4 with a different callstack.

[10459.782442] run fstests generic/476 at 2021-03-27 15:02:14
[10459.988507] BTRFS info (device nvme0n1p1): has skinny extents
[10459.988515] BTRFS info (device nvme0n1p1): using free space tree
[10459.991086] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[10460.062565] BTRFS: device fsid 776508dd-165d-4150-89a9-0cdd13a0004a devid 1 transid 6 /dev/sdb1 scanned by mkfs.btrfs (2713399)
[10460.075938] BTRFS info (device sdb1): has skinny extents
[10460.075947] BTRFS info (device sdb1): flagging fs with big metadata feature
[10460.075950] BTRFS info (device sdb1): using free space tree
[10460.077791] BTRFS info (device sdb1): enabling ssd optimizations
[10460.078662] BTRFS info (device sdb1): checking UUID tree
[10604.622052] ------------[ cut here ]------------
[10604.622062] BTRFS: Transaction aborted (error -12)
[10604.622182] WARNING: CPU: 10 PID: 2713438 at fs/btrfs/ioctl.c:718 create_subvol+0x888/0x8f0 [btrfs]
[10604.622187] Modules linked in: dm_thin_pool dm_persistent_data dm_bio_prison dm_flakey loop rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache rfkill rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi scsi_transport_iscsi ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib rdma_ucm ib_umad snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common snd_hda_intel snd_intel_dspcfg soundwire_intel soundwire_generic_allocation snd_soc_core sb_edac x86_pkg_temp_thermal snd_compress iTCO_wdt intel_powerclamp intel_pmc_bxt snd_pcm_dmaengine coretemp soundwire_cadence mei_wdt mei_hdcp iTCO_vendor_support kvm_intel snd_hda_codec dcdbas dell_smm_hwmon snd_hda_core kvm ac97_bus snd_hwdep snd_seq snd_seq_device irqbypass snd_pcm rapl intel_cstate mei_me snd_timer i2c_i801 intel_uncore snd mei i2c_smbus lpc_ich soundcore nvme_rdma nvme_fabrics rdma_cm iw_cm ib_cm rdmavt rdma_rxe nfsd ib_uverbs ip6_udp_tunnel udp_tunnel ib_core auth_rpcgss nfs_acl
[10604.622244]  lockd grace nfs_ssc ip_tables xfs radeon i2c_algo_bit bnx2x ttm drm_kms_helper cec crct10dif_pclmul crc32_pclmul crc32c_intel drm nvme mpt3sas e1000e pcspkr mdio ghash_clmulni_intel nvme_core raid_class scsi_transport_sas wmi dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua btrfs xor raid6_pq sunrpc i2c_dev [last unloaded: scsi_debug]
[10604.622292] CPU: 10 PID: 2713438 Comm: fsstress Tainted: G S                5.10.26-3.el7.x86_64 #1
[10604.622296] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 09/11/2019
[10604.622333] RIP: 0010:create_subvol+0x888/0x8f0 [btrfs]
[10604.622337] Code: 8b 40 50 f0 48 0f ba a8 50 0a 00 00 03 72 1d 41 83 ff fb 74 37 41 83 ff e2 74 31 44 89 fe 48 c7 c7 f0 44 59 c0 e8 ec 6b 5a f6 <0f> 0b 48 8b bd 30 ff ff ff 44 89 f9 ba ce 02 00 00 48 c7 c6 80 2a
[10604.622342] RSP: 0018:ffffafd7326cfc08 EFLAGS: 00010286
[10604.622346] RAX: 0000000000000000 RBX: ffff9071a992ca00 RCX: 0000000000000027
[10604.622348] RDX: 0000000000000027 RSI: ffff90812f818a80 RDI: ffff90812f818a88
[10604.622351] RBP: ffffafd7326cfce8 R08: 0000000000000000 R09: c0000000ffffd1cc
[10604.622354] R10: fffffffffffd00d0 R11: ffffafd7326cfa10 R12: 00000000fffffff4
[10604.622358] R13: ffff905445386000 R14: ffff9071e9b40230 R15: fffffffffffffff4
[10604.622361] FS:  00007fb9e7398000(0000) GS:ffff90812f800000(0000) knlGS:0000000000000000
[10604.622364] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10604.622367] CR2: 00000000009c5c40 CR3: 000000020d826002 CR4: 00000000001706e0
[10604.622370] Call Trace:
[10604.622411]  btrfs_mksubvol+0x368/0x440 [btrfs]
[10604.622447]  __btrfs_ioctl_snap_create+0x11c/0x170 [btrfs]
[10604.622455]  ? _copy_from_user+0x3a/0x70
[10604.622488]  btrfs_ioctl_snap_create_v2+0x111/0x140 [btrfs]
[10604.622522]  btrfs_ioctl+0x9d5/0x2f80 [btrfs]
[10604.622528]  ? __handle_mm_fault+0x797/0x7c0
[10604.622534]  ? __x64_sys_ioctl+0x84/0xc0
[10604.622536]  __x64_sys_ioctl+0x84/0xc0
[10604.622542]  do_syscall_64+0x33/0x40
[10604.622549]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10604.622552] RIP: 0033:0x7fb9e668988b
[10604.622556] Code: 0f 1e fa 48 8b 05 fd 95 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cd 95 2c 00 f7 d8 64 89 01 48
[10604.622561] RSP: 002b:00007fff461628b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[10604.622565] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb9e668988b
[10604.622569] RDX: 00007fff461628c0 RSI: 0000000050009418 RDI: 0000000000000004
[10604.622572] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000006
[10604.622575] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000005
[10604.622577] R13: 0000000000404d60 R14: 0000000000000000 R15: 0000000000000000
[10604.622582] ---[ end trace ca8166c2db3ed522 ]---
[10604.622587] BTRFS: error (device sdb1) in create_subvol:718: errno=-12 Out of memory
[10604.622591] BTRFS info (device sdb1): forced readonly
[10617.634193] BTRFS info (device sdb1): has skinny extents
[10617.634205] BTRFS info (device sdb1): using free space tree
[10617.642932] BTRFS info (device sdb1): enabling ssd optimizations


fs/btrfs/ioctl.c:718

    new_root = btrfs_get_new_fs_root(fs_info, objectid, anon_dev);
    if (IS_ERR(new_root)) {
        free_anon_bdev(anon_dev);
        ret = PTR_ERR(new_root);
        btrfs_abort_transaction(trans, ret);
        goto fail;
    }


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/03/27

> Hi,
> 
> xfstests generic/476 failed on btrfs(errno=-12 Out of memory, kernel 5.11.10)
> 
> The hardware of this server:
> CPU:  Xeon(R) CPU E5-2660 v2(10 core)  *2
> memory:  192G, no swap
> kernel config: see the file config-5.11.10-1
> 
> # cat /ssd/git/os/xfstests/results//generic/476.dmesg
> [ 4890.430304] run fstests generic/476 at 2021-03-26 19:02:17
> [ 4890.634292] BTRFS info (device nvme0n1p1): using free space tree
> [ 4890.634303] BTRFS info (device nvme0n1p1): has skinny extents
> [ 4890.636509] BTRFS info (device nvme0n1p1): enabling ssd optimizations
> [ 4890.697326] BTRFS: device fsid e9634b28-1ede-4e14-bb0b-18226e5858d0 devid 1 transid 6 /dev/sdb1 scanned by mkfs.btrfs (2635285)
> [ 4890.711959] BTRFS info (device sdb1): using free space tree
> [ 4890.711967] BTRFS info (device sdb1): has skinny extents
> [ 4890.711971] BTRFS info (device sdb1): flagging fs with big metadata feature
> [ 4890.713813] BTRFS info (device sdb1): enabling ssd optimizations
> [ 4890.713993] BTRFS info (device sdb1): cleaning free space cache v1
> [ 4890.714664] BTRFS info (device sdb1): checking UUID tree
> [ 5071.783374] ------------[ cut here ]------------
> [ 5071.783387] BTRFS: Transaction aborted (error -12)
> [ 5071.783452] WARNING: CPU: 38 PID: 2635321 at fs/btrfs/transaction.c:1679 create_pending_snapshot+0xc1a/0xda0 [btrfs]
> [ 5071.783529] Modules linked in: dm_thin_pool dm_persistent_data dm_bio_prison dm_snapshot dm_bufio dm_flakey loop ext4 mbcache jbd2 rpcsec_gss_krb5 nfsv4 dns_resolver nfs nfs_ssc fscache rfkill rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi scsi_transport_iscsi ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib rdma_ucm ib_umad intel_rapl_msr intel_rapl_common snd_hda_codec_realtek snd_hda_codec_generic sb_edac x86_pkg_temp_thermal snd_hda_codec_hdmi ledtrig_audio intel_powerclamp coretemp dcdbas kvm_intel snd_hda_intel mei_wdt snd_intel_dspcfg iTCO_wdt iTCO_vendor_support dell_smm_hwmon snd_hda_codec kvm snd_hda_core snd_hwdep snd_seq snd_seq_device irqbypass snd_pcm rapl intel_cstate snd_timer mei_me snd intel_uncore i2c_i801 pcspkr mei lpc_ich i2c_smbus soundcore nvme_rdma rdma_cm iw_cm ib_cm nvme_fabrics rdmavt rdma_rxe nfsd ib_uverbs ip6_udp_tunnel udp_tunnel ib_core auth_rpcgss nfs_acl lockd grace ip_tables xfs sd_mod sr_mod cdrom sg radeon i2c_algo_bit drm_ttm_helper
> [ 5071.783605]  ttm bnx2x drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm crct10dif_pclmul crc32_pclmul mpt3sas crc32c_intel ahci libahci nvme e1000e ghash_clmulni_intel libata mdio nvme_core raid_class scsi_transport_sas t10_pi wmi dm_multipath btrfs xor zstd_decompress zstd_compress raid6_pq sunrpc dm_mirror dm_region_hash dm_log dm_mod i2c_dev [last unloaded: scsi_debug]
> [ 5071.783658] CPU: 38 PID: 2635321 Comm: fsstress Tainted: G S      W         5.11.10-1.el8.x86_64 #1
> [ 5071.783664] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 09/11/2019
> [ 5071.783668] RIP: 0010:create_pending_snapshot+0xc1a/0xda0 [btrfs]
> [ 5071.783719] Code: 03 72 30 83 f8 fb 0f 84 45 01 00 00 83 f8 e2 0f 84 3c 01 00 00 89 c6 48 c7 c7 f0 60 54 c0 48 89 85 78 ff ff ff e8 98 03 ee cf <0f> 0b 48 8b 85 78 ff ff ff 89 c1 ba 8f 06 00 00 48 c7 c6 50 76 53
> [ 5071.783726] RSP: 0018:ffffb090a46cfb00 EFLAGS: 00010286
> [ 5071.783730] RAX: 0000000000000000 RBX: ffff8ec518ef60d0 RCX: 0000000000000027
> [ 5071.783734] RDX: 0000000000000027 RSI: ffff8ed4afc97d80 RDI: ffff8ed4afc97d88
> [ 5071.783737] RBP: ffffb090a46cfbd0 R08: 0000000000000000 R09: c0000000ffff7fff
> [ 5071.783740] R10: 0000000000000001 R11: ffffb090a46cf908 R12: ffff8ea6284be240
> [ 5071.783743] R13: ffff8ec519783400 R14: ffff8ec4fa591800 R15: 00000000fffffff4
> [ 5071.783747] FS:  00007fe2123fc000(0000) GS:ffff8ed4afc80000(0000) knlGS:0000000000000000
> [ 5071.783751] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5071.783754] CR2: 00007fe2123fa000 CR3: 000000010f866002 CR4: 00000000001706e0
> [ 5071.783758] Call Trace:
> [ 5071.783767]  ? create_pending_snapshots+0xa2/0xc0 [btrfs]
> [ 5071.783817]  create_pending_snapshots+0xa2/0xc0 [btrfs]
> [ 5071.783889]  btrfs_commit_transaction+0x297/0xb10 [btrfs]
> [ 5071.783939]  ? btrfs_record_root_in_trans+0x56/0x60 [btrfs]
> [ 5071.783987]  ? finish_wait+0x80/0x80
> [ 5071.783994]  btrfs_mksubvol+0x2b0/0x440 [btrfs]
> [ 5071.784058]  btrfs_mksnapshot+0x75/0xa0 [btrfs]
> [ 5071.784120]  __btrfs_ioctl_snap_create+0x167/0x170 [btrfs]
> [ 5071.784181]  btrfs_ioctl_snap_create_v2+0x111/0x140 [btrfs]
> [ 5071.784241]  btrfs_ioctl+0xb9e/0x2f30 [btrfs]
> [ 5071.784303]  ? __x64_sys_ioctl+0x84/0xc0
> [ 5071.784310]  __x64_sys_ioctl+0x84/0xc0
> [ 5071.784317]  do_syscall_64+0x33/0x40
> [ 5071.784325]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 5071.784334] RIP: 0033:0x7fe2116f388b
> [ 5071.784339] Code: 0f 1e fa 48 8b 05 fd 95 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cd 95 2c 00 f7 d8 64 89 01 48
> [ 5071.784344] RSP: 002b:00007fffa709dfe8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
> [ 5071.784349] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe2116f388b
> [ 5071.784352] RDX: 00007fffa709f010 RSI: 0000000050009417 RDI: 0000000000000005
> [ 5071.784356] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
> [ 5071.784359] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> [ 5071.784362] R13: 00007fffa70a0060 R14: 0000000000000005 R15: 0000000000000005
> [ 5071.784367] ---[ end trace 1b8c9453a855d694 ]---
> [ 5071.784376] BTRFS: error (device sdb1) in create_pending_snapshot:1679: errno=-12 Out of memory
> [ 5071.784382] BTRFS info (device sdb1): forced readonly
> [ 5071.784388] btrfs_printk: 72 callbacks suppressed
> [ 5071.784389] BTRFS warning (device sdb1): Skipping commit of aborted transaction.
> [ 5071.784395] BTRFS: error (device sdb1) in cleanup_transaction:1939: errno=-12 Out of memory
> [ 5083.887607] BTRFS info (device sdb1): using free space tree
> [ 5083.887619] BTRFS info (device sdb1): has skinny extents
> [ 5083.897508] BTRFS info (device sdb1): enabling ssd optimizations
> [ 5083.962955] BTRFS info (device sdb1): checking UUID tree
> 
> 
> xfstest (check) is easy than xfstest (check generic/476) to reproduce
> this problem.
> 
> CONFIG_PGTABLE_LEVELS=4 in config-5.11.10-1 , so we test it again in
> CONFIG_PGTABLE_LEVELS=5, this problem happened too.
> 
> [ 5517.540314] run fstests generic/476 at 2021-03-26 22:44:25
> [ 5517.749126] BTRFS info (device nvme0n1p1): using free space tree
> [ 5517.750050] BTRFS info (device nvme0n1p1): has skinny extents
> [ 5517.753372] BTRFS info (device nvme0n1p1): enabling ssd optimizations
> [ 5517.817411] BTRFS: device fsid d45acee6-3d3c-44d9-88be-46edd236b457 devid 1 transid 6 /dev/sdb1 scanned by mkfs.btrfs (2645359)
> [ 5517.832014] BTRFS info (device sdb1): using free space tree
> [ 5517.833034] BTRFS info (device sdb1): has skinny extents
> [ 5517.834032] BTRFS info (device sdb1): flagging fs with big metadata feature
> [ 5517.836874] BTRFS info (device sdb1): enabling ssd optimizations
> [ 5517.838057] BTRFS info (device sdb1): cleaning free space cache v1
> [ 5517.839759] BTRFS info (device sdb1): checking UUID tree
> [ 5665.863820] ------------[ cut here ]------------
> [ 5665.865301] BTRFS: Transaction aborted (error -12)
> [ 5665.865372] WARNING: CPU: 34 PID: 2645395 at fs/btrfs/transaction.c:1679 create_pending_snapshot+0xc1a/0xda0 [btrfs]
> [ 5665.866756] Modules linked in: dm_thin_pool dm_persistent_data dm_bio_prison dm_snapshot dm_bufio dm_flakey loop ext4 mbcache jbd2 rpcsec_gss_krb5 nfsv4 dns_resolver nfs nfs_ssc fscache rfkill rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi scsi_transport_iscsi ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib rdma_ucm ib_umad intel_rapl_msr intel_rapl_common snd_hda_codec_realtek sb_edac snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio x86_pkg_temp_thermal intel_powerclamp snd_hda_intel coretemp snd_intel_dspcfg kvm_intel snd_hda_codec snd_hda_core dcdbas iTCO_wdt mei_wdt iTCO_vendor_support dell_smm_hwmon snd_hwdep kvm snd_seq snd_seq_device snd_pcm irqbypass rapl snd_timer intel_cstate snd intel_uncore mei_me i2c_i801 pcspkr i2c_smbus mei lpc_ich soundcore nvme_rdma rdma_cm iw_cm ib_cm nvme_fabrics rdmavt nfsd rdma_rxe ib_uverbs ip6_udp_tunnel udp_tunnel ib_core auth_rpcgss nfs_acl lockd grace ip_tables xfs sd_mod sr_mod cdrom sg radeon i2c_algo_bit drm_ttm_helper
> [ 5665.866851]  ttm drm_kms_helper bnx2x syscopyarea sysfillrect sysimgblt fb_sys_fops cec ahci crct10dif_pclmul libahci crc32_pclmul nvme crc32c_intel drm mpt3sas libata e1000e ghash_clmulni_intel nvme_core mdio raid_class scsi_transport_sas t10_pi wmi dm_multipath btrfs xor zstd_decompress zstd_compress raid6_pq sunrpc dm_mirror dm_region_hash dm_log dm_mod i2c_dev [last unloaded: scsi_debug]
> [ 5665.882765] CPU: 34 PID: 2645395 Comm: fsstress Tainted: G S                5.11.10-2.el8.x86_64 #1
> [ 5665.884634] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 09/11/2019
> [ 5665.886592] RIP: 0010:create_pending_snapshot+0xc1a/0xda0 [btrfs]
> [ 5665.888599] Code: 03 72 30 83 f8 fb 0f 84 45 01 00 00 83 f8 e2 0f 84 3c 01 00 00 89 c6 48 c7 c7 f0 20 3c c0 48 89 85 78 ff ff ff e8 50 86 46 f0 <0f> 0b 48 8b 85 78 ff ff ff 89 c1 ba 8f 06 00 00 48 c7 c6 50 36 3b
> [ 5665.892739] RSP: 0018:ffffb82ee81ffa60 EFLAGS: 00010286
> [ 5665.894863] RAX: 0000000000000000 RBX: ffff9ffcf0aae6e8 RCX: 0000000000000027
> [ 5665.897001] RDX: 0000000000000027 RSI: ffffa00b6fb97d80 RDI: ffffa00b6fb97d88
> [ 5665.899160] RBP: ffffb82ee81ffb30 R08: 0000000000000000 R09: c0000000ffff7fff
> [ 5665.901363] R10: 0000000000000001 R11: ffffb82ee81ff868 R12: ffff9ffc825fb800
> [ 5665.903556] R13: ffff9ffbdb759800 R14: ffff9fdeb761c000 R15: 00000000fffffff4
> [ 5665.905765] FS:  00007f8100d50000(0000) GS:ffffa00b6fb80000(0000) knlGS:0000000000000000
> [ 5665.908029] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5665.910285] CR2: 0000000001c83638 CR3: 00000004e3ab0002 CR4: 00000000001706e0
> [ 5665.912575] Call Trace:
> [ 5665.914870]  ? create_pending_snapshots+0xa2/0xc0 [btrfs]
> [ 5665.917249]  create_pending_snapshots+0xa2/0xc0 [btrfs]
> [ 5665.919583]  btrfs_commit_transaction+0x297/0xb10 [btrfs]
> [ 5665.921945]  ? btrfs_block_rsv_release+0xe2/0x2a0 [btrfs]
> [ 5665.924319]  ? finish_wait+0x80/0x80
> [ 5665.926664]  create_subvol+0x4ef/0x8c0 [btrfs]
> [ 5665.929056]  btrfs_mksubvol+0x36e/0x440 [btrfs]
> [ 5665.931441]  ? path_openat+0x638/0xfd0
> [ 5665.933758]  __btrfs_ioctl_snap_create+0x11c/0x170 [btrfs]
> [ 5665.936077]  ? _copy_from_user+0x3a/0x70
> [ 5665.938337]  btrfs_ioctl_snap_create_v2+0x111/0x140 [btrfs]
> [ 5665.940657]  btrfs_ioctl+0x9b0/0x2f30 [btrfs]
> [ 5665.943001]  ? tick_sched_handle.isra.23+0x1f/0x60
> [ 5665.945275]  ? __x64_sys_ioctl+0x84/0xc0
> [ 5665.947526]  __x64_sys_ioctl+0x84/0xc0
> [ 5665.949756]  do_syscall_64+0x33/0x40
> [ 5665.951992]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 5665.954230] RIP: 0033:0x7f810004188b
> [ 5665.956396] Code: 0f 1e fa 48 8b 05 fd 95 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cd 95 2c 00 f7 d8 64 89 01 48
> [ 5665.961062] RSP: 002b:00007fff3bbbe388 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
> [ 5665.963468] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f810004188b
> [ 5665.965863] RDX: 00007fff3bbbe390 RSI: 0000000050009418 RDI: 0000000000000004
> [ 5665.968236] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000006
> [ 5665.970649] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000005
> [ 5665.973027] R13: 0000000000404d60 R14: 0000000000000000 R15: 0000000000000000
> [ 5665.975416] ---[ end trace 648a28c0cc4e3cd4 ]---
> [ 5665.977818] BTRFS: error (device sdb1) in create_pending_snapshot:1679: errno=-12 Out of memory
> [ 5665.980170] BTRFS info (device sdb1): forced readonly
> [ 5665.982528] btrfs_printk: 241 callbacks suppressed
> [ 5665.982531] BTRFS warning (device sdb1): Skipping commit of aborted transaction.
> [ 5665.987121] BTRFS: error (device sdb1) in cleanup_transaction:1939: errno=-12 Out of memory
> [ 5678.073600] BTRFS info (device sdb1): using free space tree
> [ 5678.075716] BTRFS info (device sdb1): has skinny extents
> [ 5678.086808] BTRFS info (device sdb1): enabling ssd optimizations
> [ 5678.146553] BTRFS info (device sdb1): checking UUID tree
> 
> 
> It is not clear whether it is a btrfs problem or a linux mm problem. 
> but firstly report it as btrfs problem.
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/03/26


