Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313732CC725
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389792AbgLBTxU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389785AbgLBTxT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:19 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1501C061A54
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:48 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id k3so1311423qvz.4
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=alicy9h9SDs6lc9wx8Vi/NzCeV4MDRigSf43yxYRDKg=;
        b=0OnvaO3PazLKgFhFCccXGJN9laIzx7qwWv9vWoIdlYQ/KOB+XjRM2JMtXZr8CUP1Ay
         49X4K/Ne3Ov62SQJoBUa0NGmiC7SUOQoyl2zSdMRYb0z7mmaaub1pYV6zlGHdVlJtrxb
         S1qwBJFA0H6ZXtWI465+to9BUYu05G+LbTmUY9NLOKFnGv6B00vF1mKuNn4HEGA2EBlC
         enebn1WMASC+9JdmPoxiVAsnBaZxNq6VQ6IpFqScxOQEkmwWCTq57nXkfU6GdC0l4aGi
         zaNgoKfg7FhGih6DZbhYQzi0lgzUYBBoR9m60euKojL+wX0JSPwXXDFEHlGGKvuwEHVV
         i0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alicy9h9SDs6lc9wx8Vi/NzCeV4MDRigSf43yxYRDKg=;
        b=JMdgZipP9RizVd7ONYMJFxjqx8m818ynt7i9W2aPnZdh+cpyrk2OgK2oVzM9yjY83b
         2D+oN+lnwhZ1QcSTaafxc9NNJO2aqCubyqJZiV7YweT+yrPqMTYt/dyo8QIU7aH4Y6uu
         Z0P3AZIGa+ra3jAuTaSBd6ilaDzZ5jHT0woDx6n4tlt8jIZn4MFx8t0kAklRBr8xKw6r
         2WOW59rOU2UQf/mcrfROmgyJQ/0d/yUgubvKMuAEvvb2m/HyLCFhtcF7XXhJZpH1fFp2
         TwDDB1XFgT03HL9w+ZbGeEl3uFhFgjeRHb7H4MxeGKnmk2bJJ3sMHYrlXLK5Xxfk+a0r
         RSiw==
X-Gm-Message-State: AOAM530atof0vV8B0AcFnIQ6z6Kln73O/j2FoQ13BC2gQ2trIj3u+sVP
        bIGBzsAIxtGg+3q2lj1W3mZEQHTblLpKFw==
X-Google-Smtp-Source: ABdhPJzJAcAQM63SfNAzR4e3EExokdqt2oGwA9gYyMfrGSd+2ed69KeO67DFloLj1aCcIWe6+YUBDA==
X-Received: by 2002:a05:6214:6a2:: with SMTP id s2mr4274226qvz.58.1606938707708;
        Wed, 02 Dec 2020 11:51:47 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b64sm2767634qkg.19.2020.12.02.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 18/54] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename
Date:   Wed,  2 Dec 2020 14:50:36 -0500
Message-Id: <c2aaec2b66cb6fad677dbca6daeec2a0e5fe5c88.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d34cba37a08f..40601a0ff4f2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9186,8 +9186,11 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out_notrans;
 	}
 
-	if (dest != root)
-		btrfs_record_root_in_trans(trans, dest);
+	if (dest != root) {
+		ret = btrfs_record_root_in_trans(trans, dest);
+		if (ret)
+			goto out_fail;
+	}
 
 	ret = btrfs_set_inode_index(BTRFS_I(new_dir), &index);
 	if (ret)
-- 
2.26.2

