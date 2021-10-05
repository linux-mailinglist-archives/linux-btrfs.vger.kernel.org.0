Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A10423162
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 22:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhJEUOo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 16:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbhJEUOn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 16:14:43 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F43C061749
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 13:12:52 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 11so436637qvd.11
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1d9aGHwglmErGqL5mxjgyRRDmF1Ka7ZDBTOZTS3pEDU=;
        b=ja+PP0/ijHmOoG+pcznL3hFI+Y9P1LVi/vyxDodUlxpY8vMnCN2AQDDJpRphbBJfQB
         Gj90X7v8P+GX+a7IPAsyFNx7fpd/reBIz06e+/MpvWtEAOgQJESVMUw161DLLghq3nFX
         ADnuPMWIUnimBoo2O/U5m/oVzn1mco26ff1tnEosqCPZIXvjBUHdDv0TnHF03Q+NZjg8
         eUKQ6AwGxt8nvdZA9GITKPYCD9BL9aNUg9rYxyGhodUojKhTAUMfFSLFkHzucCLfE4yI
         LLYX0saMEoS4dtotFbKxne+lLX8tbzVjTHfnQmj191nevzTHBP75rFRByHayrO7f/PQX
         sSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1d9aGHwglmErGqL5mxjgyRRDmF1Ka7ZDBTOZTS3pEDU=;
        b=Yjyr3zJQiQFEtZ/WvgglTcGifUV8TprYT71MJyNByTdKV8atGXTRVt0WRedMFAYsZy
         N0r6ym0N0YstK+JSQphqVjdupdokWarYiz6Zz7i6r2jgSZNapIWszATm9iX2FuxSkNxr
         Yp/WYQIGi6y6nv6V1NVx/vHlq+KWvQbF+2wDNU3i/RL0LqS+spcu095vm154QgyYZaH6
         DSWS92GRhc8FIZ5LySfllm2VGFKq2cIGzC+EvZeH0WoIbJD4cdbpQ/6bxuhH5ehsGUD7
         DF6XRUWuIrbLXyETuWVDxT66T5AmkFihwDhNq3jFoPCwDE+mL96EtOlevJLDlAhs8XGE
         whpw==
X-Gm-Message-State: AOAM533G8jCWoCtf1Jve/m8xo1sQ+Fq9xU2jVcLvYt1hWVBAlgXwO9Ur
        TCAgD/CSbqzmLk6YeBVX4jLC1xJffqHnjQ==
X-Google-Smtp-Source: ABdhPJyYdjt0V/jvc27ADNVx5DynjnPEGwbqDs2AS6/F31k7VkRwcIzyEjUKlr4a/zXprMF1+qEZpg==
X-Received: by 2002:a0c:b2c2:: with SMTP id d2mr31548664qvf.64.1633464771261;
        Tue, 05 Oct 2021 13:12:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v3sm10152301qkd.20.2021.10.05.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:12:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 3/6] btrfs: do not call close_fs_devices in btrfs_rm_device
Date:   Tue,  5 Oct 2021 16:12:41 -0400
Message-Id: <326bb4ecde587f0f3f4884b65d17951661a0ca77.1633464631.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633464631.git.josef@toxicpanda.com>
References: <cover.1633464631.git.josef@toxicpanda.com>
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

So simply decrement the  ->opened counter like we should, and then clean
up like normal.  Also add a comment explaining what we're doing here as
I initially removed this code erroneously.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0941f61d8071..5f19d0863094 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2211,9 +2211,16 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	synchronize_rcu();
 	btrfs_free_device(device);
 
+	/*
+	 * This can happen if cur_devices is the private seed devices list.  We
+	 * cannot call close_fs_devices() here because it expects the uuid_mutex
+	 * to be held, but in fact we don't need that for the private
+	 * seed_devices, we can simply decrement cur_devices->opened and then
+	 * remove it from our list and free the fs_devices.
+	 */
 	if (cur_devices->num_devices == 0) {
 		list_del_init(&cur_devices->seed_list);
-		close_fs_devices(cur_devices);
+		cur_devices->opened--;
 		free_fs_devices(cur_devices);
 	}
 
-- 
2.26.3

