Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074A020F68B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 15:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbgF3N7q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 09:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388356AbgF3N7p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5936CC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:45 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j80so18631620qke.0
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuOlF8IpTn7Y/ZwFI/h0PcotCrvJ7Q9POZ2Ys6bf7Po=;
        b=DFY9bK6ove4w5+qG3b2vq2K+5nyHFnfz4OMaVU6lhLLxDaS7R52UcaYn9KHwHVaTHu
         kQxs3EABgzStiHVFHHBcw7+TR1BdR38icPXhigjhtHgEjMy0Ckrruzpq5314T/MJ++i1
         R46HpFFTXkWeRB9/q1zZJCgK0LzvpgvIO1yCtqUCiMG3Sac6UPXb4k1mmgqGC1bhIFzh
         YyLoPDyn/News1aSL9CwQ6Y64Q524JY47x1Slj0EvAoYdCLDCP9UG6ei2AAheaN7ZHql
         1KEA90yPTMOturB/smkOHrXqBFfIY5rKRiThTaGc/7hUd/pQD0qdL05JqM4gHZA1+wIx
         KL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuOlF8IpTn7Y/ZwFI/h0PcotCrvJ7Q9POZ2Ys6bf7Po=;
        b=YCqubG2zrRO4QsCzpTi5G3WZpSunrXfddisELLUgKl9ajOh5K1qRCJl5mT4hL6m2Po
         sc9jIEG9cIPMf9DudKHCuINExC81D3dg3EAsJUd6KQWujngzYUF4acTW5HTTuI8GUK9g
         BmoXcKGnaJQocQSuLRRdXZwuVo9zR81Z7r8qmZZ51EnCkbeAM93pY7+HTMI7R2kcQ7Js
         2/N1AcgRMvJQ0xVsqEGbpek/Mds16W2fdcWo9WDdrG+Y5h+kwuVSpDbGiIcNzKA686z0
         3PlelZ+qTWv7lkJ61swm+PaMLCB8UD4hUwqxxPel9IgxlnR9vDqFSmQe5tbxyHb5MKeR
         W7mA==
X-Gm-Message-State: AOAM530PKQDrKUQvSW51dAblkO+ri0GtdEcbI7hqg5eCPD/bolsa2vuI
        wndHIfvRv2+LyFbyKzMFh1cZv1t3FI5Xmg==
X-Google-Smtp-Source: ABdhPJzFD81jkMmew0muRzK9R3EQWTcLSX4IgkcdHPypIjWiIOOEhzOnWhmRq/c/D2HDDI9ytC7atg==
X-Received: by 2002:a37:474d:: with SMTP id u74mr19157678qka.195.1593525584115;
        Tue, 30 Jun 2020 06:59:44 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t138sm3016955qka.15.2020.06.30.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/23] btrfs: use the btrfs_space_info_free_bytes_may_use helper for delalloc
Date:   Tue, 30 Jun 2020 09:59:07 -0400
Message-Id: <20200630135921.745612-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to use the ticket infrastructure for data, so use the
btrfs_space_info_free_bytes_may_use() helper in
btrfs_free_reserved_data_space_noquota() so we get the
try_granting_tickets call when we free our reservation.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delalloc-space.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index d05648f882ca..fcd75531272b 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -278,9 +278,7 @@ void btrfs_free_reserved_data_space_noquota(struct inode *inode,
 	ASSERT(IS_ALIGNED(len, fs_info->sectorsize));
 
 	data_sinfo = fs_info->data_sinfo;
-	spin_lock(&data_sinfo->lock);
-	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, -len);
-	spin_unlock(&data_sinfo->lock);
+	btrfs_space_info_free_bytes_may_use(fs_info, data_sinfo, len);
 }
 
 /*
-- 
2.24.1

