Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6254B41F145
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355023AbhJAPbS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 11:31:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36826 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355071AbhJAPbG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Oct 2021 11:31:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4724220067;
        Fri,  1 Oct 2021 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633102161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXSjrXQROzFm81HCWWoJihA2Ux0jEUkhlLJ3vAcH/J4=;
        b=NXm9JI7NWt7fsPhhmtlAhFkOefuiQ82T53OSi3YrI0SQbXByyyJuJG3thIKm3g7eDYHSLv
        6m4w5SWPjVxAvMCW7YQeLqwaAwnQivrC+9Q4Br9/XGPxkNlnXBgvv6Yl+IV073wHKHLcxC
        sn9nfHvIRX4Hd8W7Bjk4e3VnroD2k7M=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4109FA3B8B;
        Fri,  1 Oct 2021 15:29:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF529DA7F3; Fri,  1 Oct 2021 17:29:03 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] btrfs-progs: property: ro->rw and received_uuid
Date:   Fri,  1 Oct 2021 17:29:03 +0200
Message-Id: <4c02eb0d00433fa95b77befecafcdf147c230f21.1633101904.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633101904.git.dsterba@suse.com>
References: <cover.1633101904.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Implement safety check when a read-only subvolume is getting switched
to read-write and there's received_uuid set.

This prevents accidental breakage of incremental send usecase but allows
user to do the rw change anyway but resets the received_uuid in that
case.

As this is implemented entirely in userspace, it's racy and using the
raw ioctl won't prevent it nor reset the received_uuid.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 cmds/property.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/cmds/property.c b/cmds/property.c
index 647c3f07afb5..230bef04f6ce 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -22,6 +22,7 @@
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/xattr.h>
+#include <uuid/uuid.h>
 #include <btrfsutil.h>
 #include "cmds/commands.h"
 #include "cmds/props.h"
@@ -40,6 +41,26 @@
 #define ENOATTR ENODATA
 #endif
 
+static int subvolume_clear_received_uuid(const char *path)
+{
+	struct btrfs_ioctl_received_subvol_args args = {};
+	int ret;
+	int fd;
+
+	fd = open(path, O_RDONLY | O_NOATIME);
+	if (fd == -1)
+		return -errno;
+
+	ret = ioctl(fd, BTRFS_IOC_SET_RECEIVED_SUBVOL, &args);
+	if (ret == -1) {
+		close(fd);
+		return -errno;
+	}
+	close(fd);
+
+	return 0;
+}
+
 static int prop_read_only(enum prop_object_type type,
 			  const char *object,
 			  const char *name,
@@ -50,6 +71,10 @@ static int prop_read_only(enum prop_object_type type,
 	bool read_only;
 
 	if (value) {
+		struct btrfs_util_subvolume_info info = {};
+		bool is_ro = false;
+		bool do_clear_received_uuid = false;
+
 		if (!strcmp(value, "true")) {
 			read_only = true;
 		} else if (!strcmp(value, "false")) {
@@ -58,12 +83,44 @@ static int prop_read_only(enum prop_object_type type,
 			error("invalid value for property: %s", value);
 			return -EINVAL;
 		}
+		err = btrfs_util_get_subvolume_read_only(object, &is_ro);
+		if (err) {
+			error_btrfs_util(err);
+			return -errno;
+		}
+		/* No change if already read-only */
+		if (is_ro && read_only)
+			return 0;
+
+		err = btrfs_util_subvolume_info(object, 0, &info);
+		if (err)
+			warning("cannot read subvolume info\n");
+		if (is_ro && !uuid_is_null(info.received_uuid)) {
+			printf("ro->rw switch but has set receive_uuid\n");
+
+			if (force) {
+				do_clear_received_uuid = true;
+			} else {
+				printf("cannot flip ro->rw with received_uuid set, use force\n");
+				return -EPERM;
+			}
+		}
+		if (!is_ro && !uuid_is_null(info.received_uuid))
+			warning("read-write subvolume with received_uuid, this is bad");
 
 		err = btrfs_util_set_subvolume_read_only(object, read_only);
 		if (err) {
 			error_btrfs_util(err);
 			return -errno;
 		}
+		if (do_clear_received_uuid) {
+			int ret;
+
+			printf("force used, clearing received_uuid\n");
+			ret = subvolume_clear_received_uuid(object);
+			if (ret < 0)
+				warning("failed to clear received_uuid: %m");
+		}
 	} else {
 		err = btrfs_util_get_subvolume_read_only(object, &read_only);
 		if (err) {
-- 
2.33.0

