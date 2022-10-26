Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FC160E8BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiJZTLv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiJZTLb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:31 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751F413C3C4
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:54 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id i12so12432952qvs.2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FahLtt1fEpWUDLixmafjeCg1ywxgIJ+kuEr8VaRvScw=;
        b=4Eq5pfEzaVl1UCbqNX0tnapabeBZGOOXFYlP/E2l9r2xgKYC94wbXhDxFpoPr0egVx
         b7LUsnMLg97Qm1iwKLEFP6RkS0hN5PdlZ8e0NCPl5vaAbrmsZeJSF/vMA4/hq9QRngsg
         moHIourFpNK7NREte88u9bPkrTUsQyp0aFERp0pslWkwWmNAQViqeQhZ7dwNnxOQM1Jz
         7bwN+s15IO9BrSXHykkfRPVPjPVL5UzSIup/knJeuEWwWy8zVq+sp35nv6qH7cfzOnI4
         8cRXW0PutwcXa8KsAvZ/cGI1cOoo+BLBSahPbsGmgI37KlTaVFfGqmzsTxhViLvksJmM
         lUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FahLtt1fEpWUDLixmafjeCg1ywxgIJ+kuEr8VaRvScw=;
        b=hiv6819GjP5StGfNNhzi1gNcidsWTRtQqWpe6ld104NUXebK6leN4TBZxzBCZVcLSw
         Vc9IPe4drEAk8iFKHi85UeP0AGQX7wkrpsSZ9INS0zrNWlE9E8n/efxL5dUK0jZYukfc
         sd++HIQPOQ8fO3Ac/xQwp7ADVhJ83LQHAhQ2tslUnPrK4ldSdoeCBb2DLoCGZjz8aTiq
         pmlprHJ8jnkon5SiwvznQdGyVaqDPFE7Frq1DvAzABup6iZHZDLnU/mM28mlNIwbjs2X
         ENdPT0Vp5YRn2jwCczzJteXubsmv9F+khaP8WyYKNkiFQS/0axw+0NTPeZhtFYAHnJOU
         hirw==
X-Gm-Message-State: ACrzQf3x2NkwLWA/vFD3WFJvOQPs8IeVbO7kSwxcr+NZzfpCfqpY1f+3
        C3dnsYMKN10mBjIr3suCY5XbdwziyOugQA==
X-Google-Smtp-Source: AMsMyM6VWib/CnfZj8wqgXy+rJvVUNv0sId/C6lwHSN3sX4tWArSZxv+kBUOvC9buZJhhacvwLC3fg==
X-Received: by 2002:a0c:a9cb:0:b0:4b4:746d:c0e7 with SMTP id c11-20020a0ca9cb000000b004b4746dc0e7mr37950512qvb.48.1666811333286;
        Wed, 26 Oct 2022 12:08:53 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id t30-20020a37ea1e000000b006ec771d8f89sm4288318qkj.112.2022.10.26.12.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:08:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/26] btrfs: rename tree-defrag.c to defrag.c
Date:   Wed, 26 Oct 2022 15:08:22 -0400
Message-Id: <87936f273e3c81d3b51d2f82506838c1f14cdcd7.1666811038.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
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

This currently has only one helper in it, and it's for tree based
defrag.  We have the various defrag code in 3 different places, so
rename this to defrag.c.  Followup patches will move the code into this
new file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile                    | 2 +-
 fs/btrfs/{tree-defrag.c => defrag.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename fs/btrfs/{tree-defrag.c => defrag.c} (100%)

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index bb170c9d030d..84fb3b4c35b0 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_BTRFS_FS) := btrfs.o
 
 btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   file-item.o inode-item.o disk-io.o \
-	   transaction.o inode.o file.o tree-defrag.o \
+	   transaction.o inode.o file.o defrag.o \
 	   extent_map.o sysfs.o accessors.o xattr.o ordered-data.o \
 	   extent_io.o volumes.o async-thread.o ioctl.o locking.o orphan.o \
 	   export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
diff --git a/fs/btrfs/tree-defrag.c b/fs/btrfs/defrag.c
similarity index 100%
rename from fs/btrfs/tree-defrag.c
rename to fs/btrfs/defrag.c
-- 
2.26.3

