Return-Path: <linux-btrfs+bounces-18900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E5C54110
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C61C6347090
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E7E34DB68;
	Wed, 12 Nov 2025 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="rwGqUiyo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="D6+zALl1";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="lp3AFDfG";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="YqTiiJ/D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender5.mail.selcloud.ru (sender5.mail.selcloud.ru [5.8.75.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3234CFC7;
	Wed, 12 Nov 2025 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974473; cv=none; b=tkAMoQLmB4fV/HAp2wWAgUHV/z6kWZIMK7qrkhQ7fBACaYb/c6xaPNQ0qO4pdtD3DC2fHj4srR3+i84CnIsHOIBVCry0x5IPuqe0GS1yudp2Dzyl0bd1Fct0iWg+yIPmCnTjy+Df/1Jyv/f91fBVwIIV0fFLbIcYSPnFtNZ74ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974473; c=relaxed/simple;
	bh=/8NP+cn6CMnb3MgbdAiFJH1QRsNs+3tMSoD4DezBpr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbWEokKlUSLu962D7mjxscRH9yi6Y87Llf9icaQcK2AMfOZUXPRI60KGy2mxRoTFdmwZJgj7twVTd/x6CCiacR5Zkd8gyEji//GbSMNcCnr+tE+bDCoYd2GQKIT7dArV6AXj7gqt01iEr+Ve/XpZew0ZAKeBvjl71lxiAKxSNvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=rwGqUiyo; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=D6+zALl1; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=lp3AFDfG; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=YqTiiJ/D; arc=none smtp.client-ip=5.8.75.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:List-id:
	List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LLj21esqm3R2LJZDtbLCVJhszRnRQfTTEwvoExcwbOk=; t=1762974469; x=1763147269;
	 b=rwGqUiyopWuh+6k70n4AS1LBR4DqF//7tBhxNiKeK8qa3yC3pj1/PbyVE9EfN3uiohWEm5WY3Z
	bV8Mv9GSR2gc7+t94ZSIMeyFG5KC04lBEf0NYWJFrGHK60Ka6v4ui0zKcM8bTFEYYRSCak7hjjBAd
	kwSLH31+qK0wa7GVUBtk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LLj21esqm3R2LJZDtbLCVJhszRnRQfTTEwvoExcwbOk=; t=1762974469; x=1763147269;
	 b=D6+zALl1Bh6OAgMr0Ya2bQKT5P+S1I9pqZ9NLM0P2zpAQknku7TTXKbaq0s7bXBty46damnOMC
	lkSf15CHho+vWH8obPEt1+fAl8BUM9zCxQ/Todb/e0WsQiaPb3s2iUWx4pXKZ1pi7Ut5rYIofjWHO
	ZcU23KASQQ8kPIIfZVFg=;
Precedence: bulk
X-Issuen: 1428244
X-User: 149890965
X-Postmaster-Msgtype: 3849
Feedback-ID: 1428244:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20251107.120132
X-SMTPUID: mlgnr59
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=LLj21esqm3R2LJZDtbLCVJh
	szRnRQfTTEwvoExcwbOk=; b=lp3AFDfGAiLVvVpQ05fmi6m59+1mJXTr7hj1tvSaP/8AhiUyoT
	YhnjrTFmm8B/SKfidH2GBp/edS7i6XyhugnkejqOeGZO5m5oJ7yRVL1pkl75xipAkYUL2PsNo1q
	+DRkJJNR2hFl8DVNAkroaotZNVhi+gUUk/C1sQ/gmcP8DuL4O2yn+z069IwpyRo7DF3uT7hADpM
	GmcyB14f/xLpYei49Vi2Yoe+aPsHx+nkREVVa6BKSvINsdilXkbEZbV9J5i+AuMLZKIXiGPWey2
	MCeD8aoi3WIaZ0N3kS3+i5rcoiKcW2dC7cimmWG5DphrA/18w03Z3Q+Bk1EQKSDIkIg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=LLj21esqm3R2LJZDtbLCVJh
	szRnRQfTTEwvoExcwbOk=; b=YqTiiJ/D6bJVhf6Ihe7IuV6TefJR8aDBQj1BbA1Xnbl2pldU/U
	xvML7JiQeqWGYf4VJJNSsI3VQFjcrWNM6bCQ==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/8] btrfs: move kfree out of btrfs_create_qgroup's cleanup path
Date: Wed, 12 Nov 2025 21:49:38 +0300
Message-ID: <79f3f83eb5f693ad88b0cad9d37e2db214ba1491.1762972845.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <cover.1762972845.git.foxido@foxido.dev>
References: <cover.1762972845.git.foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relocate kfree() from the generic cleanup path to the specific error
exit where the allocation could leak. This prepares for future
simplification by allowing removal of the 'out' label and use of
mutex_guard for cleaner resource management.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 fs/btrfs/qgroup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9904bcfd3a60..a8474d0a9c58 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1659,7 +1659,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *qgroup;
-	struct btrfs_qgroup *prealloc = NULL;
+	struct btrfs_qgroup *prealloc;
 	int ret = 0;
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
@@ -1681,18 +1681,18 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	}
 
 	ret = add_qgroup_item(trans, quota_root, qgroupid);
-	if (ret)
+	if (ret) {
+		kfree(prealloc);
 		goto out;
+	}
 
 	spin_lock(&fs_info->qgroup_lock);
 	qgroup = add_qgroup_rb(fs_info, prealloc, qgroupid);
 	spin_unlock(&fs_info->qgroup_lock);
-	prealloc = NULL;
 
 	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
 out:
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
-	kfree(prealloc);
 	return ret;
 }
 
-- 
2.51.1.dirty


