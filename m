Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA461692C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 19:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfEGR1i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 13:27:38 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45983 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfEGR1i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 13:27:38 -0400
Received: by mail-yw1-f65.google.com with SMTP id w18so13842732ywa.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 10:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=aEVPpxn3vtZg9/x61MdknAiF78zJUHPHgf9Xoq1UHGk=;
        b=aHhSzWPcP0ah/5C960wx/yLdQDHShlg2uwvcfHtZlNrBEpRSSziuiT0LsFAPQfWa9Y
         MwjSs1ldvovyovy9YxWh0dMx+fIxCZf+PU9ii4CHR47KWOHqxCU8rKTwg4YNgn3LRpQ3
         x33lAmVz4zHX4BHh1nbEndMBYb7MJkx0mASGUgYxM0kX88KVfxTdxVjmiCYQ0mWh9TTy
         Uipcy5Lczo9lqT3MOSkUHuvEL7bHre7cyLQX1wYP+cnxCjyNlmObWqwX1iPWqkVfGhCb
         mskYe9TmS8setOzQwjl4jDjnQs6mHlsCl6QrRgnQdaGDdH56DwJYvbXLzgk1liT1PIV0
         pGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=aEVPpxn3vtZg9/x61MdknAiF78zJUHPHgf9Xoq1UHGk=;
        b=S8zBI0iwCrQUYg60SYH6mhmfkLBlo+DBgr8PCo8tA15aizmDO9tobxsCnuqKhcEoCP
         xaBcrVK34k9aF2a36d/vvanGIWTsIzFo4x0cnKrtwXYm0W8REEbw4uRBQotCrXEHmw03
         nfbIa6MAwxl/ygBi79pvSnMZLcReVWxJU4kC9GNPcuT3CDEf8pCA5tlBlvGjhQ2ZhCuR
         0SshfJ+52veqbsW1370NP2I10xifN3iiNFAiD6FYweYULvoQYzgz3S23HoU1jtq3fzUO
         oQQ9/vX9VQ6/ns/qDXLEmrNYwmMn024UApZSxeHDF53j9bLa8VPmf9SxPty4WSksmvoY
         AOSQ==
X-Gm-Message-State: APjAAAVnA7Mg9miJAxNSe1zsET7DPT+QlR/aaoLFrYVjvL/zE0Fabvr6
        uSg949VMcibkat4DD+CyZTN+9Jv5D9+dtfvQ
X-Google-Smtp-Source: APXvYqyF4ntqGMmdMiRifA39ybcE1wA1N5OpDwvuTDt+VTtkGhdnGsBFsxo7qtH1IhVuaWYx7dikew==
X-Received: by 2002:a0d:eb52:: with SMTP id u79mr10338928ywe.119.1557250056721;
        Tue, 07 May 2019 10:27:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5c09])
        by smtp.gmail.com with ESMTPSA id n125sm680271ywb.78.2019.05.07.10.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:27:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: run delayed iput at unlink time
Date:   Tue,  7 May 2019 13:27:34 -0400
Message-Id: <20190507172734.93994-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have been seeing issues in production where a cleaner script will end
up unlinking a bunch of files that have pending iputs.  This means they
will get their final iput's run at btrfs-cleaner time and thus are not
throttled, which impacts the workload.

Since we are unlinking these files we can just drop the delayed iput at
unlink time.  We are already holding a reference to the inode so this
will not be the final iput and thus is completely safe to do at this
point.  Doing this means we are more likely to be doing the final iput
at unlink time, and thus will get the IO charged to the caller and get
throttled appropriately without affecting the main workload.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b6d549c993f6..e58685b5d398 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4009,6 +4009,28 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		ret = 0;
 	else if (ret)
 		btrfs_abort_transaction(trans, ret);
+
+	/*
+	 * If we have a pending delayed iput we could end up with the final iput
+	 * being run in btrfs-cleaner context.  If we have enough of these built
+	 * up we can end up burning a lot of time in btrfs-cleaner without any
+	 * way to throttle the unlinks.  Since we're currently holding a ref on
+	 * the inode we can run the delayed iput here without any issues as the
+	 * final iput won't be done until after we drop the ref we're currently
+	 * holding.
+	 */
+	if (!list_empty(&inode->delayed_iput)) {
+		spin_lock(&fs_info->delayed_iput_lock);
+		if (!list_empty(&inode->delayed_iput)) {
+			list_del_init(&inode->delayed_iput);
+			spin_unlock(&fs_info->delayed_iput_lock);
+			iput(&inode->vfs_inode);
+			if (atomic_dec_and_test(&fs_info->nr_delayed_iputs))
+				wake_up(&fs_info->delayed_iputs_wait);
+		} else {
+			spin_unlock(&fs_info->delayed_iput_lock);
+		}
+	}
 err:
 	btrfs_free_path(path);
 	if (ret)
-- 
2.13.5

