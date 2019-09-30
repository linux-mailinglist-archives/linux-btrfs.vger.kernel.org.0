Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75017C1FE1
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 13:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfI3LSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 07:18:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33396 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbfI3LSH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 07:18:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so5441639pfl.0
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IPdAp3zoQsgkk/b9hPFlbqP9Kw9IT+uTu0lMeJnX6u0=;
        b=HwDCVyn8GxrT5PmncN1h0TSIaS7GxNqX6pVgsTxKH9+lqxgV4fV7XumcmOim3Tujnv
         qvQj1fhSBctBzVugy0BTxzOwDjn9Qf8WACx4jHeNCuByPUAVLetiSjhiW/rPGVXFM2o6
         2DCvf6jHaPY7/FcwmHav7lQ8IYL1yajnh1m66ipVcCWGS2XtmRUqruxxghHkJDVDYwEg
         GA73kf1dkns0OTp4d/lQtAXBOm7gu4MuprLEEtV452bAia8t+fnGwn5dxRRGX3+UEqU/
         5dmwAUh6VE3Y1ePsZEvWNVDUKQIDSKq/ph/6x44u+Dt8tLoqvV++Zg/qVqOz9ssTeVlq
         TGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IPdAp3zoQsgkk/b9hPFlbqP9Kw9IT+uTu0lMeJnX6u0=;
        b=Tdeq+w792kfkUu5k6BIFgkrjQA/KvVYr1yiFkgjUPBwhPpGqUA1BQfl7WiZMY/id74
         ZPf8UoArjE2QH00z8flr7dTcM9hWnf+GgoPnvRjOt7koLzT4+3LdhHkq6IiGpmsTqxTa
         xdevdWJ8k8Vh5ZvM43QRQ2HvnGYEATYpGi18Cue3rOntesTAcvJ1uLSI6twQVJihp963
         OvtTSrRk9Uj5isH2eMXQ4KCv4xkFiAwztO2wiztmGP1bKWiYhoOj61qweb8LSEDwhWRc
         ttTQfZcfMI7Iwxy47KNtgT8GnJ8/9ni1GF1sdAtbnKxtqFObGuE9wmmh5m9Jz8Rgl/C3
         4E/A==
X-Gm-Message-State: APjAAAWeabSLhXxlZQgr/JNZW7XqEDJQK7oL27eIppkryb8EK2/HSXY3
        JDt1baTwMx5ib57EL3LCaM4=
X-Google-Smtp-Source: APXvYqwBk0/89GsDfK82my30yqg+rZ4d0HpTNjLHV63mm71QYd3oGn4zl/iJH3eE5az4LZHjEt7ctw==
X-Received: by 2002:a63:eb18:: with SMTP id t24mr23495675pgh.214.1569842286345;
        Mon, 30 Sep 2019 04:18:06 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1951:51d2:46:3a23:6862:a9bf])
        by smtp.gmail.com with ESMTPSA id 192sm12838996pfb.110.2019.09.30.04.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 04:18:05 -0700 (PDT)
From:   Aliasgar Surti <aliasgar.surti500@gmail.com>
X-Google-Original-From: Aliasgar Surti
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Aliasgar Surti <aliasgar.surti500@gmail.com>
Subject: [PATCH] btrfs: removed unused return variable
Date:   Mon, 30 Sep 2019 16:47:45 +0530
Message-Id: <1569842265-32084-1-git-send-email-aliasgar.surti500@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Aliasgar Surti <aliasgar.surti500@gmail.com>

Removed unused return variable and replaced it with returning
the value directly

Signed-off-by: Aliasgar Surti <aliasgar.surti500@gmail.com>
---
 fs/btrfs/disk-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 044981c..c80fa67 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4255,7 +4255,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
-	int ret = 0;
 
 	delayed_refs = &trans->delayed_refs;
 
@@ -4263,7 +4262,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	if (atomic_read(&delayed_refs->num_entries) == 0) {
 		spin_unlock(&delayed_refs->lock);
 		btrfs_info(fs_info, "delayed_refs has NO entry");
-		return ret;
+		return 0;
 	}
 
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
@@ -4307,7 +4306,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 
 	spin_unlock(&delayed_refs->lock);
 
-	return ret;
+	return 0;
 }
 
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
-- 
2.7.4

