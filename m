Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118B766882C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 01:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbjAMAL4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 19:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240159AbjAMALl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4B05D6BF;
        Thu, 12 Jan 2023 16:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46976621EE;
        Fri, 13 Jan 2023 00:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50897C43321;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=u2HBlljfPn8Ri/yAwyLtuZNtCtHOAcW5KH7Mkb084Zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S02HWytAsHZnBWpX/Nh0sql12ycvEfPCpERqe0tpOjZIIDAMeQNTh1pm3WADHpvAZ
         FiQUlMf7+D1alQORWKjoq3oeIvZr/Z0w43a2ufpRap5JtP6a1N68p4sfxiFWRfIWkK
         74vIMqj5WxmIw27fVl6MuocLZG94SH/wtagiYay6G4P8vi/J63WaebjJN9ZtqtSjD1
         RDuTNYZT0YRktzdxf1F2rU+nSVZFmaTFFulGljSVXpAnS35W8VD/hS0QcQsthe8bby
         7vPavA/Q0YmIPASeNMOtG3YGAtuwrcrmkOFH/y6/Jw6LYr4wEmlNbw8PanyJuyDx29
         ZUI2a7n96oAeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A84175C1931; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 10/20] fs/btrfs: Remove "select SRCU"
Date:   Thu, 12 Jan 2023 16:11:22 -0800
Message-Id: <20230113001132.3375334-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
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
Acked-by: David Sterba <dsterba@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
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

