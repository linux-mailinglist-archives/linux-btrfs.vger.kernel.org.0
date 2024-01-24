Return-Path: <linux-btrfs+bounces-1746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 512B283B3B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E361C22D62
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42254132C36;
	Wed, 24 Jan 2024 21:18:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B91350FD
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131111; cv=none; b=KeJbRfnpA8RSiN74moXB2twlnBVfDYxHS4N6HxD0NBPNTSrKEAKODyZRtTQcIk+66oBeoT93lEagZIQWA9/tm/VhOmbrDLm2O6Ne1LYWYbs2Ds+92Xsbcx2sTv92eucMjU8kCfn5jtQYUzsPhEv+hT7acNIiXR9lD9e9FEfKgdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131111; c=relaxed/simple;
	bh=mcRDqAbLYOUDRZTbZ8JUMtFpBvlCcGea2UqfOGOLxRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbMA1GnTmYjEutmQ0MQj3LFV+BRJLX+d/esxzB8O2shtWJJXvdAeEhUnWXDPO1rgAtkBAcRv2xYZQnTxLkFkWdrFYiaGoRFIy++qq8kId3JQTsIl0kU6WqtJxEru/NOXpXCUbQOfgHOjt8m3mjkmLe7ZqZCkTn9H1y7ZQvA5ncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4F8921F9B;
	Wed, 24 Jan 2024 21:18:28 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BF6B13786;
	Wed, 24 Jan 2024 21:18:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MWgQJqR+sWWtdwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:28 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 04/20] btrfs: handle root deletion lookup error in btrfs_del_root()
Date: Wed, 24 Jan 2024 22:18:07 +0100
Message-ID: <a3879c9484eb245085f08fc90f94dbf027dbe22a.1706130791.git.dsterba@suse.com>
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
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: A4F8921F9B
X-Spam-Flag: NO

We're deleting a root and looking it up by key does not succeed, this
is an inconsistent state and we can't do anything. All callers handle
errors and abort a transaction.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/root-tree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 603ad1459368..ba7e2181ff4e 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -323,8 +323,11 @@ int btrfs_del_root(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot(trans, root, key, path, -1, 1);
 	if (ret < 0)
 		goto out;
-
-	BUG_ON(ret != 0);
+	if (ret != 0) {
+		/* The root must exist but we did not find it by the key. */
+		ret = -EUCLEAN;
+		goto out;
+	}
 
 	ret = btrfs_del_item(trans, root, path);
 out:
-- 
2.42.1


