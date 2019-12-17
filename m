Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0676C12308C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfLQPh0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:26 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46414 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfLQPh0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:26 -0500
Received: by mail-qk1-f195.google.com with SMTP id r14so8141506qke.13
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XZBfHw2CaSGcV4Kz3t+sRB/YUfVLcSB+/pO+8o4bxc0=;
        b=aJ8wrJCw1svlXBEhSNULiQfUuwkHyvo+7uK7RMgbo+HxZynYj6ULprhDaYKZPCIx8X
         R/L74ksJC1BY+3Qz1rkcTWqGfmzoiZ5PwKu8wTUOd+YSD8Mi/jnmY+rclfPZ1xR+sa7F
         CUWtY+e/jccj0JFhMgmcVdV6qOiEGfJ64o0vhSBLw92/SInQj14067np1CPBdkpe2+sy
         AR3JjIPdziiXwBbvjpv9WDVcMIHhnam6wxZMwRsuxckhpqboddTuhD0ljnrvJJo7uPhd
         LaO/yJtRmIMHNsOCrgs5xUgMp3fACzY55mE0lcumJEDmuMvWFIRvbss2T4gz5dfrgyZk
         H/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZBfHw2CaSGcV4Kz3t+sRB/YUfVLcSB+/pO+8o4bxc0=;
        b=KUQppuWtrIyDbYdB4OHVmTmyTs08uAUIVqdL7/FhO7oiyG1kDmtzNZ6uhL1mgrI17i
         Vz5kqUb3a5QryKorleDlRrWmK+qA6oHwtIshwDv2lWZm9HFr5TPSVpJbva7IiKWvdE1p
         teY3wsFal8HdjYTciuJBvfIcgZrjKk3Yqo4SacFDQIn2jz2QXEnOrYVqqi8sn4xj6rgx
         Dq4CBGJr5BViGaTdr73KgjH8/0+XyZQM+M+VUlwVGbBva6/Aoa47rkoHIgQJP7cu43CN
         hXyrYeTRsiedOgiWVrRzHrqLZn4MPJq/gTO53vOgpyGTz2R4eeKtKVpHrTCbtbuw74CW
         wvIA==
X-Gm-Message-State: APjAAAVoOEKR4YcrmTI/6rBkvp8Q2iP46Hmdgl66h1WEnyKyOiOnADyG
        SrlqxArODcCY8okkoh0PSQmlD93od8Ifew==
X-Google-Smtp-Source: APXvYqyZHWPO/Lmqiy2pqOTrAsK0yuHeK9AF3Vm5jLsFf3lnp33BvjGF0gU+PeVq7J+J2K/43C+JNw==
X-Received: by 2002:a37:9fc9:: with SMTP id i192mr5377090qke.364.1576597045292;
        Tue, 17 Dec 2019 07:37:25 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q30sm8171344qtd.5.2019.12.17.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 26/45] btrfs: hold a ref on the root in record_reloc_root_in_trans
Date:   Tue, 17 Dec 2019 10:36:16 -0500
Message-Id: <20191217153635.44733-27-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are recording this root in the transaction, so we need to hold a ref
on it until we do that.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index dfd3d9053301..c3cf582f943f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2563,15 +2563,20 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = reloc_root->fs_info;
 	struct btrfs_root *root;
+	int ret;
 
 	if (reloc_root->last_trans == trans->transid)
 		return 0;
 
 	root = read_fs_root(fs_info, reloc_root->root_key.offset);
+	if (!btrfs_grab_fs_root(root))
+		BUG();
 	BUG_ON(IS_ERR(root));
 	BUG_ON(root->reloc_root != reloc_root);
+	ret = btrfs_record_root_in_trans(trans, root);
+	btrfs_put_fs_root(root);
 
-	return btrfs_record_root_in_trans(trans, root);
+	return ret;
 }
 
 static noinline_for_stack
-- 
2.23.0

