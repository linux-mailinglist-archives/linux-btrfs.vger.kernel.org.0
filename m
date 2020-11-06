Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89C62A9F0D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 22:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgKFV1l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 16:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFV1l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 16:27:41 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFA5C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 13:27:39 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id r7so2474214qkf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 13:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P83gXGVfhGmZBx0oWNh9axJuVieA5PWULbRlqHh8SXs=;
        b=QBe7u7D48mE7C6f9jBK9rkKbtzGBwmL5BgrfpLxg3T8fDky4jKT9CAtkdMYQ3wfSvz
         VzUREPZF4rEwx4DCri5gT1l/nano4hsS85/mOOeggoQo2z+z4K/syDvOBUnqMs+xzQHl
         cTj3gJ8Szk2r1krGOgY167gEHaZw8JlGsnKKNT/sOrBEe2KTy6WxMUeKoHDPu5LFwyKx
         0ORKe0INt0slWknLb+nvO9TIkTPv9RQxklGXhSIHUqpy7Z6amIc5Mn2DO2obN/mgko7b
         EyAwT6Q4hihJ0tP2A7LT7LI9eKrpzmFB4JE3WvFXoRHmoFyqqZiGFaHk7i5rpRsuN413
         tkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P83gXGVfhGmZBx0oWNh9axJuVieA5PWULbRlqHh8SXs=;
        b=db8cAtp6vUVtCaYpRNWurA7W7rBul8sYOlAKlsXaBq2uqPSsbGIzEliHLuoxbKyznp
         5ZR5eWYDItHdFNF27lOVGPjQirv4q53cGE+VUZZJyFMZAH4mdM2BN0zrRDo7Um1NqiFZ
         BV4kkRByLKPe74PUde5yxpT6W7unga6Wx3Y2mah1HR5tQbMinuAKa5Wab/BdNhPs8Enn
         GXCCfhBI9UrEGPfvnGq1nwIySvs/KS1uxtgmUECVJt/HfIM+1m6JK5k7pYRKKHJvzgMu
         GYG1lNoQyu6Mur07y2MBhLcZmeiBZoI0GJcGwVrEz9eUpttDhUDwGINuFr1s5tUTvBwR
         VnFw==
X-Gm-Message-State: AOAM532db6OsTiOZzlTw90fr49cWswCrbokXrOwxpIL6l8RkdtD/zD79
        Ymn8tsE4bda7uoAFpc/gRvzTxnrrlEiGwm7g
X-Google-Smtp-Source: ABdhPJx0nXj4c00ek7+uIyTj/2vIjRfGxeo9LL0aHNT7QB5bicfC7x1BYLqmQZ0gj7EGxQ+CqKr0ig==
X-Received: by 2002:a37:b985:: with SMTP id j127mr3569447qkf.282.1604698058699;
        Fri, 06 Nov 2020 13:27:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 197sm1469175qkn.113.2020.11.06.13.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:27:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8] Locking cleanups and lockdep fix
Date:   Fri,  6 Nov 2020 16:27:28 -0500
Message-Id: <cover.1604697895.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Filipe reported a lockdep splat that he hit on btrfs/187, but honestly could be
hit anywhere we do readdir on a sufficiently large fs.  Fixing this is fairly
straightforward, but enabled me to do a lot of extra cleanups, especially now
that my other locking fixes have been merged.  The first two patches are to
address the lockdep problem.  The followup patches are cleaning out the
recursive locking support, which we no longer require.  I would have separated
this work, but btrfs_next_old_leaf was a heavy user of this, so it would be
annoying to take separately, hence putting it all together.  Thanks,

Josef

Josef Bacik (8):
  btrfs: cleanup the locking in btrfs_next_old_leaf
  btrfs: unlock to current level in btrfs_next_old_leaf
  btrfs: kill path->recurse
  btrfs: remove the recursion handling code in locking.c
  btrfs: remove __btrfs_read_lock_root_node
  btrfs: use btrfs_tree_read_lock in btrfs_search_slot
  btrfs: remove the recurse parameter from __btrfs_tree_read_lock
  btrfs: remove ->recursed from extent_buffer

 fs/btrfs/ctree.c     | 47 +++++++++++++----------------
 fs/btrfs/ctree.h     |  1 -
 fs/btrfs/extent_io.c |  1 -
 fs/btrfs/extent_io.h |  1 -
 fs/btrfs/locking.c   | 72 +++-----------------------------------------
 fs/btrfs/locking.h   | 11 ++-----
 6 files changed, 28 insertions(+), 105 deletions(-)

-- 
2.26.2

