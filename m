Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695F12D12CE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgLGN7b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgLGN7a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:30 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0EAC08E864
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:24 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id bd6so1316379qvb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGNUuifwBsvHD2zCYX/FZac+Jy1QnxNpjtDrlcuIIEE=;
        b=W8PtRvIjBisHMMnaTE/keKb+oGlKjEXiUKLiBhcbYzX2whwT3dTZjhF86Xzem0sKCE
         gl8I9DyezJ9fYFT09TS+mA+5cMwmHVoADWmTYz3fsVqMNn9XenMcLwJjeu+hUIUiQk20
         RSFwpKviLhJlWA2OAyi679izizF5I7+0uDDWpDsHDnjNfy8Zo1MESxmpZoWFzuXPEnTc
         Yvf8Ar/Wz+tLEFiJxs3U7rKiKjYdo/oa2RQzQs0fhjMRMo+nIaCHpDKTXlKHZTUpFB2+
         s0DhiePFWuMpmyCuG/uSLjSQ7v6v7q2l8Wlxkqr9WkdzGibiISSeqAGOEowzISl8AROX
         mnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGNUuifwBsvHD2zCYX/FZac+Jy1QnxNpjtDrlcuIIEE=;
        b=Z5wVqc71xAlHDE+Ea81nQ7PInWBgF3Byd0fOOGltiJf4G7zuQf6mBrGwxmdAnr5Kf6
         +/1mTKZ2YD3gHU8/85txeXhUJAWy16cydXDeOwufFpqJ3JnuLNpGh+6xToOfU7iDWlJk
         qdzkZRXjfYE/zAmnF2cdIlzNkopaKkMSabjIgW0a6OAyy6m89pAxlTVaCX4uELvUA28c
         obYE4Sr3+hTcTdPVlNkVXLJatASLuDMwYH20hk4AoPsHMM+0e2VSS1KJ5he40ow9aMfZ
         oMTwntpe0wvN24lhhmg/ugTLilsJtfVQiPv8iFPwgFQfPuG8S4UfZEjFcB2ZtEkN9/91
         9dRw==
X-Gm-Message-State: AOAM532h6+7DDXILYq9fRNTJ3bHierbV4yf9A5N0ZuX/hz+HCCGTM7gE
        mM1vVQPfyIT0ZCYr6mgvO5Aru4kxo38yp8wh
X-Google-Smtp-Source: ABdhPJwJa1esUA3A7NdRlyato29BZ9MuzlPkLRQ2W52+tnbcHXyPQtqWYw0pFiYCXhv5Iz6BYrw+4g==
X-Received: by 2002:a05:6214:58d:: with SMTP id bx13mr20900852qvb.44.1607349503702;
        Mon, 07 Dec 2020 05:58:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k41sm3549455qtc.23.2020.12.07.05.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 19/52] btrfs: handle btrfs_record_root_in_trans failure in btrfs_delete_subvolume
Date:   Mon,  7 Dec 2020 08:57:11 -0500
Message-Id: <97d500594c239ba26d66433fa8f38938eef2f46f.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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
index bcbae8b460c0..7a8d89e1b73f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4175,7 +4175,11 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
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

