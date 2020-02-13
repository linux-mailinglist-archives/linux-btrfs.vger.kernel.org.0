Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC815C47B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 16:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgBMPrn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:47:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39245 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbgBMPri (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:47:38 -0500
Received: by mail-qk1-f196.google.com with SMTP id w15so6089163qkf.6
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 07:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vC1p4faqe5ftKr0MQUOFDv6QU+rKjzLAO2BlnoeynwU=;
        b=owBk+r/wsS1yoP4TUG/BbFjBmbA29zXFfW4yL8XBeI0Ef9CTUoEjIrKU0SDy78lebz
         FNErSdJsDX3Aglhw9amPKbB/GghluDTQMmCUbrDC+UH81WBTMyFGIlHB74iYizAjO+eZ
         nIhfvAaLv3Eg7/kuvdFDn0q6BMlT5T6p8BbAaEpS3Hfb96WHa184inKp449TodSIyTPC
         F96n6pzmofBPsi81Da3Pjsk/ge5P08v5/Z2VMnOsYWVyN8XwdH29q+VSS8l8kQRyhNX4
         ciNLunzVI7rM5tgiNa+WhnFBRrRNtnbFg4rKZavdhmIFucQ9UXWzwyyRVksihUPgpGJA
         mnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vC1p4faqe5ftKr0MQUOFDv6QU+rKjzLAO2BlnoeynwU=;
        b=CgUg1TH2diM6Lcq+G8XF86Hp9YI+k+5C1MjtW7EN9KKNfxBhTIqGtgeHu2soK50neA
         +iW7jyfpauvsPFLa/1TVr06pqzQGuR2sLE/jRYSfoF35avGVHAlgth0ofr5vGdKDj8i3
         61rR7/CKK7/RNr9lZfZgRoXV5t4Oy/N24O7Zj5sagP2jvf4+wk0wg4nk++As03J4BiVQ
         2VSQRwT7KpwvvPZ5gs7LgsrlTASaIypjZmvunyd4bcprXZwvbuhaZ7MBfm/ijXzdjxJC
         FsYhdiZKQqgM7bheMDIrvKcph9fcPBQCrZvKMSjD0uAkLNYYRmgn7NXetopaXgq/vcLE
         M4Fw==
X-Gm-Message-State: APjAAAU8H7vTO9AWf+uN3j5Paztx7vHxcIkbB68T6ZTa6uLyNDHazgYC
        +vdTGOdGEyEELrAv0hxO4SyMEQJNzD0=
X-Google-Smtp-Source: APXvYqwimrHga8MOEWpdk9JwMQ7eeR0+g/TqGaitcLKUMqu8DvYizhhPQY54JxZhTHjVgRC/iZ/9Lw==
X-Received: by 2002:a37:9407:: with SMTP id w7mr10872300qkd.55.1581608857139;
        Thu, 13 Feb 2020 07:47:37 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x197sm1536700qkb.28.2020.02.13.07.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:47:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 1/4] btrfs: set fs_root = NULL on error
Date:   Thu, 13 Feb 2020 10:47:28 -0500
Message-Id: <20200213154731.90994-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213154731.90994-1-josef@toxicpanda.com>
References: <20200213154731.90994-1-josef@toxicpanda.com>
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
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

