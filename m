Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802C16F697B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 13:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjEDLEr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 07:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjEDLEi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 07:04:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDE54EF1
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 04:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE131617BE
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03D3C4339B
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683198275;
        bh=uzLa4oy/9aDF2XBfpYIetgYL3KUdJwxmMH5y8gabBx4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iDNbJKXUky9zwrhQLN9QCH/ygd4UA9OqaU004TraqLqVV3KAKxHqruYPh5je0YZ8U
         NXAChSLuPTUo73Ydzlf8vAnme3mtewAR/5f8d7KFD8w+b/WhYd+TFa0Hct43uRRhEE
         bAv2qnwOG6H6m8O0u+fYxYZ8EdVULSQXPuTrgNrW36y6hwnr4BUmgf44w1AcgEjymZ
         3P/KXeTGIOgB1HJehtCU0wW27HMfGASfk/zEI6HcB45XfiRVR1Kf2LAe7x64RPdM2i
         9I3N194pj0OZVslAZ0wL7GcVZORj+1s3HKZaQzmHAOGutzZR0naJkQ9+RtC5I9Quay
         8P2FCFy7I499w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/9] btrfs: use precomputed end offsets at do_trimming()
Date:   Thu,  4 May 2023 12:04:21 +0100
Message-Id: <0a9ca970dbc9d8f3109c0ec25cae3227f4cc7e4b.1683196407.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1683196407.git.fdmanana@suse.com>
References: <cover.1683196407.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The are two computations of end offsets at do_trimming() that are not
necessary, as they were previously computed and stored in local const
variables. So just use the variables instead, to make the source code
shorter and easier to read.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 7d842d356d9f..b16ed01c76ff 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3677,7 +3677,7 @@ static int do_trimming(struct btrfs_block_group *block_group,
 		__btrfs_add_free_space(block_group, reserved_start,
 				       start - reserved_start,
 				       reserved_trim_state);
-	if (start + bytes < reserved_start + reserved_bytes)
+	if (end < reserved_end)
 		__btrfs_add_free_space(block_group, end, reserved_end - end,
 				       reserved_trim_state);
 	__btrfs_add_free_space(block_group, start, bytes, trim_state);
-- 
2.35.1

