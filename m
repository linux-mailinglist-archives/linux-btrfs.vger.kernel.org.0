Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D872E7927EE
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbjIEQDR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353746AbjIEHwP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 03:52:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A13CCF
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 00:52:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C03001F750
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693900329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/K3fjCK5yXwCzIcV3hKbGtJiEHVdWbw1QKWgVF8Mqpw=;
        b=RXa2HGbj+ZWIaTfuCqaJZaVW03/Wo0zr7AI12AEa9b4bCurcHne4X3axXlNftTl2FBeybE
        PuEzXTkKdgj47VHIDdGr9ZltsP8eczUawjbo8Z7IXeFv5sKVFiq9ywAcJNEySeKH7HVOF6
        NU7sKt4MLXf6V66gJ8/todgO7h7mo3E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 140E713911
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6KusMije9mTFeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 07:52:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs-progs: export btrfs_feature structure
Date:   Tue,  5 Sep 2023 15:51:43 +0800
Message-ID: <512e1bb1572d5ffc3557a86a4ce3860420352214.1693900169.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693900169.git.wqu@suse.com>
References: <cover.1693900169.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the incoming "btrfs tune" subcommand, we will have different
features supported by that subcommand.

Instead of bloating the runtime and mkfs features, here we just export
btrfs_feature, so each subcommand can have their own definition of
supported features.

And since we're here, also add needed headers for future users of
"fsfeatures.h".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c | 53 ---------------------------------------------
 common/fsfeatures.h | 50 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 9ee392d3a8a6..f8eeea7695c1 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -32,64 +32,11 @@
 #include "common/sysfs-utils.h"
 #include "common/messages.h"
 
-/*
- * Insert a root item for temporary tree root
- *
- * Only used in make_btrfs_v2().
- */
-#define VERSION_TO_STRING3(name, a,b,c)				\
-	.name ## _str = #a "." #b "." #c,			\
-	.name ## _ver = KERNEL_VERSION(a,b,c)
-#define VERSION_TO_STRING2(name, a,b)				\
-	.name ## _str = #a "." #b,				\
-	.name ## _ver = KERNEL_VERSION(a,b,0)
-#define VERSION_NULL(name)					\
-	.name ## _str = NULL,					\
-	.name ## _ver = 0
-
 enum feature_source {
 	FS_FEATURES,
 	RUNTIME_FEATURES,
 };
 
-/*
- * Feature stability status and versions: compat <= safe <= default
- */
-struct btrfs_feature {
-	const char *name;
-
-	/*
-	 * At least one of the bit must be set in the following *_flag member.
-	 *
-	 * For features like list-all and quota which don't have any
-	 * incompat/compat_ro bit set, it go to runtime_flag.
-	 */
-	u64 incompat_flag;
-	u64 compat_ro_flag;
-	u64 runtime_flag;
-
-	const char *sysfs_name;
-	/*
-	 * Compatibility with kernel of given version. Filesystem can be
-	 * mounted.
-	 */
-	const char *compat_str;
-	u32 compat_ver;
-	/*
-	 * Considered safe for use, but is not on by default, even if the
-	 * kernel supports the feature.
-	 */
-	const char *safe_str;
-	u32 safe_ver;
-	/*
-	 * Considered safe for use and will be turned on by default if
-	 * supported by the running kernel.
-	 */
-	const char *default_str;
-	u32 default_ver;
-	const char *desc;
-};
-
 static const struct btrfs_feature mkfs_features[] = {
 	{
 		.name		= "mixed-bg",
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index c4ab704862cd..c9fb489d2d79 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -19,7 +19,9 @@
 
 #include "kerncompat.h"
 #include <stdio.h>
+#include <linux/version.h>
 #include "kernel-lib/sizes.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 #define BTRFS_MKFS_DEFAULT_NODE_SIZE SZ_16K
 
@@ -43,6 +45,54 @@ struct btrfs_mkfs_features {
  */
 #define BTRFS_FEATURE_STRING_BUF_SIZE		(160)
 
+#define VERSION_TO_STRING3(name, a,b,c)				\
+	.name ## _str = #a "." #b "." #c,			\
+	.name ## _ver = KERNEL_VERSION(a,b,c)
+#define VERSION_TO_STRING2(name, a,b)				\
+	.name ## _str = #a "." #b,				\
+	.name ## _ver = KERNEL_VERSION(a,b,0)
+#define VERSION_NULL(name)					\
+	.name ## _str = NULL,					\
+	.name ## _ver = 0
+
+/*
+ * Feature stability status and versions: compat <= safe <= default
+ */
+struct btrfs_feature {
+	const char *name;
+
+	/*
+	 * At least one of the bit must be set in the following *_flag member.
+	 *
+	 * For features like list-all and quota which don't have any
+	 * incompat/compat_ro bit set, it go to runtime_flag.
+	 */
+	u64 incompat_flag;
+	u64 compat_ro_flag;
+	u64 runtime_flag;
+
+	const char *sysfs_name;
+	/*
+	 * Compatibility with kernel of given version. Filesystem can be
+	 * mounted.
+	 */
+	const char *compat_str;
+	u32 compat_ver;
+	/*
+	 * Considered safe for use, but is not on by default, even if the
+	 * kernel supports the feature.
+	 */
+	const char *safe_str;
+	u32 safe_ver;
+	/*
+	 * Considered safe for use and will be turned on by default if
+	 * supported by the running kernel.
+	 */
+	const char *default_str;
+	u32 default_ver;
+	const char *desc;
+};
+
 static const struct btrfs_mkfs_features btrfs_mkfs_default_features = {
 	.compat_ro_flags = BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
 			   BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID,
-- 
2.42.0

