Return-Path: <linux-btrfs+bounces-14768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1360ADE9F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 13:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A6D17B34D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821272BCF73;
	Wed, 18 Jun 2025 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ALoDvquy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ALoDvquy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EDC29B8E4
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246195; cv=none; b=k4z48Q3PyFpfjVZ7Sxhb+mN4Szj4CEUFiiJ6xStji7fODSqB8GQJlcGQ8AzFVGMdif0F1vSLH9ulQm1kTpxGrOCsscw7g8tE59f65fyMVOaRhzrSk1AWlpwjcTKN3iL8sIUIb7nixpJZy9jC6VkU4qVzI6BomESojPi03ClvYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246195; c=relaxed/simple;
	bh=8CcFXv40GWCBym2gdmuXWoNzeShEDzTf9wGg6456X1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h31waJVK19uqeQKF8rATqRMWDIunVkPZ/YY++xd0Els1ztEUideG722PysiFrS+XBqSPXOCFRv8nHJ54V4bzDSuhPREX6Ii/W0RUVZm+1xbi3d+OrNOQ2nnxzuYT9hW6F4XOoCyo3IZW/fQuCTcdQyKlqk/C8JrpI9OQW6uNkfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ALoDvquy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ALoDvquy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 087501F7C2;
	Wed, 18 Jun 2025 11:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750246192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrI+8YZtYSjnzkJNQU43kmQBBqHsX2u5cMPqPw9S4h0=;
	b=ALoDvquy+Q/6X9v+gn5Sz8vyV4omQOO6sSbpp6gwBHe6MxZFmMlhWMLc6PLuEPofLP/BiA
	sS5aQ+js6lHROp1Le6ZSfQRZ/cMedJ3uD4Z/i82V5jB6F8I84GNXhESdmfHWu1qOn+N9Sm
	cdCf5E0EJPpc5guAX1UoIODrPMCOSqM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750246192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrI+8YZtYSjnzkJNQU43kmQBBqHsX2u5cMPqPw9S4h0=;
	b=ALoDvquy+Q/6X9v+gn5Sz8vyV4omQOO6sSbpp6gwBHe6MxZFmMlhWMLc6PLuEPofLP/BiA
	sS5aQ+js6lHROp1Le6ZSfQRZ/cMedJ3uD4Z/i82V5jB6F8I84GNXhESdmfHWu1qOn+N9Sm
	cdCf5E0EJPpc5guAX1UoIODrPMCOSqM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0168913A3F;
	Wed, 18 Jun 2025 11:29:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U0pWADCjUmiiPwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 18 Jun 2025 11:29:52 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/5] btrfs: rename error to ret in btrfs_may_delete()
Date: Wed, 18 Jun 2025 13:29:27 +0200
Message-ID: <bf32c57e59ff8339025a77c6ab780bd7e4f39087.1750246061.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750246061.git.dsterba@suse.com>
References: <cover.1750246061.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 00047367655968..7cd6ae0c12c994 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -841,7 +841,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 static int btrfs_may_delete(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *victim, int isdir)
 {
-	int error;
+	int ret;
 
 	if (d_really_is_negative(victim))
 		return -ENOENT;
@@ -851,9 +851,9 @@ static int btrfs_may_delete(struct mnt_idmap *idmap,
 		return -EINVAL;
 	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
 
-	error = inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
-	if (error)
-		return error;
+	ret = inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
+	if (ret)
+		return ret;
 	if (IS_APPEND(dir))
 		return -EPERM;
 	if (check_sticky(idmap, dir, d_inode(victim)) ||
-- 
2.49.0


