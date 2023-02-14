Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E96695A6A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 08:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjBNHQC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 02:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjBNHPo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 02:15:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A494C22785
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 23:12:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 18E3120DD5
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 07:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676358685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2AvXA99NeS+O8uuQw6VgLWfX1RAH3pCQQm0o9OmIMVM=;
        b=fGvwJlRR11KRjJrgSCfNfDCpf0JR/9mWZ+2mAmzkuulDHOT22RpoV1LXUrl56EdNWQPR5Z
        Y0mKpVByffX5ZIcqmFZ9nTejfa75KSBa20DkMUca0Owz6QQrz6PLAKHT+2ZG6h3LUs/dxJ
        5LNNdCGR8JuOrNQevuqgbiCTy+ovszI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E54913A21
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 07:11:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ITxrDhw062PLDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 07:11:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fsfeatures: remove the EXPERIMENTAL flags for block group tree runtime feature
Date:   Tue, 14 Feb 2023 15:11:06 +0800
Message-Id: <11d75f3cce7b1f9f265e08580cca293984ad68d8.1676358661.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
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

This block group tree support is already in the v6.1 kernel, and I know
some adventurous users are already recompiling their progs to take
advantage of the new feature.

Especially the block group tree feature would reduce the mount time from
several minutes to several seconds for one of my friend.
(Of course, he is doing an offline convert using btrfstune)

I see now reason to hide this feature behind experimental flags.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 169e47e92582..ddd9c9419e84 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -175,7 +175,6 @@ static const struct btrfs_feature mkfs_features[] = {
 		.desc		= "support zoned devices"
 	},
 #endif
-#if EXPERIMENTAL
 	{
 		.name		= "block-group-tree",
 		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
@@ -185,7 +184,6 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "block group tree to reduce mount time"
 	},
-#endif
 #if EXPERIMENTAL
 	{
 		.name		= "extent-tree-v2",
@@ -228,7 +226,6 @@ static const struct btrfs_feature runtime_features[] = {
 		VERSION_TO_STRING2(default, 5,15),
 		.desc		= "free space tree (space_cache=v2)"
 	},
-#if EXPERIMENTAL
 	{
 		.name		= "block-group-tree",
 		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
@@ -238,7 +235,6 @@ static const struct btrfs_feature runtime_features[] = {
 		VERSION_NULL(default),
 		.desc		= "block group tree to reduce mount time"
 	},
-#endif
 	/* Keep this one last */
 	{
 		.name		= "list-all",
-- 
2.39.1

