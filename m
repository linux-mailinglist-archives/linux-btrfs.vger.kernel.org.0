Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E873580348
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 19:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiGYRFO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 13:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiGYRFL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 13:05:11 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D45DCD
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 10:05:09 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id mn11so4475817qvb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 10:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HZrMJ1F0QXJeY0gFLKRcQg2WFlfw/X1HoyC8rQJcX7k=;
        b=cfULKsalLu5pBqKqC3bhohhREacmvhMRuc3XjdzF6SSy9ogRtGX/9wQIgXWn8u9ivv
         R8bPSpDcfsCpOigtNN+6pUYQB0aJHYQM7jSE3IrKPvVOuYz7TvuWFa/3LPeb0rwOpqFu
         H8UmfzKUOE1ppDTdGOyLwRw7fb1hByE/mUobT0kBiKW8JIxXqSZvGEf8+lRZ4O5iK+p7
         yt29lyM8hwXooR8o3WG1XlyDqdsrwDtaDRcFFBI+HmXbmhEG/zB2ozmPyh9EXy2A18sw
         mkTq6c45iQOq4ZlmdHrk2cTe2mU6pPrHFKXBCx0z+hDjrcEK/KLZ47Ajr2D0fqCfvvpj
         N0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HZrMJ1F0QXJeY0gFLKRcQg2WFlfw/X1HoyC8rQJcX7k=;
        b=TKDC6CcHIO/FiFiXq9x3X9p3iY4pyEGGMRj8lc8Xt4rVNLimHZn96+CHV2fh1N6J8I
         ilniLdeXFytAMtuzYClKf/l1zHdPsDVAI3yplFdhuzksmRA4k//QlKd5ygZ9Ez/CnTeb
         eSx3sGYYiFuhSbdR44I74K+gsNC7JNch8L7Ay8Gs5Ptc4N0IwobDnrXo+D9ZL3MtIW14
         UTKJROpRB0khPloNcy/S4nPL+r1V+EAFEE2KqFDgp9oN1UjNsDG7aees5+euRFmkYRZU
         uPzSAxZSN1Q+8RUjZpQZiDltkV0pIZoHrODR0DQNziXseXI+2UDlWpjoOvnuXzujXRBr
         REyw==
X-Gm-Message-State: AJIora9YMZfcxf5vNYfsAV1cyie6iURm4/SfBxOcYWlj7zqhgJwwD6XR
        sicS40VYC7+OGinflXNOBqcaA4ZbpdpJyw==
X-Google-Smtp-Source: AGRyM1srOzmAzAL90DdLXW86dvk6Qzaf+jzuzG0HB6eQGJcidniSjpiB5FnAvSForpqaYPJTTDkgYw==
X-Received: by 2002:a05:6214:248d:b0:473:fb6c:36aa with SMTP id gi13-20020a056214248d00b00473fb6c36aamr11171628qvb.66.1658768708619;
        Mon, 25 Jul 2022 10:05:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f22-20020ac84716000000b0031ed590433bsm7532168qtp.78.2022.07.25.10.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 10:05:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: reset RO counter on block group if we fail to relocate
Date:   Mon, 25 Jul 2022 13:05:05 -0400
Message-Id: <ca31fa4152849cee02f16c49f7ef818b89995a25.1658768686.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

With the automatic block group reclaim code we will preemptively try to
mark the block group RO before we start the relocation.  We do this to
make sure we should actually try to relocate the block group.

However if we hit an error during the actual relocation we won't clean
up our RO counter and the block group will remain RO.  This was observed
internally with file systems reporting less space available from df when
we had failed background relocations.

Fix this by doing the dec_ro in the error case.

Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c3aecfb0a71d..993aca2f1e18 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1640,9 +1640,11 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 				div64_u64(zone_unusable * 100, bg->length));
 		trace_btrfs_reclaim_block_group(bg);
 		ret = btrfs_relocate_chunk(fs_info, bg->start);
-		if (ret)
+		if (ret) {
+			btrfs_dec_block_group_ro(bg);
 			btrfs_err(fs_info, "error relocating chunk %llu",
 				  bg->start);
+		}
 
 next:
 		btrfs_put_block_group(bg);
-- 
2.26.3

