Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BC83A4400
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 16:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhFKO0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 10:26:10 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:35463 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhFKO0K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 10:26:10 -0400
Received: by mail-qt1-f178.google.com with SMTP id g12so2695513qtb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 07:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUDwO68cBfOBDlzWmC4avdYjsbG8dXonJ9Jht6qzPNU=;
        b=1cgz50ow4YBZ7rKyFkaWXr4ZEH9+zAGwS8u58DQSJd3G6y6O/+d/IYkurg82p+Snqo
         BK2i2QKRi7++Ft4rt1M56tNTgKds3Ol1BYAEkflr2HxT3NR/2Ddjg/RhxZQ3hdV/nywU
         2CZqrKpKJyB0NKZ0BmW7TTER55B8TxX63iFhJnP1z3ADXKAWh0oGgyB15C7CQOM2mcKJ
         QIixzsCxQDK6vj9dSRCbq8GfRjFl9v3zs6EENwt2YRD0qFxp9Uz2ovuvikwX+f1m1VEw
         m5oQYBIZWbJcKNuaJO/P1Xwin0cq6s/82RQgLlxdgr1/egLFLnFjNShDtjyo6jc/aGqy
         FE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUDwO68cBfOBDlzWmC4avdYjsbG8dXonJ9Jht6qzPNU=;
        b=ueTObjPv1cKqy7+U9Em2jAtfHazIwHjo1FHdYj4KVxtDTtoKYWdGsPkOOHaCY4VWeo
         +AQ/s73CN+ADG2IM3/UP6lIRY/xin6mrS6U4znSHO9ghS1CB7mloDkjfjMMEQki5dzni
         2ZJr9wQP5MIslpenjR9o9JgujWgeq6DuqNvrtNIidkktT+co4mx5tocHvGkvGh17WJfZ
         BTnKoS+VUL9QLZ6p9KEIs0xYf2LnlZDx5m1U6pHenwvL4r07Y52pf381+340EQ6lEEZH
         4JVg0e08oaTOgulp66Q1EuLvjeLaazPI1wJ4N0y7yWJfKLLapRsWsKSo2Bu+//DNoQHc
         wfyg==
X-Gm-Message-State: AOAM53202o/x0XpP5tXNL2Qoy/TYC+zNb1UzBtEJgx5s2+LQ9OdW5cgj
        6Yjc+vqVIpAoqdlUJwQ6fzuXltzFtIfNQA==
X-Google-Smtp-Source: ABdhPJzIElT0LkM1DwO2KO/d0hannUdZhyGTZUpVfloVUqzP9M1wmfXGAg+gMez/oQhooX8IK8sFSg==
X-Received: by 2002:ac8:70cf:: with SMTP id g15mr4009283qtp.360.1623421392048;
        Fri, 11 Jun 2021 07:23:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w8sm4404598qkp.136.2021.06.11.07.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:23:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] btrfs: commit the transaction unconditionally for ensopc
Date:   Fri, 11 Jun 2021 10:23:07 -0400
Message-Id: <cover.1623421213.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

While debugging early ENOSPC issues in the Facebook fleet I hit a case where we
weren't committing the transaction because of some patch that I hadn't
backported to our kernel.

This made me think really hard about why we have may_commit_transaction, and
realized that it doesn't make sense in it's current form anymore.  By-in-large
it just exists to have bugs in it and cause us pain.  It served a purpose in the
pre-ticketing days, but now just exists to be a giant pain in the ass.

So rip it out.  Just commit the transaction.  This also allows us to drop the
logic for ->total_bytes_pinned, which Nikolay noticed a problem with earlier
this week again.  Thanks,

Josef Bacik (3):
  btrfs: rip out may_commit_transaction
  btrfs: rip the first_ticket_bytes logic from fail_all_tickets
  btrfs: rip out ->total_bytes_pinned

 fs/btrfs/block-group.c       |   3 -
 fs/btrfs/ctree.h             |   1 -
 fs/btrfs/delayed-ref.c       |  26 -----
 fs/btrfs/disk-io.c           |   3 -
 fs/btrfs/extent-tree.c       |  15 ---
 fs/btrfs/space-info.c        | 178 +++--------------------------------
 fs/btrfs/space-info.h        |  30 ------
 fs/btrfs/sysfs.c             |  13 ---
 include/trace/events/btrfs.h |   3 +-
 9 files changed, 14 insertions(+), 258 deletions(-)

-- 
2.26.3

