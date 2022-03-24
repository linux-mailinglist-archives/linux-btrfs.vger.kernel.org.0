Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BC34E6448
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 14:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345548AbiCXNqj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 09:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbiCXNqj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 09:46:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DE728D;
        Thu, 24 Mar 2022 06:45:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso2596645wmz.4;
        Thu, 24 Mar 2022 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=oZ1sQ/s8ZI7VgUG5Kyss6T5kos76Vzc3N9Tcf43ykvg=;
        b=G1JkArYGVVqnvhMr0qayvYA2Sda9lv02t5+m+9n88gcrFN9uhb2xuY0llB1i+61IvZ
         4hij9LmZumxp4RR95ieNjVtHKomSK73vmTrY/r1JhH461/XofR0XGM2Ug4IGwh1hYlUI
         D7ENMuCJN9Fg1PCefQIR1sMxdlu2FcrMva5KyQbeXUjjfKhhABTfFsc0VtYCNtiON0Rt
         CtHneiW4E1O1ixBk7/Qwm+5pyqISgt4/9k2fDIgF3f3SKRgnuevdXSwA2XgWpzw3bWGv
         1/DBHI6kd3VTGsuKTbr53WaThAavZs52kv5+YtURwo1MA3CoUmIo4S341dKjmvL7+Cb4
         XpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oZ1sQ/s8ZI7VgUG5Kyss6T5kos76Vzc3N9Tcf43ykvg=;
        b=5fm8KhmeRSio7sa7QgSXuWIoDFeffrjYNii49MubaLCcLVJF9Si4LuYSac33/eEwZ8
         SvaR0jPCUmtNWfEnlo5KCDNbqByceyiPlHj0mKrrpRQghcphBNT5GIcCSNsbgbw5iW+I
         5NTAGqvrHVgdZecky4kYaQxPqhPI6suM7HOXLFOB5v1ZHCWIPvMHdV/heYTIgX3fjMjX
         M4J0p0TL9IaguLTOC92nfmAtXdv58Mty9Epl8PFPd+0mYG/DVUnVj9NyMz8smd11sMv4
         QEfEXnRPzbhcWnIxf3SPCjUnN5/rYQniMVp5qeib3piD5zgTdHHtFhx4BvwruFWFleAy
         aN4g==
X-Gm-Message-State: AOAM530puyARNQNna3LTmkSX2DTvzoKx/U42pdQJDntOnOtbwncULqmN
        hkex2ctSMJNJoG/PeRLCfr0gd21FmCo=
X-Google-Smtp-Source: ABdhPJzbRhiMs7w2yHcB9tUaqUaDFJA0Sma/O8lYUcRw7b1jV70ocMyqdUL5ilw2TzSeD4D/v0r+7g==
X-Received: by 2002:a05:600c:1d11:b0:38c:97f4:197b with SMTP id l17-20020a05600c1d1100b0038c97f4197bmr14576154wms.88.1648129505617;
        Thu, 24 Mar 2022 06:45:05 -0700 (PDT)
Received: from localhost.localdomain ([64.64.123.65])
        by smtp.gmail.com with ESMTPSA id bg18-20020a05600c3c9200b0037c2ef07493sm2620590wmb.3.2022.03.24.06.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 06:45:05 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: btrfs: fix possible use-after-free bug in error handling code of btrfs_get_root_ref()
Date:   Thu, 24 Mar 2022 06:44:54 -0700
Message-Id: <20220324134454.15192-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_get_root_ref(), when btrfs_insert_fs_root() fails,
btrfs_put_root() will be called to possibly free the memory area of
the variable root. However, this variable is then used again in error
handling code after "goto fail", when ret is not -EEXIST.

To fix this possible bug, btrfs_put_root() is only called when ret is 
-EEXIST for "goto again".

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/btrfs/disk-io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b30309f187cf..126f244cdf88 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1850,9 +1850,10 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 
 	ret = btrfs_insert_fs_root(fs_info, root);
 	if (ret) {
-		btrfs_put_root(root);
-		if (ret == -EEXIST)
+		if (ret == -EEXIST) {
+			btrfs_put_root(root);
 			goto again;
+		}
 		goto fail;
 	}
 	return root;
-- 
2.17.1

