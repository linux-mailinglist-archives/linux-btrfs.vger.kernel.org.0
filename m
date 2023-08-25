Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3234C788FBA
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjHYUUM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjHYUTr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:19:47 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECDF19AC
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:45 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-48d0bfd352eso618720e0c.2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692994784; x=1693599584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sC8vKC1MdrtQTH/KdS7qPHtYBd4gWs5JdzeemEzBpyc=;
        b=O1kw8SZ5trQNFLJ0jGTv1bHlnvwh3t7vEBO/o1WIMY6O/wOjubjZXVqV/offxDgPQj
         +stQsaYf5thuxy/mx8wMnco2zZo62qe1q7jH4claanqMLeem3Wyk8jl6vcVcgHrFV1h/
         f+RqEvwNEpyJMnQqzbOZ/GQqrfS3fhSKFXTqSwOV3Z1KxYOw9yi3Bs4K5U0NlBFSYq6f
         cd9ZsfBQ4QCzP7g3n80EwYE1ErYzshkNDhCQbHOsWFXk7BPTWL2FS+gAic2bfMwTr8jq
         pzzgO3b3Vy2Yfqs71CJVFaoQu4XSAS6EHOEHxhr2PjnDOF3eXsK5+DWuZKmvrJLWisRn
         dWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994784; x=1693599584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sC8vKC1MdrtQTH/KdS7qPHtYBd4gWs5JdzeemEzBpyc=;
        b=IrFyg5kVJxApPJoX2FOD2ccO+wrqNkhrVSawIVe5QsqgBfGQA60Jc+j5a9C8gNEgAD
         4QyS0LH2GN049J4ABdYnLCOU+jjkM/PgQkjI7pF/mokL2REkyVZoGuXEGBDoNX1GH03K
         ib8BAFCYFNZaXlGCKneVEmQyW5Vn1FuToX0CbX5egAFC8PYIVz5M4KiH3WKdKeiAuCts
         wkWgpcXU0hnv2v2Q/kRFDsttb40sf3R4X7l0jw3Hk3aa/yn/EYp9ge4WDIv1KQeujl54
         u87KxYkf8b5a47/UrFO/JPDlwIEAC3f+jFlaFnK8O/TJ34szaEvxYlXGDEIoFffwgCKk
         wDNA==
X-Gm-Message-State: AOJu0YxtWNLwwpvCSbOC9FA+rSBlzjb/OP2AMYAt/HZLwFPBAs3gKU+3
        zAj0xxEpC5p82hT/lrHjrh6KuNlFJD9NpbDN4hY=
X-Google-Smtp-Source: AGHT+IGMu8Id2/HFzNXPVXbQaupB9Adp+W1SL+F+56f9wcxFuVzUyZoFGScVZh3DQQK4NMCSvlBKow==
X-Received: by 2002:a1f:4c85:0:b0:48c:fb34:cf92 with SMTP id z127-20020a1f4c85000000b0048cfb34cf92mr17857220vka.5.1692994784098;
        Fri, 25 Aug 2023 13:19:44 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n5-20020ae9c305000000b0076ceb5eb309sm733583qkg.74.2023.08.25.13.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:19:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 06/12] btrfs: include linux/crc32c in dir-item and inode-item
Date:   Fri, 25 Aug 2023 16:19:24 -0400
Message-ID: <6dbf325458ee1c2fc45a66779fd5a277d4f39810.1692994620.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692994620.git.josef@toxicpanda.com>
References: <cover.1692994620.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now these are holding the crc32c wrappers, add the required include so
that we have our necessary dependencies.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/dir-item.h   | 2 ++
 fs/btrfs/inode-item.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
index 951b4dda46fe..5db2ea0dfd76 100644
--- a/fs/btrfs/dir-item.h
+++ b/fs/btrfs/dir-item.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_DIR_ITEM_H
 #define BTRFS_DIR_ITEM_H
 
+#include <linux/crc32c.h>
+
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 			  const struct fscrypt_str *name);
 int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index 2ee425a08e63..63dfd227e7ce 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -4,6 +4,7 @@
 #define BTRFS_INODE_ITEM_H
 
 #include <linux/types.h>
+#include <linux/crc32c.h>
 
 struct btrfs_trans_handle;
 struct btrfs_root;
-- 
2.41.0

