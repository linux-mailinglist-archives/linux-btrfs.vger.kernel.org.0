Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA13534A00
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 06:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbiEZEj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 00:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239088AbiEZEjz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 00:39:55 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AFF8B0AC;
        Wed, 25 May 2022 21:39:54 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id j21so384895pga.13;
        Wed, 25 May 2022 21:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UCUt8Yc7zYDUiimWIGThGkhoILZPhzLlu5O82zOXa38=;
        b=aV/SUigznehnPw3+KhLvXP9GGdbe7fXa3SEr7LmCQRdtBP1BGoPTF7nhfMxRJRPvLG
         chrrAoNA9agcxvcBgPFG7SgaCthYTU1/oVj4DGy2iMzEnAergMIGbGyEMwoCxBQ2TvjF
         vPKWfpoekXDqedNzarkKZrLTHsyLPK5mmiWOMPUTuEDD1HGzjcy71qKbf3WlOCNc78Cy
         3Kfw2xwprpLWqp0Nitvj4/CcrAlhwAwPmhqPu778ox9eTnevytu/90q+Va8eSNv3Juk/
         QIPJSzMM7OlUu35Zn5Vxe1ZHcU52ABuljc0HLW/rhvbTONxloZUyUp17j5oQiW8I6o8M
         +nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UCUt8Yc7zYDUiimWIGThGkhoILZPhzLlu5O82zOXa38=;
        b=aBO/pGdb7Hg/1LpHORlHl8THhh+JNIOTjIQT7OoYo9/Lebwsl1zk7aBc/oymhmMdVR
         M2Yf+BEQ90wuqfEVrZPBV/V9hLau/48Puss+fJBV6rsDxx7//UKOpYDg/ZR+j0LSS89b
         IqS/Z21rrYI7FBMCxLgnu9kK2H0n6a50Ial1KW6xttcb+6jgWvSjPH4uXLhmrnIZlOBn
         F20yS2h3fs6pvkadVnee4I87YYXAEWlb5xInvILN8XR5bLsQLt9q7kGGNrImogX5BWmG
         KvaSDOVII1LN47j03ek8Vt+0d4VIUvXlPbtKzI/Q7jy1xZOSTF/ZW1wGny/np9D7Wc6S
         2yFw==
X-Gm-Message-State: AOAM5333sWgvntKiwsoJI8CH4Tqq1O5Y16CLfq4JfxRhaWuDBkpc3x99
        17wscPTvLbmaCxDsOAk18SBCaJJv8eyJzw==
X-Google-Smtp-Source: ABdhPJwPQn33e+P+y+ZoWsJAfI6MEG3HH+rRAybs8v8pNTXPZeJyfPF5jt7DA0zh5OepjFLZPdXIRg==
X-Received: by 2002:a63:225b:0:b0:3fa:beab:211d with SMTP id t27-20020a63225b000000b003fabeab211dmr8387174pgm.350.1653539993959;
        Wed, 25 May 2022 21:39:53 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-22.three.co.id. [180.214.232.22])
        by smtp.gmail.com with ESMTPSA id 200-20020a6304d1000000b003f9eacd0684sm450834pge.3.2022.05.25.21.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 21:39:53 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: add missing function name in btrfs_log_new_name() kernel-doc comment
Date:   Thu, 26 May 2022 11:39:33 +0700
Message-Id: <20220526043933.315937-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel test robot reported kernel-doc warning:

>> fs/btrfs/tree-log.c:6792: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Update the log after adding a new name for an inode.

This has side-effect warning when invoking kernel-doc script directly:

fs/btrfs/tree-log.c:6957: warning: missing initial short description on line:
 * Update the log after adding a new name for an inode.

These warnings above are caused by missing function name in the kernel-doc
comment of btrfs_log_new_name().

Fix these by adding the function name into short description on the comment
block.

Link: https://lore.kernel.org/linux-doc/202205260024.TLEp6Pj2-lkp@intel.com/
Fixes: d5f5bd546552a9 ("btrfs: pass the dentry to btrfs_log_new_name() instead of the inode")
Cc: Filipe Manana <fdmanana@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 370388fadf960a..d25cbe61fdb669 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6954,7 +6954,7 @@ void btrfs_record_snapshot_destroy(struct btrfs_trans_handle *trans,
 }
 
 /**
- * Update the log after adding a new name for an inode.
+ * btrfs_log_new_name() - Update the log after adding a new name for an inode.
  *
  * @trans:              Transaction handle.
  * @old_dentry:         The dentry associated with the old name and the old

base-commit: babf0bb978e3c9fce6c4eba6b744c8754fd43d8e
-- 
An old man doll... just what I always wanted! - Clara

