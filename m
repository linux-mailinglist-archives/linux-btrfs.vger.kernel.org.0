Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFBA159B4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 22:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgBKVkx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 16:40:53 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38700 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgBKVkw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 16:40:52 -0500
Received: by mail-qt1-f194.google.com with SMTP id c24so20680qtp.5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2020 13:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ybxDtnfdsoEM1GzkSsc/ipKZi9W7rroe3qi+OrZucuY=;
        b=oGLqRLjhrl72iki16liE8ZPlh2hwUE+sAo6R7BuwCBDgtocJ7fYoih16vleLxQzUrD
         jN3RtuwV7vvXxvFT1NuLpn0AOuXrwBS0TvQmZLE7KYuhLJ1npQekQ/4GYaYY9flT4fHS
         TUFyOeVUTRyLJOX9oO3aZkojj38kTYnaYXpejyihQU9ih5H4fkUVLklv2QKMZRfN0CPs
         XC8+HyjxlUxut2A2xet79ThzJPaY9NCnk7Nu6waLdCGMSUtas0Vrgbh95w36IDAuNtO2
         dRjkYuOrZ8pSbgB6qR11qi18UhlOuPbZilJj3bTSEIb7vym6gZL1d0A9dNmSx+rXbS83
         nBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybxDtnfdsoEM1GzkSsc/ipKZi9W7rroe3qi+OrZucuY=;
        b=EyRxkN10oenvvf99ncT2S7Zs4JrO/OvvXTb3b02FxDRzSLwwGum1m4Gk3An0JEQs3H
         rt99fSXB+dCa1ZNhsvokmVTnk/nu+c30unGLQ3QUXkfaY6bm7S6Feukc85qdXA/hHn3b
         H3O5CCTFHvuz86KLrHDssHObaJhNqL3+7fC5pqSbqDmkoyNG3ry4QpFCl9zXqxftLmGx
         If6t8TMUk4hCSzZxTxd0XfA3ev80Uc8eXVsMJqic8sJYfmaw/Z536NNv/nb4xiOuCDMK
         WH9BSbu3VVibgJSvzHb/VbL1YN/AZWilZ9p3ryQQDPnQO6FMkl6g7VCU+x1LhDrICXp2
         MpIQ==
X-Gm-Message-State: APjAAAVv23KhpfXj+CjmRFB3qENrjUuxtqNOxIUOBdAF9MAH8uC0QXAc
        ZRuyvhdqysbZd8QOn3tyRhgeCxyZWjc=
X-Google-Smtp-Source: APXvYqxluzTdB+VrOKhaFPWzwnCeI6q70JcLLDsnXFGc/kit8eq3Dz9Dzd0cGiO1Z0h+344nbXeNZQ==
X-Received: by 2002:ac8:7357:: with SMTP id q23mr15633348qtp.12.1581457250904;
        Tue, 11 Feb 2020 13:40:50 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w60sm2895619qte.39.2020.02.11.13.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 13:40:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/4] btrfs: handle logged extent failure properly
Date:   Tue, 11 Feb 2020 16:40:41 -0500
Message-Id: <20200211214042.4645-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200211214042.4645-1-josef@toxicpanda.com>
References: <20200211214042.4645-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we're allocating a logged extent we attempt to insert an extent
record for the file extent directly.  We increase
space_info->bytes_reserved, because the extent entry addition will call
btrfs_update_block_group(), which will convert the ->bytes_reserved to
->bytes_used.  However if we fail at any point while inserting the
extent entry we will bail and leave space on ->bytes_reserved, which
will trigger a WARN_ON() on umount.  Fix this by pinning the space if we
fail to insert, which is what happens in every other failure case that
involves adding the extent entry.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c43acb329fa6..2b4c3ca5e651 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4430,6 +4430,8 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 
 	ret = alloc_reserved_file_extent(trans, 0, root_objectid, 0, owner,
 					 offset, ins, 1);
+	if (ret)
+		btrfs_pin_extent(fs_info, ins->objectid, ins->offset, 1);
 	btrfs_put_block_group(block_group);
 	return ret;
 }
-- 
2.24.1

