Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58B33112CBC
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 14:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfLDNhN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 08:37:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36640 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfLDNhN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 08:37:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so8667749wru.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 05:37:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FhFDre66rIOvroQws85OqVVPY7w+pix0IcpDz4GPk8o=;
        b=Jx3eQzNpCjR8MVhnXj/Y+q5zV1Sct52i0YUCqHRnLXJ5frH441BOXrlGVtVDB9j+R2
         /3o4xI2hpIAwDucIbC0T2rUgOHbPQY5NMr59T2OEZ9c4kXqCxVA7a5Pt6KiyTZcd3seV
         GEqVuY4pATnNyAyd7ZnYUpXlJQx2Umq611S7P/nZXGHmBPdgQ5B8kqQGQKYhBhN1nb2+
         Uha9wg/Lc+cqCu8aZTwBhFH4lOt0cfB8B6aiUZLrFj7zG0QUQfRwOLMXu8jpnOw8YFmY
         v09eQqub96M5BfPGnTZMzB8Gnw48fSCve2BEeSKHmWgTmGavlDCBjrmZlgVTrnwXjlKa
         lAvQ==
X-Gm-Message-State: APjAAAUT95tiDGz8fi0ig1prUk+MUfUO8t+eQeYlrdCagwsLFED7AyGo
        Hcnq4dqojqcMNgczpZxFYMKioS3iJCs=
X-Google-Smtp-Source: APXvYqwnynlCpuDUwPWwBjGu0IwTHFpzoKAhZiqK+bzDO4gkS4FGR1Bwr1rbngmE22iBXWoYlWTxjQ==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr4007667wra.36.1575466631571;
        Wed, 04 Dec 2019 05:37:11 -0800 (PST)
Received: from localhost.localdomain (ppp-46-244-211-33.dynamic.mnet-online.de. [46.244.211.33])
        by smtp.gmail.com with ESMTPSA id q3sm8291948wrn.33.2019.12.04.05.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 05:37:10 -0800 (PST)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v5 1/2] btrfs: decrement number of open devices after closing the device not before
Date:   Wed,  4 Dec 2019 14:36:38 +0100
Message-Id: <20191204133639.2382-2-jth@kernel.org>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20191204133639.2382-1-jth@kernel.org>
References: <20191204133639.2382-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <jthumshirn@suse.de>

In btrfs_close_one_device we're decrementing the number of open devices
before we're calling btrfs_close_bdev().

As there is no intermediate exit between these points in this function it
is technically OK to do so, but it makes the code a bit harder to understand.

Move both operations closer together and move the decrement step after
btrfs_close_bdev().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c565650639ee..ae3980ba3a87 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1069,9 +1069,6 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	struct btrfs_device *new_device;
 	struct rcu_string *name;
 
-	if (device->bdev)
-		fs_devices->open_devices--;
-
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
 		list_del_init(&device->dev_alloc_list);
@@ -1082,6 +1079,8 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 		fs_devices->missing_devices--;
 
 	btrfs_close_bdev(device);
+	if (device->bdev)
+		fs_devices->open_devices--;
 
 	new_device = btrfs_alloc_device(NULL, &device->devid,
 					device->uuid);
-- 
2.20.1 (Apple Git-117)

