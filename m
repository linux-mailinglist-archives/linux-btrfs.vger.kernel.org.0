Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC3814D402
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgA2Xuk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:40 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40271 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgA2Xuj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:39 -0500
Received: by mail-qk1-f195.google.com with SMTP id t204so1190131qke.7
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lHuaXplm52whMq5dhm44y6ojaOd486dtd/BXWJ5zxQg=;
        b=zp0EeuLA0OjJdkJ6LrX2xnMkKnP1LZGcLWzCX8daSXtDOMcLRIGAwm86l96nMAuaCU
         3BW1JMymexdbDBYXgVyyWJScOIi4pYiUesWqyZWASx0ZMOUS3jYik7ShOkIUIZ8KvMws
         eU3b21F21NB4+NEgF5YNybKJAKcqK8mo9R8T7O5gmHimILRbC0jcpxrL0kHZT9XTUwJA
         u6mypKMm7QTPlhlYCcnIzGP9sKPTsSI0lj9RfJGXA11i26W1k3msHMfkDD2h22WMHQgC
         q0xat/dTM1jOtqoyaUFwqa0XR5PexQvQpMUrxaa5126kA8fvxr7Gh7NPqsYga3wKY/Dl
         gwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHuaXplm52whMq5dhm44y6ojaOd486dtd/BXWJ5zxQg=;
        b=mXtlQUxv8c5R9LCe/DO5bpeB+XWXljn8TvvV7ucACj1FJKM1fI7g5V1Rv/Ibhp9+8F
         v+ObX2ewPW7VF1KHeRwImnCNWzyagR9JAjG8+VtRyw9yrWW2Qs/8mN6o5GaIG5L52p0k
         7uO4TUJmBRj65y8HRgBmbIHOhnu9K1avk0oNoyxIHReDn7TIu3e08M4PQe/nxucgDFL7
         yx1k/clH7/dYFhZY87WvBm9XZLT7b4HiGzE6FBPF3IPUkRcGire+TWz5xH12WmRs908j
         bSjcUYO/JJ4PSVv8WjZOnwHbW71Bcx+rUVtU91mZBqRsKaHkG7/uhFVbEsk5kbtXORWn
         M6GA==
X-Gm-Message-State: APjAAAVPqAoIBHIg7h96dIXtWZmb9OFKgwWynnDRoVRSIK6brOXwToky
        DZl84LaEyYF3VeggfUYY9yvV4MtI+EjuRw==
X-Google-Smtp-Source: APXvYqwO65cO43ZekYgF6QuPGNvPlaVfU116Lbiv/HtMVIariqMEE4RAHsMWqKSo9UokZGjTivc0Lw==
X-Received: by 2002:a05:620a:218d:: with SMTP id g13mr2604412qka.286.1580341837944;
        Wed, 29 Jan 2020 15:50:37 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h7sm1864705qke.30.2020.01.29.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/20] btrfs: call btrfs_try_granting_tickets when freeing reserved bytes
Date:   Wed, 29 Jan 2020 18:50:10 -0500
Message-Id: <20200129235024.24774-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were missing a call to btrfs_try_granting_tickets in
btrfs_free_reserved_bytes, so add it to handle the case where we're able
to satisfy an allocation because we've freed a pending reservation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 77ec0597bd17..616d0dd69394 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2932,6 +2932,8 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 	if (delalloc)
 		cache->delalloc_bytes -= num_bytes;
 	spin_unlock(&cache->lock);
+
+	btrfs_try_granting_tickets(cache->fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
 
-- 
2.24.1

