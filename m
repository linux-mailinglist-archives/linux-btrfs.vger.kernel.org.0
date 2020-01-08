Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD3D134F79
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 23:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgAHWjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 17:39:33 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44504 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgAHWjd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jan 2020 17:39:33 -0500
Received: by mail-qv1-f67.google.com with SMTP id n8so2145791qvg.11
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jan 2020 14:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9O4DrhKtiAujlipAekPUp9150nYTh58YwUBfJZU3qc=;
        b=mWHNGQNdsFTh8Y/zgNx+V1/+uz3/jLjKO9LbZ+jTyyc+TcCNcjHiaInj1mOc7oev15
         PGF9Zk9tVL9XvDEDSmMS864C7hBMqw0QgeOafaAeSPGRL0J/eKSNKiIZyQirQlV+hkId
         TXKVptD8qC6GnAZ8UE7RxG9rv3ouvV3WHXiibnQTHNEUlOXTyyy3jqsSQ0t54WxP/rJX
         gm+zn/MlXTp4C+AKrev6RFp5cDLplbELj/Kl7BfsCzemfUjtcBr0sNgtWNrePN8R3VrG
         F7vOT5W0/GcfHWqE6YkxQex4Wo5LCVGKC5QxngpmjvWVXfe/q8DDYOoeILvq4yYY/2Q8
         PEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9O4DrhKtiAujlipAekPUp9150nYTh58YwUBfJZU3qc=;
        b=ioy4PxJ6y17y1NJzZtppTgahi0XtEPHniDTKs7qYYnUBHUNjz6V0VX/5nUiqVdTbaa
         Hcv0/+7Cut2NxNLR87aFOoAC1m2lKiqSLWur2//tIGl1DuKkRg0tKtZIJIFglwhJ+3Wv
         9f4bj/pSiDc/pIcDTeQj9YCezzK6PdrF2O31vigESxD4nCKnW7vSP9Uarc2noS7hPm++
         /Sm3BJS5zFffHGONgOEqOfSdXUZmcrs51fneD0bfVpw+K4KNAR3LhhDhgFYElvgekwHP
         zSUI7Mx8hwdZ30qZ+ZOsQmzXIGRCRyXWcZ91NjGT+a9qhkCHcSKPToX0EGQzYmJNdQhF
         BRMA==
X-Gm-Message-State: APjAAAUedUfKZiemFkcnlIIOhIW6XMgW1G17viGZKiY4Rr+KryocxdLf
        tmYEf7hSch5PFsGSTMSlT9hz6AMZWOqF4Q==
X-Google-Smtp-Source: APXvYqzGImv2+sLNWx4w2bF8YEcQis3mVlGUNn441rXQ1D3914VOzzbAOF47sfyToQJ7e9W3Fm82MQ==
X-Received: by 2002:a0c:ea45:: with SMTP id u5mr6142558qvp.171.1578523170945;
        Wed, 08 Jan 2020 14:39:30 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h34sm2359788qtc.62.2020.01.08.14.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 14:39:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: check rw_devices, not num_devices for restriping
Date:   Wed,  8 Jan 2020 17:39:29 -0500
Message-Id: <20200108223929.2761-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While running xfstests with compression on I noticed I was panicing on
btrfs/154.  I bisected this down to my inc_block_group_ro patches, which
was strange.

What was happening is with my patches we now use btrfs_can_overcommit()
to see if we can flip a block group read only.  Before this would fail
because we weren't taking into account the usable un-allocated space for
allocating chunks.  With my patches we were allowed to do the balance,
which is technically correct.

However this test is testing restriping with a degraded mount, something
that isn't working right because Anand's fix for the test was never
actually merged.

So now we're trying to allocate a chunk and cannot because we want to
allocate a RAID1 chunk, but there's only 1 device that's available for
usage.  This results in an ENOSPC in one of the BUG_ON(ret) paths in
relocation (and a tricky path that is going to take many more patches to
fix.)

But we shouldn't even be making it this far, we don't have enough
devices to restripe.  The problem is we're using btrfs_num_devices(),
which for some reason includes missing devices.  That's not actually
what we want, we want the rw_devices.

Fix this by getting the rw_devices.  With this patch we're no longer
panicing with my other patches applied, and we're in fact erroring out
at the correct spot instead of at inc_block_group_ro.  The fact that
this was working before was just sheer dumb luck.

Fixes: e4d8ec0f65b9 ("Btrfs: implement online profile changing")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7483521a928b..ee4d440e544e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3881,7 +3881,13 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	num_devices = btrfs_num_devices(fs_info);
+	/*
+	 * device replace only adjusts rw_devices when it is finishing, so take
+	 * the lock here to make sure we get the right value for rw_devices.
+	 */
+	down_read(&fs_info->dev_replace.rwsem);
+	num_devices = fs_info->fs_devices->rw_devices;
+	up_read(&fs_info->dev_replace.rwsem);
 
 	/*
 	 * SINGLE profile on-disk has no profile bit, but in-memory we have a
-- 
2.24.1

