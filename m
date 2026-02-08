Return-Path: <linux-btrfs+bounces-21498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pZlIAaLpiGmZygQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21498-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 20:53:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3435A10A0C6
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 20:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0EB13008511
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 19:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C9C3246F0;
	Sun,  8 Feb 2026 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMGmnMGL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2765C13B
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770580378; cv=none; b=Dm0iRBZFdnPxyKATeEevxzniQk4p3+EXYs+d43cpOiaMuvDgNP+dogXHeY/ryn7Go2c3fqIXWDNzUaxuwQdZZy+ZVZodh6UgusTlW9TN8oFbAscmedzw/Jq2EDcBpVJ8WPPJY9LzlWoHJPLx1KasQuGOESoMrA7BJphaiI9WEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770580378; c=relaxed/simple;
	bh=Sc4Qz1sIMR/hqeRPM2Cs21sXrJxGwTbj0QJXnG2q0As=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Rc1b5D5V9fOHNycxYU8mbTSj7yyrMI6BS8IyzttZ4EgZULGak02DroIl/m0S+LnazJ4XuOpKfRZtJvVT15TlR4u0KhwuqXoNFXaOMKo9XAC5erZ27Ydua5IBGbHjkVtLaEM36aPPoQxq8AXcAsUm/LsOd6RQoVra+fpK6SVV0fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMGmnMGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7A5C4CEF7
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 19:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770580378;
	bh=Sc4Qz1sIMR/hqeRPM2Cs21sXrJxGwTbj0QJXnG2q0As=;
	h=From:To:Subject:Date:From;
	b=vMGmnMGLMTzMY1OXYKgkQN1EwDabl4gPcWE9UBHbV+odksw4nfy+fuV+7VYekyagl
	 WRKAZFglF/MlCDtrz3z88HbtcDym1Lt8ciBZB4qQ/Nu8OqLN1xWwoTa42SBAC2V8M+
	 FZOp91NoF6Rd0SQaEBemmFw6dpPYwZ9+uRfHljVZNDLKw1mnkItTyVmjee0X2ZvoYD
	 0LsZ5IsYPZPUwqfQMOFwOqezsJOsYtVFC3mSHERkBtC1qG3Tl94XNBDPk4Nbd6MwDb
	 V6DkT1ICWRaV98zuXFBDNosvn+MtuX12K4gMldim2MjHVg6MaSIJj0pMJM4vFRsvFr
	 I7pP0Zsw+quiQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix lost error return in btrfs_find_orphan_roots()
Date: Sun,  8 Feb 2026 19:52:55 +0000
Message-ID: <6400dc5103b5ddbe543961b4e865e311ab396790.1770580302.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21498-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 3435A10A0C6
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

If the call to btrfs_get_fs_root() returns an error different from -ENOENT
we break out of the loop and then return 0, losing the error. Fix this
by returning the error instead of breaking from the loop.

Reported-by: Chris Mason <clm@meta.com>
Link: https://lore.kernel.org/linux-btrfs/20260208185321.1128472-1-clm@meta.com/
Fixes: 8670a25ecb2f ("btrfs: use single return variable in btrfs_find_orphan_roots()")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/root-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 37a4173c0a0b..d85a09ae1733 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -257,7 +257,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 		root = btrfs_get_fs_root(fs_info, root_objectid, false);
 		ret = PTR_ERR_OR_ZERO(root);
 		if (ret && ret != -ENOENT) {
-			break;
+			return ret;
 		} else if (ret == -ENOENT) {
 			struct btrfs_trans_handle *trans;
 
-- 
2.47.2


