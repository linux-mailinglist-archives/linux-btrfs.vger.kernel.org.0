Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9261F44B01A
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 16:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhKIPO7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 10:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhKIPO6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 10:14:58 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1381C061764
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 07:12:12 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id b17so14420486qvl.9
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 07:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zVB3RqvDnL/UuuXLrtef8qIkZdoUFKQN42oehYvzxPY=;
        b=1w2tJHoaxef5RSBeyLJ2gD5RHhA7+cDYghmREW/RmhQiRcUyLoM827TPB3hQNAGC9Z
         IFO25dL1XD8Rwg2HMBxhMm8+zkdML3GP9/5B2awpQ5GsIN9qtHJXNGXRZE4eYATqKcft
         7sAUCIdGWKeXYpkbJJGM/tsdS8vgmfnO8Y5gNFIqxqzWs5P2nGBwhgf718VMNYEfAq2+
         lKHnlIP+nH09KJjy+NwnIJwz+XHAqKjJH7hEZsWUbpK1fTNDS7roR1Z/Y+pcVmMDMGO5
         9PLD/OjgtWiYflTZLDayDu2VOoQTkcOweWo5Nr0Ewvq6AZEzS4FBBgT6sdIMZJhIWXJR
         1hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVB3RqvDnL/UuuXLrtef8qIkZdoUFKQN42oehYvzxPY=;
        b=KIOZoY36nsuRmO1rsA6POKM0Fm3pD6ioZlf7ef9KEui7TcV7fEYtHRCJVKb1MGDH5y
         TLdlGhl95nJJh+FfP5aVcMVbnguYWRZfXIg9rVhCprTfmTz7HUp4d3Ya3ClrdF6WUj9b
         jrYQoUlGOljnRrE+uBFdypHJ1F37Ap/yX+7OjOehPaGFxh3Lu5tM8rg2uLnRZDLAvdD8
         kzlCjwdlEkMOq7OcVM9nQhZGUTK7rCTXOZ3KHVZ4P1VUBP6NrbtfmPCMq6LMGhPqeQZj
         X7f/0NSR1Ru8NNLDZj86TbDz2TpZ0A0B0RXselW+526f0QLqQ7l2x2Pkfs/ybG531YaT
         toHQ==
X-Gm-Message-State: AOAM532e61WbkkoNRi0XmUr/3exv3N/FChSq1SgJMioBMSCsA0xzgwko
        ewmP+jKo/VW6ahUO43UE6kcQoNRenwf5Dg==
X-Google-Smtp-Source: ABdhPJw+OEg0XHeF2eWSN6rXGZZNBvEc3kmwH9FEz7iYfTqcetfid2HgDO+dFK/XqgvwX/hhdsMqow==
X-Received: by 2002:ad4:4e49:: with SMTP id eb9mr7856814qvb.22.1636470731865;
        Tue, 09 Nov 2021 07:12:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bl28sm6604290qkb.44.2021.11.09.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 07:12:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 2/7] btrfs: check for priority ticket granting before flushing
Date:   Tue,  9 Nov 2021 10:12:02 -0500
Message-Id: <efd7030290cfce311cea39f381b2e5cb38761336.1636470628.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636470628.git.josef@toxicpanda.com>
References: <cover.1636470628.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we're dropping locks before we enter the priority flushing loops
we could have had our ticket granted before we got the space_info->lock.
So add this check to avoid doing some extra flushing in the priority
flushing cases.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 9d6048f54097..9a362f3a6df4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1264,7 +1264,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 
 	spin_lock(&space_info->lock);
 	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
-	if (!to_reclaim) {
+	if (!to_reclaim || ticket->bytes == 0) {
 		spin_unlock(&space_info->lock);
 		return;
 	}
@@ -1297,6 +1297,13 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 					struct reserve_ticket *ticket)
 {
 	spin_lock(&space_info->lock);
+
+	/* We could have been granted before we got here. */
+	if (ticket->bytes == 0) {
+		spin_unlock(&space_info->lock);
+		return;
+	}
+
 	while (!space_info->full) {
 		spin_unlock(&space_info->lock);
 		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
-- 
2.26.3

