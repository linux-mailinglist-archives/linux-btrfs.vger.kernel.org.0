Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF65B41AE
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiIIVsY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIIVsU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:48:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D026F3410
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LWIa5YXTGtofGANsSvKQGkq4gG99m16VAOIG1hPy8aM=; b=aBuIHxztJ6TgHlVQ+mUrlfOLdK
        12x1uj7v6CJkcaYxo0ZKkLUech5XspZDeAM3jIx1iDMY1XpPqz7tRTZf1pBNAjRZEzlOI6jZfT56L
        GvuObs1Nvdd1wPr7cYfcRJpu47LMAaQXyNjuQ4UNRkGlvKxIqT9NXx0tAbQLcMH/Ub+bDdW7cOfcg
        Kpi5oxVI2yaBbNkqqTvkYIr1iBh2O5spk0JzJwMmt2gw6+gYDt8Yx0egKHbhPYfolpRVs4Qup3HTn
        af4pI1a6aHWkf0f4/C+BqVCSFNkkHkA/v9fvBFJVgEvkFiRjNBGV6X879urNaTjJOHyersPuimp5u
        MsZAdJCQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWlrD-003CE9-9E; Fri, 09 Sep 2022 21:48:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     dsterba@suse.com, johannes.thumshirn@wdc.com, naohiro.aota@wdc.com,
        linux-btrfs@vger.kernel.org, damien.lemoal@wdc.com
Cc:     pankydev8@gmail.com, p.raghav@samsung.com, mcgrof@kernel.org
Subject: [PATCH 1/2] btrfs-progs: mkfs: fix error message for minimum zoned filesystem size
Date:   Fri,  9 Sep 2022 14:48:09 -0700
Message-Id: <20220909214810.761928-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220909214810.761928-1-mcgrof@kernel.org>
References: <20220909214810.761928-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The minimum size for a filesystem on a zone storage device
actually depends on the size of a devices' zone size, given 5
dedicated zones are required, regardless of their fulll size
of the drive:

  * 2 zones for the primary superblock
  * 1 zone for the system block group
  * 1 zone for a metadata block group
  * 1 zone for a data block group

So the minimum size for a btrfs filesystem for a zone storage
device is completely device specific.

The check for this however complains about the minimum
size required for btrfs in general, not for the above
consideration. Fix the error message so that users
understand the exact reason why mkfs might fail
if you want to create a filesystem which cannot
possibly fit into less than 5 zones. Also clarify how
the minimum size then is completely device specific.

Without this a user can end up scratching their heads
if they tried to create say a 512 MiB filesystem on
a 100 GiB NVMe ZNS drive with 128 MiB zone size.
In this case 5 * 128 = 640 MiB is the minimum required.
Without this patch a user will end up with the following
error message:

ERROR: size 268435456 is too small to make a usable filesystem
ERROR: minimum size for a zoned btrfs filesystem is 47185920

Clearly 268435456 (256 MiB) >  47185920 (45 MiB). Fix
the error message so that the user knows what to do if
they want the mimimum filesystem for btrfs zone storage
device.

With this now the user sees:

ERROR: Size 512.00MiB is too small to make a usable filesystem.
ERROR: The minimum size for a zoned btrfs filesystem requires
ERROR: 5 dedicated zones. This device's zone size is 128.00MiB so
ERROR: the minimum size for a btrfs filesystem for this zoned
ERROR: storage device (/dev/nvme5n1) is 640.00MiB

The following fstests fail because of this issue, and at first glance
it was not clear why:

  * brfs/132
  * generic/226
  * generic/416
  * generic/650

Now it's clear what the issue is and what needs to get done to
fix those respective tests. But note, that if working on a sequential
zone then parallel writes are expected to fail, so tests which require
that and use parallel writes must also check for sequential zones
and bail if one is to be used. Each of these tests needs to be adapted
a bit for zoned devices to work properly.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mkfs/main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index eaecdc061dfe..ebf462587bd5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1401,10 +1401,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	 * 1 zone for a data block group
 	 */
 	if (zoned && block_count && block_count < 5 * zone_size(file)) {
-		error("size %llu is too small to make a usable filesystem",
-			block_count);
-		error("minimum size for a zoned btrfs filesystem is %llu",
-			min_dev_size);
+		error("Size %s is too small to make a usable filesystem.",
+			pretty_size_mode(block_count, UNITS_DEFAULT));
+		error("The minimum size for a zoned btrfs filesystem requires");
+		error("5 dedicated zones. This device's zone size is %s so",
+			pretty_size_mode(zone_size(file), UNITS_DEFAULT));
+		error("the minimum size for a btrfs filesystem for this zoned");
+		error("storage device (%s) is %s",
+			file, pretty_size_mode(5 * zone_size(file), UNITS_DEFAULT));
 		goto error;
 	}
 
-- 
2.35.1

