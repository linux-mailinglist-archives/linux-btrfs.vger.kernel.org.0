Return-Path: <linux-btrfs+bounces-22193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Hw+DXEYp2m+dgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22193-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 18:20:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC081F4884
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 18:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2EA03033885
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355BE42F561;
	Tue,  3 Mar 2026 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeVTOkUb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860DE37B025
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772558392; cv=none; b=SKczqP9XYn5GwXa9w+LKpNsubIUd6MlgA285gDeJNoy2h8BT08/LCUMBXyeja1DLSws3YL0H8gstbQFYsCJbuGZ6kyyPXQ6nOeX4g/kVK0OxDagIdSossQlgUEsTjdJGrMHKBWraWwgCwIJj5eRxGRkdM87ugRTlT6PN836sYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772558392; c=relaxed/simple;
	bh=0AnxHAtTwZdpZ17TUy+idd0Ym04+NlcpUvUABFCzoBY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=l7hYy1bZxnQyTKpDdPk8VgVFPQ6/fhSZM/c0g6Ml2PmvdIVyXMBa5EqgquWGH91CC3g6XPcq2g7ksR1n7ojnIRv4Sm1aJDiMT4eXVaXbXG0vecaaQ3Ely/0rKvYgqaKcSauLiQvCcD7rzdMnklFzVxzVmqlcpKIB7skudWI+5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeVTOkUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B108AC116C6
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772558392;
	bh=0AnxHAtTwZdpZ17TUy+idd0Ym04+NlcpUvUABFCzoBY=;
	h=From:To:Subject:Date:From;
	b=WeVTOkUbKhfbMTbof40b0jTTjOpoOiMgCQff3zx97Yy5FTf0qo3wlx+HrkzvIR98l
	 N2mivGXxE25a4pZudntL8LtrvNrQMV+ul1EY9gKdWDAZYrNrbw/SvTdw4EAuVHKvl8
	 VAvfU0u2s4dRPF6Y8vFOteLsuTEuQ7YVaHBIC52RtHzp0Io6op7xmMO5d4ASbzUwtW
	 elt8Cf6spkgE9cnuzs8HPE+Vi+RyYPucQ/U3ve16otKMF/yCoRdfZeOYLY9qiVcv+X
	 iRzCACfsml/QM/TwiEwhEB1k24lBAnV9shhwfUsPl6bVfAUCtlK559HozNe1DUYLw3
	 JjpXA5bxuUfXA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: log new dentries when logging parent dir of a conflicting inode
Date: Tue,  3 Mar 2026 17:19:48 +0000
Message-ID: <9a367f025abf4ea19c96aead75d206e129b2c56e.1772558089.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BEC081F4884
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22193-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:mid,suse.com:email]
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

If we log the parent directory of a conflicting inode, we are not logging
the new dentries of the directory, so when we finish we have the parent
directory's inode marked as logged but we did not log its new dentries.
As a consequence if the parent directory is explicitly fsynced later and
it does not have any new changes since we logged it, the fsync is a no-op
and after a power failure the new dentries are missing.

Example scenario:

 $ mkdir foo

 $ sync

 $rmdir foo

 $ mkdir dir1
 $ mkdir dir2

 # A file with the same name and parent as the directory we just deleted
 # and was persisted in a past transaction. So the deleted directory's
 # inode is a conflicting inode of this new file's inode.
 $ touch foo

 $ ln foo dir2/link

 # The fsync on dir2 will log the parent directory (".") because the
 # conflicting inode (deleted directory) does not exists anymore, but it
 # it does not log its new dentries (dir1).
 $ xfs_io -c "fsync" dir2

 # This fsync on the parent directory is no-op, since the previous fsync
 # logged it (but without logging its new dentries).
 $ xfs_io -c "fsync" .

 <power failure>

 # After log replay dir1 is missing.

Fix this by ensuring we log new dir dentries whenever we log the parent
directory of a no longer existing conflicting inode.

A test case for fstests will follow soon.

Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/182055fa-e9ce-4089-9f5f-4b8a23e8dd91@gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e011786cbd94..af8de67d1304 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6246,6 +6246,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *root,
 				  struct btrfs_log_ctx *ctx)
 {
+	const bool orig_log_new_dentries = ctx->log_new_dentries;
 	int ret = 0;
 
 	/*
@@ -6307,7 +6308,11 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 			 * dir index key range logged for the directory. So we
 			 * must make sure the deletion is recorded.
 			 */
+			ctx->log_new_dentries = false;
 			ret = btrfs_log_inode(trans, inode, LOG_INODE_ALL, ctx);
+			if (!ret && ctx->log_new_dentries)
+				ret = log_new_dir_dentries(trans, inode, ctx);
+
 			btrfs_add_delayed_iput(inode);
 			if (ret)
 				break;
@@ -6342,6 +6347,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 			break;
 	}
 
+	ctx->log_new_dentries = orig_log_new_dentries;
 	ctx->logging_conflict_inodes = false;
 	if (ret)
 		free_conflicting_inodes(ctx);
-- 
2.47.2


