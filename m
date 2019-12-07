Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F73115F51
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 23:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfLGW3r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Dec 2019 17:29:47 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:47579 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725847AbfLGW3r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Dec 2019 17:29:47 -0500
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Dec 2019 17:29:46 EST
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 47VkXL0dYcz20Yn;
        Sat,  7 Dec 2019 23:24:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1575757474; bh=S8KC8+rjd9jYzf2BGy5fukUD+/i6Mak7uynOyY8j3ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=O+A0xdQXU2zDPz0jAf21Oo+W9wddh8z2GO7rPabNC4pvLNfaF4/TnKCiog0Bj2eWa
         DYCNzQXDvqrJhbf3cQtDzqyGUv0RcvbK0oFh4OV2NpFYH+Zh0qk6ct1U0ydSOrXKia
         gg+zPN4bGHzGqkI9yGSmvQT+VTvmwDWuQn4v+tXZ6rg8esb7/7tqkf7wNwS1e0hLii
         CkRKfDjeD48JZMaF2rt4w4XuOhSFjB8KQCVM+oWUAAJ4clHqiXyMwgsA3QmPL2vWXh
         H0HTpwvIuHZI3ZmOYqtWRe2LqCzH3o3oyuDqlzurPH+SGFcvuy66Vrvkd/sGF0iIh6
         gelUKumRIFvtQ==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.22.146
Received: from localhost.localdomain (firewall.henke.stw.uni-erlangen.de [131.188.22.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19WIVfm9a1gWO38tbJ7T5+TTACM/Uql3CU=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 47VkXH32G0z20Xm;
        Sat,  7 Dec 2019 23:24:31 +0100 (CET)
From:   Sebastian <sebastian.scherbel@fau.de>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Sebastian Scherbel <sebastian.scherbel@fau.de>,
        Ole Wiedemann <ole.wiedemann@fau.de>
Subject: [PATCH 2/2] btrfs: Move dereference behind null check in check volumes
Date:   Sat,  7 Dec 2019 23:18:18 +0100
Message-Id: <20191207221818.3641-3-sebastian.scherbel@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191207221818.3641-1-sebastian.scherbel@fau.de>
References: <20191207221818.3641-1-sebastian.scherbel@fau.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sebastian Scherbel <sebastian.scherbel@fau.de>

Regarding Bug 205003, point 2
The struct "tgtdev" is currently dereferenced before being checked
for null later on. This patch moves the derefernce after the null
check to avoid a possible null pointer dereference.
Furthermore WARN_ON is replaced by BUG_ON to prevent the subsequent
dereference of the null pointer.

Signed-off-by: Sebastian Scherbel <sebastian.scherbel@fau.de>
Co-developed-by: Ole Wiedemann <ole.wiedemann@fau.de>
Signed-off-by: Ole Wiedemann <ole.wiedemann@fau.de>
---
 fs/btrfs/volumes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d8e5560db285..12015f60f50d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2128,9 +2128,11 @@ void btrfs_rm_dev_replace_free_srcdev(struct btrfs_device *srcdev)
 
 void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 {
-	struct btrfs_fs_devices *fs_devices = tgtdev->fs_info->fs_devices;
+	struct btrfs_fs_devices *fs_devices;
+
+	BUG_ON(!tgtdev);
+	fs_devices = tgtdev->fs_info->fs_devices;
 
-	WARN_ON(!tgtdev);
 	mutex_lock(&fs_devices->device_list_mutex);
 
 	btrfs_sysfs_rm_device_link(fs_devices, tgtdev);
-- 
2.20.1

