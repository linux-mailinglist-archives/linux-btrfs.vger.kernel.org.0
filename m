Return-Path: <linux-btrfs+bounces-21501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEnFOn3riGkiywQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21501-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 21:01:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C90A10A101
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 21:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E19030115A5
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1746D32E6B1;
	Sun,  8 Feb 2026 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN8tOAsi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601732E13A
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770580843; cv=none; b=RqY4rANF796Oi9XhGVrWd/GUkG1PRFERAjRRbhaId/7tDeFeVL1/ehYSU/TODK3++V7tMbICy3JaUW0N+RYN6Jx7i0cEAg9IR2OQDPncuAlOkI82CgBQu43iNTeK4fkOx7t2jCGsiW5XwkwSsz4ucQMKwihJ6NWJmQ3P+NsFRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770580843; c=relaxed/simple;
	bh=Tg+CPJeA529GIZKa7HHmQRrjHlk3Fwf6iiIifaGIr/E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOHhpLsMnCPM5toOtK/On2igVq0o2AablgK/ygmmD5OqGQ4n5IvucxuQ1pFOOR5R71C9XDfVX7Z36TSi2Wh9YHcQCNVTXgvip+QUZhCO0SBJgZ7ECVV3DxmHyJh6JOO5jCTMR7zBIU+KtoKJy2zkPaUOxr9Vf7QuGeuCo2jC/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CN8tOAsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD81C19424
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 20:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770580843;
	bh=Tg+CPJeA529GIZKa7HHmQRrjHlk3Fwf6iiIifaGIr/E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CN8tOAsiZywLMoeTQ80W6YQMg1YHQFXphrlSLGIcH7wTg9loK5RUelSJpVVtuqrJb
	 ERpYAswV1UkI+Q0zvJwa/PsQXdM5xHT8+UUsGtlt2mk3mp9NJjpUkni9qRR+rrBe45
	 aUTO2Whb0lR1XPsmw3Pp/bDW1uByEvHVJUANAURoP/vcnt25DXpg6MAooGoG6fXZJT
	 rEgdKrVbGVvkSlfqVq/VPugIU/ayuMjrvJ1cmuxOiaIE0NZM5xUs2ilzhiKbwSJwaQ
	 gafH1pWW2sOtlZ9NGpTxew1Pbj6bdmlkdcQLQIj4nHh3MvcI4G1bVzMAnCS37D87cr
	 VIolIylgjEPIA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: remove bogus root search condition in load_extent_tree_free()
Date: Sun,  8 Feb 2026 20:00:37 +0000
Message-ID: <5d71bd2cd9607c61928f478ec75c8954c4e8e3b1.1770580436.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770580436.git.fdmanana@suse.com>
References: <cover.1770580436.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21501-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C90A10A101
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

There's no need to pass the maximum between the block group's start offset
and BTRFS_SUPER_INFO_OFFSET (64K) since we can't have any block groups
allocated in the first megabyte, as that's reserved space. Furthermore,
even if we could, the correct thing to do was to pass the block group's
start offset anyway - and that's precisely what we do for block groups
hat happen to contain a superblock mirror (the range for the super block
is never marked as free and it's marked as dirty in the
fs_info->excluded_extents io tree).

So simplify this and get rid of that maximum expression.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 764caaf1d8b2..17a18f17538d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -728,7 +728,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	u64 total_found = 0;
-	u64 last = 0;
+	u64 last = block_group->start;
 	u32 nritems;
 	int ret;
 	bool wakeup = true;
@@ -737,7 +737,6 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 	if (!path)
 		return -ENOMEM;
 
-	last = max_t(u64, block_group->start, BTRFS_SUPER_INFO_OFFSET);
 	extent_root = btrfs_extent_root(fs_info, last);
 
 #ifdef CONFIG_BTRFS_DEBUG
-- 
2.47.2


