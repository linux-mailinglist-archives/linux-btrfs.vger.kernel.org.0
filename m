Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C003117620
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLITqU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34470 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfLITqT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so7635350pgf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=c7+AfibCFkJTA8FU/dbhfdDn0rrPQRSToZcX4Y5fRqA=;
        b=GJzHkOkWk4qGv9LFhnUCSm70On4aBsXhBZugptJoD6wroT50L9OqRjfP1UkRrFOxrW
         OThqWUjTS9HBiVBcX6B1EKPK5LmmKj5dyTIbEDkZLj8Ss5e5ysnbOK+UhQRz16Z0+f6+
         dqO9dRaOdLQUpKOn0VIBK2NegZvDk6g2K6F7RVNDXdpuLGg/Vxp3EICyI95FCGvnXkQR
         AoTFmSp3SIB59wUx8t+oCva2gdJyb3bVRFaLq9KtqZj1ZXIUVbazFn1tfez6D1MzJs9f
         MbTnex8addkXpj4o2KQhrg3bDH0IldRZln2XcEQg7bEZMYinRM/BUIx0IU0C5qDbHO7M
         pARw==
X-Gm-Message-State: APjAAAWOqD0Z1M0V30Ul+qGSORXjQnjIOyw5gIWRZgSUaRNLWACW+FnI
        Ihbx27yrXjDATk5jZWtKfJQlNjSbJAk=
X-Google-Smtp-Source: APXvYqx/x55QjqzflzOtIP25CGPSlT/r/728kTOqcoI54R8cxxByTUxn/kakoYLEj0+i/5+EFk+X3A==
X-Received: by 2002:a63:5924:: with SMTP id n36mr12336097pgb.43.1575920779332;
        Mon, 09 Dec 2019 11:46:19 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:18 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 08/22] btrfs: add removal calls for sysfs debug/
Date:   Mon,  9 Dec 2019 11:45:53 -0800
Message-Id: <58fcbd3448a6d1c3fba82d4b5a1c9fb811412f18.1575919745.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
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
index 16379f491ca1..4c022757ffa4 100644
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
@@ -1205,6 +1209,9 @@ void __cold btrfs_exit_sysfs(void)
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

