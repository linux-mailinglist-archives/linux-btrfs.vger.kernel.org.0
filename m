Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499544F6075
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 15:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiDFNxw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 09:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiDFNxk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 09:53:40 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C14482518;
        Wed,  6 Apr 2022 02:04:16 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id 10so3190844qtz.11;
        Wed, 06 Apr 2022 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpQISEJkMsGGUwWRkm895SJQ98zg+L5bbS31/XzrGiA=;
        b=V/6a3hS7tQXXpoy3SEUCEWutQNX53bEKd8bYeS10mTop+OOgF6uyYIIWO2Y5qiJSwA
         ZZzHpdNr7A/CUPLIEv3WQNOInS18DXZ5VdUQYSMCYyIkj3vK3vNw/8cPq+twLPh24NZH
         381QADyI0AW/n15t5v21gGYxQrVUgGAQ/Ve1OW7byz/x78tsANCUkbyjU6oYEQKZRp26
         gYetu6u+ketH/fhXx4/jQj6sVxr470FhQxOGdn3drH40eH+2/vnxYU5Z6Tg2HH2rsuZC
         VuvtomEGcHAaFC3hNTchBNELrvaA5Zd/fJly/1cJV/Ik8ESQeYWiMmgMAHU8bQ11b4Af
         GBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpQISEJkMsGGUwWRkm895SJQ98zg+L5bbS31/XzrGiA=;
        b=5rgw2WxBPgjroEDdWsiR/AITUoDajFy4xN/hKEjjHnKqonKIJyo4UbrMSlurmz7j6B
         4XgEuAXJggjI5Pdh18uvrnEJfupCTk/CnLxB9MwIz9jrz12yNjQ2i2ZAnLtfSd8SQD+i
         wnj74tS+lfkF5hHB/xAAByA2dcyHGYjzvONjrp74TU46uPYK/1WHtniLqTPEcZSdlNP1
         t6eWcLJC7YGIzaU2QG/bKRXD3Yn/cOz5QdpNIVbk4iAdyE41FOeCWfoq30RNwZl//zNX
         2Yih1jUeWpRldUEIICAMok+EvJ9bLxxN9ncYOGhfddTCwTSDNAMY1BKR7O1H85+XN2et
         a3rg==
X-Gm-Message-State: AOAM530K44oyV3GO8OgL/70wP7p2Jq4ZDM2rxSRAHD5OHGhSpmPzqsxd
        ePRll/258GsSmao3kdWUPv8x1t0kGfU=
X-Google-Smtp-Source: ABdhPJwrHVOg7ApX3nRah3rsmk5CCi45Or8wzbEtr1NeXRWyz+taAotR4/9/9EkDW8QeYpzq5ZmXSQ==
X-Received: by 2002:a05:620a:16b7:b0:67d:3abc:e4d2 with SMTP id s23-20020a05620a16b700b0067d3abce4d2mr4733235qkj.702.1649235851020;
        Wed, 06 Apr 2022 02:04:11 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a16b500b0067b1205878esm9161645qkj.7.2022.04.06.02.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 02:04:10 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     clm@fb.com, josef@toxicpanda.com
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] Btrfs: remove redundant judgment
Date:   Wed,  6 Apr 2022 09:04:04 +0000
Message-Id: <20220406090404.2488787-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

iput() has already handled null and non-null parameter. so there is no
need to use if().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 fs/btrfs/tree-log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 273998153fcc..c46696896f03 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -894,8 +894,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	btrfs_update_inode_bytes(BTRFS_I(inode), nbytes, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 out:
-	if (inode)
-		iput(inode);
+	iput(inode);
 	return ret;
 }
 
-- 
2.25.1

