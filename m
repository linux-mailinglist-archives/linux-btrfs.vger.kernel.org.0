Return-Path: <linux-btrfs+bounces-20848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePR4OIMicWkPegAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20848-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 20:01:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE40A5BB67
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 20:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E269678C8B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0C41B4224;
	Wed, 21 Jan 2026 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+bfEST7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AAD495520
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013057; cv=none; b=JN0CIyKwZ3jveShGzI010A/oeoR6gP303cuV82/27DW2lryvmLAqbVtPDig0V4OLJWHHXeGVtPjfCVocIQXE9WH8ieo4IwUOrjzA070CwNK1ak6VpwiLCBU1mBe3uRFMnKRddWBW+PwpRpx8AhOQRxiroMm1m2cLM0/k086OB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013057; c=relaxed/simple;
	bh=TMxAAar5nEPD6prqoNNtiNWr/QDL3Dlw2rQO59urzIU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7Qf0GTT/wsx/NAK8rCziwVXn4rnqfO2m/3MWYTcbAHeEPzJrO6PilQTAW8RfOgmkridVDo9B+0sw1zkeKvSQAd70NkgxTcxxpSZt1pg1C9LQJM3MABz6Ru+Ho3KwKMy/Kp5/fpIsk7y2KymNmh3x3pRk5fUqRDARyO/H1CnXuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+bfEST7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80335C19421
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013057;
	bh=TMxAAar5nEPD6prqoNNtiNWr/QDL3Dlw2rQO59urzIU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=M+bfEST7WDIv+PQIbOfBxRFZmIjUm7+w//GX5r3vBKopSTQ+CTOBKKuK03n1ZcKr5
	 rgD+kfY3+nZCBA2TXKqX7ecFkUUu6XfFdvdckxcZhsoaDctGYYeECzshirx1/ZaAKU
	 dEWhMJlaHYyotJAme/HHzx2DzuLILlljwaymTAvyNWWRAZ+Qq8to/K+U9jiGDtDe95
	 kcPZ2s2l36x+ay1qYmVEplThhgL66bI3Uma1iSMTDcd5op45QHh5JsZxfAOg4T3pKW
	 NjvFhP1tJyRrlDRzcHxYDtlbiDa4OtsfwUuY5xvkU9TSDWhraNAt6DKvaXsWPzh2x8
	 +uqZsHiwbrLAg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/19] btrfs: remove pointless out labels from uuid-tree.c
Date: Wed, 21 Jan 2026 16:30:35 +0000
Message-ID: <99bbeadaec3424d41f524bc81aded85ed1b481e0.1769012877.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20848-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org]
X-Rspamd-Queue-Id: AE40A5BB67
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


