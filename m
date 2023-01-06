Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561EB65FC8D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jan 2023 09:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjAFIPj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Jan 2023 03:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAFIPi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Jan 2023 03:15:38 -0500
Received: from out20-2.mail.aliyun.com (out20-2.mail.aliyun.com [115.124.20.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52DA78E83
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Jan 2023 00:15:35 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04437578|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0350478-0.000388976-0.964563;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.QlrVp55_1672992932;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.QlrVp55_1672992932)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 16:15:33 +0800
Date:   Fri, 06 Jan 2023 16:15:34 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: unexpected ENOSPC(space_info METADATA has -105644032 free)
In-Reply-To: <20230106152516.8451.409509F4@e16-tech.com>
References: <20230106152516.8451.409509F4@e16-tech.com>
Message-Id: <20230106161533.F59D.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> Hi,
> 
> unexpected ENOSPC(space_info METADATA has -105644032 free) happen.
> 
> Test case: 
> 1, run fstests generic/006 over nfs, and btrfs as nfsd back-end file
> system
> 2, kernel 6.1.4-rc1, with btrfs code 6.2-rc2+
> 3, output of 'df -h'
> /dev/nvme0n1p1          btrfs   20G  543M   19G   3% /mnt/test
> /dev/nvme0n1p2          btrfs  100G  4.0M   98G   1% /mnt/scratch
> 
> test machine: ECC memory, and no ECC error.
> 
> dmesg output:
> [ 3068.891594] run fstests generic/006 at 2023-01-06 15:08:56
> [ 3070.740195] ------------[ cut here ]------------
> [ 3070.744856] BTRFS: Transaction aborted (error -28)
> [ 3070.749720] WARNING: CPU: 4 PID: 623014 at fs/btrfs/extent-tree.c:3077 __btrfs_free_extent.isra.49.cold.70+0xa27/0xa80 [btrfs]
> [ 3070.761272] Modules linked in: overlay loop rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache netfs rpcrdma rdma_cm iw_cm ib_cm nfsd auth_rpcgss nfs_acl lockd grace rfkill ib_core sunrpc dm_multipath intel_rapl_msr intel_rapl_common snd_hda_codec_realtek sb_edac snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio snd_hda_intel x86_pkg_temp_thermal snd_intel_dspcfg intel_powerclamp snd_intel_sdw_acpi snd_hda_codec coretemp nouveau snd_hda_core snd_hwdep kvm_intel snd_seq btrfs snd_seq_device mxm_wmi video mei_wdt kvm dcdbas blake2b_generic drm_display_helper snd_pcm xor iTCO_wdt cec raid6_pq irqbypass drm_ttm_helper iTCO_vendor_support dell_smm_hwmon zstd_compress mei_me snd_timer rapl intel_cstate dm_mod i2c_i801 snd ttm ses pcspkr intel_uncore lpc_ich enclosure mei i2c_smbus soundcore fuse xfs sd_mod sg nvme crct10dif_pclmul ahci crc32_pclmul libahci nvme_core crc32c_intel e1000e ata_generic ghash_clmulni_intel smartpqi libata nvme_common scsi_transport_sas t10_pi wmi i2c_dev
> [ 3070.848445] CPU: 4 PID: 623014 Comm: nfsd Tainted: G        W          6.1.4-0.7.el7.x86_64 #1
> [ 3070.857113] Hardware name: Dell Inc. Precision T3610/09M8Y8, BIOS A19 09/11/2019
> [ 3070.864569] RIP: 0010:__btrfs_free_extent.isra.49.cold.70+0xa27/0xa80 [btrfs]
> [ 3070.871816] Code: fa 48 c7 c6 58 6f 0b c1 48 8b 78 50 e8 ea 36 01 00 c6 44 24 27 01 e9 a1 fe ff ff 44 89 fe 48 c7 c7 28 6f 0b c1 e8 c1 6b 8b d2 <0f> 0b e9 49 fe ff ff 48 8b 44 24 08 44 89 fa 48 c7 c6 58 6f 0b c1
> [ 3070.890707] RSP: 0018:ffffbb7d080df900 EFLAGS: 00010286
> [ 3070.895978] RAX: 0000000000000000 RBX: ffffa0cac5aa30e0 RCX: 0000000000000000
> [ 3070.903160] RDX: ffffa0d20fa2c300 RSI: ffffa0d20fa1f860 RDI: ffffa0d20fa1f860
> [ 3070.910353] RBP: 00000000002b4000 R08: 0000000000000000 R09: c0000000fffdffff
> [ 3070.917545] R10: 0000000000000001 R11: ffffbb7d080df798 R12: 0000000000000000
> [ 3070.924788] R13: 0000000000000003 R14: 0000000000000003 R15: 00000000ffffffe4
> [ 3070.931970] FS:  0000000000000000(0000) GS:ffffa0d20fa00000(0000) knlGS:0000000000000000
> [ 3070.940110] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3070.945905] CR2: 00007fdf74b3f090 CR3: 000000029ac10003 CR4: 00000000001706e0
> [ 3070.953087] Call Trace:
> [ 3070.955550]  <TASK>
> [ 3070.957676]  ? free_unref_page+0x11c/0x160
> [ 3070.961816]  ? call_rcu+0xca/0x5b0
> [ 3070.965243]  btrfs_run_delayed_refs_for_head+0x41c/0x980 [btrfs]
> [ 3070.971351]  ? btrfs_log_inode+0x486/0x1500 [btrfs]
> [ 3070.976307]  ? btrfs_tree_mod_log_lowest_seq+0x44/0x50 [btrfs]
> [ 3070.982238]  ? btrfs_merge_delayed_refs+0x31b/0x370 [btrfs]
> [ 3070.987908]  __btrfs_run_delayed_refs+0x9c/0x600 [btrfs]
> [ 3070.993306]  ? mutex_lock+0x1f/0x40
> [ 3070.996865]  ? btrfs_log_inode_parent+0x367/0xcb0 [btrfs]
> [ 3071.002351]  btrfs_run_delayed_refs+0x80/0x1a0 [btrfs]
> [ 3071.007568]  btrfs_commit_transaction+0x71/0xba0 [btrfs]
> [ 3071.012963]  ? dput.part.32+0xd6/0x2f0
> [ 3071.016743]  btrfs_sync_file+0x52b/0x560 [btrfs]
> [ 3071.021448]  nfsd_file_free+0xbf/0x210 [nfsd]
> [ 3071.025870]  __nfs4_file_put_access.part.92+0x53/0x80 [nfsd]
> [ 3071.031597]  nfs4_file_put_access+0x40/0x70 [nfsd]
> [ 3071.036457]  release_all_access+0x6c/0x80 [nfsd]
> [ 3071.041142]  nfs4_free_ol_stateid+0x22/0x60 [nfsd]
> [ 3071.046003]  nfs4_put_stid+0x55/0xa0 [nfsd]
> [ 3071.050255]  nfsd4_close+0x18e/0x3b0 [nfsd]
> [ 3071.054505]  ? nfsd4_encode_getattr+0x28/0x30 [nfsd]
> [ 3071.059539]  ? nfsd4_encode_operation+0xaa/0x280 [nfsd]
> [ 3071.064835]  nfsd4_proc_compound+0x3a4/0x750 [nfsd]
> [ 3071.069819]  nfsd_dispatch+0x15b/0x290 [nfsd]
> [ 3071.074242]  svc_process_common+0x316/0x5d0 [sunrpc]
> [ 3071.079282]  ? nfsd_svc+0x350/0x350 [nfsd]
> [ 3071.083438]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
> [ 3071.088554]  svc_process+0xad/0x100 [sunrpc]
> [ 3071.092897]  nfsd+0xd5/0x190 [nfsd]
> [ 3071.096435]  kthread+0xe3/0x110
> [ 3071.099611]  ? kthread_complete_and_exit+0x20/0x20
> [ 3071.104445]  ret_from_fork+0x1f/0x30
> [ 3071.108062]  </TASK>
> [ 3071.110262] ---[ end trace 0000000000000000 ]---
> [ 3071.114924] BTRFS info (device nvme0n1p1: state A): dumping space info:
> [ 3071.121582] BTRFS info (device nvme0n1p1: state A): space_info DATA has 3730055168 free, is not full
> [ 3071.130786] BTRFS info (device nvme0n1p1: state A): space_info total=4294967296, used=561876992, pinned=0, reserved=3035136, may_use=0, readonly=0 zone_unusable=0
> [ 3071.145452] BTRFS info (device nvme0n1p1: state A): space_info METADATA has -105644032 free, is full
> [ 3071.154643] BTRFS info (device nvme0n1p1: state A): space_info total=1073741824, used=3522560, pinned=1062944768, reserved=7208960, may_use=105644032, readonly=65536 zone_unusable=0
> [ 3071.170927] BTRFS info (device nvme0n1p1: state A): space_info SYSTEM has 4161536 free, is not full
> [ 3071.180033] BTRFS info (device nvme0n1p1: state A): space_info total=4194304, used=16384, pinned=0, reserved=16384, may_use=0, readonly=0 zone_unusable=0
> [ 3071.193870] BTRFS info (device nvme0n1p1: state A): global_block_rsv: size 3670016 reserved 3670016
> [ 3071.202975] BTRFS info (device nvme0n1p1: state A): trans_block_rsv: size 1310720 reserved 1310720
> [ 3071.211991] BTRFS info (device nvme0n1p1: state A): chunk_block_rsv: size 0 reserved 0
> [ 3071.220002] BTRFS info (device nvme0n1p1: state A): delayed_block_rsv: size 0 reserved 0
> [ 3071.228143] BTRFS info (device nvme0n1p1: state A): delayed_refs_rsv: size 100663296 reserved 100663296
> [ 3071.237599] BTRFS: error (device nvme0n1p1: state A) in __btrfs_free_extent:3077: errno=-28 No space left
> [ 3071.247241] BTRFS info (device nvme0n1p1: state EA): forced readonly
> [ 3071.253648] BTRFS error (device nvme0n1p1: state EA): failed to run delayed ref for logical 2834432 num_bytes 16384 type 176 action 2 ref_mod 1: -28
> [ 3071.267058] BTRFS: error (device nvme0n1p1: state EA) in btrfs_run_delayed_refs:2151: errno=-28 No space left
> [ 3071.277093] BTRFS warning (device nvme0n1p1: state EA): Skipping commit of aborted transaction.
> [ 3071.285893] BTRFS: error (device nvme0n1p1: state EA) in cleanup_transaction:1984: errno=-28 No space left

It is yet not clear why 'space_info METADATA has -105,644,032 free'.

but another 2 questions.
1,  'global_block_rsv: size 3,670,016' < 'space_info METADATA has
-105,644,032 free', if we have bigger global_block_rsv(such as 2G), can
we walk around this problem?

2, Is global_block_rsv reserved in memory only, or in disk device?
if global_block_rsv is reserved in disk device, it will use which of 
DATA/METADATA/SYSTEM group?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/01/06


