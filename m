Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87C433793C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 17:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhCKQXp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 11:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbhCKQXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 11:23:25 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06433C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 08:23:25 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id i15so2806348qvr.0
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 08:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BGIY45p/s4D+aX/Z7SVLmuYErsSA/3rb9cNdveUclgc=;
        b=EcMsJkVYkfRoweDGnWVj2pZo5xe8wY9VJgWClWnXulRIDfaFFoB8KJVurYcTbGNW0c
         vU9PUSR7hyU/9QhTIpF8dTdexGQBDJ63DUeIwOtgw8ER/EU5tg4gti/p6HSoWcn5JniQ
         GeL7f+UCp9T+pDmtVB/7RYSCHdxdpq8LQGFw5qo3bZYi3prl5xajrfJCsuwwv2ZInwwG
         TLV9IF2EYQ/86k85uTrvLeIGQgYh4YQUnqUNfQ4uptuCdnJLwo2zCNjyuqz76Mkf2Iyh
         DZlwhiR5jQ0TlgsyDHaMTArL3Ur20SZQRRXfbuRk1ftpizNZTBIU4fh90NoPzfUSVKro
         l7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BGIY45p/s4D+aX/Z7SVLmuYErsSA/3rb9cNdveUclgc=;
        b=cf7XzhMSGCHvZc1UMBGJHWJ3FkL6mg2lKBk+CTRJEtVcTxIO/2146O4NvaRwLgE5to
         9vjRdf9Z5k1GHv9dFKcbTYyvLEpG0tUGHS1ZaJ0tmUhNqsX9+1ofURamCQ1sVoC0+aJi
         aZPsG3Gyq2cDiH3WthwRrmNzrRe1RYTyaHwCiabtMdsYHe90+xbm8mQODq6TtLgXvtmv
         sSLUhHN5h/kfL+XzjR5a70o0FzKkUZseTlXQSCn6E7lZ4WSjVAaZTjq+kN9taRjMLQiP
         GSeYtA+qM0FUqzdz2ZtZtCAuO4wLKt+JG3GXFE58E6YQNCsLmFR0Jzjgf1rGBPMFn3Cm
         /XKA==
X-Gm-Message-State: AOAM531yghYD5JLQCsOaBL+hjitueIjkVWpGLux+68Fy5GS7u90//LAv
        dofcBCoc8j7TqQdzIROoOXx9bIzgwHNXUqFd
X-Google-Smtp-Source: ABdhPJy/HfODkAz4rJeZxsvlzYW66AF3LwToNg4hUI8LC2stFkX5loQm63YPG95Iri/c3uznMfBjoA==
X-Received: by 2002:a05:6214:20a1:: with SMTP id 1mr8442631qvd.30.1615479803811;
        Thu, 11 Mar 2021 08:23:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d2sm2314251qkk.42.2021.03.11.08.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 08:23:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Neal Gompa <ngompa13@gmail.com>
Subject: [PATCH 3/3] btrfs: don't init dev replace for bad dev root
Date:   Thu, 11 Mar 2021 11:23:16 -0500
Message-Id: <b6183586bd5d9dd6f26ff4aaf3bab0a6629c6018.1615479658.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615479658.git.josef@toxicpanda.com>
References: <cover.1615479658.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While helping Neal fix his broken file system I added a debug patch to
catch if we were calling btrfs_search_slot with a NULL root, and this
stack trace popped

we tried to search with a NULL root
CPU: 0 PID: 1760 Comm: mount Not tainted 5.11.0-155.nealbtrfstest.1.fc34.x86_64 #1
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/22/2020
Call Trace:
 dump_stack+0x6b/0x83
 btrfs_search_slot.cold+0x11/0x1b
 ? btrfs_init_dev_replace+0x36/0x450
 btrfs_init_dev_replace+0x71/0x450
 open_ctree+0x1054/0x1610
 btrfs_mount_root.cold+0x13/0xfa
 legacy_get_tree+0x27/0x40
 vfs_get_tree+0x25/0xb0
 vfs_kern_mount.part.0+0x71/0xb0
 btrfs_mount+0x131/0x3d0
 ? legacy_get_tree+0x27/0x40
 ? btrfs_show_options+0x640/0x640
 legacy_get_tree+0x27/0x40
 vfs_get_tree+0x25/0xb0
 path_mount+0x441/0xa80
 __x64_sys_mount+0xf4/0x130
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f644730352e

Fix this by not starting the device replace stuff if we do not have a
NULL dev root.

Reported-by: Neal Gompa <ngompa13@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/dev-replace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 3a9c1e046ebe..d05f73530af7 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -81,6 +81,9 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 	struct btrfs_dev_replace_item *ptr;
 	u64 src_devid;
 
+	if (!dev_root)
+		return 0;
+
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
-- 
2.26.2

