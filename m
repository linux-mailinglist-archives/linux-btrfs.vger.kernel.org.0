Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F586C8696
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 21:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjCXUNY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 16:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCXUNX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 16:13:23 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B277BBAB
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 13:13:22 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a5so2563895qto.6
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 13:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1679688801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0t6BdfAxJFYOZ0ibuSqMV71Np9uiJrY1YLfyEZlCX5g=;
        b=jEWpRaeVlMJMKHa1thRn1an4ZPed9lIqkBqKOsOD0y9PpUTBrz9ec9/BO1aPKY3r0u
         BH8aXIJnIVw+Ud7h5AA2NETVDzd7dNyNikpiktlY8kWrmnanYvAsxBQSkOOkg3Be1cPH
         XLbSSXFpA8OdEidc8m6sWYyRleq7agjSpWpcsBt8TSsDmnMtpMwYLpKcZAQuWaXrDq0C
         F2GmQg0yD3doHb7dmvxjzjgtHsWy5UPqxlMq9x1QwkpZ0SaeZQgszra0O5iYj14SEoLY
         CdbCj2Sz/F3VqgQOoJRfRjuGovJYPm+O1skcViBGsSTQIMXyLUrf4hAZPguTgV+Btbd2
         xSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679688801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0t6BdfAxJFYOZ0ibuSqMV71Np9uiJrY1YLfyEZlCX5g=;
        b=C594B5wn+6lRQnnh45zIyf6yGMc1WFYLKQQoquBLqwURL5KKlQoICcn0CHsthHBtOL
         OazcDzaxRWV8ADgnXbKoI8e3jY9lpq0L1pxIfYLR+W14cxIN92CjTGt+kxTtfUUVJse5
         ZOnB7fdGtZEEO2qdmU/uXKgVRs9KuGrmA/KLXPm94r9afOS7O187LJJjuVexLUwAsbGC
         dHQT+g/1nT1OoAHHzyRL1BQBRglBpPqtrCkklxY6MBN+gDmRwX0emeqyiU6uB/qJcEs9
         o6wbpdL6sBrxgr79Ra2M7qsUGiCGCdMgnmFn4dWh6x89G3Oi1rMph7PrujKdrMR164bh
         hClw==
X-Gm-Message-State: AO0yUKWyCVG9qcjGUx2XcUIryuO5mh0NLgtRUJnJK8JRc8cAkbVyRvyb
        EXuZsYeDcI4UHIn5B0YIymK8q4Oupy2B177uU3HMvQ==
X-Google-Smtp-Source: AK7set/q6eJyGQm3kC7hOJAylkJ5sKkOx3l4cupabF226kLTprxGnZKTIwGz+mlHcEmb0eMwu31HDw==
X-Received: by 2002:a05:622a:342:b0:3bf:b70b:7804 with SMTP id r2-20020a05622a034200b003bfb70b7804mr7336335qtw.25.1679688801282;
        Fri, 24 Mar 2023 13:13:21 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id v127-20020a379385000000b0074230493ccfsm14527444qkd.73.2023.03.24.13.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:13:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] fstests: btrfs/012 don't follow symlinks for populating $SCRATCH_MNT
Date:   Fri, 24 Mar 2023 16:13:19 -0400
Message-Id: <8d1ac146d94eec8c77f08a6d04cd8d5248dc8dc8.1679688780.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

/lib/modules/$(uname -r)/ can have symlinks to the source tree where the
kernel was built from, which can have all sorts of stuff, which will
make the runtime for this test exceedingly long.  We're just trying to
copy some data into our tree to test with, we don't need the entire
devel tree of whatever we're doing, so use -P to not follow symlinks
when copying.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/012 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index d9faf81c..1b6e8a6b 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -43,7 +43,7 @@ mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
 
 _require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PROG} '{print $1}')
 
-cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT
+cp -aPR /lib/modules/`uname -r`/ $SCRATCH_MNT
 _scratch_unmount
 
 # Convert it to btrfs, mount it, verify the data
@@ -67,7 +67,7 @@ umount $SCRATCH_MNT/mnt
 
 # Now put some fresh data on the btrfs fs
 mkdir -p $SCRATCH_MNT/new 
-cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT/new
+cp -aPR /lib/modules/`uname -r`/ $SCRATCH_MNT/new
 
 _scratch_unmount
 
-- 
2.26.3

