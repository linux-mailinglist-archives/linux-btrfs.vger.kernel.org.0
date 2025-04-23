Return-Path: <linux-btrfs+bounces-13278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E715A980FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 09:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6B717C1C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 07:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB7326C3B6;
	Wed, 23 Apr 2025 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PPryWqGi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PPryWqGi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB4B26983E
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393461; cv=none; b=tvMP7daB07wECugA2p4/4zOsB0qhqcDylIBZeup0xEOho5jhAtmpTR8rcZMQBuNf4hBKtSnK3CMzmSyU/6FBRo63mEqFn9gYFs9ULVJ8Dh475E/aYGmSa85TNhihaBbxe+LVZ74yETEMH2ccnDg61xss2HflBVA9Z4AoiN/aR/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393461; c=relaxed/simple;
	bh=ESCNmJQRH8OeA557gnR0yPNLT9+1Zlw5U5WR2p2cIes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CaCjy3+qBFQHt/vA7IDr5rJ3PA3uY4/cedTkSFu7xVHz+iH8NkCE74gEeJejtEnwviIfgv6zetAzXeVxESBMJPv2Kh7T/KbZXLiF1+HVprCbMEkT8fblHCYrPtPgUR0mZ372H/YXIujR+x9A8woI2Cty5I3EkyZOCwxAoqEI1zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PPryWqGi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PPryWqGi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F1691F38E;
	Wed, 23 Apr 2025 07:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745393457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qVl1lvu1ZmARzQc3GaiM55s4FswWZThTCWDWxCvWzVo=;
	b=PPryWqGiniRUWJVljFVNUeszfTTKZn/hZZq+RXJ3Wkj8lFGr/HV5Zc+pt30705azXGQsN0
	jMfMCQsJivN8uwJ6CkqGdIrBlaH/Uvg5ityvSVvkfcJgoEzLdwrr8LEFJwduGY9FfJ9kdP
	ujAqXbrDou/rEjFCTgAlo+uY8j23e74=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PPryWqGi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745393457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qVl1lvu1ZmARzQc3GaiM55s4FswWZThTCWDWxCvWzVo=;
	b=PPryWqGiniRUWJVljFVNUeszfTTKZn/hZZq+RXJ3Wkj8lFGr/HV5Zc+pt30705azXGQsN0
	jMfMCQsJivN8uwJ6CkqGdIrBlaH/Uvg5ityvSVvkfcJgoEzLdwrr8LEFJwduGY9FfJ9kdP
	ujAqXbrDou/rEjFCTgAlo+uY8j23e74=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 276E413A3D;
	Wed, 23 Apr 2025 07:30:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2IKaCTGXCGiBZgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 07:30:57 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: merge __setup_root() to btrfs_alloc_root()
Date: Wed, 23 Apr 2025 09:30:48 +0200
Message-ID: <20250423073048.728871-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2F1691F38E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

There's only one caller of __setup_root() so merge it there.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3592300ae3e2e5..7c289506b8946b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -635,11 +635,16 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 }
 
-static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
-			 u64 objectid)
+static struct btrfs_root *btrfs_alloc_root(struct btrfs_fs_info *fs_info,
+					   u64 objectid, gfp_t flags)
 {
+	struct btrfs_root *root;
 	bool dummy = btrfs_is_testing(fs_info);
 
+	root = kzalloc(sizeof(*root), flags);
+	if (!root)
+		return NULL;
+
 	memset(&root->root_key, 0, sizeof(root->root_key));
 	memset(&root->root_item, 0, sizeof(root->root_item));
 	memset(&root->defrag_progress, 0, sizeof(root->defrag_progress));
@@ -706,14 +711,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	list_add_tail(&root->leak_list, &fs_info->allocated_roots);
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 #endif
-}
 
-static struct btrfs_root *btrfs_alloc_root(struct btrfs_fs_info *fs_info,
-					   u64 objectid, gfp_t flags)
-{
-	struct btrfs_root *root = kzalloc(sizeof(*root), flags);
-	if (root)
-		__setup_root(root, fs_info, objectid);
 	return root;
 }
 
-- 
2.49.0


