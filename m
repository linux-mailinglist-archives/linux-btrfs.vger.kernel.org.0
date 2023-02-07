Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0D868DE56
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 17:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjBGQ5f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 11:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjBGQ5d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 11:57:33 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04B43BD8F
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 08:57:31 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id c5so3850944qvk.13
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Feb 2023 08:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LuUeP9+Pd3M5rK1yWMfDkXRBAfb7ahdfkB5gJojv/0=;
        b=uIj8QO9Lj4xqZIu70EpIh5aBeHF24wWg4s0v3Hm5xLO/buhH5vnBKAUFPSFyD5IgFn
         955nGSdH7/hIIMaV77tLfq41kt55dCIog8K+RlgI64z5UgGai6DxLMkyYJqp7YQPcOyB
         izBGo5fc1ouVK7M/ZMRX+cVq+jSVIjT5txvs5H8l2f3MPhkeFUE82qm3+w3jFK3sFtRt
         qDUjyivk9yk/O/1tNbbzpI7wpyIt9xaNM9wU7uD+8OykvegLubWtdwuhEdRomPwiq5wg
         cvAnwlnVdqQw1M596RwfhE6/9zemvuSSH9WG8yRGIbSNEgv7rQa4MDvzVSlOp2hwx8jV
         L3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LuUeP9+Pd3M5rK1yWMfDkXRBAfb7ahdfkB5gJojv/0=;
        b=BZaJaIw54uFdjqbMc3RB5wtDDTEhV/RWnBtQxCQbHq2BVp08lujASHEqVBTWB87H8V
         fm50iIJATvap5LAKPrdk3dkvd0KdfzAYUpCSknAwApk4yGkS8jpcyBJVdN5d77q3fLZz
         g5C4QUmDdWi3rSO9F2jJnrKAd0AF2pZH2Q46jWVLK48hXT+A1rxbn3CJdr32ylNL1aeg
         qghJtcVgn7PnGOpy2/YzqI+Nbm76scJj9fUw4+iTAEoeMgMPaBOXtUVVlQQq9f2/F1G6
         K0oPg5aewncfJ13SibkEVWl4Hs2tz3KXGex7vnXKXvjfiqZsnAZWHalIHqh2mAP/eN0N
         3MSg==
X-Gm-Message-State: AO0yUKWPbiaQq8ClykPkobShRhBPV2/RMYnXQzo1E3Mcx0GxOp0mNghV
        QHx4ucJi/lpAbXv4fO7JgPucnSUixSpib0ir61g=
X-Google-Smtp-Source: AK7set9duHgAeQkXsY3LmIbKaRpfoIhFZDINibWEUKjI+RKoZ2HVzVuTix6+NmWAnB5RoufqTmzWwg==
X-Received: by 2002:a05:6214:240b:b0:568:f263:1c0c with SMTP id fv11-20020a056214240b00b00568f2631c0cmr7174398qvb.21.1675789050518;
        Tue, 07 Feb 2023 08:57:30 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a12aa00b0071d57a0eb17sm9595034qki.136.2023.02.07.08.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:57:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/7] btrfs: replace BUG_ON(level == 0) with ASSERT(level)
Date:   Tue,  7 Feb 2023 11:57:20 -0500
Message-Id: <c32e735843f82e6348877672218abe529d5ce585.1675787102.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1675787102.git.josef@toxicpanda.com>
References: <cover.1675787102.git.josef@toxicpanda.com>
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

In btrfs_read_node_slot() we have a BUG_ON() that can be converted to an
ASSERT().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 118440857f33..484d750df4c6 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -964,7 +964,7 @@ struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 	if (slot < 0 || slot >= btrfs_header_nritems(parent))
 		return ERR_PTR(-ENOENT);
 
-	BUG_ON(level == 0);
+	ASSERT(level);
 
 	check.level = level - 1;
 	check.transid = btrfs_node_ptr_generation(parent, slot);
-- 
2.26.3

