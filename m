Return-Path: <linux-btrfs+bounces-13023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81D0A89384
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 07:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA95C16DE39
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 05:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4079C274648;
	Tue, 15 Apr 2025 05:51:41 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6D2DFA3B;
	Tue, 15 Apr 2025 05:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744696300; cv=none; b=QXewIDYgo/BSZ4OiibWx6cnh1mqmxinnABTJSU2V5/RApBhE6x7ArU+QA5aJ+aDulH1A+O45M1l21ExAKMEX7E8PrUHv1JeTbojhO9vzQRbwlH7PiytAYtlIgpuKvASB5x51LTb071v3ZiHn2YMmzHKQ54+Co/DL/1s0FrHaVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744696300; c=relaxed/simple;
	bh=AJ999c1D441C8UFFblcx+0Neha6Iw51QzretZKKKXIM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MR9WhoCBiNz2PhcE6zhAt0tBMFJHj3a/4yLhicZTe0CHqHg19GMABJnldhHAgP2nnQZSY0wPEt4iPCT4ICjGJwgq5a/eGm7O+iGGI3kFv5W2sUPAC1UC7xbv+fCKnyUuoLwThASYbQZ0XuDvy4BM1hGacYsSrKwOreSxTjijAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F3RuFo029893;
	Mon, 14 Apr 2025 22:51:28 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ykf3jrfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Apr 2025 22:51:28 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 14 Apr 2025 22:51:27 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 14 Apr 2025 22:51:24 -0700
From: <jianqi.ren.cn@windriver.com>
To: <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <jianqi.ren.cn@windriver.com>,
        <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <terrelln@fb.com>, <linux-btrfs@vger.kernel.org>, <wqu@suse.com>,
        <boris@bur.io>
Subject: [PATCH 6.6.y] btrfs: fix qgroup reserve leaks in cow_file_range
Date: Tue, 15 Apr 2025 13:51:23 +0800
Message-ID: <20250415055123.3683832-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: quG9Gffnetfmx-6X2hzqefuMn5H3DPvw
X-Authority-Analysis: v=2.4 cv=Wd0Ma1hX c=1 sm=1 tr=0 ts=67fdf3e0 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=XR8D0OoHHMoA:10 a=iox4zFpeAAAA:8 a=t7CeM3EgAAAA:8 a=oSb3yfUiBPKWAvThIHwA:9 a=WzC6qhA0u3u7Ye7llzcV:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: quG9Gffnetfmx-6X2hzqefuMn5H3DPvw
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxlogscore=775 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504150038

From: Boris Burkov <boris@bur.io>

[ Upstream commit 30479f31d44d47ed00ae0c7453d9b253537005b2 ]

In the buffered write path, the dirty page owns the qgroup reserve until
it creates an ordered_extent.

Therefore, any errors that occur before the ordered_extent is created
must free that reservation, or else the space is leaked. The fstest
generic/475 exercises various IO error paths, and is able to trigger
errors in cow_file_range where we fail to get to allocating the ordered
extent. Note that because we *do* clear delalloc, we are likely to
remove the inode from the delalloc list, so the inodes/pages to not have
invalidate/launder called on them in the commit abort path.

This results in failures at the unmount stage of the test that look like:

  BTRFS: error (device dm-8 state EA) in cleanup_transaction:2018: errno=-5 IO failure
  BTRFS: error (device dm-8 state EA) in btrfs_replace_file_extents:2416: errno=-5 IO failure
  BTRFS warning (device dm-8 state EA): qgroup 0/5 has unreleased space, type 0 rsv 28672
  ------------[ cut here ]------------
  WARNING: CPU: 3 PID: 22588 at fs/btrfs/disk-io.c:4333 close_ctree+0x222/0x4d0 [btrfs]
  Modules linked in: btrfs blake2b_generic libcrc32c xor zstd_compress raid6_pq
  CPU: 3 PID: 22588 Comm: umount Kdump: loaded Tainted: G W          6.10.0-rc7-gab56fde445b8 #21
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
  RIP: 0010:close_ctree+0x222/0x4d0 [btrfs]
  RSP: 0018:ffffb4465283be00 EFLAGS: 00010202
  RAX: 0000000000000001 RBX: ffffa1a1818e1000 RCX: 0000000000000001
  RDX: 0000000000000000 RSI: ffffb4465283bbe0 RDI: ffffa1a19374fcb8
  RBP: ffffa1a1818e13c0 R08: 0000000100028b16 R09: 0000000000000000
  R10: 0000000000000003 R11: 0000000000000003 R12: ffffa1a18ad7972c
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  FS:  00007f9168312b80(0000) GS:ffffa1a4afcc0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f91683c9140 CR3: 000000010acaa000 CR4: 00000000000006f0
  Call Trace:
   <TASK>
   ? close_ctree+0x222/0x4d0 [btrfs]
   ? __warn.cold+0x8e/0xea
   ? close_ctree+0x222/0x4d0 [btrfs]
   ? report_bug+0xff/0x140
   ? handle_bug+0x3b/0x70
   ? exc_invalid_op+0x17/0x70
   ? asm_exc_invalid_op+0x1a/0x20
   ? close_ctree+0x222/0x4d0 [btrfs]
   generic_shutdown_super+0x70/0x160
   kill_anon_super+0x11/0x40
   btrfs_kill_super+0x11/0x20 [btrfs]
   deactivate_locked_super+0x2e/0xa0
   cleanup_mnt+0xb5/0x150
   task_work_run+0x57/0x80
   syscall_exit_to_user_mode+0x121/0x130
   do_syscall_64+0xab/0x1a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f916847a887
  ---[ end trace 0000000000000000 ]---
  BTRFS error (device dm-8 state EA): qgroup reserved space leaked

Cases 2 and 3 in the out_reserve path both pertain to this type of leak
and must free the reserved qgroup data. Because it is already an error
path, I opted not to handle the possible errors in
btrfs_free_qgroup_data.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
[Minor conflict resolved due to code context change.]
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test
---
 fs/btrfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cedffa567a75..fc127182067b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1546,6 +1546,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 					     locked_page,
 					     clear_bits,
 					     page_ops);
+		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
 		start += cur_alloc_size;
 	}
 
@@ -1559,6 +1560,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		clear_bits |= EXTENT_CLEAR_DATA_RESV;
 		extent_clear_unlock_delalloc(inode, start, end, locked_page,
 					     clear_bits, page_ops);
+		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
 	}
 	return ret;
 }
@@ -2222,13 +2224,15 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 */
 	if (cow_start != (u64)-1)
 		cur_offset = cow_start;
-	if (cur_offset < end)
+	if (cur_offset < end) {
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC | EXTENT_DEFRAG |
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
 					     PAGE_START_WRITEBACK |
 					     PAGE_END_WRITEBACK);
+		btrfs_qgroup_free_data(inode, NULL, cur_offset, end - cur_offset + 1, NULL);
+	}
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.34.1


