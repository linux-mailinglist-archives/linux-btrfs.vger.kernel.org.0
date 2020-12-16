Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7871C2DC447
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgLPQ3D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgLPQ3C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:29:02 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33EFC0619DA
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:49 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d14so22368141qkc.13
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pqiQ7UvF4uruee0h+EDKupFEUyvfZkyzSQxdS1uiU1U=;
        b=cF5Ug0inDS2p1rrQ3abfJmihaxhJwkP+QOWpk8LnouwLKRlwgttJNkokI1ep40VkYs
         9/3OcTvabqJeZclwJyNrFY8PfaEYo+eEyZqvuLEMQSyk+bnAOxyhqwu6h9UjCwFAQC0c
         mDxAYbHu86cSGWqR1Bh4MB1Stxk+nif4YsqdqyqbPmVWIwbQmxSui9Os3642iIlAXW33
         xCOwO6FgvXAYn3xpdMCHi4GuWTGgFPSvDDDiyAoV46ct9lHCzQPELG0GuWXCYM3gDaHt
         v1l8A7gIrUNN2dP4qD/45ngJTXcvEmTCPNjxDm2aF1r+vJBYZZYCzhmmWIMrb9NN6flx
         YdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pqiQ7UvF4uruee0h+EDKupFEUyvfZkyzSQxdS1uiU1U=;
        b=W2ZeEScPpFncRvrIhCIyw0IifjqIPtziZ1anOJLdhnXXgIujW2jqcvmQuf9eRWsXOC
         f9btFIWc6uHVqu9QRyQGkIdUHRgcoBx5VNVqs4wlOkekx/CLVOZp1U7BfNTDyB/o/ezo
         6QK6NaqHBCvs10DbHTki7XjSsW02pytLSitzltzrXaHYFzjpfwAcccIyNc6z6tjHus0n
         uTZEYI84UkR0hSxjqoO/wVF4sn1qIvdKlFAEnmIq2eHHLa6Gj96gC38i+2y0lG5e/+Rg
         GB6ojd7myDABcLxurYU0dvNdQNqTOlDeFWcUo0FIRbaEtMGd4GtVd5pFnB0Z+h2TNRXr
         uE5g==
X-Gm-Message-State: AOAM5313Cjo/XQQVDI2uZClMH16RWjYM/xI4aKA5uUtS0PugHxMIk5X6
        ttHWszNij3rZ82BGAjjb6adFkDUIlUrXGctJ
X-Google-Smtp-Source: ABdhPJxPerALsoCE5zIFZnSlyxJlKVYcGtCas9XSw07dz5zZ+YzN5t66oWZTGs5p77FXR3zCr15Igw==
X-Received: by 2002:a37:2e05:: with SMTP id u5mr34051976qkh.228.1608136068885;
        Wed, 16 Dec 2020 08:27:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n66sm1388675qkn.136.2020.12.16.08.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 30/38] btrfs: handle extent reference errors in do_relocation
Date:   Wed, 16 Dec 2020 11:26:46 -0500
Message-Id: <edbaaf88a4bc189c155c93cffa20e9e43e2fcb0b.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already deal with errors appropriately from do_relocation, simply
handle any errors that come from changing the refs at this point
cleanly.  We have to abort the transaction if we fail here as we've
modified metadata at this point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e60353980942..67df6ae6d13f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2434,10 +2434,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_init_tree_ref(&ref, node->level,
 					    btrfs_header_owner(upper->eb));
 			ret = btrfs_inc_extent_ref(trans, &ref);
-			BUG_ON(ret);
-
-			ret = btrfs_drop_subtree(trans, root, eb, upper->eb);
-			BUG_ON(ret);
+			if (!ret)
+				ret = btrfs_drop_subtree(trans, root, eb,
+							 upper->eb);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
 		}
 next:
 		if (!upper->pending)
-- 
2.26.2

