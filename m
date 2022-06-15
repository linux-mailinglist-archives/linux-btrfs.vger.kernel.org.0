Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40D654C9CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 15:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352791AbiFONaA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 09:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353786AbiFON3u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 09:29:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B634162D
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 06:29:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 932A621C62;
        Wed, 15 Jun 2022 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655299774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJy8DE3f/9+xy+fICZognYx9WOIVwJBGWKXJWuM5PII=;
        b=Q0WaA6NkY9VlLgvoH+meQROQ0bxY8N/Cq2DRI6GSrrwhcZi2vHK1Gc84Uc1B+dupzvSIv8
        O2b+sKfvdOFQQ0f3OQKSz87e3CxAI9Zw15Wb6sNWJm6qzXP4Sncntbn/EinW8W7tl+UGq+
        r3aa+ShAmQoLbH/7OqwknrGyJBm0JkI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 884E52C141;
        Wed, 15 Jun 2022 13:29:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 425FCDA85E; Wed, 15 Jun 2022 15:25:02 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/6] btrfs: send: drop __KERNEL__ ifdef from send.h
Date:   Wed, 15 Jun 2022 15:25:02 +0200
Message-Id: <36b430b7217448a6e70d013cca647624698a989f.1655299339.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655299339.git.dsterba@suse.com>
References: <cover.1655299339.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't need this ifdef as the header file is not shared, the protocol
definition used by userspace should be from libbtrfs or libbtrfsutil.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index f954ce6f17d8..2cce43ddcad5 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -161,8 +161,6 @@ enum {
 	BTRFS_SEND_A_MAX		= 31,
 };
 
-#ifdef __KERNEL__
 long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg);
-#endif
 
 #endif
-- 
2.36.1

