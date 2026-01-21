Return-Path: <linux-btrfs+bounces-20819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id u7BZIx+3cGlwZQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20819-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:23:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 327DF55EFF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6C40420F2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6686A47276F;
	Wed, 21 Jan 2026 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVNujqrg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66036477E30
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994047; cv=none; b=K/dLC912vugvZaDLvEccPxDmTabK4ji+xX2x//n/m17cGXvAkx7rXq6soqydCuos71VFdWghVluGWL9T3/3qPXzYqlG1pGZeRxWz6fdi4h/J+if1kM3QPJhpwETUn+tp3kLFDwTBVOlkeV7k4eA1hlcQg6mgXzeRH7LemBuhbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994047; c=relaxed/simple;
	bh=TMxAAar5nEPD6prqoNNtiNWr/QDL3Dlw2rQO59urzIU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsW8DFCxvAsK9apA1WH0J5ioirZMbTNiPeomaGkP9pHc6bd/9T/IlniB56wFJa9WC/4HLVL5LzWTUPGP/jbr8PbEkOYFbCws0EioYEgXP79QmNlAjpcdOFvU5PYBJ89EaRs0oYyCdCUqk3AQheDfSVm3kpTzDS9J9TsprWYbjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVNujqrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DDEC19422
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994045;
	bh=TMxAAar5nEPD6prqoNNtiNWr/QDL3Dlw2rQO59urzIU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sVNujqrgqse5swZNKJvzLt6MAJCnXD9ytKTM6oJRPDC4LwOLIb9hGLhAH2TzvkaIP
	 oko3OUtE0MfF84DKkOv6kmFJ87an972dxaiV3rcL59IOjzrQ2LChB3OGB1OExXHQth
	 KLAiMolNgUNN81xaZxD6yGIT2thFje8PvveVG1XEeBX2PrCaMlJhPwCfhlU8rUICXE
	 nsbJObNy7iTrLR2UG54a0WRsr9Mfy+CNhg6ZaGb3wr/Vv2oWq0pAyej/RGjXVXr7ZZ
	 Mxd4j3tC4KxRneXPSG4dJK5Cw5LXz3h6DKG6NC+ZNq8X7jSnzjyQRq39FmxiQxbxOZ
	 3CxOmvBbCXQew==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/19] btrfs: remove pointless out labels from uuid-tree.c
Date: Wed, 21 Jan 2026 11:13:43 +0000
Message-ID: <6d959362892c7c5efdbd85dbb8e4bb2df2e57443.1768993725.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20819-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 327DF55EFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

Some functions (btrfs_uuid_iter_rem() and btrfs_check_uuid_tree_entry())
have an 'out' label that does nothing but return, making it pointless.
Simplify this by removing the label and returning instead of gotos plus
setting the 'ret' variable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/uuid-tree.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index e3a1310fa7d5..f24c14b9bb2f 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -207,15 +207,11 @@ static int btrfs_uuid_iter_rem(struct btrfs_root *uuid_root, u8 *uuid, u8 type,
 
 	/* 1 - for the uuid item */
 	trans = btrfs_start_transaction(uuid_root, 1);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		goto out;
-	}
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
 
 	ret = btrfs_uuid_tree_remove(trans, uuid, type, subid);
 	btrfs_end_transaction(trans);
-
-out:
 	return ret;
 }
 
@@ -235,14 +231,14 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 
 	if (type != BTRFS_UUID_KEY_SUBVOL &&
 	    type != BTRFS_UUID_KEY_RECEIVED_SUBVOL)
-		goto out;
+		return 0;
 
 	subvol_root = btrfs_get_fs_root(fs_info, subvolid, true);
 	if (IS_ERR(subvol_root)) {
 		ret = PTR_ERR(subvol_root);
 		if (ret == -ENOENT)
-			ret = 1;
-		goto out;
+			return 1;
+		return ret;
 	}
 
 	switch (type) {
@@ -257,7 +253,7 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 		break;
 	}
 	btrfs_put_root(subvol_root);
-out:
+
 	return ret;
 }
 
-- 
2.47.2


