Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B44358CEE7
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 22:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbiHHUKd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 16:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244046AbiHHUKb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 16:10:31 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9907D1903F
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 13:10:30 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id m10so7176720qvu.4
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Aug 2022 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/VEjjPNHG4ysFaqapuQYETaEeYy8yej1PwfOBJICbmg=;
        b=d4oKe/Xq0hKeDE2d1uxb9RJXyto7wXBJHp7WaWSc7p9990ZiahvvULuFXI8pLJBqWB
         A2JCJUgXe7wr3nH2JZpUQ0PuYSPCi+PRvqaRbVxpO2nGvzDIS66Xhldol/QFOf505oOq
         v9MRQSzP7EsQXV4LOiGoHTbLos47DBUoHYoY0Gpw/6BUGRAHE67AK3ub3R/sibCy1+3m
         25tDx9vzFagr4frpMTCsBPscY21774KPhx5aUgIJaTjo/wTdd+MvF6rK30F/DjHu3Tjb
         GWHeBEZHCHmZyXRO/4r3WbZSnjgfkcrPMQnDz+dDvmOlRXDKW7JCG10pO7SfxvJEno04
         eK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/VEjjPNHG4ysFaqapuQYETaEeYy8yej1PwfOBJICbmg=;
        b=pmk09DujzXSaMMxzkfudnN6TaOlO/PdvefYA1xqWZavly9TrZJEW/eUK5Q70YXvzyz
         5eUmAeefjNtASuhpPlOElzRA8GeiTl4os8MjMrL5w3pxhV5newM8dD9KJX3ylPV8eIz4
         s8q+AdXDICunqMAcqIBT8PlzsnAuxQ9rtMeJ+0qDcu8C2u+benpKj07YIoVx3QfAPha+
         ggx8lDBJpmBW7f3OIgEGLcMFDZALExyI0//ndycItgSxagJ07n3xczCU51AtRhQ2rp0u
         GPjmMNkXRbuv3dJFrvjJld9GA3fHMc3zatfKFuIo7nC+W02kD20w4Ee0qqKT9O1Qdr5T
         QOxA==
X-Gm-Message-State: ACgBeo3hUEDhyxZPTWVyZXsgo/vGed/lU82gLQtLVvzGqWvqTijGrm2t
        D2WRDw+0JGDhQ5CFF0YcLSuw3XZCykUncg==
X-Google-Smtp-Source: AA6agR7HJbabo5H3sDOAZf9LTpXiMhfYUKQ9vPgTm/u8cVJb7ZaFlDF3MJFG5diuNP3zxvILbsrGAg==
X-Received: by 2002:a0c:df82:0:b0:474:97e5:4951 with SMTP id w2-20020a0cdf82000000b0047497e54951mr17324826qvl.96.1659989429387;
        Mon, 08 Aug 2022 13:10:29 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id dm27-20020a05620a1d5b00b006b8cb64110bsm170126qkb.45.2022.08.08.13.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 13:10:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: fix a lockdep_assert_locked() warning
Date:   Mon,  8 Aug 2022 16:10:25 -0400
Message-Id: <cover.1659989333.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

Hello,

With discard=async we're hitting a lockdep_assert_locked() in generic/475 in our
CI setup.  This just popped up recently because before lockdep would get
disabled before it got this far.  This series fixes the problem, and then
cleans up the cleanup functions to reduce the code and exported functions.
Thanks,

Josef

Josef Bacik (2):
  btrfs: call __btrfs_remove_free_space_cache_locked on cache load
    failure
  btrfs: remove use btrfs_remove_free_space_cache instead of variant

 fs/btrfs/block-group.c            |  2 +-
 fs/btrfs/free-space-cache.c       | 53 ++++++++++++++-----------------
 fs/btrfs/free-space-cache.h       |  1 -
 fs/btrfs/tests/btrfs-tests.c      |  2 +-
 fs/btrfs/tests/free-space-tests.c | 22 ++++++-------
 5 files changed, 37 insertions(+), 43 deletions(-)

-- 
2.26.3

