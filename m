Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60C82189A7
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgGHOAb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgGHOAb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:31 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1E5C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e12so34496704qtr.9
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wxLlTO38pSaivYDhn6/e+gzVkShJaxbwsw4D9UDfLoE=;
        b=VO7gtwJUZXFj1wLci8XkjO2c+0i00Yr+G2dHmu8gSY6TzN5G1zYXwmE32t5EtS6jJj
         c3wtVUAS8LhFkP9rDFA+EwIvYCaKbJfwaswLl7C/+PbKvFBP4jTNaJ/Twi8662p9FjM9
         fTp8qRdSvdysixUmzz4HMHShVLAPK22Op3AKmJPIXAQJBezSq1SPaGYwlfIt57zgNpCL
         wqnDhCzup7aZwQ61VfSOcftEaDvPs704shnoDypjnkVmbY0qeJ9FwxitKGds5qvJI3XV
         UdcblTrjAf03Hm+fwEAfEEhAb/tHu6jR+9SvBYxHQU6QUUDWlRBFKRyhb7JVHv4ocvhl
         dYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wxLlTO38pSaivYDhn6/e+gzVkShJaxbwsw4D9UDfLoE=;
        b=R9r1FiewyUQXRE6tlQkaZLugBZoTvkXdmfNQ0iE8qtYti/uawDxROj18/zFNLhaeVK
         kKFRPH7XMJ9O2Fnjyef0jHfi/HDRXc6YxrhoCQB48N2kFq1BIdw8ZFuN0QV+UZ5ovMH7
         sT7urqrSclPmJ9GDEjuv8yYAQSj6W5giP+S1cWv9w0ygxb/HGqmMAxZQrq+8oU0uDIcF
         0iw0Uo8CUs8mabDTEtcOn+bNOj7cm6PHFqZJG1xgoQpMvZbGg/3c/K4BpE4WYyssAc3g
         s4cqty3CzFPBypF5d/Nj2nqZP+XNoV0DWNuYTRYQaJ1DQ5WL5/CyDmrU/L9iNg8SjXBJ
         sgTg==
X-Gm-Message-State: AOAM53134Y/R/ExMiTN+FUHgDQT8yjDZ+l+KlGmIocUPcjoFssLsh/D9
        4+YVbc+gaAIsyrfVbpZLbdFYpnZOl6l8sw==
X-Google-Smtp-Source: ABdhPJyodWiYuuXpbCBzGv1+V4KDbCd5g2ES+xtAGEYgUyThAVwxL2iD8aV52xUqG3VBNPoxRoGXQQ==
X-Received: by 2002:ac8:27c9:: with SMTP id x9mr40593007qtx.172.1594216830109;
        Wed, 08 Jul 2020 07:00:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z18sm31762633qta.51.2020.07.08.07.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 06/23] btrfs: call btrfs_try_granting_tickets when freeing reserved bytes
Date:   Wed,  8 Jul 2020 09:59:56 -0400
Message-Id: <20200708140013.56994-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
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
index 3aa78952a2b7..daf88891a40a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3091,6 +3091,8 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 	if (delalloc)
 		cache->delalloc_bytes -= num_bytes;
 	spin_unlock(&cache->lock);
+
+	btrfs_try_granting_tickets(cache->fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
 
-- 
2.24.1

