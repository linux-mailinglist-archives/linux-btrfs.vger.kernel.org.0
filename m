Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E126110461A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfKTVvj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:39 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46298 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKTVvi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:38 -0500
Received: by mail-qk1-f194.google.com with SMTP id h15so1210774qka.13
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=V0SGfFcUp747oNGVEqYMJlEuXwf3wUUdepKGBwzX2YI=;
        b=m87ktfR/KXogknLYsKCbrCwzLDO8lSrAtcTF4JfVXzZydZ/kJWe150kdaXlw9CjMxq
         /m88Sf8qWixpKBCfQP5MSnIPL+7A0R8ncsYzAxHVEfFnBcSevaL/CA2Rri5xbTNK0dHs
         uXo3gsHXRsa7jN78flH10Zl3ehvTMeB5zQ6k9q7gM+w7WQOs7cTbN1n/JaTcxx1kPu48
         slFjuqQg86Vq81s1PcbrB8gG57iFHoE3ttEQm1jNg4vS5RU5lxQW/54dTIpOe2eISmUm
         evOhoCyEUWrOoDtGYQw0tc80A5zuTznj2+ZON6Cfm/+PtrLQkr1GQrBtzoJrjJs6zRni
         RI1Q==
X-Gm-Message-State: APjAAAXj+/CLGZNB6Jr+j1B6ssHhzJ29ZLZ1BiytanyKr6Ke9YeyisKO
        LWPc5JgV3n17dK7xiuCGA7U=
X-Google-Smtp-Source: APXvYqwrjXb9ubM+uoC/qjcvnY07D6At5YIrGBDD2419astFM+QFe+cXlL/WCX1QtRKRIg6w63U+6g==
X-Received: by 2002:a37:668a:: with SMTP id a132mr4464425qkc.405.1574286696947;
        Wed, 20 Nov 2019 13:51:36 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:36 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 08/22] btrfs: add removal calls for sysfs debug/
Date:   Wed, 20 Nov 2019 16:51:07 -0500
Message-Id: <8e0bb485431f20edcfd80f3068b0849f90979b26.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
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

