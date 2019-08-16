Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA4903DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 16:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfHPOUD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 10:20:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33191 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfHPOUC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 10:20:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id v38so6293822qtb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9CkSd9BE74+W51JiHMD0MEGF+qCN+/eIQz3CH+6fCG4=;
        b=c9rmq9Iea8vpJNidfleuT0qa1INSK0/kWRw6UXyXTqIuNwA1wgKzTcZBgI3+5T5o8r
         0Eok+9pgIDyRzvJh5prGseUsgFaV9Gbhl2TdWunCIVlo8AA3qoXQg/mbHvfvSyocmnxd
         899sj/ljDFwL5KfPDSZRmVwo3Y3uO+3J+bvcJv1rjdkKCi831Q+speidTwZT3cz+R3CG
         888W36fRLJMfw0wWQFopDD/gzL/ftzb4S4QC7dJQdoCRXJWDtLgH9IZGNhdTvArVQTe/
         po5k00nYkmvKBkSVKHUd+8JFNjCXRD3Hg7bGY2GbhY9J2RQI35JPVRUL4BtLKASixOhB
         I/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CkSd9BE74+W51JiHMD0MEGF+qCN+/eIQz3CH+6fCG4=;
        b=emi1X05Ab8EAAOW+RRA3lf524tALVvOMBYkG+O/SmJ9gU7GdQTuc0H9I75WhPf2t8L
         X1izFBs/f8nvqIOa3m0HVRhMuAPICfRsWIGLnF2i7euhJ/zujX8KX4kKlKHEFV5I45+v
         TnifCIyoIiML5kCxyYPF5QtCktDkYs7bVUc5XVjnQTb9GOCJEfBtzu48YXvDc+S0YprT
         gMerIezAj75S3XzCngvK2hAInizERX7nChAUTLwtUKhOpdU8zjT+17Q+Q2LCh5uybXiD
         Mm6eX4X7EGsO/KigNK26Mtzlwg7ogTor55e7S638zN38Ui/MhWs/A40LRYowrjE2m/aT
         OjlQ==
X-Gm-Message-State: APjAAAXnPps66TvD+BKeMGpxtj8IVq/erplHcRUljyF1RNYxXeeCkfkd
        AodaB+e43/D2fTB/xaVJarA6LLXHh4JmVg==
X-Google-Smtp-Source: APXvYqwD+LZf+gXX6vygkZBOufu+m+Gc3C4+ckCjkY4nH0pSk9mfPMg4fIKFI9tPjBvQc9yhQVsN7A==
X-Received: by 2002:ac8:66ce:: with SMTP id m14mr8701304qtp.206.1565965201346;
        Fri, 16 Aug 2019 07:20:01 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e15sm2227018qtr.51.2019.08.16.07.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 07:20:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/8] btrfs: add space reservation tracepoint for reserved bytes
Date:   Fri, 16 Aug 2019 10:19:47 -0400
Message-Id: <20190816141952.19369-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816141952.19369-1-josef@toxicpanda.com>
References: <20190816141952.19369-1-josef@toxicpanda.com>
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

