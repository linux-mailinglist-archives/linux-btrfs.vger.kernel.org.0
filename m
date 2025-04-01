Return-Path: <linux-btrfs+bounces-12736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E3DA7852B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 01:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCD7188FF50
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 23:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622F521A42D;
	Tue,  1 Apr 2025 23:18:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16667219A90
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743549509; cv=none; b=pRLx+3p9GnplOJvYEzargkSiS3/9bepDCVgWPv7rbQiLTjeRM6svRpfYDw+3GPgmaKvDPxs51G8xoKgge08Vt16Nk+UyYLUWBM8ULyxs+Jj1SjyD7dNLejjzozkSBhWiaf/pXWgYXshdT4WhehOxW+A2Fe1ziE82zNkDEqVZxuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743549509; c=relaxed/simple;
	bh=CTxUjUIMPRIcYYvD3HVoI1TaPmkdyfOAa6/HCJISPBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJV8xoUuLRkajoLE1bEjA7gYtJq5wwagiaLAYgKMCdSWuSDDTxbDEiu4paSiVEAQVDowWB2tPBPKyJN3ECuNZNu8oJNzlIEUxR254ukNg1LWhj44/ztPQDGNHrTP0nEvIip2/cAwsugUutWLnS3VXrbLU4tnkq9Vhyj2pFS4O3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3DFC121193;
	Tue,  1 Apr 2025 23:18:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 361B513691;
	Tue,  1 Apr 2025 23:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 61IzDUB07GeuewAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Apr 2025 23:18:24 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/7] btrfs: use BTRFS_PATH_AUTO_FREE in may_destroy_subvol()
Date: Wed,  2 Apr 2025 01:18:07 +0200
Message-ID: <87a43aa8a7946127eb64d330b85fca104302031f.1743549291.git.dsterba@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1743549291.git.dsterba@suse.com>
References: <cover.1743549291.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3DFC121193
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index db989572cba419..b3c2847ddae274 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4477,7 +4477,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 static noinline int may_destroy_subvol(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
 	struct fscrypt_str name = FSTR_INIT("default", 7);
@@ -4499,7 +4499,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 			btrfs_err(fs_info,
 				  "deleting default subvolume %llu is not allowed",
 				  key.objectid);
-			goto out;
+			return ret;
 		}
 		btrfs_release_path(path);
 	}
@@ -4510,14 +4510,13 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 
 	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret == 0) {
 		/*
 		 * Key with offset -1 found, there would have to exist a root
 		 * with such id, but this is out of valid range.
 		 */
-		ret = -EUCLEAN;
-		goto out;
+		return -EUCLEAN;
 	}
 
 	ret = 0;
@@ -4527,8 +4526,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 		if (key.objectid == btrfs_root_id(root) && key.type == BTRFS_ROOT_REF_KEY)
 			ret = -ENOTEMPTY;
 	}
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
-- 
2.48.1


