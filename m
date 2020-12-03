Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E312CDD85
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502056AbgLCSZU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502048AbgLCSZR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:17 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735D5C09424F
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:56 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d9so3002398qke.8
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vsrfk6ueoE77Saz+ki+XrNDk2dErjLeVhhzz9vbaZ34=;
        b=TBUgdK2MnkJ5db2K/n1+davJE3vHF4AyBaYAJXGJq2cfQ+0D36iAUjUjcmE23mSuET
         z4WFDvpcMHOllFBV+HGT2rCt8bxMP2RO3iAR/hI5zZ/hWIJYCO9NXYYyHhaWGgkbBVGE
         wDSftIQrCg81kGYWjQF8jxSVMQh5ha5w20V2+k3iZ4NTp7qSS+SRnlWurbFpyGmDgHW3
         YdHL0GnH/WO1Zvd9DrJu1ATirVvr+pPWJyQx5Sl6xn0JQekFJMt43pwQQYbnldk6LjSe
         gCUI/rTlp8hO6wdHsnCHum52g1cD22a348Bgs4UcHOd0xF3zMyp9VhOTIoSVeCoM6fsf
         BySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vsrfk6ueoE77Saz+ki+XrNDk2dErjLeVhhzz9vbaZ34=;
        b=rXXyz34rq4DvZfC9PRZgkJoI2/AnG4ZwkKB/KYl1yjQly3S8D+W/Cs3yo0EXuxBX5z
         birLPhKg/Nabv9F8y/l0dz9uf5FOiXizWXmu9u0SysqU0kq5YgQ9MR9q0ndQTADvLhx3
         okV5NytygLoucJobL5iHO5vhN1hzD4eW0JTJH9pttdgdq9AbpbGOJSNmgTLUCu/M4/yq
         ivQ4XUc4sQ9ENUAFfLVOjfPPTU3F63qfLx/zCrgHBkjdH/LODL1UMgPOc+P5jKgkZ02p
         VUPoulFS1FujPc1z7yJ9AXwiirCxKgTuQ2neqkSC1V+E7ac1tkJ9LrtVPiKNx5RzM4TD
         O8UQ==
X-Gm-Message-State: AOAM532l+6O9jC9x3U0epsLgWpHeFAPHMGQ2EzKycmRFHU/Yfj+Czk/q
        GwRAv1WSU9n1MutMd6aQv6Y0Pd19aqYo3TR+
X-Google-Smtp-Source: ABdhPJx7rECroY7Uc2Nh9zmVyPHQ6ftOHu23i3XM3vPti2q3cq/RiVcFysLqk6eTKH+uVOeIrbH+vQ==
X-Received: by 2002:a37:aad2:: with SMTP id t201mr4084190qke.61.1607019835357;
        Thu, 03 Dec 2020 10:23:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o23sm2212859qkk.84.2020.12.03.10.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH v4 31/53] btrfs: validate ->reloc_root after recording root in trans
Date:   Thu,  3 Dec 2020 13:22:37 -0500
Message-Id: <5e855332210cd2114c1ee798a0f3a3f2a7a43bb7.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to setup a ->reloc_root in a different thread that path will
error out, however it still leaves root->reloc_root NULL but would still
appear set up in the transaction.  Subsequent calls to
btrfs_record_root_in_transaction would succeed without attempting to
create the reloc root, as the transid has already been update.  Handle
this case by making sure we have a root->reloc_root set after a
btrfs_record_root_in_transaction call so we don't end up deref'ing a
NULL pointer.

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 627c1bcfdd33..5770f4212772 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2073,6 +2073,13 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 			return ERR_PTR(ret);
 		root = root->reloc_root;
 
+		/*
+		 * We could have raced with another thread which failed, so
+		 * ->reloc_root may not be set, return -ENOENT in this case.
+		 */
+		if (!root)
+			return ERR_PTR(-ENOENT);
+
 		if (next->new_bytenr != root->node->start) {
 			/*
 			 * We just created the reloc root, so we shouldn't have
@@ -2572,6 +2579,14 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 			ret = btrfs_record_root_in_trans(trans, root);
 			if (ret)
 				goto out;
+			/*
+			 * Another thread could have failed, need to check if we
+			 * have ->reloc_root actually set.
+			 */
+			if (!root->reloc_root) {
+				ret = -ENOENT;
+				goto out;
+			}
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
 			btrfs_put_root(node->root);
-- 
2.26.2

