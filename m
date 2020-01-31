Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D610014F4CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgAaWg3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:29 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34167 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgAaWg2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id d10so8259570qke.1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p6I+xp02X/JD3iHfzrWtjMJkBBWxQ9LOIvKViwUqQCE=;
        b=vQlpdNptVqS1217P0utlHY+30aTu9pBia7qdsZAlfEAm5mz4vsqlz4oUPeoiAwAnnP
         4Ex/CtBTycoDaK+IQ1z0HnETirxvoMXbFztseoE/uly5+rkw+ccfruwSgJSmRxFpK2m+
         ZpBlFNGGGfZc/MhzDk9UabKE+DzkrBaqFy1bqmU4PlVJpPtP52heObhxebaqqnQlw1L8
         RA55in1uJn9jwn9ncDoZmJYGFIlortmEjbVkxmeeTDrxs+x+cGo7KuQ4ZhVBzMq7pkZX
         0cB+D0Aw8F+Vm0OzED6l1bIImbiW92Rso6hqq33RgoSBFfw9rKMe425o5xptUZL58FFh
         +30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6I+xp02X/JD3iHfzrWtjMJkBBWxQ9LOIvKViwUqQCE=;
        b=pxnQTaGMz3Vm/sGl14dY2WIr5XAu6NhkB0pFz/wqscorFAnjrr34tQaE3PZ8DNz4vB
         YdCRsrdrRq5wtWUlQ+O4drCoip7DFDfjEYUumZyo6k7CPiIGjTFXI9pY1Iln/jM0aNFf
         q7UbcCQMUBSt2ZbtWypc6DE3jcVx+pj4RhueXyz1BI2XvwbH5nUftPJU70SEVpNZPaso
         mHzvldivF54k78gsgEG5dZw5D2MCfwjp0dHDYGi8N/eqajDzIesO3NTwXuItKHORHPus
         kqtWw1kx2CPvzUQp4zZMafPhaKPboHOrVbjxuJfXeWohHC0qnx6/kFUa/gbeQCfwz3AU
         OCUw==
X-Gm-Message-State: APjAAAVhPG78Zw2klzRq/pozxusD2Ndokz5Ot/pjEHeb1giSukTFXEAC
        CSPsHzBdvSH/j8cqsqwAruJPsk5xoRxq/w==
X-Google-Smtp-Source: APXvYqzDCTDSpz9iuSGem+D2VS9YgUYHX3zhegLdgOlGp0aSW5pji10hO2Ufd6rUnALDFmhVgHQSXw==
X-Received: by 2002:a37:e203:: with SMTP id g3mr13104164qki.479.1580510187137;
        Fri, 31 Jan 2020 14:36:27 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d20sm5727874qto.2.2020.01.31.14.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 06/23] btrfs: call btrfs_try_granting_tickets when freeing reserved bytes
Date:   Fri, 31 Jan 2020 17:35:56 -0500
Message-Id: <20200131223613.490779-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
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

