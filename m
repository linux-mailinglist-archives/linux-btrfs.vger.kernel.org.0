Return-Path: <linux-btrfs+bounces-21564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLfsGrJCimmwIwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21564-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 21:25:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F911470E
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 21:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D38E7302E7EA
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 20:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E473803C0;
	Mon,  9 Feb 2026 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK33JobX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FA37AA6D
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668678; cv=none; b=hPq3ZK/pijYrA5fulQbnA5IXUfIEiLYZdtYgXbDN6CWcRozPqczsxnQ6R75kEeyJbHAprGfqUw9atJw27sQsXjd7G3yFHsj9PFnChW9BlkQGOBrQJCYakyjc/0Cf6QBxF3n+NA0NV82UUSUI8eoKFu4REbpmgVXW2SGkVzW9EMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668678; c=relaxed/simple;
	bh=URBWZcQRwc7kBm6q/ENx+qQuWeAM704XrkCy98EuNRs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qG9zcGpxAM5P+rNGH3o2e2hO9K4Q1w353PpyxlClu53kf9c2nrfDwlaSB2YnPpFI0oe37zfVtJAC24KUHViywp1hCbig7Mjur7mo0oonTyAKXGOKEsAWI1EmAFh2oD7Xy9ejghjOyB5DwTwOa5xbiA50+lhZqHRh1+CTDGWeDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK33JobX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7557C116C6
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 20:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770668678;
	bh=URBWZcQRwc7kBm6q/ENx+qQuWeAM704XrkCy98EuNRs=;
	h=From:To:Subject:Date:From;
	b=JK33JobXSjM0R9n5vqATa96JKYv58+rxgmSPf8H1w8hQ7t1lzoH9jNl8fs1BZ6XLe
	 nEAruNFrQwMDAVnn7QspZsk5+8zZVtTsBuMyF1y7mIapp7/8uwDrOZ//x2OUBYaOTw
	 P/eoglME+LTxlklW2/uZktDLwQFbdL9C5tMJ518jMDo1vyBXX5Gvpk8cXG9lEdvHeL
	 wZdlj4cXYH5VEXp+xOmr9g1sqdSUxABW5m+oSK/X1jQ/UUXSREA9Yw8fYb5mXGKVjY
	 jFrxdtxdYkobQZXWlnV/EdsRBmcSCuEH2PZvrU3DmxygN5egH35+3kwsXjOAiyIsmF
	 Y35dGqTvkNj+g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid starting new transaction and commit in relocate_block_group()
Date: Mon,  9 Feb 2026 20:24:34 +0000
Message-ID: <fe10986ea88fddf9ff8dd58c29694583c805733e.1770667488.git.fdmanana@suse.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21564-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: C96F911470E
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

We join a transaction with the goal of catching the current transaction
and then commit it to get rid of pinned extents and reclaim free space,
but a join can create a new transaction if there isn't any running, and if
right before we did the join the current transaction happened to be
committed by someone else (like the transaction kthread for example),
we end up starting and committing a new transaction, causing rotation of
the super block backup roots besides extra and useless IO.

So instead of doing a transaction join followed by a commit, use the
helper btrfs_commit_current_transaction() which ensures no transaction is
created if there isn't any running.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/relocation.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1da892af9a44..8a8a66112d42 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3642,12 +3642,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1, NULL);
 
 	/* get rid of pinned extents */
-	trans = btrfs_join_transaction(rc->extent_root);
-	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
-		goto out_free;
-	}
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_current_transaction(rc->extent_root);
 	if (ret && !err)
 		err = ret;
 out_free:
-- 
2.47.2


