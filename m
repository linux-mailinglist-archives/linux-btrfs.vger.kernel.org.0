Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AF74D0B40
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbiCGWiM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343826AbiCGWiB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:38:01 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B256158
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:37:06 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id a14so1735393qtx.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Kp8haNt8W7FtV8s7XxnXs5TAFxLTzFbEVH7jBn3WtV8=;
        b=6wb/CSruXFrhX3huC6yinjHXnYVbdk0bqvIg2Tb+em5IUwBvoHVFy45ZDQQ6M60+Sh
         Hxiqd0o+/R/vUa6DRW4Ssje4qjgsVv1MYDrpRHux17zJUjNbis+Yj+Onzx2rkYU0VAEO
         8SRbJgOIMZ1jPez2er5Vu6ZLG7ozg5O8i87j1pCer/hFk3B9U2B7O4eET7s1S2+Aeilx
         Rk7Xcbo2PfQWVBLSTduwazKruaMkWNpKqoDYeeanIGUlnb/GBbFr2EN8elg4DJ96D0bZ
         eCTfK9/8Bdmep6Bv7Euz2T3/x1xKJ0ci/DaLkYJnlYJI/j0kWeP9KOAROWjPLEsG71cL
         IO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kp8haNt8W7FtV8s7XxnXs5TAFxLTzFbEVH7jBn3WtV8=;
        b=jgn/DAnT7rq79Os+gGOOdXvEVjxIRokZzSuwx4XUDT/fhD9Cv+Dc8p961DBHiUHZKB
         wlLLT+Q3nNK/JIcBjcAJuoljyos7kzKBBzCLP1WKMyhLgy+1fK25aIzAZY2SHqNwqlNf
         T1HaPeoDPyJLDMto3fmU61UFJH5INX5a5Y51kWaAS7moewdS0Rjmt6mvDscVcN+W3bqZ
         bYrNC9O1wv/E77wfwfpKKNq7DvCwQMOj8rr/u9aYZAwo9z3cM2gduxtmr2NqLR1RIahe
         SzhSexWj4TPk4JrHVuczle+7NgS84LdlvK/7Il6+/yEFIysjSwUG2Ge8wFiZKLTYXeXF
         KBEw==
X-Gm-Message-State: AOAM533WVVAU41UqfKojmEh7CiItq8ehuaw2rCqVZQJ07mbMMfduUxyH
        45k846nZfEfcqThFOocDUOEfAhItn0a0B0vJ
X-Google-Smtp-Source: ABdhPJxhHtmKx9KCmwYEeJcukoVoer5NCIMz98R+sIY7nf9hKKuWa3fCu8c43TrDOe+r6eS1baOjTA==
X-Received: by 2002:a05:622a:1055:b0:2de:3ea:f2ad with SMTP id f21-20020a05622a105500b002de03eaf2admr11158178qte.327.1646692625448;
        Mon, 07 Mar 2022 14:37:05 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x185-20020a3795c2000000b0060cb44d7eb9sm6822824qkd.11.2022.03.07.14.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:37:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/11] btrfs: add global_tree_id to btrfs_root_item
Date:   Mon,  7 Mar 2022 17:36:52 -0500
Message-Id: <4c2cd74a4cd9b3b8918741ad4fde28b0693fa232.1646692474.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692474.git.josef@toxicpanda.com>
References: <cover.1646692474.git.josef@toxicpanda.com>
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

This is something Dave asked for in case we want to limit a subvolume to
a set of global roots.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h                | 2 ++
 include/uapi/linux/btrfs_tree.h | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b1cc1d34944a..222c5dda9079 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2412,6 +2412,8 @@ BTRFS_SETGET_STACK_FUNCS(root_stransid, struct btrfs_root_item,
 			 stransid, 64);
 BTRFS_SETGET_STACK_FUNCS(root_rtransid, struct btrfs_root_item,
 			 rtransid, 64);
+BTRFS_SETGET_STACK_FUNCS(root_global_tree_id, struct btrfs_root_item,
+			 global_tree_id, 64);
 
 static inline bool btrfs_root_readonly(const struct btrfs_root *root)
 {
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 92760ea4b448..cd62ca1950cb 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -682,7 +682,11 @@ struct btrfs_root_item {
 	struct btrfs_timespec otime;
 	struct btrfs_timespec stime;
 	struct btrfs_timespec rtime;
-	__le64 reserved[8]; /* for future */
+
+	/* If we want to use a specific set of global roots for this root. */
+	__le64 global_tree_id;
+
+	__le64 reserved[7]; /* for future */
 } __attribute__ ((__packed__));
 
 /*
-- 
2.26.3

