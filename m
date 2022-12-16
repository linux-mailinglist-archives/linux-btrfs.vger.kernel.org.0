Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6CD64EFAE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 17:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiLPQsG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 11:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPQsE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 11:48:04 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E49F5AA
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 08:48:03 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id bw27so1000322qtb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 08:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFkwGEj+Q2/MdrCTSDBtwU/jwg+7L8nvbhUzNroUCaY=;
        b=RN1iVavjqnKozPReh2vj5xkld6g3ZxBhoYFZp1O0QiRG+DdUTheqykMGohM3wPXyu/
         kJNE9xaeocVqLJtNZ5Ad7nFGEJtClxvg4mCRQNwzrljtkUcj3VmBBRGdnHEL3iAIaZU8
         FyLJmzJUjiKWw7XeWunzfEf8rcG3FPfzIDNPCoF/4kxLcxqHWbSZzm3WKlYxI/l6Boan
         3DBMiSJMbEKoi/hHGK+0U8SC0oQwUcs3Td9tiDmk2emMhoQvG8JldnifqM2PTZ+hrC2Y
         l7nTr68Wf8ItMMHucSJm/HeEKrCL1F9DQ/sGF1iInyrzTWzefZOmZGiOUxEg/uoIJJhE
         mi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFkwGEj+Q2/MdrCTSDBtwU/jwg+7L8nvbhUzNroUCaY=;
        b=Dh1j9AgYUKQtvlF9/YdM3fEcxg/azry1j4OevQe1w8WF2B+tJ7+oVdoSOFuKd1igcd
         uP3Q9xh2FqRBRNqvy5CgbehPttFTCgsCKHJG6AVmW1WpU0Z5pZ1IwQ3dN2naoVBXr57G
         qXkC20iAAxDADplbZ0hkMmKKMgk7nijsFpE+8fkN/r1nP54CvothbOMjF04kEwaoP0nF
         BtJfcdzMPLDUJFoRcB6jZ47DbEQj9JzZfjx7gi25pfHJDDNQB86tn5BlTOwEzCpnpa+4
         VuGMV5tPSHawjLYvVkxkzrvaqU7OJdK4/cObFbZmmVLRkxYTtwMgDL/eSCJS6PanP+/X
         gJLg==
X-Gm-Message-State: AFqh2krP0Yl/OpQaZ10oTXXIoqfK95SCHyxEB+bxfBYkET+jyMF7ac/7
        a7ETHaC7NFmdi8xuH01QUt8kn+5HbhuCQNJBHHI=
X-Google-Smtp-Source: AMrXdXs8OqMlbenFY9OlmSBhDBuykw+3Pre77fcQufWrlDyg3sGGdDKQnBcx7rONsgOsXcIhlrwrUA==
X-Received: by 2002:ac8:4250:0:b0:3a6:9c36:e3b1 with SMTP id r16-20020ac84250000000b003a69c36e3b1mr53430qtm.42.1671209281692;
        Fri, 16 Dec 2022 08:48:01 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id fa11-20020a05622a4ccb00b003a7e8ab2972sm1643500qtb.23.2022.12.16.08.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:48:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix uninitialized return value in raid56 scrub code
Date:   Fri, 16 Dec 2022 11:48:00 -0500
Message-Id: <df5b246d7aa5c8eb382b1e06c7bcf7a7f2fd9d59.1671209272.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes: 75b470332965 ("btrfs: raid56: migrate recovery and scrub recovery
path to use error_bitmap") introduced an uninitialized return variable.
I'm not entirely sure why this wasn't caught by the compiler, but I
can't get any combination of compiler flags to catch it for us.  We have
been failing the raid56 scrub tests since this patch was merged, however
I assumed it was a progs related thing that I was missing and didn't
look into it until recently.  Initialize this value to 0 so we don't
errantly report scrub errors for raid56.

Fixes: 75b470332965 ("btrfs: raid56: migrate recovery and scrub recovery path to use error_bitmap")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/raid56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 2d90a6b5eb00..6a2cf754912d 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2646,7 +2646,7 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 	void **pointers = NULL;
 	void **unmap_array = NULL;
 	int sector_nr;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * @pointers array stores the pointer for each sector.
-- 
2.26.3

