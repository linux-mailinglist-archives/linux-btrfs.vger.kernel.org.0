Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77B7449E7F
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 22:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbhKHVzO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 16:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbhKHVzO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 16:55:14 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED1BC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 13:52:29 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id p19so934119qtw.12
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 13:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6E/S4PuXzzaPOGxUy6poJeEMDAGrmVQSF2JxsSlJp4=;
        b=vf1o9/0R/qGN11PzU31IUm7U+TejN/OXczW5BEb5CigEkuLrdwdWAURm9mx3rTScXU
         W03kxF2sSnjfOtjFxHRvT2z+CLpCdhddq1t9E/m7q+9JFJzc81PICnV7KGOPunrZTiDP
         KAA2ItF/u3CGQrwNQqD8mhV9WYzGCq/aLhpsF/Ri1UpLgzEuJjTJsphtgnadXQzKVVsx
         VZPciIqCo9CDHQfm2QZUOZPU/NsWbk8HNuBGm4orbnW/D82Uc5I4UJQZyaBtuFYbrOGs
         Xn2uoHIOjCHz8VXGCfX7VTCVUR+7LsRlLPV/qCRIAkFhoBPpEwr7Q/Dc3Nm/pWGm1ZC/
         g1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6E/S4PuXzzaPOGxUy6poJeEMDAGrmVQSF2JxsSlJp4=;
        b=HwPV+zgP+fxDbvwf6Jyj2DrS/qJH6xBSIkDAH/a6GfWCKl6IDXg01uf/SG2BH6/q9f
         apE7/0ipVRgbtlnNmTpVhLZPlB9FEmio3BmVL8f6WNgZw5fRUWpPLTVE/FHHWdy63VbI
         rs2r2bUMkv47UNQVVaLi98tfBVLj43cNpjgx9mfLpA7jIAKmTt5CcHEI6gYzB7A4n5dX
         SkPlz9kda5FlWJOWjyq3fUWfwx4XwMm6rxRh1fmb4ahD8FK9Se2+dJWL7Dx4ARtd0rOO
         SmLz/clxJ6ueQ3YMAbSKv0U+oIoc3yxf2tJup3evuy4V9CalMW22sOlt/r0yb48l7cHt
         bF0Q==
X-Gm-Message-State: AOAM533z+WhrAHDWNXya4TCrXXUjiXph7486S2eNvi+LbuKTcQtnQyw7
        d9urbfKtHqdppnITRYMOMtKHMLpiEZfmwQ==
X-Google-Smtp-Source: ABdhPJxTBAr8ETT3D58LOFqLh62f60qjZE6/auC5RJmxiyFmAD6T9x/CkA9Hhk2GXDsWf3/g+rc7pg==
X-Received: by 2002:ac8:5991:: with SMTP id e17mr3085320qte.98.1636408348225;
        Mon, 08 Nov 2021 13:52:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h11sm11073994qkp.46.2021.11.08.13.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:52:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Anand Jain <anand.jain@oracle.com>,
        Daan De Meyer <daandemeyer@fb.com>
Subject: [PATCH v2][RESEND] btrfs: allow single disk devices to mount with older generations
Date:   Mon,  8 Nov 2021 16:52:26 -0500
Message-Id: <75f38ba99fde2f94066fb4578914241c0e2a8f9d.1636408300.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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
 fs/btrfs/volumes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 68bb3709834a..9dfdc7680c41 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -777,6 +777,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	struct rcu_string *name;
 	u64 found_transid = btrfs_super_generation(disk_super);
 	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
+	bool multi_disk = btrfs_super_num_devices(disk_super) > 1;
 	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
 	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
@@ -909,7 +910,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		 * tracking a problem where systems fail mount by subvolume id
 		 * when we reject replacement on a mounted FS.
 		 */
-		if (!fs_devices->opened && found_transid < device->generation) {
+		if (multi_disk && !fs_devices->opened &&
+		    found_transid < device->generation) {
 			/*
 			 * That is if the FS is _not_ mounted and if you
 			 * are here, that means there is more than one
@@ -917,6 +919,10 @@ static noinline struct btrfs_device *device_list_add(const char *path,
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
2.26.3

