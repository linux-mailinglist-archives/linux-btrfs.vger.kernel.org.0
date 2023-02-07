Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BE068DE5A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 17:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjBGQ5l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 11:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjBGQ5j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 11:57:39 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0514F3BDB5
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 08:57:38 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id h24so17408958qta.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Feb 2023 08:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2YbcoN8YV/XQsKA7gpTxKVkd9miB4Uv7B6yf7bvslg=;
        b=BWce36AqfV65NuV3ORa7O4yxM2zJmxjUY2Xas8zlVpDWYeiqa8e2GVm66Xl+qdHY62
         wp10j9+9PPn1UKa9xxyncijqOd8Zyg6ERMtO90Q69NLsbCzGzZyfH1eaXnFQ10SdRRYH
         F5yVFoCgYQ0RIxxoefjiXL3LqbmoHBoVRx2+IWSTuEgtLuLetJMkxas7gKkhB9Gqogyp
         QRFSJd/VnPf2EodRRAbO7ScmRofu3Q9f53cFQNvowgL5Yn4dq3UQ8mhhgiPL6PTzzauq
         CIuZcXy7Q1vE/VC5re7WWbrmc8ARyvxqR8je3Oq2s6QtdALpZv6zy8eJiBE+vtQ/78+f
         UfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2YbcoN8YV/XQsKA7gpTxKVkd9miB4Uv7B6yf7bvslg=;
        b=LKMZ8P9/Gy/UJHnFsa47kfXmSLdp/c4wG/wU0bcNq8Vkl8U+S6aC4BDig+N0its4u3
         weDal0eLhg2XoE4qyP23phPQTaj/0VN1DF7wK5So96JmCQ59H1TPgN2JpE63UotaMBmw
         TyGdCnCZGw5HE+Cu794oiGf0LYDrvPP0msLajoEy4Aa4QWKfnAFEJ95pryM//gGWuFPu
         7yk36iYM1QGosMHyPgvISRoEzjzcItprmKjPlukyVR+B8f6xnRqLO9levWwP+KwiYe5I
         vt6PcGUZ9/jBJAOLUx+nZavynD2J/Gzty4MyoOBtNEP2Fvcz8cKSaviGp3rz6o21no5o
         z1vA==
X-Gm-Message-State: AO0yUKUH1I8URbxzWL7BwEmRxLy0O4rOtX+PviH7lyy8f4r4oOv5Yd1/
        H7QZbfAobSaVseyPIq2Pt4xyQEGIIdE8heTF6dQ=
X-Google-Smtp-Source: AK7set/XXMEDVPR3RYJ2qKo2o12tacUjyfFwFHLq6QxZslP0V3+2Zk0NSzXTH5Obc0Mc18Kt67gO2g==
X-Received: by 2002:a05:622a:1653:b0:3b8:2a6c:d1e3 with SMTP id y19-20020a05622a165300b003b82a6cd1e3mr5871647qtj.21.1675789057664;
        Tue, 07 Feb 2023 08:57:37 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id j24-20020a37ef18000000b0072396cb73cdsm9735874qkk.13.2023.02.07.08.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:57:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/7] btrfs: abort the transaction if we get an error during snapshot drop
Date:   Tue,  7 Feb 2023 11:57:25 -0500
Message-Id: <d49225b2cecf18d557ec347361373a2dbc2f81c4.1675787102.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1675787102.git.josef@toxicpanda.com>
References: <cover.1675787102.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were seeing weird errors when we were testing our btrfs backports
before we had the incorrect level check fix.  These errors appeared to
be improper error handling, but error injection testing uncovered that
the errors were a result of corruption that occurred from improper error
handling during snapshot delete.

With snapshot delete if we encounter any errors during walk_down or
walk_up we'll simply return an error, we won't abort the transaction.
This is problematic because we will be dropping references for nodes and
leaves along the way, and if we fail in the middle we will leave the
file system corrupt because we don't know where we left off in the drop.

Fix this by making sure we abort if we hit any errors during the walk
down or walk up operations, as we have no idea what operations could
have been left half done at this point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 30720ea94a82..6b6c59e6805c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5708,12 +5708,14 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 
 		ret = walk_down_tree(trans, root, path, wc);
 		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
 			err = ret;
 			break;
 		}
 
 		ret = walk_up_tree(trans, root, path, wc, BTRFS_MAX_LEVEL);
 		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
 			err = ret;
 			break;
 		}
-- 
2.26.3

