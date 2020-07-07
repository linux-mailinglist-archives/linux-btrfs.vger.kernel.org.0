Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2942172B0
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgGGPnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPnC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:02 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD1CC061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:02 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b185so27939626qkg.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTMh1XdIBMBbevjWIsHmClI1dbdzDP2/JU+FBcW3VOM=;
        b=e7GCYwKyx97WB+O03DlWeP0sf2PA7c0KOzzptttLOA6Eqwd6FmsN+oKbpW+rSLttD/
         /faiifI8KgAjs5S5NrbdcaWxFhTSMnYrb0k6idPfX36JLkQ4zi7vIhfMowbP+yAwLY27
         eke217om93w2wyEICwA1uO9ScSVQ3jzc49VuFigUt3QEQ+rzOfObuxDF9NVkl2odhZAy
         Fx3xCg4Y1kwwJXMmxzNPA+uNfTrtDN6ms5l2JtDv3hFETll966DMA7gIWyRxloWxBs/X
         hUoL2WKPFsxDkmfGfKJbrKzbDK+cFIGRTOvGq8ui/zSiaKPCHp+LxQUaAPkIHZyfHNBu
         Dkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTMh1XdIBMBbevjWIsHmClI1dbdzDP2/JU+FBcW3VOM=;
        b=fmDEi44JY/p5l+/HrGmuOuXqTAqFTQWJxVnxpl7/D3mCYK6JJGx5SgTSMZiMDeWwpG
         VjVOOvz/cvFIZvir5Kz2Dye5O2NXP8YLdJ44UX7nx6EJwM+RSvtpIdO+qhyLuZHSvjLk
         teSiek/qIP9nj1Q+WWq6eMJxqh93WeScjdEKdMwx/KDCT+iPwsMoZa8dzuW7kPgvdPUq
         IQfTkKWTAh/lk4zyhNCaY2geBnoJVBR3bmomIzLOXOqekRHPc4FZBisQHWCgvaIWxzid
         t4KcNfDQSlowZn7opuOIAgliHrkNaSBnaUvkMIg5YFVTJwr002CY0QRJHwUBFtZfsS6e
         /oJA==
X-Gm-Message-State: AOAM530i2To3ur58IM2hzNKTGhAYIcP2t288zZNLWYCG3FGzDA3XNz/x
        jptlncmcIXDxcK83bsuKOKGRY+wleuDdCg==
X-Google-Smtp-Source: ABdhPJzbsbjWByINZzTpSmwSoETjpi1oSfmF3IdmhDnKbUJR+rTQp2GdvBXkU3l+8BvhjOxoCOKM+g==
X-Received: by 2002:a05:620a:958:: with SMTP id w24mr53768226qkw.20.1594136581011;
        Tue, 07 Jul 2020 08:43:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t57sm26732549qtc.91.2020.07.07.08.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 06/23] btrfs: call btrfs_try_granting_tickets when freeing reserved bytes
Date:   Tue,  7 Jul 2020 11:42:29 -0400
Message-Id: <20200707154246.52844-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were missing a call to btrfs_try_granting_tickets in
btrfs_free_reserved_bytes, so add it to handle the case where we're able
to satisfy an allocation because we've freed a pending reservation.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 09b796a081dd..7b04cf4eeff3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3090,6 +3090,8 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 	if (delalloc)
 		cache->delalloc_bytes -= num_bytes;
 	spin_unlock(&cache->lock);
+
+	btrfs_try_granting_tickets(cache->fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
 
-- 
2.24.1

