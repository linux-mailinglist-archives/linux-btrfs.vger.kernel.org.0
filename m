Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804462B1005
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgKLVUA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgKLVT7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:59 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902E0C0617A6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:46 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y197so6881324qkb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Jo21LpZP+eErRwq4Fe6Mhy/517NyvlFaPgYRnoGB8OA=;
        b=AYXkNNX7AMHFeM70474+taVRXBCv/3rv7tJ4rGVTX4Ekk40I4Lu2QVO1plGmfnxGfU
         jXz9ZrYSdP1yht/2/T8v7c/pZ1h3dECIYV2MQqQv95etve9KnMOkjDzuasG7qKC44UJ4
         /RffRYL9NLqresFJWulcNpcIlXpHVNAKFQu4fM112FsiNKEdAysakEPen0XTaTixNHUM
         AVB4p8Rqg6Oy5/soIAYaIGU03aLNNcIKU0p4V+y47vlcNIj0wLhM+Bch95wy6R3DY8sC
         q/p6GwIpDlIpL/k5KY2XJFF+mEVQuaTY/Oxqirv7EY2qTZI1FVxl7X1g/97bykgVrNBa
         Frrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jo21LpZP+eErRwq4Fe6Mhy/517NyvlFaPgYRnoGB8OA=;
        b=aBX9SojVAH2uvB7un+Wxb+BBbx3vWZ5ZztcEzjVcP+HIJwbqoTSArBWE3UN89jv+qT
         xSyWUZCCk7Qn0ztSuJH0j5Ds+GKVyeSo1A4xIJH81XZLZkARfmh7WlewU07Q+deJR7Z6
         Znwt1UqPSdFF3j6Spp19OmeEuS+v4ZAMmnakf8Xs6jRbjHz6WLh8bKghneFxYf02XjuV
         dUxFpuRAuIycUNqKiCqDVX83hhIflZMUZgH+b0PhkbwYzuWuBrR1A/Ld9ckl+iL1RgIT
         sqJ2ijMm0lgZtq6vrKjtz7i+tUxgbM2OXY8+cqA7KRNJnLnfnAKHgg1XYhJjhr/mEdKE
         irFw==
X-Gm-Message-State: AOAM531cN3DHZvfo6dTfu0u0nSPPLWDp780fHa9Nzg9XUEp3wrFbfyAp
        CoFs1OYOoUSb1jiXOfXLN1FcUEQAjulTIA==
X-Google-Smtp-Source: ABdhPJysiBex3+fFfIuxXfdCrpxaFEvcqhG7L9MLpKtvaCHA+itb13lG+yoSzL4LGbgIRAN5gYF+NQ==
X-Received: by 2002:a37:9b05:: with SMTP id d5mr1821072qke.49.1605215985340;
        Thu, 12 Nov 2020 13:19:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p1sm5680563qkc.100.2020.11.12.13.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/42] btrfs: handle record_root_in_trans failure in qgroup_account_snapshot
Date:   Thu, 12 Nov 2020 16:18:44 -0500
Message-Id: <01d000df3d6b4abaa910f3699978a91c8b446e98.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can fail currently, so handle this failure
properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c666e6bef0ff..91be4a1a6bc8 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1440,7 +1440,9 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * recorded root will never be updated again, causing an outdated root
 	 * item.
 	 */
-	record_root_in_trans(trans, src, 1);
+	ret = record_root_in_trans(trans, src, 1);
+	if (ret)
+		return ret;
 
 	/*
 	 * We are going to commit transaction, see btrfs_commit_transaction()
@@ -1492,7 +1494,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * insert_dir_item()
 	 */
 	if (!ret)
-		record_root_in_trans(trans, parent, 1);
+		ret = record_root_in_trans(trans, parent, 1);
 	return ret;
 }
 
-- 
2.26.2

