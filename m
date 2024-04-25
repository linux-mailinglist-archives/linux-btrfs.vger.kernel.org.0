Return-Path: <linux-btrfs+bounces-4549-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D3B8B2CC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 00:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E622889FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Apr 2024 22:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1601791FC;
	Thu, 25 Apr 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sKxwuBzV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sKxwuBzV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B5C17799B
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082780; cv=none; b=Bl8h+IyhPLfmrnbb+CjQMsJRJ2Ce0ues6PplYZFkeC2phmeHKsxaS821PCSZg5xJCILDZxVyE7p0Uoc34XIoqhMXhBjiP8KoOWFemRZuYgr1B/F2dltZ3Rpq8QtGpxYsHnpwGZGZNhaUZNWsSlz1x744aCbDNRFFoAVKkxQx1xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082780; c=relaxed/simple;
	bh=tEDquzElXuurtuebriWEv1LZ/geKc1nsOtkGwKFPsmk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cidn7SwUM5J87GVk/1gRpc8vwduKS7spQeOnLdV7GK8jR9LUs4PGQB+L0yq2AIWoEgDYyq18PNK6ifnwOzAiPBJmJ0K+iQCgC2uZhvOCuz2lRfGIc4ynGwDiAgdpWGjKBFqv4LSCgVmeDwQBC0yUqjt9/aq+ZFfPRrK5ywfbG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sKxwuBzV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sKxwuBzV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 233C7344E1
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 22:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714082776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKmfGW93FHlY5Zl1Wu9IGBXmULIOUVnhdUVErQ/gdOQ=;
	b=sKxwuBzVaolXHdS9IjDaQtf9IOEzp+rtHDteS43lGc1OKxujkdSTs3AsvipgCVYCbA00vg
	92qfsYZXkJ7U66R7eyFKVu4qoCAlnFmgKc+5hW1jqlkJ/+JHRf5d56MZPKvDTojjEtzh5j
	PHve0TXait1Vk9lM37sJvLweCkRLBoM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sKxwuBzV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714082776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKmfGW93FHlY5Zl1Wu9IGBXmULIOUVnhdUVErQ/gdOQ=;
	b=sKxwuBzVaolXHdS9IjDaQtf9IOEzp+rtHDteS43lGc1OKxujkdSTs3AsvipgCVYCbA00vg
	92qfsYZXkJ7U66R7eyFKVu4qoCAlnFmgKc+5hW1jqlkJ/+JHRf5d56MZPKvDTojjEtzh5j
	PHve0TXait1Vk9lM37sJvLweCkRLBoM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBDCD1393C
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 22:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iB5fHdbTKmaQdgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 22:06:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] Revert "btrfs-progs: subvol delete: add options to delete the qgroup"
Date: Fri, 26 Apr 2024 07:35:52 +0930
Message-ID: <fa8f65936f31c07ca4783229140ecfb1f7ada785.1714082499.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714082499.git.wqu@suse.com>
References: <cover.1714082499.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 233C7344E1
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]

This reverts commit 9da773aa46ba33a9c3bdd83b31e15b031b3bfe4d.

There are several problems related to the --delete-qgroup option:

- Currently kernel doesn not allow to delete non-empty qgroups

- A qgroup can only be empty after fully dropped and a transaction is
  committed
  The tool doesn not take either factor into consideration

- Things like drop_subtree_threshold or other operations can mark qgroup
  inconsistent and skip accounting
  This can mean the target qgroup will never be empty until next rescan

On the other hand, even if we do the proper way, it would hugely delay
the command (wait until the subvolume to be dropped).

Furthermore, even all the wait is handled properly,
drop_subtree_threshold can still prevent us deleting the qgroup (qgroup
numbers are inconsistent, and accounting is skipped completely).

So this qgroup cleanup needs kernel work to support them anyway, and it
would be much easier to handle all the operations inside kernel.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-subvolume.rst |  7 -------
 cmds/subvolume.c                  | 26 --------------------------
 2 files changed, 33 deletions(-)

diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subvolume.rst
index d4379a2df83d..d1e89f15e1e2 100644
--- a/Documentation/btrfs-subvolume.rst
+++ b/Documentation/btrfs-subvolume.rst
@@ -112,13 +112,6 @@ delete [options] [<subvolume> [<subvolume>...]], delete -i|--subvolid <subvolid>
         -i|--subvolid <subvolid>
                 subvolume id to be removed instead of the <path> that should point to the
                 filesystem with the subvolume
-
-        --delete-qgroup
-                also delete the qgroup 0/subvolid if it exists
-
-        --no-delete-qgroup
-                do not delete the 0/subvolid qgroup (default)
-
         -v|--verbose
                 (deprecated) alias for global *-v* option
 
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 319f595ca495..f77a6e091569 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -348,8 +348,6 @@ static const char * const cmd_subvolume_delete_usage[] = {
 	OPTLINE("-c|--commit-after", "wait for transaction commit at the end of the operation"),
 	OPTLINE("-C|--commit-each", "wait for transaction commit after deleting each subvolume"),
 	OPTLINE("-i|--subvolid", "subvolume id of the to be removed subvolume"),
-	OPTLINE("--delete-qgroup", "also delete the qgroup 0/subvolid if it exists"),
-	OPTLINE("--no-delete-qgroup", "do not delete the qgroup 0/subvolid if it exists (default)"),
 	OPTLINE("-v|--verbose", "deprecated, alias for global -v option"),
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
@@ -378,20 +376,15 @@ static int cmd_subvolume_delete(const struct cmd_struct *cmd, int argc, char **a
 	enum { COMMIT_AFTER = 1, COMMIT_EACH = 2 };
 	enum btrfs_util_error err;
 	uint64_t default_subvol_id, target_subvol_id = 0;
-	bool opt_delete_qgroup = false;
 
 	optind = 0;
 	while (1) {
 		int c;
-		enum { GETOPT_VAL_DELETE_QGROUP = GETOPT_VAL_FIRST,
-		       GETOPT_VAL_NO_DELETE_QGROUP };
 		static const struct option long_options[] = {
 			{"commit-after", no_argument, NULL, 'c'},
 			{"commit-each", no_argument, NULL, 'C'},
 			{"subvolid", required_argument, NULL, 'i'},
 			{"verbose", no_argument, NULL, 'v'},
-			{"delete-qgroup", no_argument, NULL, GETOPT_VAL_DELETE_QGROUP },
-			{"no-delete-qgroup", no_argument, NULL, GETOPT_VAL_NO_DELETE_QGROUP },
 			{NULL, 0, NULL, 0}
 		};
 
@@ -412,12 +405,6 @@ static int cmd_subvolume_delete(const struct cmd_struct *cmd, int argc, char **a
 		case 'v':
 			bconf_be_verbose();
 			break;
-		case GETOPT_VAL_DELETE_QGROUP:
-			opt_delete_qgroup = true;
-			break;
-		case GETOPT_VAL_NO_DELETE_QGROUP:
-			opt_delete_qgroup = false;
-			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -553,19 +540,6 @@ again:
 			warning("deletion failed with EPERM, you don't have permissions or send may be in progress");
 		ret = 1;
 		goto out;
-	} else if (opt_delete_qgroup) {
-		struct btrfs_ioctl_qgroup_create_args args = { .qgroupid = target_subvol_id };
-
-		ret = ioctl(fd, BTRFS_IOC_QGROUP_CREATE, &args);
-		if (ret == 0) {
-			pr_verbose(LOG_DEFAULT, "Delete qgroup 0/%" PRIu64 "\n", target_subvol_id);
-		} else if (ret < 0 && (errno == ENOTCONN || errno == ENOENT)) {
-			/* Quotas not enabled, or there's no qgroup. */
-		} else {
-			warning("unable to delete qgroup 0/%llu: %m", subvolid);
-		}
-		/* Qgroup errors are not fatal. */
-		ret = 0;
 	}
 
 	if (commit_mode == COMMIT_EACH) {
-- 
2.44.0


