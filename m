Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4992B0FF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgKLVTi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgKLVTh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:37 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F48BC0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:37 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so5190357qtb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qlI2N4BDNbWyeQ4+U7v8Rki38Jddw/xvqPISHuIJLeM=;
        b=yeCNOjcaAyXqYKLUZ7daLoBzwsHCFgQ62knKWWHzIi9rDcweUm8vT2FeXr0Y3RFVYA
         F4x1ftvfct9lFGhYbCyCls7nHKeHO5u/GUSeYTCOdVpBHsf7DZMWT2LLYEP8iyHt4grD
         lO/QGmu3w8K3VffJtVjF6OEi4bkyOg36UzrKY9lK64gzhCjrSpKXbnHi6Y7uPAlzRD7e
         sqq1pNK16lMpUIfTdb04PLKayaAV88eTq6lKFuisqe06mK2VS/lDgu9a69mHh6lf/3tQ
         BUTjBILWCp4EfSPKBEbjSJwzDs/ue/39LVIvbAcNP+5ttaNHdZlIkw5+t4q4XqvuhVzD
         ZqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qlI2N4BDNbWyeQ4+U7v8Rki38Jddw/xvqPISHuIJLeM=;
        b=HTXh6ruefnU5O6O6NUlJ9AiRHAuses8w+8Lr0RJ+wPHO80NS3+Vc9Ws9JvA1AQH5Q/
         WAtOH4jG8+vgxPbWjYbrLbjMPouLtnM5p7U/r2xmYjC/BMl0k0gTwFyyRjQlqnVlSMgz
         4QKAp53Z0oelQ9NEQ7Df8iWInZgvdzIqkq/zdPqyK45rTQIu63f/HlkOdCN8b4ih2azD
         uXBstz8+cteZoN/4UygArzjFmtOUel1Pj/o0rlWH8/y8clgnBO0+2VN5bvvOB4rnD8CW
         6E8PQ0WXkDX8YwfpG1N2rz/bOR27C4fximW+Dgs1a717cTtmX4vIS1GHxR7fTXj8nqII
         xpXQ==
X-Gm-Message-State: AOAM532muli9Ac1ewhbmrs/HyNAQuwePQ+itxdf3z/N2yyMFHgbAoLgU
        MewPWgI8ARcgvBlvva3DJGU5KweW1aPiNA==
X-Google-Smtp-Source: ABdhPJzJCJ/GrfoAmCbm21pGp9QY8yrzJjzqobIeUFGqsIipzfopAcdO3O8RO1dz0j14Eu7z5E2IpQ==
X-Received: by 2002:aed:26a3:: with SMTP id q32mr1213484qtd.68.1605215975876;
        Thu, 12 Nov 2020 13:19:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g27sm5028686qkk.135.2020.11.12.13.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/42] btrfs: handle btrfs_record_root_in_trans failure in btrfs_delete_subvolume
Date:   Thu, 12 Nov 2020 16:18:39 -0500
Message-Id: <9480338a1528aeb7990b40c5c657936c3339c607.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_delete_subvolume.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ab7743c8bbd4..0d9be9419a80 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4049,7 +4049,12 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		goto out_end_trans;
 	}
 
-	btrfs_record_root_in_trans(trans, dest);
+	ret = btrfs_record_root_in_trans(trans, dest);
+	if (ret) {
+		err = ret;
+		btrfs_abort_transaction(trans, ret);
+		goto out_end_trans;
+	}
 
 	memset(&dest->root_item.drop_progress, 0,
 		sizeof(dest->root_item.drop_progress));
-- 
2.26.2

