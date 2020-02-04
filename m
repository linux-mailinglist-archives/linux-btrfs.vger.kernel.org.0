Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CDC151E1E
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgBDQT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:19:59 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46988 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgBDQT6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:19:58 -0500
Received: by mail-qv1-f65.google.com with SMTP id y2so8775738qvu.13
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qHlqhZR2+xy/v6kOuoXk63LhEPtdhUPqVbzT4gnSw6w=;
        b=XaN7L9bemfXxcXss8+9dc0sVaOD0RP+x2X8L0tUHXm0VQ1myHqj4yERVE04yQNdj2y
         XCG20LPRleaEw++cwmn5mKdNcDotWaDpPIssjd7pkXMkVmbACmvtbZ7BpKgoO8WxxDPK
         muZVjpdFfE7FB18O4tgAVXX/+A0LyRc7GzuH/wVS9f8UnRHvgX7hcAnZInBoElzgXpV8
         k8b2P5OXneCA3IcB9rlMRhbGntx5xCOx6h4I6ps5hM9BIrGD+6huRjPChJwYN9sThLwn
         LNyymnvpaoAc/Q8Mtfxp7rpBR+P0UMEaNdyw2IQZMttVdu7dw4P9+jzsR79V0hOPrqRA
         clUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qHlqhZR2+xy/v6kOuoXk63LhEPtdhUPqVbzT4gnSw6w=;
        b=XcDmj7LgWbtaJ73PlajkRbk8g2l19YF+zfWlLE/lDz6IFzc9K/o4c8jB4w4Lx+49fA
         k6aXFqdlLz5TW3yLO9VO8aokFdHWjimbD5ro7p2SwhNQIn5ewizDdrgM23DwwEE5TVUn
         X7AJSthLk3Prfle7fEwOzVcloRabXXIJA1as5Kk8CFFg7HIokqmYVEzqtYnKwkW0LidG
         G+kJzfmhbTKPt5afS7hWfCQ4lzYk2cX8v5NhjzqxcaZAQYa1CnXB6yqf+p/YcBw+u0bD
         uiV+7/8YtI81h42Ye8dEXhkQfKnpboesmqe5xteI/e+YjG4I97r7HJApb7OItJ3QjNtA
         M/RA==
X-Gm-Message-State: APjAAAXlXVxt8cNVqCK3JrukknBI7rsKCA9NmdDKopXDp0C4kARcBS6P
        ydGaEgFnHGTbedi6MzZ8XkgXUJqRMur98w==
X-Google-Smtp-Source: APXvYqw4m6/u7xznDQ3G6PhqQuijPd7SuQPJ+7Nkhqjx/QJi7+NIf2+pWniLqd9MNZipTrrNdO6oXQ==
X-Received: by 2002:a05:6214:18eb:: with SMTP id ep11mr28421010qvb.91.1580833197487;
        Tue, 04 Feb 2020 08:19:57 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r12sm10981038qkm.94.2020.02.04.08.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:19:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/23] btrfs: remove orig from shrink_delalloc
Date:   Tue,  4 Feb 2020 11:19:30 -0500
Message-Id: <20200204161951.764935-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't use this anywhere inside of shrink_delalloc, remove it.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
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

