Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A68773988F
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 09:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjFVHyh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 03:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFVHyf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 03:54:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8011F185;
        Thu, 22 Jun 2023 00:54:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f122ff663eso9407844e87.2;
        Thu, 22 Jun 2023 00:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687420473; x=1690012473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eie20f3ss91sUplEeIPYPp60+FBbWFR7xGUasT7bn5c=;
        b=qU/htB9JCiIHSUq3832RTd4+lIgZfeF8QP6ZVgo8g2sL/eKmb9cmuAqZbJRiKehPHI
         UycnuBYxKb4jQ+BQkGlV27c/8esqag2xF5U+5Nb9P2YLNwR1Zyfv4Cr4pyC0rCmCc4bJ
         6XpkL4bMJYgZraUYCKsb5YjhIGv645+/ksLNnhMoBj1+C2IjBwNm2c6SaLV4qrks3JxU
         xKJ/0U6r0HzQwHuZpV4sTS5T/reiQcPZvxgKp9LKr7ro13w/UHfSG85idp805/PIApIR
         dNYTRsyw6yo8UFGEclCjQD6qG0HZk3TQB4vzdZzLpp2j2aBnPWNwZTLDMM+tOgGAhYOv
         HTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687420473; x=1690012473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eie20f3ss91sUplEeIPYPp60+FBbWFR7xGUasT7bn5c=;
        b=mADkof7/TJ8GMJB495//UfgHvPsfZ+gIl+3BjFwHQiDUJP26z5D6aNCCJclO3yzZib
         oMR7/iGGSOmAet+fGGHzqFCFxZoAf34RdV9RC+lYsUfXQzHkrpr9i59xwwRbNBoisM0R
         2MLdAeXhmT4i1AYoT9JnzM3/cRWQtMAlUEK5rUbDaM49uLudwR+iJtHNT4AWlc3awuX7
         AHM6TePZCYNyP+tNZAaapMCyXT2DisnAokDDDBn/KRKF+a8j4X/mtPJmiBlYfXHLNuva
         8oT7KDDIcXrTU63YhtZFj24p+z90ZyS8nKHqOjhHLQCQro694QL0sRxgDWTBRjdcPB2M
         nF9Q==
X-Gm-Message-State: AC+VfDwvjhHNcqF6EMdo7Q0wliltQWpqxr/4T9qoR5WiatIAXtwm1maW
        0T4PvU5k1inw6fCayQJCmhg=
X-Google-Smtp-Source: ACHHUZ5V7PFqhRZ/OooYKSnOyIwbW2Sb1pABO0QSB8jezdhTlqu529QtFTTjTxqbWUqUscCxwLjHbw==
X-Received: by 2002:ac2:4d84:0:b0:4f8:5ede:d457 with SMTP id g4-20020ac24d84000000b004f85eded457mr7913343lfe.55.1687420472453;
        Thu, 22 Jun 2023 00:54:32 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z12-20020a05600c114c00b003f9b4330880sm6985723wmz.29.2023.06.22.00.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:54:31 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: remove redundant initialization of variables leaf and slot
Date:   Thu, 22 Jun 2023 08:54:30 +0100
Message-Id: <20230622075430.2794134-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variables leaf and slot are initialized when declared but the values
assigned to them are never read as they are being re-assigned later on.
The initializations are redundant and can be removed. Cleans up clang
scan build warings:

fs/btrfs/tree-log.c:6797:25: warning: Value stored to 'leaf' during its
initialization is never read [deadcode.DeadStores]
fs/btrfs/tree-log.c:6798:7: warning: Value stored to 'slot' during its
initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/tree-log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 365a1cc0a3c3..8ad7e7e38d18 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6794,8 +6794,8 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 
 	while (true) {
 		struct btrfs_fs_info *fs_info = root->fs_info;
-		struct extent_buffer *leaf = path->nodes[0];
-		int slot = path->slots[0];
+		struct extent_buffer *leaf;
+		int slot;
 		struct btrfs_key search_key;
 		struct inode *inode;
 		u64 ino;
-- 
2.39.2

