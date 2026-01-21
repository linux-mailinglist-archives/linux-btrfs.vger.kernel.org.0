Return-Path: <linux-btrfs+bounces-20854-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHF/EhsRcWlEcgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20854-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 18:47:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 016AC5ABB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 18:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D1A380731D
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545864968FD;
	Wed, 21 Jan 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuMe0/V5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CB24968E9
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013062; cv=none; b=cQm4QjMKxteA8JUluMM7fEn+igKGTrBKUEdMWZtBkaYoQKD+zZJ44CNHxnbz3pz+tHANkuLiAyWbyjLGLJmT3H5ZtyOIsjX6dH9XHhFHZj9H/CHKqvvxDuLwVHs+N+NH1vEtTPfbD4xZBxfCabuIPYNhUsGhL1xO61S7AR/iXmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013062; c=relaxed/simple;
	bh=/2XI71i5MY7w1+/nv3NFX7/Htn87znLbmabywJC8h5o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0hG3VGneDZztZw/P6beEdx0CuWHD8nVOXLVIzALflo3v4YB4pCHRCQPfCFyM+4klX+t+7TAB6BGtivETgZPfXihRvo2yMITpd3gSe5ZspVUmUkS9j8FOD9OO3q4h2y9LDJ54evuITQEFg4ub3IRte5H+14LaGu7xanemkImB5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuMe0/V5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8DEC19421
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013062;
	bh=/2XI71i5MY7w1+/nv3NFX7/Htn87znLbmabywJC8h5o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kuMe0/V5t721YvDxQCo1Stz89bUiUH/B47ZuWyf8zKtVjpKToPSEj8wzT6fdI8Lor
	 F7rHocCkecbr11YYpAwPGmt+/nSXNdMAOEnf1iuMvya0hNZpPNey+wOMns2UKX2FQK
	 KE+Efai3XSOxaYJWCW7hijfdnDzcZVy0vug+TdFxB/D1Vyp9P/dvDq4RpQBw6AZuLj
	 WiXsCja4K6NVU59Md0rvBR3vskTcU/1qEibqHpFbLUdNE84Gs5HKPALKTihcKPMALT
	 pnjy/D9LcPpAS4SuSWYUr5kcLCD71vHosRwRgFdDVA4eAMosbTHWyj+NgEHMIyuolK
	 /jy+gUDcAP1JQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 15/19] btrfs: remove out label in scrub_find_fill_first_stripe()
Date: Wed, 21 Jan 2026 16:30:41 +0000
Message-ID: <4fee8a5e3a8146182aaadb6cd2f3a31358dabb14.1769012877.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1769012876.git.fdmanana@suse.com>
References: <cover.1769012876.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20854-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 016AC5ABB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There is no point in having the label since all it does is return the
value in the 'ret' variable. Instead make every goto return directly
and remove the label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/scrub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0bd4aebe1687..2a64e2d50ced 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1696,7 +1696,7 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 				     logical_len);
 	/* Either error or not found. */
 	if (ret)
-		goto out;
+		return ret;
 	get_extent_info(extent_path, &extent_start, &extent_len, &extent_flags,
 			&extent_gen);
 	if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
@@ -1729,7 +1729,7 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 		ret = find_first_extent_item(extent_root, extent_path, cur_logical,
 					     stripe_end - cur_logical + 1);
 		if (ret < 0)
-			goto out;
+			return ret;
 		if (ret > 0) {
 			ret = 0;
 			break;
@@ -1763,7 +1763,7 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 						stripe->logical, stripe_end,
 						stripe->csums, &csum_bitmap);
 		if (ret < 0)
-			goto out;
+			return ret;
 		if (ret > 0)
 			ret = 0;
 
@@ -1773,7 +1773,7 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 		}
 	}
 	set_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state);
-out:
+
 	return ret;
 }
 
-- 
2.47.2


