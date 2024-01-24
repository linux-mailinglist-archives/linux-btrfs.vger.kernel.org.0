Return-Path: <linux-btrfs+bounces-1760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA7183B3C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D73B21FC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D67213541F;
	Wed, 24 Jan 2024 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="suoVf/nM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="suoVf/nM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD21353EF
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131153; cv=none; b=FxySGR3kU8bmd1qYvFgJBrZbwH33qVAWhLbtc5VPp5qOD56w7qj2EHEe+38MKvuoxsJDzqF9yFxyJXuU7EO7MLyvldB1VQ0oZ/GM5HCo2bnChl4+/P8nblkSDhKb5wqysG4H7kKfmyykpeIz+HmA3t/Y9Cn/T/XTgquv4YZINQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131153; c=relaxed/simple;
	bh=mpYws4/FssS2j3ZotctovtveehOAa7laRJxpnVT+qog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPPyZFpe8OGxsmfUz4LF3mgABlPnNCtYHQo5MrMfvH5WmVigaiBD18bThXH69auqb9skUtde4lsvCGwZPlvPmXzr17FCD83HSlBboV9rra1NZZBQigisxjc3P+6Wql/w3N2siRECDxS7Spwuz99sg+g1w9UCLVDpDDDKgP/eWtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=suoVf/nM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=suoVf/nM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47AA821F9B;
	Wed, 24 Jan 2024 21:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKpEyOylB2HMF92s4sVlVa+/xstPLlLo5/gXKbjmq7E=;
	b=suoVf/nMJxnW77gQwPejpx15XueWNt+ViLvqLhHeC6yqnvxkceBIb3RRFihj/TIr0jpMaq
	OBobijalZsWHhnEcCcw5oWuDQTb9gwnB5LxZFlivLeDQLZy/dYzhFSZZUzCozxBeltghml
	QV+tcAwcIvZU2mXlyxkPjZymRA5VLEk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKpEyOylB2HMF92s4sVlVa+/xstPLlLo5/gXKbjmq7E=;
	b=suoVf/nMJxnW77gQwPejpx15XueWNt+ViLvqLhHeC6yqnvxkceBIb3RRFihj/TIr0jpMaq
	OBobijalZsWHhnEcCcw5oWuDQTb9gwnB5LxZFlivLeDQLZy/dYzhFSZZUzCozxBeltghml
	QV+tcAwcIvZU2mXlyxkPjZymRA5VLEk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3654A13786;
	Wed, 24 Jan 2024 21:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7zhDDc5+sWX1dwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:19:10 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 18/20] btrfs: move transaction abort to the error site in btrfs_delete_free_space_tree()
Date: Wed, 24 Jan 2024 22:18:48 +0100
Message-ID: <ff45211dd388d91062be355a6b6b0ab9059887dd.1706130791.git.dsterba@suse.com>
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

The recommended pattern for transaction abort after error is to place it
right after the error is handled. That way it's easier to locate where
it failed and help debugging.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-tree.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 7b598b070700..888185265f4b 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1273,12 +1273,18 @@ int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
 	btrfs_clear_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
 
 	ret = clear_free_space_tree(trans, free_space_root);
-	if (ret)
-		goto abort;
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
 
 	ret = btrfs_del_root(trans, &free_space_root->root_key);
-	if (ret)
-		goto abort;
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
 
 	btrfs_global_root_delete(free_space_root);
 
@@ -1295,11 +1301,6 @@ int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(free_space_root);
 
 	return btrfs_commit_transaction(trans);
-
-abort:
-	btrfs_abort_transaction(trans, ret);
-	btrfs_end_transaction(trans);
-	return ret;
 }
 
 int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
-- 
2.42.1


