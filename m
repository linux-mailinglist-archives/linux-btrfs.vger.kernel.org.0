Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0689A436AF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhJUTBE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 15:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhJUTBA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 15:01:00 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67A1C061764
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id i1so1427156qtr.6
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RHmaQJq1KRlSSuSQUPMcqrY1JoLz+D48dOJNipw4lV8=;
        b=nS8BeYFhusw9EK35e1Ec8mcjWB9wZBOtorPZtbTMlwSZ0pVf9M/DYYl8XK/QdSIGHK
         mtxEvkMsXflT+IXtQFL7aRdHuimvncWzH7DpUqht8tMH1sfbk+6yAvdsG+cfORZLj2Qk
         eMZEVikUe2/ivSnTJ5+s/DPFR0lr+CXGfRLET9ca1Pvs0+8Z3ghQ9KlNitU7Engiv9r2
         XqsNqwX6iord8+YWn6pZgLroOag/9uHlmWOeUnZBZx/OHuT+JlRKtppgqLvMFA6936cC
         iBASMjzD5h0AyNDiT5FVnpaOC1lotr49KfmCHHvsyEGfDEfd8fCtDYbz6VoqrwFOJGXO
         9rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHmaQJq1KRlSSuSQUPMcqrY1JoLz+D48dOJNipw4lV8=;
        b=R4/YRGRyalI4UR7fD+SgG1tomDEgzWLdxzFnRXMKfyF9tClYTwRucpwSeu1ApFE1Vu
         hFYsubSaPFGe1RXqgmq9HiEFWAY7DE3ycVaj+xDs60FeSysjtI3rWRKFPwb92XySIHWA
         GUug2bqrtCU4yWp7M2OhzHbRr7LC6T34Xudh25bjD8o2JQw5ZSYMyi6UYfZFi7LueHIP
         2/WW3vxRX6PaBQz+C5fljYZApLSU+KdZrJl1uY92q1vRlGznjAGGAHHpkaWAAkZYJ0kd
         ruXhYqLQbcmJiAWMXcxzfc54CqIyIEZVGLIkzZW0z9ZKelmjTWKkKtV4+YtdzF+Njs+v
         cRAw==
X-Gm-Message-State: AOAM533htsBesu9LXwtdS6HXiAH6bN/UhRhp1BQpgI+hS/SnZ0tEZgV0
        xnipL1vvUmxegTLuCyiPb7up4ZYSVMTwKQ==
X-Google-Smtp-Source: ABdhPJwXz1ax3ji4IWJHwHxIpYoVLspEDaVlkr1nj3wmFla9liBcKzB8oN6PN8gNb/bHZe43zPBZhQ==
X-Received: by 2002:a05:622a:1992:: with SMTP id u18mr7892004qtc.234.1634842722803;
        Thu, 21 Oct 2021 11:58:42 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q8sm3271332qkl.2.2021.10.21.11.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:58:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/7] btrfs: make btrfs_file_extent_inline_item_len take a slot
Date:   Thu, 21 Oct 2021 14:58:33 -0400
Message-Id: <e4f180d23d2d0ed9a3c7ac122d4f0d07a64afdee.1634842475.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1634842475.git.josef@toxicpanda.com>
References: <cover.1634842475.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of getting the btrfs_item for this, simply pass in the slot of
the item and then use the btrfs_item_size_nr() helper inside of
btrfs_file_extent_inline_item_len().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 4 ++--
 fs/btrfs/inode.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 69c04636e605..e3c523da64b6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2522,9 +2522,9 @@ BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
  */
 static inline u32 btrfs_file_extent_inline_item_len(
 						const struct extent_buffer *eb,
-						struct btrfs_item *e)
+						int nr)
 {
-	return btrfs_item_size(eb, e) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
+	return btrfs_item_size_nr(eb, nr) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
 }
 
 /* btrfs_qgroup_status_item */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3032893efee5..d76368085b9e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6999,8 +6999,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	WARN_ON(pg_offset != 0);
 	compress_type = btrfs_file_extent_compression(leaf, item);
 	max_size = btrfs_file_extent_ram_bytes(leaf, item);
-	inline_size = btrfs_file_extent_inline_item_len(leaf,
-					btrfs_item_nr(path->slots[0]));
+	inline_size = btrfs_file_extent_inline_item_len(leaf, path->slots[0]);
 	tmp = kmalloc(inline_size, GFP_NOFS);
 	if (!tmp)
 		return -ENOMEM;
-- 
2.26.3

