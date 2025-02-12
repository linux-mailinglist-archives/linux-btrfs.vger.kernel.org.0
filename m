Return-Path: <linux-btrfs+bounces-11416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B8A330AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 21:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EA83A6E2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 20:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9F201253;
	Wed, 12 Feb 2025 20:22:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279D200B99
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391722; cv=none; b=MfFc+xUfSs85ZGKCz9vJzv7BxyB+ODGdohmjndqcxzQ4hldzXCwLqGMRVsCDzKpATopBzfsy5IZKqj33LFhvxL0uoMue4LSl+5A3LJxMrX9QTrI0UunUYZpKutGR2PfvQ5aw59qMQq+ipHyBB8Aip6geWDdUfb9WO7fC52JWFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391722; c=relaxed/simple;
	bh=T5lkJadZMXg9k3MyNmIDx9Pkuj9VE7RBKcJeDkhOpmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov46bOBgqY7TwQNZd9xQKnzcpsFraZD1RTNa3e4B83w7MZvuX5GHIyDxIg/S5M5gpvomx4XUqWVxbmJUkuNwuIrrcCoJ4vTyFLoRAP+pcC4my/JLfTZuEE68s93CmJvmLAxMiiC5xbKGajAXv7ASuDhvBq8AIDlEaPpg9u3rJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7125C337B7;
	Wed, 12 Feb 2025 20:21:58 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6945013AEF;
	Wed, 12 Feb 2025 20:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZM6uGeYCrWeXJgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 12 Feb 2025 20:21:58 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/7] btrfs: add __cold attribute to extent_io_tree_panic()
Date: Wed, 12 Feb 2025 21:21:50 +0100
Message-ID: <a1605901b4face438cacbf5ab2ea930a4b67b3a8.1739391605.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739391605.git.dsterba@suse.com>
References: <cover.1739391605.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 7125C337B7
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

This is a wrapper that leads to a panic, so add the annotation like the
other similar functions have.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 6d08c100b01d..13de6af279e5 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -346,10 +346,10 @@ static inline struct extent_state *tree_search(struct extent_io_tree *tree, u64
 	return tree_search_for_insert(tree, offset, NULL, NULL);
 }
 
-static void extent_io_tree_panic(const struct extent_io_tree *tree,
-				 const struct extent_state *state,
-				 const char *opname,
-				 int err)
+static void __cold extent_io_tree_panic(const struct extent_io_tree *tree,
+					const struct extent_state *state,
+					const char *opname,
+					int err)
 {
 	btrfs_panic(extent_io_tree_to_fs_info(tree), err,
 		    "extent io tree error on %s state start %llu end %llu",
-- 
2.47.1


