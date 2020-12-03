Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDB02CDD68
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501959AbgLCSYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436500AbgLCSYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:46 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6200C094243
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:37 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id q7so1417817qvt.12
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVw+4yG4AsOpvC9Z2rvn/D+LlOaO6eS1UP7OemY6wRk=;
        b=yYZY/lWxclMR2FAxCJe85WWU5Tblh1ruloCqIw7ig+crEbIaOu6G/pwmLdelCq5n7D
         656Kv/wTfxG+WackEpnBOAi37wqffpeu1WK2dflwvzvuRuvFyOftJ3lzTBa8OWrHDOis
         iKkH82h/bOV0tSxQXODZTKeIDS1c8Gnkt6N8XK6WsBaFgDIaeT3Y1NwdGrV1NY2/oKf7
         a+OasfK50obyKsOx/3flSDX2K0mZH9B+kxXLXDsGgANCApm8fUff3JIa2H5ahveetv1+
         1SfRCn6N+9Fn2dSoejMuhEwFqQc0/eUq78NPH8ut6n9iLsjPlndfUjSyycG28djbU0gO
         BDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVw+4yG4AsOpvC9Z2rvn/D+LlOaO6eS1UP7OemY6wRk=;
        b=Jfb4dQZEo7Tv+IR/FCqDI6V9U3Qd5WV4SAqDo/vs1KUdsnsny2FP8PSkarJmDP/K3H
         Zy8k46EHtqxpziFE1iTZPzUHKI0Asup+4MFlXewoS4F5X6MPuAw+yLDR6By9Cxf8Gh3v
         4woR8/Fp60WJ0A9HpAr6PHmXtFaTJE9AcaP20qYd4GT1w01/wUjDmh5V9NmO/j3v2zB+
         jJX7gZNSw0vb8ll+4/5/IwftDlyc0f/1YMwlBubLLZ7TVWVlkyilaw3u6KFDbIpemjT/
         rA36CIsfspHtxVlla/jdFCwSIVfRFQlCo0upNSgKUMBcMCwHAuHcHcoGU1+s5utroP3J
         DpJQ==
X-Gm-Message-State: AOAM5331Revp6Gau5zozMBwLXvn2yFiprWeNlEdVNheY+LkCuczatGga
        EHVz2PJxDELbBToEhK8FeIVGcrStzznl6Gla
X-Google-Smtp-Source: ABdhPJyzEx2XWx+360iwucdRR7T5CA8okIxBspvdbHwkR3fXpjTVFLfSDt4a1+j6smug8i9lccCOfQ==
X-Received: by 2002:a0c:f7cc:: with SMTP id f12mr371731qvo.0.1607019816719;
        Thu, 03 Dec 2020 10:23:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 100sm1936388qta.20.2020.12.03.10.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 20/53] btrfs: handle btrfs_record_root_in_trans failure in btrfs_delete_subvolume
Date:   Thu,  3 Dec 2020 13:22:26 -0500
Message-Id: <584edc07c62a703689486c2a4b1bdbd6f359de64.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_delete_subvolume.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 40601a0ff4f2..1f9fa63ef194 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4157,7 +4157,11 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		goto out_end_trans;
 	}
 
-	btrfs_record_root_in_trans(trans, dest);
+	ret = btrfs_record_root_in_trans(trans, dest);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out_end_trans;
+	}
 
 	memset(&dest->root_item.drop_progress, 0,
 		sizeof(dest->root_item.drop_progress));
-- 
2.26.2

