Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F08F159B4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 22:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgBKVkt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 16:40:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36759 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgBKVks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 16:40:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id w25so38417qki.3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2020 13:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jnceg/tyrGCwujOV27hUIDkS5QYyCPfAkZwNveltVtI=;
        b=pqZwr6qMIxBjwWUbe8v/YM55+u614nXDG57xs1luUyAI5JRxlU+B4r2DEePrZ94bFK
         8CsiugD7i8MpQ6vFS7Ly+IpBZbEmmwZ0HY1eVyxjuycUGkbM8Vb45pi8gPNowDsVgPpO
         9fcd7+e7gcSpkOkrZDASq0Y/71a17gePbawqd0Q0bcVzCMICAm8yyUAnY4/H26pHVo15
         zKCYIKKYr3SccjOUDykXS6t0aWZ2BHlwsyzx0qzynm+ZTqVn9e+RjAS08y+qEW4dsOkb
         hsfvCV4NRdsK2+cml+kE9asB5ykekgV+X/E3QCxOqbIIlWeqhm+o44QGAh2uxOKR9K4m
         N4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnceg/tyrGCwujOV27hUIDkS5QYyCPfAkZwNveltVtI=;
        b=MLEiNXgufJl9fErpcDDq+DIQ+cQboH199sOLjR8mW9MKkdMefm0HhWgAg1EyHMDseG
         emJIdmBaGrgOLpns/o8InxtHvMvkYTT7jTzdjWb9sEtDuqHMjYbC4zoSZ73qjnNCNHWR
         HHae3TuxgO3km01Udo0TUcLaw8yd8suqy5LfZuDAWYhP+7Ik4tS9tJIdQ14CgpN6wXkj
         Ha8dSaIcHkGdrdZJUWddHLzyQnkFCBdBxDu9pBgSLYg3AUwpIhjumkmGPzEiPF5gUYoV
         II3c8NC5ST4iRkM5Thi14zquDXcKazfc0J37aVmGr7CTLVwPNv1pluN8ufuF8FihSvY5
         Az2A==
X-Gm-Message-State: APjAAAX1F2v60B4ptKiUd/zLAAPmfjFG3OuZ9zQTY1ZhJX5gqUqERSSe
        7FhPxWkyJZ7eaBeKjsazwAxZiA+Ii58=
X-Google-Smtp-Source: APXvYqz5MlF/1Wug8/7MEqj6PDQfidRheSfxzR2cabNum5CH32oKY2+Wtc15d00o6/uM2RogWVy0aQ==
X-Received: by 2002:a37:de16:: with SMTP id h22mr4660803qkj.400.1581457247296;
        Tue, 11 Feb 2020 13:40:47 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o10sm2864049qko.38.2020.02.11.13.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 13:40:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/4] btrfs: set fs_root = NULL on error
Date:   Tue, 11 Feb 2020 16:40:39 -0500
Message-Id: <20200211214042.4645-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200211214042.4645-1-josef@toxicpanda.com>
References: <20200211214042.4645-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While running my error injection script I hit a panic when we tried to
clean up the fs_root when free'ing the fs_root.  This is because
fs_info->fs_root == PTR_ERR(-EIO), which isn't great.  Fix this by
setting fs_info->fs_root = NULL; if we fail to read the root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index eb441fa3711b..5b6140482cef 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3260,6 +3260,7 @@ int __cold open_ctree(struct super_block *sb,
 	if (IS_ERR(fs_info->fs_root)) {
 		err = PTR_ERR(fs_info->fs_root);
 		btrfs_warn(fs_info, "failed to read fs tree: %d", err);
+		fs_info->fs_root = NULL;
 		goto fail_qgroup;
 	}
 
-- 
2.24.1

