Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8D3D7EA9
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 21:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhG0Try (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhG0Trx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 15:47:53 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9489DC061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:47:53 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x9so10362854qtw.13
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QbeSJFamkwCvtcUpnbVG8H9a/l+HBgautDqkaGgKT3A=;
        b=vargzVUodOPqJ+Qsa6K+pQtMJEk2aa4GRNyqV0qPaYgPHok4RtVpR+M3ez8fm/8ctD
         5qIZ4lqol+tmDm/uob8fkQ2+tBSUcF5Pcupnln1NSS20B/KIUkwGsVopAz9fTdo1euZX
         0GdhzO5/WVNcunDxQCEaaQI6eBPrrCwqfRh33HZjBkIJ6EGDWSyjOSYfcf8LpQaRdHqk
         p8j//Vfm0av6dTpHfrgtB1lZGqE4heN2hLe8Cuc6wPUW+5wiEmzYBjR1txT67ZSybJiN
         NxD8Oodgk6f1IdQjVhiRk4zgalgs95Gg0UcfXQoO5sKyKEyk0zuvN6JIAYGuuAqniiVb
         oLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbeSJFamkwCvtcUpnbVG8H9a/l+HBgautDqkaGgKT3A=;
        b=adw1A7786E/084O3yczAG7wn8ngc74iRmw6J7N0+37gbNke5yQRGhtXe6tQjyU0w5+
         v4LZ7rFn46CpmO2+Vx3m9wIN8+IEEczC1A53gyikO1ZoJrOedCSxee8lZpYBYkGaLsnY
         sj4GT4EBDthRO/d5MVOwXy6Ac3BmfN+GjAffWz3edLbBjjPBrNwOiFncMgqkm2baU2rw
         luJakXWOXzAxFm0Z6b3rQoQNrPLJ8Lrq8p+es2F9oVErJOdbc9QVSshbmjhNBkLUjWb8
         4KWaq7frHANpppBYSfhlhyWPt1paS3H4ufgg+Gx5C+ra8bXzjfU60u9W4HVm3jpxslso
         hAxQ==
X-Gm-Message-State: AOAM532HEgGdmphMS1pgX+fSCEjwj7XJBxDae3ob6DoIelpg4nayymiJ
        xQMYJ4+sFf7/ZPuKWwcPn2ILRBwWViX2Ftm1
X-Google-Smtp-Source: ABdhPJxq6osR6gVAPiZ1opZFIgg8apwubLATLFydMibu95UsZDGwNk12e93liDWqb3shtbWV5HrVGw==
X-Received: by 2002:a05:622a:1653:: with SMTP id y19mr21077846qtj.305.1627415272404;
        Tue, 27 Jul 2021 12:47:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z23sm1829651qts.96.2021.07.27.12.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:47:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/6] btrfs: do not check for ->num_devices == 0 in rm_device
Date:   Tue, 27 Jul 2021 15:47:43 -0400
Message-Id: <00156ba3c68ac186cf4895fd9e62b50a504c550f.1627414703.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1627414703.git.josef@toxicpanda.com>
References: <cover.1627414703.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're specifically prohibited from removing the last device in a file
system, so this check is meaningless and the code can be deleted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 86846d6e58d0..373be4e54f28 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2199,13 +2199,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	btrfs_close_bdev(device);
 	synchronize_rcu();
 	btrfs_free_device(device);
-
-	if (cur_devices->open_devices == 0) {
-		list_del_init(&cur_devices->seed_list);
-		close_fs_devices(cur_devices);
-		free_fs_devices(cur_devices);
-	}
-
 out:
 	mutex_unlock(&uuid_mutex);
 	return ret;
-- 
2.26.3

