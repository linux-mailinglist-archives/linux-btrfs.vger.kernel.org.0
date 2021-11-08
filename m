Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D98449C72
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbhKHT3w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbhKHT3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:51 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66BBC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:27:06 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o12so14754234qtv.4
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J4aEi7UEyMDuRI9iLfK303jBVNtNAxZ970yVDmdvG/A=;
        b=BMAx5F7DBLRicyO4CyGC0FOveo4NVdjI0mVlZOtiB5dgNX7zmG7YHUhK8bRlgM26pH
         5QPa9noBEq0MKFqMsKXk+x9cHShe874FjIrmoAydcnu9fISqq9sTbAclb1Im9buIYU8e
         4SiHFnQXhMu4ERC1p+xVQ6M8+5eqy/jqkNYw9qdVy+pkJM5FnoJIK1DJJuGpbzvxlA4s
         +SbMbsPLGfZ5sA+U2tUc45ji8lfdi3LznqYl5TD1/ILNqCTocNINaByi5sZHBxkxiAjQ
         Jizpdmc2mg2un0jCEMZqKoAZLwJplVEX1yEgRXdB0nNfeWlNjtRcLTtNvbSDnKInHO70
         1Erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4aEi7UEyMDuRI9iLfK303jBVNtNAxZ970yVDmdvG/A=;
        b=dC00vUTsZzLvACrndn4667PDm4ezJsWcuRJYMTnBvDQbzXBAnDXl8zHE5pwtFc1sDA
         H2h9NZ9zQp57rVaGR7ca5I6gFS2ODMWdGqc8JsOJQX5yGqGRb07AwPM90BWdLrLSac9z
         efinyxj9oOE5r8uJGsWzQ106lnMYl7wYIFtnRHdSkcV76xZ4E+9snj7BlqwTUJhNQmJR
         nVRgxnpeCLWdrUD546uj0w52DBZZWqpL+ZpftybGVphP3P4dHc4Qk0b4UPaHC+vc6CUm
         mXDamv94bLzROlX+ClBCOyT0jbYUMClxpjl6mX7yeCBxLzl5U4So92sVWNl0ku5qvjqf
         so7g==
X-Gm-Message-State: AOAM530u7fRrdfB0jVH48nK9jiF9UN8Bdw7EjFkrdkiLnfySQYJknmkP
        G54aR5WyYTtCBM4mG8ywgqeB4GEsYGU0zA==
X-Google-Smtp-Source: ABdhPJxcY6yC9M8dzVYkKck+zixHEcVbEj/mD4FbRHUqaoy2xaSJkfHdiCOU/bm4RFs7dbu5+N/r2w==
X-Received: by 2002:ac8:594f:: with SMTP id 15mr2048647qtz.354.1636399625908;
        Mon, 08 Nov 2021 11:27:05 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e10sm11032246qtx.66.2021.11.08.11.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:27:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 12/20] btrfs-progs: mark reloc roots as used
Date:   Mon,  8 Nov 2021 14:26:40 -0500
Message-Id: <3522955e6ec553004c70b3a46318f566170f8f57.1636399481.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_mark_used_tree_blocks skips the reloc roots for some reason, which
causes problems because these blocks are in use, and we use this helper
to determine if the block accounting is correct with extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/repair.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/common/repair.c b/common/repair.c
index 7ddecc42..c53e988e 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -87,10 +87,6 @@ static int traverse_tree_blocks(struct extent_io_tree *tree,
 			btrfs_item_key_to_cpu(eb, &key, i);
 			if (key.type != BTRFS_ROOT_ITEM_KEY)
 				continue;
-			/* Skip the extent root and reloc roots */
-			if (key.objectid == BTRFS_TREE_RELOC_OBJECTID ||
-			    key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
-				continue;
 			is_extent_root =
 				key.objectid == BTRFS_EXTENT_TREE_OBJECTID;
 			/* If pin, skip the extent root */
-- 
2.26.3

