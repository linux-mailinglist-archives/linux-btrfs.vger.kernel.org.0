Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA936228201
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgGUOXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgGUOXR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:23:17 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AFFC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:17 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so16245915qtg.4
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frCUE3S3/bN7rWND0qsjSP1NCZLi+CeRQ3+FfDokoQY=;
        b=y1ezuLYOUr5+1SsF0Qix2BOwCS2zf8sgQfahSzSGY272JrYthE3wTFfmNaQucUTm+P
         NsW/I6bb0Sy9SzfsYD3/uMdk/GJD6i0OAgJLlJopYVd8YIoJ8OqKFAk/imlNpDFysa60
         yruhylrFBFrhYnTTzh/fp2uJVzVnvfQ4a3vNwCXS7o2gjWoe/DmTHv98L8xOXYlVdIxq
         s8jTsbwV+vZDGiCqyf8XI2ijy9uGKKgS0OcGRc8r+mEp3C0XXFZJ+tN2tP8OzW6xF8bh
         HdJSohM2EdZomTxqex2sWgwS5/27oOnc9S/EnF+1YL5vfPMyfqrIQA8HYI0N2kCTDLOm
         zxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frCUE3S3/bN7rWND0qsjSP1NCZLi+CeRQ3+FfDokoQY=;
        b=EU2dUr17/n4ltOCBqESPVvJBTBsD7YPFIO67Vl76QfGHdsqZw9mWcQh8sqNVos6UeZ
         DwTdU73XXLQIAZbRetdWo5laF4ZQPRF07LRDUmP1pEb0D+gNq1RaqeC82aqMl9pnJqrl
         KobGuOajYFEptJl+QeP4JDPWo3nRk9XID+QSbUj4+UeSLae5ueXu+3s92BFK3Ky6pPhZ
         jnyduJNNA07JFUTnwxtaI4+HFd/xje91taQhNZoaCU2RMe0/NLLexe8GTCTrmagZSjjz
         IL23c6D+KuXXSeVGkolgg03zFBYBUivtaXuI2cMzw6UQCbSfCoZK2i2CWmsOPcdr4Ygd
         tfaA==
X-Gm-Message-State: AOAM530GdKP9fPbEjE+xUfoMS6KNIOC5ZPupA/M0vKWpy0IO3cMiQYop
        huPOPqKDC7aJIl+KA6KwhiRtZBtP5kAyfA==
X-Google-Smtp-Source: ABdhPJy47ossLQbM9oenNz2n8zXjWNqVbbuJHtsVq716W7BkW1NIAaT6Qk6S4K3ZTRgniwPMmUmZhA==
X-Received: by 2002:ac8:964:: with SMTP id z33mr30119864qth.276.1595341396370;
        Tue, 21 Jul 2020 07:23:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o4sm23469120qtf.92.2020.07.21.07.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:23:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 20/23] btrfs: run delayed iputs before committing the transaction for data
Date:   Tue, 21 Jul 2020 10:22:31 -0400
Message-Id: <20200721142234.2680-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5b46835766e3..092f3f62a5ef 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1022,8 +1022,8 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
-	COMMIT_TRANS,
 	RUN_DELAYED_IPUTS,
+	COMMIT_TRANS,
 };
 
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
-- 
2.24.1

