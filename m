Return-Path: <linux-btrfs+bounces-2190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0D84C2CA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 03:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EC21F24231
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 02:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E344A12E47;
	Wed,  7 Feb 2024 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ax1ywQJ2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96DF9EF
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274601; cv=none; b=QInBgYH1kv5vOfg12lLux2Cu9XMcsdl7E7rDv8eqr+pV0ckM/UC96xz/O3GGJhLV3WOqIS0M7kFSxN45qB5FGigW0ntd/dbF51XqG2T0028YmzWwOAe+vZ8QcTtvV5BSkWlZjai54cCeGLW7xGQtPBWLVJZ/lDxA8BqzKbBQq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274601; c=relaxed/simple;
	bh=n3McJjJh/WLCQm3zWRum7CJcJhpjLROkO/Uv6o5ddcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ru0970eOTu7uO5y3jRPYRhjSL3MCXzmNn+qR3mfZPN85/arN7/hwWl5k1IdcDLF18DdytOAxI8qitVHeaEO5jpFdO+bP4i5uIEW+hF/l9RwmdWM9/7yqBGKDGwu/8bxJEGBqo97INGWweDBQqhkN9/Y5OZ18s26GYEo3TItZLkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ax1ywQJ2; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707274597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNJ5lQuPym878v0er8vpFPNJuyo1lBu3+aim1D8jyPw=;
	b=Ax1ywQJ2cq7Mst1G9TvZ1jy/KZKCdB3wwM6nrmmh+8C3mADSEeaKp88+b5UpuJ3b2zJStx
	82Xd4FyhygMECo19HN9HAeuvg89PdmaT+GDfacbQd2wTVBvehT8dXl8W609P0J064UeBpB
	g8OaUrY/Ei8oRdgLnN1rl09/t1VGcfU=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-btrfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v3 2/7] overlayfs: Convert to super_set_uuid()
Date: Tue,  6 Feb 2024 21:56:16 -0500
Message-ID: <20240207025624.1019754-3-kent.overstreet@linux.dev>
In-Reply-To: <20240207025624.1019754-1-kent.overstreet@linux.dev>
References: <20240207025624.1019754-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We don't want to be settingc sb->s_uuid directly anymore, as there's a
length field that also has to be set, and this conversion was not
completely trivial.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org
---
 fs/overlayfs/util.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 0217094c23ea..f1f0ee9a9dff 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -760,13 +760,14 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
 			 const struct path *upperpath)
 {
 	bool set = false;
+	uuid_t uuid;
 	int res;
 
 	/* Try to load existing persistent uuid */
-	res = ovl_path_getxattr(ofs, upperpath, OVL_XATTR_UUID, sb->s_uuid.b,
+	res = ovl_path_getxattr(ofs, upperpath, OVL_XATTR_UUID, uuid.b,
 				UUID_SIZE);
 	if (res == UUID_SIZE)
-		return true;
+		goto success;
 
 	if (res != -ENODATA)
 		goto fail;
@@ -794,14 +795,14 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
 	}
 
 	/* Generate overlay instance uuid */
-	uuid_gen(&sb->s_uuid);
+	uuid_gen(&uuid);
 
 	/* Try to store persistent uuid */
 	set = true;
-	res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, sb->s_uuid.b,
+	res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, uuid.b,
 			   UUID_SIZE);
 	if (res == 0)
-		return true;
+		goto success;
 
 fail:
 	memset(sb->s_uuid.b, 0, UUID_SIZE);
@@ -809,6 +810,9 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
 	pr_warn("failed to %s uuid (%pd2, err=%i); falling back to uuid=null.\n",
 		set ? "set" : "get", upperpath->dentry, res);
 	return false;
+success:
+	super_set_uuid(sb, uuid.b, sizeof(uuid));
+	return true;
 }
 
 bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, const struct path *path,
-- 
2.43.0


