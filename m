Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27464469F7
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhKEUsl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhKEUsj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:39 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB34C061205
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:45:59 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id a24so8056283qvb.5
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JaEXAFvl6LEWgaqIupynca0Pk9JLSpVgQ8bP1uf2aKc=;
        b=lTal3Ezt/sTN+kgqofWWQ7yjRPcLCZ0HumFEPk/s7xoTpu+BlXgX8zIKKEferpMooJ
         SQwS4mDDMEaK5nK+BfZxGp6zQuB0wta/fShrSFkwNtAuRtNNbemaRLPmTkAtQuWfBJ7n
         LYKpTN7y2rHcNsrcNRLufkRprdR3KLdypmjQ6UdLhnM3U4stimf/RwE9q9RsxYOAkM9D
         nxA0Rvw9ypmwhwTpHokye38Xwa0CmdXewXobOI8Dj5GnlX+QRzqW1u1oYrxbm7XIIgjX
         AfMOI6LO+bFlY/tGZmblBBtyPGfjOqrOw/6viZS/ZNverhFVcRAY+IR5gglqEwLNTiY9
         oTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JaEXAFvl6LEWgaqIupynca0Pk9JLSpVgQ8bP1uf2aKc=;
        b=RXB1nLn9sftS/FAopbIbEP6HHEP1xq73Tq8+X8Hwo3IWeUkbDHHs+UgTA+9jU7Egs2
         QMRwuxnHrZ4XpSpja964RDbWA4fAtcD8oZ7/Rd1z03F1QdRFyIss4FJLIAYNLQDLaMUu
         BSl9jyc2X/+5v6j4DlMs4+FMf+AttItgIiMA4QTujr2pgKdc6xlW3RipC7/zSkbMbqrv
         U//qsRYGLtK+XgK219ni5U36HKDVDeoElHLT5SZrnflF+0d+gw9UmYE1ZDFGsaQI6N63
         Kwz0jALKvMDL9NgjUMRtSAgVZwHpxYeTztou9MBg4kIPcX7mAPU2UjNIo8JPVf8fGQpF
         ameA==
X-Gm-Message-State: AOAM531maj1DnsY55sLkATpHiPG3qeTM/e1BEd0HydNn7VYyAKWYu/yZ
        wgseoentJwqis7eWkZqGalvg494pNFux4Q==
X-Google-Smtp-Source: ABdhPJzaz79lQO0MEDxiqE6lICdb/ivPz1NrZCD3AGneJroMSV59iltalEKskWpm2HI120PuzOkm2w==
X-Received: by 2002:a0c:f942:: with SMTP id i2mr1519813qvo.51.1636145158376;
        Fri, 05 Nov 2021 13:45:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q13sm6512214qtx.80.2021.11.05.13.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:45:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/25] btrfs: remove trans_handle->root
Date:   Fri,  5 Nov 2021 16:45:30 -0400
Message-Id: <e5f6231cb3c158b3325849d16eb25b6567ba7d1f.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nobody is using this anymore, remove it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 1 -
 fs/btrfs/transaction.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 4738ad1d826e..451788400e17 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -692,7 +692,6 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 
 	h->transid = cur_trans->transid;
 	h->transaction = cur_trans;
-	h->root = root;
 	refcount_set(&h->use_count, 1);
 	h->fs_info = root->fs_info;
 
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index e4b9b251a29e..1852ed9de7fd 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -135,7 +135,6 @@ struct btrfs_trans_handle {
 	bool removing_chunk;
 	bool reloc_reserved;
 	bool in_fsync;
-	struct btrfs_root *root;
 	struct btrfs_fs_info *fs_info;
 	struct list_head new_bgs;
 };
-- 
2.26.3

