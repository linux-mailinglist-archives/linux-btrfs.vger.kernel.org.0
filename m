Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D38D9151152
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgBCUuL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:11 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45183 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgBCUuK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:10 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so15670766qkl.12
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTGjfIaHDYQoF/hYTm1AJRMmvCXZoqacbFBaWliBZVI=;
        b=eYfs/e12e5eY/8iOoo4iMqGG9THRuc6OYI3ZlVljcfmDfnoir765/4hhCjdxho3hVy
         6Nzz/mlFH8tHRGnN/aVCptDA9GYIg/tpmxgQHm9R0+H+LrhciTRAaLHllJEQKi0yAuTK
         twYqC8mLIQyPmmjZRMo0ItyBaq/ACjrgsbi0a0rWMeLpnSI13oiy9sUn8bSVlEqOlx8C
         TNt1gEafZzjXXILyQaxLhZ0YL5dLxDKexZVoG4JNtNuPULa+n87Rki2Mf81vbFo6684Z
         QPggqc1Ytrlcq0yqh4ip+j51A6ybdq8Uw8k1JHL4ZLMB/6Umd+pLcEG3jyO6qHESGvZI
         C7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTGjfIaHDYQoF/hYTm1AJRMmvCXZoqacbFBaWliBZVI=;
        b=bGI6H+Ey6/A5ulHiNaLp4zAMcnDGfnUJ+ZjVKG8X0+aXlxLzB6X27Nkm+gtSPx51PD
         ye02pPCATFLts+VaRmvTBPNrsx58QTqosifRt210mW8E2T7J1i5vAT0Othtu5flr+KXB
         xL5PrI4zxqxFv4/TWrJevQcHcO7D9R+gHOk0igEqXaJ+8FY4q7FxNjpWl343yv1s0lda
         sHtOVmuaRLmyw3k5NQq1Nmt8NFgQncEJvUDy34wo8GSBB4EHU42gyCdNKGCqChQKbU3y
         VUX4VzL4L1yPJZXuEkbdEmZD+T2pyBjMCL61eGaXSyqiFiZKNi97x14tUT5XS69Pts1c
         3O/w==
X-Gm-Message-State: APjAAAWCDRO+UZUxAPoINfH8nx5dyyjkVWRzz2E9iY4QbWzxpn8oz0FR
        9zN+y+mzGuHftJvgNGZ9TJJ1p97EYlMhUQ==
X-Google-Smtp-Source: APXvYqw5GL7w5f7ftUAVp+JPopvqQ+Cue9nzEgPokZiMNEnuP3XTWxxxozX2CwZtJZRLosn84/pbRg==
X-Received: by 2002:a37:c244:: with SMTP id j4mr24499571qkm.433.1580763009044;
        Mon, 03 Feb 2020 12:50:09 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z34sm10566242qtd.42.2020.02.03.12.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/24] btrfs: use the btrfs_space_info_free_bytes_may_use helper for delalloc
Date:   Mon,  3 Feb 2020 15:49:36 -0500
Message-Id: <20200203204951.517751-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
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
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delalloc-space.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 4cdac4d834f5..08cfef49f88b 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -179,9 +179,7 @@ void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
 	start = round_down(start, fs_info->sectorsize);
 
 	data_sinfo = fs_info->data_sinfo;
-	spin_lock(&data_sinfo->lock);
-	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, -len);
-	spin_unlock(&data_sinfo->lock);
+	btrfs_space_info_free_bytes_may_use(fs_info, data_sinfo, len);
 }
 
 /*
-- 
2.24.1

