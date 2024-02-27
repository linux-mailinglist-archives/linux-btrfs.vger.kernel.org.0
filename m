Return-Path: <linux-btrfs+bounces-2829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81387868819
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 05:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED902851FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 04:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B024D110;
	Tue, 27 Feb 2024 04:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nR1AgGit";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FMfp7EJf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB0C4C3CD
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 04:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709006582; cv=none; b=foytjbIo/ZsCLyZ6Qa/OItsjvfpNukhZLAI+z+y4c7uDACNQj0ZnPGeuowXwFum39MlEZMZ0SoU6MN9WLfsWCS6QT3YKPNLey3w+Xt+lwbPY+jV9JvMS/zlkwua79WaiyU+n8LZpE8Y+oG8jGXe7EyQaOxhKTULHGf/844jrDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709006582; c=relaxed/simple;
	bh=mu6MZPV7xwAA8umtpVomgPhS5y8Bn7vrwWCw7Q9RT2E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pqD+hrpfSpQEHaAs7P7Pyt6hJFawj4M5EsKlKO1exN3hg9FObZbQPKVBNochPYPYHrE0aBvYIDUk+Un4D3Mrw0lWgkh0mvK7Wg+qOzRrsCG7sb586Zlb5EY+fGgXT29YEzloePVpK2yt8kR8Vm6mabxq0xStlcJ1/911yInWcmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nR1AgGit; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FMfp7EJf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E52CB22722
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 04:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709006577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Z3Aa2QLU58bWFZdsatt9YQ+cuVnJgzvjzhAMKSnZBKs=;
	b=nR1AgGitTTHIIEmQ/XPtiIqEQsOONxdP/kW/2uZ9I4EpUU3VOb3cabiEy6aX6Dq8uZAHRf
	aOFjxz1qR0Fll9rr51+4GQdM+5MpHMnYEqkA16XFPPfjQMz8FHX/yy1VXL3nnDgFP2aPQ3
	9s7jBipbYEy6wCupyMweDyF3pPJAqJY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709006576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Z3Aa2QLU58bWFZdsatt9YQ+cuVnJgzvjzhAMKSnZBKs=;
	b=FMfp7EJfPHiaUdZDM4ab789lIOLH2Y5cpWfaCmC4mLd/W/0dTSSFMl75RGsY2JoXJp1I9g
	CiwcCpDky0oireUsbBrgCeTCnaniASefhkK1k2JOsm4a2qo0lR+ksoCfzb5+h/cI1eAL7S
	E9Q5Kj7xpj9wzpFlT/985tf7RCp21pw=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EF03413479
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 04:02:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id sAlAKO9e3WXvdgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 04:02:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove btrfs_qgroup_inherit_add_copy()
Date: Tue, 27 Feb 2024 14:32:33 +1030
Message-ID: <25d16c7c81b93d33d23fcbcaa35c24ce07cc00ef.1709006537.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=FMfp7EJf
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: E52CB22722
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

The function btrfs_qgroup_inherit_add_copy() is designed to add a pair
of source/destination qgroups into btrfs_qgroup_inherit structure, so
that rfer/excl numbers would be copied from the source qgroup into the
destination one.

This behavior is intentionally hidden since 2016, as such copy will
cause qgroup inconsistent immediately and a rescan would reset whatever
numbers copied anyway.

Now we're going to reject the copy behaviors from kernel, there is no
need to keep those hidden (and already disabled for "subvolume create")
behaviors.

This patch would remove btrfs_qgroup_inherit_add_copy() call, and
cleanup those undocumented options.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/qgroup.c    | 41 -----------------------------------------
 cmds/qgroup.h    |  2 --
 cmds/subvolume.c | 23 +----------------------
 3 files changed, 1 insertion(+), 65 deletions(-)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 20cc14aa8a58..72d68d918f7e 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -1687,47 +1687,6 @@ int btrfs_qgroup_inherit_add_group(struct btrfs_qgroup_inherit **inherit, char *
 	return 0;
 }
 
-int btrfs_qgroup_inherit_add_copy(struct btrfs_qgroup_inherit **inherit, char *arg,
-			    int type)
-{
-	int ret;
-	u64 qgroup_src;
-	u64 qgroup_dst;
-	char *p;
-	int pos = 0;
-
-	p = strchr(arg, ':');
-	if (!p) {
-bad:
-		error("invalid copy specification, missing separator :");
-		return -EINVAL;
-	}
-	*p = 0;
-	qgroup_src = parse_qgroupid_or_path(arg);
-	qgroup_dst = parse_qgroupid_or_path(p + 1);
-	*p = ':';
-
-	if (!qgroup_src || !qgroup_dst)
-		goto bad;
-
-	if (*inherit)
-		pos = (*inherit)->num_qgroups +
-		      (*inherit)->num_ref_copies * 2 * type;
-
-	ret = qgroup_inherit_realloc(inherit, 2, pos);
-	if (ret)
-		return ret;
-
-	(*inherit)->qgroups[pos++] = qgroup_src;
-	(*inherit)->qgroups[pos++] = qgroup_dst;
-
-	if (!type)
-		++(*inherit)->num_ref_copies;
-	else
-		++(*inherit)->num_excl_copies;
-
-	return 0;
-}
 static const char * const qgroup_cmd_group_usage[] = {
 	"btrfs qgroup <command> [options] <path>",
 	NULL
diff --git a/cmds/qgroup.h b/cmds/qgroup.h
index db48c0c2f8e2..1fc107221c3b 100644
--- a/cmds/qgroup.h
+++ b/cmds/qgroup.h
@@ -38,8 +38,6 @@ struct btrfs_qgroup_stats {
 
 int btrfs_qgroup_inherit_size(struct btrfs_qgroup_inherit *p);
 int btrfs_qgroup_inherit_add_group(struct btrfs_qgroup_inherit **inherit, char *arg);
-int btrfs_qgroup_inherit_add_copy(struct btrfs_qgroup_inherit **inherit, char *arg,
-			    int type);
 int btrfs_qgroup_query(int fd, u64 qgroupid, struct btrfs_qgroup_stats *stats);
 
 #endif
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 30ddf178221f..00c5eacfa694 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -281,13 +281,6 @@ static int cmd_subvolume_create(const struct cmd_struct *cmd, int argc, char **a
 			break;
 
 		switch (c) {
-		case 'c':
-			ret = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
-			if (ret) {
-				retval = ret;
-				goto out;
-			}
-			break;
 		case 'i':
 			ret = btrfs_qgroup_inherit_add_group(&inherit, optarg);
 			if (ret) {
@@ -685,18 +678,11 @@ static int cmd_subvolume_snapshot(const struct cmd_struct *cmd, int argc, char *
 	memset(&args, 0, sizeof(args));
 	optind = 0;
 	while (1) {
-		int c = getopt(argc, argv, "c:i:r");
+		int c = getopt(argc, argv, "i:r");
 		if (c < 0)
 			break;
 
 		switch (c) {
-		case 'c':
-			res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
-			if (res) {
-				retval = res;
-				goto out;
-			}
-			break;
 		case 'i':
 			res = btrfs_qgroup_inherit_add_group(&inherit, optarg);
 			if (res) {
@@ -707,13 +693,6 @@ static int cmd_subvolume_snapshot(const struct cmd_struct *cmd, int argc, char *
 		case 'r':
 			readonly = true;
 			break;
-		case 'x':
-			res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 1);
-			if (res) {
-				retval = res;
-				goto out;
-			}
-			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
-- 
2.43.2


