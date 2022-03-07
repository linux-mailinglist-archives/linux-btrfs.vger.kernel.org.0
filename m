Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE1E4D0B27
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245210AbiCGWef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbiCGWeb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:34:31 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC79C7
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:33:35 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id e22so13256322qvf.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lr61Sv0M01HeSDAcue594ByYQqn5r0iSrzEAJeA3L5g=;
        b=XlSZJxfle6Sel7SOc8zuWSIvnH/EURAfDbZ0Co7/z8sg/oMMc9bTysGm9y0l7V0kJF
         SBk/UAK975SsTlKGa7ZJjgB0mTEEOakAZicV5ujpfj1FQkb65fv2bI+qpsg/VbiYA7Lm
         M8SHtDlR0XiS6mNkDfq2t+Awk9Sc2/uFjL6lqOnbKg6C0QWfM125Sbwk3nALKlvulMCn
         Ts/y7tUwpkvBKC6A1+2DzC7Frg437Btmrw+zs58C50IYMiVwIe9DHmDVvaBr9dmsJBn6
         dY8yzzslw7Gw5CYsIv9sXwQsMj+2CddkbYZvu6dr1E3KFttEUtQG+zxB2uJ9nd9Ve3Ny
         CwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lr61Sv0M01HeSDAcue594ByYQqn5r0iSrzEAJeA3L5g=;
        b=mkEd0k7uhFACoz6R7uArM3kvC3ixv3phNBhiU9ONcrvK2ISMTKQ8Tiw1N8E/B2h64K
         sjgacHmrTmgVPkfu55aXI5PvKIqPSt0g3eDUfte17KKpcFDpD5PoSeu8UIdKd+gezfxq
         BNtHxZLftovmieTNZxGn3SDz+ty6WH9qXEhXnIOwUvIckUQ845KggIhkUNUQwco64dFH
         gJmpn6BG5w9/bhGLadYtLP0NSq3PHhCyM0vpBlqsND/HA/Rs70OqIqcgsuqpFRVuII0N
         jvZNkShUn3NDxn/AnZ2J5CIc7ZcZeNftWAXM75mof7qlsM1ujwYlC0sWpO+SKeQ0zCtE
         W9Jw==
X-Gm-Message-State: AOAM533V7yPXmcjKYdEcVGGndmTJMRUDqNsxMPN28AcUFL2iVWbXLOtO
        w6BtrDWhvpIoyLrAkEjOOqeZKlsTJpzmSSKv
X-Google-Smtp-Source: ABdhPJx+xltQlEtIgO44JbNizixCMGN9NZvOY4OTfUiEaB9LF5OsdkKWbMa2ppgpCrl8qY4V/Xnv8Q==
X-Received: by 2002:ad4:5dee:0:b0:435:90eb:dd46 with SMTP id jn14-20020ad45dee000000b0043590ebdd46mr5190814qvb.112.1646692414198;
        Mon, 07 Mar 2022 14:33:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x26-20020ae9f81a000000b005f1916fc61fsm6630434qkh.106.2022.03.07.14.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:33:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/12] btrfs: move btrfs_node_key into ctree.h
Date:   Mon,  7 Mar 2022 17:33:20 -0500
Message-Id: <61428a739b3c49e2dc024b7f4019670429073e13.1646692306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692306.git.josef@toxicpanda.com>
References: <cover.1646692306.git.josef@toxicpanda.com>
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

This is randomly in struct-funcs.c, well away from all of the other
related functions, move this to where it's family lives.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h        | 9 +++++++--
 fs/btrfs/struct-funcs.c | 8 --------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 29e0e009267b..819bd8631c4c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1998,8 +1998,13 @@ static inline unsigned long btrfs_node_key_ptr_offset(int nr)
 		sizeof(struct btrfs_key_ptr) * nr;
 }
 
-void btrfs_node_key(const struct extent_buffer *eb,
-		    struct btrfs_disk_key *disk_key, int nr);
+static inline void btrfs_node_key(const struct extent_buffer *eb,
+				  struct btrfs_disk_key *disk_key, int nr)
+{
+	unsigned long ptr = btrfs_node_key_ptr_offset(nr);
+	read_eb_member(eb, (struct btrfs_key_ptr *)ptr, struct btrfs_key_ptr,
+		       key, disk_key);
+}
 
 static inline void btrfs_set_node_key(const struct extent_buffer *eb,
 				      struct btrfs_disk_key *disk_key, int nr)
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index f429256f56db..7526005525cb 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -161,11 +161,3 @@ DEFINE_BTRFS_SETGET_BITS(8)
 DEFINE_BTRFS_SETGET_BITS(16)
 DEFINE_BTRFS_SETGET_BITS(32)
 DEFINE_BTRFS_SETGET_BITS(64)
-
-void btrfs_node_key(const struct extent_buffer *eb,
-		    struct btrfs_disk_key *disk_key, int nr)
-{
-	unsigned long ptr = btrfs_node_key_ptr_offset(nr);
-	read_eb_member(eb, (struct btrfs_key_ptr *)ptr,
-		       struct btrfs_key_ptr, key, disk_key);
-}
-- 
2.26.3

