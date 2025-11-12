Return-Path: <linux-btrfs+bounces-18914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8B9C543B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB59C34FD86
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BA335505C;
	Wed, 12 Nov 2025 19:37:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A035502F
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976222; cv=none; b=cFdJ2bAAZyzIRkSP7C8WfaV4AInnQjYqfeBuW3BAKmxb4eeBvEx/zOOClfKB+25iubKR1MCd9wUvvfp2G9hbmI+K4qowdWvzIf7c1imB3O1+JVctcQeO0/N5hIlkO/5WaK5h5SunYLhjXWnPbNHKHoPPguJfk9BhIpCbxapY624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976222; c=relaxed/simple;
	bh=z8FtcWKnUX7aVQ3mV9pa8Goe4n8I3HewXIT6tjCipgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sq1MAMUHQG9J/jKR9f+eM02IT3cFXXuyC4FKtqOLya/Jd01WGalNpwbUGZ/ijq704zRwwdnVbqBxkecrr17TmhgMMYHsD1jPdSSNhL/I1xL95gbGNsZFYnpfT/4Cr/iCo3GiR9cms2R6XSuqqWxQCswzj39lI+zHlrYHVU/c82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8499221B66;
	Wed, 12 Nov 2025 19:36:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F29D3EA61;
	Wed, 12 Nov 2025 19:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kC58GsvhFGm+YgAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 12 Nov 2025 19:36:43 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/8] btrfs: move inode_to_path higher in backref.c
Date: Wed, 12 Nov 2025 20:36:06 +0100
Message-ID: <20251112193611.2536093-7-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112193611.2536093-1-neelx@suse.com>
References: <20251112193611.2536093-1-neelx@suse.com>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8499221B66
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

From: Josef Bacik <josef@toxicpanda.com>

We have a prototype and then the definition lower below, we don't need
to do this, simply move the function to where the prototype is.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
No code changes since v5.
---
 fs/btrfs/backref.c | 68 ++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index eff2d388a706..56e177941da4 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2574,8 +2574,39 @@ int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 	return iterate_extent_inodes(&walk_ctx, false, build_ino_list, ctx);
 }
 
+/*
+ * returns 0 if the path could be dumped (probably truncated)
+ * returns <0 in case of an error
+ */
 static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
-			 struct extent_buffer *eb, struct inode_fs_paths *ipath);
+			 struct extent_buffer *eb, struct inode_fs_paths *ipath)
+{
+	char *fspath;
+	char *fspath_min;
+	int i = ipath->fspath->elem_cnt;
+	const int s_ptr = sizeof(char *);
+	u32 bytes_left;
+
+	bytes_left = ipath->fspath->bytes_left > s_ptr ? ipath->fspath->bytes_left - s_ptr : 0;
+
+	fspath_min = (char *)ipath->fspath->val + (i + 1) * s_ptr;
+	fspath = btrfs_ref_to_path(ipath->fs_root, ipath->btrfs_path, name_len,
+				   name_off, eb, inum, fspath_min, bytes_left);
+	if (IS_ERR(fspath))
+		return PTR_ERR(fspath);
+
+	if (fspath > fspath_min) {
+		ipath->fspath->val[i] = (u64)(unsigned long)fspath;
+		++ipath->fspath->elem_cnt;
+		ipath->fspath->bytes_left = fspath - fspath_min;
+	} else {
+		++ipath->fspath->elem_missed;
+		ipath->fspath->bytes_missing += fspath_min - fspath;
+		ipath->fspath->bytes_left = 0;
+	}
+
+	return 0;
+}
 
 static int iterate_inode_refs(u64 inum, struct inode_fs_paths *ipath)
 {
@@ -2700,41 +2731,6 @@ static int iterate_inode_extrefs(u64 inum, struct inode_fs_paths *ipath)
 	return ret;
 }
 
-/*
- * returns 0 if the path could be dumped (probably truncated)
- * returns <0 in case of an error
- */
-static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
-			 struct extent_buffer *eb, struct inode_fs_paths *ipath)
-{
-	char *fspath;
-	char *fspath_min;
-	int i = ipath->fspath->elem_cnt;
-	const int s_ptr = sizeof(char *);
-	u32 bytes_left;
-
-	bytes_left = ipath->fspath->bytes_left > s_ptr ?
-					ipath->fspath->bytes_left - s_ptr : 0;
-
-	fspath_min = (char *)ipath->fspath->val + (i + 1) * s_ptr;
-	fspath = btrfs_ref_to_path(ipath->fs_root, ipath->btrfs_path, name_len,
-				   name_off, eb, inum, fspath_min, bytes_left);
-	if (IS_ERR(fspath))
-		return PTR_ERR(fspath);
-
-	if (fspath > fspath_min) {
-		ipath->fspath->val[i] = (u64)(unsigned long)fspath;
-		++ipath->fspath->elem_cnt;
-		ipath->fspath->bytes_left = fspath - fspath_min;
-	} else {
-		++ipath->fspath->elem_missed;
-		ipath->fspath->bytes_missing += fspath_min - fspath;
-		ipath->fspath->bytes_left = 0;
-	}
-
-	return 0;
-}
-
 /*
  * this dumps all file system paths to the inode into the ipath struct, provided
  * is has been created large enough. each path is zero-terminated and accessed
-- 
2.51.0


