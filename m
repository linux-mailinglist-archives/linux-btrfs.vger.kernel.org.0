Return-Path: <linux-btrfs+bounces-21368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG64Ic1rg2l+mgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21368-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 16:54:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645A6E991A
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 16:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8ECF0300D74C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC1421EE3;
	Wed,  4 Feb 2026 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAz4aDHI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4F421A17
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220334; cv=none; b=dfOZWk/Jbr4nkwjD0EOgBSTrIdPvqbkPrV//Z5FbjGJVDD14ON9QTBIu9cMfHxZ5rW8K6fuR2Cv9EmMi4c6ykZKrkykun5CSBYL0AoPX5bwmQeMDzlJMY1hQVDtJVKjXiNH8bGLSV98504F5C3Y2UMrmV6ya2GWyTc9IK/TFc+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220334; c=relaxed/simple;
	bh=CkLOG90Vy5SHI9VFpsm6Sxny5e98Uf8LGoJPaBTxjNs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFvheZ6OfnHLt5H4bXm00LAr9MJwhIF2iaO4wK8BDnicw2XM8SbIRaihH05Vc7Ovbuwy3O5s3wRZDk0arGtNxfwLNWCMukjK+nL9nPgeosSc8cNaapgqTetiyEyBJyG4qG2HO9BIIMqPv9YG+Vw2zoSfJqZEsjuWQx3EibCnNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAz4aDHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045BFC116C6
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770220334;
	bh=CkLOG90Vy5SHI9VFpsm6Sxny5e98Uf8LGoJPaBTxjNs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JAz4aDHI9LcOZmG7jLx+uBNJbtxeaNlKubcq3hxfcFWkryUmg6fzeXcAbkvm2cu+D
	 mynrwCSN8vvlJ5RDXn7t7pdiegNaqjFBw9KORMkEL8IkcYGbNFccmf6iO7stGwUuJ5
	 TD0GzWWs+XHeZuwoPenTNSyEbKVh4kH7BgqUK4Y1oNBoMqZ/GeMMu6JaVy0+XU6VS7
	 GRi/u50KRIx+idXGx0MCj3QbQURBRI+bLiE22V0FYz9GrMXRfdpEDr44W+SFEPiexG
	 qReoJ3KSBa+1F0IsGm4DQ/SGNGqAujxpW/hEzADXFmzu1IPYk7nV8jJ9dynZ6Dr4SQ
	 gJUJBePGdrkyA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: change unaligned root messages to error level in btrfs_validate_super()
Date: Wed,  4 Feb 2026 15:51:58 +0000
Message-ID: <b041b0f874dcc81db99b22f871dbb31093bffd24.1770212626.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770212626.git.fdmanana@suse.com>
References: <cover.1770212626.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21368-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 645A6E991A
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

If the root nodes for the chunk root, tree root or log root are not sector
size aligned, we are logging a warning message but these are in fact
errors that makes the super block validation fail. So change the level of
the messages from warning to error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 069f8017d425..a6011da279e3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2425,18 +2425,18 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 
 	/* Root alignment check */
 	if (!IS_ALIGNED(btrfs_super_root(sb), sectorsize)) {
-		btrfs_warn(fs_info, "tree_root block unaligned: %llu",
-			   btrfs_super_root(sb));
+		btrfs_err(fs_info, "tree_root block unaligned: %llu",
+			  btrfs_super_root(sb));
 		ret = -EINVAL;
 	}
 	if (!IS_ALIGNED(btrfs_super_chunk_root(sb), sectorsize)) {
-		btrfs_warn(fs_info, "chunk_root block unaligned: %llu",
+		btrfs_err(fs_info, "chunk_root block unaligned: %llu",
 			   btrfs_super_chunk_root(sb));
 		ret = -EINVAL;
 	}
 	if (!IS_ALIGNED(btrfs_super_log_root(sb), sectorsize)) {
-		btrfs_warn(fs_info, "log_root block unaligned: %llu",
-			   btrfs_super_log_root(sb));
+		btrfs_err(fs_info, "log_root block unaligned: %llu",
+			  btrfs_super_log_root(sb));
 		ret = -EINVAL;
 	}
 
-- 
2.47.2


