Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B91414EE7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 15:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgAaObL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 09:31:11 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42947 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgAaObL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 09:31:11 -0500
Received: by mail-qt1-f194.google.com with SMTP id j5so5499375qtq.9
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 06:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ln5EC4h4PHvfVrz2xBFzWM1XLD97a4C8Le4kqD/eTr8=;
        b=XO3QNkvzDl32KQRdgb921+03UTAKchNwPqKeipkG27q4Cs4aIuna4pemdK2EDMUlAL
         WX/Z0ZAyPSNsgLkcy6oIg2Q/R3sHd1NUkmIBwhwtK/Z/Io7I5O1voej9eb9IBOKI2Ubk
         j1Sptuh2zyzdyTblFNKqP2dO8H/B7HhhQJAj0VwBS90WL9n4UxNaoIR1rilLKtuhmHPU
         BLv3wRHHDDg/RtBci66fAhonfm/Lnyuub7ihjv3SHvBjV+jjHTNIbDdy1fRfTeY2UXdi
         gllqzsGKG74xhLHakBPTVtB1PTZw097U9lZ/HZkbadsehJL/Cx4BVJleJX1zSpg8VBY0
         8wNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ln5EC4h4PHvfVrz2xBFzWM1XLD97a4C8Le4kqD/eTr8=;
        b=Joi+1KXbKpMcbvGvE+yE25+hQChnVPn3Y/dhkvTOGI2yisiB2mj2/cPUvl9y7QPpBI
         rRwtgwwRMAvZrkUUzl5CBSCZtjUTRmRCo/rF1kEDqowha0O3WzVMiiynYRWofd5oZOs1
         Yn/xFtiLK+muEaIhJy6AAB2TalHUPhC+Mx7eH02R/hna6fQzRY9tBInYdz2Y36Ox26xh
         HobkDIStBAEYWN/9sCAPfxb5mRUnnFtUwb1hwuJnosa+Ahi0B+35b9WVHQ+HgBASsqf5
         n/Es1X5ckqC2RHVXPK88WxvKNoxcDQeqljPLzcfPHcztwahqOf5cx1TXPjmUAKvcKFB8
         ZwbQ==
X-Gm-Message-State: APjAAAU1DTgd3X9BbzExd6sd7y2qeM7kJ2HTtnzjl5qFXi2QILjQ5VzF
        ECGBwt/orXz78hRCxW9rSRHJQ30vgBUWZA==
X-Google-Smtp-Source: APXvYqxJpSfPjkWSzIcYQLbHt83SJog3UoYYcnJloEFvqiERdjlI7Cv4ctxzFBvf+5jKQwxgS7f6zA==
X-Received: by 2002:ac8:540f:: with SMTP id b15mr10944540qtq.237.1580481068233;
        Fri, 31 Jan 2020 06:31:08 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l25sm4456968qkk.115.2020.01.31.06.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 06:31:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Martin Steigerwald <martin@lichtvoll.de>
Subject: [PATCH] btrfs: do not zero f_bavail if we have available space
Date:   Fri, 31 Jan 2020 09:31:05 -0500
Message-Id: <20200131143105.52092-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There was some logic added a while ago to clear out f_bavail in statfs()
if we did not have enough free metadata space to satisfy our global
reserve.  This was incorrect at the time, however didn't really pose a
problem for normal file systems because we would often allocate chunks
if we got this low on free metadata space, and thus wouldn't really hit
this case unless we were actually full.

Fast forward to today and now we are much better about not allocating
metadata chunks all of the time.  Couple this with d792b0f19711 which
now means we'll easily have a larger global reserve than our free space,
we are now more likely to trip over this while still having plenty of
space.

Fix this by skipping this logic if the global rsv's space_info is not
full.  space_info->full is 0 unless we've attempted to allocate a chunk
for that space_info and that has failed.  If this happens then the space
for the global reserve is definitely sacred and we need to report
b_avail == 0, but before then we can just use our calculated b_avail.

There are other cases where df isn't quite right, and Qu is addressing
them in a more holistic way.  This simply fixes the users that are
currently experiencing pain because of this problem.

Fixes: ca8a51b3a979 ("btrfs: statfs: report zero available if metadata are exhausted")
Reported-by: Martin Steigerwald <martin@lichtvoll.de>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d421884f0c23..42433ca822aa 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2143,7 +2143,15 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 */
 	thresh = SZ_4M;
 
-	if (!mixed && total_free_meta - thresh < block_rsv->size)
+	/*
+	 * We only want to claim there's no available space if we can no longer
+	 * allocate chunks for our metadata profile and our global reserve will
+	 * not fit in the free metadata space.  If we aren't ->full then we
+	 * still can allocate chunks and thus are fine using the currently
+	 * calculated f_bavail.
+	 */
+	if (!mixed && block_rsv->space_info->full &&
+	    total_free_meta - thresh < block_rsv->size)
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
-- 
2.24.1

