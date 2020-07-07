Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005C62172B1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgGGPnE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPnE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB372C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:03 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 6so6784212qtt.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eyMNWoi2hC8qlRuAY9xprTphnhdSNxjekwZC/C82Cw=;
        b=ymtrum+ykktESV3a2hBp2Kt9vWIcLzXc0dAqpvUJJQGyFddqnEQCd3kAXu/DlqEfAd
         dkPgIIVYKXWNCPX01NtgkBaqqHzu0iLXxfB1T9SgW5U60HLWApyuXXzD/MNDFe59oSpT
         KeNmd1DHoCbmJu+GVTZlmTDWJIu5T+2118C01jthega2bTyrQKI81f+qZzc7dqv+egmL
         eBoHQU9/h2hwj6/Mz+k8KiFIEJqbsHf63+Xs/aMETousTMcCwvrTavPPrdonOSChh5la
         LLDrNYTgKDkaBKG2Pj/k1BzRyT9IXlWsxl9GY+6mX/+VMVS5yhcn+Z/gYO+ts/qIculh
         AZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1eyMNWoi2hC8qlRuAY9xprTphnhdSNxjekwZC/C82Cw=;
        b=TCxuk+oO4/b2NUFRKsp8MljXoAHEEiqpxIosMlRgo4WHMAe6g4khoLNS5B5S0ohMC0
         6GzH+i1qywMhG+vyczh+zffHynJytM6F7aAmjwAFnNVdvMHMZEAQz3AHoU7QR/lni9V2
         68cXrKx3bIfwoze7YZArGOj893u3UvgibxkypwgF6GArDJ8QoUf2Bh0P3kaLzkgJlYDl
         pgDr76enS4M1J76ImzO57qtLlml3oAkk9GimwbTOtqlWuM21GkD2ccrCV3mRrd0QQ8gh
         C1gc6HaC1XGHqtd68aGc2QPh3b9+wZ4BvgLkxObo8IeS5gx6ylfU4T1FJsSJU0Q2dxly
         sLGA==
X-Gm-Message-State: AOAM53055rZOgU+ZW7APnH9QOkTDQpUFrVmDNM+XPy75iNbFDFRczvdk
        RPnAqDFzJCbD23e37YMUKcJYsRABlle9nw==
X-Google-Smtp-Source: ABdhPJx4ZsjfvWJ6N0NZtWAvSzAjEAF/vINHoh82r+kqhXXv7HxUOzJ1GDg23jyfSq17XD2SLElTWA==
X-Received: by 2002:ac8:1baf:: with SMTP id z44mr56901328qtj.129.1594136582743;
        Tue, 07 Jul 2020 08:43:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o145sm24010818qke.2.2020.07.07.08.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/23] btrfs: call btrfs_try_granting_tickets when unpinning anything
Date:   Tue,  7 Jul 2020 11:42:30 -0400
Message-Id: <20200707154246.52844-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
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

