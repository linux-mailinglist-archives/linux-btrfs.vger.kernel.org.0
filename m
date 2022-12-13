Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630E164B361
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 11:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiLMKmd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 05:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiLMKmb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 05:42:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5F01B9D0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 02:42:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1ABC6145A
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F64C433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670928150;
        bh=VgDCBg8eYkUiOX78p1TGqxJgFkwkkphmUiyaW251uMY=;
        h=From:To:Subject:Date:From;
        b=JHKB7hsx06Lon8j/DhshleBj0MncwC7Fo2pF4oACxdsnliWkLNHKFYcMKHEJ2xCtF
         HIoT2/JTwPO88MqEHZHRpwd5GIvM/k943uLa/W/esTwv8LWhpxJiIa8zICnh6I3E6I
         kKEPOIFyKq+BzBral6bSMIxuPqNtqjWpX6j2tOqmKwhtwNLUcwGeqiQHdsOQbG9YR4
         Im1YQHFfNnd+nKM4FkNbiIg9iwzPa/DSlAP6Z00UebwuQo4I9XB/S8kLlNirgaCiUP
         Kmqxk3JEhh9DDwp4jqja6K74Ajerp8oxx0SJjntoipnX/jqwr0qH9mgDHgC2WI2VY6
         iUC8nd3VdrkyQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix leak of fs devices after removing btrfs module
Date:   Tue, 13 Dec 2022 10:42:26 +0000
Message-Id: <914f0ef27d40e6bac9b63f27c40357e7dcdc1bb0.1670928105.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When removing the btrfs module we are not calling btrfs_cleanup_fs_uuids()
which results in leaking btrfs_fs_devices structures and other resources.
This is a regression recently introduced by a refactoring of the module
initialization and exit sequence, which simply removed the call to
btrfs_cleanup_fs_uuids() in the exit path, resulting in the leaks.

So fix this by calling btrfs_cleanup_fs_uuids() at exit_btrfs_fs().

Fixes: 5565b8e0adcd ("btrfs: make module init/exit match their sequence")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 93f52ee85f6f..d5de18d6517e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2514,6 +2514,7 @@ static __always_inline void btrfs_exit_btrfs_fs(void)
 static void __exit exit_btrfs_fs(void)
 {
 	btrfs_exit_btrfs_fs();
+	btrfs_cleanup_fs_uuids();
 }
 
 static int __init init_btrfs_fs(void)
-- 
2.35.1

