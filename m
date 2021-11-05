Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13D94469AC
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhKEUbe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhKEUbb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:31 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B20BC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:28:51 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id n15so9802570qkp.12
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=06dZOBZdfPYIgrlPC0zYxC9/N9IWMKbvVQiFntIlih4=;
        b=rA18MlmNYIR2OhfT5R0334gB77uZfnaBEoBPCvrblkc1BMNn7La6tEokxF73Oiaoib
         MZ8U69xeMPwmR7V7fJJbeQMbTrRe2kQSfB4w1XzftMhGp9TZzCbTXiOz7NFpKWcqL4jx
         1y3QOsRa1Jd5s2mxTnxZR53l1xAllmVnAKLZr2lYEAltcRJZ9lIV/wEVFCvzjvw030Zz
         yPuG+l/Zd2YNtwLh2EMihSk9ZzJ5NuXYcH5naNO4nlHZ9ziLao0spmn9ivbjnQLNkAaC
         q66XcE3+ZKuB/oLDrJM/JrdE4aYiwR2z0L8Ture/znfMwF/MaiYYAMH1xgcMlmcZ+ZRZ
         5hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06dZOBZdfPYIgrlPC0zYxC9/N9IWMKbvVQiFntIlih4=;
        b=8JDN0OYlZ64Xck4QZh0VMQTs96jh3U+Z3EEcBvL4ROD2oDCYZAfW5/8/LNrCzf/W0U
         1upxTSbbRczc9R97JBj2mXMKgi9M5iqcvtc3T0sGeNnynNt/6YhB8FuyQoSs73o6iQ8N
         6kXL6EZbgoPv7onnQkLadkJ1dWymvRHaYiAbHWKwfac5x4Annn976VPl3a6AfZZuRvvX
         KEDSzAM9pazo2N9lhNF0Y8hkpA0/bEzAuwYl+8Z5loAItWrNT+k/Lm7GllSwWrFfPTHQ
         J6FAkmfa1La/BJXSdd/CBJv7SxrC0WCO49pheBCES9eBiX+DxiBnde81XObmt46/dC3w
         HKhQ==
X-Gm-Message-State: AOAM53062h3w675beJRWTsuwIqRx4PNO0k4PlL/at6j/JqvZxkHdd86o
        m8gG32aApoB3kqkqprWoSFLgl963FW+eJA==
X-Google-Smtp-Source: ABdhPJzEzjqFTheRSilxQR1sR6yks1Dkrn2RsFHocaHghDQKtT9gBdSVSYuqgKUoBa/2Okz/nYu0dw==
X-Received: by 2002:a37:9703:: with SMTP id z3mr48066305qkd.517.1636144130099;
        Fri, 05 Nov 2021 13:28:50 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s13sm6262047qki.23.2021.11.05.13.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:28:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/20] btrfs-progs: check: don't walk down non fs-trees for qgroup check
Date:   Fri,  5 Nov 2021 16:28:27 -0400
Message-Id: <ee44994bf587e662c6cd99ac165da53d5b0cfd9e.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will lookup implied refs for every root id for every block that we
find when verifying qgroups, but we don't need to worry about non
fstrees, so skip them here.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/qgroup-verify.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 14645c85..a514fee1 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -765,6 +765,10 @@ static int add_refs_for_implied(struct btrfs_fs_info *info, u64 bytenr,
 	struct btrfs_root *root;
 	struct btrfs_key key;
 
+	/* If this is a global tree skip it. */
+	if (!is_fstree(root_id))
+		return 0;
+
 	/* Tree reloc tree doesn't contribute qgroup, skip it */
 	if (root_id == BTRFS_TREE_RELOC_OBJECTID)
 		return 0;
-- 
2.26.3

