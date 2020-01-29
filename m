Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6399114D3FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgA2Xud (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:33 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37737 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2Xuc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:32 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so1212738qky.4
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IEzvLPaDIC9yRtkkIfSSU3Y5Q8uz3ENFeMNRKC52Soo=;
        b=L688Y38ORtLTK76GeTJtxevZCX3dlWHz+fiAyhMTV1gYnCMMtmZzO0RhAfhjGuL6ex
         1xnprSO7wMIjDzLj7CUsSNcKX3FOREv1l2xQ6XRFpG152kiuo6hdUVbrpPU4HDo6dWVB
         ugBsWCBlWISjKRBPp9y1x4+2MYfmf2jViYrx1gmyscT6iAKU/D/lxyS7GX89yAveJ24X
         YloTTq5BCDqKVt/NTwd378ImiV3w/TIzFgkxj/nMT6Uwcgg94kTa67yd0PburN6Jr9qb
         F/2FOBJK2NRJW2roGmzlG+LMly0jYVCgACFd3B1evIUibfu0KlgLByZmjX35IX7fthPd
         ft8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEzvLPaDIC9yRtkkIfSSU3Y5Q8uz3ENFeMNRKC52Soo=;
        b=YTkgxkGeBorL3EfNLGOszdvXL6eQtx/OybLqvIeqlgYKtbQTKfvQ+C4LWGz0/WY5P0
         FNSoEB/xYdHJx8mxCi4HDgYLplRbQZiiwqR/zc4P93UbOuAxJpXyIrWdYkpfk/AthBan
         DJGoITQ4KiEmiskfMphUidtQvgxUJRQa7T6iHnfdTXwojuRXvKbRcSQIX+mdo4gVHTPZ
         jyi6vn8qA1lmkRbESBo4G8AXQEk33pqz0UnKe085xPnbRl9SH1A7c0rxTpXei0w+0Hnm
         ZuSr92gorXNPZ4xu0uEpGmsBFQFbeFABVT5/WOpuw+RRAFDeDjrZJ94L/IL/u3Wgq++5
         PIVA==
X-Gm-Message-State: APjAAAWsqEPN6F6GmHy/5kdMK8JoKCP7+wngFsRXFRkuDJ29G14ofMIK
        GJffOmzDfD6Tn8GWU8ID+P2u38Ro/GGNkQ==
X-Google-Smtp-Source: APXvYqwMhULgpZuna8dNVdX7u05tfnu87qv4bN2NtcBu2zQUnC5TXzkKJlNFBiwTklyjCzAGNgIUGQ==
X-Received: by 2002:a05:620a:2218:: with SMTP id m24mr2578228qkh.442.1580341831394;
        Wed, 29 Jan 2020 15:50:31 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y26sm2016651qtc.94.2020.01.29.15.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/20] btrfs: remove orig from shrink_delalloc
Date:   Wed, 29 Jan 2020 18:50:06 -0500
Message-Id: <20200129235024.24774-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't use this anywhere inside of shrink_delalloc, remove it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index edda1ee0455e..671c3a379224 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -350,7 +350,7 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
  * shrink metadata reservation for delalloc
  */
 static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
-			    u64 orig, bool wait_ordered)
+			    bool wait_ordered)
 {
 	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
@@ -569,7 +569,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes * 2, num_bytes,
+		shrink_delalloc(fs_info, num_bytes * 2,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

