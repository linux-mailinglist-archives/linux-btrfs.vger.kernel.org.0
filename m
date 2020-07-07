Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC52C2172AC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgGGPmz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPmz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:42:55 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE02C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:42:55 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q198so38534965qka.2
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpLoVxtYuKq3xuBN6YWOovH3J+ch/wI4zzBLssFwCZc=;
        b=oW7pS4M1Omavo2E7RbFBI91o0X8F3hHGdwpq2dDtgN+sXhNGujqp/VeziDIdd5a01u
         yBI4JvHk9xo4Yspx5Y6xnFqNjD5riVMLjW8JrYOPL3Lk5Fc0UoXR58FGmLx6VWTlz6Eo
         ki8l6ci723JMlHUu9xwy/aMalNdCj7WrvOYa5YGAUgJZJTpbIABr7SnNy5vVwHdP1b/+
         P0A5J6ozQYbygHaivDBYLGeK9UB3QTrOJDBx+SExQa4zpzrnirdCqpneiEuvhGblmr4k
         qoXIcBdf5bWVnFpJ+Ct+3596oy48rpsDM06+Ktg/LoOfSmfHsOBZJLK/AJDdY0RCpk+6
         abPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpLoVxtYuKq3xuBN6YWOovH3J+ch/wI4zzBLssFwCZc=;
        b=Jc3uXsIMcdoQqr2zOuluBNxONJNO/ZtfvmY+vaEHQ92Jl+U+KT3+bDqPkgCzLUdPCy
         Hw4PKdr3pzkYexrgHPmMQ6nJImZ8MGgEnxOPpu37IGTuYwuBlY85AUKExNgBkG4xaiEW
         cH4Fe0Dpatg+fjHRZeYXGP1TcdXov/yqX1WzjsPZ9IZELSq11eI3X2qcTe7qPTgWRZDw
         OIGLI1E56Gjr0FnQR59JaMMEyocoknuIbWq+zHz3Bgrxxqfieu7wX+G7bGFyFNI/FBtq
         q4FEIDtoybZW8nMMqF3qPqAyJRfZqwS2JQ2U2ZddobQpz3zpzMbUda8yOHs9EgrdfLe7
         Wj0A==
X-Gm-Message-State: AOAM531DxzB4p4Bes/UIC1xg4+hdu+2vLaWAtGe63aDzAaDFCzz7I4px
        L3Aw9jCCyC/T0NwyJEAfs9s+cod71ostKA==
X-Google-Smtp-Source: ABdhPJxRLulU+0W5ieoSVsv0frkar7rXNCQGdP72UF6yXUEEu81sFqijXn5DRGtxX5NYX5sN2uM5Og==
X-Received: by 2002:a37:51c6:: with SMTP id f189mr53133172qkb.339.1594136574186;
        Tue, 07 Jul 2020 08:42:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q189sm24382921qke.21.2020.07.07.08.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:42:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/23] btrfs: remove orig from shrink_delalloc
Date:   Tue,  7 Jul 2020 11:42:25 -0400
Message-Id: <20200707154246.52844-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't use this anywhere inside of shrink_delalloc, remove it.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 571b87cf1c41..266b9887fda4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -517,7 +517,7 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
  * shrink metadata reservation for delalloc
  */
 static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
-			    u64 orig, bool wait_ordered)
+			    bool wait_ordered)
 {
 	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
@@ -742,7 +742,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes * 2, num_bytes,
+		shrink_delalloc(fs_info, num_bytes * 2,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

