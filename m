Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA910A971
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 05:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfK0EoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 23:44:10 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48372 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfK0EoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 23:44:10 -0500
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
Received: from waya.furryterror.org (waya.vpn7.hungrycats.org [10.132.226.63])
        by james.kirk.hungrycats.org (Postfix) with ESMTP id 6F1EE4F8A79;
        Tue, 26 Nov 2019 23:37:45 -0500 (EST)
Received: from zblaxell by waya.furryterror.org with local (Exim 4.92)
        (envelope-from <zblaxell@waya.furryterror.org>)
        id 1iZp5E-0003PQ-QX; Tue, 26 Nov 2019 23:37:44 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs-progs: inspect: add support for LOGICAL_INO_V2 ioctl
Date:   Tue, 26 Nov 2019 22:55:07 -0500
Message-Id: <20191127035509.15011-5-ce3g8jdj@umail.furryterror.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127035509.15011-1-ce3g8jdj@umail.furryterror.org>
References: <20191127035509.15011-1-ce3g8jdj@umail.furryterror.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Increase the maximum buffer size to SZ_16M.

Add an option (-o) to set the ..._IGNORE_OFFSET flag.

If the buffer size is greater than 64K or the IGNORE_OFFSET option
is used, call ioctl V2; otherwise, use ioctl V1 to be compatible with
older kernels.

Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
---
 cmds/inspect.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 758b6e60..81eb8125 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -126,14 +126,17 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 static DEFINE_SIMPLE_COMMAND(inspect_inode_resolve, "inode-resolve");
 
 static const char * const cmd_inspect_logical_resolve_usage[] = {
-	"btrfs inspect-internal logical-resolve [-Pv] [-s bufsize] <logical> <path>",
+	"btrfs inspect-internal logical-resolve [-Pvo] [-s bufsize] <logical> <path>",
 	"Get file system paths for the given logical address",
 	"",
 	"-P          skip the path resolving and print the inodes instead",
 	"-v          verbose mode",
+	"-o          ignore offsets when matching references (requires v2 ioctl",
+	"            support in the kernel)",
 	"-s bufsize  set inode container's size. This is used to increase inode",
 	"            container's size in case it is not enough to read all the ",
-	"            resolved results. The max value one can set is 64k",
+	"            resolved results. The max value one can set is 64k with the",
+	"            v1 ioctl. Sizes over 64k will use the v2 ioctl.",
 	NULL
 };
 
@@ -152,10 +155,12 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 	char full_path[PATH_MAX];
 	char *path_ptr;
 	DIR *dirstream = NULL;
+	u64 flags = 0;
+	unsigned long request = BTRFS_IOC_LOGICAL_INO;
 
 	optind = 0;
 	while (1) {
-		int c = getopt(argc, argv, "Pvs:");
+		int c = getopt(argc, argv, "Pvos:");
 		if (c < 0)
 			break;
 
@@ -166,6 +171,9 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 		case 'v':
 			verbose = 1;
 			break;
+		case 'o':
+			flags |= BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET;
+			break;
 		case 's':
 			size = arg_strtou64(optarg);
 			break;
@@ -177,14 +185,18 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 	if (check_argc_exact(argc - optind, 2))
 		return 1;
 
-	size = min(size, (u64)SZ_64K);
+	size = min(size, (u64)SZ_16M);
 	inodes = malloc(size);
 	if (!inodes)
 		return 1;
 
+	if (size > SZ_64K || flags != 0)
+		request = BTRFS_IOC_LOGICAL_INO_V2;
+
 	memset(inodes, 0, sizeof(*inodes));
 	loi.logical = arg_strtou64(argv[optind]);
 	loi.size = size;
+	loi.flags = flags;
 	loi.inodes = ptr_to_u64(inodes);
 
 	fd = btrfs_open_dir(argv[optind + 1], &dirstream, 1);
@@ -193,7 +205,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 		goto out;
 	}
 
-	ret = ioctl(fd, BTRFS_IOC_LOGICAL_INO, &loi);
+	ret = ioctl(fd, request, &loi);
 	if (ret < 0) {
 		error("logical ino ioctl: %m");
 		goto out;
-- 
2.20.1

