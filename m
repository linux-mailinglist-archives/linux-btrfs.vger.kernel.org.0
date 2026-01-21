Return-Path: <linux-btrfs+bounces-20816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O+hBj65cGmWZQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20816-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:32:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1A256087
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7A4696733C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF6B48094E;
	Wed, 21 Jan 2026 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjMd/PL1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0F45BD68
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994042; cv=none; b=Fardd/BMto5F/uNI5DO9bL+d2zEmCtAnPVgMsJntWj7dKoqR5C71/7gH4LfxYan3lZsSiAG6fa7t5PAakZraW8pQvPjW2MTy+Jm+HsCaqpS8LDfS4q1jSJXns7RW5TgGPvPzprZ6PkPyGd3693mdDS14zA5/E+4lvqc8o0I65nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994042; c=relaxed/simple;
	bh=4xkEFk5ci2qQ2IX3QHCdUwfTgaTL8iREMB/dd//CDZc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlUYBRONOHwtoiFNYuk/f3XXzDs/irGQB2T6ywlQbCagixgWGPELIqlt2yf6+xYN1fnsmLAEIL/CclfwU0qzkyDi5AmSWtouGyyxbzNJLiTmXomy72Edjeobvq8GtU0OZc0CY3ds8/HeGUiHpiCSSu9SYoc8oDTp2quyMI9bTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjMd/PL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1584EC116D0
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994042;
	bh=4xkEFk5ci2qQ2IX3QHCdUwfTgaTL8iREMB/dd//CDZc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BjMd/PL18L7jb4leBYSe6Nk5AGGpO65T3t1GQ6zikdnLFgS9qIyJVreDdExJbUMmj
	 l3W7SJ38EX3lVdgomJ58ZoBE8GSOE72jArAvlNXRs+O/b81SyScqy63mtppuLwzA63
	 qrGf+in09mBvzbejSVl9GNfB3KRyCkviGBRwivxCWXOUwuCd4aI4/tmsbQeeBJKso1
	 ytGE/yc7K1eMogZxZylgUS9UqqtVw0NCZ8DbsdIndF+Fe+OzCBYLk4LPJkVE6eXoR1
	 MYJJNFgV1WRDALIwTMmr8COgpFK0sKZR86F6ik1jVMsSKonQzwW1XAx9BQ0CP29nTT
	 DvUh4kd5gVNwg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/19] btrfs: remove pointless out labels from extent-tree.c
Date: Wed, 21 Jan 2026 11:13:40 +0000
Message-ID: <da3c4279f7ee608e3073d9e01e4fc5964859cfd8.1768993725.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20816-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7B1A256087
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


