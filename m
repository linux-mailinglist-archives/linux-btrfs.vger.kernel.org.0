Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71CB65E1C6
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 01:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbjAEAlM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Jan 2023 19:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbjAEAis (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Jan 2023 19:38:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975F9C27;
        Wed,  4 Jan 2023 16:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 702AE618A8;
        Thu,  5 Jan 2023 00:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF58FC43392;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=uNGdCXg8tvhFdD75cJKP+MAi0FVpcft3pRlEy5ToqTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZK17cdKWfyVtVbBELFi9PU3XxQufZKvLED9pEgVpPrNMvnpDMWnsBYHi7ynpV/aO
         +F1WRjWAH3B4lFWJ9xzguuL+NSeLcGmx0+79sbBbhwiJP7THgQIbF8jyGiZBGMo4vb
         RcDKz8ZE5vxNCVtUW3ynX7IN7KObRCV9/T6VFdbUJ7raVEo2Sqvar9SIoxf4jWnMRC
         c9BRbkwgJPLOexgZPo1+cRQK8ZegZBMrwgERaxVCUSgtDjlwBh48lrxapLRSpVK4Rs
         njuuVU843Vj60lInbU92N+cMN3nVlTaPbZp2gfeU4eAz6I4ujjghZRqIU1SpJtjDqZ
         3y4si+uPWMhsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D65C05C1C9D; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH rcu 18/27] fs/btrfs: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:38:04 -0800
Message-Id: <20230105003813.1770367-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
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

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in selecting it.  Therefore, remove the "select SRCU"
Kconfig statements.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: <linux-btrfs@vger.kernel.org>
---
 fs/btrfs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 183e5c4aed348..37b6bab90c835 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -17,7 +17,6 @@ config BTRFS_FS
 	select FS_IOMAP
 	select RAID6_PQ
 	select XOR_BLOCKS
-	select SRCU
 	depends on PAGE_SIZE_LESS_THAN_256KB
 
 	help
-- 
2.31.1.189.g2e36527f23

