Return-Path: <linux-btrfs+bounces-20849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMxRJu0RcWlEcgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20849-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 18:50:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 214F65AC14
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 18:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27FDB86F530
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09854963B3;
	Wed, 21 Jan 2026 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUmxkt34"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B5495531
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013058; cv=none; b=py9eANutmYWkMA8FDjl9QAAu41Awu/qBlo09DPlKA6WNzYoQcTA0fgS5l90hn1k4/80BoE+PtcP1V0flX48vtgw/pvWpdrilm9SYLvOQUWBkgtsYCHhwaErQQ5eOiWqyD+ytkGwwVYNZ4DfGxDnPp3WQUvoy/YPIg75sV/60IWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013058; c=relaxed/simple;
	bh=fkEhwUkhGJrQgDfjQKNmilXuHCSsAyuUmnMNJyKBJcw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBj5aZcwwxmnOHJD1bNQ4JrYUoAWotaf+WW6qXknwjw2C2Q0LK4/4HSLNcQ/QaWwR8DLuY7vXmRTUeUWIEMjwdLFOp3nWhqJ490lR4enpOekMxzMSizEteffdj3bAfXOWbCw5tCzsinsJ7BUrbnaWuLaG6wUXI3u3m4zy4aK8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUmxkt34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C2BC4CEF1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013057;
	bh=fkEhwUkhGJrQgDfjQKNmilXuHCSsAyuUmnMNJyKBJcw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CUmxkt34f776GgH8z2Bhkc8Em/OQstXflAw24PCXDcImIBADiaX7juBz2QYvfIOp9
	 DaeIGSsc/051uj7CzNV5FnyCcV3YFu5IUfL/ly9PULl7YlAD2YRe2I+dmjNykA4nj0
	 gXNfBYlTs5mUEnZ4UCHYPua7xy0YHEVzcnbgqrkOt98x5S14D5dgdC+2CbsXkqcill
	 e9Bw73RGuGOILFv5HkmxjYIASlDCI7+v0LUmUPg24W3FPUN5Ku4S340Au2DJ9aukDA
	 ut3Fyb8tCzIAH3m6Gt09FpZ0+tiLdiRtul2Vt9LeCpLbluLpY2lqQ0fgK4oPQB5pKA
	 o23UExpXDJRaA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/19] btrfs: remove out label in load_extent_tree_free()
Date: Wed, 21 Jan 2026 16:30:36 +0000
Message-ID: <572e0e0de60d363b557653e315824f0b2ae0cf7c.1769012877.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20849-lists,linux-btrfs=lfdr.de];
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
X-Rspamd-Queue-Id: 214F65AC14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There is no point in having the label since all it does is return the
value in the 'ret' variable. Instead make every goto return directly
and remove the label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 11ed303c6640..feec6f513ea0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -761,7 +761,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 next:
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	leaf = path->nodes[0];
 	nritems = btrfs_header_nritems(leaf);
@@ -792,7 +792,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 
 			ret = btrfs_next_leaf(extent_root, path);
 			if (ret < 0)
-				goto out;
+				return ret;
 			if (ret)
 				break;
 			leaf = path->nodes[0];
@@ -823,7 +823,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 			ret = btrfs_add_new_free_space(block_group, last,
 						       key.objectid, &space_added);
 			if (ret)
-				goto out;
+				return ret;
 			total_found += space_added;
 			if (key.type == BTRFS_METADATA_ITEM_KEY)
 				last = key.objectid +
@@ -842,9 +842,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 		path->slots[0]++;
 	}
 
-	ret = btrfs_add_new_free_space(block_group, last, block_group_end, NULL);
-out:
-	return ret;
+	return btrfs_add_new_free_space(block_group, last, block_group_end, NULL);
 }
 
 static inline void btrfs_free_excluded_extents(const struct btrfs_block_group *bg)
-- 
2.47.2


