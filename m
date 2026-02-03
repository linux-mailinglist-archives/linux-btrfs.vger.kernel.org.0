Return-Path: <linux-btrfs+bounces-21345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM48ID2HgmnDVwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21345-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 00:39:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF00DFCA8
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 00:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A320430D2FE2
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 23:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6B932D44F;
	Tue,  3 Feb 2026 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W211tCkg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626E330B27
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770161946; cv=none; b=sNscngky9k+EGbGJCWUd0CfiViCbLrEnqronhX+ikIRTthj5erAM+rcMooYD1E89pTse8ZcBNbNMcewR1rgxQFia3EAtj4U7QJK50+FTcc6WOVu0oQjM9Q9ne+Xyf+kMHP/gD1zU+6YXI8c0JZ5FI3PmBLpFgE3pEDDsW1jYiD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770161946; c=relaxed/simple;
	bh=/E2N757ug3ZhnbC0M7AfThTckHlqqbJOZcBYTSjp0wg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nk6cXj7achzEkYN/86gn5lMvz0s9C0GVQ4Feukoa/sQeyHCax49dwV5WJCSt7yPIUP0Ep6EgyYqFYN7qP2xLCsA3dJ1uHPO88NFE5L9bMR53NQECXWKidwLepzB59i3qYB5ljypOjmdSAod3+5/vw4p2C4jpsZZEiyl4HO39P1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W211tCkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97D2C116D0
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 23:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770161946;
	bh=/E2N757ug3ZhnbC0M7AfThTckHlqqbJOZcBYTSjp0wg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=W211tCkgblgOMcZ1/SLUT5M8W9iK65UhDVWvRFYiaEA8/y01wjetdgwdI/AHz9CZx
	 CJSY7qFpV8Qr0RYjJVwmc689xA0UXuSw/tfle0W9LnZOY5bmrx3Lgy5cEdhb6ZEIyu
	 NdfBc2BBFF/Ghxpm/HhT0QbIigIJQ3gElVugtDiPONJB4Ntq3TRn8JGonZUa0zI3Dk
	 R0oJ9q4c/sPTCUbogYN2egFE7SwwHBHMKOEr1fVnA/Q4is14k8chag+XUZYZHPa7Ov
	 y+EVFTaGnOBzDg3NjFxF24QDnjeJ9bOkCQXcPICq6K/Cu3wiAVK+7wK+f9+DaQl4cF
	 NOOR8P7ltcynQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: don't allow log trees to consume global reserve or overcommit metadata
Date: Tue,  3 Feb 2026 23:39:00 +0000
Message-ID: <58d04071d4bf689fc5814c030a3c7b37103021ad.1770161798.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770161798.git.fdmanana@suse.com>
References: <cover.1770161798.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21345-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: DBF00DFCA8
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

For a fsync we never reserve space in advance, we just start a transaction
without reserving space and we use an empty block reserve for a log tree.
We reserve space as we need while updating a log tree, we end up in
btrfs_use_block_rsv() when reserving space for the allocation of a log
tree extent buffer and we attempt first to reserve without flushing,
and if that fails we attempt to consume from the global reserve or
overcommit metadata. This makes us consume space that may be the last
resort for a transaction commit to succeed, therefore increasing the
chances for a transaction abort with -ENOSPC.

So make btrfs_use_block_rsv() fail if we can't reserve metadata space for
a log tree exent buffer allocation without flushing, making the fsync
fallback to a transaction commit and avoid using critical space that could
be the only resort for a transaction commit to succeed when we are in a
critical space situation.

Reviewed-by: Leo Martins <loemra.dev@gmail.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-rsv.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index e823230c09b7..fe81d9e9f08c 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -540,6 +540,31 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 					   BTRFS_RESERVE_NO_FLUSH);
 	if (!ret)
 		return block_rsv;
+
+	/*
+	 * If we are being used for updating a log tree, fail immediately, which
+	 * makes the fsync fallback to a transaction commit.
+	 *
+	 * We don't want to consume from the global block reserve, as that is
+	 * precious space that may be needed to do updates to some trees for
+	 * which we don't reserve space during a transaction commit (update root
+	 * items in the root tree, device stat items in the device tree and
+	 * quota tree updates, see btrfs_init_root_block_rsv()), or to fallback
+	 * to in case we did not reserve enough space to run delayed items,
+	 * delayed references, or anything else we need in order to avoid a
+	 * transaction abort.
+	 *
+	 * We also don't want to do a reservation in flush emergency mode, as
+	 * we end up using metadata that could be critical to allow a
+	 * transaction to complete successfully and therefore increase the
+	 * chances for a transaction abort.
+	 *
+	 * Log trees are an optimization and should never consume from the
+	 * global reserve or be allowed overcommitting metadata.
+	 */
+	if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID)
+		return ERR_PTR(ret);
+
 	/*
 	 * If we couldn't reserve metadata bytes try and use some from
 	 * the global reserve if its space type is the same as the global
-- 
2.47.2


