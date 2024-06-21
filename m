Return-Path: <linux-btrfs+bounces-5894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3109912D97
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 20:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 211ECB263CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF4417B42D;
	Fri, 21 Jun 2024 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="R1oSeza9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C117B509
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996039; cv=none; b=YvrtUarThSAkwYWn8G6B8OzXsoduJmWyNp6k7barYiOfGVIy5KUM4XAsIipwNKFFtqNBALvtcL7rT4dxqDuMsLwmVVWDc8FcSFlxIrivVMXR/uKCi7fhnOJVGuaE0WxXwe40T4wEOW5QTsrxoow7MasH/TwRWRObjrQYkD1FXqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996039; c=relaxed/simple;
	bh=cp+DFvAt9LG/T1PC3XvpGa1B6RLte7lU49nIv45c0wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gE5kV4VBylXjoI9QdWKEgJawXMmTRGRPt2up5vzrcN671u6/oPnd7ZEBvsDKkj5gTKirydrzLqm1+ztMIywXv2zyARUph3R4vpKBEpCID3NZ296imiVzN1YMOHLpsRyFjm9OaVpeINZafmNC/T+KclkJBWueMP7W7daBi1hkQfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=R1oSeza9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-70df2135426so1569767a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1718996037; x=1719600837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH37T+Xm8DXncxxgiUVB2dta1PR92NXfnOWctIuX5zc=;
        b=R1oSeza90d2WBoeLcDXfPEp2kkDyeYCMKpXK70a6FGN/DnmYikP0uatADf739mol+y
         8V2wySGq7Du7DjnrInlNcDFt5GkL+IfhQ8SiZt+LOt1afslkrE0Geoc5nG7IP6KdZ/XI
         dPitynLShVJWKoKFq9SHbixcZQhcvr6zQZs/I7g0CR42PPribcmYHCdiyIH48IvLSiS8
         b13WZa3zFk6VIatjdXTryJmuGh00sZStNmPMb896oZJHAkqpn4p9VEhvwla8YqUV1vUH
         kNF0Csc8WuV8wEqVm16NMiJyppuFp/EUttmDG/niGomATfS5Lh/Xdmfq0luYMHD0DTeY
         6cGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718996037; x=1719600837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH37T+Xm8DXncxxgiUVB2dta1PR92NXfnOWctIuX5zc=;
        b=iZKB+OuC8iX8nK50K8Eggepia4EFeugJPVVs+nJLfGaMcORqOLcmT6fQnXLhBpMJXf
         8eIhEMFYBCeiVnLWsaQprkYlY2v+cFiIOcg/fAklACGXJl79ZlZwctyq2AamQZftU0X0
         Qezzza+tJXa5q8CFyNFMWwJeuCod6Xdwm/i2PF38EMJIEKmBWLL9U1MUVCBg59SLjNei
         m8joDJqhXKz8t1g9oOgCIWvaRfuaYqkSZGlzgXG0t2D4tCCU7l8eY5PtQxGYgq8Vdy4A
         DzBSl14xK5NnfV+gM3Q1bsTDBlA5L+zI0BV6FWn7nta9SDjpkVEQkCQb6M9/b/+PHSZm
         ycYA==
X-Gm-Message-State: AOJu0YwACgiiQWgX7NKLeNxsEILN7OigWALcUvcjKJaxuMuLlAWb4m//
	qSbJdFdHVpW7CFR8adFaBvefTNu8/0hQQeOBFMpOlneAGxIHYKI5v9VKxVsvDs88aK7+FkWEddR
	d
X-Google-Smtp-Source: AGHT+IGuo7L6RB78V7pjUZyBf6RVmd33PCt5AIxp4LyD1AA5yE1vJqA07JB3nM0S92xx5hF7nnnQ1A==
X-Received: by 2002:a05:6a20:6da9:b0:1b8:593e:ff1e with SMTP id adf61e73a8af0-1bcbb5cd3e1mr8138657637.34.1718996036749;
        Fri, 21 Jun 2024 11:53:56 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::6:1ec7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e06e7sm3957366a91.21.2024.06.21.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:53:56 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 6/8] btrfs-progs: subvol list: document and test actual behavior of paths
Date: Fri, 21 Jun 2024 11:53:35 -0700
Message-ID: <c015f1943def5e892b0aac540d1ce5a3d143ed6b.1718995160.git.osandov@fb.com>
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

The way btrfs subvol list prints paths and what the -o and -a flags do
are all nonsense.

Apparently, very early versions of Btrfs had a concept of a "top level"
of subvolumes rather than the root filesystem tree that we have today;
see commit 4ff9e2af1721 ("Add btrfs-list for listing subvolumes"). The
original subvol list code tracked the ID of that top level subvolume.
Eventually, 5 became the only possibility for the top level, and -o, -a,
and path printing were based on that. Commit 4f5ebb3ef553 ("Btrfs-progs:
fix to make list specified directory's subvolumes work") broke this and
changed the top level to be the same as the parent subvolume ID, which
gave us the illogical behavior we have today.

It has been this way for a decade, so we're probably stuck with it. But
let's at least document precisely what these all do in preparation for
adding sensible options. Let's also add tests in preparation for the
upcoming changes.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 Documentation/btrfs-subvolume.rst             |  20 ++-
 cmds/subvolume-list.c                         |  13 +-
 .../026-subvolume-list-path-filtering/test.sh | 118 ++++++++++++++++++
 3 files changed, 143 insertions(+), 8 deletions(-)
 create mode 100755 tests/cli-tests/026-subvolume-list-path-filtering/test.sh

diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subvolume.rst
index d1e89f15..fe84ab1c 100644
--- a/Documentation/btrfs-subvolume.rst
+++ b/Documentation/btrfs-subvolume.rst
@@ -134,7 +134,8 @@ list [options] [-G [\+|-]<value>] [-C [+|-]<value>] [--sort=rootid,gen,ogen,path
 
         where *ID* is subvolume's (root)id, *generation* is an internal counter which is
         updated every transaction, *parent_ID* is the same as the parent subvolume's id,
-        and *path* is the relative path of the subvolume to the top level subvolume.
+        and *path* is the path of the subvolume. The exact meaning of *path*
+        depends on the **Path filtering** option used.
         The subvolume's ID may be used by the subvolume set-default command,
         or at mount time via the *subvolid=* option.
 
@@ -143,11 +144,20 @@ list [options] [-G [\+|-]<value>] [-C [+|-]<value>] [--sort=rootid,gen,ogen,path
         Path filtering:
 
         -o
-                Print only subvolumes below specified <path>. Note that this is not a
-                recursive command, and won't show nested subvolumes under <path>.
+                Print only the immediate children subvolumes of the subvolume
+                containing <path>. Paths are printed relative to the root of
+                the filesystem.
         -a
-                print all the subvolumes in the filesystem and distinguish between
-                absolute and relative path with respect to the given *path*.
+                Print all subvolumes in the filesystem other than the root
+                subvolume. Paths are printed relative to the root of the
+                filesystem, except that subvolumes that are not an immediate
+                child of the subvolume containing <path> are prefixed with
+                "<FS_TREE>/".
+
+        If none of these are given, print all subvolumes in the filesystem
+        other than the root subvolume. Paths below the subvolume containing
+        <path> are printed relative to that subvolume, and other paths are
+        printed relative to the root of the filesystem.
 
         Field selection:
 
diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index cfe165f9..3b32a5ff 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -57,9 +57,16 @@ static const char * const cmd_subvolume_list_usage[] = {
 	"List subvolumes and snapshots in the filesystem.",
 	"",
 	"Path filtering:",
-	OPTLINE("-o", "print only subvolumes below specified path"),
-	OPTLINE("-a", "print all the subvolumes in the filesystem and "
-		"distinguish absolute and relative path with respect to the given <path>"),
+	OPTLINE("-o", "print only the immediate children subvolumes of the "
+		"subvolume containing <path>"),
+	OPTLINE("-a", "print all subvolumes in the filesystem other than the "
+		"root subvolume, and prefix subvolumes that are not an "
+		"immediate child of the subvolume containing <path> with "
+		"\"<FS_TREE>/\""),
+	"",
+	"If none of these are given, print all subvolumes other than the root",
+	"subvolume relative to the subvolume containing <path> if below it,",
+	"otherwise relative to the root of the filesystem.",
 	"",
 	"Field selection:",
 	OPTLINE("-p", "print parent ID"),
diff --git a/tests/cli-tests/026-subvolume-list-path-filtering/test.sh b/tests/cli-tests/026-subvolume-list-path-filtering/test.sh
new file mode 100755
index 00000000..1b272ddc
--- /dev/null
+++ b/tests/cli-tests/026-subvolume-list-path-filtering/test.sh
@@ -0,0 +1,118 @@
+#!/bin/bash
+# Test how btrfs subvolume list prints paths, including all of the weird
+# accidental behavior.
+
+source "$TEST_TOP/common" || exit
+
+check_prereq btrfs
+check_prereq mkfs.btrfs
+
+setup_root_helper
+prepare_test_dev
+
+run_check_mkfs_test_dev
+run_check_mount_test_dev
+
+cd "$TEST_MNT"
+
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "a"
+run_check $SUDO_HELPER mkdir "a/b"
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "a/b/c"
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "a/b/c/d"
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "a/e"
+
+subvol_list_paths() {
+	run_check_stdout $SUDO_HELPER "$TOP/btrfs" subvolume list "$@" | sed 's/.*path //'
+}
+
+expect_subvol_list_paths() {
+	diff -u - <(subvol_list_paths "$@") || _fail "wrong output from btrfs subvolume list $*"
+}
+
+### No options ###
+
+# Paths are relative to the given subvolume if they are beneath it and relative
+# to the root of the filesystem otherwise.
+expect_subvol_list_paths . << EOF
+a
+a/b/c
+a/b/c/d
+a/e
+EOF
+
+expect_subvol_list_paths a << EOF
+a
+b/c
+b/c/d
+e
+EOF
+
+expect_subvol_list_paths a/b/c << EOF
+a
+a/b/c
+d
+a/e
+EOF
+
+# If passed a directory, it's treated as the containing subvolume.
+expect_subvol_list_paths a/b << EOF
+a
+b/c
+b/c/d
+e
+EOF
+
+### -a ###
+
+# Paths are relative to the root of the filesystem. Subvolumes that are not an
+# immediate child of the passed subvolume are prefixed with <FS_TREE>/.
+expect_subvol_list_paths -a . << EOF
+a
+<FS_TREE>/a/b/c
+<FS_TREE>/a/b/c/d
+<FS_TREE>/a/e
+EOF
+
+expect_subvol_list_paths -a a << EOF
+<FS_TREE>/a
+a/b/c
+<FS_TREE>/a/b/c/d
+a/e
+EOF
+
+# If passed a directory, it's treated as the containing subvolume.
+expect_subvol_list_paths -a a/b << EOF
+<FS_TREE>/a
+a/b/c
+<FS_TREE>/a/b/c/d
+a/e
+EOF
+
+### -o ###
+
+# Only immediate children of the passed subvolume are printed, and they are
+# printed relative to the root of the filesystem.
+expect_subvol_list_paths -o . << EOF
+a
+EOF
+
+expect_subvol_list_paths -o a << EOF
+a/b/c
+a/e
+EOF
+
+# If passed a directory, it's treated as the containing subvolume.
+expect_subvol_list_paths -o a/b << EOF
+a/b/c
+a/e
+EOF
+
+expect_subvol_list_paths -o a/b/c << EOF
+a/b/c/d
+EOF
+
+expect_subvol_list_paths -o a/b/c/d << EOF
+EOF
+
+cd ..
+run_check_umount_test_dev
-- 
2.45.2


