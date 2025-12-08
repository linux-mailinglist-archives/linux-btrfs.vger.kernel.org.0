Return-Path: <linux-btrfs+bounces-19561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 628E5CACF33
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 12:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A02A3017841
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 11:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5895313279;
	Mon,  8 Dec 2025 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="an092luI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A23128C9;
	Mon,  8 Dec 2025 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765191946; cv=none; b=FRa93V6QFD2ukvL2KUr+meqfMPMr1KLN09F14men4h2/BXAph/YNbZnK2IpCIJKwIZnLVeguZ8wue/iWgL6B8KPnQy5sRXJzz1aHNOVshHDO0RwHzbfkGpFCB+MLeZ6HDJ1AurycuGeSwg6oGuSjGCDOR0DqhKW/lSmBPlILWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765191946; c=relaxed/simple;
	bh=24oq/abDmr2j7N6dcDSRqRDGAa1kZKqYHrC9eGDtyp8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Tm3+FhQXYInrC81N4cNE/qMO1l5YgKAHf/rlJSLirQE1ttSimx8Kv+9Y7TsMCotSZbG/W6Lw4FVoZjtWX7zHCR0QaGYrmto+Tpo4CFi41Eu50DIj2kh/eUGeUJR3m+sU9vZpTWZeO9Gh/dSc9C9IvbWcNo9PAXtQkmtrgX7wvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=an092luI; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1765191930; bh=wMvx19vJI1RxYB9avH18Q90mZsemEo3rPfpApitslBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=an092luIe5lXSiW0vO6FNCvFdBxBnCG9sb8Q+hFY4XV3wgOq93j6/vw4nLgm6IAOr
	 v5GsSsEdxTqWp7eXKqlHM3e9Q/GGVWtnygkrsyiJHecHF1mZ5K9MR7diDtgkJjc86w
	 JP38guGboRJE7xoTLMo83DLIA58L3EBm8uSCl+ew=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 15A86A7A; Mon, 08 Dec 2025 19:05:26 +0800
X-QQ-mid: xmsmtpt1765191926tyr2219d5
Message-ID: <tencent_0974B3778967163D1736C0971436F24B5C09@qq.com>
X-QQ-XMAILINFO: M7zNVLTahEeK87eS38fFB2d9wTa14j646hOEFby0VVjHJiKMR2fikZKgf6PRar
	 UBBlFgyVlIyZcbVLJQyLDbKB5K5f2juUKaxX4L0R3plB3aeZeHMNekPcwtiWyTeViCgYEvBHQSLU
	 Kx3LA/FKfaM1X2DfpOvNzZJ9VQ1FcsAvVZtcQhkSths/YgGFVc7bioJqE0gMmt850kmt6j6LCye6
	 puoF6T+zflrJgDrOlI2pUe7lUpi8tcWXui01i/iherXN5noIvZItJIBxYwRNfowBQPgmKHa+drV6
	 aAqP/l0nW340glLSNd3Yp+Cyi7hwsR8R9d6rE968HwIfJ3lBXLLswkHkaUSz4PaBiMfjewUV+Ivr
	 MTlgCLvN2OCyElFw1GGTH+FXMYt74kcr9IA4N96NEJ+u22CEf9Ki5HOqjaIsUsVQmI5Elczoz+VZ
	 xbeca8yC4kAV6n21wXMGAKiD0iLXietfqi2r4/KcYrdem2dKuiDRJbj1+cuy1BJTB3XNOnlW3f0K
	 p+KwB+DsRWp/IjmJMZOhy7EvypvyjJ9MoDMlWHGZD/NIOMrkaBkM0I+3VDZ673vs75CoCbf+MLSR
	 l0S0iRbLXbsQgG0GqlvSVr6X7q/o4ejiS2tqs0Ci7glUdYA7S8hD8rWHIJrhxCkoKtMydk2XsUiD
	 mSbewpe0b/qGZo8YlZOOIat/qzus9dTCYJPiAqjLNbydQijLWuBXTv98tKer/+TIidJsa7OFjypU
	 6keLulZ9sTVr64csduGGWGZI08c7vh6Z0axmN3H3s2YNe5IVncqXi3X2il94cNE3d+uMrD8l+FFO
	 2/OhBw49ous1cbSvArcnjtqtEpJAQ7uC/rrUjKge2pyz9jycMaMxMfxPVl9nkvhGvmo+yLWvhzKZ
	 rpklBEpi+LqldCBtKy57PRb4bUBIK1MGVbHCJ5O9OmQKqPF041bleGDqGDm8nGkic+5BCs+Mj3KX
	 gkHftwU3/24Qq7qNQiX2GdKe9KB7sA4WTJ2Vkpnmpikquh5Wpv3UFLADdXGadGwPH/WP2WGSYq/N
	 2GwW+pgw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b44d4a4885bc82af2a06@syzkaller.appspotmail.com
Cc: clm@fb.com,
	dsterba@suse.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] btrfs: Optimize the timing of prealloc memory allocation
Date: Mon,  8 Dec 2025 19:05:26 +0800
X-OQ-MSGID: <20251208110525.483918-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <693683ba.a70a0220.38f243.0091.GAE@google.com>
References: <693683ba.a70a0220.38f243.0091.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Too many abnormal exits can cause the prealloc assertion to fail, as
reported by syzbot in [1].

Move the prealloc memory allocation to before it is actually used.

[1]
assertion failed: prealloc == NULL :: 0, in fs/btrfs/qgroup.c:3529
kernel BUG at fs/btrfs/qgroup.c:3529!
Call Trace:
 <TASK>
 create_subvol+0x5ad/0x18f0 fs/btrfs/ioctl.c:570
 btrfs_mksubvol+0x6e4/0x12c0 fs/btrfs/ioctl.c:928
 __btrfs_ioctl_snap_create+0x2b2/0x730 fs/btrfs/ioctl.c:1201
 btrfs_ioctl_snap_create+0x131/0x180 fs/btrfs/ioctl.c:1259
 btrfs_ioctl+0xb4d/0xd00 fs/btrfs/ioctl.c:-1

Fixes: 252877a87015 ("btrfs: add ASSERTs on prealloc in qgroup functions")
Reported-by: syzbot+b44d4a4885bc82af2a06@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b44d4a4885bc82af2a06
Tested-by: syzbot+b44d4a4885bc82af2a06@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/btrfs/qgroup.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9e2b53e90dcb..ac5380520152 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3289,10 +3289,6 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	if (!btrfs_qgroup_enabled(fs_info))
 		return 0;
 
-	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
-	if (!prealloc)
-		return -ENOMEM;
-
 	/*
 	 * There are only two callers of this function.
 	 *
@@ -3388,6 +3384,12 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		}
 	}
 
+	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
+	if (!prealloc) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	spin_lock(&fs_info->qgroup_lock);
 
 	dstgroup = add_qgroup_rb(fs_info, prealloc, objectid);
-- 
2.43.0


