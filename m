Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD137C642F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 06:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbjJLEpM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 00:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjJLEpL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 00:45:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8229BA9
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 21:45:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1F8CB1F74D
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 04:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697085908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Jzk7AO9TEBssCrHCNGhSWX9FnjZ2EtSHi0JcRiDg0NA=;
        b=jwd6Ec5tXD/4p4FnJiaCcnUx9pP7hpRe9eYjJKw/DttoDiyw8f0MNkTDTAW/1cDkoE1AZ1
        4Rf8eHzU8LIjXu2UOyrAIMGPBM3HVZJszimrccn6r8G1n19IED3TR40InOwS7aJAHt2OPX
        6MFTD1s6/26tSy1Iqtv+O0ECFNJWpAg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F4CF139ED
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 04:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nGBhA9N5J2WVXwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 04:45:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reject unknown mount options correctly
Date:   Thu, 12 Oct 2023 15:14:49 +1030
Message-ID: <a6a954a1f1c7d612104279c62916f49e47ba5811.1697085884.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
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

[BUG]
The following script would allow invalid mount options to be specified
(although such invalid options would just be ignored):

 # mkfs.btrfs -f $dev
 # mount $dev $mnt1		<<< Successful mount expected
 # mount $dev $mnt2 -o junk	<<< Failed mount expected
 # echo $?
 0

[CAUSE]
During the mount progress, btrfs_mount_root() would go different paths
depending on if there is already a mounted btrfs for it:

	s = sget();
	if (s->s_root) {
		/* do the cleanups and reuse the existing super */
	} else {
		/* do the real mount */
		error = btrfs_fill_super();
	}

Inside btrfs_fill_super() we call open_ctree() and then
btrfs_parse_options(), which would reject all the invalid options.

But if we got the other path, we won't really call
btrfs_parse_options(), thus we just ignore the mount options completely.

[FIX]
Instead of pure cleanups, if we found an existing mounted btrfs, we
still do a very basic mount options check, to reject unknown mount
options.

Inside btrfs_mount_root(), we have already called
security_sb_eat_lsm_opts(), which would have already stripe the security
mount options, thus if we hit an error, it must be an invalid one.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This would be the proper fix for the recently reverted commit
5f521494cc73 ("btrfs: reject unknown mount options early").

With updated timing where the new check is after
security_sb_eat_lsm_opts().
---
 fs/btrfs/super.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index cc326969751f..4e4a2e4ba315 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -860,6 +860,50 @@ static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
 	return error;
 }
 
+/*
+ * Check if the @options has any invalid ones.
+ *
+ * NOTE: this can only be called after security_sb_eat_lsm_opts().
+ *
+ * Return -ENOMEM if we failed to allocate the memory for the string
+ * Return -EINVAL if we found invalid mount options
+ * Return 0 otherwise.
+ */
+static int btrfs_check_invalid_options(const char *options)
+{
+	substring_t args[MAX_OPT_ARGS];
+	char *opts, *orig, *p;
+	int ret = 0;
+
+	if (!options)
+		return 0;
+
+	opts = kstrdup(options, GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+	orig = opts;
+
+	while ((p = strsep(&opts, ",")) != NULL) {
+		int token;
+
+		if (!*p)
+			continue;
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+		case Opt_err:
+			btrfs_err(NULL, "unrecognized mount option '%s'", p);
+			ret = -EINVAL;
+			goto out;
+		default:
+			break;
+		}
+	}
+out:
+	kfree(orig);
+	return ret;
+}
+
 /*
  * Parse mount options that are related to subvolume id
  *
@@ -1474,6 +1518,8 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		btrfs_free_fs_info(fs_info);
 		if ((flags ^ s->s_flags) & SB_RDONLY)
 			error = -EBUSY;
+		if (!error)
+			error = btrfs_check_invalid_options(data);
 	} else {
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
-- 
2.42.0

