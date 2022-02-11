Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950D24B2A51
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 17:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351462AbiBKQYq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 11:24:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351469AbiBKQYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 11:24:46 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A053AE
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 08:24:44 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id m25so8696012qka.9
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 08:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RK/G1++5C2d/S4V+mp7/CG14AtwkIfhZvbF2rF2eHMg=;
        b=ePy1wbrdzD9pu7fCcZu9x7K5Gf2hzHnfXwUGT8BcDbZBl/0JRTefuLeTdMkapVEq2H
         zLV2Afaycbi161ft7imusGzoQM7ts3lnLzscMfJzW98DH+cXynkoVPUEZbIsvS3W5a5r
         tLze+yqSrfJVn4N0DXdZoghn2PlzsjoEOtE4Vn5T/ZaDs24NZAmh/WXznNEsb3OPpcIn
         ibN4R4ow60nweEJv2mSd7EH9kerxVP7Hnz+n10YtpU5kdtFPLOb6/UyLFX9cG31QcnBD
         UIP0PxFK5NLg9DaIrsSEGa7vWynIuVMhKbSDlQ5G8ZtWAU5SiQpuUUiNoAEo6R2F8nvq
         1Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RK/G1++5C2d/S4V+mp7/CG14AtwkIfhZvbF2rF2eHMg=;
        b=KqnoccpSncvpz3cDVVuHcbannctMGHkoLzjVaP98Vds5xeShLndf/sBIaV20IPiAUu
         V0UECpzaxjIZpMqU/Cw3YEKmbFYmBBlrBG4SqfkMHY7woOiKM0T98uQSXviS/hMAIRYC
         eVH75EFQhOYGoSY3yPriQmgNpd0jAleCLPGU49v56M9Mnlb4b+E9REF0/oHYOihrtbuU
         NQOClcqJ2fSaDcQMgMJChlQPJ6Ep9oXpxkA6v7pzTOLtcINEZcZT+bHt9QmqskY1FXJz
         Ypi32D4hhCrn95Ttb0iWpMDap38bmSbAVPFyP+mYCdOMYZ8tWlU+kCKmCPDnwGrtARsZ
         HXIQ==
X-Gm-Message-State: AOAM533RCnp/Ir6SxaTGvODanNaR/xaTFcDsrFLKCLqwRP9ey3DXgYJM
        rSHSZwMcTV2OfTdz1jR4Njlu0tDRRI/1Aaf9
X-Google-Smtp-Source: ABdhPJyi73VMrW91CmnqrcRwTYFjatmFBIXw30jTkhinHeBPJ+6QW8ziwnC5hD1lP0MQCk5BPiRfHA==
X-Received: by 2002:a05:620a:103c:: with SMTP id a28mr1174253qkk.441.1644596682433;
        Fri, 11 Feb 2022 08:24:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t1sm13442408qtc.48.2022.02.11.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:24:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: do not SetPageError on a read error for extent buffers
Date:   Fri, 11 Feb 2022 11:24:38 -0500
Message-Id: <0682dfc75f9d32f4cb4152f6547a5fc4ef23d575.1644596294.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1644596294.git.josef@toxicpanda.com>
References: <cover.1644596294.git.josef@toxicpanda.com>
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

For reads the page is marked !uptodate and that indicates that there was
a problem.  We should only be using SetPageError for write errors, and
in fact do that everywhere except for extent buffer reads.  Fix this so
we maintain that PageError == write error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 16b6820c913d..bb3c29984fcd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6671,7 +6671,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 				 * i.e unlock page/set error bit.
 				 */
 				ret = err;
-				SetPageError(page);
 				unlock_page(page);
 				atomic_dec(&eb->io_pages);
 			}
-- 
2.26.3

