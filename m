Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546D6E26A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436919AbfJWWxa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41393 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436913AbfJWWx3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id p10so21494402qkg.8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VIbSyVdau/I98QtdvvQuQTJpdN1XWghXREgP5+OlIwQ=;
        b=sLuVDnBvc8VkoItGRwYXT12+VUme9yaqKg6S/qzLeXSAlUAG+ea8hqlclUXip9j+K+
         NrrmGaRyZAj3FHpXrvU4qg3wAzbgUR5+ZpL+chzCx+wCF9wjf3Xo+o3rTRNB7wp40VTR
         Hxgo0EbVzpvZLMyr7FECq7iGej+Q1CrTJOUp5p+JPVkVmcGDhwzM8ZZmm0htyhqT/XG6
         xpY4vkj6n4xMWLoqeo5Yum0rDxlqYyLa2PUzBsrKV8JjNv+nDX8uvW3SOa5dRbGn0nqJ
         0O4AN+Bng3gmEo4pAiDZnlhJP4YVi3RhrU6ePrMFG5Z6GH/TUIrgVHY5fVWfaAoTJWRO
         otZA==
X-Gm-Message-State: APjAAAXYc6lzq1JUoJQkLS6HL9x+4+UzA2ryX9Q/GZxnVfz4oPfCZJ/J
        R8W3E886FURLpTIws7k7lmReaZdY
X-Google-Smtp-Source: APXvYqzxlV4RZy1AbQTixL7rxWYadEky1L9VhT9b4KEptgiF5CR5zdnXIOhnhXX0iBtmgF9S4O6kKQ==
X-Received: by 2002:a37:6305:: with SMTP id x5mr11120900qkb.498.1571871208672;
        Wed, 23 Oct 2019 15:53:28 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:28 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 08/22] btrfs: add removal calls for sysfs debug/
Date:   Wed, 23 Oct 2019 18:53:02 -0400
Message-Id: <a30746a1a3db0798aec558d9badbaf4f19320869.1571865774.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We probably should call sysfs_remove_group() on debug/.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f6d3c80f2e28..16f2865fbbd4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -732,6 +732,10 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
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
@@ -1170,6 +1174,9 @@ void __cold btrfs_exit_sysfs(void)
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

