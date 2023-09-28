Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA607B1168
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 06:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjI1EHA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 00:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjI1EG6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 00:06:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA40114
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 21:06:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A4422189A
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 04:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695874014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtHmf0QkLCLyoKqPM0eJBrZecBdygHV/7/TgCcdG6xo=;
        b=h/PbB+zbJxZlmGoXe12jZO9UurkloGe98Oz6yOlCy8VbjaGD1Nwi4NQUJblz4C8mMWgSpE
        w5qeqCFSDd3MVkxeKHmaVLMN8LeXnt3GawJNuYjMQbY2SJzvlbPR5hLFClhoAr+F30cCkJ
        oVPA78fXySRcq6OPFN2ppifEwxv6Jzo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C22C51377A
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 04:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IPabIN37FGX1RQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 04:06:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: remove variable e from cmd_inspect_list_chunks()
Date:   Thu, 28 Sep 2023 13:36:33 +0930
Message-ID: <c01c5f2ec4a967a893f754870df436e01b6525c8.1695873867.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695873867.git.wqu@suse.com>
References: <cover.1695873867.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable @e is only utilized to record the errno from ioctl() call,
and is only for the error message.

We can go with "%m" to replace the usage of variable @e, and remove the
variable shadowing, as later we will declare a local variable @e with a
different type.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/inspect.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index ef928895fa08..50f1ddc745a6 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -1026,7 +1026,6 @@ static int cmd_inspect_list_chunks(const struct cmd_struct *cmd,
 	int ret;
 	int fd;
 	int i;
-	int e;
 	DIR *dirstream = NULL;
 	unsigned unit_mode;
 	char *sortmode = NULL;
@@ -1114,9 +1113,8 @@ static int cmd_inspect_list_chunks(const struct cmd_struct *cmd,
 	while (1) {
 		sk->nr_items = 1;
 		ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args);
-		e = errno;
 		if (ret < 0) {
-			error("cannot perform the search: %s", strerror(e));
+			error("cannot perform the search: %m");
 			return 1;
 		}
 		if (sk->nr_items == 0)
-- 
2.42.0

