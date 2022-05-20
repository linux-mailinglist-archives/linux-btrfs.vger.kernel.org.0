Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0255C52E62E
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 09:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346417AbiETHXz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 03:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346457AbiETHXs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 03:23:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4075D15AB24
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 00:23:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F164C1F975
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 07:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653031425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wPy+JHPyIjyOCaiyPscUWoH8x3QK6YL2Wj+WgXXS/t4=;
        b=f7MVFOdJr2yZcT2r+T5z4nbwfwAluwLnZinEWHrPLoveampq3vqEBXCZY3BrkQzU+eI5O/
        enapCWiKtNC4Sj6ozGs7yrpDDWS1Dn76dM73r4I0l381HPR8fVNb5uoQgxcX3wkZ4sJycc
        KHbq54gfuP7jh3X7P1+LLvyHrRsw9Go=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5014B13AF4
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 07:23:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7r20BgFCh2JXLwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 07:23:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: introduce inspect-internal map-logical command
Date:   Fri, 20 May 2022 15:23:26 +0800
Message-Id: <ff62eb10cbf38e53ac26f458644257f82daba47c.1653031397.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a simpler version compared to btrfs-map-logical.

The differences are:

- No extent check
  Thus any bytenr which has chunk mapping can be mapped.

- No length specification
  Now it's fixed to sectorsize.
  Previously we use nodesize in btrfs-map-logical, which would only
  make the output more complex due as it may cross stripe boundary
  for data extent.

  Considering the main users of this functionality is data corruption,
  thus we really just want to resolve a single sector.

- No data write support nor mirror specification
  We always output all mirrors and call it a day.

- Ignore RAID56 parity manually

We still keep the old btrfs-map-logical, just in case there are some
usage of certain parameters.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-inspect-internal.rst |  7 +++
 cmds/inspect.c                           | 78 ++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/Documentation/btrfs-inspect-internal.rst b/Documentation/btrfs-inspect-internal.rst
index 710a34fb0cb9..8a9264d3dc5b 100644
--- a/Documentation/btrfs-inspect-internal.rst
+++ b/Documentation/btrfs-inspect-internal.rst
@@ -169,6 +169,13 @@ logical-resolve [-Pvo] [-s <bufsize>] <logical> <path>
         -v
                 (deprecated) alias for global *-v* option
 
+map-logical <logical> <device>
+        map the sector at given *logical* address in the linear filesystem space into
+        physical address.
+
+        .. note::
+                For RAID56, this will only map the data stripe.
+
 min-dev-size [options] <path>
         (needs root privileges)
 
diff --git a/cmds/inspect.c b/cmds/inspect.c
index 1534f2040f4e..271adf8c6fd4 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -29,6 +29,7 @@
 #include "kernel-shared/ctree.h"
 #include "common/send-utils.h"
 #include "kernel-shared/disk-io.h"
+#include "kernel-shared/volumes.h"
 #include "cmds/commands.h"
 #include "common/help.h"
 #include "common/open-utils.h"
@@ -125,6 +126,7 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 }
 static DEFINE_SIMPLE_COMMAND(inspect_inode_resolve, "inode-resolve");
 
+
 static const char * const cmd_inspect_logical_resolve_usage[] = {
 	"btrfs inspect-internal logical-resolve [-Pvo] [-s bufsize] <logical> <path>",
 	"Get file system paths for the given logical address",
@@ -348,6 +350,81 @@ out:
 }
 static DEFINE_SIMPLE_COMMAND(inspect_subvolid_resolve, "subvolid-resolve");
 
+static const char * const cmd_inspect_map_logical_usage[] = {
+	"btrfs inspect-internal map-logical <logical> <device>",
+	"Get the physical offset of a sector.",
+	NULL
+};
+
+static int print_mapping_info(struct btrfs_fs_info *fs_info, u64 logical)
+{
+	struct cache_extent *ce;
+	struct map_lookup *map;
+	int num_copies;
+	int cur_mirror;
+	int ret;
+
+	ce = search_cache_extent(&fs_info->mapping_tree.cache_tree, logical);
+	if (!ce) {
+		error("no chunk mapping found for logical %llu", logical);
+		return -ENOENT;
+	}
+	map = container_of(ce, struct map_lookup, ce);
+	/* For RAID56, we only return the data stripe. */
+	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
+		num_copies = 1;
+	else
+		num_copies = btrfs_num_copies(fs_info, logical,
+					      fs_info->sectorsize);
+
+	for (cur_mirror = 1; cur_mirror <= num_copies; cur_mirror++) {
+		struct btrfs_multi_bio *multi = NULL;
+		u64 len = fs_info->sectorsize;
+
+		ret = btrfs_map_block(fs_info, READ, logical, &len, &multi,
+				      cur_mirror, NULL);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to map logical %llu: %m", logical);
+			return ret;
+		}
+		/* We're using READ, which should only return one mirror. */
+		ASSERT(multi && multi->num_stripes == 1);
+		printf("mirror %d logical %llu phyiscal %llu device %s\n",
+			cur_mirror, logical, multi->stripes[0].physical,
+			multi->stripes[0].dev->name);
+		free(multi);
+	}
+	return 0;
+}
+
+static int cmd_inspect_map_logical(const struct cmd_struct *cmd, int argc,
+				   char **argv)
+{
+	struct open_ctree_flags ocf = {0};
+	struct btrfs_fs_info *fs_info;
+	u64 logical;
+	int ret;
+
+	clean_args_no_options(cmd, argc, argv);
+
+	if (check_argc_exact(argc - optind, 2))
+		return 1;
+
+	ocf.filename = argv[optind + 1];
+	ocf.flags = OPEN_CTREE_CHUNK_ROOT_ONLY;
+	logical = arg_strtou64(argv[optind]);
+
+	fs_info = open_ctree_fs_info(&ocf);
+	if (!fs_info) {
+		error("failed to open btrfs on %s", ocf.filename);
+		return 1;
+	}
+	ret = print_mapping_info(fs_info, logical);
+	return !!ret;
+}
+static DEFINE_SIMPLE_COMMAND(inspect_map_logical, "map-logical");
+
 static const char* const cmd_inspect_rootid_usage[] = {
 	"btrfs inspect-internal rootid <path>",
 	"Get tree ID of the containing subvolume of path.",
@@ -690,6 +767,7 @@ static const struct cmd_group inspect_cmd_group = {
 		&cmd_struct_inspect_inode_resolve,
 		&cmd_struct_inspect_logical_resolve,
 		&cmd_struct_inspect_subvolid_resolve,
+		&cmd_struct_inspect_map_logical,
 		&cmd_struct_inspect_rootid,
 		&cmd_struct_inspect_min_dev_size,
 		&cmd_struct_inspect_dump_tree,
-- 
2.36.1

