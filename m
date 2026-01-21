Return-Path: <linux-btrfs+bounces-20822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKqBHXi7cGkRZgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20822-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:41:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAE75627B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D91E350CB3D
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3686D481229;
	Wed, 21 Jan 2026 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD4sYXyy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4E9477E30
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994049; cv=none; b=BGt1gkl/YyDUxj55fwvMEqeOkpNTPWa0v8vLGrYGXgvamOo/b9rioFnh9yhl65UuqsfCTuV8dBw75H/+RTvL5u50/JTBkuPe3Qke+eIAqJFb7yuwJNQW6h3Ay8mCKp4aGzqXU7RTPGSwoyrQ50MbIfKYTe7hKwfnWiVylkAIEJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994049; c=relaxed/simple;
	bh=nMOl2T0KpAO5544eEo+6Ur6v6RMtVI5rPfV6t8dCNhU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBpaxiWMLNflUijmuTjv5nrE+u/NzApGYpNvd/tCogmG1Ro37KJhjygNFkjgEPqpBVPy0AHbBCQ0CS4nBaLz7iL+2RSUDopYEOHNLDhcd7rvjcJFk6kWo9EWxWRst72Gup5GMcB8AR2bR7aauQKiYJ4KOmyYFIfb4IpIm+gbNqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD4sYXyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE91C19425
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994047;
	bh=nMOl2T0KpAO5544eEo+6Ur6v6RMtVI5rPfV6t8dCNhU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eD4sYXyy0H9umxnh5Dgnvd1yweITz97NnGP2hD+qKh0dZyepW1j5AV/aboog1PBqN
	 W4yHKx6Drd30BYbFlClqJePtgFrVk6VClKQYr9i8qllCK2w7xrTofw6YCBowCELYkO
	 XOJh2UX4xm3yFa+TBn1nZKhRqwCbMkpO2W3bJNb9bs3N9rgTLIMtMD1FO+8eMyhFs4
	 rdt8YBR9VubGEdqOtH3BZ85OtUs91PXKNVeFV4Kw4R4hyUTo1SgfH5n8lTy/drVCrc
	 zAXMFxdeXBUnUy5DU7rZ6MyDOYJoGrh2JznVTeBj4Pzsyex1TeZHiMP4dCqKbmCtwo
	 rxLa9bhQK0wcg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/19] btrfs: remove out label in btrfs_csum_file_blocks()
Date: Wed, 21 Jan 2026 11:13:46 +0000
Message-ID: <b9d2d3fb1662771e93fe2f2b935ebb39900161fa.1768993725.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20822-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: DCAE75627B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There is no point in having the label since all it does is return the
value in the 'ret' variable. Instead make every goto return directly
and remove the label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file-item.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 568f0e0ebdf6..7bd715442f3e 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1134,7 +1134,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	}
 	ret = PTR_ERR(item);
 	if (ret != -EFBIG && ret != -ENOENT)
-		goto out;
+		return ret;
 
 	if (ret == -EFBIG) {
 		u32 item_size;
@@ -1150,7 +1150,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 		/* We didn't find a csum item, insert one. */
 		ret = find_next_csum_offset(root, path, &next_offset);
 		if (ret < 0)
-			goto out;
+			return ret;
 		found_next = 1;
 		goto insert;
 	}
@@ -1178,7 +1178,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 				csum_size, 1);
 	path->search_for_extension = false;
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (ret > 0) {
 		if (path->slots[0] == 0)
@@ -1234,14 +1234,14 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			    btrfs_header_nritems(path->nodes[0])) {
 				ret = find_next_csum_offset(root, path, &next_offset);
 				if (ret < 0)
-					goto out;
+					return ret;
 				found_next = 1;
 				goto insert;
 			}
 
 			ret = find_next_csum_offset(root, path, &next_offset);
 			if (ret < 0)
-				goto out;
+				return ret;
 
 			tmp = (next_offset - bytenr) >> fs_info->sectorsize_bits;
 			if (tmp <= INT_MAX)
@@ -1282,7 +1282,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	ret = btrfs_insert_empty_item(trans, root, path, &file_key,
 				      ins_size);
 	if (ret < 0)
-		goto out;
+		return ret;
 	leaf = path->nodes[0];
 csum:
 	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_csum_item);
@@ -1307,8 +1307,8 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 		cond_resched();
 		goto again;
 	}
-out:
-	return ret;
+
+	return 0;
 }
 
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
-- 
2.47.2


