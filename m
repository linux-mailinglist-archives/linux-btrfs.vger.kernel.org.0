Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7940338CF39
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 22:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhEUUpk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 16:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhEUUpk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 16:45:40 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9720C0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 13:44:16 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id s12so7085949qta.3
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hfl3MkrBHJYD9IZg+Y16zjplsrM7+fgbVgPRHXrcphY=;
        b=XNmZdpAhqJJD/pbRKnrd2GsHuwXlzpYoJ6pC/YnAKzGV4t5f+UIqVWy3aPYHaW05tb
         dwlXYPlcwAu0CyaRboEtHnu43Wb2maxTUbN2P06oM/WvsTgirD40mnDVSKFa7wjT3amt
         c3TdJWX5/ZNKDpNPdVRaW0s8jgJ8cTsqdC/XLmvaSLTKpseCY69azqfxWWE2aPWX8zra
         gAUne8I3yzdjYRmBOZbuRGO6SR1NOyy98Le2Xv/v9muij7DE6eqKvM7cxbtbcP9wU8UJ
         QYQVqt9sCVJ+GSPKPLIRoh6cm4Isgb2Oss8sRmDmoXymba5gZz31fCkTFpwL1h3OOm/1
         RDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hfl3MkrBHJYD9IZg+Y16zjplsrM7+fgbVgPRHXrcphY=;
        b=WsQRZS83u0WkIGx47JWwD2V4ckK4T1ymaiZTjtTxDhHqLosGIbrO7sk+mY+68ry1/x
         w4pQ614JYpalba2bVUvU9U4zzC5+xCrSwZ28QDQL5BH1Pfi+VzmUHeRxMnq1KE4UyaYj
         OoYase/TSiCbbB2o0dz8uLkdmtcmvDlO8+C+7V1Nu0xLl7Ij+bg/I/aHVglpyPBQdOf7
         19QT1FJ0QZ2aZkm2Ey5A0AMDoD1OrBTnSKLpg8SwWaLTgruTXnGXy7eOKwsRFHNm554e
         Z/MAZ7Up8xVcWEI4mauRixtv4cVNYlHLh21Hl5xh2P5K4snYB64+PaLELBbajsLUWs03
         9fKQ==
X-Gm-Message-State: AOAM531RNr/b/6JSCyK2Y2XcXLjKEQ8LRyyJwsfkZr0njonELlf3mF5p
        SbPqdky2zyCAdaQmZXS5vErXRni91QgFRw==
X-Google-Smtp-Source: ABdhPJw17JwJNMcX3P5oMTYxgu85aI0lvLuA1bBBz3zNfyfmdKI5rNW5adMrFORBMPZaFPOiT4AMEQ==
X-Received: by 2002:ac8:758f:: with SMTP id s15mr1823727qtq.180.1621629855565;
        Fri, 21 May 2021 13:44:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 123sm4505089qkh.104.2021.05.21.13.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:44:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: abort transaction if we fail to update the delayed inode
Date:   Fri, 21 May 2021 16:44:09 -0400
Message-Id: <369d25c766284041a89250a8f2e34361be689cef.1621629737.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1621629737.git.josef@toxicpanda.com>
References: <cover.1621629737.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to update the delayed inode we need to abort the transaction,
because we could leave an inode with the improper counts or some other
such corruption behind.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 263f3ab3009c..6ce6d8a839d7 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1052,6 +1052,9 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	btrfs_delayed_inode_release_metadata(fs_info, node, (ret < 0));
 	btrfs_release_delayed_inode(node);
 
+	if (ret && ret != -ENOENT)
+		btrfs_abort_transaction(trans, ret);
+
 	return ret;
 
 search:
-- 
2.26.3

