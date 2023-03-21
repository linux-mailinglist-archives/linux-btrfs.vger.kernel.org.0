Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654C16C2FF3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCULOh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCULOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788EA3E085
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E11961B0E
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115E9C433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397248;
        bh=5xsOOuE+I4JX5ETf6m3kfOl0goPSyDQbB+stGLkr1rQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MLfBcWUmjzYLcVEkuDYfbwecdITz9mV6+5/TfphhCcaSfrzt0o/Zila2a+tSoQ3aN
         esZf1jMcziLCZ4eDhJoUu5dUdNVQUyLlCig6Jr9ldnpbUCfiz3DB7Na+I4wRpwkiL8
         QIwLHks0lyJ4mfk61BwNvw9vB6oFF4Yq8O/wJj8PDFFadwUe1yiJ197XaV/z27BVuC
         BLtCA02b0dsyfwMMK+ZNnzOflIER8fT5Z14oCOtc2XBHy0jXuZIA26tbm25xLr+WIm
         mFSe6dFz5gnooJrf4AQH5UB2bL2NoM6/7qNgLpupnf2vr1VN2GX2Ju4bb9W5yiE7So
         RYQlY5GFRQHfQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/24] btrfs: update documentation for BTRFS_RESERVE_FLUSH_EVICT flush method
Date:   Tue, 21 Mar 2023 11:13:40 +0000
Message-Id: <5b9ed9c2e2de13fc10236824bdc333e318e47786.1679326430.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
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

The BTRFS_RESERVE_FLUSH_EVICT flush method can also commit transactions,
see the definition of the evict_flush_states const array at space-info.c,
but the documentation for it at space-info.h does not mention it.
So update the documentation.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 2033b71b18ce..0bb9d14e60a8 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -27,6 +27,7 @@ enum btrfs_reserve_flush_enum {
 	 * - Running delayed refs
 	 * - Running delalloc and waiting for ordered extents
 	 * - Allocating a new chunk
+	 * - Committing transaction
 	 */
 	BTRFS_RESERVE_FLUSH_EVICT,
 
-- 
2.34.1

