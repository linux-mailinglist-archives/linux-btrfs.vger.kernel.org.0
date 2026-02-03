Return-Path: <linux-btrfs+bounces-21314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ExlCgTzgWkMNAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21314-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 14:07:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D6D9A99
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 14:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC6D93039369
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871DA34EF19;
	Tue,  3 Feb 2026 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPf29dR2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80AF34C9A3
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123757; cv=none; b=eZcrxp9TFNWrEz5zqodywimEHi4a7KClYIGP2kM8lJ9kZNcm5moM/4dXsg6I51XTnLiQm9FicYU0Su6ogFVKQGJMAqqQpLaBU6sGJukfJvecZl3LEhehpY/DDtNkRXS/uszgmbRcyqN7Hf6uhLnWI3jdhiHgIWoqJmYX19iEPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123757; c=relaxed/simple;
	bh=FnukXpRC9C+CahC3i2T7DBOga7Qj5JKXm3EGASRIMK0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkR9QbfWBEskHMSIhCHgXz+/3g7kHyfb4jJRj1UsuDM/4uNDMvdHMR+r7RGJkvMm4v5VakTHebcZ1ozqWx0nJrBqodEw6CwlxJStbTno8rDJX/fyUdn5jWlKY+ckDS8dmwALfbn2k0zlShnckJrxAAdjns27oCsEXH024s++4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPf29dR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216FBC19421
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 13:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770123757;
	bh=FnukXpRC9C+CahC3i2T7DBOga7Qj5JKXm3EGASRIMK0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VPf29dR2ierqbsjylE93prtZ6q15UWcrQYjpV0R0DgMcESRNZahULTOwYq4eBG4HR
	 JoVQiWoOXVof07OH9lihN6nqIQOjzf9pLoiP2y8tNdPGVhqnmrwarCUgVzngM2F5Fy
	 D9MhX6aNyjmLb4X58KL9D63oPN2PcOawbifJ6wKFp5przVHt4dJljAOeg+8wcQIqK+
	 b5jvxFH+izjGDl6RWGsOR6V2Di+bZe5M2HS2HrQ8qc1LOddPI83DKhBY/PGbxJTGAP
	 fZgjdxOyKWKOWUgHPDTZoASHw3SrWCjjwPzi3wDQqge1VD67jQ10q4J0lAY/uQxJGG
	 +SFEI0+y75W5w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: don't allow log trees to consume global reserve or overcommit metadata
Date: Tue,  3 Feb 2026 13:02:32 +0000
Message-ID: <2e171d116e186d839cde6430cb42551aaea5943e.1770123545.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770123544.git.fdmanana@suse.com>
References: <cover.1770123544.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21314-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 509D6D9A99
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


