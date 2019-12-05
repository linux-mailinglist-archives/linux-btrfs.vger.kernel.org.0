Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6397E114163
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 14:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfLENUM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 08:20:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38152 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbfLENUK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 08:20:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so3561469wrh.5
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 05:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f75aBtieWlV+gKe2NKSv4ElkYcQqQ1WGTJiguF3h/UQ=;
        b=ZtHiCSN+Qe7grlIoi1pba/pHbGwCuoErumZy7IQuEJ22ViaBr4bVlhTm3Wo+IL4lTf
         csvKWM7nu/48nnbjhBRAZuTuFYGEW2j0RISsvnyzU8MWsXsDU8GUlSzRgJuGqBJlOL/d
         V5OhUNoZM9Q6lwT+RbZrQAyNtBBsf1aQFho4ehzRoV01/lqpeJWeJ0ndTN8L4VIcr8Zi
         lz2c4JmTaSVSPSQkgUMbgZFZVU6VchoKoyYR8QkqqLSrjOc8X5YLx3VjJI+PCVYhwPLo
         oqkjmvg3946QQ3Sl4qYMO3WxwS7tEwTSrHw5JN9Ftdvl5tMEc2+3v2fEwMIViIsvh43x
         AuyQ==
X-Gm-Message-State: APjAAAWXSy1LIcsmwAmwjO6PNGy+IXL9GPGrQYzyUhm+Z2aqf8qVTiaF
        W9Mw2HQmqmal1l9M44+/iDoCvYF4fNI=
X-Google-Smtp-Source: APXvYqzU7Tp3ZItkkANa9IF/YOPWbHr8Buhyv5JWN9Rlq769MQI255DpbllsBWn7m+6R40BANSu2zw==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr10127686wro.128.1575552008789;
        Thu, 05 Dec 2019 05:20:08 -0800 (PST)
Received: from localhost.localdomain (ppp-46-244-194-187.dynamic.mnet-online.de. [46.244.194.187])
        by smtp.gmail.com with ESMTPSA id f67sm10482515wme.16.2019.12.05.05.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 05:20:08 -0800 (PST)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 3/3] btrfs: remove impossible WARN_ON in btrfs_destroy_dev_replace_tgtdev()
Date:   Thu,  5 Dec 2019 14:19:59 +0100
Message-Id: <20191205131959.19184-4-jth@kernel.org>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20191205131959.19184-1-jth@kernel.org>
References: <20191205131959.19184-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a user report, that cppcheck is complaining about a possible
NULL-pointer dereference in btrfs_destroy_dev_replace_tgtdev().

We're first dereferencing the 'tgtdev' variable and the later check for
the validity of the pointer with a WARN_ON(!tgtdev);

But all callers of btrfs_destroy_dev_replace_tgtdev() either explicitly
check if 'tgtdev' is non-NULL or directly allocate 'tgtdev', so the
WARN_ON() is impossible to hit. Just remove it to silence the checker's
complains.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=205003
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 fs/btrfs/volumes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c565650639ee..f5c0c401c330 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2132,7 +2132,6 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 {
 	struct btrfs_fs_devices *fs_devices = tgtdev->fs_info->fs_devices;
 
-	WARN_ON(!tgtdev);
 	mutex_lock(&fs_devices->device_list_mutex);
 
 	btrfs_sysfs_rm_device_link(fs_devices, tgtdev);
-- 
2.21.0 (Apple Git-122)

