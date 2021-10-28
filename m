Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A3F43E918
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 21:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhJ1TxG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJ1TxF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 15:53:05 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F74C061570
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 12:50:38 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h16so2486615qtk.0
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/11H0U4zWTH1gTTvpBUcvZeJRjYsl9RwwRrpMUQ98m0=;
        b=p+epD72qxX9sUxmf8X6oYXLVuHN0BLWr1lggWfm14MJFC7j9wQomjRSPNe+PCDWkab
         Bek1qEjfkEUK616L55UeYSvR9vDQQFhdHw2DIUiaJf5D8uf4htqd9kdveVt3jnKt5U6M
         WL3+ZJsdMzdOHctC32YC4F0BUw5BCoQISBO9Z/o3YlhuOxj0VtYv7Ld0yL/O58d0Klu0
         vHYz9PQ9bs8JDuVKsw4PYFzwPcLA+xKuqbmbX3Oivcc6qV52xoEmKW6sjHhiz/dFAH7R
         dF0+NQjm9a0rjTTs/soFm9fE2Azo9/B46vNdiEXRS6kNoU7a69beJLJEU02qp5UJ9mDb
         VjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/11H0U4zWTH1gTTvpBUcvZeJRjYsl9RwwRrpMUQ98m0=;
        b=EU6KIp9PtLmak/JX6Akp4GG3OO8luSG9G7Zzx7Wijd9aB88F35QrQBSABiSZuFvJ9J
         Gab3d7z/utckHOLdpx2Y3UhcnhtKVj6M/MPklmucjL5f/vthW75Nvhz3H516rouZu0UX
         5n8omIGgxB1x4AMl199FEmRC7yixy63nYYC7o4Nbm7qsEeChvVEWeTR0ySIZbWElQZWv
         KuGW03R4T2PgMUJi1jxHHJs9/oyZLQ2jb3qYdaBoGBEfcYt7FVo4NeRc/KgcjNmFfiSy
         QRK710binD0m/ugkdFlKGdJyC5i2JoUKdcrYmuy/4UJbR2VW8QXZtpPcULbC63JiJDXM
         o/VQ==
X-Gm-Message-State: AOAM532D48bTKcNHpvt7Itww7LPObg+nA0wZit5+dkLPYpMcmneyrQTr
        P67UOzyYeoxmop2QOm/QQzx89jUf0TDaYA==
X-Google-Smtp-Source: ABdhPJwkHw90w2+D/N57xCovs8T5Ej6JxAfrQ3Q0RCSZiB1YA+J1E96uAQP4aB7OkSFeFuKsJepB+A==
X-Received: by 2002:ac8:5a96:: with SMTP id c22mr7093741qtc.266.1635450637366;
        Thu, 28 Oct 2021 12:50:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c8sm2795299qtb.29.2021.10.28.12.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 12:50:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/4] Use global rsv stealing for evict and clean things up
Date:   Thu, 28 Oct 2021 15:50:32 -0400
Message-Id: <cover.1635450288.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

While trying to remove direct access of fs_info->extent_root I noticed we were
passing root into btrfs_reserve_metadata_bytes() for the sole purpose of
stealing from the global reserve if we were doing orphan cleanup.  This isn't
really necessary anymore, but I needed to clean up a few things

1) We have global reserve stealing logic in the flushing code now that does the
   proper ordering already.  We just hadn't converted evict to this yet, so I've
   done that.
2) Since we already do the global reserve stealing as a part of the reservation
   process we don't need the extra check to steal from the global reserve if we
   fail to make our reservation during orphan cleanup.
3) Since we no longer need this logic we don't need the orphan_cleanup_state bit
   in the root so we can remove that.
4) Finally with all of this removed we don't have a need for root in
   btrfs_reserve_metadata_bytes(), so change it to fs_info and change it's main
   callers as well.

With that we've got more consistent global reserve stealing handling in evict,
and I've cleaned up the reservation path so I no longer have to worry about a
couple of places where we were doing
btrfs_reserve_metadata_bytes(root->extent_root).  Thanks,

Josef Bacik (4):
  btrfs: make BTRFS_RESERVE_FLUSH_EVICT use the global rsv stealing code
  btrfs: remove global rsv stealing logic for orphan cleanup
  btrfs: get rid of root->orphan_cleanup_state
  btrfs: change root to fs_info for btrfs_reserve_metadata_bytes

 fs/btrfs/block-group.c    |  2 +-
 fs/btrfs/block-rsv.c      | 12 +++++++-----
 fs/btrfs/block-rsv.h      |  4 ++--
 fs/btrfs/ctree.h          |  9 ++-------
 fs/btrfs/delalloc-space.c |  2 +-
 fs/btrfs/delayed-inode.c  |  2 +-
 fs/btrfs/delayed-ref.c    |  4 ++--
 fs/btrfs/disk-io.c        |  1 -
 fs/btrfs/inode.c          | 21 ++++++++-------------
 fs/btrfs/props.c          |  5 +++--
 fs/btrfs/relocation.c     | 17 +++++++++--------
 fs/btrfs/root-tree.c      |  2 +-
 fs/btrfs/space-info.c     | 34 ++++++++++++++++++++++++----------
 fs/btrfs/space-info.h     |  2 +-
 fs/btrfs/transaction.c    |  4 ++--
 15 files changed, 64 insertions(+), 57 deletions(-)

-- 
2.26.3

