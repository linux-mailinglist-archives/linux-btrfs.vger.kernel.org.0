Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56312DD313
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 15:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgLQOgx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 09:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgLQOgw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 09:36:52 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8108AC061282
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:12 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 19so26487224qkm.8
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qojktz18/k706u7aHY0ojrhKydGouSH/+GIdN3/ZCtQ=;
        b=GS8hWpZWQclqRu/s9eVoRSuPTz3Y7RlCMZ1bvIH5hIZ22F4gDubmfxDJR9XH4mWq1f
         goOjrrJRw09GrBp+zAnITkCEWDThfoH3qqLVnn5N3xOI5fFiWFT/gnFe2n6R30JNWdwW
         zSrZgmZr97vfs0zZ2xGnKJ4ocKyewYUDSGj3+XW790FGgMrnIFXHrBq0fInp0JA8z9CH
         MtzErAEN+9QOFBKSVGeWCJczmROwKW9OCXYnLzU4723m6owigss8u+eepotaF9TlKJ66
         D4g7zwz1BtWTIABZJu1a5LRx2p6OfyXHW7kMK+lR23AH9ZlkDgspRnfkPuPcFyUa/Jxk
         DcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qojktz18/k706u7aHY0ojrhKydGouSH/+GIdN3/ZCtQ=;
        b=gxZsQo7SRGn9fk+aIpkfE7IwF7ckvvDPOjs6D5XuT6x7bzG3FK1vaOOcU3FO+YMrnp
         UFxOWjVCkmcwMFYzbDwRO2xYAa3saTI4QGioqjoJ64IIQaYCYF3yO+Ni1DZfn2ZEr3k/
         cTckM3JL0GujG3BkM3+tGqmg8E9DVe6VEKwHiddbwZqGf0/HSwbHVF28zGovli0uyA+H
         Qw2SmnXF1eul2ElDQr4nDQOb4Jmh/5dyZgePuRA6sUr6z/qJG2iAgyQf4OcToLgueIyy
         6zbjpA37zfNIW7BXXjZJBkOPR3ZqZQIpHvNlwEXoW+TpFxh2uscC2qtcmr1gksS1TISV
         AafQ==
X-Gm-Message-State: AOAM532D6BjEz1uJIb/ZS31X9jlUU5ek0uFsDpCe7PfaUh7G59Q53BDX
        oFbezb5pn1FqkCuL9DFvRqQJMuYFl8fLs/JV
X-Google-Smtp-Source: ABdhPJz03bq+jHb7f25l75im5BX/oDDJ8J3y6bR38POgaJ2R8ifks9zm9i0RKRcN7twEV7RHr0WU1A==
X-Received: by 2002:a37:4c05:: with SMTP id z5mr49818350qka.245.1608215771438;
        Thu, 17 Dec 2020 06:36:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l20sm3630045qtu.25.2020.12.17.06.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:36:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 4/6] btrfs: only run delayed refs once before committing
Date:   Thu, 17 Dec 2020 09:36:00 -0500
Message-Id: <09a77271aa482fac97c8cf3e3cb4daf36d183e95.1608215738.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608215738.git.josef@toxicpanda.com>
References: <cover.1608215738.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We try to pre-flush the delayed refs when committing, because we want to
do as little work as possible in the critical section of the transaction
commit.

However doing this twice can lead to very long transaction commit delays
as other threads are allowed to continue to generate more delayed refs,
which potentially delays the commit by multiple minutes in very extreme
cases.

So simply stick to one pre-flush, and then continue the rest of the
transaction commit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/transaction.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ccd37fbe5db1..4776e055f7f9 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2062,12 +2062,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	btrfs_create_pending_block_groups(trans);
 
-	ret = btrfs_run_delayed_refs(trans, 0);
-	if (ret) {
-		btrfs_end_transaction(trans);
-		return ret;
-	}
-
 	if (!test_bit(BTRFS_TRANS_DIRTY_BG_RUN, &cur_trans->flags)) {
 		int run_it = 0;
 
-- 
2.26.2

