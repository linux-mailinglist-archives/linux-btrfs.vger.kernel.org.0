Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481BF34BAB3
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 06:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhC1EWI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 00:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhC1EVw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 00:21:52 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13A8C061762;
        Sat, 27 Mar 2021 21:21:51 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id g8so4954330qvx.1;
        Sat, 27 Mar 2021 21:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1e4VJeVKAVhE4koPT+f5cd0jDW7p7wnLkhIRpNftUHY=;
        b=nqcxrhuv6shYvG6lYmvxSy/sM943Joxgcwu27qX2Jtm6wLK/EMzD9lpW1pTmCrbGoe
         Ed1LOIoNQ6Hna2+dzEJkiTG2GcvT0Kx+xKT4jYxePeSTaG/PMKxfjQ+wfK5UO6+83/MF
         e6ZJT7AgAddNpjpnQmCJe4EPDkeaV/8itsoHTRLCB3aDNYwiWjQ8GDX/qi6rZZXpv8JF
         zKy3gCUThmYGVHyk5i6DZhlDkJjlzKmjQ+JAZ33RswfFhynJC91ZXB5X81+KbZBVm5PD
         NSGcAqrAxuFkW30hsfiN+F3WgvFuMHaVMhDlYNuUPz058YQfbCpQuZHFaE9sYiEWJEqS
         M5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1e4VJeVKAVhE4koPT+f5cd0jDW7p7wnLkhIRpNftUHY=;
        b=moCAWStlvxpos7og0m9YEeu6yybmjAjw2YJiItaZCPXZMIHazFr2FJV1vs8tvAnAXP
         Sumj3T46YwFCiP0z/7M5rTmi4AC6NSRRF+DENgX3TorF48EOWYg+FRY7EQYBTV4C0PBu
         YobsgNW52da3c0E3D/Q/UoxvC2Ow43QB28A4JWPvhqLsVPBqlUrDGUULDmPQXIbc1bbz
         xaVHB1mlAlyi+2ZbKNvTvMmb+YE4tsxFB9yEHEupQYOGr6Ksn72x+Qe75phq3/rNBtQw
         BTQFtAxvz+5tcabDCdLajiIL5S9Hd79+1rdXr+I85x+KzXsNrt8qrmeb9f/qnUxXSg2E
         Q/CQ==
X-Gm-Message-State: AOAM533TRMlGkQAb4Y331V4ULFRyDBs21o9kLU2cLS61oWKqEMTX9GgR
        hYP/Dn4zD7vQuDcnmr19iB4=
X-Google-Smtp-Source: ABdhPJzYogca2xZYlfUyvmf9KdgCz8SswivgNNt4/M9Px7cNotJBEP4ypBsvBaOovTT4fbtnId8tDg==
X-Received: by 2002:ad4:470c:: with SMTP id k12mr20217517qvz.9.1616905311153;
        Sat, 27 Mar 2021 21:21:51 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.118])
        by smtp.gmail.com with ESMTPSA id i6sm10092237qkf.96.2021.03.27.21.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 21:21:50 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] disk-io.c: Fix a typo
Date:   Sun, 28 Mar 2021 09:48:34 +0530
Message-Id: <0324d03569029c0812e08e41cc182172f8f2d056.1616904353.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616904353.git.unixbhaskar@gmail.com>
References: <cover.1616904353.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

s/traget/target/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 289f1f09481d..230918d34f87 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3367,7 +3367,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 * At this point we know all the devices that make this filesystem,
 	 * including the seed devices but we don't know yet if the replace
 	 * target is required. So free devices that are not part of this
-	 * filesystem but skip the replace traget device which is checked
+	 * filesystem but skip the replace target device which is checked
 	 * below in btrfs_init_dev_replace().
 	 */
 	btrfs_free_extra_devids(fs_devices);
--
2.26.2

