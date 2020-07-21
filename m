Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6652281F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgGUOW4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOW4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:22:56 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A7AC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g26so9204432qka.3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Ci5z3yMI3h5IFqCrR0RnubjoKZNhhjifg4W5m/gO7o=;
        b=1SOtag+a6bvoZ307eHdEyAlDNcjWumwvPri0ficPJgtKwlWBqOSjxbJzvw+Sjdeqzv
         6gYTWIQt2pZjONjaMSvmrZ3XFt6rYSx/feEPF8wwj/7S1Qp1zE9h2fyc0bMHFZjA/uak
         o7MlYWyka7M/SzuuXWNYJCeot0EU9CVzT/giHQ1+zmRIIK292ogKWFJXYroiRntATVJD
         QWF48seZvVwj+QF/ZicHReBxrMV7YelJ7XnJb/zIsgGE45+bCxTld51AznJkn/fXoBv6
         FC7Ka9D7BwE0E2daSAc6CDzFAxypRrpNQwoPQiO1OEg5GMghMJqu3+8Nf4qkbUhBiEih
         eM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Ci5z3yMI3h5IFqCrR0RnubjoKZNhhjifg4W5m/gO7o=;
        b=QLO0UTOLS7gp2mIQu8WoPGcmfOT1C8KCWBelKx4ts/KdWyTSggpcey/1FK2Utw3hfn
         8WTilLq+Wu2c79gtjIpzLys8utcuWY1ErJ5qF5OcFBmx6XChywA3sBn5CLFz4Qr6Wneb
         U29wR5oWsRiMPJAKPd5riglcI0LGqKIbJAOLpBn4PQbKFOiSSYUkKfinJ8R2xHQToCcy
         T9ruPw9KZ4EpKpPFh/Ve4IjbcqPHplKUjjfNjg6ZFYZVZlzg6/qgG/FRaAndtlgbxt81
         r1+Nnl2yODVh108Tk68Tkp+cVyV1jPxNdbr3HiyrZmlYIM3pm88uFvmMPUFsFK3UflFI
         drwg==
X-Gm-Message-State: AOAM531ZWoPSD3MTunpm93u3ynjXp8eUFPlJ+oWGTpLCHTbmITnuXHxm
        gvpTgjeNtSgyFCbn2N2uOF8kuea/Dt6ebw==
X-Google-Smtp-Source: ABdhPJx5Oa6G7+OSr9fwAzvEv705RqUTlG56ZtV4pPdvtxJ65fNlEMHI+H881k9WGyIN2pflvooMGw==
X-Received: by 2002:a37:8d85:: with SMTP id p127mr20118479qkd.225.1595341374867;
        Tue, 21 Jul 2020 07:22:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j45sm22501689qtk.31.2020.07.21.07.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:22:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/23] btrfs: use the btrfs_space_info_free_bytes_may_use helper for delalloc
Date:   Tue, 21 Jul 2020 10:22:20 -0400
Message-Id: <20200721142234.2680-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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
index 0e354e9e57d0..0a41bdcc14d1 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -277,9 +277,7 @@ void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
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

