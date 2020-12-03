Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E3A2CDD79
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502001AbgLCSZK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731615AbgLCSZJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:09 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760FCC094242
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:36 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id k4so2038087qtj.10
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=alicy9h9SDs6lc9wx8Vi/NzCeV4MDRigSf43yxYRDKg=;
        b=ARwyqd8p66kcBOBVbA9U+8WEPbLZBMdRb7rzKIGWmHeExoV0fK8HSBpWuR+MJ1fSO4
         33gDolnqmJraPj9dx91HbyFivtv0WajQUsKRO8O4DGtvJeY3BYOTv1esYpNeIkYgDSYV
         IUCT8Ngb6XdjoO3tziqPIpNPOztZoQO+dgxTgNYRkq7MzfyX77R+bGDQoynjfMMC00MM
         oWcFDdx3KX+FDywVc/dGFnGL46tUNdlKo52xMdNKh1qrPvZ1XczWtvb1W2TGIOMBGKeX
         X0eWcNfBlcZdI8vQm5PospWN7OpWM1wB7oEb2RsbGOVDi66hVNVdYZUBecPipwSTqMOo
         uk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alicy9h9SDs6lc9wx8Vi/NzCeV4MDRigSf43yxYRDKg=;
        b=gG/5Uuj9pXeGQiW6XorUvjM7yjeEhN977lgdHQWl+pmsWfV0YDyjBaJnIhbjEPYh8n
         niZdqGxHg6hhD0pXDEuxiN0ZPOgMGmGmo398i709FUtPdw20Mz+RkpI5PFMNMiymQKF3
         a/hmmJKykNQB7m2iVdkEDgfPzjKlXE/CVP2IljHEcUwyRv7nVmtK7dAqPCAhrgBy/ugQ
         9UdQdXM01IbOsp0NLhDqYsibyrwqMibNZ9c85K1+PZEYKLMmLBoV/4IxDj2o0fKT9us+
         znGsG6Bj3q0NMc8Ij18DvNm7tUrRwxmHYKLLMirChcozicJq0pXRYYs3X7WgbQva3jQN
         VlzA==
X-Gm-Message-State: AOAM532CgRSoJ+6AIvzaF6zJlMEPJfGfdRMzxYjg8qUsoy8IIId2PeNN
        zFddnRfbcTdqq1Dt8vxfHOHzUgRoLvCnuaMH
X-Google-Smtp-Source: ABdhPJy6z2WVLLnwzHUqghuh0jbJ6bW6JW5iqjFDQl/ODvkTf0cXFaGvvEPHpfWF7atZKzYms9sgQQ==
X-Received: by 2002:ac8:4405:: with SMTP id j5mr4471957qtn.47.1607019814926;
        Thu, 03 Dec 2020 10:23:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y189sm2367836qka.30.2020.12.03.10.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 19/53] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename
Date:   Thu,  3 Dec 2020 13:22:25 -0500
Message-Id: <7808aa3b4846c26363dab6127195d813954f7a78.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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

