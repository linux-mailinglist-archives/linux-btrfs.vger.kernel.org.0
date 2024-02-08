Return-Path: <linux-btrfs+bounces-2236-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B94E84DC3C
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E53286561
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B356BFAD;
	Thu,  8 Feb 2024 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="grOpH0YB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="grOpH0YB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244EA6BB50
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382840; cv=none; b=UrxX/013r2IVQ/iN/XlUp5DSnXVHi1Ry0SfYIOtjUpLvPw6qDMiiGvgJb02bK1zu3Xl6p1qmOdL3jVvSSfXWecIjR4NHGS3ERRXGtuO7j5Gl1mDrDqQsokm4loYI++W9iDjTcPYaiPuTVdxVTOAH0SkxrSn+6BDFg76ZBibo+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382840; c=relaxed/simple;
	bh=L1Zhviyoxyid7j3hZCgaAyQWQfYRW8zNQLlbMeXD77A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibwS3UL5BSaJWHeVY40LdljrrPgbKTG2KMlJwj+XVzAlqfz8xwSi//WANEBR5czYSISNzK13c2rwAlr4eliebPDEGgIxGZ55tSU5huteiZMgXkP5TxgIDI6SoUNk0IShLi+HDVZEPHwwAzWhRkgB9ZIWkStpPnG2kRW/RjKEeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=grOpH0YB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=grOpH0YB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B6AA21F56;
	Thu,  8 Feb 2024 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxnKIKz2V+2h7wI8MfcazmX6it3PrKqFLEUAA5ITVSI=;
	b=grOpH0YB3UnwfKQV/UBtsO8/eAMkxoJfru8iDx+iDNYwOIVHMzS0/R/3NXf3LzOI7xUf5t
	dhVF2fvywmdOQoXojnfK0/TvgVKIjol/MXgRKxG7CSI5zhYreaM2TzaHMkwKzWOku9LkKS
	eTzulb8jG2+5Sf0JnXUBHjbPGt/5z+o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxnKIKz2V+2h7wI8MfcazmX6it3PrKqFLEUAA5ITVSI=;
	b=grOpH0YB3UnwfKQV/UBtsO8/eAMkxoJfru8iDx+iDNYwOIVHMzS0/R/3NXf3LzOI7xUf5t
	dhVF2fvywmdOQoXojnfK0/TvgVKIjol/MXgRKxG7CSI5zhYreaM2TzaHMkwKzWOku9LkKS
	eTzulb8jG2+5Sf0JnXUBHjbPGt/5z+o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AAF313984;
	Thu,  8 Feb 2024 09:00:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mws6EjWYxGWnDgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 08 Feb 2024 09:00:37 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 12/14] btrfs: delete pointless BUG_ONs on extent item size
Date: Thu,  8 Feb 2024 10:00:08 +0100
Message-ID: <8c4bfd140e6ad04a46ce0a3774c33723931e98ad.1707382595.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707382595.git.dsterba@suse.com>
References: <cover.1707382595.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[20.88%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

Checking extent item size in add_inline_refs() is redundant, we do that
already in tree-checker after reading the extent buffer and it won't
change under normal circumstances.  It was added long ago in
8da6d5815c592b ("Btrfs: added btrfs_find_all_roots()") and does not seem
to have a clear purpose.

Similar case in extent_from_logical(), added in a542ad1bafc7df ("btrfs:
added helper functions to iterate backrefs").

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 6ba743ddfe21..fe05e2f55bf7 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1036,8 +1036,6 @@ static int add_inline_refs(struct btrfs_backref_walk_ctx *ctx,
 	slot = path->slots[0];
 
 	item_size = btrfs_item_size(leaf, slot);
-	BUG_ON(item_size < sizeof(*ei));
-
 	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
 
 	if (ctx->check_extent_item) {
@@ -2256,7 +2254,6 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
 
 	eb = path->nodes[0];
 	item_size = btrfs_item_size(eb, path->slots[0]);
-	BUG_ON(item_size < sizeof(*ei));
 
 	ei = btrfs_item_ptr(eb, path->slots[0], struct btrfs_extent_item);
 	flags = btrfs_extent_flags(eb, ei);
-- 
2.42.1


