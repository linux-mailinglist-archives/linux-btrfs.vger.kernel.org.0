Return-Path: <linux-btrfs+bounces-21311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMwkEOzygWkMNAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21311-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 14:06:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 697B1D9A5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 14:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 888593036850
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D71834EEE8;
	Tue,  3 Feb 2026 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+pXNvDo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C834B1A7
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123745; cv=none; b=EEanyIRaqdQS/KRbeR6JBUlQ29+q8hTLUQEgWVk7Kvgzte1WV0yG+ewtYtTdkv61pcyee1aSNNqR4iVbT38lznTfIRv/3yZqEiIqCwe63Wo/gBQQSV7W0/Fv8tmFO6S9euB0RuCX6UjhxDUQOjMQANCBAdRN3PxyRDfjzEMX0Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123745; c=relaxed/simple;
	bh=/g94GP+2Vv5LBap82S33yDzunjODv2WODqp8LTvZNSg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NZelTQJAr/AQ/zOqv3txlnCILXcj3hCieRPvgRmbMCB9i5i1RNeqdMhNXveiKhujSRoSOVWq+vvgHKH2DQTbFneurjXxRAFl/zTuX4shUY4u79wn4JAz3l7AW1Ex9FGJXkWu6Q0jISFV/lh6vRuku0/EWk+oirMHt1VKx5gmC/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+pXNvDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E55C116D0
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 13:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770123744;
	bh=/g94GP+2Vv5LBap82S33yDzunjODv2WODqp8LTvZNSg=;
	h=From:To:Subject:Date:From;
	b=h+pXNvDotKSx8nUkdKxKYQXKl3bKLntoJKRO7W0SdSkqKKTxDmStgPosybRh69nmx
	 jBY3YTCO+QFDzvaMVoe8RE5b29T5Pizp8FWsrpcmg9lgSwfkpE8txwVvC9veExy7e8
	 /+oxyFI5TxpXDb86YUyUu23Zp+Yt6s9sqDY2isyONSwJIpjJppn6tLyABQGHZOWVeZ
	 spuWctmFv9usoxP+QQUbh2E+dMcNWkKTMyhQWH5+ZCsljoE4LBljxXTvRke/uhyGH+
	 66D9NzqDNBhYqmIjBmKU2SCvJnu3xC+LUd5NncFFGSjUQf333oOVRaIb6bO8Meo8oG
	 QhR/kD0+rAhSw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: pass boolean literals as the last argument to inc_block_group_ro()
Date: Tue,  3 Feb 2026 13:02:21 +0000
Message-ID: <9d3d4dbe2624d72d34e3a7012caab2a26a3a6521.1770123608.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21311-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 697B1D9A5A
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

The last argument of inc_block_group_ro() is defined as a boolean, but
every caller is passing an integer literal, 0 or 1 for false and true
respectively. While this is not incorrect, as 0 and 1 are converted to
false and true, it's less readable and somewhat awkward since the
argument is defined as boolean. Replace 0 and 1 with false and true.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3186ed4fd26d..262581d6da4d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1663,7 +1663,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&space_info->lock);
 
 		/* We don't want to force the issue, only flip if it's ok. */
-		ret = inc_block_group_ro(block_group, 0);
+		ret = inc_block_group_ro(block_group, false);
 		up_write(&space_info->groups_sem);
 		if (ret < 0) {
 			ret = 0;
@@ -1993,7 +1993,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			goto next;
 		}
 
-		ret = inc_block_group_ro(bg, 0);
+		ret = inc_block_group_ro(bg, false);
 		up_write(&space_info->groups_sem);
 		if (ret < 0)
 			goto next;
@@ -2518,7 +2518,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 				btrfs_mark_bg_unused(cache);
 		}
 	} else {
-		inc_block_group_ro(cache, 1);
+		inc_block_group_ro(cache, true);
 	}
 
 	return 0;
@@ -2674,11 +2674,11 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		list_for_each_entry(cache,
 				&space_info->block_groups[BTRFS_RAID_RAID0],
 				list)
-			inc_block_group_ro(cache, 1);
+			inc_block_group_ro(cache, true);
 		list_for_each_entry(cache,
 				&space_info->block_groups[BTRFS_RAID_SINGLE],
 				list)
-			inc_block_group_ro(cache, 1);
+			inc_block_group_ro(cache, true);
 	}
 
 	btrfs_init_global_block_rsv(info);
@@ -3057,7 +3057,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	 */
 	if (sb_rdonly(fs_info->sb)) {
 		mutex_lock(&fs_info->ro_block_group_mutex);
-		ret = inc_block_group_ro(cache, 0);
+		ret = inc_block_group_ro(cache, false);
 		mutex_unlock(&fs_info->ro_block_group_mutex);
 		return ret;
 	}
@@ -3108,7 +3108,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		}
 	}
 
-	ret = inc_block_group_ro(cache, 0);
+	ret = inc_block_group_ro(cache, false);
 	if (!ret)
 		goto out;
 	if (ret == -ETXTBSY)
@@ -3135,7 +3135,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	if (ret < 0)
 		goto out;
 
-	ret = inc_block_group_ro(cache, 0);
+	ret = inc_block_group_ro(cache, false);
 	if (ret == -ETXTBSY)
 		goto unlock_out;
 out:
-- 
2.47.2


