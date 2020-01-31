Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35B14F4D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgAaWgi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:38 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45422 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgAaWgi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:38 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so8186731qkl.12
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tvdnCxP2qzDN2fH1vgdT3kTHfzo9HmvwH2IHfqMpIPU=;
        b=xwXFLlWxc5PGbzaSCD01jS5qADpmGDnZbae92feEPmSKgMKZ6P8igWf9hLwkG5z/wX
         Zci9y9pnfLtT5UwBP528F94rd5+RpSckORzm1n7hYObn/duWyPcDCeUcekpXCOq0D9O4
         CUCkHKM+xXYXBUA3GL6p+v10OPoyyeWfQCDX7fBFKav+kgb/kClpaHjNImoL6g6HbxTf
         g/jPkW5irToCDEaeKjdYVqq3CpqKR2zgcNGgzW1XkgRyckwU83ENFZ7xp3viw5Gt2LYA
         TPz61bka1YtY5+J00DirYhRAoYsL89kAChEb7uzDAk2z5lNYpard1YGFf6pcNPSHYoqH
         qDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvdnCxP2qzDN2fH1vgdT3kTHfzo9HmvwH2IHfqMpIPU=;
        b=aopLATMs88Fa0HG1Dka8VPFmvzt/kxaI5139uysOvZaDGdgIMHH9BJM8uKu95qIInY
         PNqgRg2Nw8IUDyVjLMv96YCB2LyJkx1HBUY9PDo7vPNVxxSbo644UyQt/QPNpaKgckyh
         xe/DtbCKKAjFO0hqCixwpqxmJns2WD8/UKs5HuTJqVl5uZt4rIaSCYvkmocS0NVnkNNZ
         MRNPncDz4DwnLOuvSy2nOkFNiKy+tfjH4igBz7Q5DZb45/i23bgxL+ljQZHeAXfR2mja
         eUWHrOyTWeYqdXOEiI1KR9x3xB5oZAI9jjwA0SxK1IsrM3jw1H1/RnaAUe7CvDT2A/BC
         MiLA==
X-Gm-Message-State: APjAAAUqp17ypFkOkVRFFtFi9KvOSHdleDB59oB07zQPbUvR67P9ik5k
        peMfpue2prl94QjUNdn4FWAiUmEvUKk2ww==
X-Google-Smtp-Source: APXvYqzFHuEjf07WmtuUR+2ss3k1Uyi6iQ+VvywgQo+nPQA0uZ3uwA+JSgY+kfudTp0AxY7Ev4DtJA==
X-Received: by 2002:a37:a183:: with SMTP id k125mr13005297qke.381.1580510195638;
        Fri, 31 Jan 2020 14:36:35 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n25sm5074188qkh.88.2020.01.31.14.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/23] btrfs: check tickets after waiting on ordered extents
Date:   Fri, 31 Jan 2020 17:36:01 -0500
Message-Id: <20200131223613.490779-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Right now if the space is free'd up after the ordered extents complete
(which is likely since the reservations are held until they complete),
we would do extra delalloc flushing before we'd notice that we didn't
have any more tickets.  Fix this by moving the tickets check after our
wait_ordered_extents check.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a69e3d9057ff..955f59f4b1d0 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -378,14 +378,6 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 	while ((delalloc_bytes || dio_bytes) && loops < 3) {
 		btrfs_start_delalloc_roots(fs_info, items);
 
-		spin_lock(&space_info->lock);
-		if (list_empty(&space_info->tickets) &&
-		    list_empty(&space_info->priority_tickets)) {
-			spin_unlock(&space_info->lock);
-			break;
-		}
-		spin_unlock(&space_info->lock);
-
 		loops++;
 		if (wait_ordered && !trans) {
 			btrfs_wait_ordered_roots(fs_info, items, 0, (u64)-1);
@@ -394,6 +386,15 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 			if (time_left)
 				break;
 		}
+
+		spin_lock(&space_info->lock);
+		if (list_empty(&space_info->tickets) &&
+		    list_empty(&space_info->priority_tickets)) {
+			spin_unlock(&space_info->lock);
+			break;
+		}
+		spin_unlock(&space_info->lock);
+
 		delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
 		dio_bytes = percpu_counter_sum_positive(&fs_info->dio_bytes);
-- 
2.24.1

