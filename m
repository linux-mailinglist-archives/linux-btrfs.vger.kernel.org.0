Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC92CC70B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbgLBTwg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388128AbgLBTwf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:52:35 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3896C061A04
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:23 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id b144so2439562qkc.13
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DYKS2rzZ5QdoTMpXyLy3zyB2PON5SF+CzFRvbNfdP6c=;
        b=yM9IJxMnHyy7f4yVwHpC9wLlG/WKvFZbvJl21z/aqArlUQ/GW5/0kVzCPR7J/+qpT2
         bOz3x5qkxt4MYwMEuerRe57pVCxFC0yspDGrEY3KBd0k7HZZrvGxYpHK8DKza+swqwwj
         Uy+c/IERAvn77T27zWlLh/Dgzld/lOFdHRZTySims426ZoPGrTK6RswYeVJ78sDWr2hz
         v4QqB3svbpXG22Z5uid0uDdqnI8xPeKBmSRHPyuq5okT5HhUsMDlEu0X6PqFFrHJTUct
         znEDm3CnybiLm4N/CTIkVWMeRAjKDLb/OWsmhiXKsqAcSjTwO6TMK8I6f3PTHnhUrNFc
         rBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYKS2rzZ5QdoTMpXyLy3zyB2PON5SF+CzFRvbNfdP6c=;
        b=Cq2eHAcBPppqWcrfch3Ah6czxatvE0WDMb48Nq4sL0YtF78O0DAYHAK26Zz89jijSB
         YPuL/YOewbBJDHNrbqmZD6/G5jfD3ffnui0PxlHPieSaWspHE0wIirrjdHSXSr1SJ1fO
         Kl7SVCtjuQLwK24+bpjxFvSpFpw1UOGKjNrG0wtWQpVA2EOivTCQimIqvDo34+cGbAQy
         XqflUx5B/Lf7HmmX32KmAA77j5YqVVAtM/DZNEWI+vhaldtebNnEyK77T9zLTcmFNo9s
         whojkAg+kfclddB7tCF7IG57uUsoL8LDTpCL2HFPUYJtcJuX0hc8QDXJlFwMPUsfBSIy
         NcqA==
X-Gm-Message-State: AOAM532/foxgiI0xQTiKrQ68MGe3fCnyUJ+C5k+wpv9NTnchddw4UKtM
        /OO3kRi+CwLLCdFZqYtYsU6ErCuuene5ZQ==
X-Google-Smtp-Source: ABdhPJxBg8KsHNk2wyp4+wUjaeU0FWbQylajZTNjaYAsXovViY8IGwdFng0aS61BT/7P5wE927UQ2g==
X-Received: by 2002:a37:9942:: with SMTP id b63mr4131231qke.331.1606938682933;
        Wed, 02 Dec 2020 11:51:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s130sm2034375qka.91.2020.12.02.11.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 05/54] btrfs: noinline btrfs_should_cancel_balance
Date:   Wed,  2 Dec 2020 14:50:23 -0500
Message-Id: <4657a485af5665a07682c4d7a5eb14ef241995a5.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was attempting to reproduce a problem that Zygo hit, but my error
injection wasn't firing for a few of the common calls to
btrfs_should_cancel_balance.  This is because the compiler decided to
inline it at these spots.  Keep this from happening by explicitly
noinline'ing the function so that error injection will always work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2b30e39e922a..ce935139d87b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2617,7 +2617,7 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 /*
  * Allow error injection to test balance cancellation
  */
-int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
+noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
 {
 	return atomic_read(&fs_info->balance_cancel_req) ||
 		fatal_signal_pending(current);
-- 
2.26.2

