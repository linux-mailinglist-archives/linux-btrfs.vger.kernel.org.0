Return-Path: <linux-btrfs+bounces-14336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079DBAC9360
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C79C17EE33
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9816F1C6FE8;
	Fri, 30 May 2025 16:19:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC681494A8
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621946; cv=none; b=br4GrCIYVxoKzHsy9x2HZWhKqJg8c2Z6ORTyOktN/bFPnvs/MLb8DWSAEN/2RcmYAn6QsBser4qL7mDGvYyw6KNa0RB8+qSXIpIvAeTZ09Khyr+UD6H/c5pSWn9MmI8YgJeDI9zq5WQxxJMeJllkTsHXgkFiXyexZ1rXDmLVKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621946; c=relaxed/simple;
	bh=JQ7/dIqRa+avh3u+tutB+IPyg782CGRxRQ2xUQxcvVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBWQFzeCH0H6wkTyWTqsWIPEPozdvfMiGOwP1w/qa/fLe516D2VtrlhY6uizh+F9E9El/J30g09Gq1SbnYlEM0fx+4hyzfMcEF/YK3Id2WQQ4Svy7B1fcpHVktgTODLz7Ze27R507nw2GCwKtV1qppRmKGWMukJ5bFb/zXPhMTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DDEDA1F7F2;
	Fri, 30 May 2025 16:19:01 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7F0D13889;
	Fri, 30 May 2025 16:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fiW2NHXaOWgYaAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:19:01 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 20/22] btrfs: rename err to ret in btrfs_wait_tree_log_extents()
Date: Fri, 30 May 2025 18:18:57 +0200
Message-ID: <aa715ccf2bea8151eb627276af4ab6e97099ec91.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DDEDA1F7F2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/transaction.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3ca57bb8dc64..825d135ef6c7 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1227,11 +1227,11 @@ int btrfs_wait_tree_log_extents(struct btrfs_root *log_root, int mark)
 	struct btrfs_fs_info *fs_info = log_root->fs_info;
 	struct extent_io_tree *dirty_pages = &log_root->dirty_log_pages;
 	bool errors = false;
-	int err;
+	int ret;
 
 	ASSERT(btrfs_root_id(log_root) == BTRFS_TREE_LOG_OBJECTID);
 
-	err = __btrfs_wait_marked_extents(fs_info, dirty_pages);
+	ret = __btrfs_wait_marked_extents(fs_info, dirty_pages);
 	if ((mark & EXTENT_DIRTY) &&
 	    test_and_clear_bit(BTRFS_FS_LOG1_ERR, &fs_info->flags))
 		errors = true;
@@ -1240,9 +1240,9 @@ int btrfs_wait_tree_log_extents(struct btrfs_root *log_root, int mark)
 	    test_and_clear_bit(BTRFS_FS_LOG2_ERR, &fs_info->flags))
 		errors = true;
 
-	if (errors && !err)
-		err = -EIO;
-	return err;
+	if (errors && !ret)
+		ret = -EIO;
+	return ret;
 }
 
 /*
-- 
2.47.1


