Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E002B2052
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgKMQYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgKMQYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:46 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660FC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:46 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id 3so7069027qtx.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iCLmv2LpHckWp0z53a63hZYpIQrEaYcXTSXF3YJpQg8=;
        b=vq1h2c1J+tSllfAI3drCQzizascFmPjo9ieW6bQ6JY3vhHdniKK5/SijcdNBV88FAZ
         tYGCxcgHuuCqoOjSHlkpkUi3Ju3WGjxrIshKbdBx1HocxlfeSiGWVpRI5W3kD7tozDv2
         CjIOyJ/S5t5kNGPNCjtMCFxEuflJfYsBhW+ZWdrEOs2A8VIEo65ZuiiZfTrl19mfOiGH
         /54bIitOut9vH3/alaHIGf/GJXYaBPYACYVqvsoRSRvRpz/UazrIzp9uIU1aMpH4wWOr
         jdfzN1sDqDuwvSxA9gtMgkUlpggmcHu2ayoaNiSDYuDq7634TGjdk6j2PlDQMJbTKi0l
         YBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCLmv2LpHckWp0z53a63hZYpIQrEaYcXTSXF3YJpQg8=;
        b=aAB33OEunZvrjh01GkcafbjpT7y+c7EmE5SC5591QNDiBdtL+iAo7h9Rr8zNemXXM0
         M0x3dA1kf6PRbd+uDGI2UsmDHNIbcA6mqDQ5Z/fgo6i8OvApoPDK7MKHYuJ3/j9zi7Yd
         mdXNOm1kke99bQEWTb0VeXEQxWr6cE7ofH4Svk00mfqd9Ds5PHIozyhjhCsP/PovdMRp
         uGv6jFjtpGZ1bBAlHYXpQPl4Thh0WJX+79YThwsDgEqPltUnE5cWEVDQNOyrWRhItvsK
         kSFGaVkCqjv1HY/fig4nwWn3jnUg0PHJdkpgstPd4AqfhnGC+Cs79B1/UEYOShXFnyiM
         PZww==
X-Gm-Message-State: AOAM530kkkYXylftIC9L6QoRRm5Fo4olTaBNwZTbXchs4vqb9jIwf6+K
        fC/xpcLGWqqquqXTfYtkv1NjjWy5pAduZg==
X-Google-Smtp-Source: ABdhPJySZQD2nV+89oPrz/Zb4nLJqaZtLQmruWabDnzxXpOlsw+q8s5qKoAckZdij7x4o5V/IBiS8g==
X-Received: by 2002:ac8:4897:: with SMTP id i23mr2572167qtq.211.1605284681209;
        Fri, 13 Nov 2020 08:24:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w81sm7118018qka.124.2020.11.13.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 36/42] btrfs: do proper error handling in create_reloc_inode
Date:   Fri, 13 Nov 2020 11:23:26 -0500
Message-Id: <f36978a5293b0fba99f989f9860cd6b018945db8.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We already handle some errors in this function, and the callers do the
correct error handling, so clean up the rest of the function to do the
appropriate error handling.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8a9c946302cd..c4b6eef70072 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3601,10 +3601,15 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 		goto out;
 
 	err = __insert_orphan_inode(trans, root, objectid);
-	BUG_ON(err);
+	if (err)
+		goto out;
 
 	inode = btrfs_iget(fs_info->sb, objectid, root);
-	BUG_ON(IS_ERR(inode));
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		inode = NULL;
+		goto out;
+	}
 	BTRFS_I(inode)->index_cnt = group->start;
 
 	err = btrfs_orphan_add(trans, BTRFS_I(inode));
-- 
2.26.2

