Return-Path: <linux-btrfs+bounces-20840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ic0IqEXcWmodQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20840-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:14:57 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5433C5B216
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C425850D87A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1CD33BBD1;
	Wed, 21 Jan 2026 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlgfGrO0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8D494A0A
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013050; cv=none; b=NdsodrtfmgE3kkwEgLrOxHDmefvRZ49e8anjurf+0bNaFdzw6ZW9i+r55kGIQC58VkppxQuVGy6uAF8v6T6Gd55j8xfBGLQ3xAWhy3tXM5nx6CBNhwj/RGNHAMZSlO1Zc+Jt+HJxRYSqTF9+g33Aox8HWug7s0Xd8T01SZPh69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013050; c=relaxed/simple;
	bh=hhrh2/EKzT+s23gGWrY8ZGQzL7fRbjCjvh7MHR/Gejs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxfv6yxuug/f5PxKz8rLiLBU/WlUTJWHRyblLgHdL6j7S3LP1OKBm9RM0sfb3gz6jJYmDraNHFRsQcDWfPg44rlqmoyoKcYpZiGoJiViZpeFC2JcJkq8Nc+P6VoVf5k7hLw0grOGsqKJnr2NA/o0dtYPagCr8PY1W8Msnc14My4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlgfGrO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8671CC116D0
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013050;
	bh=hhrh2/EKzT+s23gGWrY8ZGQzL7fRbjCjvh7MHR/Gejs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SlgfGrO0piXmtKQzQm9kZJt3rvo6IlkMoiWnJ+sW3r+AV5zV2Z5JLKay7s25EA0zk
	 gazsTEKRxJzryxIpovhxDI2OU7BK12UT+hqrrzAh0IltxH6yBD+whkCeZfbt3zUiV7
	 YSxwj2XaTyy4S+u1lBHyr5AvNzdVgcdbSPMuQildKu/4//z7Z0dFagN+fHe883Hdqg
	 8vo6MlJRLz0+FVUXd7uLpGPJ2AxGFbKfYEEADffzW+YaMey4SHhk1hyECwz0F5dqL9
	 zEnGddj/zxWshrydzhtu0zLmeg8dV0GGE9aTji2rM9Uawdbzht8vK82paeTLwQpsJw
	 2JNco20KgtjSg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 01/19] btrfs: qgroup: return correct error when deleting qgroup relation item
Date: Wed, 21 Jan 2026 16:30:27 +0000
Message-ID: <d2fdc2383d63cbdfd5c3f70addf37270fa9dff55.1769012877.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1769012876.git.fdmanana@suse.com>
References: <cover.1769012876.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20840-lists,linux-btrfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org]
X-Rspamd-Queue-Id: 5433C5B216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

If we fail to delete the second qgroup relation item, we end up returning
success or -ENOENT in case the first item does not exist, instead of
returning the error from the second item deletion.

Fixes: 73798c465b66 ("btrfs: qgroup: Try our best to delete qgroup relations")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 14d393a5853d..c03bb96d3a34 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1640,8 +1640,10 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	if (ret < 0 && ret != -ENOENT)
 		goto out;
 	ret2 = del_qgroup_relation_item(trans, dst, src);
-	if (ret2 < 0 && ret2 != -ENOENT)
+	if (ret2 < 0 && ret2 != -ENOENT) {
+		ret = ret2;
 		goto out;
+	}
 
 	/* At least one deletion succeeded, return 0 */
 	if (!ret || !ret2)
-- 
2.47.2


