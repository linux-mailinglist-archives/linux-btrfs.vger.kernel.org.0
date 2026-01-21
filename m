Return-Path: <linux-btrfs+bounces-20845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHe+I3EecWmodQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20845-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:44:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C41F5B71F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3772B2E5C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E80741C31F;
	Wed, 21 Jan 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdtayMZN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FE48C40A
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013054; cv=none; b=PpWvGuEXl66xERnORV2FL+oPv+DPjP2oZ47omnb7Oo/YBhEKMBpaJc4yObCIxGX7HFs3KR2JZs0AkpScMkeNCb6MPBOGlWQ/03GJimVpD3rEe3xzoSP7KOkeGuKfG9VVcgC7INdHrgP6iMQ8XaRIbeRIiAjt66ZP8dCCgmb6yyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013054; c=relaxed/simple;
	bh=4xkEFk5ci2qQ2IX3QHCdUwfTgaTL8iREMB/dd//CDZc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4wSC2xBqPXtBJf2vU58lnrlG2X0628oPhir9Aq+ALMseSZuM2i1PsqWsYY2Sz/OfxNBE+5vrtOWem+/LzzOs66EmeaFnEcOR4L95+AYcsHUgSQ9NjfEG6W+EHKFq2mltir00+nSBrvsBK0VBnxrDpKMF+uF3chxVrYGQgCz5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdtayMZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5D6C4CEF1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013054;
	bh=4xkEFk5ci2qQ2IX3QHCdUwfTgaTL8iREMB/dd//CDZc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NdtayMZNLOAxfn2YjAKRDU2VlbakWx6n9dmr853lGZJyeq4kfLUQAVbF0osoPPRNo
	 BIZMjhxftdPqUK1YAkxZXvlCnQZqnJ+E4tER97AXvVWIhGO+kVFjRmRnNLvs8xoh70
	 qqOavLfsDaPKiKL7xBf9LExDDaGVhwu/rAZjEgmz/uUswN9cPqFkTuv9So5cApWTbt
	 HtMnwql9zaaG74nvJ5VNcJuydJ+ciQIAXKklG3Y9YMjdATooZZlvez6atNYeYQoHmQ
	 IJAmaCUTrHCjC5QvLKjdJb8gYzMguPVtjYQBA/QrTCYFMxzQQyJ+pMvFFnVQTtxmko
	 /V4nxDFldbuOg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/19] btrfs: remove pointless out labels from extent-tree.c
Date: Wed, 21 Jan 2026 16:30:32 +0000
Message-ID: <bd4bdff6be1620685f10b00ad70a8f2e7c96171a.1769012877.git.fdmanana@suse.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20845-lists,linux-btrfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org]
X-Rspamd-Queue-Id: 0C41F5B71F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

Some functions (lookup_extent_data_ref(), __btrfs_mod_ref() and
btrfs_free_tree_block()) have an 'out' label that does nothing but
return, making it pointless. Simplify this by removing the label and
returning instead of gotos plus setting the 'ret' variable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 10cac7229370..0ce2a7def0f3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -477,7 +477,7 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		if (key.objectid != bytenr ||
 		    key.type != BTRFS_EXTENT_DATA_REF_KEY)
-			goto fail;
+			return ret;
 
 		ref = btrfs_item_ptr(leaf, path->slots[0],
 				     struct btrfs_extent_data_ref);
@@ -488,12 +488,11 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
 				btrfs_release_path(path);
 				goto again;
 			}
-			ret = 0;
-			break;
+			return 0;
 		}
 		path->slots[0]++;
 	}
-fail:
+
 	return ret;
 }
 
@@ -2501,7 +2500,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 	int i;
 	int action;
 	int level;
-	int ret = 0;
+	int ret;
 
 	if (btrfs_is_testing(fs_info))
 		return 0;
@@ -2553,7 +2552,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			else
 				ret = btrfs_free_extent(trans, &ref);
 			if (ret)
-				goto fail;
+				return ret;
 		} else {
 			/* We don't know the owning_root, leave as 0. */
 			ref.bytenr = btrfs_node_blockptr(buf, i);
@@ -2566,12 +2565,10 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			else
 				ret = btrfs_free_extent(trans, &ref);
 			if (ret)
-				goto fail;
+				return ret;
 		}
 	}
 	return 0;
-fail:
-	return ret;
 }
 
 int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
@@ -3575,12 +3572,12 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 		return 0;
 
 	if (btrfs_header_generation(buf) != trans->transid)
-		goto out;
+		return 0;
 
 	if (root_id != BTRFS_TREE_LOG_OBJECTID) {
 		ret = check_ref_cleanup(trans, buf->start);
 		if (!ret)
-			goto out;
+			return 0;
 	}
 
 	bg = btrfs_lookup_block_group(fs_info, buf->start);
@@ -3588,7 +3585,7 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
 		pin_down_extent(trans, bg, buf->start, buf->len, true);
 		btrfs_put_block_group(bg);
-		goto out;
+		return 0;
 	}
 
 	/*
@@ -3612,7 +3609,7 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 		     || btrfs_is_zoned(fs_info)) {
 		pin_down_extent(trans, bg, buf->start, buf->len, true);
 		btrfs_put_block_group(bg);
-		goto out;
+		return 0;
 	}
 
 	WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));
@@ -3622,7 +3619,6 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	btrfs_put_block_group(bg);
 	trace_btrfs_reserved_extent_free(fs_info, buf->start, buf->len);
 
-out:
 	return 0;
 }
 
-- 
2.47.2


