Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6745463D9EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Nov 2022 16:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiK3Pva (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Nov 2022 10:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK3Pv2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Nov 2022 10:51:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF24A1AF2E
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Nov 2022 07:51:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CE03B81BA1
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Nov 2022 15:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5335C433D6
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Nov 2022 15:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669823484;
        bh=COfELNE2Y8TIWSikWBf7Jxktu99H1Ubk1LGM57Ol6vk=;
        h=From:To:Subject:Date:From;
        b=dXDCWZoPYSn1kLmW9nXdr6nYEUYBYwRAhTNUO4LpEdJygSCGv/eS9xDH7qeSpZuBP
         OPceVlWFeXalq3Z94/cT6TAkuSJHaMUHbPLjh/2/fC9O4vUUJ19h951W8/aKhaANyh
         c9VkFnss/WOCWh9rUSjTwIEdIVEyI1T2/PkNi1WdM7JazhH7QEllNDVSkqkEGYT2fJ
         eEPaw0FHG1dlTbWy/RaSAzVfZ+69y+j/33YCkrzbNkqcrPC4hpt9+EdwRawob78zw0
         Lxbma40QakMXc+65Yl6TY7J3sjCPPOms7X67HO7WySEB8tWoj9ih1mUaWP7t6x9668
         BIHCqbcs319yQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: print transaction aborted messages with an error level
Date:   Wed, 30 Nov 2022 15:51:20 +0000
Message-Id: <06fd62ae08b2206c5243f8f5f4811ec488633f08.1669823310.git.fdmanana@suse.com>
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

Currently we print the transaction aborted message with a debug level, but
a transaction abort is an exceptional event that indicates something went
wrong and it's useful to have it printed with an error level as it helps
analysing problems in a production environment, where debug level messages
are typically not logged. For example reports from syzbot never include
the transaction aborted message, since the log level on the test machines
is above the debug level.

So change the log level from debug to error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/messages.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 295aa874b226..84694a3601d9 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -197,13 +197,13 @@ do {								\
 			&((trans)->fs_info->fs_state))) {	\
 		first = true;					\
 		if (WARN(abort_should_print_stack(errno), 	\
-			KERN_DEBUG				\
+			KERN_ERR				\
 			"BTRFS: Transaction aborted (error %d)\n",	\
 			(errno))) {					\
 			/* Stack trace printed. */			\
 		} else {						\
-			btrfs_debug((trans)->fs_info,			\
-				    "Transaction aborted (error %d)", \
+			btrfs_err((trans)->fs_info,			\
+				  "Transaction aborted (error %d)",     \
 				  (errno));			\
 		}						\
 	}							\
-- 
2.35.1

