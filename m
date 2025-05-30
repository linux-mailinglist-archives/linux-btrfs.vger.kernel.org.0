Return-Path: <linux-btrfs+bounces-14325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C42AC934F
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7A516E7F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63B11AA1DB;
	Fri, 30 May 2025 16:17:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446A5674E
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621867; cv=none; b=K2hDKG98UKkPwPxi9klF6XONBetN5zeHWV2JYMdWnDMA25e3wLvy5EHQHNUNCar8jS/26GhRxs3KO+QYLiKpBZpOxVt+Xh0Mg/ST3m6etF0BzgDgnYBeOionXj1cLwdZzCmwr/ZvaRQ7yQKl/QlcplBArdfx12m+Wir1FZ+reWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621867; c=relaxed/simple;
	bh=seZtpnqQ9o986ZTkOxaBOf5wVETMpPdmKTfhEgO6gdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpsUJ+Shxv/vtYt07Doeya0cekWsbn6JiViXOgbu46ekIPXbNNk5vLFL/IErdboNHWe/yrvheQglmHEmIZzqhirdml6tkriVMMbhTRY8ZgtbZc8SjvWHWUdR4QBmgWHbi7GdO071NFLZI2BIVbfwAxlIc7qMD0VEnWf3dF9K0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 091F81F7F2;
	Fri, 30 May 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03D4E13889;
	Fri, 30 May 2025 16:17:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EjbtACjaOWidZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:17:44 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 07/22] btrfs: rename err to ret2 in btrfs_add_link()
Date: Fri, 30 May 2025 18:17:39 +0200
Message-ID: <daf8e459fe1a52ab294d6255756ec1d80e83e017.1748621715.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 091F81F7F2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2af381f2f5ed..36a11a832528 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6707,20 +6707,19 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 fail_dir_item:
 	if (unlikely(ino == BTRFS_FIRST_FREE_OBJECTID)) {
 		u64 local_index;
-		int err;
-		err = btrfs_del_root_ref(trans, key.objectid,
-					 btrfs_root_id(root), parent_ino,
-					 &local_index, name);
-		if (err)
-			btrfs_abort_transaction(trans, err);
+		int ret2;
+
+		ret2 = btrfs_del_root_ref(trans, key.objectid, btrfs_root_id(root),
+					  parent_ino, &local_index, name);
+		if (ret2)
+			btrfs_abort_transaction(trans, ret2);
 	} else if (add_backref) {
 		u64 local_index;
-		int err;
+		int ret2;
 
-		err = btrfs_del_inode_ref(trans, root, name, ino, parent_ino,
-					  &local_index);
-		if (err)
-			btrfs_abort_transaction(trans, err);
+		ret2 = btrfs_del_inode_ref(trans, root, name, ino, parent_ino, &local_index);
+		if (ret2)
+			btrfs_abort_transaction(trans, ret2);
 	}
 
 	/* Return the original error code */
-- 
2.47.1


