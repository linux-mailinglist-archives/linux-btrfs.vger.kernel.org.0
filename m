Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D6F3ACE7B
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 17:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhFRPUq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 11:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFRPUq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 11:20:46 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525E2C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 08:18:35 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q16so11761617qkm.9
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcrucE7BXliNQEHYR4bRltDDNtULAPF0enkEThtiyX4=;
        b=B6vURZ3G8/+2kAZWtMbQvxL2FP43zMXbo1H/bTMZ6n5Cl+XRvfqY4apL33h6WehkDX
         3dSiJLPyfi8B+KEY7WmEaKhQsbwMExJoQVv/dlQCLGdFTzo9P6x+soT4on73mTACDfjP
         6t1AXnoBapnQL1U69zINadUd9ALXP4fWYL4PXwPEmhz2JU3UL1tHXjMJg+bHpNnJ6uHF
         sj2ekCVOO6P2tYd2wi2Eo0FVEf82aK6Xed8zFpiwWJIj+APFMF0swBmhnDMNOm/gFcvE
         uszuPl/m4yoFJ5QEqtKJ+LL7SLTxSchA9spqN50mg9HZFyyKv7w7BmavGcbnQRWz0rAs
         LwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcrucE7BXliNQEHYR4bRltDDNtULAPF0enkEThtiyX4=;
        b=tiWcQEBv+Z8UiCB/Me6WulUweTo9ErlQ5rJ6mIffowYObPFZR+iTiidm2gdcTgP5Fm
         XeN3oStXjdkjKPi27Jpg6nobhHGWLPBrPESl1f0O0I4P1lopg2X/X69LKZItin+8phoC
         e3QjByBrUO5p9lKR+/bU7ZN96r7zJ0Zuwpf7Zh4tAnA7TWkaAOrxH7cd6wUeqbHDPjLE
         syYLZs5xqYOqVXdaScAb5rxFs04F1n2ZwzUVwSd7OVwClWdbLjGW5QOUFqL+D3nKoJq7
         84e7A7CtYOQGnFSFOIptXPo5JtbBm4iOeSuZMUrjCGpwF4Yzm5f1rYHnJzsoWvupJl7B
         B9Pw==
X-Gm-Message-State: AOAM530lZyub2pRuXap9t9WVnX99WAz5BoabPCNurBNzGl/rEof6236P
        5QsDcWBGt8T91pJH7XUYVhK5fRbOOPXitg==
X-Google-Smtp-Source: ABdhPJyHQzprA5l08av9cmgE/q0hg4Ov/ONX7T855s2zhFYekg++W0bBmmUflKIiAoRuitjgZVMh8Q==
X-Received: by 2002:a05:620a:919:: with SMTP id v25mr9549543qkv.327.1624029514153;
        Fri, 18 Jun 2021 08:18:34 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p21sm5468783qtq.92.2021.06.18.08.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 08:18:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/4][v2] btrfs: commit the transaction unconditionally for ensopc
Date:   Fri, 18 Jun 2021 11:18:28 -0400
Message-Id: <cover.1624029337.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- added "btrfs: remove FLUSH_DELAYED_REFS from data enospc flushing" to deal
  with me changing the docs and to reflect that we no longer need this step in
  data enospc flushing.
- Updated the 'rip out' patch to no longer include that particular part of the
  documentation update.

--- Original email ---
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

Josef Bacik (4):
  btrfs: rip out may_commit_transaction
  btrfs: remove FLUSH_DELAYED_REFS from data enospc flushing
  btrfs: rip the first_ticket_bytes logic from fail_all_tickets
  btrfs: rip out ->total_bytes_pinned

 fs/btrfs/block-group.c       |   3 -
 fs/btrfs/ctree.h             |   1 -
 fs/btrfs/delayed-ref.c       |  26 ------
 fs/btrfs/disk-io.c           |   3 -
 fs/btrfs/extent-tree.c       |  15 ---
 fs/btrfs/space-info.c        | 175 +++--------------------------------
 fs/btrfs/space-info.h        |  30 ------
 fs/btrfs/sysfs.c             |  13 ---
 include/trace/events/btrfs.h |   3 +-
 9 files changed, 12 insertions(+), 257 deletions(-)

-- 
2.26.3

