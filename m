Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC98654C9CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 15:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353351AbiFONaE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 09:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354150AbiFON3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 09:29:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140E542EDA
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 06:29:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C9E9121C62;
        Wed, 15 Jun 2022 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655299778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/b9QMrvKOz+Tv1M34JTyuVETa7jWPNtKR6oL1InhQGs=;
        b=tdOP76EJklHIKKhH4UVGWWL4hiBuYgWG2yUMKedULvCoCES7B3p0eHoA/dq85YLrTTytWS
        L8naAIgZ6NwiO0YCGRM3ZnGi+LuDkKNT49zd+GBZNvzjY2a/AVZCWDxMujzv2Mn+8civvC
        5hrTgneLKaLSROmoC5U4MaSdMYYQ65A=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C31802C142;
        Wed, 15 Jun 2022 13:29:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 830E5DA85E; Wed, 15 Jun 2022 15:25:06 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/6] btrfs: send: remove old TODO regarding ERESTARTSYS
Date:   Wed, 15 Jun 2022 15:25:06 +0200
Message-Id: <00c674ac373f6f96b91c557f0f9782932462c273.1655299339.git.dsterba@suse.com>
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

The whole send operation is restartable and handling properly a buffer
write may not be easy. We can't know what caused that and if a short
delay and retry will fix it or how many retries should be performed in
case it's a temporary condition.

The error value is returned to the ioctl caller so in case it's
transient problem, the user would be notified about the reason. Remove
the TODO note as there's no plan to handle ERESTARTSYS.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d8d4f062cd4f..f6469c7666c9 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -580,15 +580,10 @@ static int write_buf(struct file *filp, const void *buf, u32 len, loff_t *off)
 
 	while (pos < len) {
 		ret = kernel_write(filp, buf + pos, len - pos, off);
-		/* TODO handle that correctly */
-		/*if (ret == -ERESTARTSYS) {
-			continue;
-		}*/
 		if (ret < 0)
 			return ret;
-		if (ret == 0) {
+		if (ret == 0)
 			return -EIO;
-		}
 		pos += ret;
 	}
 
-- 
2.36.1

