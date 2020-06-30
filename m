Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D1120F69F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388765AbgF3OAN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388748AbgF3OAK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 10:00:10 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D046C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:10 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q198so18638851qka.2
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ur2leh3Ja0qBtgy0KaPVx6zXttZV5oVwu1hQROwoy9w=;
        b=zgoG1QNihlCYgZLeP54+qnc6bUpIrhXNjTpiRyGkArvJUO5231J+6bnK3SMnCI9BqY
         ecMKomGryi/ABobIK4ilhJp99qeiUTuN4+h5Ttq6Z6cv1UWL4hB8oIIE80ZcbZSDGjUe
         5kAraRIKKbQMKAJ88g19Tx1vggoacbWtSSYWONIqbj81IamZ3128R27W3EJYLNiluX4N
         WO2K+lRPvbyxWNRKuFw1+/9p5AwZ3jvsR4EmQVNmLRaqi1d57vB+gHD+p8efzerYjjsf
         u49Lq3bUFGTA9Er0H6ZVYU0ISwCJjDUDHYCjIt1DHSUCPbAx8IrooXabvSrtJ8Ddpxik
         vgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ur2leh3Ja0qBtgy0KaPVx6zXttZV5oVwu1hQROwoy9w=;
        b=Lt0QQnT+Y6C9AhtJYkmsdU56p8vN5cR+K93wPaiwxvMxachDD2cqvFGx38erLWSrtt
         CdOOPDaynRygcqp92eXmCPYDsE/UcGmfOu3A7iP6reJfiwHIgUv9ABqcM15oQ9EJb2Wq
         wop4OJ3n3XkP8PbAomR9nCrCNAvGW3eEPskDr2iC06k6kWnL8TKXo+WO4/p7t0894Sxz
         TKt6JbyDn3Z60jDc2+k3DygrX+KBdmOR9bqlGImpuKQa3XulAISvdiPIpucfoUw5mRBr
         Lp3wKI0AfLtiSpSQLQJ4jJz7okKi3Ov4+bbNrGmjlxr8iOBJY1S6tGxAZKz2EWhzrTMm
         pSGA==
X-Gm-Message-State: AOAM531pJZuOR3DgmgDatLZXxy2+KbTxIjgVocPYon6/jDxWilJYNwVM
        y/j6MTF00iATyGBzfleNU2vt6xno65mZfQ==
X-Google-Smtp-Source: ABdhPJzcXL+gXWqEH0S6idx7HdpRqYo3kw2z42zdsoz27Hi6Npupj7QwDVbp/JFnIJmTcZBJGNbmbA==
X-Received: by 2002:a37:a00a:: with SMTP id j10mr19315635qke.87.1593525608424;
        Tue, 30 Jun 2020 07:00:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y143sm3269520qka.22.2020.06.30.07.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 07:00:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 20/23] btrfs: run delayed iputs before committing the transaction for data
Date:   Tue, 30 Jun 2020 09:59:18 -0400
Message-Id: <20200630135921.745612-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
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
index 490dab7779e8..ba09085b6122 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1020,8 +1020,8 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
-	COMMIT_TRANS,
 	RUN_DELAYED_IPUTS,
+	COMMIT_TRANS,
 };
 
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
-- 
2.24.1

