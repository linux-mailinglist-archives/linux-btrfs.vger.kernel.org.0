Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E2A4D0AB4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbiCGWOa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242973AbiCGWO1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:27 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384B56405
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:32 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id b23so14592762qtt.6
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g1k6fvupQRPsKtQl0U0MVvdLQYtbuCeLFIES5SQNQHo=;
        b=tYIFHCz+gTD3RBupAwhlha+FyxPKr+n0RqnwtWHJcK4iXAwqdnMW9GAiCGDbYirQTN
         J5Wl2UBQ+5ceHDpU6A3H6sgeMVw3joPFowsdA9s0syXrEfxLBjXvyRWV2c6JBTlxQGjl
         Tv/rQzl6V9/AnKNXePo17Qa3IB00BxVe6X1ZewvMHfSV7Qs3oicN7HJ9j+AZ7SW7mCmZ
         Luy4z8GPT2sxP9splN/34/n/XHvenD2L1COoCGgMbdVNHBcz2DrF8OF4mdhcfODxk3mr
         Z8d60uGgzPqR6RPtjIX7qIaD9deqS2Cc9rYmWaK6B8jWIwX/0iz0ODfhVRbGZRO5tJDH
         6M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g1k6fvupQRPsKtQl0U0MVvdLQYtbuCeLFIES5SQNQHo=;
        b=8D55fygI36t2XgPsQJ88Sz7I1rqfg5vnMCu+Sv6NX4YCW2GgZLxvc59lViU9EUZXO2
         DrUGyo6vHpJZgsi19UKjvNg9x4ekF8x1Ah/2uGhEdSHInYvXQOenu1LgxVvCzXWEFTuj
         r67nkZcGVT6xLSCT4GV/ehlziTkJGkxBJINbbdbeFL+/RO9/IJw2rEqB5VJwb2PVaf0Y
         pZ/K7p7CaCRPwaMDTa3jkzekk7dDD4YBWBUJPzWVrzE0hKhF8E74nM3ydKCDD1U12NuE
         wxUwcFjFs+FJU2nlv6Ocs/xUCIsFct4FUo8fEmyQd60O0HQEy+XmXLEOz5KO7uB7Bbiu
         ZwEw==
X-Gm-Message-State: AOAM531vwJ+wST2xW61eu0lDtDYInjrf91v9a8ErhF6ECMDj04P2AwSf
        LGp/8jtQEIOH3mwEqOLw3zOVBf5AMniXXhUi
X-Google-Smtp-Source: ABdhPJwRS9sewY+WcUSVMtqEAh5+jSmINByXCAugTLsl8/0hTkSVzBhTsb2DZ8LOE2vGRJbCWIKBXg==
X-Received: by 2002:a05:622a:196:b0:2e0:705c:35b2 with SMTP id s22-20020a05622a019600b002e0705c35b2mr229167qtw.567.1646691210885;
        Mon, 07 Mar 2022 14:13:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 7-20020ac85747000000b002de73a851ffsm9593898qtx.89.2022.03.07.14.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 06/15] btrfs-progs: check: update block group used properly for extent tree v2
Date:   Mon,  7 Mar 2022 17:13:11 -0500
Message-Id: <a2bed9aba2b557ef349ce04082a75d18bd396219.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
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

For extent tree v2 we do not have metadata tracked in the extent root,
so every block we find we must account for as used in the appropriate
block group.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/check/main.c b/check/main.c
index 5fb765c5..aab6b3a0 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6425,6 +6425,14 @@ static int run_next_block(struct btrfs_root *root,
 	if (ret)
 		goto out;
 
+	/*
+	 * Extent tree v2 doesn't track metadata in the extent tree, mark any
+	 * blocks we find as used for the block group.
+	 */
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		update_block_group_used(block_group_cache, buf->start,
+					gfs_info->nodesize);
+
 	if (btrfs_is_leaf(buf)) {
 		btree_space_waste += btrfs_leaf_free_space(buf);
 		for (i = 0; i < nritems; i++) {
-- 
2.26.3

