Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D77ABBEA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 00:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403871AbfIWW51 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 18:57:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34799 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfIWW50 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 18:57:26 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so37727531ion.1;
        Mon, 23 Sep 2019 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ROaL1ywY/Q2RCn2pJT/rR2PzIDfgf2z/1+keY+ag5Po=;
        b=Q/Q3H3ThqKBSLPSFiylG5f8KZkJHXgUMiGWFzFzBlRwuBU03X/kdLUuSNmwAq+wQ4X
         apgn8ERLRW749INr3d5G2KONR0vRhxmEl8QzNvtWMOxQAzGlF2aAwF8GX+Mf/HpWjkfP
         Ay9klDk2d9/Zcn4A87Ktqt9I2HECAs0BpJ9QGHDCrm/jVCTf6I86GanyHru2bUU7398e
         4SIpHhhGniqzqkWK7MZJvONxI0taDhVHIR/yDcsLPWN63XRzdsJvcwhMKgDtCKvwkvhw
         nGYJdkRyVRDhTkXAT6p+/60DSznOjMaR4FraHQk5vReR8bnDjVcb45TlhFXyMSyB6nze
         Xhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ROaL1ywY/Q2RCn2pJT/rR2PzIDfgf2z/1+keY+ag5Po=;
        b=SNM1NKwDVrXnf3G7pfm1YaV66kYfS+Vm8CItLnn3SdCYQV45CtFZ4xAp9012rC8Yx6
         wzwWCz3t3pHG3Z5TaS5BhRGBRt2TnSsBHBGoO7P5EQ5zNdpRNsKhwH/IWpGbTlVU15mJ
         D7SRsMPU7+jfyWatOUin+zb8+KP55USc7OnnWxKTYzFbTRP2+mCWD9zlhscfDrvclBvf
         WGBFnM3EIS+/UjqB9PR8Cfgx4tn+HsNwwHuBl8KIA0CYCUAZqLd3PqNMR08sv2YCnR+f
         JfvXBx2PvuHuBpQP6YpLGUTEwpW8Yb8vxxzEDwB2nXJSoW2bYexMvXdjUvGz0k/nRAwq
         xd2w==
X-Gm-Message-State: APjAAAU/gLliMXf0GYAYQeI9pflklB9heX5RHeJalL9jQftI0JhIK5qS
        k4Zp7Wp6OG8HRZnamUWUlMw=
X-Google-Smtp-Source: APXvYqw4xR+V0W+nnaECtbCLv7B0EIt1U1Z9y5K5kkiSgO8J3Wjr+Om0PTPNKx78UMbRaEAYEWHMRw==
X-Received: by 2002:a5d:91c8:: with SMTP id k8mr2268069ior.232.1569279445977;
        Mon, 23 Sep 2019 15:57:25 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id r141sm38647ior.53.2019.09.23.15.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 15:57:25 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: prevent memory leak in super.c
Date:   Mon, 23 Sep 2019 17:57:10 -0500
Message-Id: <20190923225713.13381-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_mount_root the last error checking was not going to the error
handling path. Fixed it.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1b151af25772..9f3f62c000fa 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1565,7 +1565,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	security_free_mnt_opts(&new_sec_opts);
 	if (error) {
 		deactivate_locked_super(s);
-		return ERR_PTR(error);
+		goto error_close_devices;
 	}
 
 	return dget(s->s_root);
-- 
2.17.1

