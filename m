Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00232DD30F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 15:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgLQOgq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 09:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLQOgp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 09:36:45 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0804C061794
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:05 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z3so20169629qtw.9
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ekrBqf+EJCV9unDN335lJCrA3Ou6G8OuK0t/XV+pByk=;
        b=HQoT4EZ/6mFRBo0TezmB2LddnYxt2twh9Z83YmExFKz9L7d9/XbTE2spyZgtxjvU9Y
         diudRcz4ltFEqbsltzqYGCPOQW2h/kcWxZqDJbvOaff9mIyEoUsWLOwCZB39EQKQHW/e
         9YuZ02X0GgZWdeJY2fb7c0I1qGeo3xXlmvwcOtih4LOrZuFhJMh3iLSRp3EnOOxFm21B
         viCVLtdg0xgkvxq85e7Nqmd/bGbCxf1I/SeplXB1DwdHKAvoafc3uLpoZ2oYjO4SYBn/
         DP/YNXoTroetU3NNgT9ab9IXrUnR4XHhajF86e55Pm8CDvD/qCd0JqAX4YORaK17CMrc
         tHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ekrBqf+EJCV9unDN335lJCrA3Ou6G8OuK0t/XV+pByk=;
        b=h08LJ/8qJqYwAKrI223dWGc1WxhenbK9cv3rokpNA6F+mIzBw5GF+MTVeMAZGowU+J
         Ku18DD4d0cS4C6vNX8eo/L/DbVpxossXkr+17w4tXjoHeQv/f3h7G+wp9G8tTr9Q0hJs
         kgb9t0SbgSvX5RSu1C1mwXRH3E8Bpcu3uMr0bAO2qrUeQdU5mP33k4zvCP6B74SqhxsD
         +ssyEMTw+KZRNHjqK+cnZQFAEYcz7Jn0kg7uTo4u5r2XKf6ioqEKyC1P663fkZHazvxD
         ghujOAv+BuIacBlb4ZQ3gV4XcLyAq9R9Fv5cGRoX/hK8utuzUkN6OeE5gNG+KlyduagY
         P+pA==
X-Gm-Message-State: AOAM533Zf4YIP5jh9OSLQ+AS9/NZU5ST6KyHrAeW8tWugSlan0W5+n0k
        XRHEQcGMA0oIxgLwSRL75FWtYOyuK/LQs7Ux
X-Google-Smtp-Source: ABdhPJziEvzMyqSt0/mrNClqjRY1LeIMQB1mae1pJ+Sw65wesEq66RSApEQKBGCVJxtIa4NvbkxU1g==
X-Received: by 2002:ac8:7288:: with SMTP id v8mr48546849qto.358.1608215764548;
        Thu, 17 Dec 2020 06:36:04 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 17sm3344315qtu.23.2020.12.17.06.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:36:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 0/6] A variety of lock contention fixes
Date:   Thu, 17 Dec 2020 09:35:56 -0500
Message-Id: <cover.1608215552.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3->v4:
- I accidentally sent out the v1 version of these patches, because I had fixed
  them on another machine.  This is the proper set with the changes from v2 that
  are properly rebased onto misc-next.

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
  btrfs: stop running all delayed refs during snapshot
  btrfs: run delayed refs less often in commit_cowonly_roots

 fs/btrfs/block-group.c | 11 +++++--
 fs/btrfs/delayed-ref.h | 12 +++----
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/transaction.c | 74 ++++++++++++++++--------------------------
 4 files changed, 43 insertions(+), 56 deletions(-)

-- 
2.26.2

