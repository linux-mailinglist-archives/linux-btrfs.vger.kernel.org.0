Return-Path: <linux-btrfs+bounces-20958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG1ELENLc2lDugAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20958-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 11:19:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A9E7438B
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 11:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4563302BDC6
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE582EA168;
	Fri, 23 Jan 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blA3/PQi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE564309DCB
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163483; cv=none; b=t6w5hZmAXZI0wlXPwDxO1DgCff2DJv2NPaiq+CukoR8BezHgurh6EIg/DHsaJADKh8PdRHG443GH3hjlI5jpKfNbCQdVj16srRFqDsJqXEGYsFRfIpApp9j+nvLLmmVOPkQOEwRc0O9I3i1YO3yapNK0T5WdXV88dWh1bh4oShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163483; c=relaxed/simple;
	bh=oHhwjz2341dhwQ5apzLGVbGQaBlX35El/wUigga9viI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q40GWc1Y5wsHCGJViD2pxJ6OnY6biJayUiaLiDAHckY8Khf4n3f4k/quEXzbE8C1lwPxIsF2iAoTutThLoIwA4wyKeV1b+d+XO2uQ56AX6A1Nkm8fuGZk5XzT3oVbrWIy/iBhY9b39c2JcBcYUtYYYig5ctVVtdmsfaabmwsGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blA3/PQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A47C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 10:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769163483;
	bh=oHhwjz2341dhwQ5apzLGVbGQaBlX35El/wUigga9viI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=blA3/PQiQiGRgnN2FsnovJleCaovFgE4MEVa/TmzPuFce6ZuF59eXE6nh6RDA6TCV
	 w3xkUZmK/TAJuEDbKfLOiXqym19rVjqGmTfAwdC6k4qbLxOZsRBRQzOpO3r9yVVP/a
	 U6cz28ZlI7OlK6255dlZOR9EV2j6LyAiLzMohd6MMWZJqGHqFwF2lo37RQxE4X9V2P
	 LuZ2CpYOAenOjoGyEoTo8fAM1/mtX0aVv5KBU7u6OQV6JiS3VIPDLNdgoDhwKajzkh
	 rZ40yEZpgir55ljDyOKSSt1/no+05yYI3QZvoJXpaMtAZK6OG4TuPxtskwqMx3rAzZ
	 MRR6LOfOBTjOA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: do not BUG_ON() in btrfs_remove_block_group()
Date: Fri, 23 Jan 2026 10:17:58 +0000
Message-ID: <452b70fb63d201693726a31e935a201776b79564.1769163248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1769163248.git.fdmanana@suse.com>
References: <cover.1769163248.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20958-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.970];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51A9E7438B
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

There's no need to BUG_ON(), we can just abort the transaction and return
an error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7b723571501e..3186ed4fd26d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1113,7 +1113,12 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		return -ENOENT;
 	}
 
-	BUG_ON(!block_group->ro && !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED));
+	if (unlikely(!block_group->ro &&
+		     !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED))) {
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
 
 	trace_btrfs_remove_block_group(block_group);
 	/*
-- 
2.47.2


