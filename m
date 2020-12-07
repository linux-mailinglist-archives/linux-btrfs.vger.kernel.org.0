Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739D92D12E4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgLGOAC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgLGOAB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:01 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D758C094257
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:12 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y18so12465216qki.11
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhGtkRnXplYY+CEDULNniNTVseakGw1lct8t29E1QDA=;
        b=SfTFrwz+CEXQTaJn5t6SDoVng5zWHpGyYU1Zn7/22wmRJY8meubEmelqOBOj90qCwv
         IJqrcft3W0DjIzZJPg9chm9RNCTgxmHN8Xm4jZ4GwyZfWoKiulWYib/JTLPng1h2XmD2
         17A+ueMK3WgdeAOvugXN7OhAVOGd/iKqjsFg76L0hUOC2KDEicq3KtusYXkPIcm9hbZa
         S/Yvq+rmHzwBUoaHTvKnqmcgvA9wBF6NiZHePUaw4n0lWXZaDTitkAdNCdhuDymRWUWc
         iEatg84ykm0bsAAbEwhA4um3/f0qjYeWtdmMs7n2XvRRhJUgN6n+7GLYliO3IqQPWiMZ
         dMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhGtkRnXplYY+CEDULNniNTVseakGw1lct8t29E1QDA=;
        b=KCxcw3wC9VUItlGn10RpEt382cyKQLuV0m9fyW7Zs3Rv1JNkaS7KNVy9rF0NbzdAVD
         kPPFDEFzGaGkmBOuqHDc/g8lJiXYtdY1RKs9F9uj0i5ERC8YyZs12kBRwooMWNmQIt9h
         4v6AiFpTM5q/XkRshZN08V6zXEookxTqfOicx0ory10rvSwn/Ei6qc2+gwzM6zy16aAc
         q2dztODQgaRe1pjxPm+2B0Sw5OxTMKS2+0vcrlErXl7hNcqDMPECVpRs+fcrGB2EIAU5
         F27ZRwneqpejK25Th4E2GSfpRuUFrmW+82pdJh9JTiu8656aa7+xQQawShRSoXoJ5Iub
         RyLg==
X-Gm-Message-State: AOAM532FiueeUk73ofwkki2Iph16CcG8Oz1Chl9fLHvvkLAWk+zY55/H
        pD3SZr/GtH+4JbRxZPtwiLfvs9LyAl22oMya
X-Google-Smtp-Source: ABdhPJwmwdfzh3zO8H5X0lEAgSOdpsUPwMqMRsuSfhWD7wIFhw9ua8NfRw1UkdazaY0a6aMeQ/MQPg==
X-Received: by 2002:a37:6f07:: with SMTP id k7mr24321870qkc.476.1607349551461;
        Mon, 07 Dec 2020 05:59:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c128sm11115078qkg.66.2020.12.07.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 44/52] btrfs: handle __add_reloc_root failures in btrfs_recover_relocation
Date:   Mon,  7 Dec 2020 08:57:36 -0500
Message-Id: <8fb932433b26fdd1dcff6c536eff225341ba662f.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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
index 05b42a559da3..a2900dc71c72 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4007,7 +4007,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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
@@ -4222,7 +4227,10 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
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

