Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F382446A05
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhKEUtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhKEUs6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:58 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82DCC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:17 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bl12so9828426qkb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fB/uClHnFKujCxxdBUhejg5H4+7+E8aaLPSCXz7vKhs=;
        b=RlzwHU2KKI8qRHRV/4vIxFJvaJoA+i0cSsNBFUAqLhxizJw2y/T/QkbqtE9IjBLql/
         /UGalUdRiV969jEnnzVvEUrTTjbTnuZo7yYJ67hh6dYJu/gXQvhvR0ixBHHPYSTfBei7
         M6CntnyxGuPSQHlm7vXIGq3maqJY5WAepSjLudaXDelKcg2WfSi0V3z6DVupHiIQXaRV
         eEDXcI1bkZg0/BCIDdaYT8Q309oZqq5X3GXIXKoCIjpqiMUw7oIOItnsXv1AyW9zQYio
         G2dIXEsNcs8+dH9vtyWQ46upMozex9AZQhJ2KvmO5Kkz/5Hbt6QJOd7dagNbzyMXTnj8
         +K0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fB/uClHnFKujCxxdBUhejg5H4+7+E8aaLPSCXz7vKhs=;
        b=qR82XUcTkTRzhcFkRxbjteADfcj3gFpy9B15zf6y0IM26D7K94jeoLVbSwQnEKefao
         Z6PWnMQIftMgpC6kr0NlB+OubQwNuYw5aDS459e8sLN6Tt4D4758nNCFfm3VvRo22Ctc
         Yy6UAPm/pyhqssJ0b+h6fG9xu0GHuSdJHNkYm940msBFs2NdiwbUAtXk52xqb2ZyLGYF
         GPjxqrjSu7578aJNQQtV+FDd6ItzI4vFHV5hFuy3QAih24fDO2wYgOYyzZEMATBkOQW1
         5tGumOVeq8PDT9xxDnYfRbBIz+skegpD7IwKzfJrNvePgTGwsCbd4loXcoTfZiw30Ci9
         Z1FA==
X-Gm-Message-State: AOAM533xeDG75NnWbH5OL5BZNF4oBjuaMQa87XucYY4rxx3qZZ4QarU5
        0A3SbRiU22G7bykhf7H1OIvmW/cuc09LZw==
X-Google-Smtp-Source: ABdhPJy0e9quSgOvwU9TMBdiDOVytyD/+MQgTIu4B9YZ+JvxoPL4AzOanr8A08rnT+95rjwwoikazQ==
X-Received: by 2002:a37:2e81:: with SMTP id u123mr49130357qkh.156.1636145176621;
        Fri, 05 Nov 2021 13:46:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x16sm6802371qkp.56.2021.11.05.13.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/25] btrfs: don't use the extent_root in flush_space
Date:   Fri,  5 Nov 2021 16:45:43 -0400
Message-Id: <5c324b207e0784926148bf0566b4ca0b2b9f2bfb.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We only need the root to start a transaction, and since it's a global
root we can pick anything, change to the tree_root as we'll have a lot
of extent roots in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f74b4063772e..f6a1486bb6e5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -617,7 +617,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		       struct btrfs_space_info *space_info, u64 num_bytes,
 		       enum btrfs_flush_state state, bool for_preempt)
 {
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root = fs_info->tree_root;
 	struct btrfs_trans_handle *trans;
 	int nr;
 	int ret = 0;
-- 
2.26.3

