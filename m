Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3826F4FE1
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 08:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjECGEO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 02:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjECGEN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 02:04:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A115E3A84
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 23:04:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 482231FFD5
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683093849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0RbmoQh3Q2naP6gkgtB1Qm8qhoe+Akt1dkMUtChVXc=;
        b=d1qDEhD7m+WiHP/6ewFTQ/PjOlfKf2YYibNLz8GUb/qCV5EW7E0VhY4B0TnGYKMw0prL2D
        2qOldoDDACI8L9Ok4bUqKDMCtmARpdyjr3Pf3rzhE3KWbvwMgWKdaFkg0WHCYEvKsWfK32
        6kaF0V9EB7BjuS0wE2zTfdlckuduovA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E5B513584
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sFMPFVj5UWSTJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 06:04:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/7] btrfs-progs: fix -Wmissing-prototypes warnings
Date:   Wed,  3 May 2023 14:03:42 +0800
Message-Id: <d960c49a66281914913013faaa6e47339675c2d7.1683093416.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1683093416.git.wqu@suse.com>
References: <cover.1683093416.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The fixes involve the following changes:

- Unexport functions which are not utilized out of the file
  * print_path_column()
  * parse_reflink_range()
  * btrfs_list_setup_print_column()
  * device_get_partition_size_sysfs()
  * max_zone_append_size()

- Include related headers before implementing the function
  * change-uuid.c
  * convert-bgt.c
  * seed.h

- Add missing headers caused by the above header changes
  * include <uuid/uuid.h> for tune/tune.h.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/qgroup.c         | 2 +-
 cmds/reflink.c        | 2 +-
 cmds/subvolume-list.c | 2 +-
 common/device-utils.c | 2 +-
 common/utils.c        | 2 +-
 kernel-shared/ulist.c | 2 +-
 kernel-shared/zoned.c | 2 +-
 tune/change-csum.c    | 1 +
 tune/change-uuid.c    | 1 +
 tune/convert-bgt.c    | 1 +
 tune/seeding.c        | 1 +
 tune/tune.h           | 2 ++
 12 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 49014d5702ec..70a749aa4062 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -289,7 +289,7 @@ static void print_qgroup_column_add_blank(enum btrfs_qgroup_column_enum column,
 		printf(" ");
 }
 
-void print_path_column(struct btrfs_qgroup *qgroup)
+static void print_path_column(struct btrfs_qgroup *qgroup)
 {
 	struct btrfs_qgroup_list *list = NULL;
 
diff --git a/cmds/reflink.c b/cmds/reflink.c
index 24e562a744ff..14201349fc9f 100644
--- a/cmds/reflink.c
+++ b/cmds/reflink.c
@@ -58,7 +58,7 @@ struct reflink_range {
 	bool same_file;
 };
 
-void parse_reflink_range(const char *str, u64 *from, u64 *length, u64 *to)
+static void parse_reflink_range(const char *str, u64 *from, u64 *length, u64 *to)
 {
 	char tmp[512];
 	int i;
diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 750fc4e6354d..a667290c1585 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -280,7 +280,7 @@ static struct {
 static btrfs_list_filter_func all_filter_funcs[];
 static btrfs_list_comp_func all_comp_funcs[];
 
-void btrfs_list_setup_print_column(enum btrfs_list_column_enum column)
+static void btrfs_list_setup_print_column(enum btrfs_list_column_enum column)
 {
 	int i;
 
diff --git a/common/device-utils.c b/common/device-utils.c
index cb1a7a9d328a..70fbee49df1a 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -332,7 +332,7 @@ u64 device_get_partition_size_fd(int fd)
 	return result;
 }
 
-u64 device_get_partition_size_sysfs(const char *dev)
+static u64 device_get_partition_size_sysfs(const char *dev)
 {
 	int ret;
 	char path[PATH_MAX] = {};
diff --git a/common/utils.c b/common/utils.c
index 2c359dcf220f..3c67e1eb453c 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -498,7 +498,7 @@ static bool valid_escape(const char *str)
  * - line is advanced to the final separator or nul character
  * - returned path is a valid string terminated by zero or whitespace separator
  */
-char *read_path(char **line)
+static char *read_path(char **line)
 {
 	char *ret = *line;
 	char *out = *line;
diff --git a/kernel-shared/ulist.c b/kernel-shared/ulist.c
index e193b02d5f33..6f231a3d9eab 100644
--- a/kernel-shared/ulist.c
+++ b/kernel-shared/ulist.c
@@ -72,7 +72,7 @@ void ulist_init(struct ulist *ulist)
  * This is useful in cases where the base 'struct ulist' has been statically
  * allocated.
  */
-void ulist_release(struct ulist *ulist)
+static void ulist_release(struct ulist *ulist)
 {
 	struct ulist_node *node;
 	struct ulist_node *next;
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 16abb042f5b0..d187c5763406 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -92,7 +92,7 @@ u64 zone_size(const char *file)
 	return strtoull((const char *)chunk, NULL, 10) << SECTOR_SHIFT;
 }
 
-u64 max_zone_append_size(const char *file)
+static u64 max_zone_append_size(const char *file)
 {
 	char chunk[32];
 	int ret;
diff --git a/tune/change-csum.c b/tune/change-csum.c
index a11316860e3c..4531f2190f06 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -24,6 +24,7 @@
 #include "kernel-shared/transaction.h"
 #include "common/messages.h"
 #include "common/internal.h"
+#include "tune/tune.h"
 
 static int change_tree_csum(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			    int csum_type)
diff --git a/tune/change-uuid.c b/tune/change-uuid.c
index f148b9e54915..99ce0b15b2b9 100644
--- a/tune/change-uuid.c
+++ b/tune/change-uuid.c
@@ -25,6 +25,7 @@
 #include "kernel-shared/volumes.h"
 #include "common/defs.h"
 #include "common/messages.h"
+#include "tune/tune.h"
 #include "ioctl.h"
 
 static int change_fsid_prepare(struct btrfs_fs_info *fs_info, uuid_t new_fsid)
diff --git a/tune/convert-bgt.c b/tune/convert-bgt.c
index 27953cb26ada..c6bd4361f8ac 100644
--- a/tune/convert-bgt.c
+++ b/tune/convert-bgt.c
@@ -22,6 +22,7 @@
 #include "kernel-shared/transaction.h"
 #include "common/messages.h"
 #include "common/extent-cache.h"
+#include "tune/tune.h"
 
 /* After this many block groups we need to commit transaction. */
 #define BLOCK_GROUP_BATCH	64
diff --git a/tune/seeding.c b/tune/seeding.c
index 80b075e53baa..99ad455e9468 100644
--- a/tune/seeding.c
+++ b/tune/seeding.c
@@ -18,6 +18,7 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/transaction.h"
 #include "common/messages.h"
+#include "tune/tune.h"
 
 int update_seeding_flag(struct btrfs_root *root, const char *device, int set_flag, int force)
 {
diff --git a/tune/tune.h b/tune/tune.h
index 6beae9fc9ef7..753dc95eb138 100644
--- a/tune/tune.h
+++ b/tune/tune.h
@@ -17,6 +17,8 @@
 #ifndef __BTRFS_TUNE_H__
 #define __BTRFS_TUNE_H__
 
+#include <uuid/uuid.h>
+
 struct btrfs_root;
 struct btrfs_fs_info;
 
-- 
2.39.2

