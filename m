Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892F633983F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbhCLU0O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbhCLUZy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:54 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E73C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:54 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id f12so4835209qtq.4
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z+uodiFjP+HFgtUyY68U8zF2pVNFl8Wi2YW3O8bwUhg=;
        b=huWeh3KIBnIgq26rR/PgCsFbqIWxzCsVMFqRFnkCvdvuAocbmrFznhKkn9zl/LM7hp
         C6qR6MzFH8pnSEPoxGynMvepf1+4QX0lk2APTYO5U53SmFCXsRssPNeWTDPDb4T5R8F/
         BktsChBpqF0T55EiVTbsJIWObYhb5P3Q0ggRZ4T+NXfdGF1X0PhDZ4DvKsb648VdxGwf
         fBvThABVr0hfNzfaAwPBMKKKa+cLCoS5Jy9CJAtx/e69eUYaeO5PFrrJxecVQYxyT4Kl
         6dwQvMMEBT39s8P49A2w756VRZ+zm4MK1r9rAJ4N7alaLzeWgx1Qwqx4N6AM/pLgkxNh
         BtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+uodiFjP+HFgtUyY68U8zF2pVNFl8Wi2YW3O8bwUhg=;
        b=h30nMfUG3+f68eBdaQeE4KpTqiUKzgceYxqwN04CVb2d92STnhj3PIHKKp5Kt+R1AC
         vcYTOmcsMLYxsjceX4ciidBowYiHdEfZUAB+LzU9tc8OlhgX7QYOa7LaH4QaV6SPeUEi
         nSA6yTyVjRKycbtSufHL1ra2MH5/I41SuqvN7EILAH1N2GkI2O/wA6peWwP4zbifUmsM
         WaGLoxYwq/JSQ7iTAfX+AmqKV6s5FRMWRZMdWijKgshtVWkoAoOj+K4GRnAkZAf8wqWG
         PSN21cbtPetOS39mBs20ZMQVIcV3ilcAm7wRXHwqL4k159Aj02R+9mmJ9EpHBlMN7WU5
         PPRQ==
X-Gm-Message-State: AOAM533KQln7LkTA4HzFrxhUrHVWpJFVDdmWZFhb+MNMBOfXb4PU4qwY
        MO9vkHTh3K8p4B/H0YmpRW/tjC8yDYorrhEL
X-Google-Smtp-Source: ABdhPJwEn4sQOjf8ZRxuugKsiA8yHKI83iJi1SC5KPsVkycRhvodJheImfoEPPbzjRfyT5PjtBXqeQ==
X-Received: by 2002:ac8:51d6:: with SMTP id d22mr13430748qtn.355.1615580753211;
        Fri, 12 Mar 2021 12:25:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j6sm5306106qkm.81.2021.03.12.12.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 11/39] btrfs: handle btrfs_record_root_in_trans failure in create_subvol
Date:   Fri, 12 Mar 2021 15:25:06 -0500
Message-Id: <13787b7b2e23314817a592659364e9940b3e17d6.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in create_subvol.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e8d53fea4c61..29dbb1644935 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -721,7 +721,12 @@ static noinline int create_subvol(struct inode *dir,
 	/* Freeing will be done in btrfs_put_root() of new_root */
 	anon_dev = 0;
 
-	btrfs_record_root_in_trans(trans, new_root);
+	ret = btrfs_record_root_in_trans(trans, new_root);
+	if (ret) {
+		btrfs_put_root(new_root);
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_create_subvol_root(trans, new_root, root);
 	btrfs_put_root(new_root);
-- 
2.26.2

