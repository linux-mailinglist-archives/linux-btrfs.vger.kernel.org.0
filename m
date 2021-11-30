Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93296462B43
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 04:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhK3Dns (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 22:43:48 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58132 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhK3Dnr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 22:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638243628; x=1669779628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lo0iiNClyPT8UMTcs0fc/2utImA5UWMVBjIK1Jz9TW4=;
  b=mV5W+14fCT7eoLOVaCIdRG4zJbYeCBIcv3eq8dgLKjJgwqtzUV2H09We
   IyCHNQPafbc3GQXcrNy0xF8XDJvV/v3jn4bmXaA9OKnnxG7Gw+FDTz/vn
   oJnOJbmKjXknyng/NC5JEdOkDZCIgYMrODfr9aUhhPt3AOQ3eRvwcm5MH
   rJo/E72XgNhSvUDkZ5jtgQwZ1vx6Y+HbwsW6Dv4AbqEmdy9f1psPn5HGT
   yYw6Qp9RdVHwCWlvrzwGwNgOm7oVbR8c4IcZMYA/lIC49ynuCAXxjfYL/
   lVtW2vWp5BG9ScjaJg92ud4q1voGH5a4bnglTVSTzcvHvmsHD99YGAa9U
   A==;
X-IronPort-AV: E=Sophos;i="5.87,275,1631548800"; 
   d="scan'208";a="191804061"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2021 11:40:28 +0800
IronPort-SDR: 4siP35FoKWCyksBWnwNkwqjo/tQZiCfzVkuNhvzrMZHsRFmRw+drF4B/lbpxL4fz0EZC9FQHX1
 qybsNOj8uk5r6/l5bMIaj42dbRHRGRd7smPUwKZUMhkWtAd9XJOh6EgEQ0VtTQx3pTkXGOPsYP
 CDVTV6dYgbCQnIe1T1rsqla/2L8TulzywlF0ZgCnBYvJi1xQkF5vwRCt3UUZ325cJLrY5/tZFn
 HV1k7isVoC27glfbTe3dNp7aIALcNaMHMs9E+Rk0py+X23K7EKP+2TzPWjMOEx3sHGi4fMBvYb
 Aq0zCA0w6PFnvYZkuWOAIjKm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 19:13:42 -0800
IronPort-SDR: J/AgK8havk9vGnZ3n2MyBe4yy/poGp9sofxHsb4wHV7Zbe2RmDOA0q7MyWFIVa+rJqOqYddMSw
 JeWjCmg5a+csiiAjrmAFYQNYhiXCKfcmWrYJ+JMPfjm4v8/lJDmgq9H+SpOqMaG+TVwG63ZElD
 XQ3YBMGOdHge2ujvg4ahmNkreLKKyV0+3flGc6etQPy9cmZpN5NjgqvYgWN95QnnXWEe1ZLD9W
 OCCqg3dk7vhOvISOG2gmDQNhW1f9UJ4sc6ftdUb23+Q1wNXpYLE0v+S1P+yomsznf4Ygq+WwNx
 PJQ=
WDCIronportException: Internal
Received: from 6vhbl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.134])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2021 19:40:28 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: fix re-dirty process of tree-log nodes
Date:   Tue, 30 Nov 2021 12:40:21 +0900
Message-Id: <20211130034021.515210-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a report of a transaction abort of -EAGAIN with the following
script.

  #!/bin/sh

  for d in sda sdb; do
          mkfs.btrfs -d single -m single -f /dev/\${d}
  done

  mount /dev/sda /mnt/test
  mount /dev/sdb /mnt/scratch

  for dir in test scratch; do
          echo 3 >/proc/sys/vm/drop_caches
          fio --directory=/mnt/\${dir} --name=fio.\${dir} --rw=read --size=50G --bs=64m \
                  --numjobs=$(nproc) --time_based --ramp_time=5 --runtime=480 \
                  --group_reporting |& tee /dev/shm/fio.\${dir}
          echo 3 >/proc/sys/vm/drop_caches
  done


  for d in sda sdb; do
          umount /dev/\${d}
  done

The stack trace is shown in below.

  [ 3310.967991] BTRFS: error (device sda) in btrfs_commit_transaction:2341: errno=-11 unknown (Error while writing out transaction)
  [ 3310.968060] BTRFS info (device sda): forced readonly
  [ 3310.968064] BTRFS warning (device sda): Skipping commit of aborted transaction.
  [ 3310.968065] ------------[ cut here ]------------
  [ 3310.968066] BTRFS: Transaction aborted (error -11)
  [ 3310.968074] WARNING: CPU: 14 PID: 1684 at fs/btrfs/transaction.c:1946 btrfs_commit_transaction.cold+0x209/0x2c8
  [ 3310.968083] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr ns sunrpc vfat fat ipmi_ssif intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd kvm_amd kvm irqbypass rapl wmi_bmof i2c_piix4 k10temp acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_cpufreq fuse zram ip_tables xfs raid1 crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ast i2c_algo_bit drm_vram_helper drm_kms_helper cec drm_ttm_helper ttm nvme drm ccp tg3 sp5100_tco nvme_core wmi
  [ 3310.968131] CPU: 14 PID: 1684 Comm: fio Not tainted 5.14.10-300.fc35.x86_64 #1
  [ 3310.968135] Hardware name: DIAWAY Tartu/Tartu, BIOS V2.01.B10 04/08/2021
  [ 3310.968137] RIP: 0010:btrfs_commit_transaction.cold+0x209/0x2c8
  [ 3310.968141] Code: e9 f3 b4 8d ff 49 8b 54 24 28 49 8b 44 24 30 48 89 42 08 48 89 10 e9 2d ff ff ff 44 89 f6 48 c7 c7 48 65 60 84 e8 fb 89 fe ff <0f> 0b e9 5e fe ff ff 48 8b 7d 50 44 89 f2 48 c7 c6 78 65 60 84 e8
  [ 3310.968144] RSP: 0018:ffffb284ce393e10 EFLAGS: 00010282
  [ 3310.968147] RAX: 0000000000000026 RBX: ffff973f147b0f60 RCX: 0000000000000027
  [ 3310.968149] RDX: ffff974ecf098a08 RSI: 0000000000000001 RDI: ffff974ecf098a00
  [ 3310.968150] RBP: ffff973f147b0f08 R08: 0000000000000000 R09: ffffb284ce393c48
  [ 3310.968151] R10: ffffb284ce393c40 R11: ffffffff84f47468 R12: ffff973f101bfc00
  [ 3310.968153] R13: ffff971f20cf2000 R14: 00000000fffffff5 R15: ffff973f147b0e58
  [ 3310.968154] FS:  00007efe65468740(0000) GS:ffff974ecf080000(0000) knlGS:0000000000000000
  [ 3310.968157] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [ 3310.968158] CR2: 000055691bcbe260 CR3: 000000105cfa4001 CR4: 0000000000770ee0
  [ 3310.968160] PKRU: 55555554
  [ 3310.968161] Call Trace:
  [ 3310.968167]  ? dput+0xd4/0x300
  [ 3310.968174]  btrfs_sync_file+0x3f1/0x490
  [ 3310.968180]  __x64_sys_fsync+0x33/0x60
  [ 3310.968185]  do_syscall_64+0x3b/0x90
  [ 3310.968190]  entry_SYSCALL_64_after_hwframe+0x44/0xae
  [ 3310.968194] RIP: 0033:0x7efe6557329b
  [ 3310.968198] Code: 4a 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 73 1e f8 ff 8b 7c 24 0c 41 89 c0 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 c1 1e f8 ff 8b 44
  [ 3310.968200] RSP: 002b:00007ffe0236ebc0 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
  [ 3310.968203] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efe6557329b
  [ 3310.968204] RDX: 0000000000000000 RSI: 00007efe58d77010 RDI: 0000000000000006
  [ 3310.968205] RBP: 0000000004000000 R08: 0000000000000000 R09: 00007efe58d77010
  [ 3310.968207] R10: 0000000016cacc0c R11: 0000000000000293 R12: 00007efe5ce95980
  [ 3310.968208] R13: 0000000000000000 R14: 00007efe6447c790 R15: 0000000c80000000
  [ 3310.968212] ---[ end trace 1a346f4d3c0d96ba ]---
  [ 3310.968214] BTRFS: error (device sda) in cleanup_transaction:1946: errno=-11 unknown

The abort occur because of a write hole while writing out freeing tree
nodes of a tree-log tree. For zoned btrfs, we re-dirty a freed tree
node to ensure btrfs can write the region and does not leave a hole on
write on a zoned device. The current code fails to re-dirty a node
when the tree-log tree's depth is greater or equal to 2. That leads to
a transaction abort with -EAGAIN.

Fix the issue by properly re-dirty a node on walking up the tree.

Fixes: d3575156f662 ("btrfs: zoned: redirty released extent buffers")
Cc: stable@vger.kernel.org # 5.12+
Link: https://github.com/kdave/btrfs-progs/issues/415
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/tree-log.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index de79e15a7c6a..a42e132f35f5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2890,6 +2890,8 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 						     path->nodes[*level]->len);
 					if (ret)
 						return ret;
+					btrfs_redirty_list_add(trans->transaction,
+							       next);
 				} else {
 					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 						clear_extent_buffer_dirty(next);
@@ -2970,6 +2972,8 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 						next->start, next->len);
 				if (ret)
 					goto out;
+				btrfs_redirty_list_add(trans->transaction,
+						       next);
 			} else {
 				if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 					clear_extent_buffer_dirty(next);
@@ -3420,8 +3424,6 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 			  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
 	extent_io_tree_release(&log->log_csum_range);
 
-	if (trans && log->node)
-		btrfs_redirty_list_add(trans->transaction, log->node);
 	btrfs_put_root(log);
 }
 
-- 
2.34.1

