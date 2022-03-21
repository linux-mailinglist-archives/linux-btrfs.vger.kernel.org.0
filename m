Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC084E2DA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Mar 2022 17:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350873AbiCUQQK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Mar 2022 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349263AbiCUQQC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Mar 2022 12:16:02 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DC32314D
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 09:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647879270; x=1679415270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ht3ht7NGdEqqjqWIUOCUfml5Fc2/ivtasHKMfz/HYQI=;
  b=nN7l5SojrLL8kL7GWnBsDKLWoIdCbqOz1/Uo1K6WcAk3IuN4IFI6wvvv
   mbJEUydRTVi9Gvr7a3VeoRSIJswE2mIajl1UCTQHOwnp7FmdBzA5Oi8IU
   pJpjkUJxPMgT0TETA/GYeUvIKgt+pwbxmrzV75u/BETxb9phXt+sAAw31
   iHLbJSUzuI6kWxb07w3hvJXcn/eBA5c0p+KxJL1vN6Xy8joBeyr843EEb
   Vvz/jbBFIdAtaIm8YzzK1QZl2a17qVDD7DXdxy/oo/9RiiWhYBIDnwO6M
   IvB1sHb6nSkOUVdbMXscDXduD8u1SWovnJFi9PQFC9rc0Dy8f4OLSezbG
   w==;
X-IronPort-AV: E=Sophos;i="5.90,199,1643644800"; 
   d="scan'208";a="307836353"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2022 00:14:30 +0800
IronPort-SDR: WM9AfShHaIHgGqYIRLvO1xTRwUM/PDxmSQJI2+3kN8oRO5Uw1zHNxXrgElgJ21rkqgYh3q3ASX
 tjmrtOqsSYmTgpm0AJ0WpOFQSSrvOQCtWxf41hD/RL9eeXlCBkMB6gt1KDZqDGvWI9BUcoHMdU
 ERfTqJKk2Ww0IUnzS1G4GEA7Cw9yzbI3PePh78s28vSjTZW8YLYuhJDEma5Dl3/rGuuHujsuGq
 AeUf+XQFfDC5I+jt2rexrR1vlL7xZGvqeZYhJxagCEck6dsLhoV4IN0vTcYjzR1T5DMNcAI4E5
 iVM3LKTyRvYA4PngdCxL3wTc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:45:30 -0700
IronPort-SDR: VbXmbkN7f/4LJ4z7GTOhBqLU84r7wi1h3vVEwrf64StiX9oO6jTkQSwpxh/jjVgK0IsQROcs/D
 82VrNhQBC/bCsW/ohbBXyaq9Kcm808vOiRLZN+HxBTUbSPgM/xCly40lIVUwgshUw0jiriWwqr
 sim3GvQsximeBwW9dbXVeMtzbHo+zJq0P2Jw48cSQaho42ESkgzj9KJ7agDn3bSpXrhIlhOrf0
 XKhBnP+a9ujdDU+Vrz5Ee1akp4toXdVbFWQ7K6joJlPl2wP9NegrYkLvRKi0ewXdNp40gLTYZE
 DBk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Mar 2022 09:14:29 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 3/5] btrfs: change the bg_reclaim_threshold valid region from 0 to 100
Date:   Mon, 21 Mar 2022 09:14:12 -0700
Message-Id: <a93784045c882dbcee83399af67cd17161f279b6.1647878642.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647878642.git.johannes.thumshirn@wdc.com>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

For the !zoned case we may want to set the threshold for reclaim to
something below 50%.  Change the acceptable threshold from 50-100 to
0-100.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 90da1ea0cae0..fdf9bf789528 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -746,7 +746,7 @@ static ssize_t btrfs_sinfo_bg_reclaim_threshold_store(struct kobject *kobj,
 	if (ret)
 		return ret;
 
-	if (thresh != 0 && (thresh <= 50 || thresh > 100))
+	if (thresh < 0 || thresh > 100)
 		return -EINVAL;
 
 	WRITE_ONCE(space_info->bg_reclaim_threshold, thresh);
-- 
2.35.1

