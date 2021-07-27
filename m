Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580603D8063
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhG0VDs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhG0VDo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:03:44 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFD5C08EAD1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:23 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c18so154448qke.2
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nXyk6RG1BPGDU9NJwhOl2kUfe2XMppFu/R1x/KhsYoo=;
        b=WgIVHA8YYZzaw3701F0hXqvZodXWHk4FEUVKRofxsuNKUll+VgDUw6jvn2RbVvaz7W
         lz3w9E2B3QmI6cTVZ2E8WORbYjf5nXLr3/MVWWHGItFnizHV/oFKq/mXl1DWqZdgzY7l
         PEmZvsHJQq6QFDownBd5lKbTJT3JY4sw9w6Jru/bhkwZrlfYZnNr7Ne/4A81sidMZtig
         GybSC7hV85GS+BTCqQ5mrnKf0uFnc1O7UdiW80eeb5xV0oo9KAQWQM9VY3ENFNVbGc68
         ZS/QT1nxoneopX+kC5wQaM2JK2uOAdjWnV7Tv2cPU7ItBKKatohDufu50YS19AbhX2ep
         Lh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXyk6RG1BPGDU9NJwhOl2kUfe2XMppFu/R1x/KhsYoo=;
        b=SKt9qFt6vAT0Ge2Psweh1Q8Rq/jEmy9CCacyArqfA+mvFaUWCvDoI4KcqkMERIu2/B
         GmQ9aGwlxBcP+vBOvQqlzUH1Ac9qW8dc43GK+cRcLcWacOBTJsNbIc49Pvb+wSXkubYj
         lCrDIrWsvn2O+6m99wm6Ff435gbGZ3x8zkDgm68Awlp3znbqaFISOYnW0rYJbIFkmsKD
         1b7VQK5rCJGaYkvOV51CycINXtnjgc4mUQj52v5ClNBjAd/NQoU19y4DVIRJ1Ab3ya1L
         sAO+hn77X1MX12JRMAhBKsn1IMq3ZkhcyqxuprnCMNRhsYtBvXDy4Y/H+adYJYLrC78I
         0omA==
X-Gm-Message-State: AOAM531jiy2xlrOpbkHLgxCjbtiSG6qfj3bJSC5Gtvo3oRKs4qmPD+Jm
        OJn3WZGpKl0EindXQW7s5Ly/+QJmakRW8Du1
X-Google-Smtp-Source: ABdhPJwD6JWZnEAdMCN9ReYx7gfYXCW72h5Bi6kXg3q8NeQhCvbnQyajs0nH39hnZBYn9O9LtI4AQA==
X-Received: by 2002:a37:a20d:: with SMTP id l13mr23544549qke.83.1627419682221;
        Tue, 27 Jul 2021 14:01:22 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p19sm1870318qtx.10.2021.07.27.14.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:01:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/7] btrfs: do not call close_fs_devices in btrfs_rm_device
Date:   Tue, 27 Jul 2021 17:01:13 -0400
Message-Id: <27fa361288b46bcc0f4b1225f7c76c96ce6dbe5f.1627419595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1627419595.git.josef@toxicpanda.com>
References: <cover.1627419595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a subtle case where if we're removing the seed device from a
file system we need to free its private copy of the fs_devices.  However
we do not need to call close_fs_devices(), because at this point there
are no devices left to close as we've closed the last one.  The only
thing that close_fs_devices() does is decrement ->opened, which should
be 1.  We want to avoid calling close_fs_devices() here because it has a
lockdep_assert_held(&uuid_mutex), and we are going to stop holding the
uuid_mutex in this path.

So add an assert for the ->opened counter and simply decrement it like
we should, and then clean up like normal.  Also add a comment explaining
what we're doing here as I initially removed this code erroneously.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 86846d6e58d0..5217b93172b4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2200,9 +2200,17 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	synchronize_rcu();
 	btrfs_free_device(device);
 
+	/*
+	 * This can happen if cur_devices is the private seed devices list.  We
+	 * cannot call close_fs_devices() here because it expects the uuid_mutex
+	 * to be held, but in fact we don't need that for the private
+	 * seed_devices, we can simply decrement cur_devices->opened and then
+	 * remove it from our list and free the fs_devices.
+	 */
 	if (cur_devices->open_devices == 0) {
+		ASSERT(cur_devices->opened == 1);
 		list_del_init(&cur_devices->seed_list);
-		close_fs_devices(cur_devices);
+		cur_devices->opened--;
 		free_fs_devices(cur_devices);
 	}
 
-- 
2.26.3

