Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8646B5A669A
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 16:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiH3Osj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 10:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiH3Osi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 10:48:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D8BFC46;
        Tue, 30 Aug 2022 07:48:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id jm11so11311946plb.13;
        Tue, 30 Aug 2022 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=PzFydKNwJFrQJTDHNguIpkAiPm6m9rG7392GYNGhqRM=;
        b=hR7lNPvcJsuJ4wkmpQauiVWOOMK4TDxwDPY897qZj8FyJClUmDDPvR+9pwBQZGenNJ
         JtBXbKWPXnhp4lahN5rHGhZEncnLARBvXEeUSVZ9OjF9+V2MYUAi2Cc4BLnFiRBxE483
         dYjVd26A5NCDf3l6s28eGk43gLZamecwAbgMe0URV7VW4u5bY3VzVZy6CkGxmSlU0wAe
         iejBP6L+Eev8s7QUIEUSoQx8w9mNTydTAh83DcwIuGCUA5FOqQnoreIAh+SViGsm6y+z
         v/VIqA0Jn9uyX/LW4TW4RhozUXIy1OPzibiJzgiUTfpkFrQsOQEfGwXCLm8PgYLk9Fx5
         IyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=PzFydKNwJFrQJTDHNguIpkAiPm6m9rG7392GYNGhqRM=;
        b=2QF3rYkUWZjf/JnwenZI3z9JpQe95X+t0h2ML+SmjC8l0/IDwmqSxure+TOzRFjVrB
         U5Uyc5I0X1KFZXgOTsxDR4NlMbk9o18MAqTue8wVV/ATBFD8GmhwEChHhpqAXen1UXOM
         dgUbEkiNydcqYl4S8Gj8cUdXzkcAp9f+9Cn9JbqpRGVhzX5GkqyuL3FZNv1jorJPLwpe
         6ZQ859xCoUg4tFGHOBHQBGYhV8siv7XrMed6bUAFRAmyn++I39fMN62gpOpP96WmVnVE
         lvE2AJq3F/e69kIMkJdhmZ2p02+7GvkApwWNri/zXWx5d+/cuuRtmBV8gAtKXfc2685o
         C2JQ==
X-Gm-Message-State: ACgBeo185aefeKQuhqLqcr7GV/k2ELgoc6ia5GvFop3Wu4rcxy2eD5jg
        fckhXz13ffw9QJYYWHP+VLpPdJU/BC4=
X-Google-Smtp-Source: AA6agR7Bpn4pRWGzH75l9rWYc/G3Y8PcuvLog4ycJEOKfM+z/mQxBS97LNbCFrNyluKkEqi1kgJE1g==
X-Received: by 2002:a17:902:ccd1:b0:172:5c49:34be with SMTP id z17-20020a170902ccd100b001725c4934bemr21125748ple.23.1661870917172;
        Tue, 30 Aug 2022 07:48:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b00172c7dee22fsm9762718pln.236.2022.08.30.07.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 07:48:36 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] btrfs: remove redundant variables ret
Date:   Tue, 30 Aug 2022 14:48:32 +0000
Message-Id: <20220830144832.300092-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Rturn value directly from iterate_object_props() instead of
getting value from redundant variable ret.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 fs/btrfs/props.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index a2ec8ecae8de..055a631276ce 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -270,11 +270,8 @@ int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path)
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	u64 ino = btrfs_ino(BTRFS_I(inode));
-	int ret;
-
-	ret = iterate_object_props(root, path, ino, inode_prop_iterator, inode);
 
-	return ret;
+	return iterate_object_props(root, path, ino, inode_prop_iterator, inode);
 }
 
 static int prop_compression_validate(const struct btrfs_inode *inode,
-- 
2.25.1

