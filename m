Return-Path: <linux-btrfs+bounces-21604-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD+AOD4gi2lBQQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21604-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 13:10:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1567F11A901
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 13:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7967E302B391
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66F4328617;
	Tue, 10 Feb 2026 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o45mhnpG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E8326924
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770725430; cv=none; b=Y5E2VvcivqP1T/nw5ZG69ZdhL0VJzhawPGMexEss19I2iXHHCzsRHNn742fCKSgVwWTlUObqzkrbAqwEAg6G/NzLT6BHZ3qZMuPIw0vr38NRfO27zONXdUY/X0Lq3a1YyG0o+TGFgrUJyqDKP+WkkrNuVODbkoJO77/6t/wyGqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770725430; c=relaxed/simple;
	bh=mkUVIK60t4T2vSAOAbObkP6gitCm1yccb8Va6AHVWAo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aOWqH4umDLQ2NAXuuMJX0jmz9RQeu3qr41mupYRHa2l8tISLYHG2WRG2RH3djvZg4I/kSWQ5YRUprDuq0kf0kmvWszpsc7mOwx3csQpJ2tAvcFzc4TANuXFPAOMH4g1HT2e/qHxKFnOEkObk/yVM+7QwKz97VbbUIBpolwLF3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o45mhnpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAA6C116C6
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770725429;
	bh=mkUVIK60t4T2vSAOAbObkP6gitCm1yccb8Va6AHVWAo=;
	h=From:To:Subject:Date:From;
	b=o45mhnpGcF+a6DUwms77L5BESAzkKtLSha/EvH4eQL7Okvs7hKEALMgv4gNDHuXdn
	 CfmGLWRcUDyUYYak38i/Za44FPz9N88WlbjSjjQhuGofLeP3kPNPfybtv87/sjp+r6
	 VAXVjQjStNUytamV15QrkKGgCmsQ2OGQlmiV16KjvzOG+2M+zjEPMdhEQsEhcZkPff
	 gy1Chj/I2Kuiw/SfRdti4t5u/lp1M4rp0JtWFAyBLpjdlSLDSIHhH8ztTRx4LYR3Zr
	 KfNAMeA3nxQgh4GyaDl8HzQJjSRV/czWPhj78oyjlf98XBweRxBlO8UVvA9lQ9gXa7
	 hq7FzYKPatHTQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove pointless out label in qgroup_account_snapshot()
Date: Tue, 10 Feb 2026 12:10:27 +0000
Message-ID: <b9fdf03c58efd3a7f53472de443054e6c2d9ba69.1770725404.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21604-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1567F11A901
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

The 'out' label is pointless as there are no cleanups to perform there,
we can replace every goto with a direct return.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 746678044fed..98fb8c515a13 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1602,16 +1602,16 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 
 	ret = commit_fs_roots(trans);
 	if (ret)
-		goto out;
+		return ret;
 	ret = btrfs_qgroup_account_extents(trans);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/* Now qgroup are all updated, we can inherit it to new qgroups */
 	ret = btrfs_qgroup_inherit(trans, btrfs_root_id(src), dst_objectid,
 				   btrfs_root_id(parent), inherit);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/*
 	 * Now we do a simplified commit transaction, which will:
@@ -1627,23 +1627,22 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 */
 	ret = commit_cowonly_roots(trans);
 	if (ret)
-		goto out;
+		return ret;
 	switch_commit_roots(trans);
 	ret = btrfs_write_and_wait_transaction(trans);
-	if (unlikely(ret))
+	if (unlikely(ret)) {
 		btrfs_err(fs_info,
 "error while writing out transaction during qgroup snapshot accounting: %d", ret);
+		return ret;
+	}
 
-out:
 	/*
 	 * Force parent root to be updated, as we recorded it before so its
 	 * last_trans == cur_transid.
 	 * Or it won't be committed again onto disk after later
 	 * insert_dir_item()
 	 */
-	if (!ret)
-		ret = record_root_in_trans(trans, parent, 1);
-	return ret;
+	return record_root_in_trans(trans, parent, 1);
 }
 
 /*
-- 
2.47.2


