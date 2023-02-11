Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928D5693084
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Feb 2023 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjBKLu5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Feb 2023 06:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjBKLu4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Feb 2023 06:50:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4F1166D7
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 03:50:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B06A320CCB
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676116253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EvOhysT2lBVP5MvBb+CO9mmfmI+K6OaWzwbswTPEKSY=;
        b=AlJ2ri1cPsR+2n9hOsHLW1smdzbDHGWudZNAAjUq0MdeIpRxMV0WT+wKPYypWrmwmXTDx8
        ui1S42vS3tdUwDvNipJ5cf8RpsZBL+PaY9fAJTLw0yePtHWjvkg65EtZ92MznGFQV8kfvl
        Nm4hBM7i837S+ZZqKCelpyEfq2SOfaE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 123A913A10
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AEqMMxyB52ObVgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:50:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: filesystem-usage: use btrfs_ioctl_dev_info_args::fsid to determine if a device is seed
Date:   Sat, 11 Feb 2023 19:50:32 +0800
Message-Id: <98d5e1d689f293762497337af234fed2b34232a4.1676115988.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676115988.git.wqu@suse.com>
References: <cover.1676115988.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the new member, btrfs_ioctl_dev_info_args::fsid, we can easily
determine if a device is seed, no matter if it's missing or not.

And this method is better than all the existing methods by:

- No root privilege requirement compared to tree search

- Can handle missing device compared to super block read

The only problem is, we need to check if the kernel supports the new
member.
If not, we still have to fall back to the existing methods.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/filesystem-usage.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index abde04d715a7..f7fd4f90112f 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -759,7 +759,17 @@ static int is_seed_device(int fd, u64 devid, const u8 *fsid,
 			  const struct btrfs_ioctl_dev_info_args *dev_arg)
 {
 	int ret;
-	u8 found_fsid[BTRFS_UUID_SIZE];
+	u8 found_fsid[BTRFS_UUID_SIZE] = {0};
+
+	/*
+	 * Check if @dev_arg contains a valid fsid.
+	 * If so, we can determine if it's seed immediately.
+	 */
+	if (memcmp(dev_arg->fsid, found_fsid, BTRFS_FSID_SIZE)) {
+		if (memcmp(dev_arg->fsid, fsid, BTRFS_FSID_SIZE))
+			return 1;
+		return 0;
+	}
 
 	/*
 	 * A missing device, we can not determing if it's a seed
-- 
2.39.1

