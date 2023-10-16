Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5486D7CB24D
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjJPSWP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjJPSWJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:09 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F48E1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:05 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9beb865a40so1286876276.1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480525; x=1698085325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KUH5mNaG/0p3sTE3eYcJAqpZYp281vwXEU6Fc+b6FA=;
        b=lnXYc92OZQ4PZ20+ruIXGxUlXSOk//qHrO355299QcIG49ES8XhebXzLIC9h1fK5+d
         a+ax2zxeyZUAXaUU7SjNVrdxWWlfyNAIRl1JR5MZsMiZtBwmWBH7Ua8oJmNKTwJSnu/F
         8OIg109nd5n+vL+2c68HnH05ojry2+xhf8iA/CvoiqbkKxMm8rra2i1t/c1lIddLBX8p
         XNGsPJlTq/UibnUUYpRN6WuW9W+LAdz11VS+lbuSsjZ777iQTjrV5AOW2d6EHsrAcxOl
         pza+uVWk45A4A3jzMbFLGiiGC/5Ea1fyOFVjIIgnASSb+ifIzuZBbu9QgpK9Bw8KpkWZ
         P9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480525; x=1698085325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KUH5mNaG/0p3sTE3eYcJAqpZYp281vwXEU6Fc+b6FA=;
        b=FFaz7+psV3X29lF2QCvgt2Qw7ciAi8DxCDHiVA8pQSahwisyW+xNuOrcoJ0hx9LGH0
         5HQH+5K32/Kva/U7/siWphtjuZEefEhjDDTGMiMN1kLc9F0n4DwxGJaqwf4H0xEr4d68
         PRZgppdrrtsyVUQ+iUR4mkAUWJZxcS145L3f8TWE5qVGU8dBJBQoWqs+T926ur3kUMq1
         E4Fnodd/NuAEIY/+qzZGRA8Yecb6BFy6IWlEL0yqXJNH3IpUQoF309PROTckhYC65CRu
         G74owU3kjy9TGJLe8vexPrbd2SdenM9KfK81MPqgkiRiXJXvP66rykHI3A1Q0PI4ScB0
         juKw==
X-Gm-Message-State: AOJu0Yz/fzc3p5C2SFWS42loBv8cUV1B+8EUVzgDheXAfNvKHaR/irpI
        3fC0hK2jFl8DCXvwdyPEiPn+K3pwTravTChbRIDBhA==
X-Google-Smtp-Source: AGHT+IEu3pLQjT6cHD0v62jFaTeeh9TWZiH+cl4ZqbAYKkeTWTLpo9kdtD5kC30Q64Rl5aOCCXjMYA==
X-Received: by 2002:a25:abe2:0:b0:d9a:5ff4:cfde with SMTP id v89-20020a25abe2000000b00d9a5ff4cfdemr18718827ybi.13.1697480524716;
        Mon, 16 Oct 2023 11:22:04 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cu19-20020a05621417d300b0066d1d860cd1sm3664880qvb.19.2023.10.16.11.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 07/34] btrfs: disable various operations on encrypted inodes
Date:   Mon, 16 Oct 2023 14:21:14 -0400
Message-ID: <ffd8f8000e51846d68900c89c601163832d2056b.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
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

From: Omar Sandoval <osandov@osandov.com>

Initially, only normal data extents will be encrypted. This change
forbids various other bits:
- allows reflinking only if both inodes have the same encryption status
- disable inline data on encrypted inodes

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c   | 3 ++-
 fs/btrfs/reflink.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c9317c047587..4806ff34224a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -630,7 +630,8 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 	 * compressed) data fits in a leaf and the configured maximum inline
 	 * size.
 	 */
-	if (size < i_size_read(&inode->vfs_inode) ||
+	if (IS_ENCRYPTED(&inode->vfs_inode) ||
+	    size < i_size_read(&inode->vfs_inode) ||
 	    size > fs_info->sectorsize ||
 	    data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
 	    data_len > fs_info->max_inline)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index fabd856e5079..3c66630d87ee 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/blkdev.h>
+#include <linux/fscrypt.h>
 #include <linux/iversion.h>
 #include "ctree.h"
 #include "fs.h"
@@ -809,6 +810,12 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 		ASSERT(inode_in->i_sb == inode_out->i_sb);
 	}
 
+	/*
+	 * Can only reflink encrypted files if both files are encrypted.
+	 */
+	if (IS_ENCRYPTED(inode_in) != IS_ENCRYPTED(inode_out))
+		return -EINVAL;
+
 	/* Don't make the dst file partly checksummed */
 	if ((BTRFS_I(inode_in)->flags & BTRFS_INODE_NODATASUM) !=
 	    (BTRFS_I(inode_out)->flags & BTRFS_INODE_NODATASUM)) {
-- 
2.41.0

