Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4BFF14D40A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgA2Xuw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:52 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38780 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgA2Xuw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id k6so1201064qki.5
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iCdztqJ7OJaNXdfA+GKq8vonfrVyx1k2w1vzCYv+w7o=;
        b=ThDqXcbWvEOzDi60tlZyziU4WaXPHld7sFYWrbe/sZkcCD0tpWF6d09jMNDkJwY3lC
         OL9n9yHLER4Y1S1s872pDgcjV7Lo+HUaf+ganiE/f2AHiU60X4KTMDGfFOUpa2KM4lN+
         koCuxShAWJ1Zsvtrj/5uCyijvIiotgti1+kJSyiRil/B76onDWVAsHMaJzaBeOIhmVP/
         DEpYnp1hQEEvLdXQXPl1KFwCoLlShIcuMJFgjCbF2M7K6GqGbvct4BSDpxgMSzAxUShX
         20LeF1Ca56wLBIvzxi+FI6XCeGPu8nc3s7+4W8D6i8cvsPn5tF1pnVmP9NnEX3JVKmQH
         A7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCdztqJ7OJaNXdfA+GKq8vonfrVyx1k2w1vzCYv+w7o=;
        b=PWORG3y/8WNP0gqh2BASwUR8JpBHZqk6ISjxNsPbePwLx1oZIF/596fTNxNceSjEE0
         SQNXsaMdFNUYOBbigIIqAQotsNiVnVPF1EWg0Gd+9VzZHdqZ0md9aEW17r891agxHJ5m
         OZNguBUS+igOAYM16GgsADx+afyPXC6t8qLeF9RMlDNYhA4AsjCLVJWhLVExfwjAHdjM
         VugMdm9dO0qeyvrIz9SrGkczUkrTyh0fXanTHwN/7caSY55G/qzS9uONmvLtLmt7PYux
         ICEDE+iOMBAyoPHPuLp8OFOtjiLMhZ0WHTWI1tQcG8jnIVsi9NI+pCZ0eVW3oNUoQAhw
         fRLA==
X-Gm-Message-State: APjAAAWngzWtPU+XkmTsvLe/s65FEd5I1WTGzZgHGaVqEbA3OnOOd4vC
        SKi5VKu1VK5qI3NXj4Rx5r98KlDa3is1hw==
X-Google-Smtp-Source: APXvYqynke/qebwPu+X3XT2NHxkj/rgv4Nt+oWMht4tq8kE55gkVcwrjmkZMH55FbvBIKvCaytW+Fw==
X-Received: by 2002:a37:91c2:: with SMTP id t185mr2374430qkd.284.1580341851141;
        Wed, 29 Jan 2020 15:50:51 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z8sm1980584qth.16.2020.01.29.15.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/20] btrfs: flush delayed refs when trying to reserve data space
Date:   Wed, 29 Jan 2020 18:50:18 -0500
Message-Id: <20200129235024.24774-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 03e8c45365ea..520c91430f90 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -858,6 +858,7 @@ static const enum btrfs_flush_state data_flush_states[] = {
 	ALLOC_CHUNK_FORCE,
 	FLUSH_DELALLOC_WAIT,
 	RUN_DELAYED_IPUTS,
+	FLUSH_DELAYED_REFS,
 	COMMIT_TRANS,
 };
 
-- 
2.24.1

