Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D442D2F84
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgLHQZv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgLHQZv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:51 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA0C0619D2
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:58 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id p12so8448058qvj.13
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=spjabu9k22U8QvInYIw0gNrlCBCJU+aYdbwhJP3xbSw=;
        b=jBtW0t8fpavFo/tY92kocFln6D7zI/NPcsdeKicUBllcWn25ulXy7znOZVN4ohbwrG
         caIjvZn5gcAyJ8zoc26TQ8TMX4CBrw7KvvwOVYrgk9THTLVyAqCp1geTEfd0cZrSwcsf
         5zanYEmWYroCh48W8tLDgBrxCvmJ6O/TcKBLI0xUAbroVldqVAyfNcUJu3MybrFWXIyl
         2L6gwI8qaHMQdg+56rhvfQoAviVUjyqGirrVQQQbZ5vfvVQ9Dv8VgRaZMsk0/minjq8O
         uuwoIJBlgWCHvrwuLjh55jkV3IcBUmmQ54zaHdD/83huV9MSh66UsnUEC0qsnn3LxR8s
         Nd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spjabu9k22U8QvInYIw0gNrlCBCJU+aYdbwhJP3xbSw=;
        b=D+mILL7WK2pp1HpARpGVX7qOF+6Zg1VSglMxZPXKs32XrnIgMDk4S0s68fmXPuKUL7
         5HxYVGsng2VTLIkXcionqDTnfz+FIGp8R1/KZA3bZT+WENLbTOOMSe6Hb0hJLrvpXe9Y
         9xN+3RVmPa2jfPjvY/sCrrUmQb2i8dckPyF2rjp1EHVr5OrZp0yhCwvMZiZDu/pQ7Gbz
         xHvu4MH5N+u3E5maWj4L3AlRwYto91OLTxENUCyuob2yB4aCB0VlePCpso9mt5lR+Nc9
         Zhlu+OlHwQlV78HeZR20uSSOKq1lpjNvSu1FRySK0ej1wtXOPjr7tEmASN1xgY2EOeFq
         7CZA==
X-Gm-Message-State: AOAM531lX52ojArTLDHWKwKJXDbEx05itfjszjcuGwmq/ze8Oo6rMwTO
        PZPjFO2Qe0Yxt7YxWMijQ0YMZkcHZ3EJByye
X-Google-Smtp-Source: ABdhPJw0b20XGhN5xP87EvrBNHhAtsKH9gvySLgG1C5f3FOnwH2vzjoE7Wd1MpWjL9p9rco28ztIrg==
X-Received: by 2002:a0c:c30d:: with SMTP id f13mr28343072qvi.29.1607444697208;
        Tue, 08 Dec 2020 08:24:57 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j17sm13801881qtn.2.2020.12.08.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 25/52] btrfs: handle record_root_in_trans failure in btrfs_record_root_in_trans
Date:   Tue,  8 Dec 2020 11:23:32 -0500
Message-Id: <cfa35bc3ae313efcb4b17047e76a5a15a54639af.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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
index 77feead2a324..7404d88e6201 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -480,6 +480,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret;
 
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return 0;
@@ -494,10 +495,10 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
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

