Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA8111F9B1
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2019 18:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfLORcb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Dec 2019 12:32:31 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:56140 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfLORca (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Dec 2019 12:32:30 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47bWgf1hWqz9vYkd
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2019 17:32:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id npqqkTPSBHgu for <linux-btrfs@vger.kernel.org>;
        Sun, 15 Dec 2019 11:32:30 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47bWgf0QqFz9vYkc
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2019 11:32:30 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id o200so3906854ywd.22
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2019 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4SnZZNIdiXwc2Ipx9xkew+gAn+bF2xDJhghO9ThBXqs=;
        b=qtsS9VgdRokvBqYMULCyJ8o3Cysmefl5dXkdsssJziMf4/Vg+Oy3yjDzTsApcVaa70
         lrOzt1EfM+rSnjdnAh1uXhRW54lloEVoo85aHaqedAjVoWSn2bZIkCo5Eh3XAqyj7YFY
         cdgs7WuPKfHpdXWCVLz+5EiYabirjYUZL9wfLF6O1Q5YDwFOuo/wpmNVuEHBgb95ugPj
         uorxFzJcjJjuSLelYI0nSs8P/hY1VfZtC/oWk1UX5wgJDGirTICTG+suqOxUZvkbuB3r
         QrlxvGaS/zHaok1t/UVzS3IG3iyReQfd1oKCCaZWhqzePOsVON5wHVt5foQfcvUs3oSF
         Uk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4SnZZNIdiXwc2Ipx9xkew+gAn+bF2xDJhghO9ThBXqs=;
        b=ZsYmhmEwP3ZoXArhEvDtvjkI3lIeYfTNtDOpR1Wm94Y986gZGaQtCo73EqzwliOV9X
         sh7JbNGyMS4zUeHRHV3n+HQPjbmbT3nVMkr1ceoMxRcc56SQ2t9vcwjFpEjzj59a/+U0
         F7R/A8K5+YNyD3Fq+psdEJOcsWhY3Rh1JHMVSzYGzSWnuFOf9CUq/hyZ8ADPv86+3LBq
         if506f8gmiXjNvLGGHtCmlueEN0b63/FechlS1qSLSv8LKDCIHWBG37e3pLO8hSlvRRY
         I0T/ah2oKlAI9jxWJynf57XJL2e792/fsD0iJof7PGe8L2kBdbDSJkafWLLgRI4J9h3J
         Py9w==
X-Gm-Message-State: APjAAAV0FADZcxfIscW4AI6OVriznvTnQt13IHUCbLvBivML2lMejceb
        nx0rVQroLNRaPP80tmddshzeG2JfN7vAyJP1C/ZD3iCX4wpNI8/TKiAFkR76oEydqAz2tACQaMS
        Rex2+t8T2vaUU4ZposI27PXowq0s=
X-Received: by 2002:a25:3803:: with SMTP id f3mr17170064yba.144.1576431149555;
        Sun, 15 Dec 2019 09:32:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvAAD3U4dRSHJAPmdTZhN7NNz8PeQKLQqJ/2RxBeqq6+hRiwf2JrFi9rw4/k1PHibdvux0Iw==
X-Received: by 2002:a25:3803:: with SMTP id f3mr17170050yba.144.1576431149326;
        Sun, 15 Dec 2019 09:32:29 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id s130sm7345257ywg.11.2019.12.15.09.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 09:32:29 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Fix incorrect check causing NULL pointer derefernce
Date:   Sun, 15 Dec 2019 11:32:26 -0600
Message-Id: <20191215173226.29149-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfsic_process_superblock, argument state is dereferenced for
the variable fs_info and then checked for NULL. The patch fixes
this issue by returning an error if state is NULL and then assigns
fs_info.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/btrfs/check-integrity.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 0b52ab4cb964..70d7a05cafad 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -629,15 +629,18 @@ static struct btrfsic_dev_state *btrfsic_dev_state_hashtable_lookup(dev_t dev,
 static int btrfsic_process_superblock(struct btrfsic_state *state,
 				      struct btrfs_fs_devices *fs_devices)
 {
-	struct btrfs_fs_info *fs_info = state->fs_info;
-	struct btrfs_super_block *selected_super;
+	struct btrfsic_dev_state *selected_dev_state = NULL;
 	struct list_head *dev_head = &fs_devices->devices;
+	struct btrfs_super_block *selected_super;
+	struct btrfs_fs_info *fs_info;
 	struct btrfs_device *device;
-	struct btrfsic_dev_state *selected_dev_state = NULL;
 	int ret = 0;
 	int pass;
 
-	BUG_ON(NULL == state);
+	if (!state)
+		return -EINVAL;
+
+	fs_info = state->fs_info;
 	selected_super = kzalloc(sizeof(*selected_super), GFP_NOFS);
 	if (NULL == selected_super) {
 		pr_info("btrfsic: error, kmalloc failed!\n");
-- 
2.20.1

