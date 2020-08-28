Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF11255C58
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 16:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgH1OZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 10:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgH1OZB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 10:25:01 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A0EC061264
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Aug 2020 07:25:00 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m7so1057308qki.12
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Aug 2020 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kh1Zh0CHISJ7AbPsutOT2MBEMVkJlWxRaQAmkyPA6rI=;
        b=1SxsjhiGM16MJ20ZqF8EVxjf+PPpkGzSMU0YUgt21623iRBqfQXMk0gECWdNcxpPot
         2nHL5MnhmLPfa0WfSw9SQEuw9NEZyCf5PnxEjl7K/yI+JCBg2GXOCTdbD8qrA2WNK87b
         3v3x81PLDoRnKSofGyah0qLMBW6Q/LXDFnbqdK0f4bYryO0jdkOWULRSBOx0PZ4wC/am
         aUQ9BYmRVjtMibr+s2ReJT/87jOddccU1u4cXx/qeLZ0W1xgPF/76fgh980ICXyKvuf0
         Z6UEHINiC5K2+7rDcwIWb3X4mx9xg0NmidBAU/En2UBKTckj3sDip8SmDy/tRMNWgCBX
         58iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kh1Zh0CHISJ7AbPsutOT2MBEMVkJlWxRaQAmkyPA6rI=;
        b=bqJfbmqHtUHheuI+DpsS9HgVE+yWbIvYn6X5cI5NtS8imKpesWFOEGvnIgnN/NAMBc
         vw+GaknH47FvohzU38yvGpGJwXk/KHBYruSIol1kXUJdtXn5sBaSSfHAjaCtBZTYqPDR
         4xKXIwJlAgnuUH5eYbps46xWiQ0VA11uuvd/587cv62QMHTfrxl27dEsZs3S9pEQIkgI
         +MaodY7RRC3fnMiR50rl3AONpZburNIaDidI+D/aV1S0UIQ6NG7izl9Rd1KiVeKjvQJS
         uiXgYyCgSAe6A+bV6ILGvbwTFXfte536aVYPHC+OVB4EAMh4YSxRhsH++F1UpzgdvKyf
         3wyg==
X-Gm-Message-State: AOAM531J0k9drrO2L2eUk/p4J/W+5DKsE0mzsvoIJpmHxfrwz9mwqvwv
        Z6S1yGbkfXOb18J20W+7v+TH8mVWzCkN9I+G
X-Google-Smtp-Source: ABdhPJzgGx9/YA2geIrims3u9O8vxZSkZbw5hRyM8B37FL+abg9JV5taHkT3ysQLKwG/8+P2q5DeDw==
X-Received: by 2002:a37:ac14:: with SMTP id e20mr1467171qkm.85.1598624699716;
        Fri, 28 Aug 2020 07:24:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v136sm898957qkb.31.2020.08.28.07.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 07:24:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: hold the uuid_mutex for all close_fs_devices calls
Date:   Fri, 28 Aug 2020 10:24:57 -0400
Message-Id: <e45e00c3d31286c86b76693262266e702ed7f1a3.1598624685.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My recent change to not take the device_list_mutex for closing devices
added a lockdep_assert_held(&uuid_mutex) to close_fs_devices.  I then
went and verified all calls had that, except I overlooked
btrfs_close_devices() where we close seed devices.  Fix this by holding
the uuid_mutex for this entire operation.

20cc6d129252 ("btrfs: do not hold device_list_mutex when closing devices")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6f489245eec6..3f8bd1af29eb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1183,13 +1183,13 @@ void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 	close_fs_devices(fs_devices);
 	if (!fs_devices->opened)
 		list_splice_init(&fs_devices->seed_list, &list);
-	mutex_unlock(&uuid_mutex);
 
 	list_for_each_entry_safe(fs_devices, tmp, &list, seed_list) {
 		close_fs_devices(fs_devices);
 		list_del(&fs_devices->seed_list);
 		free_fs_devices(fs_devices);
 	}
+	mutex_unlock(&uuid_mutex);
 }
 
 static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
-- 
2.24.1

