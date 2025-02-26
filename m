Return-Path: <linux-btrfs+bounces-11855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04F7A45ABC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150A73A636E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0C26FA66;
	Wed, 26 Feb 2025 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XmtPsC9h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XmtPsC9h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C12459D0
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563503; cv=none; b=E+XuD3ZbkwKe8laK9tiUX7/ujVy5WeDIVkRrjNja1vabZj7xshFZetej7wMY6cV70yq5E8jsWC9VAty3E8cQEpwjLnhBu18KrR+JBlppkqSUmUyoHPgLWZ4HTOwqdmWBdo7YxXl8JD3TQVE7RFo5a4SC8nr1daeu1VaWu1Qn3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563503; c=relaxed/simple;
	bh=Vla1PCdW8paBvSBffkFgdqkLoScb4AX40CY+qd/p4L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dD1D71rHI6o2wZhSxEEjmTooHYGQWeMSTp2Tp1SGc54ZMq+OUeKJPVkYfDipI5vQ1Mswtjkb3fa8/TiuS1Xd6imb/+22TJxaqHMfNr0nnZkSSvPAfbXz1573dz6ogROUsosVWEMB0+li/2ynp6Rsi6tLPSUnN/qAjpck8ejthBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XmtPsC9h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XmtPsC9h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04D942116B;
	Wed, 26 Feb 2025 09:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvEzT8OzuzWMkI6y2kfg43d6Wr7t1BTuuQwf678u+Z0=;
	b=XmtPsC9hYtE1QfhkoOAK6vN+YC/xOcYrbrGiaRdCheKgAEvhaKRnfIsc7bQmL1ijXmPGkI
	hymkoGObN2atrpeG2SvGzjUJoGN40hyb8Mlu8Xnjbd3ldK5tBzW2q0hM8xf2V36P9C6tFW
	s5r98ANTWN13ENiaEsFiG0Cuxan3lVk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvEzT8OzuzWMkI6y2kfg43d6Wr7t1BTuuQwf678u+Z0=;
	b=XmtPsC9hYtE1QfhkoOAK6vN+YC/xOcYrbrGiaRdCheKgAEvhaKRnfIsc7bQmL1ijXmPGkI
	hymkoGObN2atrpeG2SvGzjUJoGN40hyb8Mlu8Xnjbd3ldK5tBzW2q0hM8xf2V36P9C6tFW
	s5r98ANTWN13ENiaEsFiG0Cuxan3lVk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2A5E13A53;
	Wed, 26 Feb 2025 09:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2NU5OyjkvmddYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:36 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 20/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_drop_subtree()
Date: Wed, 26 Feb 2025 10:51:32 +0100
Message-ID: <19718010a4f25ff40d579138665ffad74b8f0a1b.1740562070.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 122d575c016b..5de1a1293c93 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6277,7 +6277,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 			struct extent_buffer *parent)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct walk_control *wc;
 	int level;
 	int parent_level;
@@ -6290,10 +6290,8 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	wc = kzalloc(sizeof(*wc), GFP_NOFS);
-	if (!wc) {
-		btrfs_free_path(path);
+	if (!wc)
 		return -ENOMEM;
-	}
 
 	btrfs_assert_tree_write_locked(parent);
 	parent_level = btrfs_header_level(parent);
@@ -6330,7 +6328,6 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	}
 
 	kfree(wc);
-	btrfs_free_path(path);
 	return ret;
 }
 
-- 
2.47.1


