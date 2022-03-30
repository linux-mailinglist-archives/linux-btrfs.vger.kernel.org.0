Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03E54EBD67
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 11:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbiC3JQC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 05:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244671AbiC3JQB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 05:16:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B130925281
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 02:14:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 705691F38C;
        Wed, 30 Mar 2022 09:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648631653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mJjs8VIroH8BmCOq+Q4evy1B3lKLNj1LWYl7PUNLeZs=;
        b=AWaORKktdmWD3vnJ/SI1AkFcJFxzjKUW6LIHuS4IgxB+Ix5+71QVxFOE7X3aZkl4wA5JKo
        3XgqSQdUxbHs915zbgpHAcxoQBNdoe3ybZjKvrohjzQCcLmrV162OcgV6UMal30HW60lRd
        Pplg4z2nqUlR6Y+/xZZMiFd+r3rsfsM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3132113A60;
        Wed, 30 Mar 2022 09:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mKEhCWUfRGKiVQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 30 Mar 2022 09:14:13 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: remove balance v1 ioctl
Date:   Wed, 30 Mar 2022 12:14:05 +0300
Message-Id: <20220330091407.1319454-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220330091407.1319454-1-nborisov@suse.com>
References: <20220330091407.1319454-1-nborisov@suse.com>
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

It was scheduled for removal in kernel v5.18 thus its time has come.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ioctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9e81c8c5000c..fe00dd88c281 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5459,8 +5459,6 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_fs_info(fs_info, argp);
 	case BTRFS_IOC_DEV_INFO:
 		return btrfs_ioctl_dev_info(fs_info, argp);
-	case BTRFS_IOC_BALANCE:
-		return btrfs_ioctl_balance(file, NULL);
 	case BTRFS_IOC_TREE_SEARCH:
 		return btrfs_ioctl_tree_search(inode, argp);
 	case BTRFS_IOC_TREE_SEARCH_V2:
-- 
2.25.1

