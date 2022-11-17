Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B020F62DEB3
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Nov 2022 15:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiKQOzA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Nov 2022 09:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiKQOy7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Nov 2022 09:54:59 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0E59876
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Nov 2022 06:54:58 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h21so1200151qtu.2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Nov 2022 06:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4gYHLnDbPsX8o+ArCdE4Q+WPLVZfM0ujlhxTUgHkNIY=;
        b=sgt0hWFQ9p9leh3zx3sdosqVYv1hSD0H2SZt56COC01NtPuioNOOAtXtiedM8iDf4M
         L6ZZ1HuE+vkjY/4QA2MKzFAxIk08iXyiyetYl0h+okQsQzqspNpfBXrgQzHY9bzCzvYD
         1weDXHJrTKt1nMWUyGcvskQd2bbFb2teP41TvBqpaJ6+dSZvfaXGnljisKhkrpxFm2zC
         CpvBvLFmvIScl1ByIrAch9MP1HGaIlwOp+N7PRlw2ixS/h5nHXAGlU4gInZ2nFfejBzV
         KW5kpO/rR/3NZBEujQ6S6bjkVxp93dfyYD7hURrzIHrKkuMCi3sVdWfC9I5ydrtU4+yT
         +LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gYHLnDbPsX8o+ArCdE4Q+WPLVZfM0ujlhxTUgHkNIY=;
        b=55iWrMd/yw8ss1hx8aZte8oFn1dLf6MgEw9NnY8I7UciiWA5OwIonYTHE1EOLdqLhj
         mwMsUHKkohnhQbJ480V8UEzATemDEkbxrINmrxc8752i1O82aMH9xgzkSKHoFltRdoKd
         GWMieNx9RllPz3z5eVVdcKPo+OGL4RvgjXccVKO2era9lekoWkcURL9p78i/0DwTm5iG
         LDkdkThdgsO1N5oAnTWJRSrZLAWtM+QHGrKOZZdHp9fzGjXkKye1YMkP/mdGffKV9wlm
         4qRXxfi3r9q6qZKDUVVWnKux1X9yfoZVn78vx07uwr8ewqR1DiToZpkKt52+3WzfVqIT
         ltxA==
X-Gm-Message-State: ANoB5pkhOt7OTH5MFhshpB8A9co+18c4w5BKq7YPiy78MZ2uPKb7NRio
        Dki++8pJHB/mrRllt2k4+INqbbkI12OVnQ==
X-Google-Smtp-Source: AA0mqf409FYYBlI2ofdBNwF/2ikDc06itcN+/tH+oPAZzYToAPSLmsS8LcYfeq78a5pJJvd/JZenag==
X-Received: by 2002:ac8:7401:0:b0:3a5:310c:1cbf with SMTP id p1-20020ac87401000000b003a5310c1cbfmr2352983qtq.607.1668696897602;
        Thu, 17 Nov 2022 06:54:57 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h7-20020ac85847000000b00397e97baa96sm508833qth.0.2022.11.17.06.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 06:54:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: do not try to handle a ticket for FLUSH_EMERGENCY
Date:   Thu, 17 Nov 2022 09:54:56 -0500
Message-Id: <1f314a6e586b0725b84eb906efbfdafd10890c59.1668696886.git.josef@toxicpanda.com>
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

Even though it is unlikely, we can still fail
BTRFS_RESERVE_FLUSH_EMERGENCY sometimes.  Unfortunately the condition to
check if we should just return the error only checks for NO_FLUSH, and
thus we could get into handle_reserve_ticket with FLUSH_EMERGENCY, which
has the equivalent assertion of ASSERT(flush != FLUSH_EMERGENCY && flush
!= NO_FLUSH).  Fix this by changing the condition at the end of
__reserve_bytes to check !can_ticket(flush) to handle both of these
cases properly.

Fixes: dfed100c66b2 ("btrfs: introduce BTRFS_RESERVE_FLUSH_EMERGENCY")
Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a1384357f7a5..d28ee4e36f3d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1729,7 +1729,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		}
 	}
 	spin_unlock(&space_info->lock);
-	if (!ret || flush == BTRFS_RESERVE_NO_FLUSH)
+	if (!ret || !can_ticket(flush))
 		return ret;
 
 	return handle_reserve_ticket(fs_info, space_info, &ticket, start_ns,
-- 
2.26.3

