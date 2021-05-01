Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49853704EB
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 May 2021 04:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhEACIB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 22:08:01 -0400
Received: from out20-1.mail.aliyun.com ([115.124.20.1]:46949 "EHLO
        out20-1.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhEACIA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 22:08:00 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04820154|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0112843-0.00155434-0.987161;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.K6xSAyq_1619834829;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.K6xSAyq_1619834829)
          by smtp.aliyun-inc.com(10.147.40.200);
          Sat, 01 May 2021 10:07:10 +0800
Date:   Sat, 01 May 2021 10:07:14 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: 'umount /mnt/scratch' of xfstests generic/475 freeze
Message-Id: <20210501100713.E2BB.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

'umount /mnt/scratch' of xfstests generic/475 freeze, the OS still
reponse.

the frequency is yet not clear, but not high.

By the way, We enable '-O no-holes -R free-space-tree' default for
mkfs.btrfs.

This is the dmesg output:

[ 4674.419567] ------------[ cut here ]------------
[ 4674.425349] WARNING: CPU: 11 PID: 2022633 at fs/btrfs/extent_io.c:6409 extent_buffer_test_bit+0x44/0x70 [btrfs]
[ 4674.437254] Modules linked in: dm_thin_pool dm_persistent_data dm_bio_prison dm_flakey loop rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache rfkill rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi scsi_transport_iscsi ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib rdma_ucm ib_umad iTCO_wdt intel_pmc_bxt intel_rapl_msr iTCO_vendor_support dcdbas intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel ipmi_ssif kvm irqbypass rapl intel_cstate ipmi_si intel_uncore mei_me ipmi_devintf joydev mei lpc_ich ipmi_msghandler acpi_power_meter nvme_rdma nvme_fabrics rdma_cm iw_cm ib_cm rdmavt rdma_rxe nfsd ib_uverbs ip6_udp_tunnel udp_tunnel ib_core auth_rpcgss nfs_acl lockd grace nfs_ssc ip_tables xfs mgag200 drm_kms_helper crct10dif_pclmul crc32_pclmul cec crc32c_intel bnx2x nvme drm mpt3sas igb pcspkr ghash_clmulni_intel mdio megaraid_sas nvme_core dca raid_class i2c_algo_bit scsi_transport_sas wmi dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua btrfs xor
[ 4674.437303]  raid6_pq sunrpc i2c_dev [last unloaded: scsi_debug]
[ 4674.547845] CPU: 11 PID: 2022633 Comm: kworker/u96:7 Tainted: G        W         5.10.33-4.el7.x86_64 #1
[ 4674.559153] Hardware name: Dell Inc. PowerEdge T620/02CD1V, BIOS 2.9.0 12/06/2019
[ 4674.568280] Workqueue: btrfs-cache btrfs_work_helper [btrfs]
[ 4674.575343] RIP: 0010:extent_buffer_test_bit+0x44/0x70 [btrfs]
[ 4674.582554] Code: 49 89 f0 48 c1 ee 0c 48 8b 44 f7 70 41 81 e0 ff 0f 00 00 48 8b 70 08 48 8d 4e ff 83 e6 01 48 0f 44 c8 48 8b 09 83 e1 04 75 29 <0f> 0b 48 2b 05 e3 07 f2 d0 83 e2 07 48 c1 f8 06 89 d1 48 c1 e0 0c
[ 4674.604916] RSP: 0018:ffffa247a4c1fca8 EFLAGS: 00010246
[ 4674.611431] RAX: ffffea7584253b80 RBX: 0000000043e0b000 RCX: 0000000000000000
[ 4674.620097] RDX: 000000000000010b RSI: 0000000000000000 RDI: ffff8e920775a800
[ 4674.628785] RBP: ffff8e920775a800 R08: 0000000000000779 R09: ffff8e92522585a0
[ 4674.637387] R10: 0000000000000097 R11: 0000043e98db99be R12: 0000000043d00000
[ 4674.646031] R13: ffff8e9578e79400 R14: ffff8e9369847350 R15: ffff8e9369847310
[ 4674.654688] FS:  0000000000000000(0000) GS:ffff8ea1bf940000(0000) knlGS:0000000000000000
[ 4674.664371] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4674.671463] CR2: 00005642b0efa208 CR3: 00000013f1a10003 CR4: 00000000001706e0
[ 4674.680080] Call Trace:
[ 4674.683526]  free_space_test_bit.isra.11+0xac/0xf0 [btrfs]
[ 4674.690325]  load_free_space_tree+0x1f7/0x3f0 [btrfs]
[ 4674.696671]  caching_thread+0x374/0x500 [btrfs]
[ 4674.702352]  ? newidle_balance+0x265/0x3e0
[ 4674.707622]  btrfs_work_helper+0xc2/0x300 [btrfs]
[ 4674.713487]  process_one_work+0x1aa/0x340
[ 4674.718591]  worker_thread+0x30/0x390
[ 4674.723301]  ? create_worker+0x1a0/0x1a0
[ 4674.728313]  kthread+0x116/0x130
[ 4674.732549]  ? kthread_park+0x80/0x80
[ 4674.737237]  ret_from_fork+0x1f/0x30
[ 4674.741855] ---[ end trace 037def07c1124c76 ]---
[ 4674.747602] ------------[ cut here ]------------


fs/btrfs/extent_io.c:6409
int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
               unsigned long nr)
{
    u8 *kaddr;
    struct page *page;
    unsigned long i;
    size_t offset;

    eb_bitmap_offset(eb, start, nr, &i, &offset);
    page = eb->pages[i];
L6409:    WARN_ON(!PageUptodate(page));
    kaddr = page_address(page);
    return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
}

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/05/01


