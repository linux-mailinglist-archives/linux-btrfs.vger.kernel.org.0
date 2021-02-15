Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063AD31BBF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Feb 2021 16:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhBOPKw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Feb 2021 10:10:52 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:32822 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhBOPJf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Feb 2021 10:09:35 -0500
Received: by mail-pf1-f173.google.com with SMTP id z6so4355463pfq.0;
        Mon, 15 Feb 2021 07:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1CImeLkwCmEEWp5CqMsBNoPilXWNNUKWmgmftkePSYI=;
        b=aNFcVrpLXNPMOrahql/58bk/pewP47YBqgT7cs8HpuECMlm2LZ2e4rMTs+QGfFgbc4
         jMUGbbZ/HnnQ+68MZIbEUjx7Di5Wlhj42E+gVSE0kNDbl/Bb6BbGbNxHlKMhaLojHFh8
         GTdiS6eizQ0VmDgujTkISdGpgpNtCXNK11okXSrnUH4/mEMoVx0aABk4QIuyEHKevcEU
         QisUfXrZuZodWQ0Zkc4Msfw5DGXZhVSie3IAO4gfBTF/NDRdfdFV8GmoFJv9ukfyxwMx
         B+ffJjGtNX7MNQ6bFN6d6/dSSbmLXgu+jZGyLTChGF50eSM3Qt73GwNiuCq8UqeRd2DB
         0y1A==
X-Gm-Message-State: AOAM530NpqI0e0swvGGhB5zcdF+oDt2byqXB/1chWaQkt3v24QjIJK2c
        JTRcZHIkpeI3QQrdjzk2JDc=
X-Google-Smtp-Source: ABdhPJxVHgzI798sQiWyZNow0lQJxeuW8dcgHlp+pibazXyfCYuwnLiWe4PmP6GaejyEc1KRNmkMBQ==
X-Received: by 2002:a63:1e07:: with SMTP id e7mr3885647pge.376.1613401735053;
        Mon, 15 Feb 2021 07:08:55 -0800 (PST)
Received: from localhost.localdomain ([106.204.197.146])
        by smtp.googlemail.com with ESMTPSA id v31sm18635089pgl.76.2021.02.15.07.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:08:54 -0800 (PST)
From:   Maheep Kumar Kathuria <me@maheepk.net>
To:     clm@fb.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maheep Kumar Kathuria <me@maheepk.net>
Subject: [PATCH] btrfs: Fixed a brace coding style issue
Date:   Mon, 15 Feb 2021 20:38:20 +0530
Message-Id: <20210215150820.83069-1-me@maheepk.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixed a coding style issue in thresh_exec_hook()

Signed-off-by: Maheep Kumar Kathuria <me@maheepk.net>
---
 fs/btrfs/async-thread.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index 309516e6a968..38abeff7af69 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -212,9 +212,8 @@ static inline void thresh_exec_hook(struct __btrfs_workqueue *wq)
 out:
 	spin_unlock(&wq->thres_lock);
 
-	if (need_change) {
+	if (need_change)
 		workqueue_set_max_active(wq->normal_wq, wq->current_active);
-	}
 }
 
 static void run_ordered_work(struct __btrfs_workqueue *wq,
-- 
2.29.2

