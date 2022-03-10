Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6544D3EBE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiCJBdB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbiCJBdA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:33:00 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C0C127562
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:32:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so3867598pjb.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lkGU+fQLDepGxNyY48PCeZGfV2D6j0kdpBqJ1hGxlL0=;
        b=aUTIkChkg1kB8+Wg8FssXl93i/H3qLBzUnX1RgGjto4PLWIzJnykO6lWVeBVayGvh2
         +Y3CNMhEfrzEl7QP45et/YpnOaqI3GutUJqiIAIBLWrt0eALO68gbh5EGqdtgeb1gaMP
         GJOrBYeUs0TOrRSUkqEUVHvmVXdTeHyV8+p266PcqpyCfLWo9FO+K/dGhC1KGwtykbnv
         ajoVKkBGtv0wmO7cC1sdgtuQAg3slk3nVNvfbc08Qnkpv2AVjoU0tNuNfaIQOsaLunHs
         fUgUbwpPopVPa4RqnDt+mMZqqpUZmY/iSp6LfQNBhwPGyjbP4N/b0NIqXUZjGJnXxHRK
         auWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lkGU+fQLDepGxNyY48PCeZGfV2D6j0kdpBqJ1hGxlL0=;
        b=b3cS6CIrYpZe/yizyNoeJQ006u1IcPGuOUQ9AyvU6XzhI6CeVGTEwtyCIn9JJS2xTH
         iwepF2buOqxX9M77VFKUGb5RHAYAADDGDS4HUuAObw0oGwmUf0oldtKBj7PnzllALrwz
         TYf6J7vlPrldcoAV1AeY+gXsq9bTnKEt6TL9GcZe3Yu/1o+MGCd4Z75oPRjcvtei/K3X
         sOwJ74lCPnedW+jAxiYa8m2uuKAe4xozTR/E43q9kfX0mtx368XR/2/ShNal//LZeFnA
         i+9CqDdoT96PruVNbRDJ1yaIP/B8MoScsXUUqsOH0HYJfywvWF7t41VkmCfelqJnLXLi
         wS4w==
X-Gm-Message-State: AOAM531cDZSOcG91X+3hgDMcI8AbD27GE8LuidtgGgHIHwkRz72Hjqq5
        +P9cWfhM5XWBpX427rYreAeGdIDFqQRMOw==
X-Google-Smtp-Source: ABdhPJxx8rWpFlJrt+r64GVo2HlCSZ3Lfvb7+LMK6zhhG8lvGPhQXqv2hRUtFZLrqDWXj5yGrO8+Rg==
X-Received: by 2002:a17:902:ef4c:b0:14f:7548:dae3 with SMTP id e12-20020a170902ef4c00b0014f7548dae3mr2638634plx.92.1646875919304;
        Wed, 09 Mar 2022 17:31:59 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:31:58 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 05/16] btrfs: remove unnecessary btrfs_i_size_write(0) calls
Date:   Wed,  9 Mar 2022 17:31:35 -0800
Message-Id: <723552bc3d3a123224c2b0e65428dc4eff86187c.1646875648.git.osandov@fb.com>
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

btrfs_new_inode() always returns an inode with i_size and disk_i_size
set to 0 (via inode_init_always() and btrfs_alloc_inode(),
respectively). Remove the unnecessary calls to btrfs_i_size_write() in
btrfs_mkdir() and btrfs_create_subvol_root().

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9c838bdd51cc..244e8d6ed5e4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6606,7 +6606,6 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_fail;
 
-	btrfs_i_size_write(BTRFS_I(inode), 0);
 	err = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (err)
 		goto out_fail;
@@ -8787,7 +8786,6 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 	inode->i_fop = &btrfs_dir_file_operations;
 
 	set_nlink(inode, 1);
-	btrfs_i_size_write(BTRFS_I(inode), 0);
 	unlock_new_inode(inode);
 
 	err = btrfs_subvol_inherit_props(trans, new_root, parent_root);
-- 
2.35.1

