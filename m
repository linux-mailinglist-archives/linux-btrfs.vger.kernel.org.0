Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAEF69B80E
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 05:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBREg4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 23:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBREgz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 23:36:55 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6343C5EC91;
        Fri, 17 Feb 2023 20:36:54 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id ay25so1661648pfb.12;
        Fri, 17 Feb 2023 20:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g0MutB6M+PkBFIDaCb6URHRakniXWUTPPuj2SeO9isM=;
        b=adq+EHMfgBgzK0zJiLl1tti/KKGlT7tkzLu4y7c3ZrBzV8eWGqP4dNmoxHOl/MN3Aw
         Jd72dd4uLVposgz3moAOqPlQWG/Yv1w+5pYFB0q8mCMJOJMuzclmovvCDo+JrxBlGZvC
         o5luHbUEzST3oTNYEkFBi45M+800qGEkzO6MQn8QIxhzQgcKxo5oWurjYcaGaJh5cgXa
         gj1oxNFa9TdzqNxIubtSeXYlar5uaAdRziCSKZ9C7DOXyNJjrYiU3uAEO6J1DE3uKt1O
         JoGqw54HA2h7LQ07WIus0lO7I3HcaOJsG3hlSFhxwP9d4whmaTF0LCD6bqk3NvtM903x
         ckdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0MutB6M+PkBFIDaCb6URHRakniXWUTPPuj2SeO9isM=;
        b=iSjotriMGtaKKqF5I9XI4WwLNUrFgvG/8fw+4+PSNuZD5SlAaB0fAW/j3En+MfegU4
         QDA9/11PM2vGvS86GGJtTCQYYTAfufrabFfR1oCFLDky+RBjwcvgfgRGru5llEMJJNTt
         Zvm1lJGFuS85KU5W4/5GoDbSzM/tVHS+GGaAiUVuTJeoS0clCQJjRf7q6PebUS87JLia
         u2eC76Vsyb0e6g2g4wfC5qHHs/IhE0zhcnyvz1TVbApOZJTp8KKPsCK807QFq886blW7
         l5I3E17CjYFcQWK+47iiaP00kdCmhTgkkPGXswZJrwIO+kCvFengYz7/i0w4+5Q/XBOJ
         5C8Q==
X-Gm-Message-State: AO0yUKWqnUGkeqQKDY6KX55JoqKhV+/ZpQefre7nML8P4yyndk/Y0iaO
        7XWeDS1JPQ4xJ5FulR/lRXYDK/AQqsGGHTi5
X-Google-Smtp-Source: AK7set9I7ygmjTy7dnVVG+lzZT8W+saVF6JXdKI7zVGXfWm+4LVK9JqwshhZixyNNuCvV38dvjwSJg==
X-Received: by 2002:a62:1946:0:b0:5aa:2d65:4733 with SMTP id 67-20020a621946000000b005aa2d654733mr4363086pfz.10.1676695013833;
        Fri, 17 Feb 2023 20:36:53 -0800 (PST)
Received: from DESKTOP-HHR6EMI.localdomain ([103.116.245.58])
        by smtp.gmail.com with ESMTPSA id m11-20020aa78a0b000000b005a8ba70315bsm3778769pfa.6.2023.02.17.20.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 20:36:53 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        void0red <void0red@gmail.com>
Subject: [PATCH] btrfs: handle btrfs_del_item errors in __btrfs_update_delayed_inode
Date:   Sat, 18 Feb 2023 12:36:48 +0800
Message-Id: <20230218043649.86-1-void0red@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Even if the slot is already read out, we may still need to re-balance
the tree, thus it can cause error in that btrfs_del_item() call.

Link: https://lore.kernel.org/linux-btrfs/9b45f60f-c849-e072-64ef-298937e6a8a3@suse.com/T/#t

Signed-off-by: void0red <void0red@gmail.com>
---
 fs/btrfs/delayed-inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index cac5169eaf8d..88a5d893972d 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1043,7 +1043,7 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	 * so there is only one iref. The case that several irefs are
 	 * in the same item doesn't exist.
 	 */
-	btrfs_del_item(trans, root, path);
+	ret = btrfs_del_item(trans, root, path);
 out:
 	btrfs_release_delayed_iref(node);
 	btrfs_release_path(path);
-- 
2.34.1

