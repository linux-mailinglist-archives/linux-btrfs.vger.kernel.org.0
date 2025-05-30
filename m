Return-Path: <linux-btrfs+bounces-14321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C22AC934C
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FE81C01352
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD271AE877;
	Fri, 30 May 2025 16:17:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A022E401
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621845; cv=none; b=Og0XtgAUpSOV28VMLclB8pI/9IcvsbjjRvUbpESHkEA2GWjyzHnefjc6iuLMU8tTvf/I7noQFKleM7N/Vmi8KwNH2WEvJBche7bQg9ub5+aJ+5asuwb9465+Hr7LbxsxBaYpJiF4OYRDT0PGEo41I41mszCv9Im8hV3AAPsfegA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621845; c=relaxed/simple;
	bh=gyrvCvpzTaVGZGTzmk156skCkVpN3bwz4FArK7uILI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQeQ/iuePNQpSAsynuUecK8ZUotoPG5q8amcdZaL8MxqXR2qeQ4HJwHOX/4YbSxHgyR+JkMwheEnYvfskni+ijY/K5UD3l8SBYf3P7rH0sa1RlxNmUk/Wejv5vmZJ9aCiiIwQYaKtjRu5JJgtQv+A4bzMbC1am3fK96t+yC+MIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 838B11F7F2;
	Fri, 30 May 2025 16:17:22 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CF5D13889;
	Fri, 30 May 2025 16:17:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ONF+HhLaOWh2ZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:17:22 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 03/22] btrfs: rename err to ret2 in search_leaf()
Date: Fri, 30 May 2025 18:17:14 +0200
Message-ID: <54301fb6e1df7cce1dd95526a191aac3dc1434a3.1748621715.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 838B11F7F2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.00

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 06dc7731c54a..0f0a69c8259d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1939,15 +1939,14 @@ static int search_leaf(struct btrfs_trans_handle *trans,
 		ASSERT(leaf_free_space >= 0);
 
 		if (leaf_free_space < ins_len) {
-			int err;
+			int ret2;
 
-			err = split_leaf(trans, root, key, path, ins_len,
-					 (ret == 0));
-			ASSERT(err <= 0);
-			if (WARN_ON(err > 0))
-				err = -EUCLEAN;
-			if (err)
-				ret = err;
+			ret2 = split_leaf(trans, root, key, path, ins_len, (ret == 0));
+			ASSERT(ret2 <= 0);
+			if (WARN_ON(ret2 > 0))
+				ret2 = -EUCLEAN;
+			if (ret2)
+				ret = ret2;
 		}
 	}
 
-- 
2.47.1


