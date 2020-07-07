Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C72172B2
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgGGPnH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPnG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:06 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0BEC061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:06 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 6so6784347qtt.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lSf+3a72PAiNlMwNS/uTdBTwmHFW8V8FvMYLaHzUIks=;
        b=qQSHzAu0Z9u1rIpgsaLLocTLmxh3eUhk4tNIXeyYS2g+XbqG++UmI9SH4PZKq2ERsh
         nmNKMxr8t5RYdn2dZmz+qsMJ5LbrIFl5P5GAz/oGqUM2KGJuYz8LSD+IDr73gYTBZLZt
         eHWIyx1XYqgFvGLJ6Fhn6y6FP9ZlZcXyXOPxHyHu4C2B8Oq5cxWpGItcX+offgXXM8aN
         8xe+duFV2JDhwfGntfOgqypsQQvM9cM1gp3FjtH2E4l8nOua972TyMmIcx7/PQu2kHSi
         Og00Rhb5apPkTGQzU5hPKrgLKlkPr977tNXrPMCEEpV+jO7zdtRGwjtoq5ZzdfEvR9+S
         6Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lSf+3a72PAiNlMwNS/uTdBTwmHFW8V8FvMYLaHzUIks=;
        b=PjzaJLO1p/DrgdXzcqxX1gwEE6rjKhEvqgDQKnTx2hYuEyCdRvYoaRLkJkwiURoHHX
         Z4DJClTVW9D3fS8nGrVBz983UNLLpacc6ny83vLxGES7nG1eEPgM4oAYEoCTRxmj4Jqd
         QAdk9xlrYJaR2UFlwLBw8iRZvVja9dt1dIUl7L24GkHMtmMCBbD6AxS88aSddd/h+S98
         5+QwVlju4N3Q3KZSDdGTS3LAOPxqR46vc/AB89fr9CZoDJ40JOhll24MFqPTftK/OrU7
         oBV6bWUajgyXUXs8uaukexRn1p8bpHjViBbL4eZeE6QAtqU+v5KIOU9YTrNA5xw0SW0Q
         Tc3w==
X-Gm-Message-State: AOAM5328RUycAzDejmzelJpaH11+PwQzu+oTZeGJyYZPft2dXg8LJHmV
        zI2cZwZ2875s4sN5ahr+ZV/rS+NkkUSHWQ==
X-Google-Smtp-Source: ABdhPJwoiWLdAhq3L1li4PgjFmIfNY+Vtn/dPkyTElVXvJo+7oq4Yx09LRvfwdkkvoDMUe6S9HF6gg==
X-Received: by 2002:ac8:554f:: with SMTP id o15mr56311653qtr.278.1594136585513;
        Tue, 07 Jul 2020 08:43:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f54sm29637141qte.76.2020.07.07.08.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 08/23] btrfs: call btrfs_try_granting_tickets when reserving space
Date:   Tue,  7 Jul 2020 11:42:31 -0400
Message-Id: <20200707154246.52844-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have compression on we could free up more space than we reserved,
and thus be able to make a space reservation.  Add the call for this
scenario.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7b04cf4eeff3..df0ae5ab49bb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3057,6 +3057,13 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 						      space_info, -ram_bytes);
 		if (delalloc)
 			cache->delalloc_bytes += num_bytes;
+
+		/*
+		 * Compression can use less space than we reserved, so wake
+		 * tickets if that happens.
+		 */
+		if (num_bytes < ram_bytes)
+			btrfs_try_granting_tickets(cache->fs_info, space_info);
 	}
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
-- 
2.24.1

