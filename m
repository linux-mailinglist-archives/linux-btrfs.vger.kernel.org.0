Return-Path: <linux-btrfs+bounces-4865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199928C0D48
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 11:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF0A1F25801
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 09:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C78B14A629;
	Thu,  9 May 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kqbjb+wg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kqbjb+wg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8470514A4F1
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245982; cv=none; b=q5tD1Rn4saTfnZHlvoGPvcOrIY2x1o95IscsJ29Mb/WTJk5ud7nu9C20OPMstbmTggjdczS32ux6+zzEU9Kzvpnb2eHOBSgcxN8Qb+Tn7/SSTlt1jX3Yrzim3VXjIEVLi7Nu8v4I+TOou9lA0C67RKTQCWt3HQQUJmywimAz240=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245982; c=relaxed/simple;
	bh=VfgPbyqmkDJMjON/Fs3VsA4kADkRenLwRXJeL0qNE3U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bl/7G+cwagpKf6yarRRgShmtmvDCAGa/itLoIjKFNKTkOXAqX1+w5SLEk+0qYtXP43yxkRKluyW/toTJazFMV2E+ncQBVU/txBAlAA0bkaWwkcvT+NYgy2Sn0piJI2WFNlURIX5t7eZFXZN2vxdk/SbcZA7TVtByQ0yZlxIDnJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kqbjb+wg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kqbjb+wg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0C603816F
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715245978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BhIwFODyTsP37yjtMgSFWa2/IofebGxy+5BFFE5Bn7U=;
	b=kqbjb+wgAT6cZNa05y0TFIRewZ/1jHi1YdKEF9DSUXCZMOLC6AxcdPQgYFebJFLEYvB7EB
	53IaJS8lEJGmVAkfvW2vE8TmbE5YJdCT+BJG30yqYITuwek+DJz5bfxbR+eG6suAMpCfHM
	78CvHprIXnbYoDEZ6w9ux9+SMQsljyk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715245978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BhIwFODyTsP37yjtMgSFWa2/IofebGxy+5BFFE5Bn7U=;
	b=kqbjb+wgAT6cZNa05y0TFIRewZ/1jHi1YdKEF9DSUXCZMOLC6AxcdPQgYFebJFLEYvB7EB
	53IaJS8lEJGmVAkfvW2vE8TmbE5YJdCT+BJG30yqYITuwek+DJz5bfxbR+eG6suAMpCfHM
	78CvHprIXnbYoDEZ6w9ux9+SMQsljyk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF2E313A24
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:12:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WORLIpmTPGZ6KgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 09:12:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs-progs: cmds/qgroup: add more special status for qgroups
Date: Thu,  9 May 2024 18:42:33 +0930
Message-ID: <6b7f2367322a05e6442fd8f5aedac23490b32b1c.1715245781.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Currently `btrfs qgroup show` command shows any 0 level qgroup withou a
root backref as `<stale>`, which is not correct.

There are several more cases:

- Under deletion
  The subvolume is not yet full dropped, but unlinked.
  In that case we would not have a root backref item, but the qgroup is
  not stale.

- Squota space holder
  This is for squota mode, that a fully dropped subvolume still have
  extents accounting on the already-gone subvolume.
  In this case it's not stale either, and future accounting relies on
  it.

This patch would add above special cases, and add an extra `SPECIAL
PATHS` section to explain all the cases, including `<stale>`.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-qgroup.rst | 24 ++++++++++++++++++++++++
 cmds/qgroup.c                  | 32 ++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/Documentation/btrfs-qgroup.rst b/Documentation/btrfs-qgroup.rst
index 343626767eb5..0e47c336619f 100644
--- a/Documentation/btrfs-qgroup.rst
+++ b/Documentation/btrfs-qgroup.rst
@@ -153,6 +153,30 @@ show [options] <path>
                 To retrieve information after updating the state of qgroups,
                 force sync of the filesystem identified by *path* before getting information.
 
+SPECIAL PATHS
+-------------
+For `btrfs qgroup show` subcommand, the ``path`` column may has some special
+strings:
+
+`<toplevel>`
+	The toplevel subvolume
+
+`<under deletion>`
+	The subvolume is unlinked, but not yet fully deleted.
+
+`<squota space holder>`
+	For simple quota mode only.
+	By its design, a fully deleted subvolume may still have accounting on
+	it, so even the subvolume is gone, the numbers are still here for future
+	accounting.
+
+`<stale>`
+	The qgroup has no corresponding subvolume anymore, and the qgroup
+	can be cleaned up under most cases.
+	The only exception is that, if the qgroup numbers are inconsistent and
+	the qgroup numbers are not all zeros, some older kernels may refuse to
+	delete such qgroups until a full rescan.
+
 QUOTA RESCAN
 ------------
 
diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 70a306117ebd..928c432ca432 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -71,6 +71,8 @@ struct qgroup_lookup {
 };
 
 struct btrfs_qgroup {
+	struct qgroup_lookup *lookup;
+
 	struct rb_node rb_node;
 	struct rb_node sort_node;
 	/*
@@ -321,6 +323,26 @@ static void print_qgroup_column_add_blank(enum btrfs_qgroup_column_enum column,
 		printf(" ");
 }
 
+static const char *get_qgroup_path(struct btrfs_qgroup *qgroup)
+{
+	if (qgroup->path)
+		return qgroup->path;
+
+	/* No path but not stale either, the qgroup is being deleted. */
+	if (!qgroup->stale)
+		return "<under deletion>";
+	/*
+	 * Squota mode stale qgroup, but not empty.
+	 * This is fully deleted but still necessary.
+	 */
+	if (qgroup->stale &&
+	    (qgroup->lookup->flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE) &&
+	    !is_qgroup_empty(qgroup))
+		return "<squota space holder>";
+
+	return "<stale>";
+}
+
 static void print_path_column(struct btrfs_qgroup *qgroup)
 {
 	struct btrfs_qgroup_list *list = NULL;
@@ -338,11 +360,8 @@ static void print_path_column(struct btrfs_qgroup *qgroup)
 			if (count)
 				pr_verbose(LOG_DEFAULT, " ");
 			if (level == 0) {
-				const char *path = member->path;
-
-				if (!path)
-					path = "<stale>";
-				pr_verbose(LOG_DEFAULT, "%s", path);
+				pr_verbose(LOG_DEFAULT, "%s",
+					   get_qgroup_path(qgroup));
 			} else {
 				pr_verbose(LOG_DEFAULT, "%llu/%llu", level, sid);
 			}
@@ -353,7 +372,7 @@ static void print_path_column(struct btrfs_qgroup *qgroup)
 	} else if (qgroup->path) {
 		pr_verbose(LOG_DEFAULT, "%s%s", (*qgroup->path ? "" : "<toplevel>"), qgroup->path);
 	} else {
-		pr_verbose(LOG_DEFAULT, "<stale>");
+		pr_verbose(LOG_DEFAULT, "%s", get_qgroup_path(qgroup));
 	}
 }
 
@@ -805,6 +824,7 @@ static struct btrfs_qgroup *get_or_add_qgroup(int fd,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	bq->lookup = qgroup_lookup;
 	bq->qgroupid = qgroupid;
 	INIT_LIST_HEAD(&bq->qgroups);
 	INIT_LIST_HEAD(&bq->members);
-- 
2.45.0


