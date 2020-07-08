Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0F92189B8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgGHOBD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgGHOBC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:01:02 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79990C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:01:02 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k18so4201658qtm.10
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xmiqq+ZSGW48hf2wB/mM0xQesV//E9KoAcumehKGgc=;
        b=qlTcLPWP2aaLK6gQMfqIPIgkLHBcOTliv0YRnitEmaJCaLppOT18QV4xseZJj3PHk8
         /MbzWH4oCmtP9V7pv5M3SFXqyIf/zAD54gxqeMK5XC3hzOFjR7Z3hREvkiQJSxU/tKG+
         gyNTXjbHZ7GjVQVWu+BmmEoKB1Mh3thfxixxs5AAdgzRT+QEAnDtkFPxal22pbMYEkUh
         mXcuzVB1Dqofor0SDURDhqNlnRghzj9diMKDtCokyoB8qnnqTIt782uGoxJZOw4mY5Id
         FupPWO6zbgWAkEHB5124s8D3zn6dPCTTJ+0R5AIliAmV9fGPd/315j5rRBqaFpx3arJf
         Q0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xmiqq+ZSGW48hf2wB/mM0xQesV//E9KoAcumehKGgc=;
        b=oeB+lEsADIc7cs4UIaQx8sAAx7iarjso+B8U2GuUkJuB1dDq9DbIBjAviWCFwaDGX4
         wUPq0BjaHtEaJfY6ZoxBWTr9EYu5yWpOcIXbMyWhYsQnF9LQvfXiGcXiQR+hUn70fj9M
         ncHTJoYTLDwXnqzx4HqGUNliFwOUbaHqNF05rUb600jopmulWeUQD0RogTtGUN5VfbDU
         YWRgFnWQDHoxEkPQYRwWC5G7ddgjTsXjX5L0BEWhlWy9i3Jwpkwzf09NRdvlZ0FkOuuK
         s6MUo5B5nGfoDKfsM0QPwsALTqQIwVCHm8cQPNbiRTldwtZ6c48qdi970zpfa0H9v4oX
         OvdA==
X-Gm-Message-State: AOAM531zVLRBrhwBJ9O3xb0dGq/g17l5Holnk/WF7mhdDFzSqPQbi7Db
        MUuhlCZ+hOuZ/cJkYSsReGVKYtPz7g88Lw==
X-Google-Smtp-Source: ABdhPJxYQ0sQmBqbLScS49yg2Q4Fgwqs0zcqm6aZHuYt69Vy9Cdw+jsNA6cRzof1YcrNm9IJj5V4Bw==
X-Received: by 2002:ac8:4c85:: with SMTP id j5mr63025678qtv.219.1594216861420;
        Wed, 08 Jul 2020 07:01:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w4sm31166898qtc.5.2020.07.08.07.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:01:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 21/23] btrfs: flush delayed refs when trying to reserve data space
Date:   Wed,  8 Jul 2020 10:00:11 -0400
Message-Id: <20200708140013.56994-22-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can end up with free'd extents in the delayed refs, and thus
may_commit_transaction() may not think we have enough pinned space to
commit the transaction and we'll ENOSPC early.  Handle this by running
the delayed refs in order to make sure pinned is uptodate before we try
to commit the transaction.

Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 092f3f62a5ef..fce61f800150 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1023,6 +1023,7 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
 	RUN_DELAYED_IPUTS,
+	FLUSH_DELAYED_REFS,
 	COMMIT_TRANS,
 };
 
-- 
2.24.1

