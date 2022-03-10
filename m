Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78D4D3EC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbiCJBdD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiCJBdB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:33:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696971275C9
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:32:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v4so3901286pjh.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UAO9DI3ccYAZkKeASeStB5YXc4pmhDQ2ItZ8HxAquoE=;
        b=CBqQRHNeC7rrOW5A2n9jjyGNLkOTRYb5BxQ1MzAl1d7HCohpe4roLbfGfnCxOnCcl1
         eROPvZh1Vg1PEIwHFKQQrcob6F41DqLk0KeYmozPMui3fRW8W+DuND8GgzjGCl9LWvsk
         PZeQm7U+bGi9zwNpsM586fGnG+xCLqdxeAUYplKJNgOls1YzOLdaYfoNuJGvFoNvl/ve
         iWzvAUHNg/+PIJC/mz+yu0W7snJPdahWIvzckSsZo1ZE/k9pLMkTYmNc6duVelaYRkOd
         N7Ch6kzSxd7XHLO1Aejq6VUMUJkCa8AiWHd+Tea9d63zAVB8X4GI5Lh0DVMiAmiZNYat
         zXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UAO9DI3ccYAZkKeASeStB5YXc4pmhDQ2ItZ8HxAquoE=;
        b=ohuyUrDDs5cmQZyawXsaM5wdP+hBhESwPeb2FvxWX925gd1KFZj6mLdzq3a0s0XcZ1
         EBvqfeoeT1+qdDlGlAs7KU78o+h1rlrfGS0jrvBB9UrqCor6VP38MCf213v9dcVBXwZ5
         lvFKnUsev8D4ZcVGjRexx0pBnj8UAYe13Sbl4G8ahud2k8s0uUtoLtmdPSbd627lVu8j
         N5nG0UvXygcrE8UggR0UQiza+tR5qDwbBMpDakjzf8VkAa6yGCt65hENDzqG/7ht9Ckj
         TFm1JY7cWGWPaQzvY6nQKhuLzRY6lStYWNQL56rtMNSwyMLJ/WSeidrnyn7UeIi5C8JA
         2H5w==
X-Gm-Message-State: AOAM530EvzPuv+fRvKIkzs4FU/lx4Ftad4WNRy8at+DBr2+JtQCxdAJy
        6osTufUmt+RWYMAA3r2BKU8NRWkAPYD1xQ==
X-Google-Smtp-Source: ABdhPJyKqRb92ZbdrnE43bi0lO1Pys0PQfSHm0z3+Q5zDKu56Hgl5WQGVv1tg9JPNmLo3CnzNZyyWQ==
X-Received: by 2002:a17:90a:4146:b0:1bf:2dc8:7407 with SMTP id m6-20020a17090a414600b001bf2dc87407mr2485588pjg.76.1646875921575;
        Wed, 09 Mar 2022 17:32:01 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:32:01 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 07/16] btrfs: remove unnecessary set_nlink() in btrfs_create_subvol_root()
Date:   Wed,  9 Mar 2022 17:31:37 -0800
Message-Id: <730b3ec34d95183a96d28f96fca02bf35933fd95.1646875648.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646875648.git.osandov@fb.com>
References: <cover.1646875648.git.osandov@fb.com>
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

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
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

