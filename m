Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF66153FDDA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 13:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbiFGLtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 07:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243221AbiFGLsu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 07:48:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA5385EEE;
        Tue,  7 Jun 2022 04:48:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 49D6B1F920;
        Tue,  7 Jun 2022 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654602522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NUwf3Gk9Ls+AmYFjduKNpBrgoW1N6oRmrELloAJjmks=;
        b=b3s3RkuCMvV1Jl6K534V81LTCpKmWJncosYpSTxRmpU+lep9lZE6m+nH51kdl4v0RTNnwt
        X3QnWV/45K28WKqdub3Up5tgUKObWmvKUh7PkmmBwBpebOOvHCCPTZYzVqSWbgnJqDyAeE
        dY1s3Qv5lZLcusZgpt9nIUq/TqMsQ1I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7325E13638;
        Tue,  7 Jun 2022 11:48:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3A73Dxk7n2KzdQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 07 Jun 2022 11:48:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH v2] btrfs: reject log replay if there is unsupported RO flag
Date:   Tue,  7 Jun 2022 19:48:24 +0800
Message-Id: <a6612cd9432b8ae6429cceee561c0259232cc554.1654602414.git.wqu@suse.com>
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

[BUG]
If we have a btrfs image with dirty log, along with an unsupported RO
compatible flag:

log_root		30474240
...
compat_flags		0x0
compat_ro_flags		0x40000003
			( FREE_SPACE_TREE |
			  FREE_SPACE_TREE_VALID |
			  unknown flag: 0x40000000 )

Then even if we can only mount it RO, we will still cause metadata
update for log replay:

 BTRFS info (device dm-1): flagging fs with big metadata feature
 BTRFS info (device dm-1): using free space tree
 BTRFS info (device dm-1): has skinny extents
 BTRFS info (device dm-1): start tree-log replay

This is definitely against RO compact flag requirement.

[CAUSE]
RO compact flag only forces us to do RO mount, but we will still do log
replay for plain RO mount.

Thus this will result us to do log replay and update metadata.

This can be very problematic for new RO compat flag, for example older
kernel can not understand v2 cache, and if we allow metadata update on
RO mount and invalidate/corrupt v2 cache.

[FIX]
Just reject the mount unless rescue=nologreplay is provided:

  BTRFS error (device dm-1): cannot replay dirty log with unsupport optional features (0x40000000), try rescue=nologreplay instead

We don't want to set rescue=nologreply directly, as this would make the
end user to read the old data, and cause confusion.

Since the such case is really rare, we're mostly fine to just reject the
mount with an error message, which also includes the proper workaround.

Cc: stable@vger.kernel.org #4.9+
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Reject the mount instead of setting nologreplay
  To avoid the confusion which can return old data.
  Unfortunately I don't have a better to shrink the new error message
  into one 80-char line.
---
 fs/btrfs/disk-io.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fe309db9f5ff..f20bd8024334 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3655,6 +3655,20 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		err = -EINVAL;
 		goto fail_alloc;
 	}
+	/*
+	 * We have unsupported RO compat features, although RO mounted, we
+	 * should not cause any metadata write, including log replay.
+	 * Or we can screw up whatever the new feature requires.
+	 */
+	if (unlikely(features && btrfs_super_log_root(disk_super) &&
+		     !btrfs_test_opt(fs_info, NOLOGREPLAY))) {
+		btrfs_err(fs_info,
+"cannot replay dirty log with unsupport optional features (0x%llx), try rescue=nologreplay instead",
+			  features);
+		err = -EINVAL;
+		goto fail_alloc;
+	}
+
 
 	if (sectorsize < PAGE_SIZE) {
 		struct btrfs_subpage_info *subpage_info;
-- 
2.36.1

