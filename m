Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5320F688
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 15:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbgF3N7n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 09:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388310AbgF3N7k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:40 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82232C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:40 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j10so15576305qtq.11
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eyMNWoi2hC8qlRuAY9xprTphnhdSNxjekwZC/C82Cw=;
        b=rxPaGioK9eQLYv2ggBL4lTq+uuymCO/2+1iIg0sVvmoXyGaIltIyKloWkEGirfusBm
         2cZyHmWZNyPJdGwgb5UtN8jWsyb77ql+ysMs1cPp9szfvmAN1ehJZpSJSLzd7qHVrum3
         rejzitX2SNRTuMjiZyPzU/wKlsMfv+zmL5wpA8G32n1xe5kIi+ttYOsasZKvGmj+HiEr
         5i8g3mHGWLXbCBzYG7mefAMMCjH1k/wXsqgQ49bT94b2FLg6/vjtAvddX+/R4AmsbuSa
         Efw0uvp/pOzqC03Y/7J3HAJ2A14PCm0dKZS92dkR5LK/QAX/GYVS8p2ae1Ppd6IcY9EA
         UdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1eyMNWoi2hC8qlRuAY9xprTphnhdSNxjekwZC/C82Cw=;
        b=Oy7NL7gCuJjiE2nU9H0e4pSye28g1f7JI/6ie5BeHRgfdBx5ynoMjMfICxdkU0hNMa
         PwhFaPzdtu2BVIrG5K9t1fdicVYKehk4rqnNCGW+Edv/ry6LZ+5cpWfolBNUMDlnluli
         BUerLRL5XJDF3q4h8C/CMyAMfmhB+rSfqiUvZbD4wS4H6F/w8cRkHIwbbhooRjjiGQZQ
         oFgS649ufiG0NUF49XIZbjVInJawfWxXLr4GkCqDhEip7Qafooyv5fa6Jhiwhk0Gdm+h
         0TFuC8ZuSViqsTh+AY53jswlrF5uuUF6Krk6i6p994YzRGzwCiT79ByNM2PtVFZJgO9+
         JAdQ==
X-Gm-Message-State: AOAM531as1i56jy4jnM/R32bmimNwdzbQVUgCqX2BnAkoolqf66/kS1M
        +6erucVGjUSVgCtvcCssC8iKtfSIlICKdQ==
X-Google-Smtp-Source: ABdhPJzEd8TGZfUSdHGOMJzcl9NOywxOlWBK6fbKR2w2b68m0STG7+9cj4BC4FjDFyZ3nQeU1jpaWg==
X-Received: by 2002:ac8:2bfb:: with SMTP id n56mr21474120qtn.281.1593525579406;
        Tue, 30 Jun 2020 06:59:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c7sm3360066qta.95.2020.06.30.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/23] btrfs: call btrfs_try_granting_tickets when unpinning anything
Date:   Tue, 30 Jun 2020 09:59:05 -0400
Message-Id: <20200630135921.745612-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When unpinning we were only calling btrfs_try_granting_tickets() if
global_rsv->space_info == space_info, which is problematic because we
use ticketing for SYSTEM chunks, and want to use it for DATA as well.
Fix this by moving this call outside of that if statement.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c0bc35f932bf..4b8c59318f6e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2844,11 +2844,10 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 				len -= to_add;
 			}
 			spin_unlock(&global_rsv->lock);
-			/* Add to any tickets we may have */
-			if (len)
-				btrfs_try_granting_tickets(fs_info,
-							   space_info);
 		}
+		/* Add to any tickets we may have */
+		if (!readonly && return_free_space && len)
+			btrfs_try_granting_tickets(fs_info, space_info);
 		spin_unlock(&space_info->lock);
 	}
 
-- 
2.24.1

