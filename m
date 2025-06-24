Return-Path: <linux-btrfs+bounces-14915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BABAE69A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 16:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10131882A2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945252D4B7C;
	Tue, 24 Jun 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kOZAN9rz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1392D23B8;
	Tue, 24 Jun 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775731; cv=none; b=uniD5J4EVEAfE6vj06nb7eMjRNMbkstx+8B/C4TURmM/cebAHyg0Qo+WQQpjsYh7UIbzVe9Jeo2NQ2Z9PLeBEOIeuhbaFgE4nj1A5dZm8n2AnugiWsIGdUoYWdBA7WhGxPxXXmtPs1iDCW5itr7nXi6YOHxblP47Yv35RMxBVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775731; c=relaxed/simple;
	bh=XWUoSHK9ZFJwMOXvEylhqSbkKPrkssdXq5HfgyRyxVU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oSsvXiXNS/3RYABCdI5xjwNHYEhUIjAECDOKCegzNt/nAJuAxQxbmEXoDny0jsbI7Qy1zVkqm2UKQW0wa2tv36BnJgpHTCcndKbR84KwXWXfD77o4q0ZShEL36KmvhcdJtmLwSyxbRDLJuAbDCCatuPvoG3u/6hqooVvbJiTgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kOZAN9rz; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1750775422; bh=WzKuairL6klH+H3Pk4Z77kBpxk6VjGhy/vtLbAwqk5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kOZAN9rzKb1q9tF3m9+4tgSWGTydQYU7tqSKNjd8QI5toYZBZXpCMs+yLA/jrGFWz
	 MztBaNrGn4q8RGvK4URp+blG7wJJa6rmSmb9KAa5lprZ+fxfm+F1IWS4fBYbofnGM1
	 3n1eVUXGYwc1ZtWplOyca7bJ4Rh6gPHC7UZuv0o0=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 7922C4AA; Tue, 24 Jun 2025 22:30:18 +0800
X-QQ-mid: xmsmtpt1750775418tjjf65ee2
Message-ID: <tencent_C857B761776286CB137A836B096C03A34405@qq.com>
X-QQ-XMAILINFO: N+vldBj843eNUXLV7XGtfaVgQimuVCxUrR6sPDEC+V9drvLoQjxq8Pv10JL9qj
	 QWzIDij1izxZ3rRoaZUVLlAyN78/87L7WCOVeezIiR9vKaFN4jYeNutAnPJxqdfFSlooFVszfigi
	 2iuCejs/o3458aXvQPAxDSMAsUQzall0XG7XUDmTSkSeyEUWm0/4D8hn5g/NbyTwTezC67hKjr9r
	 nRNb4JowPS/u7WJ/YFK84gsTtPSm6U526ThhyJV6twb38qd1iaeIfi0DzzQm1MYiY3EOTm/DKivB
	 UGJahcbWwZ9oPBC2RW6WRGFj45SdSfeMVFtv23iO5vzSYjujgKTM+IhOQcuv67Gd62jsCUmlCdxM
	 q1PmxA1WYrnbXnklyLrCHM55rxP07C0ZZjJvUxcmIl5Xf6eZsK4/NFTgTQq/QDrSyaHOINRAFAQs
	 7fQ4m1iFCQPlfS1UdA2mfSTO7yDXfqYrYD4Rtild/wxcji8mlGccDglqHvNvKjD+J73syu8NQquj
	 yijzY8Jd1ccEryqr6g+lmJ3e349WLTXVvMTwKem93BS5g/dqa6zy2Y6E+wYxOMKbV1WNSvngSjdv
	 vE8cLw2b2zrDPbA8klrDw1b5MegVOC2qAoxCwV+Dzx1Ww4aebWsxpMPrYCPPQD4e3XInI64RUtOE
	 Iu4n+CzWJ4Z5pmf8e3p90k1KJwrZwv6lFijBKGqQUzIlq2bTc5bAllVwAKKDpDvJ8voFm1GivxZH
	 BfskME/+hrVx3S9rD8S+TYMu70w4Wf4rCXt/9X1P1pxTKkue5D7ikiqtxqtn6Kd7W2WAQSbiEGel
	 bhTYNbsIz9eMc571bglMHK2dPuvJIN75KiXtQIdlp8lYwbN4xM8h+jOskOWYcjvCInaztB4FBdIA
	 LSG5+RFEotLgRjBO4lL2pdTcb7MplQauzOrBwOFcFSbycHlA8OzS4HlYJv72PNFoq1rxOrpSVp0S
	 I9xgWT0/rkfJOk7l0DslLYiCnEuTySlS1hsWaa8ctNZpVsXNayHr1KhosOUgeCh9bqpHRcYPZDNF
	 onVL95pQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com
Cc: clm@fb.com,
	dsterba@suse.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	wqu@suse.com
Subject: [PATCH next] btrfs: fix deadlock in btrfs_read_chunk_tree
Date: Tue, 24 Jun 2025 22:30:12 +0800
X-OQ-MSGID: <20250624143011.327069-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <685aa401.050a0220.2303ee.0009.GAE@google.com>
References: <685aa401.050a0220.2303ee.0009.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the lock uuid_mutex outside of sget_fc() to avoid the deadlock
reported by [1].

[1]
-> #1 (&type->s_umount_key#41/1){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       down_write_nested+0x9d/0x200 kernel/locking/rwsem.c:1693
       alloc_super+0x204/0x970 fs/super.c:345
       sget_fc+0x329/0xa40 fs/super.c:761
       btrfs_get_tree_super fs/btrfs/super.c:1867 [inline]
       btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
       btrfs_get_tree+0x4c6/0x12d0 fs/btrfs/super.c:2093
       vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
       do_new_mount+0x24a/0xa40 fs/namespace.c:3902
       do_mount fs/namespace.c:4239 [inline]
       __do_sys_mount fs/namespace.c:4450 [inline]
       __se_sys_mount+0x317/0x410 fs/namespace.c:4427
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (uuid_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
       btrfs_read_chunk_tree+0xef/0x2170 fs/btrfs/volumes.c:7462
       open_ctree+0x17f2/0x3a10 fs/btrfs/disk-io.c:3458
       btrfs_fill_super fs/btrfs/super.c:984 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1922 [inline]
       btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
       btrfs_get_tree+0xc6f/0x12d0 fs/btrfs/super.c:2093
       vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
       do_new_mount+0x24a/0xa40 fs/namespace.c:3902
       do_mount fs/namespace.c:4239 [inline]
       __do_sys_mount fs/namespace.c:4450 [inline]
       __se_sys_mount+0x317/0x410 fs/namespace.c:4427
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->s_umount_key#41/1);
                               lock(uuid_mutex);
                               lock(&type->s_umount_key#41/1);
  lock(uuid_mutex);

 *** DEADLOCK ***

Fixes: 7aacdf6feed1 ("btrfs: delay btrfs_open_devices() until super block is created")
Reported-by: syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa90fcaa28f5cd4b1fc1
Tested-by: syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/btrfs/super.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 237e60b53192..c2ce1eb53ad7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1864,11 +1864,10 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	fs_devices = device->fs_devices;
 	fs_info->fs_devices = fs_devices;
 
+	mutex_unlock(&uuid_mutex);
 	sb = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
-	if (IS_ERR(sb)) {
-		mutex_unlock(&uuid_mutex);
+	if (IS_ERR(sb))
 		return PTR_ERR(sb);
-	}
 
 	set_device_specific_options(fs_info);
 
@@ -1887,6 +1886,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 * But the fs_info->fs_devices is not opened, we should not let
 		 * btrfs_free_fs_context() to close them.
 		 */
+		mutex_lock(&uuid_mutex);
 		fs_info->fs_devices = NULL;
 		mutex_unlock(&uuid_mutex);
 
@@ -1906,6 +1906,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 */
 		ASSERT(fc->s_fs_info == NULL);
 
+		mutex_lock(&uuid_mutex);
 		ret = btrfs_open_devices(fs_devices, mode, sb);
 		mutex_unlock(&uuid_mutex);
 		if (ret < 0) {
-- 
2.43.0


