Return-Path: <linux-btrfs+bounces-14028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A04AB7F83
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 10:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C704C4F60
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46D12820D1;
	Thu, 15 May 2025 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SK/Hlera";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SK/Hlera"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6E38DD8
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296054; cv=none; b=YWv0nQdI6dUMQpfWfJMzfq6WdZqyG93rXEe8kDVjaxFoBqM1Rtmue76sd9Kj6KF+wTOAIPgHGTOCHANC4EPGTV2WdR1kUTzXgrBaBps3FTEhf89N+wBZBzC9w3ET9FlMJ63zl8MCekIMST9sG1ZAUwzJeVarCp3AafVKI25tBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296054; c=relaxed/simple;
	bh=LTwLPDUhOVX7oy5aWDb9xHD0l5s0Qj805K5q1yrcZrk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZl9U6DT5Zs2IonEUnuYiiHo+XKzNQZpikuqgH074Kn78ChfHnr+ebfslo/aBNi/fvFNsSw0/8Mm+KppVSrZHcDyiibGw1rZWs10+F7lgv7QaGBFEhM6q5gtRIzd7L/6pfHUPZomDq5Q/2TuoN7b1V3XfWMffAXktKHH/jLfnbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SK/Hlera; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SK/Hlera; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 982451F7B7
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747296043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIrT9GDAO/A++uVweSTh/y9cntR0pisJw9ksbXXqcoY=;
	b=SK/Hlerass9mS1Jh8SVgV2rAE+zneZXcDndh4yXttJO4o52zxtV2hsR0VdVwY1ti3E6cnM
	vNCfuKr2YKmpBD6NmIT67Zi+xvysqytxRomxvRjCqxx1IWP+eYiOQdv6dCVyO3pagdjlJa
	tfFBc/uvOPgXjGaFXUdnRQVRhBKCwOE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="SK/Hlera"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747296043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIrT9GDAO/A++uVweSTh/y9cntR0pisJw9ksbXXqcoY=;
	b=SK/Hlerass9mS1Jh8SVgV2rAE+zneZXcDndh4yXttJO4o52zxtV2hsR0VdVwY1ti3E6cnM
	vNCfuKr2YKmpBD6NmIT67Zi+xvysqytxRomxvRjCqxx1IWP+eYiOQdv6dCVyO3pagdjlJa
	tfFBc/uvOPgXjGaFXUdnRQVRhBKCwOE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D27C9139D0
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4PG9JCqfJWi8LwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/6] btrfs-progs: fix-data-checksum: show affected files
Date: Thu, 15 May 2025 17:30:18 +0930
Message-ID: <6112e51519a5914c181dd1e5deb07bf165e15c72.1747295965.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747295965.git.wqu@suse.com>
References: <cover.1747295965.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 982451F7B7
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
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
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Previously "btrfs rescue fix-data-checksum" only show affected logical
bytenr, which is not helpful to determine which files are affected.

Enhance the output by also outputting the affected subvolumes (in
numeric form), and the file paths inside that subvolume.

The example looks like this:

  logical=13631488 corrtuped mirrors=1 affected files:
    (subvolume 5)/foo
    (subvolume 5)/dir/bar
  logical=13635584 corrtuped mirrors=1 affected files:
    (subvolume 5)/foo
    (subvolume 5)/dir/bar

Although the end result is still not perfect, it's still much easier to
find out which files are affected.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/rescue-fix-data-checksum.c | 59 +++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/cmds/rescue-fix-data-checksum.c b/cmds/rescue-fix-data-checksum.c
index 7e613ba57f76..bf3a65b31c71 100644
--- a/cmds/rescue-fix-data-checksum.c
+++ b/cmds/rescue-fix-data-checksum.c
@@ -18,6 +18,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/backref.h"
 #include "common/messages.h"
 #include "common/open-utils.h"
 #include "cmds/rescue.h"
@@ -158,6 +159,49 @@ static int iterate_one_csum_item(struct btrfs_fs_info *fs_info, struct btrfs_pat
 	return ret;
 }
 
+static int print_filenames(u64 ino, u64 offset, u64 rootid, void *ctx)
+{
+	struct btrfs_fs_info *fs_info = ctx;
+	struct btrfs_root *root;
+	struct btrfs_key key;
+	struct inode_fs_paths *ipath;
+	struct btrfs_path path = { 0 };
+	int ret;
+
+	key.objectid = rootid;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = (u64)-1;
+
+	root = btrfs_read_fs_root(fs_info, &key);
+	if (IS_ERR(root)) {
+		ret = PTR_ERR(root);
+		errno = -ret;
+		error("failed to get subvolume %llu: %m", rootid);
+		return ret;
+	}
+	ipath = init_ipath(128 * BTRFS_PATH_NAME_MAX, root, &path);
+	if (IS_ERR(ipath)) {
+		ret = PTR_ERR(ipath);
+		errno = -ret;
+		error("failed to initialize ipath: %m");
+		return ret;
+	}
+	ret = paths_from_inode(ino, ipath);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to resolve root %llu ino %llu to paths: %m", rootid, ino);
+		goto out;
+	}
+	for (int i = 0; i < ipath->fspath->elem_cnt; i++)
+		printf("  (subvolume %llu)/%s\n", rootid, (char *)ipath->fspath->val[i]);
+	if (ipath->fspath->elem_missed)
+		printf("  (subvolume %llu) %d files not printed\n", rootid,
+		       ipath->fspath->elem_missed);
+out:
+	free_ipath(ipath);
+	return ret;
+}
+
 static int iterate_csum_root(struct btrfs_fs_info *fs_info, struct btrfs_root *csum_root)
 {
 	struct btrfs_path path = { 0 };
@@ -197,9 +241,10 @@ next:
 	return ret;
 }
 
-static void report_corrupted_blocks(void)
+static void report_corrupted_blocks(struct btrfs_fs_info *fs_info)
 {
 	struct corrupted_block *entry;
+	struct btrfs_path path = { 0 };
 
 	if (list_empty(&corrupted_blocks)) {
 		printf("No data checksum mismatch found\n");
@@ -208,6 +253,7 @@ static void report_corrupted_blocks(void)
 
 	list_for_each_entry(entry, &corrupted_blocks, list) {
 		bool has_printed = false;
+		int ret;
 
 		printf("logical=%llu corrtuped mirrors=", entry->logical);
 		/* Poor man's bitmap print. */
@@ -223,7 +269,14 @@ static void report_corrupted_blocks(void)
 				has_printed=true;
 			}
 		}
-		printf("\n");
+		printf(" affected files:\n");
+		ret = iterate_inodes_from_logical(entry->logical, fs_info, &path,
+						  print_filenames, fs_info);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to iterate involved files: %m");
+			break;
+		}
 	}
 }
 
@@ -280,7 +333,7 @@ int btrfs_recover_fix_data_checksum(const char *path,
 		errno = -ret;
 		error("failed to iterate csum tree: %m");
 	}
-	report_corrupted_blocks();
+	report_corrupted_blocks(fs_info);
 out_close:
 	free_corrupted_blocks();
 	close_ctree_fs_info(fs_info);
-- 
2.49.0


