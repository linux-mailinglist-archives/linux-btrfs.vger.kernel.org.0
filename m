Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D87E6FFD6C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 May 2023 01:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbjEKXm1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 19:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbjEKXm0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 19:42:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A044EC5
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 16:42:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 888241FF6E
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 23:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683848543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NDYMO38q3WZRQXWz3GizU/9n+q3ab0neO1WGdnoZIm8=;
        b=QuWGLcukz7W8R1uQ7NlVNDJfKQZSXNYPVkuOKl2haXq0h4XjsImbd0dI2H1M8AZ9uEs3Hs
        I/NxOsjniYJXrKF/BSLdRDWu8kV3OxGzOegtIkTHsOwoirmdFXExVDPqASRnJ0QFzURdJe
        PysR0B9c25NZKglspqOrKdgHX92g8ZI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8396134B2
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 23:42:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cuCVKF59XWQ3SwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 23:42:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: trigger orphan inodes cleanup during sync ioctl
Date:   Fri, 12 May 2023 07:42:05 +0800
Message-Id: <79d32abc0d6c1a3afcf9224bd44875f5594c80b6.1683848508.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
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

There is an internal error report that scrub found an error in an orphan
inode's data.

However there are very limited ways to cleanup such orphan inodes:

- btrfs_start_pre_rw_mount()
  This happens at either mount, or RO->RW switch.
  This is not a valiable solution for rootfs which may not be unmounted
  or RO mounted.

  Furthermore this doesn't cover every subvolume, it only covers the
  currently cached subvolumes.

- btrfs_lookup_dentry()
  This happens when we first lookup the subvolume dentry.
  But dentry can be cached thus it's not ensured to be triggered every
  time.

- create_snapshot()
  This only happens for the created snapshot, not the source one.

This means if we didn't trigger orphan items cleanup, there is really no
way to manually trigger it.

Thus this patch would add a manual trigger for sync ioctl.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:
Although this patch is very small, it involves a behavior change and
hugely delay the sync ioctl.
---
 fs/btrfs/ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index df7603c30686..51ad2f0f9dd8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3111,6 +3111,11 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 {
 	struct btrfs_trans_handle *trans;
 	u64 transid;
+	int ret;
+
+	ret = btrfs_orphan_cleanup(root);
+	if (ret < 0)
+		return ret;
 
 	trans = btrfs_attach_transaction_barrier(root);
 	if (IS_ERR(trans)) {
-- 
2.40.1

