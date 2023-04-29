Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835336F264C
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjD2UUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjD2UUJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:09 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD64E7A
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:08 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9a7e639656so1970255276.0
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799607; x=1685391607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90TVpregLfTN8aIVCSeAhQNQKYWfvkrvrWKSEVNGrho=;
        b=HduhfxSzxERqtCrYmRRuV7+JuquIRPY0sI5rFjAd2yZHrCnUDERtpRuFgOeUQCmSVg
         yL0PyJLA2il1LcP+KRV0txLoRL4Sl/SE/0obO+R6txhimDtSOvIDCvMaX98rI7ZJRSzr
         Ju3d+gxDTooS5JE4YbVGJbxh1TXc7sE/eAg/6lQhBhHuY+Ow3YKVmI5g0H/3HzI6nbM2
         1UuZX4HCqtYYLCnBzRZsWpb6LhOUZvZWFPS8qvBKU+qSh2J/hVhyv0pl+o55SmJOz8o0
         HDa7tQ2cNwz/tFQR+qTPD6GP0w9ce27RnTAvsVbSZeXLVuO2QsTFRAla35mRvxMU7fxT
         GyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799607; x=1685391607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90TVpregLfTN8aIVCSeAhQNQKYWfvkrvrWKSEVNGrho=;
        b=Y2yZmoEa8DYIh0H1Y2J5l98f0gtYg+Z9PM838V7X8knuClHiOo8zGZeyLBl3wf80GT
         qlIIUkoSE6jb6nABOR6snr5RXY47FiDEc5kI/gWzjDLCLhvNaGqMdvw6TpXRdfE3qNGo
         NbvdIdtkutCr1RKbaXyoXFKNM6X8WKYv57PDsIkpSHoZrsbkeFx6bmSRBMQ6A1CfhQJb
         cTCy9RwcO19H9/zsVzhakVrwDVUHQWx32fkwmGwjcCOQPyJpbExgzZYfW+NJn9C1JI7S
         3Uu53ixMNriqZ0Nza60FL8J0dt0LsVBLx6elj20Y+xLsdWvr981KswbYAU4zGteF7xUB
         6hhg==
X-Gm-Message-State: AC+VfDyMVsItCiK2hYa28TbXXIDOhLuJ+oW2f/iTtph4KtqNor74U6VO
        w5P4myTEq8fno0xtxTLIxLGBUesUqt3dhmXoaHYfQA==
X-Google-Smtp-Source: ACHHUZ5JUdx87BEIciFIxm56nnWxuaCqqla/JponFEliOk4jYLnNImAnOK0YAnZIo89Ntq9cgwZXtw==
X-Received: by 2002:a25:f801:0:b0:b9d:9fbe:e83d with SMTP id u1-20020a25f801000000b00b9d9fbee83dmr2460828ybd.29.1682799607277;
        Sat, 29 Apr 2023 13:20:07 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c16-20020a5b0150000000b00b96ae6e1f57sm5844312ybp.41.2023.04.29.13.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/26] btrfs-progs: remove useless add_root_to_dirty_list call in mkfs
Date:   Sat, 29 Apr 2023 16:19:33 -0400
Message-Id: <ff68c401f848ac47437f047c9797c9e695affb2c.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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

We are calling this when creating the UUID tree, however when we create
the tree it inserts the root item into the tree_root, so this call is
superfluous.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 4856cf96..418c721c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -789,7 +789,6 @@ static int create_uuid_tree(struct btrfs_trans_handle *trans)
 		goto out;
 	}
 
-	add_root_to_dirty_list(root);
 	fs_info->uuid_root = root;
 	ret = btrfs_uuid_tree_add(trans, fs_info->fs_root->root_item.uuid,
 				  BTRFS_UUID_KEY_SUBVOL,
-- 
2.40.0

