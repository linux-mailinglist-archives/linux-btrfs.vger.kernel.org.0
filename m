Return-Path: <linux-btrfs+bounces-20826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F+nLsq4cGmWZQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20826-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:30:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D405600E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DD35968A62
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FB1480DF4;
	Wed, 21 Jan 2026 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dy0aWgQm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB948123F
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994051; cv=none; b=aPet88fBCr/2c4D+v46vv15WO2Ls6xlFherlxxZanM8wAj6TMjOcLtNbBN4w2fQ67TeQA4x0hKJNsP8LeETe0oji2gJIuDOAWFbmdGxBFzvPitEnQv0+albc9eILtdE/TzbrZD03jLiNDOle9fSJHbhfZXsT3z1pYMgt5ArLogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994051; c=relaxed/simple;
	bh=yYQTCTdUEkX9emXBwk//QID0a1Y1QnVOVAs8IPOngnE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qL0lxUPZaGclEeZzrF9axlDl8jbN2Q+NzI2ZNsJbJjtqHYVRkSVJHxTGDqj6ffJsLR7OdGMuU+xaoWA4ayx6gToSK51s5uI3oEX7p07X/68j8BnPiN/jyX7CsjwguzujFTVLoschH80QSwd8xfSA/SwQ4Vme1ES1QBm/EglC2xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dy0aWgQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB85C116D0
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994051;
	bh=yYQTCTdUEkX9emXBwk//QID0a1Y1QnVOVAs8IPOngnE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Dy0aWgQmxCCpk1iU+33kdoarujjQgFZuxjNT/qVaJzyBArlEVDLy/KkQJwqRvPd1n
	 uctmFalP4LZbRqxwm4Y2TwAvGmp9ps+psZ5s7BygNNWhtT8va8OPfge9ZkY7H+zbcF
	 KfkMnvUao58+GBUlfSbFA7AT3YWRlF+iTToyVznA2td8DrpovGTW5d1oqk9CTpQZGd
	 GaRG8DMVeErUHMvcykwWM+QSNV8nn+mvjRAou+ogwBsmXhQTWizF/u54R2mnyfd05b
	 2PZ530RyYYpqbwO6NaBzceNFNzQy6gPvXmwtv/05A/RkOTLDhQ0cOIVInHhiI/0ZJ1
	 E7WxPt0dK2cpg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 16/19] btrfs: remove out label in finish_verity()
Date: Wed, 21 Jan 2026 11:13:50 +0000
Message-ID: <1974159cc321acb84acea5ccef0427592a576cad.1768993725.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20826-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 45D405600E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There is no point in having the label since all it does is return the
value in the 'ret' variable. Instead make every goto return directly
and remove the label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/verity.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index a2ac3fb68bc8..06cbd6f00a78 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -525,23 +525,21 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
 	ret = write_key_bytes(inode, BTRFS_VERITY_DESC_ITEM_KEY, 0,
 			      (const char *)&item, sizeof(item));
 	if (ret)
-		goto out;
+		return ret;
 
 	/* Write out the descriptor itself */
 	ret = write_key_bytes(inode, BTRFS_VERITY_DESC_ITEM_KEY, 1,
 			      desc, desc_size);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * 1 for updating the inode flag
 	 * 1 for deleting the orphan
 	 */
 	trans = btrfs_start_transaction(root, 2);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		goto out;
-	}
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
 	inode->ro_flags |= BTRFS_INODE_RO_VERITY;
 	btrfs_sync_inode_flags_to_i_flags(inode);
 	ret = btrfs_update_inode(trans, inode);
@@ -554,8 +552,7 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
 	btrfs_set_fs_compat_ro(root->fs_info, VERITY);
 end_trans:
 	btrfs_end_transaction(trans);
-out:
-	return ret;
+	return 0;
 
 }
 
-- 
2.47.2


