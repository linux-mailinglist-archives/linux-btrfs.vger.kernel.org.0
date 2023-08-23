Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D99785680
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 13:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjHWLLR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 07:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjHWLLQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 07:11:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021A0E40
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 04:11:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B84C521D06
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 11:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692789071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MkOWRfR7qGvxE+25/w7fZHkee2CVEPuin01IH2Vik+M=;
        b=Q8LzO6wB2bvrF39lGs9qYVcX+wFtY52QlzwaDoOXd1Mu7IHwxFlc+qZUL9skfcEGS6mVY5
        oI5JJ99PC5Y0lh5aUTQAuKqfnTfxTB3GTZfwfXkkzCD3oJpX6NWsS9BPVaKQeWmWKVPDx1
        CCcDhh9HTo/fgaxOBSetPwrKRAspouY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7ACE13458
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 11:11:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S0mbKk7p5WQbKwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 11:11:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: tune: do not allow multiple features in different groups to be executed in one go
Date:   Wed, 23 Aug 2023 19:11:05 +0800
Message-ID: <5e887659a71a834e82690ba28af1c50a4ae6fa48.1692789062.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
Btrfstune allows mulitple different options to be executed in one go,
some options are completely fine, like no-holes along with extref, but
with more and more options, we need more exclusive checks.

In fact a lot of new options are already not following the old
success/total checks.

[ENHANCEMENT]
There is really not much need to allow multiple features to be set in
one go.

So this patch introduce a small array called btrfstune_cmd_groups[],
which sort all the options into the following categories:

- Extent tree
  This includes converting to/from extent and block group tree.

- Space cache
  This includes converting to v2 space cache.

- Metadata UUID
  This includes changing metadata uuid.

- FSID change
  This includes the slower full fs fsid rewrites.

- Csum change
  This includes the experimental csum rewrites.

- Seed devices
  This includes changing the device seed flag.

- Legacy options
  This includes no-holes/extref/skinny-metadata features, which are
  already default mkfs features.

Now we only allow options inside the same group to be specified.
E.g. "btrfstune -r -S 1" would fail as it includes both legacy and seed
groups.
Meanwhile "btrfstune -r -n" would still be allowed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/main.c | 126 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 86 insertions(+), 40 deletions(-)

diff --git a/tune/main.c b/tune/main.c
index c49c24298187..fe814fccc675 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -130,12 +130,54 @@ static const struct cmd_struct tune_cmd = {
 	.usagestr = tune_usage
 };
 
+enum btrfstune_group_enum {
+	/* Extent/block group tree feature. */
+	EXTENT_TREE,
+
+	/* V1/v2 free space cache. */
+	SPACE_CACHE,
+
+	/* Metadata UUID. */
+	METADATA_UUID,
+
+	/* FSID change. */
+	FSID_CHANGE,
+
+	/* Seed device. */
+	SEED,
+
+	/* Csum conversion */
+	CSUM_CHANGE,
+
+	/*
+	 * Legacy features (which later become default), including:
+	 * - no-holes
+	 * - extref
+	 * - skinny-metadata
+	 */
+	LEGACY,
+
+	BTRFSTUNE_NR_GROUPS,
+};
+
+static bool btrfstune_cmd_groups[BTRFSTUNE_NR_GROUPS] = { 0 };
+
+static unsigned int btrfstune_count_set_groups()
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < BTRFSTUNE_NR_GROUPS; i++) {
+		if (btrfstune_cmd_groups[i])
+			ret++;
+	}
+	return ret;
+}
+
 int BOX_MAIN(btrfstune)(int argc, char *argv[])
 {
 	struct btrfs_root *root;
 	unsigned ctree_flags = OPEN_CTREE_WRITES;
-	int success = 0;
-	int total = 0;
 	int seeding_flag = 0;
 	u64 seeding_value = 0;
 	int random_fsid = 0;
@@ -177,15 +219,19 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		case 'S':
 			seeding_flag = 1;
 			seeding_value = arg_strtou64(optarg);
+			btrfstune_cmd_groups[SEED] = true;
 			break;
 		case 'r':
 			super_flags |= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF;
+			btrfstune_cmd_groups[LEGACY] = true;
 			break;
 		case 'x':
 			super_flags |= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
+			btrfstune_cmd_groups[LEGACY] = true;
 			break;
 		case 'n':
 			super_flags |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
+			btrfstune_cmd_groups[LEGACY] = true;
 			break;
 		case 'f':
 			force = 1;
@@ -193,28 +239,35 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		case 'U':
 			ctree_flags |= OPEN_CTREE_IGNORE_FSID_MISMATCH;
 			new_fsid_str = optarg;
+			btrfstune_cmd_groups[FSID_CHANGE] = true;
 			break;
 		case 'u':
 			ctree_flags |= OPEN_CTREE_IGNORE_FSID_MISMATCH;
 			random_fsid = 1;
+			btrfstune_cmd_groups[FSID_CHANGE] = true;
 			break;
 		case 'M':
 			ctree_flags |= OPEN_CTREE_IGNORE_FSID_MISMATCH;
 			change_metadata_uuid = 1;
 			new_fsid_str = optarg;
+			btrfstune_cmd_groups[METADATA_UUID] = true;
 			break;
 		case 'm':
 			ctree_flags |= OPEN_CTREE_IGNORE_FSID_MISMATCH;
 			change_metadata_uuid = 1;
+			btrfstune_cmd_groups[METADATA_UUID] = true;
 			break;
 		case GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE:
 			to_bg_tree = true;
+			btrfstune_cmd_groups[EXTENT_TREE] = true;
 			break;
 		case GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE:
 			to_extent_tree = true;
+			btrfstune_cmd_groups[EXTENT_TREE] = true;
 			break;
 		case GETOPT_VAL_ENABLE_FREE_SPACE_TREE:
 			to_fst = true;
+			btrfstune_cmd_groups[SPACE_CACHE] = true;
 			break;
 #if EXPERIMENTAL
 		case GETOPT_VAL_CSUM:
@@ -222,6 +275,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 				"Switching checksums is experimental, do not use for valuable data!");
 			ctree_flags |= OPEN_CTREE_SKIP_CSUM_CHECK;
 			csum_type = parse_csum_type(optarg);
+			btrfstune_cmd_groups[CSUM_CHANGE] = true;
 			break;
 #endif
 		case GETOPT_VAL_HELP:
@@ -237,20 +291,23 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		goto free_out;
 	}
 
-	if (random_fsid && new_fsid_str) {
-		error("random fsid can't be used with specified fsid");
-		ret = 1;
-		goto free_out;
-	}
-	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
-	    !change_metadata_uuid && csum_type == -1 && !to_bg_tree &&
-	    !to_extent_tree && !to_fst) {
+	if (btrfstune_count_set_groups() == 0) {
 		error("at least one option should be specified");
 		usage(&tune_cmd, 1);
 		ret = 1;
 		goto free_out;
 	}
-
+	if (btrfstune_count_set_groups() > 1) {
+		error("too many conflicting options specified");
+		usage(&tune_cmd, 1);
+		ret = 1;
+		goto free_out;
+	}
+	if (random_fsid && new_fsid_str) {
+		error("random fsid can't be used with specified fsid");
+		ret = 1;
+		goto free_out;
+	}
 	if (new_fsid_str) {
 		uuid_t tmp;
 
@@ -319,17 +376,17 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
  	if (to_bg_tree) {
 		if (to_extent_tree) {
 			error("option --convert-to-block-group-tree conflicts with --convert-from-block-group-tree");
-			ret = 1;
+			ret = -EINVAL;
 			goto out;
 		}
 		if (btrfs_fs_compat_ro(root->fs_info, BLOCK_GROUP_TREE)) {
 			error("the filesystem already has block group tree feature");
-			ret = 1;
+			ret = -EINVAL;
 			goto out;
 		}
 		if (!btrfs_fs_compat_ro(root->fs_info, FREE_SPACE_TREE_VALID)) {
 			error("the filesystem doesn't have space cache v2, needs to be mounted with \"-o space_cache=v2\" first");
-			ret = 1;
+			ret = -EINVAL;
 			goto out;
 		}
 		ret = convert_to_bg_tree(root->fs_info);
@@ -342,7 +399,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	if (to_fst) {
 		if (btrfs_fs_compat_ro(root->fs_info, FREE_SPACE_TREE_VALID)) {
 			error("filesystem already has free-space-tree feature");
-			ret = 1;
+			ret = -EINVAL;
 			goto out;
 		}
 		ret = convert_to_fst(root->fs_info);
@@ -353,12 +410,12 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	if (to_extent_tree) {
 		if (to_bg_tree) {
 			error("option --convert-to-block-group-tree conflicts with --convert-from-block-group-tree");
-			ret = 1;
+			ret = -EINVAL;
 			goto out;
 		}
 		if (!btrfs_fs_compat_ro(root->fs_info, BLOCK_GROUP_TREE)) {
 			error("filesystem doesn't have block-group-tree feature");
-			ret = 1;
+			ret = -EINVAL;
 			goto out;
 		}
 		ret = convert_to_extent_tree(root->fs_info);
@@ -371,7 +428,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	if (seeding_flag) {
 		if (btrfs_fs_incompat(root->fs_info, METADATA_UUID)) {
 			error("SEED flag cannot be changed on a metadata-uuid changed fs");
-			ret = 1;
+			ret = -EINVAL;
 			goto out;
 		}
 
@@ -381,34 +438,30 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			ret = ask_user("We are going to clear the seeding flag, are you sure?");
 			if (!ret) {
 				error("clear seeding flag canceled");
-				ret = 1;
+				ret = -EINVAL;
 				goto out;
 			}
 		}
 
 		ret = update_seeding_flag(root, device, seeding_value, force);
-		if (!ret)
-			success++;
-		total++;
+		goto out;
 	}
 
 	if (super_flags) {
 		ret = set_super_incompat_flags(root, super_flags);
-		if (!ret)
-			success++;
-		total++;
+		goto out;
 	}
 
 	if (csum_type != -1) {
-		/* TODO: check conflicting flags */
 		pr_verbose(LOG_DEFAULT, "Proceed to switch checksums\n");
 		ret = btrfs_change_csum_type(root->fs_info, csum_type);
+		goto out;
 	}
 
 	if (change_metadata_uuid) {
 		if (seeding_flag) {
 			error("not allowed to set both seeding flag and uuid metadata");
-			ret = 1;
+			ret = -EINVAL;
 			goto out;
 		}
 
@@ -417,10 +470,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		else
 			ret = set_metadata_uuid(root, NULL);
 
-		if (!ret)
-			success++;
-		total++;
 		btrfs_register_all_devices();
+		goto out;
 	}
 
 	if (random_fsid || (new_fsid_str && !change_metadata_uuid)) {
@@ -429,7 +480,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			error(
 		"Cannot rewrite fsid while METADATA_UUID flag is active. \n"
 		"Ensure fsid and metadata_uuid match before retrying.");
-			ret = 1;
+			ret = -EINVAL;
 			goto out;
 		}
 
@@ -441,24 +492,19 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			ret = ask_user("We are going to change UUID, are your sure?");
 			if (!ret) {
 				error("UUID change canceled");
-				ret = 1;
+				ret = -EINVAL;
 				goto out;
 			}
 		}
 		ret = change_uuid(root->fs_info, new_fsid_str);
-		if (!ret)
-			success++;
-		total++;
+		goto out;
 	}
-
-	if (success == total) {
-		ret = 0;
-	} else {
+out:
+	if (ret < 0) {
 		root->fs_info->readonly = 1;
 		ret = 1;
 		error("btrfstune failed");
 	}
-out:
 	close_ctree(root);
 	btrfs_close_all_devices();
 
-- 
2.41.0

