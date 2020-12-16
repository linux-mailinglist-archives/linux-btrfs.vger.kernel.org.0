Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33D12DC424
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgLPQ2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgLPQ2S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:18 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB025C0611CE
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:19 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id g24so5194655qtq.12
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CoE53/nmnjHVbpSZTX5nmeCiKBp2mQN7wYzsWW/xfp4=;
        b=fsI/CBfVTtpQ/10tkRTwziqvZjuWuKCUVAcDoxpzYf9qyYHya1ubafnYWBL14gVZTC
         lOktcvngdfksWZyoyjD0t+SqAfoMAgVFFVc1JZvR3T4FVxpIfSZiMcJaGJZgOEFVcxEz
         C28Yh878xbUh8uIE2wXp7PaBE5+uCO63PdzV3P/VEabi201VipTANbLMPfWc735noyTL
         oOzrUaCC+nbLbonnc24fSDNUaVvK8XqTpmsIiEhnRdhOwX+su3FhijmNhtjQftDEkXhK
         cKQ2DfvwzJwi5ZlNFzqRvgeK4RArDvCHrkTiwgcHmI5I6wEX6xxzcXoVz45UGdflsFTm
         XqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CoE53/nmnjHVbpSZTX5nmeCiKBp2mQN7wYzsWW/xfp4=;
        b=qbjWBwB+b6yGD/v6UkD8OvFuXlb8insPjdUAJK6TNpVll6SatokoZOkkVIoGLU9aex
         v3xgP47UGmgWc7NHfnQjXTeY5kZWczCBk+TvH2608mOdESsSN1ndrKwegxRnKuknnlbg
         u841MmaxknzXC8XXaQXR4glclbSYqBsttpyNBBZih4PCV2e6UPXkYJZJU6QGCrKphxcy
         Ru5edKqY1Bm61vedvA79+PtfZS5ptb4vBjw7F9TmAqp6wlb8gXjMpaidtoer2ivfjkGX
         a4e0oKiFCP40+HWEP8HpZq5UIR4zFirbYqQ2rby0VJmyvyhj2Hk7+km28tn2xks7bAWA
         cJhQ==
X-Gm-Message-State: AOAM530E74O5SxGUDL23TEVuOfDMTtqWAXx5hc8LyLJITKqvpDt/abbX
        GKqwHF+LV7+HfN/qe4k+7k8lTJ4zcShJf4dx
X-Google-Smtp-Source: ABdhPJyZxyM1s+ktUSpQVcEReGcy7S0eqEoELrTEjVT0liEBqAerWrEifvdHjm21HO/duWp3oKISJA==
X-Received: by 2002:ac8:6947:: with SMTP id n7mr44440131qtr.83.1608136038780;
        Wed, 16 Dec 2020 08:27:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d190sm1380071qkf.112.2020.12.16.08.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 13/38] btrfs: handle btrfs_record_root_in_trans failure in start_transaction
Date:   Wed, 16 Dec 2020 11:26:29 -0500
Message-Id: <33513c6f189db9338a71550fa93a3ca729fe3c40.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in start_transaction.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index eba48578159e..307a73abe86d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -734,7 +734,11 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	 * Thus it need to be called after current->journal_info initialized,
 	 * or we can deadlock.
 	 */
-	btrfs_record_root_in_trans(h, root);
+	ret = btrfs_record_root_in_trans(h, root);
+	if (ret) {
+		btrfs_end_transaction(h);
+		return ERR_PTR(ret);
+	}
 
 	return h;
 
-- 
2.26.2

