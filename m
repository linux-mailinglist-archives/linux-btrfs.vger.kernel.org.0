Return-Path: <linux-btrfs+bounces-11858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7949FA45AC0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A662165FEC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B452270ED5;
	Wed, 26 Feb 2025 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qb3gI1KX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qb3gI1KX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174F24DFE9
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563512; cv=none; b=tfUMENzgvv0skC+2TPgqLhBTVHY7BBtsaiSNCwUfup5CQIxRTg7WRzMOaZiXsuvNQ42MT38XmsjIy35+JAfqdHQKf6lqiIk67BQ61pv6OQFRfG3zoqq716k2TqjLZ8Bs5i7/sRi6UY1m0apYjhrB2SgfJmN/2K6RA9qMFlysD1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563512; c=relaxed/simple;
	bh=YKlJsNGwHfBGM47aOVu/iKQuuMmXoPz2InlUhkUi+5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hr+Xc0GXqoqgReXYR1nXPyLvPVFvG5JdqmG5UH0/dhT24kCz6UdQ7fAsAdja+N9Qg47BT3ng6vCIh4RNjSOlKxHT7/Iq3X8TfEciUJa/+Bp1C0GLsy4NT42qJPtV/XwSZ6I17TXaUSB0tbIASYQXL2/M9FEoHQrDioBcIx3ai+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qb3gI1KX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qb3gI1KX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D06551F38F;
	Wed, 26 Feb 2025 09:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBZQ1t3wYArOTfTQUxyz8f+8izMASiBGrJCULQ+lYfw=;
	b=qb3gI1KXqE6wX9giKdicDYU0pg/zqk/19x1Byq10KfxbmqIlGX9YF9EUbGlEkjCxsqL2yv
	yYtyiPniamJgH6c4zyT/5ZQ6+TqCvs8zeznUa8W72FwK+R+x5yOuSZXFMYTM2DQAWDy7A8
	bZOlavwQ0Ey+QgD2j3Dow+m6+6HZxxg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qb3gI1KX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBZQ1t3wYArOTfTQUxyz8f+8izMASiBGrJCULQ+lYfw=;
	b=qb3gI1KXqE6wX9giKdicDYU0pg/zqk/19x1Byq10KfxbmqIlGX9YF9EUbGlEkjCxsqL2yv
	yYtyiPniamJgH6c4zyT/5ZQ6+TqCvs8zeznUa8W72FwK+R+x5yOuSZXFMYTM2DQAWDy7A8
	bZOlavwQ0Ey+QgD2j3Dow+m6+6HZxxg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA0BB13A53;
	Wed, 26 Feb 2025 09:51:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WTtSMRHkvmcvYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:13 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 12/27] btrfs: use BTRFS_PATH_AUTO_FREE in load_global_roots()
Date: Wed, 26 Feb 2025 10:51:13 +0100
Message-ID: <4227060d1bfb2ea88d270f785dc6f1344c88d824.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
References: <cover.1740562070.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D06551F38F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ab7cbbf90af3..f0e4dd0245df 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2198,8 +2198,8 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 
 static int load_global_roots(struct btrfs_root *tree_root)
 {
-	struct btrfs_path *path;
-	int ret = 0;
+	BTRFS_PATH_AUTO_FREE(path);
+	int ret;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -2208,18 +2208,17 @@ static int load_global_roots(struct btrfs_root *tree_root)
 	ret = load_global_roots_objectid(tree_root, path,
 					 BTRFS_EXTENT_TREE_OBJECTID, "extent");
 	if (ret)
-		goto out;
+		return ret;
 	ret = load_global_roots_objectid(tree_root, path,
 					 BTRFS_CSUM_TREE_OBJECTID, "csum");
 	if (ret)
-		goto out;
+		return ret;
 	if (!btrfs_fs_compat_ro(tree_root->fs_info, FREE_SPACE_TREE))
-		goto out;
+		return ret;
 	ret = load_global_roots_objectid(tree_root, path,
 					 BTRFS_FREE_SPACE_TREE_OBJECTID,
 					 "free space");
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
-- 
2.47.1


