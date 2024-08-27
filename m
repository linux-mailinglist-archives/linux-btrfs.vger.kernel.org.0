Return-Path: <linux-btrfs+bounces-7586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71889961991
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB5B1F24A6C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC951D4157;
	Tue, 27 Aug 2024 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cOWP8yWf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cOWP8yWf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C21D4165
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795743; cv=none; b=Zo5j7hjFB51dGVOa+a+eh622C5VPuSrjW2H9FHut4d5sbxbgwtyiya6vBOWFQ3X7vZGtDBnpsihU08oKp/0qP5/5eFz2ukE5ha4/xT2K1pxk862AMKpueJ2crnru/hXMjHXjlzTjQ9hrt+XBD2TsuWpCMXwz/6n4CkR761Ck89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795743; c=relaxed/simple;
	bh=BrUcF+d3HLSZ1d6DYTFrAUOC7cqMndxjFQ5moeHd8qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7Xhd4NrcScSCme6Mf2qFy9waMwRlYteRuv5nIjXIUcwTNYSFokH2200k20NhasXeI3BGJEalaeVNjA0wXRp41Vu6LewyQMs0bv5cu+lQhZSLgWh5gLVBctl+a9RuXHi6jCc0jYZzCQw3PRZnXLt4MTjfa76CJf6y0r3+J95imU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cOWP8yWf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cOWP8yWf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B0D631FB86;
	Tue, 27 Aug 2024 21:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CR5C26H4BKnVhv5eI6uWEbTZB4QHe0h1VMRqY1A1gY4=;
	b=cOWP8yWf9SzKlPGRkyqw9ih3lYdc5TapkCGYPcfV0CEUEdMdSDPcJxHfDINtHft6dH+bUh
	XpnRHNgMfixS9X5Qu+onxBe7QOY1u1G5s9EP/6wQGlfXs3QhQTr5rw8gZIrn5HSGFfMcDB
	Cpc4zFL8JXEoHUptUHu3j4VI7f4InGE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CR5C26H4BKnVhv5eI6uWEbTZB4QHe0h1VMRqY1A1gY4=;
	b=cOWP8yWf9SzKlPGRkyqw9ih3lYdc5TapkCGYPcfV0CEUEdMdSDPcJxHfDINtHft6dH+bUh
	XpnRHNgMfixS9X5Qu+onxBe7QOY1u1G5s9EP/6wQGlfXs3QhQTr5rw8gZIrn5HSGFfMcDB
	Cpc4zFL8JXEoHUptUHu3j4VI7f4InGE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA43013A20;
	Tue, 27 Aug 2024 21:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fgWOKVxLzmayGgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 Aug 2024 21:55:40 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 08/12] btrfs: rename __btrfs_run_defrag_inode() and drop double underscores
Date: Tue, 27 Aug 2024 23:55:40 +0200
Message-ID: <3eba76fa9a67053754b39acf6fb1e45bb3e96e13.1724795624.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1724795623.git.dsterba@suse.com>
References: <cover.1724795623.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The function does not follow the pattern where the underscores would be
justified, so rename it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 5258dd86dbd8..41d67065d02b 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -231,8 +231,8 @@ void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
 
 #define BTRFS_DEFRAG_BATCH	1024
 
-static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
-				    struct inode_defrag *defrag)
+static int btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
+				  struct inode_defrag *defrag)
 {
 	struct btrfs_root *inode_root;
 	struct inode *inode;
@@ -322,7 +322,7 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 		first_ino = defrag->ino + 1;
 		root_objectid = defrag->root;
 
-		__btrfs_run_defrag_inode(fs_info, defrag);
+		btrfs_run_defrag_inode(fs_info, defrag);
 	}
 	atomic_dec(&fs_info->defrag_running);
 
-- 
2.45.0


