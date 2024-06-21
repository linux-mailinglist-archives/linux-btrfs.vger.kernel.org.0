Return-Path: <linux-btrfs+bounces-5895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE5912D98
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 20:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7597128A4EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 18:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0449917C210;
	Fri, 21 Jun 2024 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="2AJIZM5f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA917B509
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996042; cv=none; b=QHO706tdzapGuJZos/EIhw8ZQpVs44NKPu7v/B2Qcqy0kbkL0XAGNFBUv8EwUFOIBp/l62qg5GWCzjYIvOCU6Jf9J+WhqGR/pb0DWKUNlURvEENqpKu2Qu385RuxpuAQGQ4L8zcKRX6Ol6pMjmeZR73g4+PmV/bKAyrYn53971g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996042; c=relaxed/simple;
	bh=nc4eReYEnK9FxSD8Vr8UZctZG7mrd8qchTZ2vyvEvxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snHoTGqG7OavBCNxSU0JnLxdhvYKzAwNy1KkoT3sX6cuQhhWMO+GZ1V5t4BDb+W5q11KNFtN0d4e/OL6GwMeFbIlUd2vtip8KCHwtSfNvtOMzkO9Ibj+DpzZP0AZVn/py5+gDY4/M2dXIjVxQgQylJiasb9hjzLtBQoHpCXcNio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=2AJIZM5f; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-71816f36d4dso433406a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1718996040; x=1719600840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/V5hL5Wvz5/EkwK3eEVEu+zgQlQLp61GSiylGiYTHo=;
        b=2AJIZM5fylObGUTUzwK1nEmAOhdlGRe1ZtvUzph/a3rgsx3mgDtJ4WpP2IUqbZ6ow6
         NLkCxEHr/uIstMOI6MA5T2D5Hv7M4vhnrbj/r8EpL4ZM58Rahsxf//hDwDQsWylyT4qK
         Hk6Sw8ACuKJGvwKvZ4ju6dN3Nd9Ewgv5WgrE/mTDKJykMSwiLrS/w/k8JpNp60FBf0UI
         dDaIAeRF+kox5Gavs5BDTlaonEykun+UV4I9SNJMQ5+18jd4uiENTvxFrlw20FPATv7d
         bXUQws+jOneFPoIJbzn6WI2l1/KzZMDzoAgOF1zZChL++O6dWKvJeHlZKKu/j9zJcJDH
         9Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718996040; x=1719600840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/V5hL5Wvz5/EkwK3eEVEu+zgQlQLp61GSiylGiYTHo=;
        b=FMbkUdIUze2xgl3qd/OYvFhH7GWJh4Vjxb9dP0gz32heYhcln9QabxaV6kR8UCM+gs
         23fFmlB8yvVhYJcHbQEHak7k6D43m6m/S+fwRI92k6kAZA5sZCy22UhvHQcSrFWHWLiB
         4fbjSa3n09mlE/TTT6JS1wpsaL71uD806OGhq/EbkBNwgdoQVpElk7+cOQNj50CcvRWP
         h06pPbnv3MMqrjXLyhOBD4KnihsLVp3NIIGcJ62j5sPUTrGRi9OjIX71tRB86Kw+DzyM
         /omyXNfd7n30K3F3MFbfASxZpaz+LIbCCT4dZ1XfqTJeAz9gsu90clpJKyXy+YREffVo
         Oeeg==
X-Gm-Message-State: AOJu0Yxy568rkDeqx0Y8N2ruFoxcFpq+QwwzufLiOgz5AQfXuEP6shKN
	IG5kcUtuqrdDZnVQhSPCl+fHwzREzvkO26jmXJwGbVmAxwEeUfB7RmqnAgHANrYUTwGKrUDVPeE
	s
X-Google-Smtp-Source: AGHT+IE8HMhbihMLkiujCyo6bwns2EzJFrXeKCOdSywQIHmeeKjXwyCjMo22tBY/RBb+uKZT/h5SWA==
X-Received: by 2002:a17:90a:d905:b0:2c7:a907:b6bd with SMTP id 98e67ed59e1d1-2c7b5dbf636mr8708243a91.49.1718996039731;
        Fri, 21 Jun 2024 11:53:59 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::6:1ec7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e06e7sm3957366a91.21.2024.06.21.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:53:59 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 8/8] btrfs-progs: subvol list: add sane -O and -A options
Date: Fri, 21 Jun 2024 11:53:37 -0700
Message-ID: <a7ac630a985c28ae5936a11e6e229a228ecc052a.1718995160.git.osandov@fb.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718995160.git.osandov@fb.com>
References: <cover.1718995160.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

Now that we've documented the current nonsensical behavior, add a couple
of options that actually make sense: -O lists all subvolumes below a
path (which is what people think -o does), and -A lists all subvolumes
with no path munging (which is what people think the default or -a do).
-O can even be used by unprivileged users.

-O and -A also renames the "top level" in the default output to what it
actually is now: the "parent".

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 Documentation/btrfs-subvolume.rst             | 17 ++++
 cmds/subvolume-list.c                         | 77 +++++++++++++++----
 .../026-subvolume-list-path-filtering/test.sh | 38 +++++++++
 3 files changed, 117 insertions(+), 15 deletions(-)

diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subvolume.rst
index fe84ab1c..f76c1302 100644
--- a/Documentation/btrfs-subvolume.rst
+++ b/Documentation/btrfs-subvolume.rst
@@ -136,6 +136,9 @@ list [options] [-G [\+|-]<value>] [-C [+|-]<value>] [--sort=rootid,gen,ogen,path
         updated every transaction, *parent_ID* is the same as the parent subvolume's id,
         and *path* is the path of the subvolume. The exact meaning of *path*
         depends on the **Path filtering** option used.
+
+        If -O or -A is given, "top level" is replaced by "parent".
+
         The subvolume's ID may be used by the subvolume set-default command,
         or at mount time via the *subvolid=* option.
 
@@ -143,6 +146,20 @@ list [options] [-G [\+|-]<value>] [-C [+|-]<value>] [--sort=rootid,gen,ogen,path
 
         Path filtering:
 
+        -O
+                Print <path> and all subvolumes below it, recursively. <path>
+                must be a subvolume. Paths are printed relative to <path>.
+
+                This may be used by unprivileged users, in which case this only
+                lists subvolumes that the user has access to.
+        -A
+                Print all subvolumes in the filesystem. Paths are printed
+                relative to the root of the filesystem.
+
+        You likely always want either -O or -A. The -o and -a options and the
+        default if no path filtering options are given have very confusing,
+        accidental behavior that is only kept for backwards compatibility.
+
         -o
                 Print only the immediate children subvolumes of the subvolume
                 containing <path>. Paths are printed relative to the root of
diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index fa5082af..4dde9fbe 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -59,6 +59,13 @@ static const char * const cmd_subvolume_list_usage[] = {
 	"List subvolumes and snapshots in the filesystem.",
 	"",
 	"Path filtering:",
+	OPTLINE("-O", "print all subvolumes below <path> relative to <path>"),
+	OPTLINE("-A", "print all subvolumes in the filesystem relative to the "
+		"root of the filesystem"),
+	"",
+	"You likely always want either -O or -A. The -o and -a options and the",
+	"default are confusing and only kept for backwards compatibility.",
+	"",
 	OPTLINE("-o", "print only the immediate children subvolumes of the "
 		"subvolume containing <path>"),
 	OPTLINE("-a", "print all subvolumes in the filesystem other than the "
@@ -866,9 +873,11 @@ out:
 	return subvols;
 }
 
-static struct subvol_list *btrfs_list_subvols(int fd,
+static struct subvol_list *btrfs_list_subvols(int fd, bool include_top,
+				bool below,
 				struct btrfs_list_filter_set *filter_set)
 {
+	u64 top_id = below ? 0 : BTRFS_FS_TREE_OBJECTID;
 	struct subvol_list *subvols;
 	size_t capacity = 4;
 	struct btrfs_util_subvolume_iterator *iter;
@@ -883,15 +892,28 @@ static struct subvol_list *btrfs_list_subvols(int fd,
 	}
 	subvols->num = 0;
 
-	err = btrfs_util_create_subvolume_iterator_fd(fd,
-						      BTRFS_FS_TREE_OBJECTID, 0,
-						      &iter);
+	err = btrfs_util_create_subvolume_iterator_fd(fd, top_id, 0, &iter);
 	if (err) {
 		iter = NULL;
 		error_btrfs_util(err);
 		goto out;
 	}
 
+	if (include_top) {
+		err = btrfs_util_subvolume_info_fd(fd, top_id,
+						   &subvols->subvols[0].info);
+		if (err) {
+			error_btrfs_util(err);
+			goto out;
+		}
+		subvols->subvols[0].path = strdup("");
+		if (!subvols->subvols[0].path) {
+			error("out of memory");
+			goto out;
+		}
+		subvols->num++;
+	}
+
 	for (;;) {
 		struct root_info subvol;
 
@@ -945,14 +967,15 @@ out:
 
 static int btrfs_list_subvols_print(int fd, struct btrfs_list_filter_set *filter_set,
 		       struct btrfs_list_comparer_set *comp_set,
-		       enum btrfs_list_layout layout)
+		       enum btrfs_list_layout layout, bool include_top,
+		       bool below)
 {
 	struct subvol_list *subvols;
 
 	if (filter_set->only_deleted)
 		subvols = btrfs_list_deleted_subvols(fd, filter_set);
 	else
-		subvols = btrfs_list_subvols(fd, filter_set);
+		subvols = btrfs_list_subvols(fd, include_top, below, filter_set);
 	if (!subvols)
 		return -1;
 
@@ -1097,8 +1120,10 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 	char *top_path = NULL;
 	int ret = -1, uerr = 0;
 	char *subvol;
+	bool is_list_below = false;
 	bool is_list_all = false;
-	bool is_only_in_path = false;
+	bool is_old_a_option = false;
+	bool is_old_o_option = false;
 	enum btrfs_list_layout layout = BTRFS_LIST_LAYOUT_DEFAULT;
 
 	filter_set = btrfs_list_alloc_filter_set();
@@ -1113,7 +1138,7 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 		};
 
 		c = getopt_long(argc, argv,
-				    "acdgopqsurRG:C:t", long_options, NULL);
+				    "acdgopqsurRG:C:tOA", long_options, NULL);
 		if (c < 0)
 			break;
 
@@ -1122,7 +1147,7 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 			btrfs_list_setup_print_column(BTRFS_LIST_PARENT);
 			break;
 		case 'a':
-			is_list_all = true;
+			is_old_a_option = true;
 			break;
 		case 'c':
 			btrfs_list_setup_print_column(BTRFS_LIST_OGENERATION);
@@ -1134,7 +1159,7 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 			btrfs_list_setup_print_column(BTRFS_LIST_GENERATION);
 			break;
 		case 'o':
-			is_only_in_path = true;
+			is_old_o_option = true;
 			break;
 		case 't':
 			layout = BTRFS_LIST_LAYOUT_TABLE;
@@ -1187,6 +1212,12 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 				goto out;
 			}
 			break;
+		case 'O':
+			is_list_below = true;
+			break;
+		case 'A':
+			is_list_all = true;
+			break;
 
 		default:
 			uerr = 1;
@@ -1197,6 +1228,19 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 	if (check_argc_exact(argc - optind, 1))
 		goto out;
 
+	/*
+	 * The path filtering options and -d don't make sense together. For -O
+	 * and -A, we're strict about not combining them with each other or with
+	 * -o, -a, or -d. The -o, -a, and -d options are older and have never
+	 * been restricted, so although they produce dubious results when
+	 * combined, we allow it for backwards compatibility.
+	 */
+	if (is_list_below + is_list_all +
+	    (is_old_a_option || is_old_o_option || filter_set->only_deleted) > 1) {
+		error("-O, -A, -o, -a, and -d are mutually exclusive");
+		goto out;
+	}
+
 	subvol = argv[optind];
 	fd = btrfs_open_dir(subvol);
 	if (fd < 0) {
@@ -1216,15 +1260,15 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 		goto out;
 	}
 
-	if (is_list_all)
+	if (is_old_a_option)
 		btrfs_list_setup_filter(&filter_set,
 					BTRFS_LIST_FILTER_FULL_PATH,
 					top_id);
-	else if (is_only_in_path)
+	else if (is_old_o_option)
 		btrfs_list_setup_filter(&filter_set,
 					BTRFS_LIST_FILTER_TOPID_EQUAL,
 					top_id);
-	else if (!filter_set->only_deleted) {
+	else if (!is_list_below && !is_list_all && !filter_set->only_deleted) {
 		enum btrfs_util_error err;
 
 		err = btrfs_util_subvolume_get_path_fd(fd, top_id, &top_path);
@@ -1241,13 +1285,16 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 	/* by default we shall print the following columns*/
 	btrfs_list_setup_print_column(BTRFS_LIST_OBJECTID);
 	btrfs_list_setup_print_column(BTRFS_LIST_GENERATION);
-	btrfs_list_setup_print_column(BTRFS_LIST_TOP_LEVEL);
+	btrfs_list_setup_print_column(is_list_below || is_list_all ?
+				      BTRFS_LIST_PARENT : BTRFS_LIST_TOP_LEVEL);
 	btrfs_list_setup_print_column(BTRFS_LIST_PATH);
 
 	if (bconf.output_format == CMD_FORMAT_JSON)
 		layout = BTRFS_LIST_LAYOUT_JSON;
 
-	ret = btrfs_list_subvols_print(fd, filter_set, comparer_set, layout);
+	ret = btrfs_list_subvols_print(fd, filter_set, comparer_set, layout,
+				       is_list_below || is_list_all,
+				       is_list_below);
 
 out:
 	free(top_path);
diff --git a/tests/cli-tests/026-subvolume-list-path-filtering/test.sh b/tests/cli-tests/026-subvolume-list-path-filtering/test.sh
index 1b272ddc..a65ba91f 100755
--- a/tests/cli-tests/026-subvolume-list-path-filtering/test.sh
+++ b/tests/cli-tests/026-subvolume-list-path-filtering/test.sh
@@ -114,5 +114,43 @@ EOF
 expect_subvol_list_paths -o a/b/c/d << EOF
 EOF
 
+### -A ###
+
+# Paths are always relative to the root of the filesystem.
+for path in . a/b a/b/c; do
+	expect_subvol_list_paths -A "$path" << EOF
+
+a
+a/b/c
+a/b/c/d
+a/e
+EOF
+done
+
+### -O ###
+
+# Paths are relative to the given path.
+expect_subvol_list_paths -O . << EOF
+
+a
+a/b/c
+a/b/c/d
+a/e
+EOF
+
+expect_subvol_list_paths -O a << EOF
+
+b/c
+b/c/d
+e
+EOF
+
+expect_subvol_list_paths -O a/e << EOF
+
+EOF
+
+run_mustfail "btrfs subvol list -O allowed non-subvolume" \
+	$SUDO_HELPER "$TOP/btrfs" subvolume list -O a/b
+
 cd ..
 run_check_umount_test_dev
-- 
2.45.2


