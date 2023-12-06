Return-Path: <linux-btrfs+bounces-724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65E38078F0
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 20:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4F41C20E2C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211B747F76;
	Wed,  6 Dec 2023 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="G0l+RAGB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A390318D
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 11:52:27 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id K7rM2B00T04l9eU017rNXN; Wed, 06 Dec 2023 19:51:22 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>,
	Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/4] new command: btrfs filesystem get-info ...
Date: Wed,  6 Dec 2023 20:32:44 +0100
Message-ID: <bf76fb3c704069461ec8cd8999bb20e234cdbad4.1701891165.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701891165.git.kreijack@inwind.it>
References: <cover.1701891165.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1701892282; bh=uGkmsN2BQJ0BbIaILYEV0FW2f+O/sTbklFXbWeGC3Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=G0l+RAGBifeBFb0FBye6yRgiuCz7phLfC3KoCpUbJbH/trQb/dVbfgD1M6qrIb9xT
	 6KQM+YFfEccpyFVR5Buua4Aww2P/Jigc7TxZn8T5VFqqnKV6dp2hQ2JU3dzm5Xx9Ww
	 mkeKnWvKazBgcxsTEqRtD10+A90LYHvwSwNULvAw=

From: Goffredo Baroncelli <kreijack@inwind.it>

usage: btrfs filesystem get-info <options> <filesystemspec>

This new command returns specific info of a btrfs filesystem.

<filesystemspec> is in the form of:

- UUID=<uuid>
- UUID_SUB=<subuuid>
- PARTUUID=<partuuid>
- LABEL=<label>
- btrfs <device>
- a valid btrfs path

and <option> is one of the following:
    -d    show one accessible device of the filesystem passed as argument.
    -D    show all the devices of the filesystem passed as argument.
    -l    show the label of the filesystem passed as argument.
    -m    show one accessible mountpoint of the filesystem passed as argument.
    -M    show all the mountpoints of the filesystem passed as argument.
    -r    show the rootpath name of the argument (which must be a path).
    -s    show the subvolume name of the argument (which must be a path).
    -U    show the UUID of the filesystem passed as argument.
    --is-mounted    the 0 exit code is returned if the filesystem passed
                    as argument is mounted.

The intended use is as helper in the script.

Typical usage:
-----------------------------
$ ./btrfs fi get-info -D /
/dev/sdd3
-----------------------------

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 cmds/filesystem.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 38a0787f..a6c29bf3 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1546,6 +1546,102 @@ static int cmd_filesystem_info(const struct cmd_struct *cmd,
 }
 static DEFINE_SIMPLE_COMMAND(filesystem_info, "info");
 
+static const char * const cmd_filesystem_get_info_usage[] = {
+	"btrfs filesystem get-info -m|-M|-d|-s|-r|-D|-U|-l|--is-mounted UUID=<uuid>|UUID_SUB=<subuuid>|PARTUUID=<partuuid>|LABEL=<label>|<device>|<mount_point>",
+	"Get some information of a btrfs filesystem.",
+	"One of the following option must be passed:",
+	"-d    show one accessible device of the filesystem passed as argument.",
+	"-D    show all the devices of the filesystem passed as argument.",
+	"-l    show the label of the filesystem passed as argument.",
+	"-m    show one accessible mountpoint of the filesystem passed as argument.",
+	"-M    show all the mountpoints of the filesystem passed as argument.",
+	"-r    show the rootpath name of the argument (which must be a path).",
+	"-s    show the subvolume name of the argument (which must be a path).",
+	"-U    show the UUID of the filesystem passed as argument.",
+	"--is-mounted    the 0 exit code is returned if the filesystem passed",
+	"                as argument is mounted.",
+	NULL
+};
+
+static int cmd_filesystem_get_info(const struct cmd_struct *cmd,
+				int argc, char **argv)
+{
+	if (check_argc_min(argc - optind, 2) || check_argc_max(argc - optind, 2))
+		return 1;
+
+	const struct btrfs_info *bi;
+	int r = btrfs_info_find(argv[2], &bi);
+	if (r < 0) {
+		error("Cannot get info for '%s': %d - %s\n", argv[2],
+		      -r, strerror(-r));
+		return 2;
+	}
+
+	if (!strcmp(argv[1], "-m")) {
+		const char *p = btrfs_info_find_valid_path(bi);
+		if (!p)
+			return 100;
+		printf("%s\n", p);
+	} else if (!strcmp(argv[1], "-d")) {
+		const char *p = btrfs_info_find_valid_dev(bi);
+		if (!p)
+			return 100;
+		printf("%s\n", p);
+	} else if (!strcmp(argv[1], "-s") || !strcmp(argv[1], "-r")) {
+		const struct btrfs_info_mount *bm, *res = NULL;
+		const char *winner = NULL;
+		int winner_length = 0;
+		char *path = realpath(argv[2], NULL);
+		if (!path) {
+			fprintf(stderr, "ERROR: in realpath(%s)\n", argv[2]);
+			return -EINVAL;
+		}
+		int lpath = strlen(path);
+		for (bm = bi->mounts; bm; bm = bm->next) {
+			int l = strlen(bm->dest);
+			if (l > lpath)
+				continue;
+			if (strncmp(bm->dest, path, lpath))
+				continue;
+			if (!winner || l > winner_length) {
+				winner = bm->dest;
+				winner_length = l;
+				res = bm;
+			}
+		}
+		free(path);
+		if (!res)
+			return 100;
+		if (!strcmp(argv[1], "-s"))
+			printf("%s\n", res->subvol);
+		else /* -r */
+			printf("%s\n", res->rootpath);
+	} else if (!strcmp(argv[1], "-M")) {
+		const struct btrfs_info_mount *bm = bi->mounts;
+		while (bm) {
+			printf("%s\n", bm->dest);
+			bm = bm->next;
+		}
+	} else if (!strcmp(argv[1], "-D")) {
+		const struct btrfs_info_device *bd = bi->devices;
+		while (bd) {
+			printf("%s\n", bd->name);
+			bd = bd->next;
+		}
+	} else if (!strcmp(argv[1], "-U")) {
+		printf("%s\n", bi->uuid);
+	} else if (!strcmp(argv[1], "-l")) {
+		printf("%s\n", bi->label);
+	} else if (!strcmp(argv[1], "--is-mounted")) {
+		return btrfs_info_is_mounted(bi) ? 0 : 100;
+	} else {
+		error("Unknown parameter '%s'", argv[1]);
+	}
+
+	return 0;
+}
+static DEFINE_SIMPLE_COMMAND(filesystem_get_info, "get-info");
+
 static const char * const cmd_filesystem_balance_usage[] = {
 	"btrfs filesystem balance [args...] (alias of \"btrfs balance\")",
 	"Please see \"btrfs balance --help\" for more information.",
@@ -1751,6 +1847,7 @@ static const struct cmd_group filesystem_cmd_group = {
 		&cmd_struct_filesystem_resize,
 		&cmd_struct_filesystem_label,
 		&cmd_struct_filesystem_info,
+		&cmd_struct_filesystem_get_info,
 		&cmd_struct_filesystem_usage,
 		&cmd_struct_filesystem_mkswapfile,
 		NULL
-- 
2.43.0


