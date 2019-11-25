Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCA9109465
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKYTrR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:17 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45423 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfKYTrR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:17 -0500
Received: by mail-qt1-f196.google.com with SMTP id 30so18562813qtz.12
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=V0SGfFcUp747oNGVEqYMJlEuXwf3wUUdepKGBwzX2YI=;
        b=HCaI748FX1GBqpZsRlWuE2VXiWf8vjH0rC/dKvtXjDbJUQ4ZW+9ug8GITNkcyaiG5a
         abYjN/8t5bzDJJwRht/AyVrIOkSxuD8s2ohqEL/IRweeW60+UxAwJ1RVbc7FAOwZKxzL
         TxVcUht9vhO6kEoEwyn8EzsoxNBTvs8bdhi9wtWYReFtwXTfpvUz2NjTL8o/JFKCuA1J
         zgDiiky8ugWZJpQenExIx4k+b0gQrhaAEkAP70efB3SOQ3tY2KlZ45+1gRODUzMMfs99
         rDYOdwiviFX5bQJD+DpnZeM417SqwmpOD3CLxzSqZGr7LdTrLIwwahzwW6M+P0C/PrhH
         O+yQ==
X-Gm-Message-State: APjAAAXwev76aFW1YRMY1J4LsOvE1x7zh+Q16LkonYQHYIFaSiFVbhPM
        6DwbGelH1EQ85fue3io3mp4=
X-Google-Smtp-Source: APXvYqwkyjbyRbIDwzHLqUCXONl6iD7eRwpOm7LH0hP1qKLV7V2NDsADp4MgAX3Us/mim0cgJSNrlw==
X-Received: by 2002:ac8:73d0:: with SMTP id v16mr13423388qtp.335.1574711236454;
        Mon, 25 Nov 2019 11:47:16 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:15 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 08/22] btrfs: add removal calls for sysfs debug/
Date:   Mon, 25 Nov 2019 14:46:48 -0500
Message-Id: <9c4496199ee429b0bf162d43ccbeb768c6d1bec8.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We probably should call sysfs_remove_group() on debug/.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5ebbe8a5ee76..58d089354bc1 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -771,6 +771,10 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 		kobject_del(fs_info->space_info_kobj);
 		kobject_put(fs_info->space_info_kobj);
 	}
+#ifdef CONFIG_BTRFS_DEBUG
+	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj,
+			   &btrfs_debug_feature_attr_group);
+#endif
 	addrm_unknown_feature_attrs(fs_info, false);
 	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj, &btrfs_feature_attr_group);
 	sysfs_remove_files(&fs_info->fs_devices->fsid_kobj, btrfs_attrs);
@@ -1209,6 +1213,9 @@ void __cold btrfs_exit_sysfs(void)
 	sysfs_unmerge_group(&btrfs_kset->kobj,
 			    &btrfs_static_feature_attr_group);
 	sysfs_remove_group(&btrfs_kset->kobj, &btrfs_feature_attr_group);
+#ifdef CONFIG_BTRFS_DEBUG
+	sysfs_remove_group(&btrfs_kset->kobj, &btrfs_debug_feature_attr_group);
+#endif
 	kset_unregister(btrfs_kset);
 }
 
-- 
2.17.1

