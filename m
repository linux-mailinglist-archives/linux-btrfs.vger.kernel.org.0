Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80F12172B3
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgGGPnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPnJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:09 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B51C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:08 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w34so12024937qte.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuOlF8IpTn7Y/ZwFI/h0PcotCrvJ7Q9POZ2Ys6bf7Po=;
        b=rkr2Zf/QlddTmfBfb7LGOebR2lh6X585cp+9mr2K06HghZR65Q7OGYSV3vHmyVL+A7
         q0EAUxLyHivwItorUE9N8ntbAp3qP4Qt0Q35ydNxnqYq+4CtRW/lDDh5G7S9lJjl5tNj
         Qv2wd5hOK0aOJNXHKUsjZP3DMpLJf0WxsQhAa9Sy3sTh29xd4SeAhxXDBSZCaQpOnk4U
         6Pmhtjty/+0WxNR7orbibOxlJGMnch7lTLTYr1YId+bf9Nte025hhrmy8sVPi3/hNsoQ
         fJNEYgHXh/1GMEKt6LJK63SXn86NYcxCadPWaemQq9JMaj/1gMJGTzwhW3PN2OfTlkln
         ji+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuOlF8IpTn7Y/ZwFI/h0PcotCrvJ7Q9POZ2Ys6bf7Po=;
        b=LJk7r3LRCpbgoPSHNcqxsyaMwwAoA3EUndvWJ768JGxA892fzdkicLuq2PH/yXxY06
         I5EvHxPnECGFsU9Dr/Kxp8JGKhcYEtpaLmjHt/0o1ql/CaZKF6pneR1SbIqTznz9qMDV
         bqfscE8vz1/zEgxuio2qCnw2RgditKQbJs4Bmd4MlYPiz+GxeLIqvjWGfNWsePb0CHtO
         Xg4nugPUv1UfQoDe5IVnpWFmKu/BI5M92/MRnkO0sWGYWB0HXTR/t75BDkOMja83KR1P
         doabfdYQGmOx8gNCMdGlDMJWfpytKbHWjUBxd3si+Zkj6dGu0Ny2ILAorQC5F9oMZeC2
         rzbA==
X-Gm-Message-State: AOAM5335MlmeJmLQiMdkUYCo71kACJHiestgySiCxEM0PPv4JamoDwCI
        8AkttetdZHpC7nhTWpge/DaRWQRRk+2DWQ==
X-Google-Smtp-Source: ABdhPJy0nxE1nX9Ra5/NOLjOuRqW7puLS74kfVW5bWGc5L5R/gmj2mnMXGHYi06nLybGzCRjxhmHpA==
X-Received: by 2002:ac8:13c9:: with SMTP id i9mr56583234qtj.284.1594136587526;
        Tue, 07 Jul 2020 08:43:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w44sm28069759qtj.86.2020.07.07.08.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/23] btrfs: use the btrfs_space_info_free_bytes_may_use helper for delalloc
Date:   Tue,  7 Jul 2020 11:42:32 -0400
Message-Id: <20200707154246.52844-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
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

