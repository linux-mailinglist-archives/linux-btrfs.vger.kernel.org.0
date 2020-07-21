Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3372281EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgGUOWm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOWm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:22:42 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC12AC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:41 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b79so5625721qkg.9
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=psc9iFpr11NrkpfCqKSXQMbsM0IUWL8y4wKOAVQjwHQ=;
        b=2PVC+XazFngzPvXoQL8FrwEPkEsgxVEKlnR9m62yaOMLNBtdMzHiT0nSISBNJiK+7q
         RTnLbP8Mdc9jHhMccquCj4qEsPGluQxew8RAPCIYigA6IuV0IBuQBL1HV91HqDDLR0T1
         ++4RNwc1MT1HPnfnonEHYrXo22dMrsV6VtmTDS4iFMo5nOZ5U5D5EZUJvVYyGijA1/6w
         AStIbtw5m/nRJP9LJHrG9X5F/GJT62Ry1gdQk4dcHfvXHJ5dA+wLuNge89svef7n9rVn
         tqBtP+4Pwxe5EtsHB4x/fLOoVn2+unQ7CAOZ9/gJIyk5t0SPEHGmcuS7zywp7MxZa2z8
         IPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=psc9iFpr11NrkpfCqKSXQMbsM0IUWL8y4wKOAVQjwHQ=;
        b=Cb0sJUF9AQKvw+21ZwCMxdsQwn+82HZPliV/BHuxcNO6Ll1s39CUAyyvm/GW1qphQU
         G0qGzWEotoG8ggDWlWxR/jQjV6MrWBlxP7jwmFE64mbx+vL5ldXdXppzEUbdGn/O28Yf
         I+Kua8jUyshe3GcwNiqjnqZN6qbssRUnkpfFXBy3XCpkQAxRlJdhf25KW42Yzfq1HS9R
         CQ7OBxhBWE2Yt1iz7Tr6KpBVH2k1GaxQKhaxj5L431hdWTshlqM4r6VrzMnHQhWIXmZa
         4sy6eziQuU/pKL84alAxzI6ESWEAZlfo2iroTX1z58b6+KnudLWWns6eZb+5ZEf+4aAs
         lGtg==
X-Gm-Message-State: AOAM530EiJqTJXhh+T2YkAIa/Y/SRFIYZn1xFhPexCgHJY8+b6VONZ8b
        kCFgFRZORvhB/qZBX0xQ3qVq5mU50HJkNA==
X-Google-Smtp-Source: ABdhPJwyTXiiveNJb+IPICraKRrRr/qb9zJZ4bPQM5nyFj3dCbIGMJ3vyKw7n0+ek/QPdbt20wY4pQ==
X-Received: by 2002:a05:620a:63a:: with SMTP id 26mr15132085qkv.490.1595341360743;
        Tue, 21 Jul 2020 07:22:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y22sm22726166qth.46.2020.07.21.07.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:22:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/23] btrfs: remove orig from shrink_delalloc
Date:   Tue, 21 Jul 2020 10:22:13 -0400
Message-Id: <20200721142234.2680-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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
index ef6e264746fc..10cae5b55235 100644
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

