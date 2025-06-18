Return-Path: <linux-btrfs+bounces-14769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC89FADE9FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 13:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 033867A6BE0
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 11:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1EF2BEFF1;
	Wed, 18 Jun 2025 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RAMAHlp+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RAMAHlp+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC92BE7C8
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246198; cv=none; b=L87MTGq3lJIJwIkrBNeoEiNGZP+EvqmYCjyRX1j75VmcQvThw03EqWz2JZIIajwF3ylyfiT+CrpvrTLvHkc1tOKis8FGxwkMnx64A+yWrcpKp8pr64ibpePu6EKJ0xSmZj3goluQ8sEIxKNpp83adsWeG3e/rzTP4cpnJEtM9AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246198; c=relaxed/simple;
	bh=KTUlt/A/ftcNl2tDjQ3mo2YnqlSxSudRWI8UrCbGNbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLHlIRqVZHVu90MRV0Oy70fTlI0umJA0HMHkWGYmcQzFyYDL/oyv/22eT0vQk+CIJmyXXvE2CQuaQsxhwei2YkYo1K3S68DvgxsI2BPi7yfC5QLCeKDHdhWhb3qOhLsYAHMuw0CQD5ddqWgKHV3jKkmfFeZLgQ61ht/3oxHG09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RAMAHlp+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RAMAHlp+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 230CC2121C;
	Wed, 18 Jun 2025 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750246195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miCYiu6IQVGA+HHVM+0L5I4I1fM6CUx4RnRqhF29ei0=;
	b=RAMAHlp+sDfZGE6HWzNxhKxUd+W0JAfnN9TSnLfTZBE+8I88fH6nfWHUhd1mb/qy/uNp8X
	Q3nfH/JGS2Sr+DiIRLUzxTo3uFCwcUln8bAOHBukF0s0/mt8NgByrNDEFhNdYGWwXL9Erj
	7KWmtrhGSdb5bd52jK3cMNWyzU5Xw64=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750246195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miCYiu6IQVGA+HHVM+0L5I4I1fM6CUx4RnRqhF29ei0=;
	b=RAMAHlp+sDfZGE6HWzNxhKxUd+W0JAfnN9TSnLfTZBE+8I88fH6nfWHUhd1mb/qy/uNp8X
	Q3nfH/JGS2Sr+DiIRLUzxTo3uFCwcUln8bAOHBukF0s0/mt8NgByrNDEFhNdYGWwXL9Erj
	7KWmtrhGSdb5bd52jK3cMNWyzU5Xw64=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BE7813A3F;
	Wed, 18 Jun 2025 11:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ty7PBjOjUmipPwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 18 Jun 2025 11:29:55 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] btrfs: rename error to ret in btrfs_mksubvol()
Date: Wed, 18 Jun 2025 13:29:28 +0200
Message-ID: <107edad2046a728174ad8849668447418e3a24ad.1750246061.git.dsterba@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7cd6ae0c12c994..b38acf43ebb563 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -903,28 +903,27 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct dentry *dentry;
 	struct fscrypt_str name_str = FSTR_INIT((char *)name, namelen);
-	int error;
+	int ret;
 
-	error = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
-	if (error == -EINTR)
-		return error;
+	ret = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
+	if (ret == -EINTR)
+		return ret;
 
 	dentry = lookup_one(idmap, &QSTR_LEN(name, namelen), parent->dentry);
-	error = PTR_ERR(dentry);
+	ret = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_unlock;
 
-	error = btrfs_may_create(idmap, dir, dentry);
-	if (error)
+	ret = btrfs_may_create(idmap, dir, dentry);
+	if (ret)
 		goto out_dput;
 
 	/*
 	 * even if this name doesn't exist, we may get hash collisions.
 	 * check for them now when we can safely fail
 	 */
-	error = btrfs_check_dir_item_collision(BTRFS_I(dir)->root,
-					       dir->i_ino, &name_str);
-	if (error)
+	ret = btrfs_check_dir_item_collision(BTRFS_I(dir)->root, dir->i_ino, &name_str);
+	if (ret)
 		goto out_dput;
 
 	down_read(&fs_info->subvol_sem);
@@ -933,11 +932,11 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 		goto out_up_read;
 
 	if (snap_src)
-		error = create_snapshot(snap_src, dir, dentry, readonly, inherit);
+		ret = create_snapshot(snap_src, dir, dentry, readonly, inherit);
 	else
-		error = create_subvol(idmap, dir, dentry, inherit);
+		ret = create_subvol(idmap, dir, dentry, inherit);
 
-	if (!error)
+	if (!ret)
 		fsnotify_mkdir(dir, dentry);
 out_up_read:
 	up_read(&fs_info->subvol_sem);
@@ -945,7 +944,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	dput(dentry);
 out_unlock:
 	btrfs_inode_unlock(BTRFS_I(dir), 0);
-	return error;
+	return ret;
 }
 
 static noinline int btrfs_mksnapshot(const struct path *parent,
-- 
2.49.0


