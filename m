Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72CE3151E22
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgBDQUG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:06 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39463 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBDQUF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id c5so14734460qtj.6
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5TzrCut3e7LtajYQ7nNJKIW30/wD+NUmBWxzDxFl8M=;
        b=fSZOWjrEVa4KL0jOdnzuRywpkSOFO2xhyANd6LODNxceRpZv5jY6/pHbo/3XnRKkuw
         cHzlGUtskbn1strcJObqDOFN5Mephlmxu78XdEAUGBOilOFZM9aMsGzhDQTQL1g89r06
         F/ttJ2crfVyDQTB1xKyMYy6a9v/+65aw71OcIM/rVHMfLP52y0qXbsh51BL9r4HhlHHl
         yKm99WTjj3S/e6zTnu1ucYuLupDZDWVCNdE92Zv4atfZRghuYVhgodGei1b8xoubv64+
         oj6LilrDQF+/c/3sTHT8NUc6VVqvdQUT+T1TDa6uF8A4CvzlWx+lWS/aSGvewwoxH7YH
         OVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5TzrCut3e7LtajYQ7nNJKIW30/wD+NUmBWxzDxFl8M=;
        b=GWqkOy+mG/zEeVexmxDG5q9EPu0iJJn3Dn0Q1BZgGewkC7f6Vwp9CIDXSnQjye0SQO
         i/Smkk6dNGiJP+SfmrG6ZCSsOQ75YTbIy/rHnY0JwdqA6OmbFdk5hXqKj0K1wPgbi5Rk
         5bvcOEiu/hn13tpuAEyIrL6aUGm+slqtO4WcGE8KpGUJfmjRcOqt4w7zcrQRGdHHtpfi
         toyeHAfk9mwvy4CXfFY14xYt05CI067ZRKHj5uLB9phq77nn3fXZMzNIo6i22fwnNINc
         DCpdK1XFQrM3c9GkiEYaxd517jT3fqADWpUyG7eN6fbnBxV75ZvXDDNVdBiufBiIG68J
         WOWw==
X-Gm-Message-State: APjAAAVzbZeyQvFisbhcmyBCVUamZS2GC7k7iRKx+FWPRFqApZUM6KSa
        btXLi4lT0lqMbBSU4c+DCuGmrCG15h5QgA==
X-Google-Smtp-Source: APXvYqzxO75NCqrxepa9cfgcE0BDlBMZg5BQZztfm8rHjaG2ZTO/T1HxUeOUJB1krQPaPJl7YJEHDA==
X-Received: by 2002:aed:2e02:: with SMTP id j2mr28470613qtd.370.1580833203893;
        Tue, 04 Feb 2020 08:20:03 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y197sm2531649qka.65.2020.02.04.08.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 06/23] btrfs: call btrfs_try_granting_tickets when freeing reserved bytes
Date:   Tue,  4 Feb 2020 11:19:34 -0500
Message-Id: <20200204161951.764935-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were missing a call to btrfs_try_granting_tickets in
btrfs_free_reserved_bytes, so add it to handle the case where we're able
to satisfy an allocation because we've freed a pending reservation.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
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

