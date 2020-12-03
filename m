Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED422CDD7F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502031AbgLCSZO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502021AbgLCSZN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:13 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F38CC094257
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:10 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id k4so2039674qtj.10
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUDtQkFoKJzUDp/KbFsXFW9qPpciC82EJzYszvfdmFA=;
        b=Q2+kshZMuYSL9PiHVJcODSHMLkbQxWsT5gEACCMXcv5Ek9B1wZdthHGE5DEWUXx/8C
         ZPda71MJn8wWqzkk5ywAPqTPgpTioZz80WS9K6bo12cCFGpeMh3x1jtrwAVczEvNSZvk
         6UEkM/dN4HGQyXTUZ3Rpahd8kpO/06dEJmqcD6K4whtp0enJ+xkuOujHSqt27ZXVr0TQ
         /wluelKFwmLXg4Qwckr1daaEvNOvoFPUW4CeCCr2ifdBJzgX1gSYDjpgYgyo3Im3OPl6
         ghmc/hdeoK1ZQi8hMGQJ7qcB+7SK91qw2wRGPK2ZsnAF1/qbMl1MKKVgyjA87ahiV1za
         6N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUDtQkFoKJzUDp/KbFsXFW9qPpciC82EJzYszvfdmFA=;
        b=eSUnaT566/x49iRRLUCujilnteS/u3fkvTkcK6liMjmMW6EhWYamFjsoKwefweQZ3X
         PNFX6Iqa/0viCPZx1OcA/7AH3lnpHaHB+BbnTREW8vwDhPEBgmJvKFV3qbLrWXHiiNr7
         mN8gHOlVlAr7GjgFDTrYrwSwa6bS+HVuPr7Hh9iEtE9i8bK0o2NgA+xbiyCgLe6/5ocU
         wyFhRsLg9fQt6x52HuiP0QgVTLc/LBPzENZXDSSQ68DBWWAR7QW+airtwISIutepCxn0
         EpEqpmlTZFKyPt9mhef6iO9KAjUKibemCaOPrm2ZyriaUBBRCkx2cj5xZ8KCfReHH7mT
         1l0A==
X-Gm-Message-State: AOAM532CJhD4zKW6Vw3x/iomV33EE2K5URDwMzHoRPZtq6PRqY8zL1q6
        JJUIfr0Z4+aMJfxThWj3BEboiRTTfxgNkfW1
X-Google-Smtp-Source: ABdhPJxRNih9lTiflufC6ruR14xKFZ8LLzIjQ/c/TE4fr504USJWnM2OLVQpKhpC8KNG6AASKwXWGQ==
X-Received: by 2002:ac8:120d:: with SMTP id x13mr4514572qti.141.1607019849255;
        Thu, 03 Dec 2020 10:24:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o16sm2326621qkg.27.2020.12.03.10.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 39/53] btrfs: handle btrfs_search_slot failure in replace_path
Date:   Thu,  3 Dec 2020 13:22:45 -0500
Message-Id: <99645d064db65ba5a02263f49e1779ba025da8b2.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can fail for any number of reasons, why bring the whole box down
with it?

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5a654037795b..6ce46977ec05 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1314,7 +1314,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		path->lowest_level = level;
 		ret = btrfs_search_slot(trans, src, &key, path, 0, 1);
 		path->lowest_level = 0;
-		BUG_ON(ret);
+		if (ret)
+			break;
 
 		/*
 		 * Info qgroup to trace both subtrees.
-- 
2.26.2

