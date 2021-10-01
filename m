Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD941F143
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 17:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355049AbhJAPbP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 11:31:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59142 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355044AbhJAPbF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Oct 2021 11:31:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 21A6422657;
        Fri,  1 Oct 2021 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633102159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3t9lC0QceZjSZIa5CGJ5xMk+R0MPPG8i/Zhw7qevX6M=;
        b=lp5juBvnsDA6uCOP/3uqhTC0KBgTyZU5aNL3QkPxlxU1oRsRBewf4L9vKeWVMQVqN9QE9D
        /IIXKmVbNXUhrDbCLNQivBt8EGoqTPqYqyhvOXinXlPd1ZapSV95N8REKU5C3BV1D79/No
        iUutkGyCG8D/BNWyO7EpZFx+2zl2TeA=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1AC2FA3B8C;
        Fri,  1 Oct 2021 15:29:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9EF67DA7F3; Fri,  1 Oct 2021 17:29:01 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs-progs: props: add force parameter to set
Date:   Fri,  1 Oct 2021 17:29:01 +0200
Message-Id: <e4d1d9fda9e4c70ba251f4ac869f3f24453a9ced.1633101904.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633101904.git.dsterba@suse.com>
References: <cover.1633101904.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add option support to force the value change. This allows to do safety
checks by default and warn user that something might break. Using the
force will override that and changing the property should do change
itself and additionally any other changes that could break some
usecases.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 cmds/property.c | 42 ++++++++++++++++++++++++++++--------------
 cmds/props.h    |  3 ++-
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/cmds/property.c b/cmds/property.c
index 0971aee06a3f..647c3f07afb5 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -43,7 +43,8 @@
 static int prop_read_only(enum prop_object_type type,
 			  const char *object,
 			  const char *name,
-			  const char *value)
+			  const char *value,
+			  bool force)
 {
 	enum btrfs_util_error err;
 	bool read_only;
@@ -79,7 +80,8 @@ static int prop_read_only(enum prop_object_type type,
 static int prop_label(enum prop_object_type type,
 		      const char *object,
 		      const char *name,
-		      const char *value)
+		      const char *value,
+		      bool force)
 {
 	int ret;
 
@@ -99,7 +101,8 @@ static int prop_label(enum prop_object_type type,
 static int prop_compression(enum prop_object_type type,
 			    const char *object,
 			    const char *name,
-			    const char *value)
+			    const char *value,
+			    bool force)
 {
 	int ret;
 	ssize_t sret;
@@ -347,7 +350,7 @@ static int dump_prop(const struct prop_handler *prop,
 
 	if ((types & type) && (prop->types & type)) {
 		if (!name_and_help)
-			ret = prop->handler(type, object, prop->name, NULL);
+			ret = prop->handler(type, object, prop->name, NULL, false);
 		else
 			printf("%-20s%s\n", prop->name, prop->desc);
 	}
@@ -379,7 +382,7 @@ static int dump_props(int types, const char *object, int name_and_help)
 }
 
 static int setget_prop(int types, const char *object,
-		       const char *name, const char *value)
+		       const char *name, const char *value, bool force)
 {
 	int ret;
 	const struct prop_handler *prop = NULL;
@@ -407,7 +410,7 @@ static int setget_prop(int types, const char *object,
 		return 1;
 	}
 
-	ret = prop->handler(types, object, name, value);
+	ret = prop->handler(types, object, name, value, force);
 
 	if (ret < 0)
 		ret = 1;
@@ -420,19 +423,26 @@ static int setget_prop(int types, const char *object,
 
 static int parse_args(const struct cmd_struct *cmd, int argc, char **argv,
 		       int *types, char **object,
-		       char **name, char **value, int min_nonopt_args)
+		       char **name, char **value, int min_nonopt_args,
+		       bool *force)
 {
 	int ret;
 	char *type_str = NULL;
 	int max_nonopt_args = 1;
 
+	*force = false;
+
 	optind = 1;
 	while (1) {
-		int c = getopt(argc, argv, "t:");
+		int c = getopt(argc, argv, "ft:");
 		if (c < 0)
 			break;
 
 		switch (c) {
+		case 'f':
+			/* TODO: do not accept for get/list */
+			*force = true;
+			break;
 		case 't':
 			type_str = optarg;
 			break;
@@ -516,12 +526,13 @@ static int cmd_property_get(const struct cmd_struct *cmd,
 	char *object = NULL;
 	char *name = NULL;
 	int types = 0;
+	bool force;
 
-	if (parse_args(cmd, argc, argv, &types, &object, &name, NULL, 1))
+	if (parse_args(cmd, argc, argv, &types, &object, &name, NULL, 1, &force))
 		return 1;
 
 	if (name)
-		ret = setget_prop(types, object, name, NULL);
+		ret = setget_prop(types, object, name, NULL, force);
 	else
 		ret = dump_props(types, object, 0);
 
@@ -530,13 +541,14 @@ static int cmd_property_get(const struct cmd_struct *cmd,
 static DEFINE_SIMPLE_COMMAND(property_get, "get");
 
 static const char * const cmd_property_set_usage[] = {
-	"btrfs property set [-t <type>] <object> <name> <value>",
+	"btrfs property set [-f] [-t <type>] <object> <name> <value>",
 	"Set a property on a btrfs object",
 	"Set a property on a btrfs object where object is a path to file or",
 	"directory and can also represent the filesystem or device based on the type",
 	"",
 	"-t <TYPE>       list properties for the given object type (inode, subvol,",
 	"                filesystem, device)",
+	"-f              force the change, could potentially break something\n",
 	NULL
 };
 
@@ -548,11 +560,12 @@ static int cmd_property_set(const struct cmd_struct *cmd,
 	char *name = NULL;
 	char *value = NULL;
 	int types = 0;
+	bool force = false;
 
-	if (parse_args(cmd, argc, argv, &types, &object, &name, &value, 3))
+	if (parse_args(cmd, argc, argv, &types, &object, &name, &value, 3, &force))
 		return 1;
 
-	ret = setget_prop(types, object, name, value);
+	ret = setget_prop(types, object, name, value, force);
 
 	return ret;
 }
@@ -576,8 +589,9 @@ static int cmd_property_list(const struct cmd_struct *cmd,
 	int ret;
 	char *object = NULL;
 	int types = 0;
+	bool force;
 
-	if (parse_args(cmd, argc, argv, &types, &object, NULL, NULL, 1))
+	if (parse_args(cmd, argc, argv, &types, &object, NULL, NULL, 1, &force))
 		return 1;
 
 	ret = dump_props(types, object, 1);
diff --git a/cmds/props.h b/cmds/props.h
index a43cb2537f37..0f786b1866ee 100644
--- a/cmds/props.h
+++ b/cmds/props.h
@@ -28,7 +28,8 @@ enum prop_object_type {
 typedef int (*prop_handler_t)(enum prop_object_type type,
 			      const char *object,
 			      const char *name,
-			      const char *value);
+			      const char *value,
+			      bool force);
 
 struct prop_handler {
 	const char *name;
-- 
2.33.0

