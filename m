Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C85C17632B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 19:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgCBSsF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 13:48:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39329 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgCBSsF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 13:48:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id e13so772365qts.6
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 10:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2zOJM+viYJgQ6kMNmJf1M6apIcP4tzIY1cifg00waDM=;
        b=odSIYsB6L/GuBFxeLScube/BzkWRQpSEABzjBU8VJ+wo4Fu4vPtI3OodzNN4okdKPN
         qF9SSyO1G/awb7fz+fB6kS83nx+GWrEsAhh4HKekY5joau29q0ikgpAOt1izryxTlMdv
         ZKvWU1zGcELjY5Ex2GQ6c4CFmG3HVvWvDf2e7Wp6EF/JnUSwnoPM31zRyc9AqClRRNB2
         cy1Pyvos2rpS9UTWqUSrK5/lkGan0gZCclp/uJSAWv9VXI8tJMJN6RXZhkK2LrBkWNpO
         4wzT/treKXhIh/mIUGRSsI3fFLMGCyhwB9G+EitDWepz1Je5j32fin2HG8cQZozkhJ0a
         XhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2zOJM+viYJgQ6kMNmJf1M6apIcP4tzIY1cifg00waDM=;
        b=Y9Pzfbi4q7jPVrOcvfhteh3bp0VKB5h7zvGe4YvooLoZed+2nwCxpP4Hq0h6REOglQ
         PRh+pqhHw5gly2s1uAwj+qPsOkf0l4aSkocft2IflmsL4Sv6Jx2Xy3IdZI2y4qDLf43W
         75TjjvuFQBMgEPGkTLgCQ4df//zRFiVQ7xwx5mvkulfU5KNjD2zm/JyMbP09A73K+zXM
         loFsfOg5siSVKttlT+UNUFdpMKOygjh5p7pF1AxVlEq0O738kuKhLgP1LnDOtYw3UbVZ
         TWKobHJMECIjxJEozH7SN9V0JJDl/TeJDziZ3sCiVBTRMMpbFx7xnJss+GHti/lbY285
         gAUg==
X-Gm-Message-State: ANhLgQ2rvv9Ny11NDlyKYx/wV9uurk82eLycsd45+BOAgmbLdpzNT0YE
        mltVrQX18mgltoq8x35pY063m2mD2XI=
X-Google-Smtp-Source: ADFU+vsrazRRlVkOwEyFrdTOB0mwU1asrqkyupKZNfa19Tx+VfpzGF4AchH5n0QDcaNINUjyJ2TcEg==
X-Received: by 2002:ac8:5047:: with SMTP id h7mr1073618qtm.72.1583174883715;
        Mon, 02 Mar 2020 10:48:03 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w9sm10680620qka.71.2020.03.02.10.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:48:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: unset reloc control if we fail to recover
Date:   Mon,  2 Mar 2020 13:47:52 -0500
Message-Id: <20200302184757.44176-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302184757.44176-1-josef@toxicpanda.com>
References: <20200302184757.44176-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to load an fs root, or fail to start a transaction we can
bail without unsetting the reloc control, which leads to problems later
when we free the reloc control but still have it attached to the file
system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 507361e99316..173fc7628235 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4678,6 +4678,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		fs_root = read_fs_root(fs_info, reloc_root->root_key.offset);
 		if (IS_ERR(fs_root)) {
 			err = PTR_ERR(fs_root);
+			unset_reloc_control(rc);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			goto out_free;
 		}
@@ -4689,8 +4690,10 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	}
 
 	err = btrfs_commit_transaction(trans);
-	if (err)
+	if (err) {
+		unset_reloc_control(rc);
 		goto out_free;
+	}
 
 	merge_reloc_roots(rc);
 
-- 
2.24.1

