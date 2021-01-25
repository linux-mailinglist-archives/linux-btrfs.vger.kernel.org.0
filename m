Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698FE302059
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 03:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbhAYCYM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 21:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbhAYBzF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 20:55:05 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC458C061573;
        Sun, 24 Jan 2021 17:41:44 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id d85so11154454qkg.5;
        Sun, 24 Jan 2021 17:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dB7AV+eR2Q61jkORlAJSRwyf/ZJ9KntrjND2fG3o7wA=;
        b=LpcvtcY1Nmd4Ld5MdvccLdwuEAPflNL0Vb53u1cstyJ1Esir7VdFUNOwyP2nPhr3lO
         /ypg7QsMiyB9dEgf1yBNH2GNmnMS3e4SAtlCYdZfRoRkujUa7+cS+5yrRc4coxLEsU+y
         1xr2pLgv+GZ/Z5elSdfMtFCaETuLfmZR/g4aCLc8wi0Fj5YCXVX0W8De/kmSMgnGcUJm
         6RVhyCuHkI5ln9lENiy+yMNRm7YEXj+1afJTTgqoKOZ+p3ybUoe6Wu/FAhGeWFHqO0KL
         EC4HrLP6+BjiWM1mY+xKRuayAnfrIiMslIJuiPcb3ocs1mswey/VNBIvL3D2tOB3YqDL
         mrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dB7AV+eR2Q61jkORlAJSRwyf/ZJ9KntrjND2fG3o7wA=;
        b=g/i1R7ccrgb9cXNfq/f281N/4Nz3yxhC4X+7aXGs99Wnl+8jlEr/onMDPjMK91IcE6
         UAk9zM93XrcKwo9dnWA3tWYCGjL0tGnjdKCzEQj18NAE8mZ5nsHTVPqjJtxkgUis8kGX
         H7neOXQmSKafRMMgaxbs1YDOSkmRvImti3XZWpwA1TX4NpT5q7CZDenO/S/hyK69KHp1
         Xsj28IB0ynfYy4og2A3YGBY/7EyId35Y3Y2Fvn1GvngI+OCkCKHLy95/UNh4neJX/4w2
         18OiRlJ5ZDb5BPrEXFIbPa7fQZAqywXkKKsXvxbL1tRJLqEu1Dy9j1GGSwe7f6wbSlUw
         wRmw==
X-Gm-Message-State: AOAM5318bZBClElakqUIFVByYsGyfI66LKHYkesC6h1+/j0waNaUomx8
        Z24j8WB2vqFNDvGR4SkSjZfBD6SB2lm/vIOp
X-Google-Smtp-Source: ABdhPJy437+EdlnubuMXXmNByYvaJ1sr46qpoG8lAyB3G5SFh7tFj85LgQ9BAbg8J5qXxgP2+BkqWA==
X-Received: by 2002:a37:4587:: with SMTP id s129mr882183qka.62.1611538903733;
        Sun, 24 Jan 2021 17:41:43 -0800 (PST)
Received: from fedora ([2604:2000:ffc0:0:347e:7d23:25c9:8337])
        by smtp.gmail.com with ESMTPSA id t51sm5856228qte.8.2021.01.24.17.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 17:41:43 -0800 (PST)
Date:   Sun, 24 Jan 2021 20:41:41 -0500
From:   Nigel Christian <nigel.l.christian@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: remove repeated word
Message-ID: <20210125014141.GA10137@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Comment for processed extent end of range has an
unnecessary "in". Eradicate it.

Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7f689ad7709c..2dc98eeb3c93 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2775,7 +2775,7 @@ struct processed_extent {
 	struct btrfs_inode *inode;
 	/* Start of the range in @inode */
 	u64 start;
-	/* End of the range in in @inode */
+	/* End of the range in @inode */
 	u64 end;
 	bool uptodate;
 };
-- 
2.29.2

