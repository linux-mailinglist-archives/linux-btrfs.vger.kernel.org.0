Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C356164640F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 23:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLGW2T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 17:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLGW2R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 17:28:17 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EB854762
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 14:28:16 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a16so2206382qtw.10
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Dec 2022 14:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwdnYcIiWi7wHi2bXU/Fk7/olRy/K+ncT86VsG5nZ9o=;
        b=rXWQYi0/l1e9oDvb0YhtJsffigGqAs1c1dqEZ4WmH+llMZOWFxl1wo3CiT5JChFpA2
         lHP/SwLscUjkE9iMkfTa9uxg0fRCDiNO1qFIYWyFChbR0kqtM53REEIPLzE21jtN+kFv
         iXQFLEgzvIP+Y8C+T+QrA29Wt4TRtajS0oc5CgOvFRG1czHQf9qtNp7rFeoZGtB1iX6M
         88NuT+8im2ZtNTtZTi5VrmhvPNVha15Xt/3sMyTuDhhnELcpqG2QR5wH6xNeFKxk2Gf3
         +j6CRAvnBA30ZjFP/JGZZ1evSMIbxVjVYgDD5gksUUkUrRLieP36lRDvowgC1+jwxaca
         BbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwdnYcIiWi7wHi2bXU/Fk7/olRy/K+ncT86VsG5nZ9o=;
        b=ur71kwwKT13sATvcwO78k8dgEZCe12dvAnHh9mjy55fe4icMIXHvMrBpM0OCLnhhSb
         sfWfH9NmLZpdytOK4TsqIguThKHh0Vc7Zx66iAtTr59U2j7qdxJdGLOXZG/UUMw0isK7
         DxpVU5b+hmvlvYShLdFdOLv6amT3FU9adlsgy7GXP9pcRKkEHj0fv2f8Tzaa1HKohltN
         VwdKFekfoEfxb/p+q84KKOGRXBfClcGfGPOxxcn9QthphZCcIcFfspoinpUiBYRc3yps
         87ayIpq8Cq15P6bX0RMg+61LHNyEvy+qAXz/9JSgjB0jVc/56ldc64ptZbCJ5gxmt61q
         Bf7A==
X-Gm-Message-State: ANoB5pnX81UP3FcC8f0YrtJlYN0iiikUFhGQyryNlu8gyF+CBpLqhkqo
        HrHdPyBV4EIak/D8OBrf6wYmE9jyzhqob5Yt
X-Google-Smtp-Source: AA0mqf5+JI1xZ4gy8NdnFrYROfdEWjr6t+BXLZZttDIEvCNePqMiRZgzjNkoyV1uAnvk7iBXG4XIwg==
X-Received: by 2002:ac8:7305:0:b0:3a6:9cca:67e4 with SMTP id x5-20020ac87305000000b003a69cca67e4mr1600624qto.60.1670452095896;
        Wed, 07 Dec 2022 14:28:15 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id j11-20020ac8550b000000b003434d3b5938sm14245048qtq.2.2022.12.07.14.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:28:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/8] btrfs: always lock the block before calling btrfs_clean_tree_block
Date:   Wed,  7 Dec 2022 17:28:04 -0500
Message-Id: <1882118e87ae105bcbc5a94744b98c4b67207567.1670451918.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1670451918.git.josef@toxicpanda.com>
References: <cover.1670451918.git.josef@toxicpanda.com>
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

