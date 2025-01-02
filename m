Return-Path: <linux-btrfs+bounces-10683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F949FF739
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 10:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADA2162029
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39053199237;
	Thu,  2 Jan 2025 09:05:20 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18F1922F5;
	Thu,  2 Jan 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735808719; cv=none; b=f77YWSdJmf4ZHSrn9v+CsbvnVpxFIrab/BFJNuH6StXEnITlCsm6wc4fz258FnkKLDYmR89IDbP/wR9dtJhdZLNFkEPwbT7H2EtNPFIbuIv0FcfityRLLde3oMTuVlIWqT66i3Q3A0ZAOe7KqCdLoZPYkRzlLekie38R1eTu26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735808719; c=relaxed/simple;
	bh=lLkHW+Uz2woP6zj4gYzmVLkJBkWmUoR2PiBfWrInx2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8IqJdGG2zlKEKXoAgRzQLYkaNVtvWdWYjsTCbWQt89KM5ssnA8Mmm+BM8B5jsoCdMDh2OvaDD8im3+8ZXzMPcWOaHBpSc+NY7D/9P93+5iE3Fm1sul6h3mvdGWO9wRKdeD+GF0ClRVviVArqVi7COLxr2cGDv7GkLRZPOEUG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5028g8xX027745;
	Thu, 2 Jan 2025 09:05:07 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43t8a83vn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 02 Jan 2025 09:05:06 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 2 Jan 2025 01:05:05 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 2 Jan 2025 01:05:03 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <lizhi.xu@windriver.com>
CC: <clm@fb.com>, <dsterba@suse.com>, <josef@toxicpanda.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quwenruo.btrfs@gmx.com>,
        <syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V4] btrfs: Prevent the use of corrupt extent root
Date: Thu, 2 Jan 2025 17:05:02 +0800
Message-ID: <20250102090502.218613-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102083948.181566-1-lizhi.xu@windriver.com>
References: <20250102083948.181566-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4EyPpFLX9s-RlSVDh_DO9AHnCGfYcsR0
X-Proofpoint-ORIG-GUID: 4EyPpFLX9s-RlSVDh_DO9AHnCGfYcsR0
X-Authority-Analysis: v=2.4 cv=f8qyBPyM c=1 sm=1 tr=0 ts=677656c2 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VdSt8ZQiCzkA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=FXPXl8PBpE8CVprqC9UA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_02,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2501020077

syzbot reported a null-ptr-deref in find_first_extent_item. [1]

The btrfs filesystem did not successfully initialize extent root to the
global root tree when mounted, since the mount options contain ignorebadroots,
because commit 42437a6386ff, it can be mounted successfully, which causes
the failure to read the tree root, which in turn causes exten root to not
be inserted into the global root tree.

Add a extent root check when scrub calls scrub_find_fill_first_stripe.

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
V3 -> V4: check extent root before calling find_first_extent_item 

 fs/btrfs/scrub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 204c928beaf9..560415fe1007 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1548,6 +1548,9 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	/* The range must be inside the bg. */
 	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length);
 
+	if (!extent_root)
+		return -ENOENT;
+
 	ret = find_first_extent_item(extent_root, extent_path, logical_start,
 				     logical_len);
 	/* Either error or not found. */
-- 
2.43.0


