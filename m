Return-Path: <linux-btrfs+bounces-1743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE78C83B3B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9C51F253A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920D31353E4;
	Wed, 24 Jan 2024 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c3BXrYdR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c3BXrYdR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A17E760
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131096; cv=none; b=sD1YfoOmC3PLehqURSI9AtkNuHc/LwSh3gRteleLgwJkVsGBvIlJ8+ilA5B9YGdAdmc8vIHvNsWBWEuRGZEITR/W3Og/DDyRffyx3Hz72ox8dFlFkHTiqpJX32qOcvfS/KMenm0Kbeofdj4SFn2uPWBqrnqJ/n7I0HXCyXWi+rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131096; c=relaxed/simple;
	bh=8Cb97388zbxK1SFgikL+CyLvVJfAXspRsJUK0FggzdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxFue2x4mkOBhVRZsm0COTPiKFax/GsBk4T6HKgEZMPKdFfKxgJp8plIW0QliS2UdKObnfMbhvX9h+zv8hty2zNOvymfWYZQLFEUyktNoY0DLqvWpmfkeR19rBEGx1rCN4VBNB5Nc3aZtTXSg+2wJUlBGVuAJ1ES1Qu4FXMLGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c3BXrYdR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c3BXrYdR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 701D41FD85;
	Wed, 24 Jan 2024 21:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/GCNl1SCnRjV5/FZW6ZeqoEhQfO1p2x7eEoW+mfFw4=;
	b=c3BXrYdR/lFhg5mjDjKx8ylqhPhYswkuqfQBe/zByD/deoobM4xDaLxLUPiyz1JlPvzTSB
	gMqOOU0VvinUEycH+jikSZSQkff9qGSHejwkVQtif9hV9zLTDP9cBlFhjWczxuLMtX5yKG
	+CLQAIMgFb8deAcl1yZ7cfGqicostCQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/GCNl1SCnRjV5/FZW6ZeqoEhQfO1p2x7eEoW+mfFw4=;
	b=c3BXrYdR/lFhg5mjDjKx8ylqhPhYswkuqfQBe/zByD/deoobM4xDaLxLUPiyz1JlPvzTSB
	gMqOOU0VvinUEycH+jikSZSQkff9qGSHejwkVQtif9hV9zLTDP9cBlFhjWczxuLMtX5yKG
	+CLQAIMgFb8deAcl1yZ7cfGqicostCQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6894813786;
	Wed, 24 Jan 2024 21:18:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wySEGZV+sWWddwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:13 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 01/20] btrfs: handle directory and dentry mismatch in btrfs_may_delete()
Date: Wed, 24 Jan 2024 22:17:48 +0100
Message-ID: <269733d3339107847d24fe4d19f4e55cb6c8cfc3.1706130791.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[16.19%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

The helper btrfs_may_delete() is a copy of generic fs/namei.c:may_delete()
to verify various conditions before deletion. There's a BUG_ON added
before linux.git started, we can turn it to a proper error handling
at least in our local helper. A mistmatch between directory and the
deleted dentry is clearly invalid.

This won't be probably ever hit due to the way how the parameters are
set from the caller btrfs_ioctl_snap_destroy(), using a VFS helper
lookup_one().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3d476decde52..845fdc5f2a99 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -910,7 +910,9 @@ static int btrfs_may_delete(struct mnt_idmap *idmap,
 	if (d_really_is_negative(victim))
 		return -ENOENT;
 
-	BUG_ON(d_inode(victim->d_parent) != dir);
+	/* The @victim is not inside @dir. */
+	if (d_inode(victim->d_parent) != dir)
+		return -EINVAL;
 	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
 
 	error = inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
-- 
2.42.1


