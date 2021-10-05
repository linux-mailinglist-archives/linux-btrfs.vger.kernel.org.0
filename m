Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD07423161
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbhJEUOm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 16:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhJEUOl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 16:14:41 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C41AC061749
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 13:12:50 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id l7so293548qkk.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 13:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EujUb2zdQxZ1DX7m7qZ5lK5plbrk+V7MM+/HKaZss6k=;
        b=TYtc3khhbUgbbPEFK7PBrJrC9MQGUsuCNWgylAoTNzDmxHbhDXCs9vD4mzLJEU5g9r
         2Tzu3TdWNUWCsALuZh2ol6T/RITe1JkZ3BF3T1tGtYRZO8wJPdA0q5EkOOFnujhxuCak
         cmLi7QVBBEI84b9ORKqDHguFuXEZeWqMmWZXTsBlvkbEj9FyVtnzMPUyFH02UpyyxfxZ
         bamGsVzy5kvD5kmqRwOGG1cAtxrHlbc6SmhdgS1qf0bHDgNPqUBQmVXATkyA/t3IOIgZ
         okDh4DVnlno60oC3gQlMVVEoADi11H92Y7RLgRJH01DbGg5sbsJTQYZxiqARER2wkjFt
         /U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EujUb2zdQxZ1DX7m7qZ5lK5plbrk+V7MM+/HKaZss6k=;
        b=T2kuhjJPJXiwr0C3X9ZFKJFS8UIZ57ZERaX8Kthaxif5hVtukAczsJHPx33jBjjO1i
         W3+75g8HnWe3zBrv1+4TWPP9dk8VQIHqs07OXRkDUvI6UsUFmmj7qVqxIsbC4KI0/WcR
         D4sxRt81eXblIJx/wU9AfbcBJ7BxWDlYRsAlh+2VMI/GVslkCSRz9hx4/BrqzCDqkKD7
         09dbssqQkgDHQxUWxINlPMmSTpDBUOyrR8on6xLCctrnE7AYmw2WVX79K4qLGYS1hW7V
         3O3Dtq6dlNfvIZ40jk4AqGs14mxnXDqxDJbGuY+5b8rh0PxOxxkAp08WdKd+P3IW2gn7
         mRuw==
X-Gm-Message-State: AOAM533crl4fd7LamzO8ZNCm8sgOsCpKeYuWqHWsP/TbALHtFM6dEc+n
        nBadsHzT9sT1H26hQet/qV6wPd+yYKIKfA==
X-Google-Smtp-Source: ABdhPJweL+TkK7VZ9q/sQWP6fFQwaOE5Kc9cSWzlr7bMYSX+x9X2JYaHwsgUBVNTXlkM9eGq2iqstw==
X-Received: by 2002:a37:610b:: with SMTP id v11mr3000520qkb.293.1633464769462;
        Tue, 05 Oct 2021 13:12:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v19sm1473512qtk.31.2021.10.05.13.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:12:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4 2/6] btrfs: add comments for device counts in struct btrfs_fs_devices
Date:   Tue,  5 Oct 2021 16:12:40 -0400
Message-Id: <de61153ec9b67271f45f63a718bac0703bc171a3.1633464631.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633464631.git.josef@toxicpanda.com>
References: <cover.1633464631.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Anand Jain <anand.jain@oracle.com>

A bug was was checking a wrong device count before we delete the struct
btrfs_fs_devices in btrfs_rm_device(). To avoid future confusion and
easy reference add a comment about the various device counts that we have
in the struct btrfs_fs_devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 83075d6855db..c7ac43d8a7e8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -236,11 +236,30 @@ struct btrfs_fs_devices {
 	bool fsid_change;
 	struct list_head fs_list;
 
+	/*
+	 * Number of devices under this fsid including missing and
+	 * replace-target device and excludes seed devices.
+	 */
 	u64 num_devices;
+
+	/*
+	 * The number of devices that successfully opened, including
+	 * replace-target, excludes seed devices.
+	 */
 	u64 open_devices;
+
+	/* The number of devices that are under the chunk allocation list. */
 	u64 rw_devices;
+
+	/* Count of missing devices under this fsid excluding seed device. */
 	u64 missing_devices;
 	u64 total_rw_bytes;
+
+	/*
+	 * Count of devices from btrfs_super_block::num_devices for this fsid,
+	 * which includes the seed device, excludes the transient replace-target
+	 * device.
+	 */
 	u64 total_devices;
 
 	/* Highest generation number of seen devices */
-- 
2.26.3

