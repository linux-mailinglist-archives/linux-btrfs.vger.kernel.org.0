Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8165AB961
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiIBURE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiIBUQ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:16:56 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BF0F2CBD
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:16:47 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id j17so2333227qtp.12
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=Zzul0XjQ7K8RbEgqt69BK5NPau1GZEWDBk77SvrCOyE=;
        b=rpmLgkjuLnWxOxGVUk260emfvUEpMx2pXrGvHO3rlpWOMDqAdDFixMkyyBkU7Qfuo2
         XW99vPm3P6CE2dUKqxunat0FHis6/rb9cqOyRQ22Zv9AnrpmysY/huqH8sVAAxjtG/el
         CHDqdBpM2nsVcQcXK+T7fIQG7W3DIa68mlZak4Rr9HWTWNGHbEvGNyj6U/yrn/pofR7R
         icCYLA2tc5kQrchm5L0hz2/bW1cdOQXpAA9DB5Pk1y00hZ5/FCkDKP2HjXeCym4Ipe2I
         YJRqwa+slOvC45erQbFfelDVm9D4TKzrVyYbqujhF4w9XnEWdu/yNhYoi9Ga01xrsmwX
         4y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Zzul0XjQ7K8RbEgqt69BK5NPau1GZEWDBk77SvrCOyE=;
        b=kNZOcMhFOvWOKy+A6SRW3mZ5mkMoT4PI09lFWcrNXkjpeEd0llYYpZ8PHDF9JPDH6b
         7iU9yULXi6z83L6OlYiuGC0pI/enrAu09yVX19bAfkPdrwWC/oJXmdsc9kHneDoTv/OT
         IucIAnVil8M6ZVR611tVudmZxgVQ8xkUdKrjBQHWnJ27l4xOFyDz1SO6E3KzEjPG2OVs
         yQ0nNI43a9gaxju5PNCMoBKaAxDaIYKWIV+Gvcj2slJRDalQWK099jtbKG73WMYL0psv
         f2ZROprCEIZFroPvuxg8/TcIMuX6nZU9tAxcRpuqg/pwqyVOh7pe+rcCJTfL8kgRfrJV
         B4Sw==
X-Gm-Message-State: ACgBeo3lK8cWb84EqszWDi/wCSLqyDClangb/M1t4aZdJS3zMxt3BrDY
        MhnIbO69KLxpo7Tpn1kk9MfXKPfXFyOWxA==
X-Google-Smtp-Source: AA6agR62a5buKfFAlpAUC+RucTLQcgiLAj1HZUjhh+XWEcO2xggi3E5h7gM+2QQzZdRu7umAqd5m5w==
X-Received: by 2002:ac8:5c53:0:b0:344:76e1:4843 with SMTP id j19-20020ac85c53000000b0034476e14843mr29356409qtj.281.1662149805829;
        Fri, 02 Sep 2022 13:16:45 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r12-20020ac85c8c000000b00344fbd8270bsm1618835qta.42.2022.09.02.13.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:16:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/31] btrfs: use find_first_extent_bit in btrfs_clean_io_failure
Date:   Fri,  2 Sep 2022 16:16:09 -0400
Message-Id: <243544aa541f1331cc4efade59b1b0b34290a306.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we're using find_first_extent_bit_state to check if our state
contains the given failrec range, however this is more of an internal
extent_io_tree helper, and is technically unsafe to use because we're
accessing the state outside of the extent_io_tree lock.

Instead use the normal helper find_first_extent_bit which returns the
range of the extent state we find in find_first_extent_bit_state and use
that to do our sanity checking.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c15a6433d43c..598cb66f65df 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2395,9 +2395,10 @@ int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	u64 ino = btrfs_ino(inode);
+	u64 locked_start, locked_end;
 	struct io_failure_record *failrec;
-	struct extent_state *state;
 	int mirror;
+	int ret;
 
 	failrec = get_failrec(inode, start);
 	if (IS_ERR(failrec))
@@ -2408,14 +2409,10 @@ int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 	if (sb_rdonly(fs_info->sb))
 		goto out;
 
-	spin_lock(&io_tree->lock);
-	state = find_first_extent_bit_state(io_tree,
-					    failrec->bytenr,
-					    EXTENT_LOCKED);
-	spin_unlock(&io_tree->lock);
-
-	if (!state || state->start > failrec->bytenr ||
-	    state->end < failrec->bytenr + failrec->len - 1)
+	ret = find_first_extent_bit(io_tree, failrec->bytenr, &locked_start,
+				    &locked_end, EXTENT_LOCKED, NULL);
+	if (ret || locked_start > failrec->bytenr ||
+	    locked_end < failrec->bytenr + failrec->len - 1)
 		goto out;
 
 	mirror = failrec->this_mirror;
-- 
2.26.3

