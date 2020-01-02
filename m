Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F5B12EB4C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 22:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgABV0u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 16:26:50 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44001 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABV0u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 16:26:50 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so32874866qtj.10
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 13:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BcQyxHq/385juGIbca8KbSKy6dyKpl2HYomxtoBwbnk=;
        b=GWtl7ez0y1jIYdE7peiNXZfqloRARHvjhoNmXaatytEmM5tovxsDNoGiomkWSN8Ae/
         /CzeYBM5bAxWO2uK6mF+Uflb7qcj7INTEOAA+Rg97zlCQ2DKlOGVxDps0x6efgoL4qzk
         ceAQdib1DWD6bmW1VMo6iAg/MrAPKcuDXy7xpfChxZ38j+/9RizkClxzn/5z085kwsV1
         JEgkGH/FpsU9J48hDfaQFoZ5BvGjIo4/yKOAfCHftDCWrz72cV2e6oY37meymQG8kcNZ
         Tx04Hhn4EquOFyIX5hx7vetvmPVIxkyewTmx4RFOUYnePPGuA9HrMNt8Ah4FS9JdXTeu
         u9XA==
X-Gm-Message-State: APjAAAVub0WiObbYi4fq12rv72KymxNKlNx5lbKs2BxpW4/0WVyt9aJS
        JUPEUsddmaG9UtPrxTF6oZA=
X-Google-Smtp-Source: APXvYqyoyVrGB7Zw1nUOK5oSSlw8v2I7nmVkdtLf7sieMEudo0JM5X9E8vFToHlQcKnY9je5JFn6og==
X-Received: by 2002:aed:2ee1:: with SMTP id k88mr55926160qtd.25.1578000409516;
        Thu, 02 Jan 2020 13:26:49 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id f42sm17553933qta.0.2020.01.02.13.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 13:26:48 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 00/12] btrfs: async discard follow up
Date:   Thu,  2 Jan 2020 16:26:34 -0500
Message-Id: <cover.1577999991.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Dave applied 1-12 from v6 [1]. This is a follow up cleaning up the
remaining 10 patches adding 2 more to deal with a rare -1 [2] that I
haven't quite figured out how to repro. This is also available at [3].

This series is on top of btrfs-devel#misc-next-with-discard-v6 0c7be920bd7d.

[1] https://lore.kernel.org/linux-btrfs/cover.1576195673.git.dennis@kernel.org/
[2] https://lore.kernel.org/linux-btrfs/20191217145541.GE3929@suse.cz/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/dennis/misc.git/log/?h=async-discard

Dennis Zhou (12):
  btrfs: calculate discard delay based on number of extents
  btrfs: add bps discard rate limit for async discard
  btrfs: limit max discard size for async discard
  btrfs: make max async discard size tunable
  btrfs: have multiple discard lists
  btrfs: only keep track of data extents for async discard
  btrfs: keep track of discard reuse stats
  btrfs: add async discard header
  btrfs: increase the metadata allowance for the free_space_cache
  btrfs: make smaller extents more likely to go into bitmaps
  btrfs: ensure removal of discardable_* in free_bitmap()
  btrfs: add correction to handle -1 edge case in async discard

 fs/btrfs/block-group.h      |   7 +
 fs/btrfs/ctree.h            |  10 +-
 fs/btrfs/discard.c          | 258 +++++++++++++++++++++++++++++++++---
 fs/btrfs/discard.h          |  12 ++
 fs/btrfs/extent-tree.c      |   4 +-
 fs/btrfs/free-space-cache.c | 154 +++++++++++++++------
 fs/btrfs/free-space-cache.h |   2 +-
 fs/btrfs/sysfs.c            | 129 ++++++++++++++++++
 8 files changed, 519 insertions(+), 57 deletions(-)

Thanks,
Dennis
