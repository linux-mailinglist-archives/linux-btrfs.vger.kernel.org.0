Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0F135B2E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 15:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbgAIOP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 09:15:58 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36118 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgAIOP6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 09:15:58 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so6078346qkc.3
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jan 2020 06:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QECz5UdFs5m0KXPG2mbg1cmUPCrorQQ6WbyIU1+Zu5g=;
        b=LqWFto893VQyvi2HKVGmQfFBX6A2olbFaJW9ywVmABe0idVGN0UA2aWlaMJtM7GDjf
         XFJEmIvBmrfw45PUD36bHiQpK/nCWA/ZdxyZnSvXyTE3NKEpYlDAihjatg/c0TlLKFrb
         gYLQJyAi06M11RYY6o4VvVl28LgurdwrwjsIINda67eDBRwS13f27ZvoKybYK+cBsr0k
         WmHMJPWlN8z82wPuFGTshnrmsDCUJUj5p6d+eh2DOAlJ+Nlk90CmufoQ1Mc3WW3v1Cea
         x3emNHdK9OWuvQUeXFrNLgo0elzonNGDTxguBJE7Y+hYuLAfr8+/Fx7AhZ5Cgxe6Td9k
         ZFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QECz5UdFs5m0KXPG2mbg1cmUPCrorQQ6WbyIU1+Zu5g=;
        b=adBhWhq4i/vcs9ThFLFmx3qFaUscH6UA170m9JGzuOoBLo2OINxdSVdY4flSgPF0bj
         5BdGmMpGZTPSmtcMOpBlO9VO5OOFEdMKiqZxOXz2OXh1ThrWwi1Ig8CdbELZEsCWU/tb
         zcsPLOccGfkeIDVykI4vHQe6zEvIGZkrwnk1X86eMjklPhFMbLTEHr1DOI0yxEa0emtS
         BfoQR1nt8y0CtN6z+3JzUagkrwY+/B5i/LAZSltk09VBN8DKQBQyIqp9msNUunhWAZM2
         QJSp4IYrVkuGkIu78LrG97cmkwO90bMISek9wwBW7dkU/nkh88GQ+ua4K+70/igmaVXs
         cYCQ==
X-Gm-Message-State: APjAAAX7pxo5nrBmyALO9Wr2IlQloGm//viX9zUkJE056kHVuUR3XR+J
        Px8JQIeUEDm/FE40pbbnTR1sD5lNUvT/Jw==
X-Google-Smtp-Source: APXvYqwmlME0QDrliaihMR7yMEV3Tpjxg7s3vS28a38h7AyygQQINE2+ZQ9/FMIPdA+BQL8uGJn5Yg==
X-Received: by 2002:ae9:e115:: with SMTP id g21mr9416280qkm.187.1578579357679;
        Thu, 09 Jan 2020 06:15:57 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h34sm3427454qtc.62.2020.01.09.06.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:15:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH][v2] btrfs: check rw_devices, not num_devices for restriping
Date:   Thu,  9 Jan 2020 09:15:31 -0500
Message-Id: <20200109141531.5155-1-josef@toxicpanda.com>
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
v1->v2:
- replace the dev_replace.rwsem locking with the chunk_mutex locking, which
  covers both dev replace and rm device.

 fs/btrfs/volumes.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7483521a928b..a92059555754 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3881,7 +3881,14 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	num_devices = btrfs_num_devices(fs_info);
+	/*
+	 * rw_devices can be messed with by rm_device and device replace, so
+	 * take the chunk_mutex to make sure we have a relatively consistent
+	 * view of the fs at this point.
+	 */
+	mutex_lock(&fs_info->chunk_mutex);
+	num_devices = fs_info->fs_devices->rw_devices;
+	mutex_unlock(&fs_info->chunk_mutex);
 
 	/*
 	 * SINGLE profile on-disk has no profile bit, but in-memory we have a
-- 
2.24.1

