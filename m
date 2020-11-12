Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DC82B1008
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgKLVUI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgKLVUH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:07 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0574C0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:54 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id g17so5229473qts.5
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Jqb0Q2KFWCdUEdNSrCWi508mhvN7EKxtkJxvJVVfvyo=;
        b=WMtGIYZ9nMqNXQN4262n4zZio6ynHNSSW7yQAl4FSkd3020K9UembIoAJiwZeRDY7O
         0S80ZGJvsaeulVThB9UyB9s/xbXD7QiaJQViStJOEObJmLDFQT7eXhBwKeLaq8riPpKr
         S+E4sFeZrlOCTOfy1by1Ctamf3y59hX1Dn4yG94lvepJjI9afT/Na+kc9fLewrge/zap
         iA859roIcYs8f4BIHbxtAl/mZQl1qub79eEQId+OpjoRsOISTMmVQQHUsILmvRsBpv5w
         d56CvMgECb7It9sgZxEHxgUAtmwGb5POvsFN0vmK29PF1LNJ9uYaFuroGnZRB77mEKGR
         RSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jqb0Q2KFWCdUEdNSrCWi508mhvN7EKxtkJxvJVVfvyo=;
        b=a0nzJxAovqagZvKyL11X5e6Ky7xqQD2DEbszXNKiEaemEZMP32sVUAKWIsS63+bucy
         3VbpLfmJ3HS5QwhBmFjOVzbET6jo0zRzWP3O14GX2fc92jfnov4eXlPjNQLIuOKLcBIy
         UutsHasEPItTue/yAlN6ixXZL3iGAo88NDi9nw3qqUAgWiGcsPddmcySCEyev6yX2RNm
         A0X5jhAeZID5XKcvZxOvPcx97CnVZ/CHGyjD020iC/299GiSrqX1cYsbZUx2z47Bi70+
         8f7RGW8B2qiUWE5nKP8GWdQG/Ho2E46UWZIblWyxr61AETTTgmkZV594WyNBjFlmRdXn
         FlAg==
X-Gm-Message-State: AOAM533El9qMFNBPx33Z4Oil8nbdr+cKWJjqPdVL1OiaLpsjWm98YhQ0
        mfof9rTWgM9gcGJB/oCCuq+nOVHD8plRCA==
X-Google-Smtp-Source: ABdhPJyj92NvzjcYmV98sfO6Hwavl6IhQpr8OvfOm8EeDh67dHmDJsUCFPwnGWS1p1mSSP1srRH5ng==
X-Received: by 2002:ac8:702:: with SMTP id g2mr1241706qth.124.1605215993568;
        Thu, 12 Nov 2020 13:19:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i192sm5776518qke.73.2020.11.12.13.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 21/42] btrfs: have proper error handling in btrfs_init_reloc_root
Date:   Thu, 12 Nov 2020 16:18:48 -0500
Message-Id: <5d4f0da12a8c44b90a5ccede692235bf86df1ea3.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

create_reloc_root will return errors in the future, and __add_reloc_root
can return -ENOMEM or -EEXIST, so handle these errors properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1627e1378b35..c0be6b1f22cb 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -860,9 +860,14 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	reloc_root = create_reloc_root(trans, root, root->root_key.objectid);
 	if (clear_rsv)
 		trans->block_rsv = rsv;
+	if (IS_ERR(reloc_root))
+		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
-	BUG_ON(ret < 0);
+	if (ret) {
+		btrfs_put_root(reloc_root);
+		return ret;
+	}
 	root->reloc_root = btrfs_grab_root(reloc_root);
 	return 0;
 }
-- 
2.26.2

