Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97642A9F13
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 22:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgKFV1v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 16:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgKFV1v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 16:27:51 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84983C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 13:27:50 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id h15so2442516qkl.13
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 13:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zaXp2T/BvYqdWHs3si0IpLy75LgadgOzkh2XlaoWbAQ=;
        b=jd8Y5lNzgTy/oEWV13wOJ6975TSUyeIsR6vli7La4JN5rsiFknzhBU5zCOmrrv5pFS
         i1h6eMESYs9Oym5u52wsLVGT+EwKEK4U9iHcOQls+T1ykoEnRlEZuRiW80JsOEcAUKqs
         zuFG855i8BJCiRMEmmD2cVA7TXtENG0SDleWsbWd5h04L8r45yJDEOHCY0FPkkTF8gEh
         FsNj5NLx2ekRZTs/5tZYvcllGpsxw+hyEbljGpmUrXCnrm0+WBYkV3zCaZ2q2GDFFK7f
         m1npkkmuMMG6I4cH6oxy6c4skcgQHiqu98qCkj4DLuIiOCkQ2kGFrfPNu7O5CAnkIspT
         BIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zaXp2T/BvYqdWHs3si0IpLy75LgadgOzkh2XlaoWbAQ=;
        b=H5TNuHByVXNoSHEcsAnOaa1/DSc9wf1LpYcrJHQT5UEwyg2OJQoq9VdcAr9MxPvMlG
         sAOkyKXBKtV3BccrniqCsEBQAcrMn8dOEEe00ASNxgcS3fRtzkUnt/v+nRLVlqs3lP5O
         7W0rwCn2cGFKXVi+FxvhxUvlfP36XNH/2ByFncEY8zA3up2moxp8JYM/wyqP62nplGkK
         Rjg/Cl8a7Ry1shK6uDcmS2wuaM1Y0e+l6IkKGj7uCrDHjLHdLhBvfIM81DQI/dPSYj6Z
         V3BJoprbOx9EqqFy+yeqRDG+HfWycSwdGhnlYSUnMye9k880UwyFXKHokMiGh1FBsilu
         Sv5A==
X-Gm-Message-State: AOAM531nYK1QFXo7/O47ThSCoa/hTrmijZOxN3434NtJb7j3maivzAs9
        hBYszbZhGh/888cGklPtl0GH5uNeyhImRfkP
X-Google-Smtp-Source: ABdhPJzAwHg1AbwsnjweOmvsm0wr8agTLd43hoYC2glJi8y03gdWMhbxp8WWw9BYgsA89UGqOUB4nA==
X-Received: by 2002:a37:a192:: with SMTP id k140mr3646003qke.32.1604698069544;
        Fri, 06 Nov 2020 13:27:49 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r18sm1359916qtp.89.2020.11.06.13.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:27:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/8] btrfs: use btrfs_tree_read_lock in btrfs_search_slot
Date:   Fri,  6 Nov 2020 16:27:34 -0500
Message-Id: <cce77fcffe84af208d0260120a874134b771ce65.1604697895.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604697895.git.josef@toxicpanda.com>
References: <cover.1604697895.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We no longer use recursion, so
__btrfs_tree_read_lock(BTRFS_NESTING_NORMAL) == btrfs_tree_read_lock.
Replace this call with the simple helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ef7389e6be3d..2cdfaf7298ab 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2857,8 +2857,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 				btrfs_tree_lock(b);
 				p->locks[level] = BTRFS_WRITE_LOCK;
 			} else {
-				__btrfs_tree_read_lock(b, BTRFS_NESTING_NORMAL,
-						       0);
+				btrfs_tree_read_lock(b);
 				p->locks[level] = BTRFS_READ_LOCK;
 			}
 			p->nodes[level] = b;
-- 
2.26.2

