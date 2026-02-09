Return-Path: <linux-btrfs+bounces-21560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNHPED0VimlrGAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21560-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:11:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6A1112E76
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D13A300B45A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17AF3815E4;
	Mon,  9 Feb 2026 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3wINTAT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDA237A496
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770657075; cv=none; b=Usr78NF9QplCPe8PYBB2OzD1e0kJjmF4E/g13emDpuiGtDOUmDhN31XErTflCKHs3iazw8W4PNUyMGi7UJ/RxzUAkyEGdMVZezQ+lyMFJcPoRIZrHj4rPSv5loTv/EnhPNhZNlGEtO+4dQqn9kn63xKFyUC4n28kg6AdfFvvBz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770657075; c=relaxed/simple;
	bh=rXBcqcSBxLj48ghx6bzkIV8ARLZH+35kkTQNXEhSNsY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOSN8X+uHH51bi8MLCZ1GF6DTILbuG9Uk+VofxOH7R/tO/wr2Zph7GKa6tQvyloMbXGBPQt7lthc3I5Vl3VM5maFHwvRMj2I78ZjZCUzOzerXkHRQ8XtVTEg62rMhvbgu0L6/Ggnq54mbcxRpt9Fm5Bllmdrhn4glIfRK2LfVxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3wINTAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECF1C19424
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770657074;
	bh=rXBcqcSBxLj48ghx6bzkIV8ARLZH+35kkTQNXEhSNsY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=j3wINTATFufsV5iP7KQv3NTAnH5Q82XMffUbCOwWqITqLfj5Cys58EMgfUPUiTLfZ
	 D5ekUsXa90+8X9fxTwvpNlDxz9UOeijkicbnrpUcwu4PoC8l6j1urBaajXUxhySXG/
	 ZfXxim/U8quexFUIndJvKkLd+DdZqbH5z95hX0aiK6LCfNqxFunRq2n13Lg5k8jsIq
	 MlUroRLfW5OYYsBB08aCuKKLO2ql8HVj44EfHGSR+14M5mhOhhhFlKlAeXxocOA0+J
	 LQxPBrJ8Zu47X2BgxgqTcwzm+viLl4T0xipq0rbOJVDsvTqvXEx+qVwYvMntoKowv4
	 X9LQ6mdXl9NAw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: remove btrfs_handle_fs_error() after failure to recover log trees
Date: Mon,  9 Feb 2026 17:11:07 +0000
Message-ID: <1809fae065223b682451f6007b620a4edd53cc87.1770656691.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21560-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF6A1112E76
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

There is no need to call btrfs_handle_fs_error() (which we are trying to
deprecate) if we fail to recover log trees:

1) Such a failure results in failing the mount immediately;

2) If the recovery started a transaction before failing, it has already
   aborted the transaction down in the call chain.

So remove the btrfs_handle_fs_error() call, replace it with an error
message and assert that the FS is in error state (so that no partial
updates are committed due to a transaction that was not aborted).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cb0bca3f6a05..99ce7c1ca53a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2028,9 +2028,9 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 	/* returns with log_tree_root freed on success */
 	ret = btrfs_recover_log_trees(log_tree_root);
 	btrfs_put_root(log_tree_root);
-	if (ret) {
-		btrfs_handle_fs_error(fs_info, ret,
-				      "Failed to recover log tree");
+	if (unlikely(ret)) {
+		ASSERT(BTRFS_FS_ERROR(fs_info) != 0);
+		btrfs_err(fs_info, "failed to recover log trees with error: %d", ret);
 		return ret;
 	}
 
-- 
2.47.2


