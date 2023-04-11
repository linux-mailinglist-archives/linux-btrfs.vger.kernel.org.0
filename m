Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538006DCFBB
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Apr 2023 04:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDKCbb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Apr 2023 22:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjDKCb3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Apr 2023 22:31:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8F026B2
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 19:31:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8C741FDFA
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 02:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681180285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L43IinhMCgExty2IBqQjT0VbqQ7tAzNU9ZwDVt4oZvA=;
        b=PsYQzC9BoBqPlbvfgfxLSx8AnXauS0WsO87xdX3RJ3K93Zsy6T54n4N08oH8ZMRE3pQYMY
        xbrXte/I/UAOsATvU2ldARNaJhskO3L8lNwD+a+SJLQ1pmGhuNiMfr1DJ1KY8bgDovGPdh
        pcSUfSpzUzc6rGxYQidYptN7030ar1o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1981413638
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 02:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SDykNnzGNGRWDgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 02:31:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: mkfs: make -R|--runtime-features option deprecated
Date:   Tue, 11 Apr 2023 10:31:05 +0800
Message-Id: <1ca85433fb63d9c9cf66da72e407381c0146b76c.1681180159.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681180159.git.wqu@suse.com>
References: <cover.1681180159.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The option -R|--runtime-features is introduced to support features that
doesn't result a full incompat flag change, thus things like
free-space-tree and quota features are put here.

But to end users, such separation of features is not helpful and can be
sometimes confusing.

Thus we're already migrating those runtime features into -O|--features
option under experimental builds.

I believe this is the proper time to move those runtime features into
-O|--features option, and mark the -R|--runtime-features option
deprecated.

For now we still keep the old option as for compatibility purposes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/mkfs.btrfs.rst | 25 ++++---------------------
 common/fsfeatures.c          |  6 ------
 mkfs/main.c                  |  3 ++-
 3 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index ba7227b31f72..e80f4c5c83ee 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -161,18 +161,6 @@ OPTIONS
 
                 $ mkfs.btrfs -O list-all
 
--R|--runtime-features <feature1>[,<feature2>...]
-        A list of features that be can enabled at mkfs time, otherwise would have
-        to be turned on on a mounted filesystem.
-        To disable a feature, prefix it with *^*.
-
-        See section *RUNTIME FEATURES* for more details.  To see all available
-        runtime features that **mkfs.btrfs** supports run:
-
-        .. code-block:: bash
-
-                $ mkfs.btrfs -R list-all
-
 -f|--force
         Forcibly overwrite the block devices when an existing filesystem is detected.
         By default, **mkfs.btrfs** will utilize *libblkid* to check for any known
@@ -199,6 +187,10 @@ OPTIONS
 -l|--leafsize <size>
         Removed in 6.0, used to be alias for *--nodesize*.
 
+-R|--runtime-features <feature1>[,<feature2>...]
+        Removed in 6.4, used to specify features not affecting on-disk format.
+        Now all such features are merged into `-O|--features` option.
+
 SIZE UNITS
 ----------
 
@@ -279,15 +271,6 @@ zoned
         see *ZONED MODE* in :doc:`btrfs(5)<btrfs-man5>`, the mode is automatically selected when
         a zoned device is detected
 
-
-RUNTIME FEATURES
-----------------
-
-Features that are typically enabled on a mounted filesystem, e.g. by a mount
-option or by an ioctl. Some of them can be enabled early, at mkfs time.  This
-applies to features that need to be enabled once and then the status is
-permanent, this does not replace mount options.
-
 quota
         (kernel support since 3.4)
 
diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 169e47e92582..4aca96f6e4fe 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -99,7 +99,6 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "mixed data and metadata block groups"
 	},
-#if EXPERIMENTAL
 	{
 		.name		= "quota",
 		.runtime_flag	= BTRFS_FEATURE_RUNTIME_QUOTA,
@@ -109,7 +108,6 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "quota support (qgroups)"
 	},
-#endif
 	{
 		.name		= "extref",
 		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
@@ -143,7 +141,6 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_TO_STRING2(default, 5,15),
 		.desc		= "no explicit hole extents for files"
 	},
-#if EXPERIMENTAL
 	{
 		.name		= "free-space-tree",
 		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
@@ -154,7 +151,6 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_TO_STRING2(default, 5,15),
 		.desc		= "free space tree (space_cache=v2)"
 	},
-#endif
 	{
 		.name		= "raid1c34",
 		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_RAID1C34,
@@ -185,8 +181,6 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "block group tree to reduce mount time"
 	},
-#endif
-#if EXPERIMENTAL
 	{
 		.name		= "extent-tree-v2",
 		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
diff --git a/mkfs/main.c b/mkfs/main.c
index f5e34cbda612..78cc2b598b25 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -424,7 +424,6 @@ static const char * const mkfs_usage[] = {
 	OPTLINE("-n|--nodesize SIZE", "size of btree nodes"),
 	OPTLINE("-s|--sectorsize SIZE", "data block size (may not be mountable by current kernel)"),
 	OPTLINE("-O|--features LIST", "comma separated list of filesystem features (use '-O list-all' to list features)"),
-	OPTLINE("-R|--runtime-features LIST", "comma separated list of runtime features (use '-R list-all' to list runtime features)"),
 	OPTLINE("-L|--label LABEL", "set the filesystem label"),
 	OPTLINE("-U|--uuid UUID", "specify the filesystem UUID (must be unique)"),
 	"Creation:",
@@ -440,6 +439,7 @@ static const char * const mkfs_usage[] = {
 	OPTLINE("--help", "print this help and exit"),
 	"Deprecated:",
 	OPTLINE("-l|--leafsize SIZE", "removed in 6.0, use --nodesize"),
+	OPTLINE("-R|--runtime-features LIST", "removed in 6.4, use -O|--features"),
 	NULL
 };
 
@@ -1140,6 +1140,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				char *orig = strdup(optarg);
 				char *tmp = orig;
 
+				warning("runtime features are deprecated, use -O|--features instead.");
 				tmp = btrfs_parse_runtime_features(tmp,
 						&features);
 				if (tmp) {
-- 
2.39.2

