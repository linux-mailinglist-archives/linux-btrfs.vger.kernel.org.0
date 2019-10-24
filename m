Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36FC6E283C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 04:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408234AbfJXCeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 22:34:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44927 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfJXCep (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 22:34:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id u22so21930515qkk.11;
        Wed, 23 Oct 2019 19:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RnxLx4iMo75xJka0lIAwxQJug/9mvKAFWodrvAvQzVY=;
        b=ZDc+x8O/msjsbqVuE0yiec7D0eZn8ze3gbThv12ReqVgPyUigwqgycMA+uIDdjia7x
         7rbiRfCFkz/vQFCLuNNis0BwUH804+DqyWpmXpBSjZk99/57Ogb8pxeJxdHy/pLEmzjN
         aVyezgp9av7RrjKjL2uEy5w6SfrGrzpnuHwRwZ2zZwlxvrNWaZbOgnyOUFWz6O/wRDLx
         npiZQH0n3eC+r1vt5+P4Gws44JFnGY+R7Oh9U2AEL06YX2ir+1efHvdNPrn9mHRyK4Kz
         FVY4H0j6EcwT0oNT4X3RhV51guUg5iz5tSz0dqvYp15yTULFQYpprM72b+h9CzgkYcos
         WqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnxLx4iMo75xJka0lIAwxQJug/9mvKAFWodrvAvQzVY=;
        b=Et0er9hvbyxu3nEsbtgznXCHWXzNbQExDpS1TMcobERU/lT5bR0dattATmZ1N1Pqc6
         jxyeV/SjLKkHeqABSbh4BimpS7J2m01r/m+DYcOlFUBhUd+ddXoRaGwJJfmQj2H3jO0K
         JyLhFBFcTj2EkUcet0bzwbY6fSfAzNhWUQwBSvbBR7/WGskix3cRGbaHMO4PcBrypsUy
         +0hWeOu94R9vGh2UfMeYa8K9lsGw/3cwFaohB6ie8zpoeiKNG5PB0UouiDrWX5Kb3uHd
         84cFuqZj141xJZn5lgpml03i7MQtFIJF+kZ5iW233gF9hnOoQE3e24bl9buqIFKFZqhs
         xqgA==
X-Gm-Message-State: APjAAAVP/bnFYFdiv64IFXvKkIhxSqBtesmfDVsb5XZ/3maAvdjOO2tE
        kMHNg3exSyIAixGFySQyjBeZqDDP
X-Google-Smtp-Source: APXvYqwJfJmS/60lUwsK1R1gGIGQOe7Pg/kcOo7BhftIJKBCy+uqnMMkuKdXRjZKV4+GRo8ky6GEaw==
X-Received: by 2002:a05:620a:386:: with SMTP id q6mr8967893qkm.243.1571884483899;
        Wed, 23 Oct 2019 19:34:43 -0700 (PDT)
Received: from localhost.localdomain ([186.212.94.31])
        by smtp.gmail.com with ESMTPSA id q16sm10252495qke.22.2019.10.23.19.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 19:34:43 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, mpdesouza@suse.com
Subject: [PATCH 2/5] btrfs: ioctl: Introduce btrfs_vol_uevent
Date:   Wed, 23 Oct 2019 23:36:33 -0300
Message-Id: <20191024023636.21124-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024023636.21124-1-marcos.souza.org@gmail.com>
References: <20191024023636.21124-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This new function will be used to send uevents when a subvolume is created
or removed. Two environment variables are being exported:

BTRFS_VOL_NAME: contains the name of the volume being added/removed
BTRFS_VOL_{ADD|DEL}: will signalize whether a subvolume is created/deleted

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ioctl.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index de730e56d3f5..174cbe71d6be 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -940,6 +940,33 @@ static inline int btrfs_may_create(struct inode *dir, struct dentry *child)
 	return inode_permission(dir, MAY_WRITE | MAY_EXEC);
 }
 
+static inline int btrfs_vol_uevent(struct block_device *bdev, bool vol_added,
+				const char *name)
+{
+	char *envp[3];
+	int ret = -ENOMEM;
+
+	envp[0] = kasprintf(GFP_KERNEL, "BTRFS_VOL_NAME=%s", name);
+	if (!envp[0])
+		return ret;
+
+	envp[1] = kasprintf(GFP_KERNEL, "BTRFS_VOL_%s=1",
+			vol_added ? "NEW" : "DEL");
+	if (!envp[1])
+		goto free;
+
+	envp[2] = NULL;
+
+	btrfs_kobject_uevent(bdev, KOBJ_CHANGE, envp);
+
+	ret = 0;
+
+	kfree(envp[1]);
+free:
+	kfree(envp[0]);
+	return ret;
+}
+
 /*
  * Create a new subvolume below @parent.  This is largely modeled after
  * sys_mkdirat and vfs_mkdir, but we only do a single component lookup
-- 
2.23.0

