Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644422CC702
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgLBTv7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLBTv7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:51:59 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0742FC0613D6
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:19 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id y11so1299855qvu.10
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ljUV3+4q56H95g8ABu7lDvHi0HAOTzW5SqlwymD4DP8=;
        b=rwXDYb1kMKU+HyeIUBhharRdqW8rr1KAyWIuGfp86TkFqk0UgGfL4oAvvdh8PL+utF
         bz2PpTzD8saQHGq7Smo+c2bC7/VtSN4UMmwL79f9ZdDL6b7J86iarNTQyCAC+DPuFPyV
         YBkzwNVhvzSt6uBloR23+fKPLOSuGGNtqI4/Mw0KGQBEzQohUGeLN2qqdMVq0m/OPPIp
         GGVd2SjBsgDtPqCQFmelhrlZGdwoDjqTBWmZ4372OxVScyjnKtgmw6qLNbh99HlTOvm1
         BQlXolXcd3IlklA1smwz1vUT6vj8bLh4G4Cwjk4uf/fuLqSzWhY3DE0KcOOIRrtiRdMn
         LiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljUV3+4q56H95g8ABu7lDvHi0HAOTzW5SqlwymD4DP8=;
        b=Lh5yfEDR7bmT1Z1L142CUMjPzVjQgRlNw0+UO8nL9LHJcyS/sQEAtTGij6knGe6WnL
         yIsTAjtvW7/qX04p0nhSt3QDkAt+Xgqb6wYsEArg7Gl2BAqhIbUoA5vAlU7XZcrQNYjf
         PkljcRJibjEOjayxbnJENYf4Nl1DwJq0Z86G4PTjZsZ6pnaGrUIiWS5MjO6nr2fvNOR4
         JeMZ6VUneTaaAH0WmiOmlJ+ns+PI0ocBv2Ndt4nNmoBCrD8f/pgbQ5ZA0TXf2gkINaNv
         jvYp1v77PgP7bXiskPlsuk6swkXgymsxfv+Vjc4C5xGuNClSOfpYerRQErpDcfWpKE5f
         BfOA==
X-Gm-Message-State: AOAM530dqPXmUx4zIS+P7caLw3CMltOx3jZcfKpAoUn+zvPbmgsHPEg2
        Fecq13yq5aLZBLvfHKFEK2n5raB3cTj1nA==
X-Google-Smtp-Source: ABdhPJxMWE3t01FptcqjuOs5FWyJC3+pGSXkER3u0CmavvPIUf/M2jYp+RkQ1IXKBIpSouYV1PLcgw==
X-Received: by 2002:ad4:524b:: with SMTP id s11mr4456083qvq.3.1606938677822;
        Wed, 02 Dec 2020 11:51:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d66sm2921797qke.132.2020.12.02.11.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 02/54] btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
Date:   Wed,  2 Dec 2020 14:50:20 -0500
Message-Id: <c0a4d7f83ba50576a4203f0169f2232dbe009d3a.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following patches are going to address error handling in relocation,
in order to test those patches I need to be able to inject errors in
btrfs_search_slot and btrfs_cow_block, as we call both of these pretty
often in different cases during relocation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e5a0941c4bde..f40d3a2590a5 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1494,6 +1494,7 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
 
 /*
  * helper function for defrag to decide if two blocks pointed to by a
@@ -2800,6 +2801,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		btrfs_release_path(p);
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
 
 /*
  * Like btrfs_search_slot, this looks for a key in the given tree. It uses the
-- 
2.26.2

