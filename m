Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09E625A0BC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 23:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgIAVTo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 17:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIAVTn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 17:19:43 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0E8C061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 14:19:43 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id db4so1100238qvb.4
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YWnr0WLfCQE6h0ZRjFtS5otUhhl9HFQAxIbrN+oSmRE=;
        b=FcC/pwGFn6Qnb5MhHnBxQbg9+Mv7CxhWq9dGIn4IF52WGO52/8Ft4Dexn9zN/4IxHI
         pyLyekH+IPrYr3zj59mzSpKdu0n5PPBm0SHeGjizcwff2voyWSage2TmhDRo1aql1gyF
         AtenhQZA8rwYAI1XtFOmJhhQ5Gvi9u27Mx0lzNJmrGaE6LGwLqd3bnzk8SfYCc0l9J6O
         4pW3Olbc8faCIMue5sReL5mGbwua07Bam8JLbrZRimwI7yP6bLN1fLy86s8TeWKEWLGp
         HPEHxS7iNlqfhUiYXJHiQHcDuJqolK6o+gocOxRCn/Q2fjqQnSTUVEWh5CSoyWipAN7q
         Ee+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YWnr0WLfCQE6h0ZRjFtS5otUhhl9HFQAxIbrN+oSmRE=;
        b=HprXxYauRpf71vTGICWQeBchftilMdhPdyYVXkpVALgHUFOWAgkob/i3IDtZJbgIvh
         BdA/ZVjhceLrtSYWGOXL8vIK0kiOW/KUCUIkNmgAZ4roIt8VnoA6GZxxQKdiMjxq+xE0
         6z2d9WWi5pZDcfLuEd0IFzM1x3McsX2qaBxSoqtiqOrCpq2Z7dA6Ro8ZlSEG0MHrpeFD
         LSw7iUXREVN5EaUQZE0C/hEGzBEjxREXxoXXm+hqIIpWb0+F3a2MPDdaNWGgjEVu4CSv
         TGMRwjEpv+oodcShGSjeS7cm841DtGKXm27FrObCTJfbmSx+ZuvTY/6E7IJVJv+/wM5x
         UIqA==
X-Gm-Message-State: AOAM533BaeWbO8Qn0nnibtS9QfAs5XnBJv2CrKSrBa0rYSXHpKU/sm8E
        3yaGaQymECXYBTGzLhZMy9dr1S8CzwcChV13
X-Google-Smtp-Source: ABdhPJyJMvoYllXLzTXrWk5+S0+qVeQ+GGz/r3hErCfayIBDUyKDxAsktP8nJbaDNiRYGTwhc4HTEQ==
X-Received: by 2002:ad4:51d1:: with SMTP id p17mr3855242qvq.14.1598995181673;
        Tue, 01 Sep 2020 14:19:41 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b2sm2774758qto.82.2020.09.01.14.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 14:19:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Daan De Meyer <daandemeyer@fb.com>
Subject: [PATCH] btrfs: allow single disk devices to mount with older generations
Date:   Tue,  1 Sep 2020 17:19:39 -0400
Message-Id: <6b1f037344cd8d24566f3d9873b820a73384242c.1598995167.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
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

Reported-by: Daan De Meyer <daandemeyer@fb.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 77b7da42c651..eb2cc27ef602 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -786,6 +786,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	struct rcu_string *name;
 	u64 found_transid = btrfs_super_generation(disk_super);
 	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
+	bool multi_disk = btrfs_super_num_devices(disk_super) > 1;
 	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
 	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
@@ -914,7 +915,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		 * tracking a problem where systems fail mount by subvolume id
 		 * when we reject replacement on a mounted FS.
 		 */
-		if (!fs_devices->opened && found_transid < device->generation) {
+		if (multi_disk && !fs_devices->opened &&
+		    found_transid < device->generation) {
 			/*
 			 * That is if the FS is _not_ mounted and if you
 			 * are here, that means there is more than one
@@ -922,6 +924,10 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			 * with larger generation number or the last-in if
 			 * generation are equal.
 			 */
+			btrfs_warn_in_rcu(device->fs_info,
+		  "old device %s not being added for fsid:devid for %pU:%llu",
+					  rcu_str_deref(device->name),
+					  disk_super->fsid, devid);
 			mutex_unlock(&fs_devices->device_list_mutex);
 			return ERR_PTR(-EEXIST);
 		}
-- 
2.26.2

