Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA29324B96
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 08:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhBYHym (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 02:54:42 -0500
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:44430 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhBYHyd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 02:54:33 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0443632|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0936412-0.000754961-0.905604;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.Jd3t208_1614239628;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Jd3t208_1614239628)
          by smtp.aliyun-inc.com(10.147.41.137);
          Thu, 25 Feb 2021 15:53:48 +0800
Date:   Thu, 25 Feb 2021 15:53:51 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: xfstest btrfs/154 failed at kernel 5.4.100
Message-Id: <20210225155350.BB3A.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

xfstest btrfs/154 failed at kernel 5.4.100

frequency: always
kernel version: 5.4.100, other kernel version yet not tested.
xfstest: https://github.com/kdave/xfstests.git
btrfs-progs: 5.10.1
	but mkfs.btrfs default enable no-holes and free-space-tree.

# ./check btrfs/154
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 T7610 5.4.100-3.el7.x86_64 #1 SMP Thu Feb 25 13:19:45 CST 2021
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- /dev/sdb /mnt/scratch

btrfs/154       _check_dmesg: something found in dmesg (see /ssd/git/os/xfstests/results//btrfs/154.dmesg)
- output mismatch (see /ssd/git/os/xfstests/results//btrfs/154.out.bad)
    --- tests/btrfs/154.out     2021-02-25 13:41:27.906590386 +0800
    +++ /ssd/git/os/xfstests/results//btrfs/154.out.bad 2021-02-25 15:45:52.182865707 +0800
    @@ -1,2 +1,6 @@
     QA output created by 154
    +Traceback (most recent call last):
    +  File "/ssd/git/os/xfstests/src/btrfs_crc32c_forged_name.py", line 89, in <module>
    +    os.rename(srcpath, dstpath)
    +OSError: [Errno 75] Value too large for defined data type
     Silence is golden

154.dmesg:
[ 1137.030022] run fstests btrfs/154 at 2021-02-25 15:45:49
[ 1137.255989] BTRFS: device fsid 048c1c27-28e2-4a59-b972-a849548071b6 devid 1 transid 6 /dev/sdb
[ 1137.272475] BTRFS info (device sdb): using free space tree
[ 1137.273944] BTRFS info (device sdb): has skinny extents
[ 1137.275394] BTRFS info (device sdb): flagging fs with big metadata feature
[ 1137.280387] BTRFS info (device sdb): enabling ssd optimizations
[ 1137.282337] BTRFS info (device sdb): checking UUID tree
[ 1139.077762] ------------[ cut here ]------------
[ 1139.079227] BTRFS: Transaction aborted (error -75)
[ 1139.079319] WARNING: CPU: 13 PID: 33668 at /usr/hpc-bio/linux-5.4.100/fs/btrfs/inode.c:10160 btrfs_rename2+0xcfc/0x1fd0 [btrfs]
[ 1139.080221] Modules linked in: btrfs(OE) crc32c_intel xor raid6_pq zstd_compress zstd_decompress rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache rfkill rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi scsi_transport_iscsi ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib rdma_ucm ib_umad intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_realtek coretemp snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio kvm_intel snd_hda_intel snd_intel_nhlt dcdbas iTCO_wdt mei_hdcp mei_wdt iTCO_vendor_support dell_smm_hwmon kvm snd_hda_codec snd_hda_core irqbypass snd_hwdep rapl snd_seq snd_seq_device intel_cstate snd_pcm intel_uncore mei_me snd_timer i2c_i801 mei lpc_ich snd soundcore nvme_rdma rdma_cm iw_cm ib_cm nvme_fabrics rdmavt rdma_rxe ib_uverbs ip6_udp_tunnel udp_tunnel ib_core ip_tables xfs radeon i2c_algo_bit ttm bnx2x drm_kms_helper drm crct10dif_pclmul crc32_pclmul mpt3sas ghash_clmulni_intel nvme e1000e pcspkr
[ 1139.080221]  mdio nvme_core raid_class scsi_transport_sas wmi dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua sunrpc i2c_dev [last unloaded: crc32c_intel]
[ 1139.091695] CPU: 13 PID: 33668 Comm: python2 Tainted: G           OE     5.4.100-3.el7.x86_64 #1
[ 1139.091695] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 09/11/2019
[ 1139.095695] RIP: 0010:btrfs_rename2+0xcfc/0x1fd0 [btrfs]
[ 1139.095695] Code: 11 00 00 41 83 fa e2 0f 84 56 11 00 00 44 89 d6 48 c7 c7 28 54 66 c1 44 89 9d 38 ff ff ff 44 89 95 50 ff ff ff e8 d7 9a 3f fa <0f> 0b 44 8b 95 50 ff ff ff 44 8b 9d 38 ff ff ff 44 89 d1 ba b0 27
[ 1139.099694] RSP: 0018:ffffb1324f94bc80 EFLAGS: 00010282
[ 1139.103695] RAX: 0000000000000000 RBX: ffff9e10c6dfc210 RCX: 0000000000000006
[ 1139.103695] RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff9e10ef6d7900
[ 1139.107694] RBP: ffffb1324f94bd90 R08: 00000000000006e0 R09: 0000000000000007
[ 1139.107694] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9e10c6d01d90
[ 1139.111694] R13: ffff9e10c6df5800 R14: ffff9e10c6d01d90 R15: ffff9e10edb0cdd0
[ 1139.111694] FS:  00007f90f6657580(0000) GS:ffff9e10ef6c0000(0000) knlGS:0000000000000000
[ 1139.115694] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1139.115694] CR2: 00005598088b1768 CR3: 00000030289e6005 CR4: 00000000001606e0
[ 1139.119695] Call Trace:
[ 1139.119695]  ? btrfs_get_16+0x48/0xa0 [btrfs]
[ 1139.123695]  ? btrfs_search_slot+0x7fd/0x990 [btrfs]
[ 1139.123695]  ? inode_permission+0xbe/0x180
[ 1139.123695]  ? vfs_rename+0x303/0x9b0
[ 1139.128154]  vfs_rename+0x303/0x9b0
[ 1139.129710]  ? __lookup_hash+0x71/0xa0
[ 1139.131694]  do_renameat2+0x38e/0x530
[ 1139.131694]  __x64_sys_rename+0x1c/0x20
[ 1139.135694]  do_syscall_64+0x5b/0x180
[ 1139.135694]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1139.139694] RIP: 0033:0x7f90f53609eb
[ 1139.139694] Code: e8 5a 0a 08 00 85 c0 0f 95 c0 0f b6 c0 f7 d8 5b c3 66 0f 1f 44 00 00 b8 ff ff ff ff 5b c3 90 f3 0f 1e fa b8 52 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 69 e4 34 00 f7 d8
[ 1139.143695] RSP: 002b:00007ffe8b3597a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
[ 1139.147694] RAX: ffffffffffffffda RBX: 00007f90f53609e0 RCX: 00007f90f53609eb
[ 1139.147694] RDX: 00007f90f643f068 RSI: 00005598088b1760 RDI: 000055980893fc00
[ 1139.151696] RBP: 0000559808849690 R08: 0000559808849012 R09: 0000000000000006
[ 1139.151696] R10: 0000000000000065 R11: 0000000000000246 R12: 00007f90f64ea410
[ 1139.155694] R13: 00007f90f64c9390 R14: 0000559808849690 R15: 00007f90f65f6dc0
[ 1139.155694] ---[ end trace e4bc87cb710a7eb9 ]---
[ 1139.159704] BTRFS: error (device sdb) in btrfs_rename:10160: errno=-75 unknown
[ 1139.161685] BTRFS info (device sdb): forced readonly
[ 1139.260639] BTRFS info (device sdb): using free space tree
[ 1139.262409] BTRFS info (device sdb): has skinny extents
[ 1139.268132] BTRFS info (device sdb): enabling ssd optimizations


fs/btrfs/inode.c:
 10156          ret = btrfs_add_link(trans, BTRFS_I(new_dir), BTRFS_I(old_inode),
 10157                               new_dentry->d_name.name,
 10158                               new_dentry->d_name.len, 0, index);
 10159          if (ret) {
 10160                  btrfs_abort_transaction(trans, ret);
 10161                  goto out_fail;
 10162          }


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/02/25


