Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659E9349E57
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 02:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhCZBBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 21:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhCZBBq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 21:01:46 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C34C06174A;
        Thu, 25 Mar 2021 18:01:45 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id g15so3783705qkl.4;
        Thu, 25 Mar 2021 18:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3v8k48IeCcus0saI/jVFEZrQSGBnWbV6wgOy5GPt20=;
        b=CGkkGBUjxhHpwAeWwidcEzKAr05bxggAaj/rd2vXYCx+WpJwH9fXH0cjssEGmFO8PP
         oxI4oyD6P06v1EHighDaeeLduczaUgH5Zh+/C9QBslMtBOMyx4Tx89kTqV/uCFNGKeFN
         MrNzQoLLko1QxBWkTEgomRxeqI0vKUwZcAyBa/5kFMVAnhnWsl1zj4nldf0AZKnnsL6b
         icF/ud86aOLlPwuxF3or0+cbTZdS627/b4mIQSZLM5td5qiUClL0+Mg9uyBE83a3HzYj
         6E0UuQkWormOfq+Mhf4U70Hp3vPiLzQhnf80BYPyipk/6r6E7ou/88Ek5SwEgiyT8gM1
         vW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3v8k48IeCcus0saI/jVFEZrQSGBnWbV6wgOy5GPt20=;
        b=aDaFHyGOVuPynRtPC/3yKZmKuAPWpluoqofra1agI4LfIrsDtuKeWcKQnpVXkRckJh
         glvvP7BoLcift+ingutWl17MpvQBmxc9ivXQXCvyqk3R7IDiUD6zDAwi8nq2K7ANa2QS
         JpUmGDOIuiqY3xcit2t3boverlm62dJgys5CMu0XOmntU2p1RlaiKys7kJhtJt4GO/GX
         qILHcylwAFGbFP461xWWEyKrcIy1vr5tR3lMBJGVutfM8VSRNBM53pyYa2UOeMQE4dqR
         VxpeM4IhjFMU4YPgf0HxgDURR8PSPLwWEwvmDnamIAmTxX+TS14HhxnOCNL7vfdmvIsU
         xIIw==
X-Gm-Message-State: AOAM533GsMnunyFRAzpoGnuM6j0IWxlOSOkCMyC/K0GmO29gWJFmXThL
        ZjvHI6y29MyffODIC/tDyLhT6jK5UfQhInhw
X-Google-Smtp-Source: ABdhPJwKZFW/K1uf0/IrICUIF0d9wONxtMf2Xbdbdo2mo7MS2AQU17I1P6LMzF24jym0AJdLk4S4jA==
X-Received: by 2002:a05:620a:714:: with SMTP id 20mr10904457qkc.192.1616720505274;
        Thu, 25 Mar 2021 18:01:45 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.107])
        by smtp.gmail.com with ESMTPSA id o7sm5611975qki.63.2021.03.25.18.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:01:44 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] btrfs: Fix a typo
Date:   Fri, 26 Mar 2021 06:29:32 +0530
Message-Id: <20210326005932.8238-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


s/reponsible/responsible/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3d9088eab2fc..14de898967bf 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2426,7 +2426,7 @@ static void drop_csum_range(struct scrub_ctx *sctx, struct btrfs_ordered_sum *su
  * the csum into @csum.
  *
  * The search source is sctx->csum_list, which is a pre-populated list
- * storing bytenr ordered csum ranges.  We're reponsible to cleanup any range
+ * storing bytenr ordered csum ranges.  We're responsible to cleanup any range
  * that is before @logical.
  *
  * Return 0 if there is no csum for the range.
--
2.26.2

