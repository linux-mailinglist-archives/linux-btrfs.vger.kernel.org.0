Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D39123089
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfLQPhX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:23 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43836 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfLQPhX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:23 -0500
Received: by mail-qt1-f195.google.com with SMTP id b3so9011101qti.10
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tqjFPaSIMWGK3trwS7bmGXN/H40JuxpLUV/LPzvJNpQ=;
        b=UJddNo0MZYr7ZubcPqJhFSZT7EiNmXAS9YcdU3mNii9nIE8FK9CiZXwQ1f2BnI1uWd
         2Pi/AIkD9LK6t1mML0OCcNza92dTC5FGmmhPsyKEZZWt2Qpo3ZzhNKmkcz7bd/aOPJtu
         CzBl9wEm532Y85McrMOGHwejIuKu16tQkf2tGEb+BOMRl2rDKXK78k3JBClxr7P7+2RL
         U56uG0AOkvnTvLI1oM68UEX/mFgzpOZNmhaFNJHuDbbooCDpnSv9d0ohMIMIOre/mjcg
         KUvHwTjHjplTv5H4Y1mh6h6cy9D8QBmej3/yOCXVlNM1Elj96yiZhGOL/scHrWM/n5zH
         IJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tqjFPaSIMWGK3trwS7bmGXN/H40JuxpLUV/LPzvJNpQ=;
        b=Bqo3orLfdTx9uh0z0WcsHzSBKVzX05wl92w2zE+YTrzDJADagGQQD1tTJCHbZtWm6x
         paTKIz0qKGItJcSyrnhM9HYQQhdbWPO6M5n5y6u7xtbGuxTAQr9bSexYvoTtZhhzt+OL
         fRHRpuK36cW9PPI9mrkeMMinMjK2UJstCgm6gUT8ChESHY6yDM2QxJRhFHldGEIEOFDr
         N9DeW2BLp04ov+mzEmsE2F7zmlL8HCJST/MsL/R3tjyYDB4bsLjcGLVxxiBIxHtBjDdW
         ZxFcPzCqTpYuEEPNCAmzx42+tr8ESq2es4cn601dgnVgm0SGI2LLQS7wRYwrS6XQwGxh
         C02Q==
X-Gm-Message-State: APjAAAUee0QezxdZ0fWVTH4f5KAPlnwmQxndW9X9yp/RgVRQZNVnV+RP
        lT16Dh7mDqsykT1LJ2REwJlEw+VrIrFeOA==
X-Google-Smtp-Source: APXvYqzR6yxc+BFOEietfF6Z2HOisJjr5BU7xm0us/AR63BaxKgc2urJ27iLtZk8itjxO3KpCTAZaw==
X-Received: by 2002:ac8:75d8:: with SMTP id z24mr4899529qtq.193.1576597041860;
        Tue, 17 Dec 2019 07:37:21 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u15sm7116518qku.67.2019.12.17.07.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 24/45] btrfs: hold a ref on the root in prepare_to_merge
Date:   Tue, 17 Dec 2019 10:36:14 -0500
Message-Id: <20191217153635.44733-25-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the reloc roots corresponding root, we need to hold a ref on
that root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 473bbbd58d31..19d69ce41f06 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2433,6 +2433,8 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		list_del_init(&reloc_root->root_list);
 
 		root = read_fs_root(fs_info, reloc_root->root_key.offset);
+		if (!btrfs_grab_fs_root(root))
+			BUG();
 		BUG_ON(IS_ERR(root));
 		BUG_ON(root->reloc_root != reloc_root);
 
@@ -2445,6 +2447,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		btrfs_update_reloc_root(trans, root);
 
 		list_add(&reloc_root->root_list, &reloc_roots);
+		btrfs_put_fs_root(root);
 	}
 
 	list_splice(&reloc_roots, &rc->reloc_roots);
-- 
2.23.0

