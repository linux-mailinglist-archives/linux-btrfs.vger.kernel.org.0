Return-Path: <linux-btrfs+bounces-20829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO2dL2O3cGlwZQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20829-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:24:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8236A55F2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C476452A222
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369F24779A5;
	Wed, 21 Jan 2026 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRLUtYhZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87D48122B
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994055; cv=none; b=mNLtzM3TRoS1RGmgSR0V0+hpeUgD3QN54slnbqqAQNk5tb1rMfdW8XIJto6j4nB4RzAeS3MLcobR0UOxDK7u2q5ufGN1cEE17DOQsSBkeIb7FfRgI3uh7CRHEwzrvIgaeO+QrtbTlUU01uXQiUS1nZ6BZl4IeSo6xSUJI9qAgbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994055; c=relaxed/simple;
	bh=xfiKz7igY25resrIpCfzFM6rIRjzh0llD8dXCZMEAkw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGMKXFAXvL5BMmO/hF/2AAJI+s12oa/FKHBeDkog95N4+aUKou3exG5ZpEheJWXTgnCSUbIr8Tb75Tvp42LWoMkhg9+EIZdCrVOoQG5UKEocGZrdRuA2QURI7T8J3QgrY6AjiQ6efjABoKvR5eZTPDTii9UcL7Na8VYiQT+puRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRLUtYhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1EEC19422
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994053;
	bh=xfiKz7igY25resrIpCfzFM6rIRjzh0llD8dXCZMEAkw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SRLUtYhZNxP9HNeCZAgTf5NK1qNrihq2oarTpXO+kgzMcC1X07msamP4ZSOrgtYIU
	 ZXnBvUbdJ2TP2U/waRjZNIvuti9ne1w68eIhsG2zhk/21AvvBWSAw64L+DzaNduWuO
	 sUkeC0i0c/0q1h+EK/aT1bbwjrq6FsA5TUUJBMgZ63Sb80VxIYu4v+beIvHktx8U77
	 Nkoz8p8IY0F563QpKH5jCRSKtu/dfJMznxLuFo1x//lvQHI3ip97ggUm66LL0d1v4G
	 GQAt7c3HJgAd1PM5CNGZjfjttX3Vl2HpRFHSkfNP5Ue72w3jL2UzHMaBumVXLMa+g2
	 rdeV4MZoRTzzg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 19/19] btrfs: remove out label in btrfs_wait_for_commit()
Date: Wed, 21 Jan 2026 11:13:53 +0000
Message-ID: <2e5c3e3dc4b17740e84660c1706ecc55bd895deb.1768993725.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768993725.git.fdmanana@suse.com>
References: <cover.1768993725.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20829-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8236A55F2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There is no point in having the label since all it does is return the
value in the 'ret' variable. Instead make every goto return directly
and remove the label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f4cc9e1a1b93..8aa55cd8a0bf 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -950,7 +950,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
 
 	if (transid) {
 		if (transid <= btrfs_get_last_trans_committed(fs_info))
-			goto out;
+			return 0;
 
 		/* find specified transaction */
 		spin_lock(&fs_info->trans_lock);
@@ -975,7 +975,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
 		if (!cur_trans) {
 			if (transid > btrfs_get_last_trans_committed(fs_info))
 				ret = -EINVAL;
-			goto out;
+			return ret;
 		}
 	} else {
 		/* find newest transaction that is committing | committed */
@@ -991,14 +991,15 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
 			}
 		}
 		spin_unlock(&fs_info->trans_lock);
+		/* Nothing committing or committed. */
 		if (!cur_trans)
-			goto out;  /* nothing committing|committed */
+			return ret;
 	}
 
 	wait_for_commit(cur_trans, TRANS_STATE_COMPLETED);
 	ret = cur_trans->aborted;
 	btrfs_put_transaction(cur_trans);
-out:
+
 	return ret;
 }
 
-- 
2.47.2


