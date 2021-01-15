Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7702F880C
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jan 2021 23:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbhAOV7H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 16:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbhAOV7G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 16:59:06 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49DAC061757
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 13:58:26 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id b9so7184281qtr.2
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 13:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9skiJ9CWxqM+V5ht72tq7F0NrlndUSnTd//4DBCvFU=;
        b=R0RnPv6sMx+W03pOaBCO9Ih3a+HHj2G4Ol0L6nzYORBSbR4uVj5WL3kdVF60275WaU
         j7TczaVmWetSu3HD5BC7UamV5bZpAqlncsZ4YUTFALVNyXx45ynvOQn3riy6Pf1lU7Y/
         YfcOf9vWhFMh3j7H/ynjWFXEHKfDriN6rxraK8h/L4NXM7LRjVEPZTPBprFU1nA9JuRe
         umdQH8bT3p22C7+OXOxqZA5rhH2HNWkOLVdVCUbDJeknWuowUx3OSZ48doRg4fIlsieE
         YKg7M0Sy+HWA+8TEOejr0KHZrdA98frO/hAXSxPGKbdEHW5VvXUcbchXHx/6qErK7gL/
         4Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9skiJ9CWxqM+V5ht72tq7F0NrlndUSnTd//4DBCvFU=;
        b=X4zlpahJ5403BVJ2dGAnNlaK46e3CtvXGXl5dAKbpxKGB2eYBajkZLqw/e1taj49rH
         +yYlHSqvJY9qemnADRWcwegq7B6JGRVEfgRaAHL46QHdI5eCRqIzTq3A0XubCstckf0q
         ajV/M/CpkLAESiGb2TzvoIWuGCCltNdeSjnjWDsgmbdhU18459Ec8EACyj2JVRpsgk2Z
         En7X6ak8NocWRUjiwPIznP0U+xyZoo3I+IvpfMXZx3eTRi+sFvALVcEeMMRYuGMbykJ0
         KaixYuwactOSywZ/hZLyUWvuIljJZyPvRCVxj1UOyLyMW/c6/bi+mKSWWJxEyTRKsphW
         WnAA==
X-Gm-Message-State: AOAM531gsl27eGYbEihu5jtBSxxrKjfSHy/tAfeMXj1gZruUQyWVm5qR
        g3P5Jwq0pseEURGBLvG9qsu0c249iOtgBm4i
X-Google-Smtp-Source: ABdhPJwOaxufP1LcwPCCMVM46jMO84OEfGeiCqPP/mTUwNBSECmLt8hKKN307mT6aV7bfACt/Do55A==
X-Received: by 2002:ac8:7b32:: with SMTP id l18mr13829027qtu.289.1610747905542;
        Fri, 15 Jan 2021 13:58:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q3sm5894651qkb.73.2021.01.15.13.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 13:58:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Anand Jain <anand.jain@oracle.com>,
        Daan De Meyer <daandemeyer@fb.com>
Subject: [PATCH v2] btrfs: allow single disk devices to mount with older generations
Date:   Fri, 15 Jan 2021 16:58:23 -0500
Message-Id: <990fe8a8efc2de74492a57148cdffe5dc9c02136.1610747845.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
v1->v2:
- Added Anand's reviewed-by.
- Rebased onto misc-next.
- GIANT NOTE: This was marked with needs a test, but I sent a test at the same
  time and it's been merged into xfstests already, it's btrfs/219.

 fs/btrfs/volumes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index badb972919eb..9b127e593535 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -790,6 +790,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	struct rcu_string *name;
 	u64 found_transid = btrfs_super_generation(disk_super);
 	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
+	bool multi_disk = btrfs_super_num_devices(disk_super) > 1;
 	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
 	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
@@ -918,7 +919,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		 * tracking a problem where systems fail mount by subvolume id
 		 * when we reject replacement on a mounted FS.
 		 */
-		if (!fs_devices->opened && found_transid < device->generation) {
+		if (multi_disk && !fs_devices->opened &&
+		    found_transid < device->generation) {
 			/*
 			 * That is if the FS is _not_ mounted and if you
 			 * are here, that means there is more than one
@@ -926,6 +928,10 @@ static noinline struct btrfs_device *device_list_add(const char *path,
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

