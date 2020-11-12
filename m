Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414D32B100B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgKLVUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbgKLVUN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:13 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349A7C0613D6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:13 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id g19so3586087qvy.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zdnQLi7LKvaFAzBPY7SLpBx+wGhyhes4JAA9NZf/ZKU=;
        b=yw3ag5pSG/qjXW8ArYGevFDAKKggNQJTy6M9EB9hb8+tdq2eGYetY0HQmIYsEbxL8I
         980IAoAG4sU07dZENy+db56/jiUdskKv/l2JjSi/alwoWM5Q4f1FwVfSjKOSW6fRwCPt
         pPTM8HTPqDalP3x+NYpf8RZwWeVgq4UPUny3Fxzl6DrJG8B2iFMIP0yyONIqmyXw6eG+
         1BvMR2XUMEA/MFAnZRRFxS0KC9ZqsDbFhiAx45KwUXD5yVoAv8ylEtQcjg0mRJKCdjdD
         c8f8RjUMd055cfOWt70lGOPXd5uKbir/nHAg1Sm7u2V5nW6hoJMsjU2W5iZ2oxdu7n2T
         rFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zdnQLi7LKvaFAzBPY7SLpBx+wGhyhes4JAA9NZf/ZKU=;
        b=SzJsBdL3q9zQWr8Yhu9sYbm9snn/avF3B3XC12artgOeEFNxyxKJ0Mk9OLn55+k2BU
         vPq5CSNUFUKkW7TB9UVbBFIeLAF4D/gZgZrfzdveN5q04nywBaWjDvDDSl1ByFkrAYAQ
         9/p+IysAg+KRWzJEzeqYmvxPgn0KUiG7H4jnH/CWD5OFfSrXFnTrko9bRloRBdeGKrPm
         aXM9EKmulpFycw6qaibnWQQx8HrBm50i6NwsE1yR8zZnjKYTt6mzkSSPtaXnvItNHv34
         6ZTLP9DXzpWE1avzlzbAw6SFlTwyfvtPMg/waS9Q8pIlQmZrjppe5HZONyxIJCML/GE7
         qutA==
X-Gm-Message-State: AOAM530WZT+enz5y3HBdG8jv0/cWPM+G/0Z4UyKj0zTzeKfNSZCu9aon
        IpJazQai6+khEHO4IXSCuFDPhUPSKwl3Ww==
X-Google-Smtp-Source: ABdhPJyQzH/p44QCCJg/qMQnmfnqTpafPGy7fB3vWWYQ78+VmMdqFs42NqsWKSJQ+PavM8LVzMClcw==
X-Received: by 2002:a0c:b648:: with SMTP id q8mr1756291qvf.33.1605216012012;
        Thu, 12 Nov 2020 13:20:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d82sm5601373qkc.14.2020.11.12.13.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 30/42] btrfs: handle the loop btrfs_cow_block error in replace_path
Date:   Thu, 12 Nov 2020 16:18:57 -0500
Message-Id: <cbf9fbdfc9dac05efbf263713e7af55f77c74a60.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As we loop through the path to replace it, we will have to cow each node
we hit on the path down to the lowest_level.  If this fails we simply
unlock and free the block and break from the loop.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 07092d7a4d0e..52ae6bba2261 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1294,7 +1294,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				ret = btrfs_cow_block(trans, dest, eb, parent,
 						      slot, &eb,
 						      BTRFS_NESTING_COW);
-				BUG_ON(ret);
+				if (ret) {
+					btrfs_tree_unlock(eb);
+					free_extent_buffer(eb);
+					break;
+				}
 			}
 
 			btrfs_tree_unlock(parent);
-- 
2.26.2

