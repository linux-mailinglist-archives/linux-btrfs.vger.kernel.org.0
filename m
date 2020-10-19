Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0C6292F10
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Oct 2020 22:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgJSUCf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Oct 2020 16:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgJSUCe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Oct 2020 16:02:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF57C0613CE
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Oct 2020 13:02:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b69so787436qkg.8
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Oct 2020 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GkxikNxpxvF1pBlcz2yyfl5uLoQR9BL1plj7bYp6F3g=;
        b=oVlW9uGa/KmsjgbFxtv+Hu868UyTDMaPK+N0ljxoYut3t7tiEF7afaB08FIIUHsFe4
         mD41tPAKKK/eWJldRqSGm+YcqeWgKwtINSCyerF9SyTTROUV/6qT5zdhDhzi21neb3wA
         /KNTjLbJThdl+9sEmD9NiX3ohc3W/ZSNvh0jgQNG3NSrETVjV1M4iXHcyb+xShYept6u
         I9M1eTZ3onj1n9kQuk/cIdvQOBY6qD9tMa4AdMd2r+rWl/hNgvwdqR/Gmp8G/XVhmLVf
         lsA1z+1r9XZxELdSLJWN0gtVqrlYF0A5ZNp5CfwMY6JqkwFl42Ju6T//zJbvXg5E39/V
         ZaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GkxikNxpxvF1pBlcz2yyfl5uLoQR9BL1plj7bYp6F3g=;
        b=Gx4k9EoC6YdfqrMmp5PxdUjzdJTZ/lHl7afcDegOJ9RzrJ50UWoddK3Fjlv6KWGwGS
         jUXxNGeNs5cz/dxIFT7RMr4hqvdusG5FMMcNUXM6zZGEF0PL4hQtxID5LR9GBYg/jvbL
         5tVPtORZsdRkO7SZGD4B8sBm50UgP8WfX9wgu1UpXtHV3UFm5b8PHe2eLFPfdPLaH6fe
         kOwr/5xlprlWY82UP9Wre3uaGDNt9ct1KpXDklp8rJhaP5y4Ij9DBApe6rr1gBiFQn8D
         GjIriHQwKcFtYfvJ1JUhQirNlaHp3f2TkyC9cYml33KSpU5EIsD/ParbraAIV19OKohq
         Sy5w==
X-Gm-Message-State: AOAM530G++fyXekMKhTpr8zLDU9LHUiFdlhIx8U6Aw4/uK77VVVXUaK+
        41+OPU9IsIhvElKnDGrB/OYXOJP5/olEvgii
X-Google-Smtp-Source: ABdhPJz3P6itPaoRVOGP0DGILrqCIPdZhF/CkljfsDTlvM/9UZZHN2lvIuT1AuuZb0iaVaZHNyi9vA==
X-Received: by 2002:a05:620a:14a9:: with SMTP id x9mr1303765qkj.47.1603137753379;
        Mon, 19 Oct 2020 13:02:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n205sm445095qke.43.2020.10.19.13.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:02:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] Lockdep fixes for misc-next 
Date:   Mon, 19 Oct 2020 16:02:28 -0400
Message-Id: <cover.1603137558.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Here's a few lockdep fixes for misc-next+my rwsem patch.  Nothing too crazy, but
the last one is a little wonkey because qgroups does a backref resolution while
adding delayed refs.  Generally we do the right thing with searching the commit
roots and skipping the locking, with the exception of looking up fs roots if we
have to resolve indirect refs.  This obviously uses the normal lookup and
locking stuff, which is problematic in the new world order.  For now I'm fixing
it with a special helper for backref lookups that either finds the root in
cache, or generates a temporary root that's not inserted into the fs roots radix
tree and is only used to do the backref resolution.  Thanks,

Josef

Josef Bacik (3):
  btrfs: drop the path before adding qgroup items when enabling qgroups
  btrfs: protect the fs_info->caching_block_groups differently
  btrfs: add a helper to read the tree_root commit root for backref
    lookup

 fs/btrfs/backref.c     | 14 +++++++-
 fs/btrfs/block-group.c | 12 +++----
 fs/btrfs/disk-io.c     | 79 +++++++++++++++++++++++++++++++-----------
 fs/btrfs/disk-io.h     |  3 ++
 fs/btrfs/extent-tree.c |  2 ++
 fs/btrfs/qgroup.c      | 16 +++++++++
 6 files changed, 98 insertions(+), 28 deletions(-)

-- 
2.26.2

