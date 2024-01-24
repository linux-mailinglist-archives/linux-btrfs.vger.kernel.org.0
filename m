Return-Path: <linux-btrfs+bounces-1752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C961C83B3BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084ED1C22DC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A461353FC;
	Wed, 24 Jan 2024 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N1etxsUp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N1etxsUp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D31350FE
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131130; cv=none; b=pvIoCBdO6cWPqBIgKoGVyA+CXWtsvxsd1lM7/EVy51iML6+svwrSEKevDZPIjYdyBIcoxRu3LeS6ef59RPe7eipLNXeyIp6afbpggeDh/RiyncOfEVg4K3OOmOA1L7VbhS4pmFHl6TXei8TW36KdUxdQ3zwmnfIUj2iOWYXvH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131130; c=relaxed/simple;
	bh=zbx63mhoXaSJnATT2BUcgGXhBH4LSnQzNdUp7FmgraM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vn23+K7zGHgEmjS6zXFtnZe9BC7pmXqTUZLMwmArOmCNu4B0AygCnwttWJ+VaQIAVrxm84Fo8HQgnB3DKsoYA3PyhU9MMtr0THfYkh3E5usjl8PY6Ipmcyn2WPku6niLeKCWcdKG+6UF6jts98Pebn09Zxq3DhocaWmlWWEzhTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N1etxsUp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N1etxsUp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2DC4321F87;
	Wed, 24 Jan 2024 21:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWbiFXanp1fK7r2djYeVcACJJwKpvkq+E/AE92Gb00U=;
	b=N1etxsUpsyKoTcIfuQd4ET2GNjuR1Aw0YAoWwHtRXPx/KcohVAn8jp65IOpriIa9BZrVP3
	gQWLYdcY7Ciwuo/xrmz+65O6j5nidKqEo1XKj5S4eKU8krkuVCdz7Xu8ZhZFSNKUEwkut3
	4n+n/NUxaJHoPbNB5scfvkU1WLVZqtY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWbiFXanp1fK7r2djYeVcACJJwKpvkq+E/AE92Gb00U=;
	b=N1etxsUpsyKoTcIfuQd4ET2GNjuR1Aw0YAoWwHtRXPx/KcohVAn8jp65IOpriIa9BZrVP3
	gQWLYdcY7Ciwuo/xrmz+65O6j5nidKqEo1XKj5S4eKU8krkuVCdz7Xu8ZhZFSNKUEwkut3
	4n+n/NUxaJHoPbNB5scfvkU1WLVZqtY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2585513786;
	Wed, 24 Jan 2024 21:18:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R6koCbd+sWXPdwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:47 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 10/20] btrfs: delayed-inode: drop pointless BUG_ON in __btrfs_remove_delayed_item()
Date: Wed, 24 Jan 2024 22:18:25 +0100
Message-ID: <a7caa051d250466468c83da032f27b690c7f6ab8.1706130791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706130791.git.dsterba@suse.com>
References: <cover.1706130791.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

There's a BUG_ON checking for a valid pointer of fs_info::delayed_root
but it is valid since init_mount_fs_info() and has the same lifetime as
fs_info.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 08102883f560..0b1701f1b8c9 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -430,8 +430,6 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 
 	delayed_root = delayed_node->root->fs_info->delayed_root;
 
-	BUG_ON(!delayed_root);
-
 	if (delayed_item->type == BTRFS_DELAYED_INSERTION_ITEM)
 		root = &delayed_node->ins_root;
 	else
-- 
2.42.1


