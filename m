Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619D25A9859
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 15:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiIANUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 09:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiIANTt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 09:19:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DB4BF8
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 06:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4261561F32
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33186C433D6
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662038314;
        bh=l6lrCUsQTAcFFyxiwTppIFO1W5We04eRtRNcwxuzPkg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UeyJCxCRBhY8Wbj/Uq9sVB3vjXPjbIokQ3h/L/Xpnu3CtRKR2qWsl/Yo1JctpS9V7
         RE0QZeEz3VTJWBh4w/j2XktHwhaIMfM2OkSewA7BB5+OTqXW/9nujmI8Hfmka6kMB+
         rMsjQRkUz4iWEeUjeXamX5o7oVRCw5TDkYQbKpTXMdDGb2QflbNJLXNj+d4aatkqnQ
         y+kgi4qXqe4eNJsV5LwAiA4YVrRTr4qyygUElOdykFqHwflN8P6K6unoGggbFjJNVI
         PJyrWLBVtsg88uS8mtwMSZDOGX6xd+9ZZ62JWSvOXOtyNi272JT23EN2Tj14TisJMM
         HiUTdxz8h6/iA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/10] btrfs: allow hole and data seeking to be interruptible
Date:   Thu,  1 Sep 2022 14:18:21 +0100
Message-Id: <29ac2c59860774abb16bfb2660e0dd831d793cf5.1662022922.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662022922.git.fdmanana@suse.com>
References: <cover.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Doing hole or data seeking on a file with a very large number of extents
can take a long time, and we have reports of it being too slow (such as
at LSFMM from 2017, see the Link below). So make it interruptible.

Link: https://lwn.net/Articles/718805/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0a76ae8b8e96..96f444ad0951 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3652,6 +3652,10 @@ static loff_t find_desired_extent(struct btrfs_inode *inode, loff_t offset,
 		start = em->start + em->len;
 		free_extent_map(em);
 		em = NULL;
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
 		cond_resched();
 	}
 	free_extent_map(em);
-- 
2.35.1

