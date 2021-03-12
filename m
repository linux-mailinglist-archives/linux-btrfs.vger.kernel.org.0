Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29753339850
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhCLU0l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbhCLU0P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:15 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB824C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:14 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id m186so9070264qke.12
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+taWR5KRsj940Ij5EIrNKIZZtVKjNmXibQ0JT3vmUkQ=;
        b=Syn4LcZRve/EtUjo9jods65IXC1UTChd4s+W5A/8y5qocpmVLtGl7mWpxMSBUr0H9z
         f9gDJyfawkCqs/KjMj3C7HMFDL6WNn/0ZsTe+M2H3ED40DPZjxtGKmTfH0CLjYiW5AxS
         aZ29FZhAIscua4qFOu2avovu+rgPNjMGptBrmUyCwR+4h1QCEBB4UHVKYVLiu0yDmTes
         kg7myTxLbXZC5py+/S05MGTzkpv6UXDJqcbvaCZRBzHyW4C1cbc2MkHQceZjR58izu18
         d8Qb3Un4UaCaNX6Zq1YmBJxw9rUkXDuc2ElG/YBo9VOms9HyWzCfKbkDG1LfbWHfY/DG
         6hPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+taWR5KRsj940Ij5EIrNKIZZtVKjNmXibQ0JT3vmUkQ=;
        b=i5IX5Kz5vxYkxwJVS5jptSVetd8eRqqMxbu2IZaSSYHkUsejbQ4JyM4MfxHa5iJyie
         uiMznFw1GgdTbHvFtOswOMht4edeJHhI4DGdqUeyGn4BfOwgQ034zS68n5sZxIN7QLxq
         5VGr3rtPFjwo1FA2Hb1JHMX/f4EY+JJ933w//WEhBmOIJpLaNZuWxpWp81IevsOu00NV
         38+CxJxMOKYk2Tf0YUWC1PdQIeICQVdclUSk4oZbpHT/iicnj2dZT++tajZohchn1yac
         ja9vmT7Ef/k1I+fEqrDdu5d9mh8dUCx8OeQd5umMaVEj1ImALZYxxbFV+EkovvNqLNB4
         9pnA==
X-Gm-Message-State: AOAM531k+wwCN+Q7QwKexaeqO9T41xyQURbioSXvcBiMufCRMtZvow6d
        lchsGftJyA9C8+nu568Dcorgj8aVGFoEr7A4
X-Google-Smtp-Source: ABdhPJxAh6UcV5567r7Od+HBrB1toH7OgvBwHFeHBpbR+wF29Ey2/qmm1BvkLP+vX2ugsPgLvSCcLQ==
X-Received: by 2002:a37:630a:: with SMTP id x10mr14191153qkb.326.1615580773824;
        Fri, 12 Mar 2021 12:26:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o21sm4593300qtp.72.2021.03.12.12.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 24/39] btrfs: handle btrfs_update_reloc_root failure in prepare_to_merge
Date:   Fri, 12 Mar 2021 15:25:19 -0500
Message-Id: <5e1a5fbd0668822fdb5c6bf3ae1ee473d8e5af77.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
an error properly in prepare_to_merge.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e6f9304d6a29..b9cc99d4b950 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1868,10 +1868,21 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		 */
 		if (!err)
 			btrfs_set_root_refs(&reloc_root->root_item, 1);
-		btrfs_update_reloc_root(trans, root);
+		ret = btrfs_update_reloc_root(trans, root);
 
+		/*
+		 * Even if we have an error we need this reloc root back on our
+		 * list so we can clean up properly.
+		 */
 		list_add(&reloc_root->root_list, &reloc_roots);
 		btrfs_put_root(root);
+
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			if (!err)
+				err = ret;
+			break;
+		}
 	}
 
 	list_splice(&reloc_roots, &rc->reloc_roots);
-- 
2.26.2

