Return-Path: <linux-btrfs+bounces-21558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOUYHj0VimlrGAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21558-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:11:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BFB112E75
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F91F300608D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF593859FA;
	Mon,  9 Feb 2026 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdWwP9Ma"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC2F37A496
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770657073; cv=none; b=Xo+cByDZ+nzvJpFoSv9GP2PK9oqZaCfaar7rM5hDX/Jg0nHHUyv+Iub8M5oPZ4K8qMozCUL4zggfvjSeiwYpz513iZK65u0F/wLzTPoj5OgQJUxLoCVooiXcLnKTBUyNVeBZohAkjREcbyB/r475YihunygTPQHiNX5WQl6RpGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770657073; c=relaxed/simple;
	bh=K7C5lnHAzLT2iWPwiZFjuOOTWTsAsG4AzwAO8fH/6S8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZc6pWjO+Ym9X6RZZaiJYym43CtLTu3s/aWasTkkS+tedHIkjyhmRAbMa9Q2Z0uuz0sfq3wo7SJjqdyt43x/AkuzigqQesNKX2zXHmr8um3KHSGTipDR9rPkatJrv60bWgZufUFsQdQLlb1iP/hT7ZNXaJDmO+eF4G447qNtH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdWwP9Ma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F27FC19423
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 17:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770657072;
	bh=K7C5lnHAzLT2iWPwiZFjuOOTWTsAsG4AzwAO8fH/6S8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pdWwP9Maxzc9irR8W31l43y9yBVQ90s8eZY8FX+VVQOkcl4VU4GNLn/1VXCb1NiEf
	 AvEKE8+5RS1OgYPhhNI18iub6jk3bpsykg1yuDFhDdn80c6KCWkMffOKUr30lMg6iH
	 Z3DOX93RzxGMJiUEaLA2+m5l9E/ArPBgmQ7WcHLZ7mB8f5Rbe61moK2JqIY9AMEywQ
	 F2EM1K1NZpxDk6qyKricIIGQppQTEq4/gojwKTMEX92iy0cLqXQucKsriKD85Ep6Mn
	 j6AIVqJ7iigXmPvUlj6DizfLVFWHWigxzbOiZw8HTiDc1ya6pjNPZSwP7+n1mEVbc7
	 6R7wUpBVc1eBg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: change warning messages to error level in open_ctree()
Date: Mon,  9 Feb 2026 17:11:05 +0000
Message-ID: <0c6a372adb02b3b9c5ecf431b4ff96c9f8637fb4.1770656691.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770656691.git.fdmanana@suse.com>
References: <cover.1770656691.git.fdmanana@suse.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21558-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88BFB112E75
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Failure to read the fs root results in a mount error, but we log a warning
message. Same goes for checking the uuid tree, an error results in a mount
failure but we log a warning message. Change the level of the logged
messages from warning to error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 597d78d2dfe1..040c9577e737 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3632,7 +3632,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->fs_root = btrfs_get_fs_root(fs_info, BTRFS_FS_TREE_OBJECTID, true);
 	if (IS_ERR(fs_info->fs_root)) {
 		ret = PTR_ERR(fs_info->fs_root);
-		btrfs_warn(fs_info, "failed to read fs tree: %d", ret);
+		btrfs_err(fs_info, "failed to read fs tree: %d", ret);
 		fs_info->fs_root = NULL;
 		goto fail_qgroup;
 	}
@@ -3653,8 +3653,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		btrfs_info(fs_info, "checking UUID tree");
 		ret = btrfs_check_uuid_tree(fs_info);
 		if (ret) {
-			btrfs_warn(fs_info,
-				"failed to check the UUID tree: %d", ret);
+			btrfs_err(fs_info, "failed to check the UUID tree: %d", ret);
 			close_ctree(fs_info);
 			return ret;
 		}
-- 
2.47.2


