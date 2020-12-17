Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3E92DD312
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 15:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgLQOgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 09:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgLQOgv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 09:36:51 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4572C06138C
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:10 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 22so16285021qkf.9
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eIfUdd9SMDMV7st/xib0XwZ+96qQemHgJNdz3/SGt4o=;
        b=xNTuXHAie7kihA3DKNJ7S/3rUKl/Mx1NAZ2MqMqSIJf8EKaCH/DPPDzm6nWkV6aB4w
         Dp8UNFIEwfdcaj2KxQgCM1jvJJsyAx5zkeCwYYUF4z5rEEFKIfdg2raFoS5SCSEVuyuB
         ccqrOp4td0IfNpO4D5M4OMOr0tyXdrlqI0NlKXNc1jXVz4UfdjWlDhAmddMVUeIr88bE
         V7OCZZJEJcg8Q3nXGCgpF6A0xKM0exT0uQ+6fBYz27zPJWRQJT5uQaqju+TO4S1EBybi
         BXVddyxNL/ic4zhgXIAfjczF8sRRTVmA6E3AA7kQDMysp9jX7wlaAd+ACVi9hb2tpUdh
         sJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eIfUdd9SMDMV7st/xib0XwZ+96qQemHgJNdz3/SGt4o=;
        b=DVEIAdGz4CiiqssE1Wmw03z1EPODFJKcCMmilwXVrA7LBMD1cPMZ4QDvK57nEQ3h9Q
         bZz6ntsuTILfUy/m6k49LH+nyDuQThyWQu0Ld8m2UrlswZA2/0T2s+TLLqWpX+Mx3fIP
         JkB/pJaQQaCnbky7mFwdJuDBWRIng5OcLX/jUqPEso4T5UmVOWzFdMN3hJ5Ykx9/Iej2
         GHZ2TTS0hSN/eMQ1NzgoYOvX2RayVqn8zQ9tf+PF04TLo47BhxlquYoQ9j7b3Wtzz8Wc
         nYUPuCjFuGq3TgrqDzxNj4O+D+81/+NIPegKuVMQvtNkFZr78voO+ddqrsAg5FQotKXb
         iSEA==
X-Gm-Message-State: AOAM53135C+ZlGJJIVCaeub1QZ2zY8OlU9QxppWpxBGeD5nVzSzWAwHD
        exFYhR+//AR1ldffp4DIwrByL33M/GsUt8do
X-Google-Smtp-Source: ABdhPJxBXdiQiCWeiLU1cIz9Us3u0otD/l4T2f8qrbdQSWOfS4NTQTKGaVp+Knd05FxfMcE7OrPKAQ==
X-Received: by 2002:a37:50c:: with SMTP id 12mr47472555qkf.296.1608215769718;
        Thu, 17 Dec 2020 06:36:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v5sm3490027qkv.64.2020.12.17.06.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:36:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 3/6] btrfs: delayed refs pre-flushing should only run the heads we have
Date:   Thu, 17 Dec 2020 09:35:59 -0500
Message-Id: <1beb0dccc468e2190062281005f2616bda623924.1608215738.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608215738.git.josef@toxicpanda.com>
References: <cover.1608215738.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously our delayed ref running used the total number of items as the
items to run.  However we changed that to number of heads to run with
the delayed_refs_rsv, as generally we want to run all of the operations
for one bytenr.

But with btrfs_run_delayed_refs(trans, 0) we set our count to 2x the
number of items that we have.  This is generally fine, but if we have
some operation generation loads of delayed refs while we're doing this
pre-flushing in the transaction commit, we'll just spin forever doing
delayed refs.

Fix this to simply pick the number of delayed refs we currently have,
that way we do not end up doing a lot of extra work that's being
generated in other threads.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d79b8369e6aa..b6d774803a2c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2160,7 +2160,7 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	if (count == 0)
-		count = atomic_read(&delayed_refs->num_entries) * 2;
+		count = delayed_refs->num_heads_ready;
 
 again:
 #ifdef SCRAMBLE_DELAYED_REFS
-- 
2.26.2

