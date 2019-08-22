Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 899C999F7E
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391487AbfHVTLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:11:12 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37701 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbfHVTLM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:11:12 -0400
Received: by mail-yw1-f66.google.com with SMTP id u141so2850743ywe.4
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9CkSd9BE74+W51JiHMD0MEGF+qCN+/eIQz3CH+6fCG4=;
        b=MW6SxWJE7T0gbebkLEQCTmvnqNp2FF7ksqISSnR86yFmyRjxNNpwXJhKL6/pzjf8pp
         CvTByBVZyXs6fKXHsh5WIqSXItWrxvwAS69UNcP+kqGG8a+4LkUygZnN2l6lQsOvquT5
         H3yBgVuB8ccyhefH0CjjarxeIqLOydok7ea2cZhSJSCVxkmeSvid6zxK8zX2i74rdfc7
         qnHm918lY6uQLxtSXQCeUx2wyT8Ixh3u8imPqQTLEh67Ezztw6Bz4/8PAWI/bRmuyqMe
         6SfK2U9petHyDqvJKojwzEPEYITdG4ZSJBqVK9kZkmOLa6kkM+OAaLNepcJdjdX3URDR
         5uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CkSd9BE74+W51JiHMD0MEGF+qCN+/eIQz3CH+6fCG4=;
        b=PT85/9rqH05l0tEpd4MoacGbRQW6mt/kFQ5znn7mtJTIMJVsFUZhwOziRCDZuH3scR
         en1BlM3KT0JF5loG4qPEqzLUF2H15Tx/oW69XlcJzxGlLH9GmpCBgSPiSN0pIZ5UQFIW
         dKPcMAv1OZFI9x0dLQpchCe/z+l9EOeSCkzEgHFFVuR7/YuzZM8NBvYCW+/rzAdbIill
         Xkxm3Xlhf1j9B83Zti/8jYaUMbLFUPTAFnOmzmdN78Dat1Q3h4vhEoB/Lzo/hniQaICn
         7LLmWkBc76EO618yOrTf2xHOt+J0bPAtjPjxsX6SWzLM7YNH7pnsUnFX47AGuUD7ZguG
         42ZA==
X-Gm-Message-State: APjAAAXykgivGIw2NaA2mm8Yr5V64kqHY7S9yy05nDMn45JukHBFJtdQ
        5626b/z2bjcvgNyS+ALO28CdPv+OYBnttQ==
X-Google-Smtp-Source: APXvYqzttA9zp9dRhpk68KROHW6MrFVv1MbPRT2pLRDlvgEP4xKcVjZNnnQI9UPvCqB+Tb5znraq+w==
X-Received: by 2002:a81:94c7:: with SMTP id l190mr660132ywg.55.1566501070897;
        Thu, 22 Aug 2019 12:11:10 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t186sm108524ywt.20.2019.08.22.12.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:11:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/9] btrfs: add space reservation tracepoint for reserved bytes
Date:   Thu, 22 Aug 2019 15:10:56 -0400
Message-Id: <20190822191102.13732-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191102.13732-1-josef@toxicpanda.com>
References: <20190822191102.13732-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed when folding the trace_btrfs_space_reservation() tracepoint
into the btrfs_space_info_update_* helpers that we didn't emit a
tracepoint when doing btrfs_add_reserved_bytes().  I know this is
because we were swapping bytes_may_use for bytes_reserved, so in my mind
there was no reason to have the tracepoint there.  But now there is
because we always emit the unreserve for the bytes_may_use side, and
this would have broken if compression was on anyway.  Add a tracepoint
to cover the bytes_reserved counter so the math still comes out right.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9867c5d98650..afae5c731904 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2758,6 +2758,8 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
 	} else {
 		cache->reserved += num_bytes;
 		space_info->bytes_reserved += num_bytes;
+		trace_btrfs_space_reservation(cache->fs_info, "space_info",
+					      space_info->flags, num_bytes, 1);
 		btrfs_space_info_update_bytes_may_use(cache->fs_info,
 						      space_info, -ram_bytes);
 		if (delalloc)
-- 
2.21.0

