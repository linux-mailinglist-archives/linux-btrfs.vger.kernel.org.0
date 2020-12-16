Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12682DC49A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgLPQuS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgLPQuS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:50:18 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C171CC06179C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:37 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id n142so23142018qkn.2
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvw4fToFfLgQs8KHyWhExgNSTskokaGNdY4lgpyxcwA=;
        b=WMTHwemjsVt4fObDqjplW2jdPSfipA4emVVcntvFxAY9YAV6JQyX78pxewpJ6Sm7GP
         VaE0Ab5RcSXnmHKNkZMQ3dkLuhTQAPZUcyWvnrZiVCRzVo257esq1iZA2ASxnEvXBfzv
         AcmZW4LiTx1V6mvDQZ77BSokFIT/+ni8CF04xCrPOXpCG9nKPuRKBVJqNB3ocCHGcIBe
         OVl+dzzHUEGJSHgD/HMEkmOu9J0sBSPgnW67f4yXb1DBwkqGFUdG3Nd+brqJoF/bMNu5
         h0yeRuhfZT49lBWQ2yD/+G3r/++lF8kw//3pJnfjDqcZiLIJn+9knu8ubRlQGrDNYYvk
         bQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvw4fToFfLgQs8KHyWhExgNSTskokaGNdY4lgpyxcwA=;
        b=Itsx6TI9sCrwFx3DBVtYeGCZ8m9k1jNt6ogl4Z/SL+aOihKSbdLs559nyjtGcW4L4g
         0LZPueDa7WRA0ugdHL153l9bAIAsOADYl7zgNZYOb0IQ6ZeiOAkYyuiozFJ9Om9poXOk
         2AeFiXoFFUdkgJ1yWt3l5qQf+2bb8tYQykDuzFPaaLsXTVH+UFDGhtL0jJCy0GHcPSug
         JykJhjjoPE27JM1yaPLBY2zkt/qVLUXEu1q7Zo/5yeWGEiSdb4Q1wW+Lq4nbPmVm8OPK
         xzlVBWA6WcsNmcfKws7WLlvry7j8BjGb6/11GN39cVO90u1gDptOVqXckWWUskzpM6Bi
         QxKw==
X-Gm-Message-State: AOAM532oDIS8m7XUh7kYou79VhcfYDdMBrNzxfR/iodazwPu5KvKi3g9
        jtEi+HQybr1KIfJ9hyWJ4GkWtSd2sL8gdpG9
X-Google-Smtp-Source: ABdhPJy3gSA2jH/YnrJdOFMq4W+R+FGryid85ZTNHczdljx8Dj/qEdzM+7IrtsvU0s3w2aTrg/wyBg==
X-Received: by 2002:a37:a495:: with SMTP id n143mr44743787qke.362.1608137376746;
        Wed, 16 Dec 2020 08:49:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w30sm1471816qkw.24.2020.12.16.08.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:49:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/6] A variety of lock contention fixes
Date:   Wed, 16 Dec 2020 11:49:28 -0500
Message-Id: <cover.1608137316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2->v3:
- Added Nikolay's reviewed by for the second patch.
- Rebased onto the latest misc-next.

v1->v2:
- Fixed the log messages that Nikolay pointed out.
- Added Nikolay's reviewed by for the first patch.
- Removed the unneeded mb for flushing.

--- Original email ---
Hello,

I've been running some stress tests recently in order to try and reproduce some
problems I've tripped over in relocation.  Most of this series is a reposting of
patches I wrote when debugging related issues for Zygo that got lost.  I've
updated one of them to make the lock contention even better, making it so I have
to ramp up my stress test loops because it now finishes way too fast.  Thanks,

Josef

Josef Bacik (6):
  btrfs: do not block on deleted bgs mutex in the cleaner
  btrfs: only let one thread pre-flush delayed refs in commit
  btrfs: delayed refs pre-flushing should only run the heads we have
  btrfs: only run delayed refs once before committing
  btrfs: run delayed refs less often in commit_cowonly_roots
  btrfs: stop running all delayed refs during snapshot

 fs/btrfs/block-group.c | 11 +++++--
 fs/btrfs/delayed-ref.h | 12 +++----
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/transaction.c | 73 ++++++++++++++++--------------------------
 4 files changed, 43 insertions(+), 55 deletions(-)

-- 
2.26.2

