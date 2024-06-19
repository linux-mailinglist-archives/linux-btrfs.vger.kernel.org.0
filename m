Return-Path: <linux-btrfs+bounces-5824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC86690F4D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 19:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A16B21EFD
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE3B155A23;
	Wed, 19 Jun 2024 17:09:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26581C3E
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816942; cv=none; b=XSw5SR4rw6Ds+FX9HBxqlREjdCcDFSK/MQE5TOLl0Z5Uf2BiXz99eFHP9B5ntRlS6DJ8PLwmo0tHWuB8t5f9MS8gNwXceu2T1yiXLpUN5vcysjZdJHCH1rP0jdklpj286Fd2UQ+bLJ1vg0HN5hD4GNh1r05bcCcBgDLrw6bYoqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816942; c=relaxed/simple;
	bh=W0MNAEnc6+31Xluf/lEu4hH9uAu3tRuk5oWnFAZmcgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIzyDnLJNn9AcKqwLygciZSVAfhxBtA1R/Wz8O4M+C5WFHFyxcNpU0XbzkOq97CA0IcDoQIB7U15g1LeaPVPJvfRdaK3NrLSnmUUsdR/ks6++bQ/oFXfTb1zqjNGe+1nVXnHDpBX/u7C3yR+eRxspJ3HddkuQcp6tF9SrDkc5sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 114D01F7C7;
	Wed, 19 Jun 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BD4313668;
	Wed, 19 Jun 2024 17:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d+ThAqsQc2Z2QwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 19 Jun 2024 17:08:59 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/5] btrfs: abort transaction if we don't find extref in btrfs_del_inode_extref()
Date: Wed, 19 Jun 2024 19:08:54 +0200
Message-ID: <6ff867fb978d8d3447747e20fa5b002dd0c985ce.1718816796.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1718816796.git.dsterba@suse.com>
References: <cover.1718816796.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 114D01F7C7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

When an extended ref is deleted we do a sanity check right before
removing the item, if we can't find it then handle the error. This is
done by btrfs_handle_fs_error() but this is from the time before we had
the transaction abort infrastructure, so switch to that. The end result
is the same, the error is reported and switched to read-only. We newly
return the -ENOENT error code as this better represents what happened.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode-item.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 84a94d19b22c..316756ff08ac 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -141,8 +141,8 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 	extref = btrfs_find_name_in_ext_backref(path->nodes[0], path->slots[0],
 						ref_objectid, name);
 	if (!extref) {
-		btrfs_handle_fs_error(root->fs_info, -ENOENT, NULL);
-		ret = -EROFS;
+		btrfs_abort_transaction(trans, -ENOENT);
+		ret = -ENOENT;
 		goto out;
 	}
 
-- 
2.45.0


