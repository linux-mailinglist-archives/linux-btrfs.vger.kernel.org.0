Return-Path: <linux-btrfs+bounces-21355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OoNEopBg2kPkQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21355-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 13:54:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7BBE60D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 13:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19D2B30DA3B5
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 12:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69753F23BE;
	Wed,  4 Feb 2026 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giQYpTwU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439DE32D0F0
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209314; cv=none; b=usi5PpQS9oXFGgJrFGEzyDRejvo54YJTpvVs10BsufMh4X0HytMDltLZIhFMU2xDXNmV5RVch0C3EeNCU2Hqd6s/rU9Ke4gQ8FBXuDElP2280rDj9MtKWU71MiVoH2Yz8jRlOJHw2u2pvFU1PTeHHKtDVuP8aAdGLAVDywwgOEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209314; c=relaxed/simple;
	bh=FfYm2g930k0Fs2tFBqJ2PS1E7Q1z9dNTIEZu5Jyfgd0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI3wG4frieiH/iChygPR95wKqzwW3ULgxbjcRxnAAZZs9uu1H9b26TOAYIzVhLm5TdR3hVCvmHkPwPOds9LjFKS83DHAgSY278vNtQ7amSIbpLQNMQCtoDUGqbzxvStGTFSqhUju8VkiyMrjBytzWzz98UmFyIjq4DmUlYKeyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giQYpTwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685DCC4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 12:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770209313;
	bh=FfYm2g930k0Fs2tFBqJ2PS1E7Q1z9dNTIEZu5Jyfgd0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=giQYpTwUyty8rJ04ylwsa7kal1moefLWkhZp1XYClatCXyv+ergBkoIdq4y6zF0ap
	 xBbuNcxR2kdAeZVvoYKc+uzk18Kp1ezs49GZoG4ka4g6FY4xroNheV++9mNvzHEbLK
	 4afEOSji9sVFkmuB+v9fwxyVtg0WiGkF2ueDpYS2xKQlChkecDxV7Obv/q0vMJ/X0P
	 fEAQORPWDjlZYyCt8Pg8xSGVyWlwP5AUunvo5Avyx/qFHIezUoQ2ghFS9n+9Db3qeq
	 F55ru8wQ5vhrYk6638FmLNdkuA+YUSzQ6pp/g3AAtXh+bocnLzJ9AEsLMy8fnEH6I2
	 iAtB8f5Uuanlg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: use the correct type to initialize block reserve for delayed refs
Date: Wed,  4 Feb 2026 12:48:31 +0000
Message-ID: <45801be3be6d71e6e75020ae8d31c9dafca8c1a4.1770209077.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <c16363c678a392fafd249223228c6c75985e4a59.1770141624.git.fdmanana@suse.com>
References: <c16363c678a392fafd249223228c6c75985e4a59.1770141624.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-21355-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F7BBE60D5
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

When initializing the delayed refs block reserve for a transaction handle
we are passing a type of BTRFS_BLOCK_RSV_DELOPS, which is meant for
delayed items and not for delayed refs. The correct type for delayed refs
is BTRFS_BLOCK_RSV_DELREFS.

On release of any excess space reserved in a local delayed refs reserve,
we also should transfer that excess space to the global block reserve
(it it's full, we return to the space info for general availability).

By initializing a transaction's local delayed refs block reserve with a
type of BTRFS_BLOCK_RSV_DELOPS, we were also causing any excess space
released from the delayed block reserve (fs_info->delayed_block_rsv, used
for delayed inodes and items) to be transferred to the global block
reserve instead of the global delayed refs block reserve. This was an
unintentional change in commit 28270e25c69a ("btrfs: always reserve space
for delayed refs when starting transaction"), but it's not particularly
serious as things tend to cancel out each other most of the time and it's
relatively rare to be anywhere near exhaustion of the global reserve.

Fix this by initializing a transaction's local delayed refs reserve with
a type of BTRFS_BLOCK_RSV_DELREFS and making btrfs_block_rsv_release()
attempt to transfer unused space from such a reserve into the global block
reserve, just as we did before that commit for when the block reserve is
a delayed refs rsv.

Reported-by: Alex Lyakas <alex.lyakas@zadara.com>
Link: https://lore.kernel.org/linux-btrfs/CAOcd+r0FHG5LWzTSu=LknwSoqxfw+C00gFAW7fuX71+Z5AfEew@mail.gmail.com/
Fixes: 28270e25c69a ("btrfs: always reserve space for delayed refs when starting transaction")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Add the missing change to btrfs_block_rsv_release().

 fs/btrfs/block-rsv.c   | 7 ++++---
 fs/btrfs/transaction.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index fe81d9e9f08c..7eeb205870d3 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -276,10 +276,11 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_rsv *target = NULL;
 
 	/*
-	 * If we are a delayed block reserve then push to the global rsv,
-	 * otherwise dump into the global delayed reserve if it is not full.
+	 * If we are a delayed refs block reserve then push to the global
+	 * reserve, otherwise dump into the global delayed refs reserve if it is
+	 * not full.
 	 */
-	if (block_rsv->type == BTRFS_BLOCK_RSV_DELOPS)
+	if (block_rsv->type == BTRFS_BLOCK_RSV_DELREFS)
 		target = global_rsv;
 	else if (block_rsv != global_rsv && !btrfs_block_rsv_full(delayed_rsv))
 		target = delayed_rsv;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index da50fbd68853..aea84ac65ea7 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -726,7 +726,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 
 	h->type = type;
 	INIT_LIST_HEAD(&h->new_bgs);
-	btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_BLOCK_RSV_DELOPS);
+	btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_BLOCK_RSV_DELREFS);
 
 	smp_mb();
 	if (cur_trans->state >= TRANS_STATE_COMMIT_START &&
-- 
2.47.2


