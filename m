Return-Path: <linux-btrfs+bounces-10682-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CC89FF703
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 09:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC6C160471
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 08:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A39196DB1;
	Thu,  2 Jan 2025 08:40:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633C6FBF;
	Thu,  2 Jan 2025 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735807204; cv=none; b=SF8FkNkxauI+JtWhmTZoVuD+uqW1gyxqUTGnUiOE6pfmnHu/espjcYF0SRoELlzCdG/TP3tU/9JBk/BYB8Y2asuxwgc/mFMrBOKozmPR3T3cX5nbILsop3z26clIKpgpmZsGWFQCojz8YZLNVNuEoONFWpp7H5IJpNyAfhEaODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735807204; c=relaxed/simple;
	bh=1hMp2YOGnuuI822MDH1xEbWu2lp0buAwF+uoz+fpm5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTaV7nmYoMxG9siFlca2PWaXZfk98InQS9iJK0tQreD03QawE5yW3CT3RwJftdEfvMlUah3I+d5iruDEFmiNAA+nL16mU/5FCYzDzd+HIRq4+cYD7AqCsuN2+Zal7rILZagLDDi9GjqaYBZqMU4PCPBZ3yZ26sjdxkVWJwq/vu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5027nUVL001332;
	Thu, 2 Jan 2025 00:39:52 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43tdg7brcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 02 Jan 2025 00:39:51 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 2 Jan 2025 00:39:51 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 2 Jan 2025 00:39:49 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <quwenruo.btrfs@gmx.com>
CC: <clm@fb.com>, <dsterba@suse.com>, <josef@toxicpanda.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lizhi.xu@windriver.com>,
        <syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V3] btrfs: btrfs can not be mounted with corrupted extent root
Date: Thu, 2 Jan 2025 16:39:48 +0800
Message-ID: <20250102083948.181566-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <de8702eb-b800-48bb-ab56-ce4f048c755c@gmx.com>
References: <de8702eb-b800-48bb-ab56-ce4f048c755c@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: L8msXMtDj7zdW_sUvgRVMFbOFkqk9Bu-
X-Authority-Analysis: v=2.4 cv=AokU3P9P c=1 sm=1 tr=0 ts=677650d8 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VdSt8ZQiCzkA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=sQrxKanbwnIRMVMjfjoA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: L8msXMtDj7zdW_sUvgRVMFbOFkqk9Bu-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_02,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2501020073

syzbot reported a null-ptr-deref in find_first_extent_item. [1]

The btrfs filesystem did not successfully initialize extent root to the
global root tree when mounted(as the mount options contain ignorebadroots),
which causes the failure to read the tree root, which in turn causes extent
root to not be inserted into the global root tree.

To prevent this issue, if extent root is corrupt then exit the mount.

[1]
Unable to handle kernel paging request at virtual address dfff800000000041
KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000041] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6417 Comm: syz-executor153 Not tainted 6.13.0-rc3-syzkaller-g573067a5a685 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : find_first_extent_item+0xac/0x674 fs/btrfs/scrub.c:1375
lr : find_first_extent_item+0xa4/0x674 fs/btrfs/scrub.c:1374
sp : ffff8000a5be6e60
x29: ffff8000a5be6f80 x28: dfff800000000000 x27: 0000000000000000
x26: 0000000000400000 x25: 0000000000400000 x24: 1fffe0001848ab0a
x23: 0000000000000208 x22: ffff8000a5be6f20 x21: ffff0000c2455858
x20: ffff8000a5be6ec0 x19: ffff0000db072010 x18: ffff0000db072010
x17: 000000000000e32c x16: ffff80008b5fea08 x15: 0000000000000004
x14: 1fffe0001b60c031 x13: 0000000000000000 x12: ffff700014b7cdd8
x11: ffff80008257f234 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000041 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000008 x3 : 0000000000400000
x2 : 0000000000100000 x1 : ffff0000db072010 x0 : 0000000000000000
Call trace:
 find_first_extent_item+0xac/0x674 fs/btrfs/scrub.c:1375 (P)
 scrub_find_fill_first_stripe+0x2c0/0xab8 fs/btrfs/scrub.c:1551
 queue_scrub_stripe fs/btrfs/scrub.c:1921 [inline]
 scrub_simple_mirror+0x440/0x7e4 fs/btrfs/scrub.c:2152
 scrub_stripe+0x7e4/0x2174 fs/btrfs/scrub.c:2317
 scrub_chunk+0x268/0x41c fs/btrfs/scrub.c:2443
 scrub_enumerate_chunks+0xd38/0x1784 fs/btrfs/scrub.c:2707
 btrfs_scrub_dev+0x5a8/0xb34 fs/btrfs/scrub.c:3029
 btrfs_ioctl_scrub+0x1f4/0x3e8 fs/btrfs/ioctl.c:3248
 btrfs_ioctl+0x6a8/0xb04 fs/btrfs/ioctl.c:5246
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __arm64_sys_ioctl+0x14c/0x1cc fs/ioctl.c:892
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]

Fixes: 42437a6386ff ("btrfs: introduce mount option rescue=ignorebadroots")
Reported-by: syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=339e9dbe3a2ca419b85d
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 -> V2: exit mount when extent root is corrupt
V2 -> V3: correct comments and Fixes tag

 fs/btrfs/disk-io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index eff0dd1ae62f..beb236c7fe1c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2167,7 +2167,8 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 		found = true;
 		root = read_tree_root_path(tree_root, path, &key);
 		if (IS_ERR(root)) {
-			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
+			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS) ||
+			   objectid == BTRFS_EXTENT_TREE_OBJECTID)
 				ret = PTR_ERR(root);
 			break;
 		}
@@ -2188,7 +2189,8 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 		if (objectid == BTRFS_CSUM_TREE_OBJECTID)
 			set_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state);
 
-		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
+		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS) ||
+		   (ret && objectid == BTRFS_EXTENT_TREE_OBJECTID))
 			ret = ret ? ret : -ENOENT;
 		else
 			ret = 0;
-- 
2.43.0


