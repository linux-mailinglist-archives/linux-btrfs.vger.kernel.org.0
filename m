Return-Path: <linux-btrfs+bounces-10676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC90A9FF5E7
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 05:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04F21881E52
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 04:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E326F32C8B;
	Thu,  2 Jan 2025 04:06:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CEF7F9;
	Thu,  2 Jan 2025 04:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735790771; cv=none; b=IvBFcGeMOa8mhh9eUCLIluPLes8WbZzAWzZOMVos2oakONC3LVTLjhsE7TqiViAIVJ0wG4jJpq/0QTHN9vVQ/dq5VT759J7J3x5N793LRTVQiLkwSJoDdD1xlEELKfISnwmGswS7LrV0cus/GmvFLrNrGG5gXPkPGUtrFX5gr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735790771; c=relaxed/simple;
	bh=CfeK0U4w9p1UzqLCVNkT85sq+ZXld5K/QiS6I1O5uzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd6EqsLv29HRWfyktELYj49FGCwOVUeVgwpwiB/rthdb5mCDaHZ5JvZT+ym27VRjUaDR6ePNI/rx8kbZfZyhdhgr5yN1/kAZtfDRI6K82FcalKcQ/r8UH6h8MiZOGwqaWfZdyUtcRS7EorBYXdmbgf0v9TP7rYgIqOFxeZ1RG6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5023P2I2016942;
	Wed, 1 Jan 2025 20:06:01 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43thqq3ffh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 01 Jan 2025 20:06:01 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 1 Jan 2025 20:06:00 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 1 Jan 2025 20:05:58 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com>
CC: <clm@fb.com>, <dsterba@suse.com>, <josef@toxicpanda.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] btrfs: Prevent the use of invalid extent root
Date: Thu, 2 Jan 2025 12:05:58 +0800
Message-ID: <20250102040558.3339238-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67756935.050a0220.25abdd.0a12.GAE@google.com>
References: <67756935.050a0220.25abdd.0a12.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=RoI/LDmK c=1 sm=1 tr=0 ts=677610a9 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VdSt8ZQiCzkA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=qxYQtNXVLrngNQi_9kAA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: xHV9RDp81P7hUJWjckIc-JsFZPMwmR2t
X-Proofpoint-ORIG-GUID: xHV9RDp81P7hUJWjckIc-JsFZPMwmR2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_01,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 mlxlogscore=989 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2501020032

syzbot reported a null-ptr-deref in find_first_extent_item. [1]

The btrfs filesystem did not successfully initialize extent root to the 
global root tree when mounted, this is because extent buffer is not uptodate,
which causes the failure to read the tree root, which in turn causes extent
root to not be inserted into the global root tree.

To prevent this issue, add extent root check before using it.

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

Reported-by: syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=339e9dbe3a2ca419b85d
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/btrfs/scrub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 204c928beaf9..6080839cec95 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1372,10 +1372,14 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
 				  struct btrfs_path *path,
 				  u64 search_start, u64 search_len)
 {
-	struct btrfs_fs_info *fs_info = extent_root->fs_info;
+	struct btrfs_fs_info *fs_info;
 	struct btrfs_key key;
 	int ret;
 
+	if (!extent_root)
+		return -ENOENT;
+
+	fs_info = extent_root->fs_info;
 	/* Continue using the existing path */
 	if (path->nodes[0])
 		goto search_forward;
-- 
2.43.0


