Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B011412F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgAQV1H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:07 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44276 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbgAQV1H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:07 -0500
Received: by mail-qv1-f68.google.com with SMTP id n8so11353506qvg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7dXPcLtcCSCDRGETr4vm+QgKm0KbD9S2RIf4ehLy/AM=;
        b=Ve113yvma78zo/lDcr6Y3p/2bn0mK2g0gbzxrEg8h30/veg/aEUbfhPYodktSU03oL
         cpfz3tjZYNoltPav3GkHq6ZPK2jwLQxlA3826WZe3VFe7HWO/l3+UMj2+usrwiKY2CyW
         aehMFN4tUgftm3gcBzSkI+igvplHgECiT+xjDstInUcgNHZWtfUNMLkpO663vlbzw6p+
         uC+oxuBhFhgxC2C0fpdYVDBVDN0pH7q4SiWatF65g3sXtCyOAmXUlIqEDxnLhRkpDedp
         83jvb9LvcOrXMsrx9C8nkz/asRNSzH0pYwOiBWB7EID30EQiVwBA4n5oydyzSzzRZ/az
         3BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7dXPcLtcCSCDRGETr4vm+QgKm0KbD9S2RIf4ehLy/AM=;
        b=PjjipE8q1AMQI4BtVrfQcoppV1IAoecnAUeRRq2xDE5NpHDDFTmvxTjfu4v13dzO1I
         J/yap2nSOjOTjn98c8aCeTUgKFwysMZZQIrPRaLI5gNkcB36KghxlgznCs2CpZ76br4n
         2wD5AGhvwc1n9dXeydSATpCl19ZpgJ9zmPABirOIeGw31ocrmbW8KU46kwR7IBVYc8ds
         1jt+7tF+g4tmYJqSt5kr1c95NhsqU3zvGGAfgCfVGi6bJYnqjS6yIdUAXIM89/1NNblO
         oMPr0eoAn9JWAjtHjGoQXu6LBSC0SkkoxTQ+yfFI7mKfMiETf0kI7OYKH+8+uGv2g71U
         BLOQ==
X-Gm-Message-State: APjAAAXl/VYVw0fifM4XBKkOLNBE/bESA13UMSAWudx4rV8ncWArWMJq
        t6hS3ryPxBzK+XQkdm4290XgWn9/MryX8w==
X-Google-Smtp-Source: APXvYqwemu9xAGhaYzRu/6KEqoE1IW2WDbl4fpDrE8x7xLSst9/5OKOgjC60W/gnSVr9qz20ZdzaKQ==
X-Received: by 2002:a0c:8d0a:: with SMTP id r10mr9235989qvb.7.1579296426297;
        Fri, 17 Jan 2020 13:27:06 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z141sm12390874qkb.63.2020.01.17.13.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:27:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 35/43] btrfs: hold a ref on the root in btrfs_check_uuid_tree_entry
Date:   Fri, 17 Jan 2020 16:25:54 -0500
Message-Id: <20200117212602.6737-36-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup the uuid of arbitrary subvolumes, hold a ref on the root while
we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ce3eff93c366..527b0b41ebdc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4382,6 +4382,10 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 			ret = 1;
 		goto out;
 	}
+	if (!btrfs_grab_fs_root(subvol_root)) {
+		ret = 1;
+		goto out;
+	}
 
 	switch (type) {
 	case BTRFS_UUID_KEY_SUBVOL:
@@ -4394,7 +4398,7 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 			ret = 1;
 		break;
 	}
-
+	btrfs_put_fs_root(subvol_root);
 out:
 	return ret;
 }
-- 
2.24.1

