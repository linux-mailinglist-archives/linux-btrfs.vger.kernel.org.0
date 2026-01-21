Return-Path: <linux-btrfs+bounces-20818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HVvOfK2cGndZAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20818-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:22:26 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D794B55ECD
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7597686FFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A71480958;
	Wed, 21 Jan 2026 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLs/PaXX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CFF47276F
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994044; cv=none; b=itT1OMZ7uDRUQ2vtqUlfcyNd/xCbCPdwM2jFHPYqIoB4D8Z7+5/eUsdNmAj6vB43HteFmp4A0Zn4fCvLi4wMmFI/zZwupSJa9dU3rkDIna+Ks+JHn1bYIsUIvFhPahl/THDrQXzPFq6/SVHIzYZpwxfsNlpkYjn/50hZaD490x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994044; c=relaxed/simple;
	bh=m7Jbad55f32q0cgYed3wHEdNyDDNb5Xfcg0L4OGQJ4Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtRwk8EX3XmYRebwL4GwDdwMXgu6yKHwsa5XaRq1uSapnxtbJ6z0l/9t0CEZm5UL5yYm2XBUCnBknbYZJdsMo5AtMYfB7wjT4ONjfSMI38PSZXvx/zUxeuwNxG/Y7iIHbjxla0CRXj5PIveuoqloVZMjXq7eBJ23Dne8BKJBP64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLs/PaXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6104C19422
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994044;
	bh=m7Jbad55f32q0cgYed3wHEdNyDDNb5Xfcg0L4OGQJ4Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KLs/PaXXVTbcEngp4AS5z8+XzMUkvSKuJlMTqi+wr/RDTYDNpnWZhxVA6k0Wg+xjn
	 d/unNypbIDpmNIwZ/8ySTNQTauhmkOVsttcRu9vYrzAKoeIZEGAwRJSlKQSSAv5Mzh
	 0YPivxhPjD6ddAOIYCpZdqWsgmiKsIl2cnr358tqkADnsHVPLUT1j7AsKUS3lKa7ZQ
	 PyJ9LCwCRhlZ9FtthJP641/voLgRkulKLqJcsLcApKmpvZvnV9gpnHjPmGRyD8EzQP
	 uSqE7TJgjoTdfrnhWb0syjc7o1o4N7FxdDV61GPBW4hKIc5DMvVNNl8giHnCDDMWtx
	 Mwlb8objn3xQw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/19] btrfs: remove pointless out labels from inode.c
Date: Wed, 21 Jan 2026 11:13:42 +0000
Message-ID: <c451716b7deebee4a4cb56b873451dc71830235e.1768993725.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20818-lists,linux-btrfs=lfdr.de];
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
X-Rspamd-Queue-Id: D794B55ECD
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


