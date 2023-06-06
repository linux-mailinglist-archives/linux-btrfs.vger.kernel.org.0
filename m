Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1717236E4
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 07:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjFFFhI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 01:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjFFFhG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 01:37:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2094F1B5
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 22:37:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b18474cbb6so33324525ad.1
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jun 2023 22:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=slowstart.org; s=google; t=1686029825; x=1688621825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pu9II8vmC6Ef9qV99x8bdSbLd/lbSjj9YoeDNcqmv8=;
        b=fKxk2EqmuqLWIAvIGCNAfEKnYDtbqPDpQ7OZ2c7SvymN878q/p4Bc0rMe7V/3vNOzj
         JjduZbUVVzTOcRPJEUtS1AXRCLv+5EVw7Wr8hYCm8FXfQ5PlfADwtcFIJ1pPHuEGd4qq
         uZMnmTciYM8KCQI/1HD/nHsRpQox8/6KxqKTtg/gb7qVWRvhySnLOEB6GjTyWWvrUjfX
         VofsO43uTcf6yG1BVo64xwSFczpC8K5yv2YEWjPl44gELzUQrCgwawmM1F1h9NYb4VIE
         0DfHGQQwYJ0OcQ4X1lEzbE6tr6x/77dftt7NZAWIr/esOvyoVPcyZzEJ1fiIJZL+lU2S
         Nhbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elisp-net.20221208.gappssmtp.com; s=20221208; t=1686029825; x=1688621825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pu9II8vmC6Ef9qV99x8bdSbLd/lbSjj9YoeDNcqmv8=;
        b=iuExxXQ/mnLbP/od1j33FedtT/QhZiw6siQYkL0qHv5gFJtddzuSWgxwtBVqiTvjtP
         egpKjQDMWZotZNGrKAnRyKbZ+nlUyosOGnnQ+iS1QgAu+yJSmo5gH2ifVCKMMBpdBcXx
         /gOug0MR1KgqcqciI3zAmWgBn1JmJyc8+WDHFHS+u3i/lqEWKvUiRWDLEFkdrFvHKqPa
         RnqDlK0AnpEEjg3dmpgHrDFHWcZCHmJ/GI74pVR+BZBw7454ErCr6mIE9vmb2mwLBz0K
         KUe62yoFboEvv1o/HqyuPBViW9e4Ld78b1ka594tPthp9OgXD9B7q+bFp0XB7hpWwaU6
         8bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686029825; x=1688621825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3pu9II8vmC6Ef9qV99x8bdSbLd/lbSjj9YoeDNcqmv8=;
        b=LgtiIGZwjTh4M8+NkmM4HWOWMBC5nD4hDvqnIBbAlyEG1Z/alhms88hr7f7xoETUkX
         Yrfy4A6YXrLVI5yqmzQdhWzZPlzl54kYLeSx9hSgMqgA1s0Py+nJR/XwrbzJBRmLqKzi
         fGwtGH97xDN4z6IZyiyA95n71+V9qjWOmaTQYuHPW+MRmiASb1+VYMH7kKRCmsbLs3nr
         m2bat7vsKRjazAnT0bH8eNymQFqWicisw6ysx9KWSeNE4Ugooo7gCJ4/zYyrJcCSmrs+
         U2tbMqpxMrIu5JVyAnpvL1I4uo2Fc667l0qC7ngLKdC/VAh4Pp8d+Am32WRwVE/Dn2iM
         qe0A==
X-Gm-Message-State: AC+VfDxiMvMZcL2b8xlFa0XJKBUNB5gu0pp/JVUGUvlzhdxFPZU8Motl
        OZzCaD38OedywHWub1LKOarBCxAfFQUYJpAV0xrLpDBSr9EhvC7rvtGV8gA3IgI7mQQykfKqD1Y
        telcHcDd8LPXIo0oByGh7lw6ViUxaKSxgoiI+sl9Rwv09kSuwqp4csJdFEQXUsvGoT2oG6Fg3c8
        Qc8sXnz3fAzA4E
X-Google-Smtp-Source: ACHHUZ5BF1YIXY1yPdovXQWu19voQyH8DdFq4Ylk/LFOgcLoIGTxo+Pchpi1InmQcgX4vpYSHJ6KjA==
X-Received: by 2002:a17:902:8693:b0:1ae:62ed:9630 with SMTP id g19-20020a170902869300b001ae62ed9630mr801811plo.15.1686029824896;
        Mon, 05 Jun 2023 22:37:04 -0700 (PDT)
Received: from naota-xeon.wdc.com (fp96936df3.ap.nuro.jp. [150.147.109.243])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b001b06f7f5333sm7521853plg.1.2023.06.05.22.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:37:04 -0700 (PDT)
Sender: Naohiro Aota <naohiro@slowstart.org>
From:   Naohiro Aota <naota@elisp.net>
X-Google-Original-From: Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 4/4] btrfs: reinsert BGs failed to reclaim
Date:   Tue,  6 Jun 2023 14:36:36 +0900
Message-Id: <e8acfcfefeb3156e11e60ea97dcd2c6ecf984101.1686028197.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686028197.git.naohiro.aota@wdc.com>
References: <cover.1686028197.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The reclaim process can temporally fail. For example, if the space is
getting tight, it fails to make the block group read-only. If there are no
further writes on that block group, the block group will never get back to
the reclaim list, and the BG never get reclaimed. In a certain workload, we
can leave many such block groups never reclaimed.

So, let's get it back to the list and give it a chance to be reclaimed.

Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index db9bee071434..36e0d9b5d824 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1833,7 +1833,18 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		}
 
 next:
-		btrfs_put_block_group(bg);
+		if (!ret) {
+			btrfs_put_block_group(bg);
+		} else {
+			spin_lock(&bg->lock);
+			spin_lock(&fs_info->unused_bgs_lock);
+			if (list_empty(&bg->bg_list))
+				list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
+			else
+				btrfs_put_block_group(bg);
+			spin_unlock(&fs_info->unused_bgs_lock);
+			spin_unlock(&bg->lock);
+		}
 
 		mutex_unlock(&fs_info->reclaim_bgs_lock);
 		/*
-- 
2.40.1

