Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E55339843
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhCLU0S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbhCLU0A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:00 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9DC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:00 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id 6so4828931qty.3
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GnMZDF/O4JZv/4zqXZjtvesTd4a9V1cxhp5IFVF288s=;
        b=XknyHN5gKkuJ8o6+wiTTuEeEoA3ug0u4zi/2W17VH/WolBTNbwSjxJjvTzjgx9WD9V
         pdharBYhSNwhvY1XpV+gGAWnCyPQbIFFG+Hs6y/6HTdu9ODhNZ/cjr1Uf/Qek3HqZB0m
         qpV0dZzwlA6IpW+vJiX9awMmILtpM/aWaUp3wxYH/hUsn/bEz121e67qKggmhcLSic9i
         s15KuEXoYKXKQuddFAPcGYtJLEfhSlh0To5tQSqbb40cPMNb3VaLPvPnfleS3QqFznhI
         osI+mR0/YWQ6KpRXUIh9/v4LOjoL2w3hjHoA7dI7i1bWEWxIw/CIcb5Gtz8hca3va3jz
         Z8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GnMZDF/O4JZv/4zqXZjtvesTd4a9V1cxhp5IFVF288s=;
        b=sOFkXQG4aMtAVWXHIh3QNV1ixzLe4uscqoRVnLSn7HaRiWs1nLLco71Tv5vUe0QTsc
         OYNQnXuoErugD/hHHu6PKoiNZhtyK3RVdN+hduhGfPKbv/ZfAH20TNzBFuTMrXr6QOjh
         02oSDoZSVuDYNd41HLbR6TOT5C30YTk9MNzHq1FllArwfgui8vl9GSanOoDohh6vRAvU
         cXtKHFUD4ikw44sJveAG7QG6MF7qtwMLJIylro1xD0uGVm/w/PaCciR0nnKl3pWMDtHt
         4IV5Y7k6PyVFusiRVERzt2+MaCVaxR9dGY5vKHd1TycZjtwgONWmjI7cydS7TThcR7/q
         owmw==
X-Gm-Message-State: AOAM532ExSesNtqCerVF9Zhpz7mjN5qHC5n4GsLKlBwu8ShwvjfCt5nx
        mkqQE6p2f1sGrUjksvK4kn3O2Zb3I3VIzLKD
X-Google-Smtp-Source: ABdhPJwEogEb2ne0XqDZtYaOjQQJE0DDn/hdSFifal5mLblC100fzuH+ZVSlBrkqgBLDIvYRCsUexA==
X-Received: by 2002:a05:622a:3cf:: with SMTP id k15mr13756028qtx.368.1615580759313;
        Fri, 12 Mar 2021 12:25:59 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z7sm5095739qkf.136.2021.03.12.12.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 15/39] btrfs: handle record_root_in_trans failure in btrfs_record_root_in_trans
Date:   Fri, 12 Mar 2021 15:25:10 -0500
Message-Id: <13e101dee1ffe75dc455cfa8f290f80f2b176ee5.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can fail currently, handle this failure properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 26c91c4eba89..7ee0199fbb95 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -487,6 +487,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret;
 
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return 0;
@@ -501,10 +502,10 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 		return 0;
 
 	mutex_lock(&fs_info->reloc_mutex);
-	record_root_in_trans(trans, root, 0);
+	ret = record_root_in_trans(trans, root, 0);
 	mutex_unlock(&fs_info->reloc_mutex);
 
-	return 0;
+	return ret;
 }
 
 static inline int is_transaction_blocked(struct btrfs_transaction *trans)
-- 
2.26.2

