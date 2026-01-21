Return-Path: <linux-btrfs+bounces-20825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IVfMu+2cGndZAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20825-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:22:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 694CA55EC6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B05F6886AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B89348123D;
	Wed, 21 Jan 2026 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1ka718S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8219D478E4A
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994050; cv=none; b=ADdR44uUziHP/J6LsIMWhvrcVJqKA3q3SKawrojmT4ZgRzY24uAHyjbiTNtXX+TkS511XIleou4AlIz/xHGEa0wl4a4AScwS/j7VmaxniIj0kkl99W0IAoIfHquCdLpM9OAZcFlPHiPEC5TMN9b6CSk76VF+TmMCUtBZ/uyEsvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994050; c=relaxed/simple;
	bh=/2XI71i5MY7w1+/nv3NFX7/Htn87znLbmabywJC8h5o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXc6qq59Z4XeEYvqEoVETnGFzzOuqacrj9IqveujMWkT6ABUYg3nel43CJAKmboDnTR+DWTVA9kzrcZM4VtAdpkl1Xu8AY/i8veCPz9KyXlxPPIG9rI7G4s15fB7oM/yCQvJZ7+tp8oCa2jGmgop9cyW+nrNhJegEO3+6EAK8YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1ka718S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF757C116D0
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994050;
	bh=/2XI71i5MY7w1+/nv3NFX7/Htn87znLbmabywJC8h5o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G1ka718Snnrunhj5Gi6iDSeAupp1w2a1xoUBpDQcfVW/M/4MVUsm829MMloW/YhkQ
	 pM/GoJZ6VdIWa4m1KkqKASYgU86MMsmG87Dh9ZGc9O5mJwnRemZMtGQX5Vft3ntOcH
	 /dc27XsxcSkjA8PG13CW8JmFFuN1hauJx+unyuMCZvHTwBIFMbvhN3ln62PFYM4PUG
	 Jc9QeTkhJITOFevTNniZdB1WklFUP3mzH7PAqu26Dh1OYIEzLBGRokwWtaTTF9KRoD
	 K9iKGGsQZYLVkjLf81gBjZLaB5E7sn3y5eFPdHPwn3zQm6EwZtJFHyDf7WzEvlkh24
	 fJHpYs0Ky7bnA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 15/19] btrfs: remove out label in scrub_find_fill_first_stripe()
Date: Wed, 21 Jan 2026 11:13:49 +0000
Message-ID: <796454a8e46fc0ab08932e40ebb9fbf54195258a.1768993725.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768993725.git.fdmanana@suse.com>
References: <cover.1768993725.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20825-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 694CA55EC6
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


