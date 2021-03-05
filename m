Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB65E32E520
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 10:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhCEJoa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 04:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCEJoA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Mar 2021 04:44:00 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B193FC061574;
        Fri,  5 Mar 2021 01:44:00 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t26so994208pgv.3;
        Fri, 05 Mar 2021 01:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=myXEvGngLyw0rSdRs2pyTmkG4KiSVGWXGtBSKeFf77c=;
        b=a9Qy1lShvEdwL5fcKgoBZqEuhU2arR/7RHUuKxhdo03LhyhGS0L2fdKGtaUKZ01JS+
         yeKeJEATMH6hostfjhH4Ux0L+DCNR1phOR/gHsbgOpMnCDd8tOb9Tt1qS0SIhML/BJSE
         c8xHateOqYF6OafcfiXBAEAY0sfLTSqLTDL0T87t9+GjNAR4Z8cxI/nIWE3Itpz4IUN1
         zQx1cGAFbQ4yeEAKMOMn654l0xRCNbbDh2Az+mqRRdTLC6ezgxlzoCfCs5MJuAO95A1f
         2LeWVChHCPgpqp2jS4GZDs9ttME/RXp7NtBAocWhOpZ99YQ848xHjc/CrdRZj5aT+1CS
         xVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=myXEvGngLyw0rSdRs2pyTmkG4KiSVGWXGtBSKeFf77c=;
        b=FmnThHtT3NJunx7bW9foyL+Af1K3R+pcnog1ohQf/VDM6OKDUsABcL7wICGtT3nx86
         Rr92FtI7ne8IB2rcNogwfAyDMly7a1ptID2UoR/+DgMtdYDUIJ/84Hd95w0aUBTBMjp+
         C7wqtMuqMEtMsn3VePI2k1gs015oiJQxGjcXPlqI33wenvgGkHQ/m1gv0M3Nhpkjkp9n
         1g4mLclPjvZElXCdViXKge5HE1rc9UvFTaeN1XRX0TwFSVBjltKCYlOMLsCqZ0I/eC5n
         ySh0NDvxG9kvKW3jdVaUx5CuDyjBAveSGfnfApuaN4kL9RIHiu6qpMEghmFi4dxzIOfj
         7dFA==
X-Gm-Message-State: AOAM530s9cylKbunM9tUwDTB2+qtUunsYywV/SeXZO9nTys78bbRVBb2
        sObhVxjezrVS8dEOtHo/jRY=
X-Google-Smtp-Source: ABdhPJxz+yPDlpH57O3Ran5esvJ+eTUaChtMck3XKfhtcBnU/Ks7MYYQD0daprqkotGMlQBubo9T4w==
X-Received: by 2002:aa7:9342:0:b029:1ee:8893:8554 with SMTP id 2-20020aa793420000b02901ee88938554mr8357111pfn.2.1614937440360;
        Fri, 05 Mar 2021 01:44:00 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id c193sm2136793pfc.180.2021.03.05.01.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:43:59 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: btrfs: fix error return code of btrfs_recover_relocation()
Date:   Fri,  5 Mar 2021 01:43:53 -0800
Message-Id: <20210305094353.13511-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When the list of reloc_roots is empty, no error return code of
btrfs_recover_relocation() is assigned.
To fix this bug, err is assigned with -ENOENT as error return code.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 232d5da7b7be..631b672a852f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3817,8 +3817,10 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	}
 	btrfs_release_path(path);
 
-	if (list_empty(&reloc_roots))
+	if (list_empty(&reloc_roots)) {
+		err = -ENOENT;
 		goto out;
+	}
 
 	rc = alloc_reloc_control(fs_info);
 	if (!rc) {
-- 
2.17.1

