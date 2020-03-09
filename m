Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839FE17EB40
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCIVdH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:33:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36790 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgCIVdG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:33:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id d9so5309154pgu.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3iIB1WRtOJTgQ/7H6zzNl6rlY3jxphMj5H3mzHsas4=;
        b=sn50z7M1A782WGtsPbiNIIrJMqodq6VrRjRBpIy0krjBQr7Fjl+aTA1utEg5eNYfkz
         FF4NgtqSZS5zUFj6WGnCjX1TEPtnKfZHZ5DUjpy32Ojt3D8D/a4/oOGAFLqvakz2r2vl
         PeTsTf+UEcy3ZaE01ou38vQj4gFBW33aUwczj1vDmkfqNl81Lzl/XuIiawWseO9spH4r
         ebtkiN8Bq4pUXCsNKdbYzzQO2chgkj0SH+R7aP1Fc/9OwDQPGAmVOh8j5xWAxv9VFK2V
         mnJLg9PXJyZ6DfS4X4Mc5cdE1Qy3nS16qAwHLGB50Z0Qa+1NAFaRkTDvh6eHvU5t5POU
         oLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3iIB1WRtOJTgQ/7H6zzNl6rlY3jxphMj5H3mzHsas4=;
        b=abwYCQ8HBRv59l0K4rDI4EEllW7D2VbjE57g2ggEVkLLelZKmaCNJJVvvMCDYpHr3r
         a76mW8TL6XT295umSy6Aiu7I2ZM7pg5jpdLxbvE2cY/HWBy3X0dqcOc+7XcB0U6CBegs
         bn5944vrqtcW5Xp/qNh4skAArsMK1B9Gn9u7ioAAPklys5T/ZAJHvqlxaqpWBT6vABOu
         i1Fl/tUY9cxXGKtEZfV14iGWk/cRgsKTsguMSGE7vnH2Cf5uXM3o3EQ+iZH8+HeeV499
         AuDd03Licj1zNUI80o8etWyaPL6/+N8OoB6DWM9+9m14aD8mW0pqWqZCZ41qzYKCNSrA
         +B2A==
X-Gm-Message-State: ANhLgQ01L7DMhDViqpWDD/46Y7vyGj5R/oUB/exJ8X7xxmbVCjWQT0B0
        e4BUsB4NkB4ANKzVbIoN7sxSlRSPav8=
X-Google-Smtp-Source: ADFU+vvf4GplwUkgztILKzl0EmxG1Y9yqR1w9lIH9b0pUHzVJ9o2L1mVzhwDpVshzeqn/2ZpOTXA5A==
X-Received: by 2002:a62:6381:: with SMTP id x123mr18165041pfb.75.1583789584309;
        Mon, 09 Mar 2020 14:33:04 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:33:03 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/15] btrfs: kill btrfs_dio_private->private
Date:   Mon,  9 Mar 2020 14:32:35 -0700
Message-Id: <432c19b74bb13191a04550b630d2db1f998ba3be.1583789410.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583789410.git.osandov@fb.com>
References: <cover.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We haven't used this since commit 9be3395bcd4a ("Btrfs: use a btrfs
bioset instead of abusing bio internals").

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9d3a275ef253..8cc8741b3fec 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -62,7 +62,6 @@ struct btrfs_dio_private {
 	u64 logical_offset;
 	u64 disk_bytenr;
 	u64 bytes;
-	void *private;
 
 	/* number of bios pending for this dio */
 	atomic_t pending_bios;
@@ -8068,7 +8067,6 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		return;
 	}
 
-	dip->private = dio_bio->bi_private;
 	dip->inode = inode;
 	dip->logical_offset = file_offset;
 	dip->bytes = dio_bio->bi_iter.bi_size;
-- 
2.25.1

