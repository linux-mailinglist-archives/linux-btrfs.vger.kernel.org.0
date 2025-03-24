Return-Path: <linux-btrfs+bounces-12510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F867A6D528
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 08:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1227A165900
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 07:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39F22512E6;
	Mon, 24 Mar 2025 07:35:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E48250BF0;
	Mon, 24 Mar 2025 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801709; cv=none; b=KsnXPO5iatWhSrtHbcfVFzmrLFvFGxNXH8TEEmAHyFAhil2cofpkleftxlHeRgrkfOTsEY4weOBzecFtq3m+OvyjIc7NciycjQqU+OGEVr4kLOtHP07Jhn1GrsoJvxS35Q/XzZ5HTPw/bdrrFKzCR9vdxICe07kmCSXGnUAOEUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801709; c=relaxed/simple;
	bh=kNdkIG9UPAH3v2U1o048RTeCISVVguBVoM06LHnz1Ds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g5kpUmyvsyykNfuC2UQHzLFnbdRvqfGzwL7rNKL0lWNo2yf70LJVBok8JenV6175KyCcTkmNxMluYMdVvUjiszF+TEyj9z6iRF9uSUjHryse+PlFLs50H99UxBPSQW+6awq6ovDIKX5F7TNGgaqO7dM3SzFPrw1N3k8WsfiVTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O60OUf018528;
	Mon, 24 Mar 2025 00:34:59 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hrg41mrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 24 Mar 2025 00:34:58 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 24 Mar 2025 00:34:57 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 24 Mar 2025 00:34:55 -0700
From: <jianqi.ren.cn@windriver.com>
To: <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <jianqi.ren.cn@windriver.com>,
        <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <llfamsec@gmail.com>, <wqu@suse.com>
Subject: [PATCH 6.6.y] btrfs: make sure that WRITTEN is set on all metadata blocks
Date: Mon, 24 Mar 2025 15:34:54 +0800
Message-ID: <20250324073454.3796450-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=HZwUTjE8 c=1 sm=1 tr=0 ts=67e10b22 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=gEA-OUY-moF3Uf1y:21 a=Vs1iUdzkB0EA:10 a=maIFttP_AAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=t7CeM3EgAAAA:8 a=xqbIuppjPMaPyYIW3jgA:9 a=qR24C9TJY6iBuJVj_x8Y:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: XKmDfec6X6tV-aNjrxe3Hfm0-dMsJgX6
X-Proofpoint-ORIG-GUID: XKmDfec6X6tV-aNjrxe3Hfm0-dMsJgX6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240054

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit e03418abde871314e1a3a550f4c8afb7b89cb273 ]

We previously would call btrfs_check_leaf() if we had the check
integrity code enabled, which meant that we could only run the extended
leaf checks if we had WRITTEN set on the header flags.

This leaves a gap in our checking, because we could end up with
corruption on disk where WRITTEN isn't set on the leaf, and then the
extended leaf checks don't get run which we rely on to validate all of
the item pointers to make sure we don't access memory outside of the
extent buffer.

However, since 732fab95abe2 ("btrfs: check-integrity: remove
CONFIG_BTRFS_FS_CHECK_INTEGRITY option") we no longer call
btrfs_check_leaf() from btrfs_mark_buffer_dirty(), which means we only
ever call it on blocks that are being written out, and thus have WRITTEN
set, or that are being read in, which should have WRITTEN set.

Add checks to make sure we have WRITTEN set appropriately, and then make
sure __btrfs_check_leaf() always does the item checking.  This will
protect us from file systems that have been corrupted and no longer have
WRITTEN set on some of the blocks.

This was hit on a crafted image tweaking the WRITTEN bit and reported by
KASAN as out-of-bound access in the eb accessors. The example is a dir
item at the end of an eb.

  [2.042] BTRFS warning (device loop1): bad eb member start: ptr 0x3fff start 30572544 member offset 16410 size 2
  [2.040] general protection fault, probably for non-canonical address 0xe0009d1000000003: 0000 [#1] PREEMPT SMP KASAN NOPTI
  [2.537] KASAN: maybe wild-memory-access in range [0x0005088000000018-0x000508800000001f]
  [2.729] CPU: 0 PID: 2587 Comm: mount Not tainted 6.8.2 #1
  [2.729] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  [2.621] RIP: 0010:btrfs_get_16+0x34b/0x6d0
  [2.621] RSP: 0018:ffff88810871fab8 EFLAGS: 00000206
  [2.621] RAX: 0000a11000000003 RBX: ffff888104ff8720 RCX: ffff88811b2288c0
  [2.621] RDX: dffffc0000000000 RSI: ffffffff81dd8aca RDI: ffff88810871f748
  [2.621] RBP: 000000000000401a R08: 0000000000000001 R09: ffffed10210e3ee9
  [2.621] R10: ffff88810871f74f R11: 205d323430333737 R12: 000000000000001a
  [2.621] R13: 000508800000001a R14: 1ffff110210e3f5d R15: ffffffff850011e8
  [2.621] FS:  00007f56ea275840(0000) GS:ffff88811b200000(0000) knlGS:0000000000000000
  [2.621] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [2.621] CR2: 00007febd13b75c0 CR3: 000000010bb50000 CR4: 00000000000006f0
  [2.621] Call Trace:
  [2.621]  <TASK>
  [2.621]  ? show_regs+0x74/0x80
  [2.621]  ? die_addr+0x46/0xc0
  [2.621]  ? exc_general_protection+0x161/0x2a0
  [2.621]  ? asm_exc_general_protection+0x26/0x30
  [2.621]  ? btrfs_get_16+0x33a/0x6d0
  [2.621]  ? btrfs_get_16+0x34b/0x6d0
  [2.621]  ? btrfs_get_16+0x33a/0x6d0
  [2.621]  ? __pfx_btrfs_get_16+0x10/0x10
  [2.621]  ? __pfx_mutex_unlock+0x10/0x10
  [2.621]  btrfs_match_dir_item_name+0x101/0x1a0
  [2.621]  btrfs_lookup_dir_item+0x1f3/0x280
  [2.621]  ? __pfx_btrfs_lookup_dir_item+0x10/0x10
  [2.621]  btrfs_get_tree+0xd25/0x1910

Reported-by: lei lu <llfamsec@gmail.com>
CC: stable@vger.kernel.org # 6.7+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ copy more details from report ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test
---
 fs/btrfs/tree-checker.c | 30 +++++++++++++++---------------
 fs/btrfs/tree-checker.h |  1 +
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 53c74010140e..6d16506bbdc0 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1889,6 +1889,11 @@ enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf)
 		return BTRFS_TREE_BLOCK_INVALID_LEVEL;
 	}
 
+	if (unlikely(!btrfs_header_flag(leaf, BTRFS_HEADER_FLAG_WRITTEN))) {
+		generic_err(leaf, 0, "invalid flag for leaf, WRITTEN not set");
+		return BTRFS_TREE_BLOCK_WRITTEN_NOT_SET;
+	}
+
 	/*
 	 * Extent buffers from a relocation tree have a owner field that
 	 * corresponds to the subvolume tree they are based on. So just from an
@@ -1950,6 +1955,7 @@ enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf)
 	for (slot = 0; slot < nritems; slot++) {
 		u32 item_end_expected;
 		u64 item_data_end;
+		enum btrfs_tree_block_status ret;
 
 		btrfs_item_key_to_cpu(leaf, &key, slot);
 
@@ -2005,21 +2011,10 @@ enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf)
 			return BTRFS_TREE_BLOCK_INVALID_OFFSETS;
 		}
 
-		/*
-		 * We only want to do this if WRITTEN is set, otherwise the leaf
-		 * may be in some intermediate state and won't appear valid.
-		 */
-		if (btrfs_header_flag(leaf, BTRFS_HEADER_FLAG_WRITTEN)) {
-			enum btrfs_tree_block_status ret;
-
-			/*
-			 * Check if the item size and content meet other
-			 * criteria
-			 */
-			ret = check_leaf_item(leaf, &key, slot, &prev_key);
-			if (unlikely(ret != BTRFS_TREE_BLOCK_CLEAN))
-				return ret;
-		}
+		/* Check if the item size and content meet other criteria. */
+		ret = check_leaf_item(leaf, &key, slot, &prev_key);
+		if (unlikely(ret != BTRFS_TREE_BLOCK_CLEAN))
+			return ret;
 
 		prev_key.objectid = key.objectid;
 		prev_key.type = key.type;
@@ -2049,6 +2044,11 @@ enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node)
 	int level = btrfs_header_level(node);
 	u64 bytenr;
 
+	if (unlikely(!btrfs_header_flag(node, BTRFS_HEADER_FLAG_WRITTEN))) {
+		generic_err(node, 0, "invalid flag for node, WRITTEN not set");
+		return BTRFS_TREE_BLOCK_WRITTEN_NOT_SET;
+	}
+
 	if (unlikely(level <= 0 || level >= BTRFS_MAX_LEVEL)) {
 		generic_err(node, 0,
 			"invalid level for node, have %d expect [1, %d]",
diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index 3c2a02a72f64..43f2ceb78f34 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -51,6 +51,7 @@ enum btrfs_tree_block_status {
 	BTRFS_TREE_BLOCK_INVALID_BLOCKPTR,
 	BTRFS_TREE_BLOCK_INVALID_ITEM,
 	BTRFS_TREE_BLOCK_INVALID_OWNER,
+	BTRFS_TREE_BLOCK_WRITTEN_NOT_SET,
 };
 
 /*
-- 
2.25.1


