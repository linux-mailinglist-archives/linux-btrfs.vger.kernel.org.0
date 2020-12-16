Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A5D2DC43C
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgLPQ2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgLPQ2s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:48 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85B4C0619DE
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:56 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id y15so17587181qtv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TGT1uQEPkXlGSsuy+GeVOlQWvLE7GDlWh9fH5azgYjI=;
        b=ERkp9UYBxT0EmqE+N8zUrmlqwStrJC0ru8WcONwyYuVC5Xvah9u8wBeeYCME9vuMcj
         630o31BDHT4vyoj1gjDj+hl68DujTA+3Ye2YCd3iYZMa9qy0p3YkrpHSx8+Tk5D33L12
         7zF1FOd5NRvb3RgFvucSGo0Q2O5UedhBF94jtjOjA9MgSBdagPIDEUFsSBE48dQeYFZk
         VVJGuX5268CSVhsAj7HomkuMRdAc6i/I+uonaHNrspJrriaeINgIjFs700tPsAcF1hJQ
         Hr6KE39CfsIEH4e1FXPvU+nHq2oR9wnOaW/AhPsR8AwV0+NhFsulSCWuMQ40hDq5IGX8
         zA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TGT1uQEPkXlGSsuy+GeVOlQWvLE7GDlWh9fH5azgYjI=;
        b=AFhNhnFBcscv3XaFEx/X6RUl8MAB6Dj9xrmRGbE2oJUGQv00gTrSciZ223tmp7JYiS
         8nuLgwjhKdfBTOXASXk72jxLv9aI/xP7mmpvN1Vq3EoGAsgiQu4Qnni81uaQmdG16Cbf
         eeZlMXUibVKkra3LBZOfMMQFL+YBtFPLsc0EUMuvcIFCxxj8eA1XII1/dOUCBQbNGYNC
         DYJJRMWCTfG9zsbexOiGpVK0rRVo5adgUQA5vxn2qFOq8H641j7Qqq5v3a2u8Cktptvf
         igvnEdgl+W5hMH3pZmDuWCXP+EfCzUSL1iPlWDs1iql9RF9e7BI9KDfEoaaB8KiQx8Mp
         QVPg==
X-Gm-Message-State: AOAM5335ZIeZ8cj1YxVYKjaFHEtAUXuJ9qPTi9GUZXPKJvdKm0I4Z3l6
        tmjMcOoq9TXooqxSqHUCHTqrUUxuHyYeavfj
X-Google-Smtp-Source: ABdhPJwKlD+EjT/7vjWbvo/Me09NMJ72DbNWfDFujGgIQrNef8B4VBrD5P2HxsJeZgkeShqyVDI0Qg==
X-Received: by 2002:aed:3b13:: with SMTP id p19mr116198qte.302.1608136075749;
        Wed, 16 Dec 2020 08:27:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x17sm109237qts.59.2020.12.16.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 34/38] btrfs: handle __add_reloc_root failures in btrfs_recover_relocation
Date:   Wed, 16 Dec 2020 11:26:50 -0500
Message-Id: <2cbb558f593e693a176d489d6e3c4d704718a347.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already handle errors appropriately from this function, deal with
an error coming from __add_reloc_root appropriately.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 26b85ab4b295..39d5cb9360a2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4015,7 +4015,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		}
 
 		err = __add_reloc_root(reloc_root);
-		BUG_ON(err < 0); /* -ENOMEM or logic error */
+		if (err) {
+			list_add_tail(&reloc_root->root_list, &reloc_roots);
+			btrfs_put_root(fs_root);
+			btrfs_end_transaction(trans);
+			goto out_unset;
+		}
 		fs_root->reloc_root = btrfs_grab_root(reloc_root);
 		btrfs_put_root(fs_root);
 	}
@@ -4230,7 +4235,10 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
-	BUG_ON(ret < 0);
+	if (ret) {
+		btrfs_put_root(reloc_root);
+		return ret;
+	}
 	new_root->reloc_root = btrfs_grab_root(reloc_root);
 
 	if (rc->create_reloc_tree)
-- 
2.26.2

