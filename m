Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CCF4469B9
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhKEUbr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhKEUbq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:46 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51910C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:29:06 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bk22so9832695qkb.6
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IV6Sq4QnvwDpy8hLkJ4ai4Fqu2bnnZgMtCUn2i5h8qY=;
        b=mmYLwxQwXh/e3xoCNXzNuedvi7usez++/UWyMJ3I+O19UuAmBLARGDZ0MW04uymWJf
         bjnZ+qnNnXvEBlCwZd4DQLKw7kRG9yFhX84qowKHhJf+QaSNL+vF2NJTws92sKX2Aa4O
         u54ydV/7ZWFf0zLudU0x0/kVuRDfttoJrdcOyB/pku38/5dZQYxhEAfvqm9iUfIcOLNf
         Ot0RfPK74ekP35sqVZIBqHfHSe6o0Oj6Uh8BL+jk/jarAcuqscZT7VzXJN4WWHeLDhQG
         sbUSPKbM/V/nIkCBrgIC/RaOut9cf8o91XqCG/e8FBeW1CZjdUDQtt76MpME+BtcVXcx
         QCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IV6Sq4QnvwDpy8hLkJ4ai4Fqu2bnnZgMtCUn2i5h8qY=;
        b=jjiZKX4EZEZg7O/qETCEUev/pzdKuu4EbIUQnFdSId+xQhfj5RfUhAZlpgmO7Fx9Zx
         HwnlTE62N1PFsZ/SNRtDDKryqUl/J3MPqxvSl9k3T8BQ+WbLsWrNVVMuFr/15y5c00Yk
         2eVz4i0TR04O6DjWPYZVA3IQQxqxFOJZeYj0gj9rtYr6yB/4XjfbNyPYCa/nFpSeLFJP
         0SiJK1S4LnijrAuUkPcMllpG0Sb7KtXrc9Hcbb9K57cboeOHuKa+eYXeHCRBRY8IfqCY
         q36ed6beuSTYJAgU6ttQPtc6blqmDlQjbTKm9lkHtAQkc2x1dGBpqZPopNnOBunLGaGB
         r4/w==
X-Gm-Message-State: AOAM531q2Dgh7k0S4tRdHt36iDf8PTNFqhc9uAoo3fI6sXKFLfklDAjb
        LWM3c+d5WamMPTZ1IqIR/WoZdo9lyPIRGQ==
X-Google-Smtp-Source: ABdhPJxs8Mu5iWSe6kRbTqPmf1oQAfw66P62+BYpWI8G47S8EX6X//HPotpilFmgYrPwkdiRpj1g6g==
X-Received: by 2002:a37:4152:: with SMTP id o79mr49175705qka.169.1636144145204;
        Fri, 05 Nov 2021 13:29:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f12sm6379040qko.22.2021.11.05.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:29:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/20] btrfs-progs: mark reloc roots as used
Date:   Fri,  5 Nov 2021 16:28:37 -0400
Message-Id: <1da6c61af04c10b8a7e682676121e1031753fe69.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_mark_used_tree_blocks skips the reloc roots for some reason, which
causes problems because these blocks are in use, and we use this helper
to determine if the block accounting is correct with extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/repair.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/common/repair.c b/common/repair.c
index 79519140..413c3e86 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -87,10 +87,6 @@ static int traverse_tree_blocks(struct btrfs_fs_info *fs_info,
 			btrfs_item_key_to_cpu(eb, &key, i);
 			if (key.type != BTRFS_ROOT_ITEM_KEY)
 				continue;
-			/* Skip the extent root and reloc roots */
-			if (key.objectid == BTRFS_TREE_RELOC_OBJECTID ||
-			    key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
-				continue;
 			is_extent_root =
 				key.objectid == BTRFS_EXTENT_TREE_OBJECTID;
 			/* If pin, skip the extent root */
-- 
2.26.3

