Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABB2115374
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfLFOqE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44638 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFOqE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id i18so6623854qkl.11
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jfbRXZ/5/MBFQWWw54MEoM9lTLz/KmX5CXwHy/coLzY=;
        b=IIsGxeTcd3eveCbIvURL4N6LNAitZCJEOOk7pCUn/AOtyc5LYZ1yi/RkXLDY+xMbtP
         Zaa6aG+Dv87PgKw3xPHOJTJDd3/8UFxrxIFs2xH4lCkRH6t6V9ivUWI6IyclC4gaQ8B6
         1FJGl8+iGBuPGjL1bZe8Ot3zuVTkzJ9kV2zATjx+lSey6BbNSwG6jd2+SduBFAoK6MoF
         HTFZrKLmKIlIWpbCQHYNnxvzP1NXScLmQHUslOYTHIaS1DUpNkaeatlNuYADIhcO6eXU
         Vz/gj6QXBBOInNJiJ9budUeQDcmPhHMXaZOO5DYjTlqzIs0ottUiGEBQDwbxeVcRYJPz
         gJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jfbRXZ/5/MBFQWWw54MEoM9lTLz/KmX5CXwHy/coLzY=;
        b=sIf4Q6uxFxGWz33Fg5GezrIHynOc9UjmEPqbsh+26Iloc779+vzb8ujPx2uEBP+4Ei
         vPOMlJlb/2mU/PbE7BC6A8FUBeko427S47iVVKxdEKm9rM4EcPXyI13oMJz2SJTgqmWo
         rzU5f+uTF+aBtiD3f3UsM7SFk2fTAdHNINZ/yPCxSK8XQrnBGQAoUSchlTVlZuKFEOSj
         4Xv7zIxsggZxrcaqZ4iEPYOfRS4cvYM+e20zD4G5GT6Q0u8G0M1BRFwM1fiHN5LVqRr3
         2KMf2KCoGUMTIk3zES5Q1NAE2Elu4MBYETP/ffDomK+C/BRWDsrlZ8ASfb/iZQWmkgT6
         tfig==
X-Gm-Message-State: APjAAAXPoAmhXD8BAchGqgttlraJN0tXV/HoFAAvtrdx9hNBiocZ6B7Z
        M6FeiRedHh53e7S3E71sTqJ86wJjeNLoXQ==
X-Google-Smtp-Source: APXvYqx/p7FE72MAbe1AOv4urLeYIcj8dUxiZth8SL8IMFO282CTH/il8u7/os+7OoSnlUZ0YrUpXQ==
X-Received: by 2002:a05:620a:548:: with SMTP id o8mr1526375qko.490.1575643563177;
        Fri, 06 Dec 2019 06:46:03 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s20sm5893325qkg.131.2019.12.06.06.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/44] btrfs: hold a root ref in btrfs_get_dentry
Date:   Fri,  6 Dec 2019 09:45:06 -0500
Message-Id: <20191206144538.168112-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looking up the inode we need to search the root, make sure we hold a
reference on that root while we're doing the lookup.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/export.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 08cd8c4a02a5..eba6c6d27bad 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -82,12 +82,17 @@ static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 		err = PTR_ERR(root);
 		goto fail;
 	}
+	if (!btrfs_grab_fs_root(root)) {
+		err = -ENOENT;
+		goto fail;
+	}
 
 	key.objectid = objectid;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
 	inode = btrfs_iget(sb, &key, root);
+	btrfs_put_fs_root(root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto fail;
-- 
2.23.0

