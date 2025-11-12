Return-Path: <linux-btrfs+bounces-18907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D650C5412E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E8F6348CF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA74534E741;
	Wed, 12 Nov 2025 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="KMw8kXPo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="XnM5RjMU";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="AYR+cCAa";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="AbEkgjaS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender6.mail.selcloud.ru (sender6.mail.selcloud.ru [5.8.75.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBF34DB68;
	Wed, 12 Nov 2025 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974527; cv=none; b=QLXV676/6dDTayfTbIPdzoojbbQqRS4MCLbkSN4I5vgMQw06zptgy0PI74WarIKmQWzoVfYitb3QBeEmE9C1ZRcoW+vWNXi/yqPgt834ub3GVjt90X4N4UPZe4G0fzZXHxjcluzP0MtFofO9YWR+7Gm521NSeTiqiFAW4gF1sHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974527; c=relaxed/simple;
	bh=jBGfuob7zOPXWGRZTOoC3Q/HdN2ubZFd5hDIK7o931Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpWD8LcqcYY8V2Rt3uTogosN2nUj37QDUksr0MI60kesBJPzKDvMENkmDgKoUJdY2ZiH+GQ5w5zNce+ZSe7rNssvEAXx42hkp3IO5kpYQpqXu0XkqhVy1SVfzFGtWrqT1ZfgBIUeO7i+O+lD3n6CucUU9piTOYHZoneNl+I7XT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=KMw8kXPo; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=XnM5RjMU; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=AYR+cCAa; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=AbEkgjaS; arc=none smtp.client-ip=5.8.75.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:List-id:
	List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FE2/yEfUZslK/B3nL6QvDOFYUETlNN+H40NdrpdBDW0=; t=1762974525; x=1763147325;
	 b=KMw8kXPo98DqY0tyXSCSeILMK81JFjid91axPZlA1mJDZe6iE3K/706SVHMD18ZmdPOABZ12tK
	N5eREiDIFDncjhnc6+SdBH03KxP9zaVJ7yX3ROMHcRgGFqi7NM8eJ1wJZaY9NUfLz/wruGGsngBJp
	PB8Uz+ws7SDiibFYsxHE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FE2/yEfUZslK/B3nL6QvDOFYUETlNN+H40NdrpdBDW0=; t=1762974525; x=1763147325;
	 b=XnM5RjMUHRVqvdf0i+5udzg5ivBYz6GJNxjSJbtykp/n7xT/kP15P//AlYztAC9HgCGqjVPmoC
	bqPiipUfzwLa+tIYId5zixCcYK7d5Ujs17vU6NoEnjGKa1lRIUR5XaA70U6APDJKFXMRW/in+Yym8
	qpxu6rjODI9WfZ0U6WJI=;
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
X-SMTPUID: mlgnr60
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=FE2/yEfUZslK/B3nL6QvDOF
	YUETlNN+H40NdrpdBDW0=; b=AYR+cCAamjnzXOOR0V9avs6U9l3H2kL9xg4isgFgBCy4UzN+VO
	jOncwSS0nVyz2hwt9zpMSPnsaleop72+dlmsofmWTG2M2E6OoMdOPRzOywlMvG6YeG7HJMbTSVi
	NG5jtO6jWF1WnWhlqtVP3eUnXcFl8xphNQ2TdMpYOEC+mreUOR3rnFE9nTMcVehr8yvJ48TJ1xZ
	/ZKJPJoHCeL+7ijsL+27gxXcU0pcWQ/zRgfsPs1uOV+7X3RpJ5f7oOZSP/uDJO02DHYxzpSEc9C
	SYPpEt4ePP9Zl9cM3mEUjCRV1zU5jrugjhkX/ZgR8cXMfQwl6x3b1sPQMfRV5FOKslA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=FE2/yEfUZslK/B3nL6QvDOF
	YUETlNN+H40NdrpdBDW0=; b=AbEkgjaSz91Gjo+gwQzG3fbcPSettj0x988gXYXP8ZM1MMEl4t
	QnKuNLeaADJ8CljJublXQysVWezmr83YYwAg==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 8/8] btrfs: simplify cleanup in btrfs_add_qgroup_relation
Date: Wed, 12 Nov 2025 21:49:44 +0300
Message-ID: <d9e7808a976e6325bfdc41100bd9b38892663a8b.1762972845.git.foxido@foxido.dev>
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

Remove from cleanup path mutex_unlock via guard() and kfree via
__free(kfree) macro. With those two cleanups gone, we can remove `out`
label and replace all gotos with direct returns.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 fs/btrfs/qgroup.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9b2f2c8ca505..238c17c7d969 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1528,65 +1528,55 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
  * callers and transferred here (either used or freed on error).
  */
 int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst,
-			      struct btrfs_qgroup_list *prealloc)
+			      struct btrfs_qgroup_list *_prealloc)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_qgroup *parent;
 	struct btrfs_qgroup *member;
 	struct btrfs_qgroup_list *list;
+	struct btrfs_qgroup_list *prealloc __free(kfree) = _prealloc;
 	int ret = 0;
 
 	ASSERT(prealloc);
 
 	/* Check the level of src and dst first */
 	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst)) {
-		kfree(prealloc);
 		return -EINVAL;
 	}
 
-	mutex_lock(&fs_info->qgroup_ioctl_lock);
-	if (!fs_info->quota_root) {
-		ret = -ENOTCONN;
-		goto out;
-	}
+	guard(mutex)(&fs_info->qgroup_ioctl_lock);
+
+	if (!fs_info->quota_root)
+		return -ENOTCONN;
+
 	member = find_qgroup_rb(fs_info, src);
 	parent = find_qgroup_rb(fs_info, dst);
-	if (!member || !parent) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!member || !parent)
+		return -EINVAL;
 
 	/* check if such qgroup relation exist firstly */
 	list_for_each_entry(list, &member->groups, next_group) {
-		if (list->group == parent) {
-			ret = -EEXIST;
-			goto out;
-		}
+		if (list->group == parent)
+			return -EEXIST;
 	}
 
 	ret = add_qgroup_relation_item(trans, src, dst);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = add_qgroup_relation_item(trans, dst, src);
 	if (ret) {
 		del_qgroup_relation_item(trans, src, dst);
-		goto out;
+		return ret;
 	}
 
-	spin_lock(&fs_info->qgroup_lock);
+	guard(spinlock)(&fs_info->qgroup_lock);
 	ret = __add_relation_rb(prealloc, member, parent);
 	prealloc = NULL;
 	if (ret < 0) {
-		spin_unlock(&fs_info->qgroup_lock);
-		goto out;
+		return ret;
 	}
-	ret = quick_update_accounting(fs_info, src, dst, 1);
-	spin_unlock(&fs_info->qgroup_lock);
-out:
-	kfree(prealloc);
-	mutex_unlock(&fs_info->qgroup_ioctl_lock);
-	return ret;
+	return quick_update_accounting(fs_info, src, dst, 1);
 }
 
 static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
-- 
2.51.1.dirty


