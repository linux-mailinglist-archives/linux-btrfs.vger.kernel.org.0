Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A868C4CC9F7
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiCCXUS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiCCXUO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:20:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF5C15F090
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 15:19:27 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so3776171pjb.4
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 15:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oz1oNqIfMm4Cmy4YhvA49X206rRkGkJIw0ay+dbHTpQ=;
        b=uwdTwMBuKVSy7bQk5Yjr935Awtku5OyCOrUXT6Hh1QZc7DSxmMBG0c6apgCVBaO5q2
         T5CJRKdF7l+Sa3GrX8YIirisnNgbsVakN7QKt6O6i71FySwhjiT8OWnEmphctYk8i7oK
         2DaS+CejrYpThxPuHcpZmFkkhk1mZD/ompmMe5M8CJOnhtD0SsjMRNdZJLx5leGW7lo2
         Pl7VF1bm9givr0dilnkm5sbtMENdUhJ1nV71rs4+KED/rEaITggfYmEBIxnuFsAiHw99
         slOfS7XKZW30v0UMog8zEkWTS2NZYZSBI+LvfxZBH+nvKEmXWtKZBut2feVPw/UyhxVT
         Rmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oz1oNqIfMm4Cmy4YhvA49X206rRkGkJIw0ay+dbHTpQ=;
        b=NL7t/8m2iyxeS46vS0Y3nWoNkcJGlvY42SrjGJw8zUbO2NxSm9nT0ARsBlRFc2KyC4
         hg+FI7BnyAnJFs/lHnElqMIhuXuqoq79OFLnrBfn//Z1aMdDlluMNgZ79gVQPqisVtYL
         DPqYUNuROy2m8I3gTG2NHN5UtDnycLTuFbgolGWxYqcTWEHwPVGVnbh4lkldms7ciVCg
         UoVcGKPY3NzdTHrL5fEmN9e58Q30lVEfgUo5KBxzKzGau0pPGiS/XSxznB3fOda2jGyz
         +DiLvLSXcHl2V/D5AeOaogYfRUqYPXl8C8WSCiai/pBQKLcfAaZovT9BTRpc81eixvF9
         vEgg==
X-Gm-Message-State: AOAM532j9iqZ8IKq2M1N2/UpkT04te7r3ybiswxYX2hBYuLqF53TgO/w
        yOoMLpwz8BzMvdcNYCN29iGZw+4XRK/h7A==
X-Google-Smtp-Source: ABdhPJxqMMQsJhXoo8QpA7O1O7jCx6WbOsGWu8TUAVzFRJNxeSGueXGD+LJuFNPN+vjPbIC97Wrmrw==
X-Received: by 2002:a17:902:aa84:b0:150:8d6:bdec with SMTP id d4-20020a170902aa8400b0015008d6bdecmr37956806plr.118.1646349566533;
        Thu, 03 Mar 2022 15:19:26 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:76ce])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm1103507pja.23.2022.03.03.15.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:26 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 06/12] btrfs: remove unnecessary set_nlink() in btrfs_create_subvol_root()
Date:   Thu,  3 Mar 2022 15:18:56 -0800
Message-Id: <d8a5ee9219d8a61072ad322e5dbdf44054b4bb8d.1646348486.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646348486.git.osandov@fb.com>
References: <cover.1646348486.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

btrfs_new_inode() already returns an inode with nlink set to 1 (via
inode_init_always()). Get rid of the unnecessary set.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b7d54b0b2fb5..a9dabe9e5500 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8784,7 +8784,6 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 	inode->i_op = &btrfs_dir_inode_operations;
 	inode->i_fop = &btrfs_dir_file_operations;
 
-	set_nlink(inode, 1);
 	unlock_new_inode(inode);
 
 	err = btrfs_subvol_inherit_props(trans, new_root, parent_root);
-- 
2.35.1

