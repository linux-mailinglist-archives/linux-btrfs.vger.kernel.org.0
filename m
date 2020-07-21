Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733732281F0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgGUOWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOWq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:22:46 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97914C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:46 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id m9so9380883qvx.5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUsScBbpNuEa/GRgx27yvwOsrj7ecK3MJGcmAjuWUPo=;
        b=Y0SNBNCa4JNRvsVTYNYYPWnRhIkOeHK+BurvmLF77qDFhud4PIk2lGPOg8czRNLwNP
         QkbIJzixl8zpdJh7B+MKVN8crnBhjxnpx7WBQyrsOVNsChwOrF0hXH93BA8feW7OuZwu
         9iQf4Sp91N7z/aIj+hbHzJT5YjAzHDmvmycTs2y1Y4Ys0y58v0YdsQZLd9T/et1iQfdH
         MtKdtUbDAKW70xCTc6M6OCrAE7oA3fafFR/XQ50c48rm81lCxBbF/Ro5Xp8MTSjOBBFg
         QeyD1dlaygxzHASZB7R0mmm0dfNK3hvWuLNM/Pbll3rAWDQGkwseKfluvG5OkqW6SrTj
         Skyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUsScBbpNuEa/GRgx27yvwOsrj7ecK3MJGcmAjuWUPo=;
        b=KirQvf5alBT3B4eNZ2OrGdweRffX7hnhZXRTgzdQbirXFrrmbHh27gHHOi44Gdce2H
         YA9464XplRpHSf0VlrEt9MtTTBcXr/RLXCeIsHrlpslgSzUbv0PKu3s0UqQDgx21AYM4
         CW+v56AVN4+wmN+4sgbF2WkLcnof1EOUNf5oR7LT6Gm9J5TPDnP+Sunxxl7zyIFrCnwb
         hxcKwHE7miqK5QpXq+488EYGArffeCi6DTUoeRilUsmYlwoL1VvmgiC/O6Hiq+du3Rrf
         xDgAoO1fETfbsrgp5YzF2uugwwLrMgaWt2oAQwZKFwYIat8f2PoV/wGANannaRIzTIqV
         kC8A==
X-Gm-Message-State: AOAM532lm4CAmTpUR+J8cXufCgSAZoSod9rj3CKLmKCKuoXZe31I09zO
        qIcNdnAdqfkudCmPA4gMp6g1Qq4X7TRtFQ==
X-Google-Smtp-Source: ABdhPJxjOJ1iljgVmCxnOscNNRATtCRia/GNupuZTwDHAfjgBPUkQ2MM77LSYTH0nW19CSZ2OtIFSw==
X-Received: by 2002:a0c:b9a8:: with SMTP id v40mr27733429qvf.90.1595341365466;
        Tue, 21 Jul 2020 07:22:45 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h16sm2576086qkg.8.2020.07.21.07.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:22:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 04/23] btrfs: make shrink_delalloc take space_info as an arg
Date:   Tue, 21 Jul 2020 10:22:15 -0400
Message-Id: <20200721142234.2680-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 78ad8f01785c..1bf40328b0ee 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -516,10 +516,10 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
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
@@ -545,7 +545,6 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
 	}
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
-	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 
 	delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
@@ -753,7 +752,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
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

