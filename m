Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA524339842
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhCLU0P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhCLUZ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:58 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51F6C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:58 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id s2so4833908qtx.10
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UpEwvVrgtX/qmbF7ZoVe+muqS/VaAiIhL2VAalGSYNo=;
        b=aOCao0vxzuhfGGTdQMpZVGMk8ymaKrYBqYoGb1bnnKTKHVum33MSb3Wga/aPdAPsPB
         v3m86Uu8e7q0ktfPrkSamH3i+HiuB6idbPZJHh1bQJEXS4K43rFHG0++iMeuc0bjIzfW
         +ytGrXS0StGN9XCyDRJqV8BtRZqScbERq6MyG8J65YXLcboNWyZp8+pmGuUOa+BX9dQM
         E16H4JiWtuGmRZQtz4ddQ5YPHSgTNVc9lCbVstTKoeisW2FryoDSsG0JeC8g9DrFBwWl
         2odXiygJa2wfbQkxZgJnkYxUWcsH5TQLbHtVOSNbwOSGvpLZpzlvWSt2lhoijTdW5hmv
         UdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UpEwvVrgtX/qmbF7ZoVe+muqS/VaAiIhL2VAalGSYNo=;
        b=BCLTlte1IX36TVH/J1PJ9thDWSCvg8qFTitejQvPbStDqpdsC6bSnqHofYUM5OZYlV
         twbs/QgXlq3KbIfJqBsPvWezE11G2eZInr7oibOyyDckAx51GTJvOjLWZycJu7A+ctrO
         O1rSnCmSfLZ75/C4AOwtvdF9RnswSTxz1b8d/g699dnImEYSv5WEQXrZa2+jt8CZ9Bhg
         RcHhr6d1MvehfZb6EWEb/7jgD0Rr0sDrHQRMh/Wtbcj4v6cJNZxjQvllyaLHCCN4thAB
         R1J986MK1cHijzBsX/ddNFLiStVlr5ZbT3j3rOmm1zCipD9dUYs5Z+zutFUChy5MYMmX
         6ZVQ==
X-Gm-Message-State: AOAM530zy/2dF3UFOpnviMH2njYHrTeFp3AW0b+zvZeo+LIxVYzILcqt
        9w5O5/AVOGx5+foXVp3PaBg1cP9QoYF6czOL
X-Google-Smtp-Source: ABdhPJxnEZtNBmZT5xdcUDa4Nl0N2z36JE4FiSrGC0N7Nk85pqCJ0vCmrUIrLPVtVY0VZ7pRUwnDaA==
X-Received: by 2002:a05:622a:408:: with SMTP id n8mr13832933qtx.64.1615580757723;
        Fri, 12 Mar 2021 12:25:57 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p7sm5295031qkc.75.2021.03.12.12.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 14/39] btrfs: handle record_root_in_trans failure in qgroup_account_snapshot
Date:   Fri, 12 Mar 2021 15:25:09 -0500
Message-Id: <c47e86b005eb32dd4116b17b675c16f2450c2d7d.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can fail currently, so handle this failure
properly.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3a3a582063b4..26c91c4eba89 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1444,7 +1444,9 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * recorded root will never be updated again, causing an outdated root
 	 * item.
 	 */
-	record_root_in_trans(trans, src, 1);
+	ret = record_root_in_trans(trans, src, 1);
+	if (ret)
+		return ret;
 
 	/*
 	 * btrfs_qgroup_inherit relies on a consistent view of the usage for the
@@ -1513,7 +1515,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * insert_dir_item()
 	 */
 	if (!ret)
-		record_root_in_trans(trans, parent, 1);
+		ret = record_root_in_trans(trans, parent, 1);
 	return ret;
 }
 
-- 
2.26.2

