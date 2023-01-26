Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3C67D867
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 23:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjAZWcN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 17:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjAZWcL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 17:32:11 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42A962260
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 14:32:01 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id j9so2634774qtv.4
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 14:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GqhiLH8xbCati0h5mD44WfdY+eBKZJjYIyoqr/wRT30=;
        b=e9QdIV+psmA4uPcD3QqP+iSu9mmXpumb7E3xCJ9QbdLRf7A6sYBFXuUPzagPepgLjS
         5ctuuhf38dIjJ/VVlZvxX2/RyZ7RaTcq1AM7WPVrlCARRQekyePnqwfL7xVKb7QIr/k7
         YrB6L0lkb77nDUAxSD36+yDnlMB8SuNC5T2hS2aQURzW+UzrzrdUucEqms8jS7rKWQGp
         z4Ml7P7bPpeRja19F2ETLU5AzgOQ6nQV5i1pTTYhTJNxnuyLNgM0USZ+y+8QHSRje+Hb
         FmrpAFDn8Gt/34K4dGG/i6mHhIYYYBT94H2tIfhE1As9dEnJhcB/Kr/9uZi2mzGyyM+O
         inIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqhiLH8xbCati0h5mD44WfdY+eBKZJjYIyoqr/wRT30=;
        b=QA4HRGf4sGWCl94c3KTABpxsDg/7Rw0N9wB4iNp8fPwBE47rIC8Ojqk69IrkbdrING
         vsJ2bAN8X74KOIn6QyHsOotPrfR/GtOziAehWaJ7KRYWh8BwxSLvjoA7RDGzJ3R/jMRB
         1oN+nCMyUYAGXNwLrKTpw5wKDjPtoXssHcU9Hwn64SfjpAXpSXURq9gYIvg96OlE6p51
         z10/JpbM3CwxrRZuXW4ngaCdgpQAvTZ6bku+0XQu6cnEbdN0hVNaeRYOTPGD8B6pNTle
         J1hfBz3Ak1yAiof3jZprC5zVsDZ1XXKCE6m0uS/pZKFAvUmHxh0SINyIvnNXwb7+otrG
         8V6w==
X-Gm-Message-State: AFqh2kp0ZxNfGAo1oUwuFmmJGgaEEn1pezDodMtZ3mEwDWupIyf0n48Z
        4ZrMB1SQgO0Tas+NWlRBUx2NuMo6rY//bCrRDC0=
X-Google-Smtp-Source: AMrXdXvCROUxwYmpN7wVV5DJzOBEt3/vcZZSPuW/7rdWMqjViXzQvOwHB7xI//myGpVQlMvu4gDqNQ==
X-Received: by 2002:ac8:5b90:0:b0:3a8:30c9:ba8f with SMTP id a16-20020ac85b90000000b003a830c9ba8fmr74880617qta.28.1674772320357;
        Thu, 26 Jan 2023 14:32:00 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id n3-20020a05620a294300b00704df12317esm1777111qkp.24.2023.01.26.14.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:31:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Anand Jain <anand.jain@oracle.com>,
        Daan De Meyer <daandemeyer@fb.com>
Subject: [PATCH v3] btrfs: allow single disk devices to mount with older generations
Date:   Thu, 26 Jan 2023 17:31:58 -0500
Message-Id: <1bf56a77b8b57cc3b993fda00752e79830685ffc.1674772170.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have this check to make sure we don't accidentally add older devices
that may have disappeared and re-appeared with an older generation from
being added to an fs_devices.  This makes sense, we don't want stale
disks in our file system.  However for single disks this doesn't really
make sense.  I've seen this in testing, but I was provided a reproducer
from a project that builds btrfs images on loopback devices.  The
loopback device gets cached with the new generation, and then if it is
re-used to generate a new file system we'll fail to mount it because the
new fs is "older" than what we have in cache.

Fix this by simply ignoring this check if we're a single disk file
system, as we're not going to cause problems for the fs by allowing the
disk to be mounted with an older generation than what is in our cache.

I've also added a error message for this case, as it was kind of
annoying to find originally.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reported-by: Daan De Meyer <daandemeyer@fb.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v2->v3:
- Dropped the printk as we now have a printk here to indicate that something
  went wrong.
- Validated that it still fixes btrfs/219.  That test validates a few corner
  cases that I could think of at the time, and looking at it again I've covered
  everything that comes to mind.

 fs/btrfs/volumes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 707dd0456cea..b17b4a66a8d4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -766,6 +766,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
 	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
 					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
+	bool multi_disk = btrfs_super_num_devices(disk_super) > 1;
 
 	error = lookup_bdev(path, &path_devt);
 	if (error) {
@@ -902,7 +903,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		 * tracking a problem where systems fail mount by subvolume id
 		 * when we reject replacement on a mounted FS.
 		 */
-		if (!fs_devices->opened && found_transid < device->generation) {
+		if (multi_disk && !fs_devices->opened &&
+		    found_transid < device->generation) {
 			/*
 			 * That is if the FS is _not_ mounted and if you
 			 * are here, that means there is more than one
-- 
2.26.3

