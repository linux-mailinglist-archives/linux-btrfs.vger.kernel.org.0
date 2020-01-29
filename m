Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD8914D404
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgA2Xun (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42611 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbgA2Xum (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id q15so1172561qke.9
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8VM6SIzwrBod58dzrRyCte/u82JQ98JLp9eD5ZNrdc4=;
        b=jihd+PuUV3+MSlJgZF7jGHVsFrKgXRARVy6mfEu489UsKWAuUvrY3xLlxb1RZPSN9a
         DPD2cIrA9Um2Aq4wD6ApWB6biJX02tjolJIpvwrpr7R76tp4uC/+x1JlmgxVDCdQ6AcT
         xTLzC4taartmSwmJIuO+Sswh23B7W+qDKXQCPvnFCK25K+Uj1WBuBhNNVekobzodO2SI
         X9rVa2+gfmcyUAgZjITWeN+3elePlU0AZiplTBVJ51iBaa4hprGyEJE7RAzL+5JqBrkA
         b8YEghJoy5A0ELoNqKau+f7HO+fCjBx4OV8Ii13KwRXLgr5pR12uFWuDo8pa/s+6pOaz
         E7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8VM6SIzwrBod58dzrRyCte/u82JQ98JLp9eD5ZNrdc4=;
        b=ifgUJqASxMitt33ZPDgs6mXoFbV57eWZhuA5Dz717yEGwudS/Yl0VrpWP8MC5N6f/T
         OqkI8QI01HPL6s3ZwQycnNohb8ihILBQSniT4AuSqbjEGYTUypkV/5JBSTTgJzqrte8Y
         goTwS3EtrBrvkGD3rK1if6ST+B/YmuuFA0Bf8AJBm7OIl+j0PgkL4yTxjmO3lrofKakO
         3BgTVS3d80DqUiTCws0n/cPpef4NWUuggFCAbZ90H19EEQnrJyn8vYqlPgLwRFeu2UNa
         mqJvjt8Ese0g0jxX4qQRzTvyyQkqllvs5J8SVytTkAeyeeWhaksX7RzVL7u4JLyOs+Kc
         RGLg==
X-Gm-Message-State: APjAAAU9sPhv4Qi6xozRRecymMjegUrYb05KCKfTOhwaWodnduyf3FDP
        M7uqNHdrTujYdUuk0ZHuFguovp2ZKwuBag==
X-Google-Smtp-Source: APXvYqyHNLviIVVMA4cYE/9qfSm6KxjnE4GTytOH3b8d7NSsN9/mo6QccJOrQnIc/pYX7RRz4EMrEw==
X-Received: by 2002:a37:a085:: with SMTP id j127mr2403575qke.89.1580341841088;
        Wed, 29 Jan 2020 15:50:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i19sm1741127qki.124.2020.01.29.15.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/20] btrfs: call btrfs_try_granting_tickets when reserving space
Date:   Wed, 29 Jan 2020 18:50:12 -0500
Message-Id: <20200129235024.24774-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have compression on we could free up more space than we reserved,
and thus be able to make a space reservation.  Add the call for this
scenario.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 616d0dd69394..aca4510f1f2d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2899,6 +2899,13 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 						      space_info, -ram_bytes);
 		if (delalloc)
 			cache->delalloc_bytes += num_bytes;
+
+		/*
+		 * Compression can use less space than we reserved, so wake
+		 * tickets if that happens.
+		 */
+		if (num_bytes < ram_bytes)
+			btrfs_try_granting_tickets(cache->fs_info, space_info);
 	}
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
-- 
2.24.1

