Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF3354A21E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 00:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239782AbiFMWbW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 18:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239749AbiFMWbU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 18:31:20 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B374530F61
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 15:31:19 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x75so5126699qkb.12
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZ1HMFQilA45Vrghk1d8ClDIicRCXWZ9GWZGPOomaiA=;
        b=G5hgoIUimeDKzaWOInHLgxFrcnFYX81GODKPs22b/0ftx5ldABNf+xISDTj1g5ZN9y
         QoDPa/ZUwfLcbDDsSkAM5iaKwmLtOosjEvI/9qSHbRjecQYqed0U/uCmTWOSUTEJlv1/
         Yg425B91ytvX3AkWa5VckQB4xgEZoQiYNtjRdlTaJkyu7rJidrubi7QIlkJFDXDY+dhc
         VzyYowBIaZbuoQTjejkl7aEN5WxZRzop0bTyPjJDhc8pxfpPkNCZDdNBjjHXhtQrEiMg
         NND0iLMnbo/Gp+6qP84YbKmnICE4qi3F+pXQVKjkQxzVwGJhE3Hc1NIXDVeQE6lQsDGd
         27+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZ1HMFQilA45Vrghk1d8ClDIicRCXWZ9GWZGPOomaiA=;
        b=ySQDIzmSmYh7MtOPSHE0qywYfKwb2qbElNhRy7G2YPCMRBGPD+duR2fEz5nLiKOVju
         mdDjShk3PMV4PI0IGS56Aahm1xeG1NLCuZd889i99gYcrqx5ET3pPzAereJoNkqQRLr8
         t37C9F9o8ONrgnD7pWRtCGuj0iLDbheGcrk+CeWG5+UMLxUaU8QRkzT/91SzdJ8q8iRG
         5gV3M7y2I6rFkS0ogAXm6O6WFIM96Y13HzLqpaFiIcw5PeX/zAbCirVFqXl+in9hwd4P
         MFmli+B+qxSAN+VQHqq779DvEfeykh2qzsIBLB27mpRgWMBvTBGbkOpZeVEYSKuSJMFo
         hLlA==
X-Gm-Message-State: AOAM532F6HwPK8zsG5iArbMmgqdEfH/vdqhqCq6qQMsXMsuQH1n06+Z0
        hKIsmvkU7+z1UlXXPOHTsgL0LgxM4ivdxQ==
X-Google-Smtp-Source: ABdhPJwSqvDLUFJ42XgIc2trMsMd1R425rLIvd62wNS0FffXeCKFYyaLn4Q9l3LDebkYq1xW1xrUSg==
X-Received: by 2002:a37:c403:0:b0:6a7:7763:fe07 with SMTP id d3-20020a37c403000000b006a77763fe07mr1785558qki.579.1655159478580;
        Mon, 13 Jun 2022 15:31:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k15-20020a05620a138f00b006a73654c19bsm7372243qki.23.2022.06.13.15.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:31:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: reset block group chunk force if we have to wait
Date:   Mon, 13 Jun 2022 18:31:17 -0400
Message-Id: <26ea5e38363115b0a35bf7e56078a552075c9ca7.1655159467.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

If you try to force a chunk allocation, but you race with another chunk
allocation, you will end up waiting on the chunk allocation that just
occurred and then allocate another chunk.  If you have many threads all
doing this at once you can way over-allocate chunks.

Fix this by resetting force to NO_FORCE, that way if we think we need to
allocate we can, otherwise we don't force another chunk allocation if
one is already happening.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ede389f2602d..13358fbc1629 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3761,6 +3761,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 			 * attempt.
 			 */
 			wait_for_alloc = true;
+			force = CHUNK_ALLOC_NO_FORCE;
 			spin_unlock(&space_info->lock);
 			mutex_lock(&fs_info->chunk_mutex);
 			mutex_unlock(&fs_info->chunk_mutex);
-- 
2.26.3

