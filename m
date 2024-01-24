Return-Path: <linux-btrfs+bounces-1751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C10B83B3BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA5BB221B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C384A1353E8;
	Wed, 24 Jan 2024 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B7FJdw8f";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B7FJdw8f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72759132C36
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131128; cv=none; b=qjdMPFceve0ijZS549578+r71q3Dh1VkrMrpMuO5VY0WzgYz7XR/6m9ZPVyBA006/16qztD0WS236EUwsb8soEEqMY5F2HKVf+Auaq4J91ROoemKweO/QhC7LizQuwTS6f4Z0oMBa9U86a++jciGh98uwunhnDyLXhAyBtirlgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131128; c=relaxed/simple;
	bh=0293vjhe/xM/zKxL6mKOJ9he3BT7jP1qed4GPmVyn3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUaSkm+9tjbm3lEBMmehm8pydlfAWZlrkAaS4sYHaXgnoTP52HVaY5TzjptHu4oaCpEg/tWatNjYTccJWOWnExxbT7LI3TIk/Jf7sVqOZExQ3HJPLco+KoMOoIrp9FYPExY1uqwYh0hxDjm7SbhOQilhpPTvSgfS8DynhcnvBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B7FJdw8f; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B7FJdw8f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC9091FD85;
	Wed, 24 Jan 2024 21:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jf+ZIV1OyR3nwLGFlV/nmpwKXEIHN+GZAXn/3XbW3Ic=;
	b=B7FJdw8fEBHE7Xiu5Y/9oE24qaHVh5jFN2+qQVRST7FhFQR0KH/vaJGmnEkmMzrERAXnu9
	yoCfdIVCCR/M3hvZ+1NtUc4zvAjgjZvssB1X15sMXY+Px7xwYE9TdAIu0qW6nooNRQUxe9
	nIlKc1XhEACb7X19M5UjfOeRNDjJwok=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jf+ZIV1OyR3nwLGFlV/nmpwKXEIHN+GZAXn/3XbW3Ic=;
	b=B7FJdw8fEBHE7Xiu5Y/9oE24qaHVh5jFN2+qQVRST7FhFQR0KH/vaJGmnEkmMzrERAXnu9
	yoCfdIVCCR/M3hvZ+1NtUc4zvAjgjZvssB1X15sMXY+Px7xwYE9TdAIu0qW6nooNRQUxe9
	nIlKc1XhEACb7X19M5UjfOeRNDjJwok=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5BB113786;
	Wed, 24 Jan 2024 21:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vTtcLLR+sWXJdwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:44 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 09/20] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Wed, 24 Jan 2024 22:18:19 +0100
Message-ID: <de08f62548ad094851d13779065afb4d40d8b937.1706130791.git.dsterba@suse.com>
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
Authentication-Results: smtp-out2.suse.de;
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

The get_parent handler looks up a parent of a given dentry, this can be
either a subvolume or a directory. The search is set up with offset -1
but it's never expected to find such item, as it would break allowed
range of inode number or a root id. This means it's a corruption (ext4
also returns this error code).

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/export.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 744a02b7fd67..203e5964c9b0 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -174,8 +174,15 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		goto fail;
+	if (ret == 0) {
+		/*
+		 * Key with offset of -1 found, there would have to exist an
+		 * inode with such number or a root with such id.
+		 */
+		ret = -EUCLEAN;
+		goto fail;
+	}
 
-	BUG_ON(ret == 0); /* Key with offset of -1 found */
 	if (path->slots[0] == 0) {
 		ret = -ENOENT;
 		goto fail;
-- 
2.42.1


