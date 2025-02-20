Return-Path: <linux-btrfs+bounces-11632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7AAA3D5E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C9A17C7BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0361F4734;
	Thu, 20 Feb 2025 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oksKATpf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oksKATpf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC481F12F1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045723; cv=none; b=U2v5daoa0jNEmd3GhkIHis8SSbZ7VSB6PzcuMvYvFFlzSVpmSd3Zsn4Q3WjSzhQkAlK9vxsa8OpPx0ZvGkN1eSRbpAzL5QLKfRXlEvwr9q1dJPSWD+VaBZpRozbJ4J4HHgOYxek59F82AemzKzq3zfKbA/W4jio2A3tMHr36fy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045723; c=relaxed/simple;
	bh=km9rH/fjB64u/WOhGNm8ilC/ptBkMkiwWoJ1d0uvbGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLPmQIJl8lcpDevrtCMWYgzsSpu7D5YvIs/IiIFHogmbxPJ29F348EgJf9cVLGu/e2yY1yZj6lvQVpqkj9EFmEkifq04LpavQajvSMCK+TA53IQHkzgMsZbqKfA08HCdt+g+V8+jQ5PQicKt+vkriEZ68JjN7OoImVzUITikxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oksKATpf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oksKATpf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 62C971F388;
	Thu, 20 Feb 2025 10:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPK9hfuI+WsqZ1P6EjzV7bXxj0tWSE76HAnoTfymI9A=;
	b=oksKATpf0XfW8eqgeqgUvqHqjeitokI7ulGmlApZivDyxaJQYlXmScu4SG8nVSxrc34G3S
	jr1Mw7kIY52ch2vsTbTVSNlnZCldxeB5jkMzX3x7P8nGq81Q8a28whceREmz2N6lCUKEl3
	MFuGzxbyMVgmgNGZY0mU06DgHXBSTHo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPK9hfuI+WsqZ1P6EjzV7bXxj0tWSE76HAnoTfymI9A=;
	b=oksKATpf0XfW8eqgeqgUvqHqjeitokI7ulGmlApZivDyxaJQYlXmScu4SG8nVSxrc34G3S
	jr1Mw7kIY52ch2vsTbTVSNlnZCldxeB5jkMzX3x7P8nGq81Q8a28whceREmz2N6lCUKEl3
	MFuGzxbyMVgmgNGZY0mU06DgHXBSTHo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B3E213301;
	Thu, 20 Feb 2025 10:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MGhLFpH9tme7fwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:53 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 19/22] btrfs: use struct btrfs_inode inside btrfs_remap_file_range()
Date: Thu, 20 Feb 2025 11:01:53 +0100
Message-ID: <ef6aae740664d6eed48463fd24cadca8972ca31f.1740045551.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740045551.git.dsterba@suse.com>
References: <cover.1740045551.git.dsterba@suse.com>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Use a struct btrfs_inode to btrfs_remap_file_range() as it's an internal
helper, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/reflink.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 63d4a4d22801..f63f92e176c8 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -865,8 +865,8 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 		struct file *dst_file, loff_t destoff, loff_t len,
 		unsigned int remap_flags)
 {
-	struct inode *src_inode = file_inode(src_file);
-	struct inode *dst_inode = file_inode(dst_file);
+	struct btrfs_inode *src_inode = BTRFS_I(file_inode(src_file));
+	struct btrfs_inode *dst_inode = BTRFS_I(file_inode(dst_file));
 	bool same_inode = dst_inode == src_inode;
 	int ret;
 
@@ -874,10 +874,10 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 		return -EINVAL;
 
 	if (same_inode) {
-		btrfs_inode_lock(BTRFS_I(src_inode), BTRFS_ILOCK_MMAP);
+		btrfs_inode_lock(src_inode, BTRFS_ILOCK_MMAP);
 	} else {
-		lock_two_nondirectories(src_inode, dst_inode);
-		btrfs_double_mmap_lock(BTRFS_I(src_inode), BTRFS_I(dst_inode));
+		lock_two_nondirectories(&src_inode->vfs_inode, &dst_inode->vfs_inode);
+		btrfs_double_mmap_lock(src_inode, dst_inode);
 	}
 
 	ret = btrfs_remap_file_range_prep(src_file, off, dst_file, destoff,
@@ -886,16 +886,18 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 		goto out_unlock;
 
 	if (remap_flags & REMAP_FILE_DEDUP)
-		ret = btrfs_extent_same(src_inode, off, len, dst_inode, destoff);
+		ret = btrfs_extent_same(&src_inode->vfs_inode, off, len,
+					&dst_inode->vfs_inode, destoff);
 	else
 		ret = btrfs_clone_files(dst_file, src_file, off, len, destoff);
 
 out_unlock:
 	if (same_inode) {
-		btrfs_inode_unlock(BTRFS_I(src_inode), BTRFS_ILOCK_MMAP);
+		btrfs_inode_unlock(src_inode, BTRFS_ILOCK_MMAP);
 	} else {
-		btrfs_double_mmap_unlock(BTRFS_I(src_inode), BTRFS_I(dst_inode));
-		unlock_two_nondirectories(src_inode, dst_inode);
+		btrfs_double_mmap_unlock(src_inode, dst_inode);
+		unlock_two_nondirectories(&src_inode->vfs_inode,
+					  &dst_inode->vfs_inode);
 	}
 
 	/*
-- 
2.47.1


