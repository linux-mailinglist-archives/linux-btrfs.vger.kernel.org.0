Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030AB7879C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 22:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243631AbjHXU7Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 16:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243683AbjHXU7I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 16:59:08 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDE81BD8
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 13:59:06 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d7484cfdc11so285862276.1
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692910746; x=1693515546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FWdXIunGDLRKMN75NKo0EpEeoRsvcOII5ntqlucJjRM=;
        b=42rsz8o/6adb7stYtBZ52/EfWsj37+/i/mUHSdpMRrs4fOr5gA2jYIXEMPmofkB4k5
         Q7zRAKVMHpgYzwhnCY9EcTGlE4sqqWpemXvnh3iYWWxQU965egto8SGwCRA5gEzPD2s3
         TJIOsFJLEHXjb7RL0myEjjzW962KMktHRWIS31h2NDCxTmJnG0ci34FkikC6+dVIi8k7
         7tVCySgik0uM7aGOTTFDZybh+p8kTCK5CNTQxCXnMvLs7pNiGi9nkugAgIWBanRdLu5J
         zZxJTwcMY7GWiKYFzsMA2Yfv8zQIWM7Sal9rS1ICj8q1jeyu935lSgjYYpsgbwJtwS8F
         gwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692910746; x=1693515546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWdXIunGDLRKMN75NKo0EpEeoRsvcOII5ntqlucJjRM=;
        b=QobdsOpu+E2q+L0Js/XjRFIBN9NJY5g3DFo25i6+7u01xADYWEl+2CkueWJexMom3l
         28BUFvP7JygBqNC5Dd4V0QtpV5gTyfxOM7gjSnhIFbTMN4TlLIQcJOlxuWt/S4u0PUBv
         EK4l4cX56q86woY2gjweV/AFzFuKTXIePulLVgTz0c/AFfP36ur26nWc5T3f957TDTDp
         ej08lfLgQXAeZQ+EJyZFsZ6/q64wm47R9k6tps3RTLN0tNuYOZG5nVKZTtHPYhpCq2On
         DqQn4QAmvVtA5qb4XsSDX9eRgsad8nhBpnHJBsRJvpTOLDbW/KMbPTbuR4WTEI20LjqE
         M4SQ==
X-Gm-Message-State: AOJu0YwXUwrtywyDsKbH1AL3aez2dAEdYIzp3GAZzZY+fqVj3saTdKSw
        DKfk+ZxNok36lkct3RFLFhm7elBNt3VKt156se8=
X-Google-Smtp-Source: AGHT+IGXUxIHqnY9uHOnU8Nr91aJAM32xvWpPz7ZaVjGa2cM44H7V5XGyrbMfK5LCDnwJrSmG6YPxA==
X-Received: by 2002:a25:4fc6:0:b0:d78:98f:4aa1 with SMTP id d189-20020a254fc6000000b00d78098f4aa1mr2454270ybb.7.1692910745748;
        Thu, 24 Aug 2023 13:59:05 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t14-20020a255f0e000000b00d1dd5c6c035sm49076ybb.62.2023.08.24.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 13:59:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: check for BTRFS_FS_ERROR in pending ordered assert
Date:   Thu, 24 Aug 2023 16:59:04 -0400
Message-Id: <c640ee0669c4454488d2ddacbc3a93884c905b38.1692910732.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we do fast tree logging we increment a counter on the current
transaction for every ordered extent we need to wait for.  This means we
expect the transaction to still be there when we clear pending on the
ordered extent.  However if we happen to abort the transaction and clean
it up, there could be no running transaction, and thus we'll trip the

ASSERT(trans)

check.  This is obviously incorrect, and the code properly deals with
the case that the trans doesn't exist.  Fix this ASSERT() to only fire
if there's no trans and we don't have BTRFS_FS_ERROR() set on the file
system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ordered-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 09b274d9ba18..69a2cb50c197 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -659,7 +659,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 			refcount_inc(&trans->use_count);
 		spin_unlock(&fs_info->trans_lock);
 
-		ASSERT(trans);
+		ASSERT(trans || BTRFS_FS_ERROR(fs_info));
 		if (trans) {
 			if (atomic_dec_and_test(&trans->pending_ordered))
 				wake_up(&trans->pending_wait);
-- 
2.26.3

