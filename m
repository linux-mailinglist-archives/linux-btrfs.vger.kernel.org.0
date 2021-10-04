Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE48421512
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 19:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhJDRVX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 13:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbhJDRVU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 13:21:20 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FCEC061745
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Oct 2021 10:19:31 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x9so6397841qtv.0
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Oct 2021 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1d9aGHwglmErGqL5mxjgyRRDmF1Ka7ZDBTOZTS3pEDU=;
        b=tOUbrNcQlBWswQGOZTotJ/c9uaDuj9WZeS6Ebsoyb5eX2bVW/yre69scmuqNIHk+6a
         /JN8cIh2VO1tqgEmh16j1Ewo0ycPC9s3bAjkWPtYXU5t/EyoOv9UkNc49sO22rSNXOCF
         mk3Hj6E3qSOVoeszj8orf9A53SJ0HkTTZIh/YHr3q2G3J4gdCjt/OR5xaufTAHJCORQv
         d65EDeEYZXrFxxs6Fhh/k8Z0TgW1ishOtGoU2CJEfSanQOhVNVF7dyfz5GOyk1790RLd
         w+RJVRqrWeZXyT8q4BsPABEqRweyt6Cj5mGBpyhAwZAMpmfuIPm1tg9UuPM1BPvIQPoE
         uGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1d9aGHwglmErGqL5mxjgyRRDmF1Ka7ZDBTOZTS3pEDU=;
        b=hm3wvsZ7vaXf0BkNsVIoww93QhG9TrAu1WEjwAp98+TSNskMUITT6eYZi+ksTaQig0
         /RSgbpHcUx8bn+ssrEhP6o81SnoivhPKXl4424Cyy4rr4hBJL1gQHUxo0j8LAg3viE/E
         2z4J0Yo3/sioKe2G+n6nEngbFe9M3js+iYEkHq4MlwmglA/NeyfBxeHfdYSffx6k56ad
         Hxvif1eMmbScuZYl0Y25lvepEZTOzROEZSFoV+l/7lu5+g9VHOntwIm2DuE6FHc51ex8
         5u3vaQU94RC6dv+v9Qg1d0pa2sL+TTqMXe9F0FAQVa1IaJVhprO+lVIpe6cpz+bTDhGl
         ZQhg==
X-Gm-Message-State: AOAM532V1dY0O+31zH1meQU2dq3I17ijj+//JxIZJyIa87GbwPV8ecwo
        /6BvOELQDQHgfyJqoWjLHzyTb3FiRK7Lgw==
X-Google-Smtp-Source: ABdhPJx7kmvHBHmeMScu6wNOk9T3Sat/upYhguvZXKcdNu7a/UKhY6rV90rUs2Fx5OIOWlNrWBhuaQ==
X-Received: by 2002:ac8:4618:: with SMTP id p24mr14514411qtn.24.1633367970566;
        Mon, 04 Oct 2021 10:19:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k16sm9403158qta.27.2021.10.04.10.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:19:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 3/6] btrfs: do not call close_fs_devices in btrfs_rm_device
Date:   Mon,  4 Oct 2021 13:19:19 -0400
Message-Id: <326bb4ecde587f0f3f4884b65d17951661a0ca77.1633367810.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633367810.git.josef@toxicpanda.com>
References: <cover.1633367810.git.josef@toxicpanda.com>
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

