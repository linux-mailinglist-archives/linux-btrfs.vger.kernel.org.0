Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F145E3436B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Mar 2021 03:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCVCkI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Mar 2021 22:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVCjj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Mar 2021 22:39:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88583C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Mar 2021 19:39:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e18so15069545wrt.6
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Mar 2021 19:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCa2wTspF3XYYM9R8FbcUv0lgkwdxY3wirB8OMzuSRE=;
        b=ISQbuAWkrTavlTtoYe39Ms/cfly/KS+XZh+DLtMqmkYcBoSuFCruzsPHlD7DMV0ijO
         1+nvN7o3dZ3ZXg5jshWFCH0d4fMjlPCZR+xEtrE4te2mX90jBYZ3h8j7q0BYJo1QXDzW
         Iv4YTLFQaWZbYilme8D1nuoLTTBdmjA4OxecGpKoRZ06ts1wXt9nK8cs9osW7tFaQ1Ye
         8dspmOeWJZDvlosAMOJX8GPn2EJZHMzhRe65PXuELwLVOCA0YCU+PRqXS+FEcM1Apm5+
         UySQXCj4rRASNrYcCV3q3mCscOvkHl9bIFe2vr4mnyxxjrYnaxE+1vxqQvDXSrDo3SXc
         Q+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCa2wTspF3XYYM9R8FbcUv0lgkwdxY3wirB8OMzuSRE=;
        b=TnEfBzpxfQe96VVVIH7r8+dfbkYfZoLVGiwJ7rMdMCGdtQQBSlxrcwTBRdctiZ05m5
         9EuIrWBO+7UquGp0daPJ1EzGlL+l1v8+CWMH80mtXPnVG1z7HWhI/F/H6ogF04D57NTg
         rTTNi2dF4OGUyMIYBk9zXdczF16VVIHKNepvWmJBiVFguQ0twkJmPl95gydUgDAjqmyP
         9mm6HBYGZLWglMcxOPKcfSrNHBYUXjeEsqJfKFFV2x0qWHr6Y/dXBKLiFC/Qphu+4yR9
         KH9VLqU8wiRL8kOvrZE2YmRK1Zg9GURg0w2YCVgAdAXYEwL1QCNUyuMPLWFbYDO7wYEC
         DjYw==
X-Gm-Message-State: AOAM530BY0ud14Uej61Rr2rEXwpdq60LMs8mjJjCeeGngoGnSjBahvnh
        L9zCCTn68b+LDgr07KMCJtQRvjnrb+mc7F7e
X-Google-Smtp-Source: ABdhPJyM0kXGZJYcZrdaihLXrLaye+gILfpQbDvUhthywCTL0sb4RmZKm0796QmHPp1/KqqMkf1rfA==
X-Received: by 2002:adf:82af:: with SMTP id 44mr15165234wrc.279.1616380777918;
        Sun, 21 Mar 2021 19:39:37 -0700 (PDT)
Received: from localhost.localdomain ([46.109.162.86])
        by smtp.gmail.com with ESMTPSA id z25sm16854353wmi.23.2021.03.21.19.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 19:39:37 -0700 (PDT)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH] btrfs-progs: btrfs-map-logical fix case when extent isn't found
Date:   Mon, 22 Mar 2021 04:42:42 +0200
Message-Id: <20210322024242.32045-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Given extents:
[21057146519552,21057146535936)
[21057146552320,21057146568704)

and trying to map 21057146535936 we would find 21057146519552
which would give us extent with length of 0 because

> real_logical = max(logical, cur_logical); // logical (21057146535936)
> real_len = min(logical + bytes, cur_logical + cur_len) -
> real_logical;
// cur_logical (21057146519552) + cur_len (16384) -
// real_logical (21057146535936) = 0

So we need to break before this

Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
---
 btrfs-map-logical.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
index 24c81b8d..a2030f96 100644
--- a/btrfs-map-logical.c
+++ b/btrfs-map-logical.c
@@ -327,17 +327,18 @@ int main(int argc, char **argv)
 		u64 real_logical;
 		u64 real_len;
 
-		found = 1;
 		ret = map_one_extent(root->fs_info, &cur_logical, &cur_len, 1);
 		if (ret < 0)
 			goto out_close_fd;
 		if (ret > 0)
 			break;
 		/* check again if there is overlap. */
-		if (cur_logical + cur_len < logical ||
+		if (cur_logical + cur_len <= logical ||
 		    cur_logical >= logical + bytes)
 			break;
 
+		found = 1;
+
 		real_logical = max(logical, cur_logical);
 		real_len = min(logical + bytes, cur_logical + cur_len) -
 			   real_logical;
-- 
2.30.2

