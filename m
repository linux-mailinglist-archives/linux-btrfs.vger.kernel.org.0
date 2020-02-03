Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E763215114D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBCUuD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:03 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43764 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBCUuC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:02 -0500
Received: by mail-qk1-f194.google.com with SMTP id j20so15669949qka.10
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9MsgTvktr4YSMm81eVIl/XHloOcoHVfFseLWsJpfohA=;
        b=07GYTMSSrRbiCP28AnIjmkdKZOQKLMwfurlB+h7yyuz+c0Cu66e6U+YOjeFMeGrOjD
         WooYRxEixEDEhkaoHOZWK6L9o7GPH66b5Q5BZbFT9A9IFh9K0TckrgQk9VN4qQthnKp0
         rHulMQdV21/He/ZxgZfHfcUYTmSelFzFIOn3lDRFpI4ZEoQGEaVjfv8M4/6cmxQDan6I
         bEIyjh5Aqs2YV9qArCP/iQwccQehZ7JsQbBPl234u8RnfCBCnwp9taoNyhmRzpDcV35n
         v+XqtuV4CvSsb2IWOyvEtZAXxZ6zIQEt77HlG35HYNxc8qR6ZPycuta+FarQNthYHtkR
         HNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9MsgTvktr4YSMm81eVIl/XHloOcoHVfFseLWsJpfohA=;
        b=d1IyCpsHYqfCq9knfY4rzAQTvVsW1EHR87EXt7wzZD3h4damVFJsLsu4NxbaQLmhPo
         9Pt8mJvTsZULGgT0KmjjMxCy122UjR9JVez3KsC6tXT80yhRPSDlRP2Jg5VXxUiP3/B6
         fRWh35Q9zmotzv3ob0RflYclsYHgFlk6fWP3WFAj+fjg4fNe03GMSXG7ua8fiiQjTyAc
         qbAdKO+86XvBnotk9vACC5EJtrH4k2ubakVquueLj5L7U/b03FYY3e9v4lKPAbHyyesd
         6Ml1Yzte7AMkuoUfrykEmXZZpG0fqsj8cjCy1ZP9QR0h9flAZJBpDp9f+cDaYsX6Vk3S
         Ifcw==
X-Gm-Message-State: APjAAAVU15dHhKDRC7y2P1irIUAjd0p81SXVVxzZeK+aJVPzf8sO2lTU
        cabDREA0nWkOnnmFnv9vTc+ONS+Vp1XgDw==
X-Google-Smtp-Source: APXvYqwl4CParGFQ7mpQb0tjDCfFXpLAdDLut7xZR51uu93KO8JxvnOTvgI5qW+lNxJUSCr/kMc/+A==
X-Received: by 2002:ae9:e10e:: with SMTP id g14mr26181132qkm.430.1580763001209;
        Mon, 03 Feb 2020 12:50:01 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e130sm9870180qkb.72.2020.02.03.12.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 04/24] btrfs: make shrink_delalloc take space_info as an arg
Date:   Mon,  3 Feb 2020 15:49:31 -0500
Message-Id: <20200203204951.517751-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently shrink_delalloc just looks up the metadata space info, but
this won't work if we're trying to reclaim space for data chunks.  We
get the right space_info we want passed into flush_space, so simply pass
that along to shrink_delalloc.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 924cee245e4a..17e2b5a53cb5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -349,10 +349,10 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
 /*
  * shrink metadata reservation for delalloc
  */
-static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
-			    bool wait_ordered)
+static void shrink_delalloc(struct btrfs_fs_info *fs_info,
+			    struct btrfs_space_info *space_info,
+			    u64 to_reclaim, bool wait_ordered)
 {
-	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
 	u64 delalloc_bytes;
 	u64 dio_bytes;
@@ -378,7 +378,6 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
 	}
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
-	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 
 	delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
@@ -580,7 +579,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes,
+		shrink_delalloc(fs_info, space_info, num_bytes,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

