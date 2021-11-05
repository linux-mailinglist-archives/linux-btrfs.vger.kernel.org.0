Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D79446A23
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhKEUwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbhKEUwc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:52:32 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C352C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:49:52 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w9so3243102qtk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sTO7hkfVeK1NvbB6fUrvFX1seNZNrLPhRHh4teDShvQ=;
        b=nXiED6vWjJMRoXFgnTiv8LwD6+tKdA33gx56+h6gCfcYkIL4NEIZGELu7xe3mvCp5L
         kq4XhlFsoikGA0Qwze47zpdOCU8HYKgPrzXWy30PZIEhAxeBJysZlzh19sPq+aosFvxd
         QTkBCSzc+YIllAvGxYuXqh91FlrV3xXrca/HsUqUR+n8PtAkrJg2GI7WBnIpfhC6xzRG
         0Veu+OVQTVIPCVGqmAwSokPxOWy9nzJO80hI2klE+BMZdIGlxk8tcDk4GZiusmo9hwRy
         V8jl9O5yNicjg053Mi0/WfX/GIRHunv1Fa2LzEOcVTkstX63IYt4AqdYdV0Pmk28AEYM
         Dbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTO7hkfVeK1NvbB6fUrvFX1seNZNrLPhRHh4teDShvQ=;
        b=SYnA2sfG+uilNG2NW/MrJLj/XfhJ//CRGhKkbuUgrx+nSdnqJ+JL+g7fG6yyiFniaB
         aW7uZmcXNLaRNw/xodF9I59eXLlaViD/FL6tawncs+i4Z2uWruKmmH4looH0pK47YjQN
         U2EU912XprN18Fwt/AI3WbbtRBvtIEESEbKwVGQc0/S3lY2Z7M6QVmd8fSO0hIs7ZOOY
         +H2KI6hdhli2X8eOWucCAxMXC4TYKD3ErHcFachR0UZYav1Ujnc3Yjj54RTNW4WB62bN
         l5CDmaGhf8W8dWN9BzbMHO/DTfmd2BLsIxWq6vXcq8fx5rbCLklCqDts4ZotRzt+1KJR
         98rw==
X-Gm-Message-State: AOAM532m0xPqccEFYTCOwLwtcCuPVrND9/6liC7BHcGRax0FXYdO03I0
        yUtrlA/OyBq/OxgmHDgebdWhs/CZ4z+88A==
X-Google-Smtp-Source: ABdhPJytGoHeuX8AUdq7OutOHURTT0hu25uGYn0eKJArI1YTEg8p/3XdhSbNL6lxXSBqzYxgJ7bqMw==
X-Received: by 2002:ac8:5a4a:: with SMTP id o10mr65426484qta.318.1636145391214;
        Fri, 05 Nov 2021 13:49:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k23sm2662288qtm.49.2021.11.05.13.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:49:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/8] btrfs: disable qgroups in extent tree v2
Date:   Fri,  5 Nov 2021 16:49:40 -0400
Message-Id: <8d9ea620918068916f534c16c24edfd7a3c8ef59.1636145221.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636145221.git.josef@toxicpanda.com>
References: <cover.1636145221.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Backref lookups are going to be drastically different with extent tree
v2, disable qgroups until we do the work to add this support for extent
tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/qgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index be0c6ce3205d..2f37dbcfc35d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -940,6 +940,12 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	int ret = 0;
 	int slot;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		btrfs_err(fs_info,
+			  "qgroups are currently unsupported in extent tree v2");
+		return -EINVAL;
+	}
+
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (fs_info->quota_root)
 		goto out;
-- 
2.26.3

