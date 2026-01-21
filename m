Return-Path: <linux-btrfs+bounces-20847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MReNGgpcWniewAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20847-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 20:30:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A971C5C335
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 20:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A34FC78C053
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCE04963B8;
	Wed, 21 Jan 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClP8u1X4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5AB34EF1B
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013056; cv=none; b=XB4X6uA0AOcsfaytgBJSH3Xgw75xLvyOwOFHZIy97z8kPl6tj5p/imvaQhRaylZG1zBw9G1gqZJ2PM+3FGe0vvP3BwyA1IupOIGnXUtXhQ8dQq/1f8vVCM4yKlRVgvlSqsw4py7t0wbo8bfuhACl2Y8qIQR/g8uBxfGDSJPEwWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013056; c=relaxed/simple;
	bh=m7Jbad55f32q0cgYed3wHEdNyDDNb5Xfcg0L4OGQJ4Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYNgs6yL5Xoemq17SzYgZYR4RnM67kTEBGKSS8pBmA5gYJstIRCjTlx1GMOK1a7m22LVB/VZk+HynKdiG9NOjFTgVa2D6qMdzAFfUeW6W7gZJ3Lq3aF5qsPzN0NTosJM4pl8lB+QZSX8U9DWdKkviEJPa9PZ3GE56sy3gGANIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClP8u1X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD28C116D0
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013056;
	bh=m7Jbad55f32q0cgYed3wHEdNyDDNb5Xfcg0L4OGQJ4Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ClP8u1X4tptf0aX6xnfnT9OAYzvCtkcBfhhJpJSL88xtSkgPrn3N7edQOUjrhIeHQ
	 /NCmYpKUAm0TBeP7oraguDrKYulmCTo5pwRtKdGaFHn+uvncy4r+W0Um4n3HpXRqmh
	 OQXPlZNgFFNkCd8n58XqC8/HLK1DTS21IjLYV3XBV4uo1+xDLJxPeLbEbtwihdmj0x
	 2E8aNpSJMxH6lo1M7HH+9wJrqC1agM8YkAO8JF3toSuZXD8fVHreI23YrLZlM2wDn+
	 CxpH8WNyNH8byxuU9Is0mVYpw3POKGw1JB8/8HAIuBKijhmz4gMCSZW3YiW9BhSC9K
	 ebiliRkeX4jWg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/19] btrfs: remove pointless out labels from inode.c
Date: Wed, 21 Jan 2026 16:30:34 +0000
Message-ID: <da3078320833416629fc6e327be4aa208b53b61f.1769012877.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20847-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A971C5C335
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

Some functions (insert_inline_extent() and insert_reserved_file_extent())
have an 'out' label that does nothing but return, making it pointless.
Simplify this by removing the label and returning instead of gotos plus
setting the 'ret' variable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fa110827aaab..09a7e074ecb9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -507,7 +507,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		ret = btrfs_insert_empty_item(trans, root, path, &key,
 					      datasize);
 		if (ret)
-			goto fail;
+			return ret;
 	}
 	leaf = path->nodes[0];
 	ei = btrfs_item_ptr(leaf, path->slots[0],
@@ -546,7 +546,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	ret = btrfs_inode_set_file_extent_range(inode, 0,
 					ALIGN(size, root->fs_info->sectorsize));
 	if (ret)
-		goto fail;
+		return ret;
 
 	/*
 	 * We're an inline extent, so nobody can extend the file past i_size
@@ -562,8 +562,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	}
 	inode->disk_i_size = i_size;
 
-fail:
-	return ret;
+	return 0;
 }
 
 static bool can_cow_file_range_inline(struct btrfs_inode *inode,
@@ -3037,7 +3036,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	drop_args.extent_item_size = sizeof(*stack_fi);
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (!drop_args.extent_inserted) {
 		ins.objectid = btrfs_ino(inode);
@@ -3047,7 +3046,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 		ret = btrfs_insert_empty_item(trans, root, path, &ins,
 					      sizeof(*stack_fi));
 		if (ret)
-			goto out;
+			return ret;
 	}
 	leaf = path->nodes[0];
 	btrfs_set_stack_file_extent_generation(stack_fi, trans->transid);
@@ -3082,13 +3081,11 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_inode_set_file_extent_range(inode, file_pos, ram_bytes);
 	if (ret)
-		goto out;
+		return ret;
 
-	ret = btrfs_alloc_reserved_file_extent(trans, root, btrfs_ino(inode),
-					       file_pos - offset,
-					       qgroup_reserved, &ins);
-out:
-	return ret;
+	return btrfs_alloc_reserved_file_extent(trans, root, btrfs_ino(inode),
+						file_pos - offset,
+						qgroup_reserved, &ins);
 }
 
 static void btrfs_release_delalloc_bytes(struct btrfs_fs_info *fs_info,
-- 
2.47.2


