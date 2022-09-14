Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02925B8B52
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiINPHA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiINPGs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:06:48 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411AD5C948
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:47 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id m9so11956429qvv.7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=gaUer8CEwSkw6jck6MmuJ2inzW3s41u45ndN6q3Dfjs=;
        b=ojyLi+vYcgeLc10oJTDHzKy1dzYXZjDc+ZmU72etVPoNo9vClgDGOFYUHqBMid041r
         SA8J15GTdikCNnRhN9ZgcTwUBgH9AKlZp6GtjU7kZMQRJt9cpL1+bl4VP4pGkOk9co7L
         nMiLPqjZiBLfOEdK/deC4cNYhTkJBcd1OrgXPuDpdNyCL/lYig6Ci/vZJR7+1kyKZen2
         pRJaz+tyYK5L3LjwDY5qciFK8AnS+ocC1SraR30j/Dg5OMSXCyJgxHOP4MAMQ1nNtOm/
         Y1XfbgtZJcTqsOKdMLVjAdimtltBedVxv6F1yqxIAhq4S4gd/a8wCVQSU5D5fcK476qf
         +odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gaUer8CEwSkw6jck6MmuJ2inzW3s41u45ndN6q3Dfjs=;
        b=0Jk6ynhbKsNVI7vBlFf8sD3YAnvnSykBepkOFelZ2y+wtVzMRn2kFzGolpcYD7JxKD
         T8gQXqkq99GPuJsP3+T/45aP6wxqgLuZIi6NrW4vbG40zSgaX7i83Gf8lxz9s9PuxnGN
         gWwF49Pg/gMIwdVsH0o+7z+pbp1rfrG815jeJBy+LGl2XYReX2ziDw4SwBEna2+urRqT
         eX5/pzvlqXa1CgIucCtSV2TvtAE3UI7B6Ps682wZ+53KB9hGUG8FGEylTlLI9x6uAzYS
         v8+Y05e6ngIXmZwgDLUyHkjzZDpmPD3Ua/J8vAXE5r9Ypy6zZ7CY3dS94gh08X9mgFMu
         xJnA==
X-Gm-Message-State: ACgBeo0A6w8K9vSHMUqSHbSyQInJ5sjdkPZGTb08Ylkde3Ffu6bRJkbV
        MNi7Pm6AlWpSdKZwofIhjpxVDR+4UEaRHA==
X-Google-Smtp-Source: AA6agR7Qk7vAjMIQ18ZTw9pIkU5epnLrzf6skCRp/e1OHaUS38qIaNRh4+uU9pl88g0jL0vVJS5HBA==
X-Received: by 2002:a0c:914e:0:b0:479:58a9:d4c1 with SMTP id q72-20020a0c914e000000b0047958a9d4c1mr33188681qvq.86.1663168005922;
        Wed, 14 Sep 2022 08:06:45 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id ck12-20020a05622a230c00b0031eddc83560sm1671052qtb.90.2022.09.14.08.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:06:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/17] btrfs: remove BTRFS_TOTAL_BYTES_PINNED_BATCH
Date:   Wed, 14 Sep 2022 11:06:26 -0400
Message-Id: <e17fc6ac382df50bdc88a688274ac98dccd3144e.1663167823.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
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

This hasn't been used since

138a12d86574 ("btrfs: rip out btrfs_space_info::total_bytes_pinned")

so it is safe to remove.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0003ba925d93..3936bb95331d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -87,14 +87,6 @@ struct btrfs_ioctl_encoded_io_args;
 
 #define BTRFS_DIRTY_METADATA_THRESH	SZ_32M
 
-/*
- * Use large batch size to reduce overhead of metadata updates.  On the reader
- * side, we only read it when we are close to ENOSPC and the read overhead is
- * mostly related to the number of CPUs, so it is OK to use arbitrary large
- * value here.
- */
-#define BTRFS_TOTAL_BYTES_PINNED_BATCH	SZ_128M
-
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
 
 /*
-- 
2.26.3

