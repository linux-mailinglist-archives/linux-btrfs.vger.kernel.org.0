Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE7151E25
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgBDQUM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36845 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBDQUM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:12 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so14759229qto.3
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ob65Y1fCySdjU3HzvYcTFuDZ/6jg7ad/NLvvq1Ek/Q4=;
        b=qAdj4lLJKNmqivwQrr1Ln8IZsSLsxKdWy4f6RQvfP0OyngxbvYNt18ON/JnQ8lRbr9
         6fqq+azwfZoGoy6Ofx2pL7mCkzfgNByRB6rwDtg4QWnASLP7IttyZXrKNCiYDA42XghL
         L9FRyzU7cYtLGzNy5P3Ru2/oG9g4o1S1AMiQUHT43U1gI/aeQY1zOYYNPX62hSW3yrEV
         5FtFsy9XFv+vS4us7LtnTBUqCzXMlKb04gA7vBUnjSIYXYrxIlY0ayt6B2r7zTl/Owty
         3p6qB9e8sCHZl7PNlxbMZ/5sRmJ6r6pp2JQLxXoNvmbLB1WBEx1pT3iukAH5IFIkNZjM
         0ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ob65Y1fCySdjU3HzvYcTFuDZ/6jg7ad/NLvvq1Ek/Q4=;
        b=W6G3kczCE5hlliI5Xfk72l3zLPcZggFCov8AurxzsDFn1LaxFbE4QUQM4spqSTSJ4s
         DxDw4F0RpZWeNkLRdElyy0oJ11XsUZSx/0hkIGZEkznVZ0M3vnMX0odLO4OTfkeDufVn
         nPT3YImF2HOxgdrQyC0P/+i1jleWd6TbTWJ+qbLb2ezJfL16CUQhy4wUQTj1eZyAr2T/
         fGq85BumOkT0fMbcWbCojn3BJb1shfLpB2cNyqrEqy+G1IkN/Yl4Q5+v4kKA9E/98RxA
         VvEzAvcwD2brfPEZKU2jbzX0HC3r9YHs2tUvBnluEO5JRPtmx8B5IqZZZ8x82gWcAt+p
         Kk4Q==
X-Gm-Message-State: APjAAAWRp40rSgkFpkWe7CZ3fdRPwXah1p/48wPuiFWkP062bO4a/MAK
        3MaBj2RAF2pQwgFF1mRD6JCHb1hgr6fUUQ==
X-Google-Smtp-Source: APXvYqx8fWdEXsyHvXkD1y74XlUEpusW5QCfuvTBXdzLgfYsX/hLcdV8rFOgsw+4kaRTihOhvQE24Q==
X-Received: by 2002:aed:3fb7:: with SMTP id s52mr28090568qth.97.1580833209264;
        Tue, 04 Feb 2020 08:20:09 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 2sm11280923qkv.98.2020.02.04.08.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/23] btrfs: use the btrfs_space_info_free_bytes_may_use helper for delalloc
Date:   Tue,  4 Feb 2020 11:19:37 -0500
Message-Id: <20200204161951.764935-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to use the ticket infrastructure for data, so use the
btrfs_space_info_free_bytes_may_use() helper in
btrfs_free_reserved_data_space_noquota() so we get the
try_granting_tickets call when we free our reservation.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delalloc-space.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 4cdac4d834f5..08cfef49f88b 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -179,9 +179,7 @@ void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
 	start = round_down(start, fs_info->sectorsize);
 
 	data_sinfo = fs_info->data_sinfo;
-	spin_lock(&data_sinfo->lock);
-	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, -len);
-	spin_unlock(&data_sinfo->lock);
+	btrfs_space_info_free_bytes_may_use(fs_info, data_sinfo, len);
 }
 
 /*
-- 
2.24.1

