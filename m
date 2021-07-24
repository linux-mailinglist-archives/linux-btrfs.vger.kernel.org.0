Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7719D3D458E
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 09:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhGXGe3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 02:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbhGXGe2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 02:34:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0838EC061575;
        Sat, 24 Jul 2021 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rAxC2Xr5XHh/MT1pN0HBz3vac7Bu9Hn+MlmAa6J1irc=; b=Rw9T4x57RqMsMpSAbj8EED+JWd
        H9hckClpA6IpKwoyS5exCbyA0NbIrm1k30jV0kewTptsTar8P4hbl8CPcUapae6CiUa2ze4HO2kcS
        U0AFeRfHJ0duh4liPyWbr815Uh6PeX2KE35jvWGah3fraenFFzPdTWKev4CcpbDJ+mKnyeCxu/eC9
        5CeN2UTJMm/QcCwB0+GcCviGNYXt8BNhxlv46V2JIdk8RUJvWgO1K+UZRJ9gYT62SkM3hKacaWdOV
        aXNRKQrqso7mTCLuKJbD7MKa1E8FjaNC33RqjBF63I7LjwC6sSOFGTz3FbofYAq8ZCv9gnr7pWxDu
        PEtZRpYA==;
Received: from [2001:4bb8:184:87c5:85d0:a26b:ef67:d32c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7Brg-00C4cN-9f; Sat, 24 Jul 2021 07:14:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 05/10] block: allocate bd_meta_info later in add_partitions
Date:   Sat, 24 Jul 2021 09:12:44 +0200
Message-Id: <20210724071249.1284585-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724071249.1284585-1-hch@lst.de>
References: <20210724071249.1284585-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move the allocation of bd_meta_info after initializing the struct device
to avoid the special bdput error handling path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/partitions/core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 4540232e68f9..ae88b5439056 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -352,13 +352,6 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	bdev->bd_start_sect = start;
 	bdev_set_nr_sectors(bdev, len);
 
-	if (info) {
-		err = -ENOMEM;
-		bdev->bd_meta_info = kmemdup(info, sizeof(*info), GFP_KERNEL);
-		if (!bdev->bd_meta_info)
-			goto out_bdput;
-	}
-
 	pdev = &bdev->bd_device;
 	dname = dev_name(ddev);
 	if (isdigit(dname[strlen(dname) - 1]))
@@ -382,6 +375,13 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	}
 	pdev->devt = devt;
 
+	if (info) {
+		err = -ENOMEM;
+		bdev->bd_meta_info = kmemdup(info, sizeof(*info), GFP_KERNEL);
+		if (!bdev->bd_meta_info)
+			goto out_put;
+	}
+
 	/* delay uevent until 'holders' subdir is created */
 	dev_set_uevent_suppress(pdev, 1);
 	err = device_add(pdev);
@@ -411,9 +411,6 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 		kobject_uevent(&pdev->kobj, KOBJ_ADD);
 	return bdev;
 
-out_bdput:
-	bdput(bdev);
-	return ERR_PTR(err);
 out_del:
 	kobject_put(bdev->bd_holder_dir);
 	device_del(pdev);
-- 
2.30.2

