Return-Path: <linux-btrfs+bounces-4863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A3F8C0D46
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 11:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E7328312C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C3D14A604;
	Thu,  9 May 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gJKZxFKG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gJKZxFKG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B1214A4DB
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245981; cv=none; b=Ktc6j3LNvylPjpVkS/8r7D7IC7bbAcbMkXXocdhPUFb7UG77yO3j1bkMfuQXd5K/BZ91ua2K1iEix5x0jYTlUhbtN3OKSCNdYudkwyP3pApGcDv9cQqnJ2sJf0loOpqLv2LitgsQAXE4qZmbUr8yBfk7riPTUrEPk2G980Bhero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245981; c=relaxed/simple;
	bh=utIzCba/mEneP85bvrR0QrflpB8vXbJiIO2tSYwQ6N0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IyiuWTR588HmtRzOR+FPODGo3kr1U+w8I46G/Ccybh4SH+q+UhsJI160YYGB3TVouuxgp7eaOr9YLLONEaxK2dvGzkBE6v3gDD6Yi5KTfsK+yEcXc0udh1alik9UyhoFtrjYB0oXwc74YyU40DEJjNfBJI+Um7jyMXIoa+POoYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gJKZxFKG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gJKZxFKG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E7205FB7C
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715245977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezWkQnw0RiPu5aODpPDmzInIckAKs4WS1Ye/E0uqyOA=;
	b=gJKZxFKGYzoV9vjSVRTHVpPrWEJ/z679NYBdojldxRaCGxeQSHt1iV9IkeqJcHVCvIFYVt
	m7rWVZB/Qg3b5KpUIA1Othaf4pywOK24EGZHgXcJ/UlKKcbK/QHfrGazdk00hnvzsEwcGR
	TQ/FNtR7IkGtGBJJUKKnxO1PPSX4YPQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715245977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezWkQnw0RiPu5aODpPDmzInIckAKs4WS1Ye/E0uqyOA=;
	b=gJKZxFKGYzoV9vjSVRTHVpPrWEJ/z679NYBdojldxRaCGxeQSHt1iV9IkeqJcHVCvIFYVt
	m7rWVZB/Qg3b5KpUIA1Othaf4pywOK24EGZHgXcJ/UlKKcbK/QHfrGazdk00hnvzsEwcGR
	TQ/FNtR7IkGtGBJJUKKnxO1PPSX4YPQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B55A13A24
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:12:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GL4bBJiTPGZ6KgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 09:12:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs-progs: cmds/qgroup: handle stale qgroup deleteion more accurately
Date: Thu,  9 May 2024 18:42:32 +0930
Message-ID: <d18afb13ac8bd8bf49ec7ad8294d5432c7a15eab.1715245781.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715245781.git.wqu@suse.com>
References: <cover.1715245781.git.wqu@suse.com>
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
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The current stale qgroup delete is a mess, it doesn't handle the
following cases at all:

- It doesn't detect stale qgroups correctly
  The current check is using the root backref, which means unlinked but
  not yet fully dropped subvolumes would mark its corresponding qgroups
  stale.

  This is incorrect. The real stale check should be based on the root
  item, not root backref.

- Squota non-empty but stale qgroups
  Such qgroups can not and should not be deleted, as future accounting
  still require them.

- Full accounting mode, stale qgroups but not empty
  Since qgroup numbers are inconsistent already, it's common to have
  such stale qgroups with non-zero numbers.

  Now it's dependent on the kernel to determine whether such qgroup can
  be deleted.

The patch would address the above problems by:

- Do root_item based detection
  So that btrfs_qgroup::stale would properly indicate if there is a
  subvolume root item for the qgroup.

- Do not attempt to delete squota stale but non-empty qgroups

- Attempt to delete stale but non-empty qgroups for full accounting mode
  And deletion failure would not count as an error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/qgroup.c | 119 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 16 deletions(-)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index a023f0948180..70a306117ebd 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -80,9 +80,24 @@ struct btrfs_qgroup {
 	struct rb_node all_parent_node;
 	u64 qgroupid;
 
-	/* NULL for qgroups with level > 0 */
+	/*
+	 * NULL for qgroups with level > 0 or the subvolume is *unlinked*.
+	 *
+	 * Note that, an unlinked subvolume doesn't mean it has been fully
+	 * dropped, so callers should not rely on this to determine if
+	 * a qgroup is stale.
+	 *
+	 * This member is only to help locating the path of the corresponding
+	 * subvolume.
+	 */
 	const char *path;
 
+	/*
+	 * This is only true if the qgroup is level 0 qgroup, and there is
+	 * no subvolume tree for the qgroup at all.
+	 */
+	bool stale;
+
 	/*
 	 * info_item
 	 */
@@ -229,6 +244,12 @@ static struct {
 static btrfs_qgroup_filter_func all_filter_funcs[];
 static btrfs_qgroup_comp_func all_comp_funcs[];
 
+static bool is_qgroup_empty(struct btrfs_qgroup *qg)
+{
+	return !(qg->info.referenced || qg->info.exclusive ||
+		 qg->info.referenced_compressed ||
+		 qg->info.exclusive_compressed);
+}
 static void qgroup_setup_print_column(enum btrfs_qgroup_column_enum column)
 {
 	int i;
@@ -795,7 +816,6 @@ static struct btrfs_qgroup *get_or_add_qgroup(int fd,
 		uret = btrfs_util_subvolume_path_fd(fd, qgroupid, &path);
 		if (uret == BTRFS_UTIL_OK)
 			bq->path = path;
-		/* Ignore stale qgroup items */
 		else if (uret != BTRFS_UTIL_ERROR_SUBVOLUME_NOT_FOUND) {
 			error("%s", btrfs_util_strerror(uret));
 			if (uret == BTRFS_UTIL_ERROR_NO_MEMORY)
@@ -803,6 +823,24 @@ static struct btrfs_qgroup *get_or_add_qgroup(int fd,
 			else
 				return ERR_PTR(-EIO);
 		}
+		/*
+		 * Do a correct stale detection by searching for the ROOT_ITEM of
+		 * the subvolume.
+		 *
+		 * Passing @subvol as NULL will force the search to only search
+		 * for the ROOT_ITEM.
+		 */
+		uret = btrfs_util_subvolume_info_fd(fd, qgroupid, NULL);
+		if (uret == BTRFS_UTIL_OK) {
+			bq->stale = false;
+		} else if (uret == BTRFS_UTIL_ERROR_SUBVOLUME_NOT_FOUND) {
+			bq->stale = true;
+		} else {
+			warning("failed to search root item for qgroup %u/%llu, assuming it not stale",
+				btrfs_qgroup_level(qgroupid),
+				btrfs_qgroup_subvolid(qgroupid));
+			bq->stale = false;
+		}
 	}
 
 	ret = qgroup_tree_insert(qgroup_lookup, bq);
@@ -2136,6 +2174,65 @@ static const char * const cmd_qgroup_clear_stale_usage[] = {
 	NULL
 };
 
+/*
+ * Return >0 if the qgroup should or can not be deleted.
+ * Return 0 if the qgroup is deleted.
+ * Return <0 for critical error.
+ */
+static int delete_one_stale_qgroup(struct qgroup_lookup *lookup,
+				   struct btrfs_qgroup *qg, int fd)
+{
+	u16 level = btrfs_qgroup_level(qg->qgroupid);
+	struct btrfs_ioctl_qgroup_create_args args = { .create = false };
+	const bool inconsistent = lookup->flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+	const bool squota = lookup->flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
+	const bool empty = is_qgroup_empty(qg);
+	bool attempt = false;
+	int ret;
+
+	if (level || !qg->stale)
+		return 1;
+
+	/*
+	 * By design, squota can have a subvolume fully dropped but its qgroup numbers
+	 * are not zero.
+	 * Such qgroup is still needed for future accounting, thus can not be deleted.
+	 */
+	if (squota && !empty)
+		return 1;
+
+	/*
+	 * We can have inconsistent qgroup numbers, in that case a really stale
+	 * qgroup can exist while its numbers are not zero.
+	 *
+	 * In this case we only attempt to delete the qgroup, depending on the
+	 * kernel implementation, we may or may not be able to delete it.
+	 */
+	if (inconsistent && !empty)
+		attempt = true;
+
+	if (attempt)
+		pr_verbose(LOG_DEFAULT,
+		"Attempt to delete stale but non-empty qgroup %u/%llu\n",
+			   level, btrfs_qgroup_subvolid(qg->qgroupid));
+	else
+		pr_verbose(LOG_DEFAULT, "Delete stale qgroup %u/%llu\n",
+			   level, btrfs_qgroup_subvolid(qg->qgroupid));
+	args.qgroupid = qg->qgroupid;
+	ret = ioctl(fd, BTRFS_IOC_QGROUP_CREATE, &args);
+	if (ret < 0) {
+		if (attempt) {
+			warning("not supported to delete non-empty stale qgroup %u/%llu",
+				level, btrfs_qgroup_subvolid(qg->qgroupid));
+			ret = 1;
+		} else {
+			error("failed to delete qgroup %u/%llu",
+				level, btrfs_qgroup_subvolid(qg->qgroupid));
+		}
+	}
+	return ret;
+}
+
 static int cmd_qgroup_clear_stale(const struct cmd_struct *cmd, int argc, char **argv)
 {
 	enum btrfs_util_error err;
@@ -2172,22 +2269,12 @@ static int cmd_qgroup_clear_stale(const struct cmd_struct *cmd, int argc, char *
 
 	node = rb_first(&qgroup_lookup.root);
 	while (node) {
-		u64 level;
-		struct btrfs_ioctl_qgroup_create_args args = { .create = false };
+		int delete_ret;
 
 		entry = rb_entry(node, struct btrfs_qgroup, rb_node);
-		level = btrfs_qgroup_level(entry->qgroupid);
-		if (!entry->path && level == 0) {
-			pr_verbose(LOG_DEFAULT, "Delete stale qgroup %llu/%llu\n",
-					level, btrfs_qgroup_subvolid(entry->qgroupid));
-			args.qgroupid = entry->qgroupid;
-			ret = ioctl(fd, BTRFS_IOC_QGROUP_CREATE, &args);
-			if (ret < 0) {
-				error("cannot delete qgroup %llu/%llu: %m",
-					level,
-					btrfs_qgroup_subvolid(entry->qgroupid));
-			}
-		}
+		delete_ret = delete_one_stale_qgroup(&qgroup_lookup, entry, fd);
+		if (delete_ret < 0 && !ret)
+			ret = delete_ret;
 		node = rb_next(node);
 	}
 
-- 
2.45.0


