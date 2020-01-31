Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CCA14F4E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgAaWgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:54 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33961 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgAaWgy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:54 -0500
Received: by mail-qt1-f196.google.com with SMTP id h12so6746471qtu.1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2Ume/qlDre8Ea67Er3EDH0IdgTNboJRMluDWsWiEk1o=;
        b=MFniYDWzSsfc2a4tUbg0GXez6yLgeZmRrLn27/uUR5ie29Y+XnanyhWiijlg5snlV7
         9ErS/96kBIYTEg0uBffflr2tpWXTVtn3LtszYK+gW6bCBsDfXqvu0ImEYDqHSWy3rzpG
         tKLqq/KscW4+nlIMvrZXi+mX7uwOmgM3QqkP369gPxx4MrV2H1Ydd2WDnaL4y3fd3m1D
         eDdaGZoyIGXU5rGw23SY0onHW571OGT5trAbKdfHL9kICI12itERhqAzifCLVxH2yT+z
         17vV4Tc1fJz7NyHCa9DNw4/E4RLSGpyzRJGDJN60aJTlH8s/FjoSMSYrqaGBvaApODez
         csng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Ume/qlDre8Ea67Er3EDH0IdgTNboJRMluDWsWiEk1o=;
        b=Jsgp01+nnhIkZ01ob7PgTIx+I9DMTwPjzfXyZvUBEwDYLskzERbwngJkdd3/ypmfz9
         d45DkFBaRiUHIImtt40XF688+hHy8FxHYWq+Ep6fCdoxQepI8r7lgwCLKMZyUaPL58dl
         DF9lkRaoWOn359W4qj7Ri8Ue9lK58S3LoHLRmLgCfVHP8jpVBwoXC1NJ8wKU1QhOy3BR
         fNbhViWQwpTTVEaNf/G/r1ryqc/EU31HTe8H2YO9T+kKa2yrCStX/Ko6eU1prXelUHIf
         ay0geD/XSlaoZoI/UY8snsiPqrf9Sep1mmMA5XeOXxKt68HKvQrK0Cj/OICof+tV4nOr
         W44Q==
X-Gm-Message-State: APjAAAVFQm510n8xnbBE5qPy/ZTTFsuZjWBIs77p7RvWZAGXK0JqpcGF
        KFynnLZHGXReXOuWOSu1KDAggU2ctiq3NA==
X-Google-Smtp-Source: APXvYqyXx95Hm9buow1zyldVk78s8gFPtlg+OqzREgW0ssHcLHUOa7q8g5P7f7tV097AlecXlZ/o4Q==
X-Received: by 2002:aed:3fce:: with SMTP id w14mr13721762qth.0.1580510212723;
        Fri, 31 Jan 2020 14:36:52 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m95sm5664140qte.41.2020.01.31.14.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 21/23] btrfs: run delayed iputs before committing the transaction for data
Date:   Fri, 31 Jan 2020 17:36:11 -0500
Message-Id: <20200131223613.490779-22-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before we were waiting on iputs after we committed the transaction, but
this doesn't really make much sense.  We want to reclaim any space we
may have in order to be more likely to commit the transaction, due to
pinned space being added by running the delayed iputs.  Fix this by
making delayed iputs run before committing the transaction.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0c2d8e66cf5e..c86fad4174f1 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -804,8 +804,8 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
-	COMMIT_TRANS,
 	RUN_DELAYED_IPUTS,
+	COMMIT_TRANS,
 };
 
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
-- 
2.24.1

