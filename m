Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEDE77C82A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Aug 2023 08:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjHOG4Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Aug 2023 02:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjHOG4V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Aug 2023 02:56:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3913CE45;
        Mon, 14 Aug 2023 23:56:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1bddac1b7bfso12671785ad.0;
        Mon, 14 Aug 2023 23:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692082580; x=1692687380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUgTpKvLzyEfVvT0eZucmMi0a2l4EEgYyV3ExMSDuL8=;
        b=DyCQX7K7aXm5ixAzvq5aQetI/7HwpOXEI8LvFhToyoRJ2Ry9rfb0wDBj/Q0trZRwgv
         ZOLDfLaSiyRKXIveMtrUCPdLzD+kzQ7RGKK2NtcReZcutkA3mlUpLEPYFWtP0EjeiBy+
         WWtic7BJn98TXC520HiO5CUD4Je/2jeo/mDOoNIBR6Rr2GHK8+ZPcpulDgJF2J14BR6J
         k9TQmeD+cnY8Y66PDcqhFsgfMadNRlGikWgAqmSWh3iVjuh5EvVzcxRr/3INyzYg/0Ea
         elxarFyrSUpt4EzCcwjWMOrmEHlqMHfz52HdzTTfGtrsRPwMd88MExbFNIqfQzjHxkMq
         K43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692082580; x=1692687380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUgTpKvLzyEfVvT0eZucmMi0a2l4EEgYyV3ExMSDuL8=;
        b=QdZOBzneZacz/0FNlx6lP5ANsKArkqI+hlhoPVyZe9WQ5JzZQ07YxN8E7Dat97jy0D
         oHZuys/or0zPNHdOGVHdtRGEXQV+QHc99k0nx9sTaCx7BwUJCKeTVxMGaMIIZ3lg0qU2
         WZ6Rfdnss50AoldPy+mHjTwSPbm8+aYb+nq5Dq+BglsNe6/a+XQ/CyzJrQkCiOnvNCNM
         eJT4dIBfzFsqtDw+89cwRM89AsVt//hWTry7oz47ldcU/qt/qDecMZtwugLUCcGNFlBK
         3FV1cdB9pUyosCwNHVJinqJW+LIH1q5L/EYXaY55eLKzkp6Ywq4jPrz7+2VIZs6tNjRi
         JwMQ==
X-Gm-Message-State: AOJu0YwzpAak7bBuPsDJiCIksVKUn98HZXHkn40KIm6pAO0IwgU9rKRX
        PmGk6Lu1mrh/sswrwc8eLbA=
X-Google-Smtp-Source: AGHT+IE9ZvbwgdO5tnXWt7EuPnDO5gAwrdtELk1VthVUpswLs7Bk81bzeNVuUMjHSJ+rnhONNpJU6w==
X-Received: by 2002:a17:902:e884:b0:1bc:224a:45c2 with SMTP id w4-20020a170902e88400b001bc224a45c2mr1640660plg.15.1692082579578;
        Mon, 14 Aug 2023 23:56:19 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001b9c960ffeasm10514110plg.47.2023.08.14.23.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 23:56:19 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Subject: [PATCH] btrfs: fix BUG_ON condition in btrfs_cancel_balance
Date:   Tue, 15 Aug 2023 02:55:59 -0400
Message-Id: <20230815065559.31546-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pausing and canceling balance can race to intterupt balance lead to BUG_ON 
panic in btrfs_cancel_balance. The BUG_ON condition in btrfs_cancel_balance
does not take this race scenario into account.

However, the race condition has no other side effects. We can fix that.

Reproducing it with panic trace like this:
kernel BUG at fs/btrfs/volumes.c:4618!
RIP: 0010:btrfs_cancel_balance+0x5cf/0x6a0
Call Trace:
 <TASK>
 ? do_nanosleep+0x60/0x120
 ? hrtimer_nanosleep+0xb7/0x1a0
 ? sched_core_clone_cookie+0x70/0x70
 btrfs_ioctl_balance_ctl+0x55/0x70
 btrfs_ioctl+0xa46/0xd20
 __x64_sys_ioctl+0x7d/0xa0
 do_syscall_64+0x38/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Race scenario as follows:
> mutex_unlock(&fs_info->balance_mutex);
> --------------------
> .......issue pause and cancel req in another thread
> --------------------
> ret = __btrfs_balance(fs_info);
> 
> mutex_lock(&fs_info->balance_mutex);
> if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req)) {
>         btrfs_info(fs_info, "balance: paused");
>         btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
> }

Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
---
 fs/btrfs/volumes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2ecb76cf3d91..886d667419ed 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4638,8 +4638,7 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info)
 		}
 	}
 
-	BUG_ON(fs_info->balance_ctl ||
-		test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
+	BUG_ON(test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
 	atomic_dec(&fs_info->balance_cancel_req);
 	mutex_unlock(&fs_info->balance_mutex);
 	return 0;
-- 
2.34.1

