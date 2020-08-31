Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F64D257F00
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 18:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgHaQre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 12:47:34 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39973 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726946AbgHaQrb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 12:47:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0ECB9E46;
        Mon, 31 Aug 2020 12:47:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 31 Aug 2020 12:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=KzZZDTTPxLVeHnC+Kft6iAvdGA
        ypqhxp8uK99LnjcnI=; b=Yu/G5+zZQ/fihPDL3N2KX91yMKBL80OLDCLRMRc+6h
        SgqJWEo1q0rY/J75AAx9TRlFPgGzmez1ZGIdBq03ilb2iL3kVu1qmdz5MgtQ8/jT
        H+PJWT70ARAmv7bToymUgSwp2qK5DhVy87bceY/rFFkgWBfaBVxJfqZjjOBU0mVz
        E/xJCJ1j6kLjr0N2NqXFIhSVK7CFaapbxNLguTYYuy4L8S4r0Fe6qww4Yo+NjnJh
        8FqjSJmUFb/dDEQj66Ujh2nRfJ/gOWnhOycHQp65BRAlcoRH6j3qV6oXMpN6tsJe
        eBQ78l6J8Pciq9ZqL+j+90exxDWjmLijlEXTfwGS7oNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KzZZDTTPxLVeHnC+K
        ft6iAvdGAypqhxp8uK99LnjcnI=; b=BjU4+OKZ0c0KgbTPinL7KLrB5KbzrokSP
        1jV388z0WQTmjI9rQMCoXsM22ZXfIdrqlavgNizOGdG+0Ppo2SSAWRLdIJXNok8b
        M0Bn3Muy1K51d+ptgHNT1Jh8ulwMBZLReUfkR8lEu1tprM9i6fZ61HQGzyr7dAOU
        rrfbeS7l2jPehw6uM4nLdySM+MwuCq5KSIdCk2aTcpzb4qRqy/gnrvKMklQN2GCR
        m2GFRW8cpYslnWG8cpr8I+ES4F3lcCFuhnJyp/ArDS+4QdMnAkw/idT34LfU5bQ7
        sJ5WGNFmMHLpYzHd2vlbeeZYproC0WGP2SBQvamTvKty7UCLK00QQ==
X-ME-Sender: <xms:oSlNX2kEQ5t1hrDQIIHjVjqQUWdzA_zSMx4W5nrc_rb4hERlj8_rXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefhedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduie
    dtleeuieejfeelffevleeifefgjeejieegkeduudetfeekffeftefhvdejveenucfkphep
    udeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:oSlNX91SQbgwHxW5oDzvGiT1E_o5XMBiEQA9B-ObX9zHJu4OQGIS2Q>
    <xmx:oSlNX0ouXyUGUfl4x2_QY0uXzPf_TCgwyMU3kLIlU0-RmGUW9T5GYA>
    <xmx:oSlNX6mdOIrHKdZqsCdOuSMrRzmyU56qostuyYqhSEmFy3G7X3CufA>
    <xmx:oSlNXxz4kMbB-zjVJWSWr8Zqn1GJVT6rVLsf31AF2ITH9igJUFPLqA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id E27E23280060;
        Mon, 31 Aug 2020 12:47:26 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Boris Burkov <boris@bur.io>
Subject: [PATCH] btrfs-progs: add async option to btrfs property set
Date:   Mon, 31 Aug 2020 09:47:13 -0700
Message-Id: <7bef0f743bf7321000d2dbc1b6a4c8f71b78c98b.1598652426.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When setting read-only, we want to avoid unnecessary sync-ing. However,
users may have come to rely on the implicit sync, so keep it in user
space while removing it from the kernel. For those who don't want the
likely unnecessary sync, add '-a' for async to skip the sync.

Since property is a fairly generic command, it is a little tricky to
properly apply -a in all cases. Options as far as I can see it are:
- fail on everything but ro set
- accept but ignore on everything but ro set
- accept and implement for all sets, fail/ignore on get

I opted for the first, least accepting option, though that may be
annoying.

Implementing for other sets is not straightforward, as the underlying
kernel interface may implicitly sync. For example, setting the label
does a transaction commit.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/property.c          | 37 +++++++++++++++++++++++++------------
 libbtrfsutil/btrfsutil.h |  7 +++++--
 libbtrfsutil/subvolume.c | 11 ++++++++---
 props.c                  | 22 ++++++++++++++++++----
 props.h                  |  5 ++++-
 5 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/cmds/property.c b/cmds/property.c
index 62cadf71..c5f930dd 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -29,7 +29,7 @@
 #include "common/help.h"
 
 static const char * const property_cmd_group_usage[] = {
-	"btrfs property get/set/list [-t <type>] <object> [<name>] [value]",
+	"btrfs property get/set/list [-t <type>] [-a] <object> [<name>] [value]",
 	NULL
 };
 
@@ -182,7 +182,7 @@ static int dump_prop(const struct prop_handler *prop,
 
 	if ((types & type) && (prop->types & type)) {
 		if (!name_and_help)
-			ret = prop->handler(type, object, prop->name, NULL);
+			ret = prop->handler(type, object, prop->name, NULL, true);
 		else
 			printf("%-20s%s\n", prop->name, prop->desc);
 	}
@@ -214,7 +214,7 @@ out:
 }
 
 static int setget_prop(int types, const char *object,
-		       const char *name, const char *value)
+		       const char *name, const char *value, bool sync)
 {
 	int ret;
 	const struct prop_handler *prop = NULL;
@@ -242,7 +242,7 @@ static int setget_prop(int types, const char *object,
 		return 1;
 	}
 
-	ret = prop->handler(types, object, name, value);
+	ret = prop->handler(types, object, name, value, sync);
 
 	if (ret < 0)
 		ret = 1;
@@ -255,15 +255,18 @@ static int setget_prop(int types, const char *object,
 
 static int parse_args(const struct cmd_struct *cmd, int argc, char **argv,
 		       int *types, char **object,
-		       char **name, char **value, int min_nonopt_args)
+		       char **name, char **value,
+		       bool *sync, int min_nonopt_args)
 {
 	int ret;
 	char *type_str = NULL;
 	int max_nonopt_args = 1;
 
+	if (sync)
+		*sync = true;
 	optind = 1;
 	while (1) {
-		int c = getopt(argc, argv, "t:");
+		int c = getopt(argc, argv, "t:a");
 		if (c < 0)
 			break;
 
@@ -271,6 +274,14 @@ static int parse_args(const struct cmd_struct *cmd, int argc, char **argv,
 		case 't':
 			type_str = optarg;
 			break;
+		case 'a':
+			if (!sync) {
+				errno = -EINVAL;
+				error("async not supported for command");
+				return 1;
+			}
+			*sync = false;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -352,11 +363,11 @@ static int cmd_property_get(const struct cmd_struct *cmd,
 	char *name = NULL;
 	int types = 0;
 
-	if (parse_args(cmd, argc, argv, &types, &object, &name, NULL, 1))
+	if (parse_args(cmd, argc, argv, &types, &object, &name, NULL, NULL, 1))
 		return 1;
 
 	if (name)
-		ret = setget_prop(types, object, name, NULL);
+		ret = setget_prop(types, object, name, NULL, false);
 	else
 		ret = dump_props(types, object, 0);
 
@@ -365,13 +376,14 @@ static int cmd_property_get(const struct cmd_struct *cmd,
 static DEFINE_SIMPLE_COMMAND(property_get, "get");
 
 static const char * const cmd_property_set_usage[] = {
-	"btrfs property set [-t <type>] <object> <name> <value>",
+	"btrfs property set [-t <type>] [-a] <object> <name> <value>",
 	"Set a property on a btrfs object",
 	"Set a property on a btrfs object where object is a path to file or",
 	"directory and can also represent the filesystem or device based on the type",
 	"",
 	"-t <TYPE>       list properties for the given object type (inode, subvol,",
 	"                filesystem, device)",
+	"-a              async: skip sync after setting the property",
 	NULL
 };
 
@@ -383,11 +395,12 @@ static int cmd_property_set(const struct cmd_struct *cmd,
 	char *name = NULL;
 	char *value = NULL;
 	int types = 0;
+	bool sync;
 
-	if (parse_args(cmd, argc, argv, &types, &object, &name, &value, 3))
+	if (parse_args(cmd, argc, argv, &types, &object, &name, &value, &sync, 3))
 		return 1;
 
-	ret = setget_prop(types, object, name, value);
+	ret = setget_prop(types, object, name, value, sync);
 
 	return ret;
 }
@@ -412,7 +425,7 @@ static int cmd_property_list(const struct cmd_struct *cmd,
 	char *object = NULL;
 	int types = 0;
 
-	if (parse_args(cmd, argc, argv, &types, &object, NULL, NULL, 1))
+	if (parse_args(cmd, argc, argv, &types, &object, NULL, NULL, NULL, 1))
 		return 1;
 
 	ret = dump_props(types, object, 1);
diff --git a/libbtrfsutil/btrfsutil.h b/libbtrfsutil/btrfsutil.h
index b7894e14..cb07c48e 100644
--- a/libbtrfsutil/btrfsutil.h
+++ b/libbtrfsutil/btrfsutil.h
@@ -304,20 +304,23 @@ enum btrfs_util_error btrfs_util_get_subvolume_read_only_fd(int fd, bool *ret);
  * btrfs_util_set_subvolume_read_only() - Set whether a subvolume is read-only.
  * @path: Subvolume path.
  * @read_only: New value of read-only flag.
+ * @sync: Whether or not to block on sync-ing the subvolume after.
  *
  * This requires appropriate privilege (CAP_SYS_ADMIN).
  *
  * Return: %BTRFS_UTIL_OK on success, non-zero error code on failure.
  */
 enum btrfs_util_error btrfs_util_set_subvolume_read_only(const char *path,
-							 bool read_only);
+							 bool read_only,
+							 bool sync);
 
 /**
  * btrfs_util_set_subvolume_read_only_fd() - See
  * btrfs_util_set_subvolume_read_only().
  */
 enum btrfs_util_error btrfs_util_set_subvolume_read_only_fd(int fd,
-							    bool read_only);
+							    bool read_only,
+							    bool sync);
 
 /**
  * btrfs_util_get_default_subvolume() - Get the default subvolume for a
diff --git a/libbtrfsutil/subvolume.c b/libbtrfsutil/subvolume.c
index 204a837b..44647276 100644
--- a/libbtrfsutil/subvolume.c
+++ b/libbtrfsutil/subvolume.c
@@ -482,7 +482,8 @@ PUBLIC enum btrfs_util_error btrfs_util_get_subvolume_read_only(const char *path
 }
 
 PUBLIC enum btrfs_util_error btrfs_util_set_subvolume_read_only(const char *path,
-								bool read_only)
+								bool read_only,
+								bool sync)
 {
 	enum btrfs_util_error err;
 	int fd;
@@ -491,13 +492,14 @@ PUBLIC enum btrfs_util_error btrfs_util_set_subvolume_read_only(const char *path
 	if (fd == -1)
 		return BTRFS_UTIL_ERROR_OPEN_FAILED;
 
-	err = btrfs_util_set_subvolume_read_only_fd(fd, read_only);
+	err = btrfs_util_set_subvolume_read_only_fd(fd, read_only, sync);
 	SAVE_ERRNO_AND_CLOSE(fd);
 	return err;
 }
 
 PUBLIC enum btrfs_util_error btrfs_util_set_subvolume_read_only_fd(int fd,
-								   bool read_only)
+								   bool read_only,
+								   bool sync)
 {
 	uint64_t flags;
 	int ret;
@@ -515,6 +517,9 @@ PUBLIC enum btrfs_util_error btrfs_util_set_subvolume_read_only_fd(int fd,
 	if (ret == -1)
 		return BTRFS_UTIL_ERROR_SUBVOL_SETFLAGS_FAILED;
 
+	if (sync)
+		return btrfs_util_sync_fd(fd);
+
 	return BTRFS_UTIL_OK;
 }
 
diff --git a/props.c b/props.c
index 0cfc358d..0313f22b 100644
--- a/props.c
+++ b/props.c
@@ -41,7 +41,8 @@
 static int prop_read_only(enum prop_object_type type,
 			  const char *object,
 			  const char *name,
-			  const char *value)
+			  const char *value,
+			  bool sync)
 {
 	enum btrfs_util_error err;
 	bool read_only;
@@ -56,7 +57,7 @@ static int prop_read_only(enum prop_object_type type,
 			return -EINVAL;
 		}
 
-		err = btrfs_util_set_subvolume_read_only(object, read_only);
+		err = btrfs_util_set_subvolume_read_only(object, read_only, sync);
 		if (err) {
 			error_btrfs_util(err);
 			return -errno;
@@ -77,10 +78,16 @@ static int prop_read_only(enum prop_object_type type,
 static int prop_label(enum prop_object_type type,
 		      const char *object,
 		      const char *name,
-		      const char *value)
+		      const char *value,
+		      bool sync)
 {
 	int ret;
 
+	if (!sync) {
+		error("async not supported for label");
+		return -EINVAL;
+	}
+
 	if (value) {
 		ret = set_label((char *) object, (char *) value);
 	} else {
@@ -97,7 +104,8 @@ static int prop_label(enum prop_object_type type,
 static int prop_compression(enum prop_object_type type,
 			    const char *object,
 			    const char *name,
-			    const char *value)
+			    const char *value,
+			    bool sync)
 {
 	int ret;
 	ssize_t sret;
@@ -107,6 +115,12 @@ static int prop_compression(enum prop_object_type type,
 	char *xattr_name = NULL;
 	int open_flags = value ? O_RDWR : O_RDONLY;
 
+	if (!sync) {
+		ret = -EINVAL;
+		error("async not supported for compression");
+		goto out;
+	}
+
 	fd = open_file_or_dir3(object, &dirstream, open_flags);
 	if (fd == -1) {
 		ret = -errno;
diff --git a/props.h b/props.h
index a43cb253..970185f0 100644
--- a/props.h
+++ b/props.h
@@ -17,6 +17,8 @@
 #ifndef __BTRFS_PROPS_H__
 #define __BTRFS_PROPS_H__
 
+#include <stdbool.h>
+
 enum prop_object_type {
 	prop_object_dev		= (1 << 0),
 	prop_object_root	= (1 << 1),
@@ -28,7 +30,8 @@ enum prop_object_type {
 typedef int (*prop_handler_t)(enum prop_object_type type,
 			      const char *object,
 			      const char *name,
-			      const char *value);
+			      const char *value,
+			      bool sync);
 
 struct prop_handler {
 	const char *name;
-- 
2.24.1

