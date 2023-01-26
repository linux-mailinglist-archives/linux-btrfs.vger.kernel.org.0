Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493BF67D717
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 22:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjAZVBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 16:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAZVBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 16:01:10 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F182036474
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:04 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id m26so2400736qtp.9
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwdnYcIiWi7wHi2bXU/Fk7/olRy/K+ncT86VsG5nZ9o=;
        b=dQ72jJbfdA296BDHhKL8Utno7XtXzSf+heK+rKl+qrYuId6E3Asmtxwz2o5NJQlW5t
         NOCTbwVVgPnP43RKTYu56jOnI4S2VwtJstlMQcoVdG5+Nbda6tQwtFKl575k1nCxTyo7
         fRvAMjoUmaUlrTeHIh59XAfPuUKfRLpa2NqD7h+OphmsJEzuPCG7x1aUmAxYdmmb7b1Y
         Sk5SZnXHRjSbq0qAAulizvsetyAsyFRwbkjQgH81Up0NljAcLgyD9s5wEqYCpkMvaMGZ
         QAcUf9cReQHaBjF563EHQYMjROr8yGNXfrvzqZVQGYTKjCYtmT4EXYGhwUvxKRSIHtxF
         ErQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwdnYcIiWi7wHi2bXU/Fk7/olRy/K+ncT86VsG5nZ9o=;
        b=WheOYP60pLGdyUe2U78Ta6mz6cTZveaox5kf9FioBWjsyLH+Fe0oUik46fj1LwFWXB
         9TiaTVHfQOfnZrYEFde5K75nvhlpS2RhVBnDjXmUO+WnoUXzxLU9jLKagqzalHgm2U13
         7xaJeBq8i08cQKRjLqxZbJgewYNaII2kjcVtq/lzwz5adtXpMgegAi74nfjBTSBaan+H
         jq64sfaSZVu6/0X4ssevuv/Bzpf01/bVTUO2SE4QDHZFnIQbmDby8Uf2/KB3taSMuIKL
         k2uwT3lbT4MPujv4W/xzqPs4HpRd56WE82y4mzRNvCyH1wPVtok2VsO6KNVouai0VI+5
         Dyrw==
X-Gm-Message-State: AO0yUKVectUccedTiHG3S5JaK6bTAxk0FqBZEsQI9KYN0eO8o0O1qcH2
        X1jlNUbMv0Y8kQw8atoQmde6QSwEQgG7KBS7R4o=
X-Google-Smtp-Source: AK7set+Gy+TGpBLSYSfAW5k0TqC9faBsy/GYtzLQo2bm+RJmxBCRf5AklYBKHdaQq+TfzfZerEkLVA==
X-Received: by 2002:ac8:5cc6:0:b0:3b6:414f:c2ba with SMTP id s6-20020ac85cc6000000b003b6414fc2bamr13287426qta.38.1674766863696;
        Thu, 26 Jan 2023 13:01:03 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s20-20020a05622a179400b003b81a90f117sm665624qtk.60.2023.01.26.13.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:01:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 1/7] btrfs: always lock the block before calling btrfs_clean_tree_block
Date:   Thu, 26 Jan 2023 16:00:54 -0500
Message-Id: <298b929ac0435fce236af750f62cbd9423c0ed12.1674766637.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674766637.git.josef@toxicpanda.com>
References: <cover.1674766637.git.josef@toxicpanda.com>
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

We want to clean up the dirty handling for extent buffers so it's a
little more consistent, so skip the check for generation == transid and
simply always lock the extent buffer before calling
btrfs_clean_tree_block.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 876bea67f9a1..c85af644e353 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5534,8 +5534,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 			}
 		}
 		/* make block locked assertion in btrfs_clean_tree_block happy */
-		if (!path->locks[level] &&
-		    btrfs_header_generation(eb) == trans->transid) {
+		if (!path->locks[level]) {
 			btrfs_tree_lock(eb);
 			path->locks[level] = BTRFS_WRITE_LOCK;
 		}
-- 
2.26.3

