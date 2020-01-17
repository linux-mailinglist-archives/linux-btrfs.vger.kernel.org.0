Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008161412EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgAQV1H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42229 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgAQV1E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:04 -0500
Received: by mail-qk1-f196.google.com with SMTP id z14so24148025qkg.9
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P8XNEd0C6kBDH9BTgE6tDYjoHWT0SVgdH+Usr5cP7to=;
        b=NZgXsQdgqMb+6KLNkZasjZBcaezZGj8HcEnb80I9fyEdUJLAolsoCs4OR7tnLWxa8O
         Y5ggI4lz32Mo+zY7/yV0cUCgjsJJ7Nls4Cts0OWiK3Sx+DoXuH+WehtGR9z8gqvFr9QR
         +HtPcxhwHdfK6cviG7WWx8gTOLXLCCBsFRfJyDUVsm7QyXCHI+xpSaa0RiKrH1ksWhHR
         cwc0qrYsvNpJBYFolV1gl7Mrcfh+YmAaTwCzsgag5XnkbD9ATRYQHp9j4n7ViLpNBRhT
         JeEI43ClneY3MDRuRkPab4k1E8r1AHA6E+5PCfd+y+IZG7MVW7qt+Q5/0/L1Eq7ko8cJ
         y6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8XNEd0C6kBDH9BTgE6tDYjoHWT0SVgdH+Usr5cP7to=;
        b=dv8Xustg3hz7C1ZqeVbrDwOfqXqSK7t+HkJY3+zYPmDA6UVpRsS6FiiOL69SiD/+Ou
         tNWhc7reTAhbgz573Pdp8ngEg0obX2nJhN1hXjtHD4gM1RtYid9lW9Bv0drrfvOKy7ga
         r3MNvEI2MLXfE4mYWVp4Dcelxt3+5wzAPrjXWw5pMP+VgtVDQtVRuz7UpmkHNHwfkqrz
         uexmt/rD0thwDm4RVKPVrHirI32mW96dDi+ZFXBSlp4CenBVI9KR0nAJa2Wbu3aqxuYi
         c5HzIbmuo2hvIhMjgxgczGQDS6u+sFv+q6MGG5tqf5g17cWXXUx/LiYlSy1a044b9Ygx
         kTeg==
X-Gm-Message-State: APjAAAX+a8ezRqf7+Hjn3IwXi6Mr3y8FQgO5H1FlkC0jHc2wO+lm4YhK
        qI4REyEawuVbheY+XJVMh2Car0skiLpRVQ==
X-Google-Smtp-Source: APXvYqx/gxbMyh1in0ECdMDW/YNw2zbnPUWUkwpu6kl1Q4Xn8R+6KHqiH0khqhVRdrS9X3mxyH6CRg==
X-Received: by 2002:a05:620a:634:: with SMTP id 20mr35578753qkv.269.1579296423055;
        Fri, 17 Jan 2020 13:27:03 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 201sm12523748qkf.10.2020.01.17.13.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:27:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 33/43] btrfs: hold a ref on the root in create_pending_snapshot
Date:   Fri, 17 Jan 2020 16:25:52 -0500
Message-Id: <20200117212602.6737-34-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We create the snapshot and then use it for a bunch of things, we need to
hold a ref on it while we're messing with it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c       | 1 +
 fs/btrfs/transaction.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 69c39b3d15a5..47953d022328 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -875,6 +875,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	d_instantiate(dentry, inode);
 	ret = 0;
 fail:
+	btrfs_put_fs_root(pending_snapshot->snap);
 	btrfs_subvolume_release_metadata(fs_info, &pending_snapshot->block_rsv);
 dec_and_free:
 	if (snapshot_force_cow)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e194d3e4e3a9..7008def3391b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1637,6 +1637,12 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
+	if (!btrfs_grab_fs_root(pending->snap)) {
+		ret = -ENOENT;
+		pending->snap = NULL;
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_reloc_post_snapshot(trans, pending);
 	if (ret) {
-- 
2.24.1

