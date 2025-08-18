Return-Path: <linux-btrfs+bounces-16119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0265B295D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 02:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F593B4B82
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 00:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F658218AA0;
	Mon, 18 Aug 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IIaTyf9M";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IIaTyf9M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932820B80A
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755477150; cv=none; b=sYxTKdVq/zF4MPYwgUJb/jbynwTN9J4qzz08kKBQHotlYzzc/I31S3O3l69xNkq2xMjFE0jCtzhQ3WLJjIU63JHwQgsB3OHeV7yU08S5Vs8BiCZARUUwexc/U4HRbAWKpz1RLqIcSz618lgnuHHgH+TFaTW0DtmWCUq4sTZhT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755477150; c=relaxed/simple;
	bh=WJjAzg/6UyFkbR7zxrNtUdarGhiuf4VhYgGd+0jy/B0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pF1USqI9g/6rcbCZqcHr/nVPLMRCZ6levyKQGIhlf2ml0K0K7N2TiFadMXW4fCk97qhkgN8lQZ+ViMz6v4OuaqQquRDy4onDdh+DSjbBOv8yOgFQIpEOwJAPM5As+zlYH5hMRoFtU2u0gzkrWAYawqw1tVWKekWpN41RAxBKYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IIaTyf9M; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IIaTyf9M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8605C218FC
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755477128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TxHKIOJsoYulkRLcpue6WvWX0fFvom9hXJeXw7H/ZU=;
	b=IIaTyf9MqBWjR0c5YdVP4gtL+nSQywopp/icerUn2TpLhyUGEybaYh/1NaU2GxTDJOrtjT
	76ndVflQ3UgvGrFYBCfFPAMeZqha2n1Ntv9Vxl/F9OxCVuXXafAFJZWNl+iJN6lJNQCdLD
	/KhF3SpiobGehlgfnheRgYVCL7o6VYA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=IIaTyf9M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755477128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TxHKIOJsoYulkRLcpue6WvWX0fFvom9hXJeXw7H/ZU=;
	b=IIaTyf9MqBWjR0c5YdVP4gtL+nSQywopp/icerUn2TpLhyUGEybaYh/1NaU2GxTDJOrtjT
	76ndVflQ3UgvGrFYBCfFPAMeZqha2n1Ntv9Vxl/F9OxCVuXXafAFJZWNl+iJN6lJNQCdLD
	/KhF3SpiobGehlgfnheRgYVCL7o6VYA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C273713686
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SPf0IId0omhWKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs-progs: mkfs/rootdir: extract inode flags validation code into a helper
Date: Mon, 18 Aug 2025 10:01:44 +0930
Message-ID: <a3f2a149cc9b1ae1c6b43c5aecc52af92c83e691.1755474438.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755474438.git.wqu@suse.com>
References: <cover.1755474438.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 8605C218FC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Currently we do the validation of inode flag parameters inside
mkfs/main.c, but considering all things like structure
rootdir_inode_flags_entry are all inside rootdir.[ch], it's better to
move the validation part into rootdir.[ch].

Extract the validation part into a helper,
btrfs_mkfs_validate_inode_flags(), into rootdir.[ch].

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c    | 37 +++----------------------------------
 mkfs/rootdir.c | 39 +++++++++++++++++++++++++++++++++++++++
 mkfs/rootdir.h |  1 +
 3 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index bde897afd029..f0d2e42421e6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1531,40 +1531,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (ret < 0)
 		goto error;
 
-	list_for_each_entry(rif, &inode_flags_list, list) {
-		char path[PATH_MAX];
-		struct rootdir_inode_flags_entry *rif2;
-
-		if (path_cat_out(path, source_dir, rif->inode_path)) {
-			ret = -EINVAL;
-			error("path invalid: %s", path);
-			goto error;
-		}
-		if (!realpath(path, rif->full_path)) {
-			ret = -errno;
-			error("could not get canonical path: %s: %m", path);
-			goto error;
-		}
-		if (!path_exists(rif->full_path)) {
-			ret = -ENOENT;
-			error("inode path does not exist: %s", rif->full_path);
-			goto error;
-		}
-		list_for_each_entry(rif2, &inode_flags_list, list) {
-			/*
-			 * Only compare entries before us. So we won't compare
-			 * the same pair twice.
-			 */
-			if (rif2 == rif)
-				break;
-			if (strcmp(rif2->full_path, rif->full_path) == 0) {
-				error("duplicated inode flag entries for %s",
-					rif->full_path);
-				ret = -EEXIST;
-				goto error;
-			}
-		}
-	}
+	ret = btrfs_mkfs_validate_inode_flags(source_dir, &inode_flags_list);
+	if (ret < 0)
+		goto error;
 
 	if (*fs_uuid) {
 		uuid_t dummy_uuid;
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index e9d5c6bed0c4..1fc050f3ab1b 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -1123,6 +1123,45 @@ int btrfs_mkfs_validate_subvols(const char *source_dir, struct list_head *subvol
 	return 0;
 }
 
+int btrfs_mkfs_validate_inode_flags(const char *source_dir, struct list_head *inode_flags)
+{
+	struct rootdir_inode_flags_entry *rif;
+
+	list_for_each_entry(rif, inode_flags, list) {
+		char path[PATH_MAX];
+		struct rootdir_inode_flags_entry *rif2;
+		int ret;
+
+		if (path_cat_out(path, source_dir, rif->inode_path)) {
+			error("path invalid: %s", path);
+			return -EINTR;
+		}
+		if (!realpath(path, rif->full_path)) {
+			ret = -errno;
+			error("could not get canonical path: %s: %m", path);
+			return ret;
+		}
+		if (!path_exists(rif->full_path)) {
+			error("inode path does not exist: %s", rif->full_path);
+			return -ENOENT;
+		}
+		list_for_each_entry(rif2, inode_flags, list) {
+			/*
+			 * Only compare entries before us. So we won't compare
+			 * the same pair twice.
+			 */
+			if (rif2 == rif)
+				break;
+			if (strcmp(rif2->full_path, rif->full_path) == 0) {
+				error("duplicated inode flag entries for %s",
+					rif->full_path);
+				return -EEXIST;
+			}
+		}
+	}
+	return 0;
+}
+
 static int add_file_items(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root,
 			  struct btrfs_inode_item *btrfs_inode, u64 objectid,
diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
index c9761e090984..cbb83355ee9b 100644
--- a/mkfs/rootdir.h
+++ b/mkfs/rootdir.h
@@ -61,6 +61,7 @@ struct rootdir_inode_flags_entry {
 };
 
 int btrfs_mkfs_validate_subvols(const char *source_dir, struct list_head *subvols);
+int btrfs_mkfs_validate_inode_flags(const char *source_dir, struct list_head *inode_flags);
 int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *source_dir,
 			struct btrfs_root *root, struct list_head *subvols,
 			struct list_head *inode_flags_list,
-- 
2.50.1


