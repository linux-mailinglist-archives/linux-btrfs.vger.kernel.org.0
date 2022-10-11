Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F385FB236
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJKMRb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJKMRZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:17:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FF15755F
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51BCFCE16C5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A099C433D7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665490641;
        bh=6zdh+oXTjm2mZHvnq1SUvQWAIouArWQfCqPI9wvwWto=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gKkGDgz2wXqpFUcKEPOMp2DqWRii+rfnHaWU1lgboqwjhYdCcCAi6Jx0WeWjubGjR
         UAGajmH5zYyH3R/+ehEUn2Z3+AX7WL9FXzVEKZ+VGvO8gSJi2i8NkbtHq7nYqnJaEo
         oYqyXZJdfBEsRDR+Pv369F0Ew6QHZjmkvQN2enxpiWLQVi2TpWGRD45Cosmrs9LCqF
         mChQcRMi50hjD/EphH2i8kBJ5cW7EiUUn02KWq5re763wFWia7FBSto0qltqAsCWOB
         V7MnHMdDtxxKGLk3bljKZ4uaYUAOGPa937rtdiI5WjCsC1wrd2vmixvd7LRNnEX128
         LNIVcFMLRoXQg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/19] btrfs: remove checks for a 0 inode number during backref walking
Date:   Tue, 11 Oct 2022 13:17:00 +0100
Message-Id: <9747bdb0d51eb0b2c28b823154ee17f2ebf77963.1665490018.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665490018.git.fdmanana@suse.com>
References: <cover.1665490018.git.fdmanana@suse.com>
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

When doing backref walking to determine if an extent is shared, we are
testing if the inode number, stored in the 'inum' field of struct
share_check, is 0. However that can never be case, since the all instances
of the structure are created at btrfs_is_data_extent_shared(), which
always initializes it with the inode number from a fs tree (and the number
for any inode from any tree can never be 0). So remove the checks.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 4757f9af948a..f4010ce66e21 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1033,7 +1033,7 @@ static int add_inline_refs(const struct btrfs_fs_info *fs_info,
 			key.type = BTRFS_EXTENT_DATA_KEY;
 			key.offset = btrfs_extent_data_ref_offset(leaf, dref);
 
-			if (sc && sc->inum && key.objectid != sc->inum &&
+			if (sc && key.objectid != sc->inum &&
 			    !sc->have_delayed_delete_refs) {
 				ret = BACKREF_FOUND_SHARED;
 				break;
@@ -1134,7 +1134,7 @@ static int add_keyed_refs(struct btrfs_root *extent_root,
 			key.type = BTRFS_EXTENT_DATA_KEY;
 			key.offset = btrfs_extent_data_ref_offset(leaf, dref);
 
-			if (sc && sc->inum && key.objectid != sc->inum &&
+			if (sc && key.objectid != sc->inum &&
 			    !sc->have_delayed_delete_refs) {
 				ret = BACKREF_FOUND_SHARED;
 				break;
-- 
2.35.1

