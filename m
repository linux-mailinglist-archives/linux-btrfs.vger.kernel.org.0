Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FE568DE54
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 17:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjBGQ5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 11:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjBGQ5a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 11:57:30 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2163BD8F
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 08:57:29 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c2so17436521qtw.5
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Feb 2023 08:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/eqUPeDubSHqAKYlG4a6Zd2I0FSGhm2iJyMdziRqqSw=;
        b=BLcJHuZh2FrlXIMLzLMTWIMr9oOiBk0QlLWQzTqLSFW9I+BhyG4IY71CbHLdvS8ACH
         eutJyz7fqMtz+sMTuo7yZtSzVD73hos05/XiFhJW1B9p0C5sAbUmsS1t3mtVwILi3UaK
         FjQ8Di/6QBVZrmLKANeMjQpX70hlDt48Tikxo7m+/bJHCc8+XBMoYPB1BU1twVY8+0P1
         eEZ2Gtfz9H8+A3o4rxyrIbN5+7QdJ8+ptSEzTYrB01I9jpuZ/G6VDJFb1+h0tUjJHiE7
         EaYY5Q65dXPSy9s18HDwlylnVEYpP2Smehns+8UT2lJvKKrEw76v1i9HAgkYt9L/fa7l
         HOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eqUPeDubSHqAKYlG4a6Zd2I0FSGhm2iJyMdziRqqSw=;
        b=mYv9y7k7MjOGOAbhO82zy7Ew97K7AT++ywZ6wZotyOtiwcN1gUY8eo82lCF+h5PS/I
         4+w+aOnNv5OCqzQyXXQvijRt21/yBvwG/yJrpdFnRlaocZQlGH71QVCSGYPJBBs34G2o
         9M6Ibl+dvP+pU8vCRvTEBmB+XsDEWFUKdk/NchxHPFTQlG2nJHAcdD/39ifvYLioofSU
         Ab94Ru8p9B8T+8zp5NiEjUbUh5hiEvPtnWswlPW1V7COPxD1FbwbTuaMshJ8vxd2DIPH
         r5xEGOTTEmNcEZVwWp1PGCGf8LnJZVbQZCxxDWplCfjgpO4VzZHWqSk5c64vhV+BRFND
         TwjA==
X-Gm-Message-State: AO0yUKV0udNJfT0HI8X3sbVmZQaqMMncEht8Drwc4LoRX46l2uOLpmpF
        tHGGQLLbDoeByfQVFYNKcZp0MqezSh8Kjdte9AA=
X-Google-Smtp-Source: AK7set/BM+6le1WxUauSidnJ4AYoBkEoB2AcCI7Q0nVZXlQzIVDNsEND/el6ACm6ymGFUtkV4ngI4g==
X-Received: by 2002:a05:622a:134a:b0:3b8:4e37:50ea with SMTP id w10-20020a05622a134a00b003b84e3750eamr7146708qtk.58.1675789047705;
        Tue, 07 Feb 2023 08:57:27 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id pe4-20020a05620a850400b0071ada51ab48sm9813517qkn.37.2023.02.07.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:57:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/7] Error handling fixes
Date:   Tue,  7 Feb 2023 11:57:18 -0500
Message-Id: <cover.1675787102.git.josef@toxicpanda.com>
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

Hello,

For a short period of time our btrfs backport had 947a629988f1 ("btrfs: move
tree block parentness check into validate_extent_buffer()") without the
associated fix, which resulted in a lot of hilarity.

One of the things that popped was a WARN_ON(ret == 1) in __btrfs_free_extent
where we didn't find the bytenr we were looking for.  This was troubling, as it
appeared that we were losing the EIO and returning 1 from btrfs_search_slot.

I rigged up my error injection stress test with
btrfs_check_leaf/btrfs_check_node with balance (as this was the path that we saw
the error).  This of course uncovered a few other unrelated things, but
eventually I reproduced what we saw in production.  Thankfully it was not that
we were eating the -EIO and returning 1 instead, however the actual problem is
worse.  We do not handle the errors properly in snapshot delete (which also gets
used by reloation), and then we do not abort the transaction when we hit errors
in this path, which leads to the file system being corrupted and eventually
triggers the above WARN_ON().

With these fixes in place my stress testing was running overnight without
tripping over any other leaks, corruptions, or panics.  Previously I wasn't able
to run for longer than a couple of minutes without falling over.  Thanks,

Josef

Josef Bacik (7):
  btrfs: use btrfs_handle_fs_error in btrfs_fill_super
  btrfs: replace BUG_ON(level == 0) with ASSERT(level)
  btrfs: handle errors from btrfs_read_node_slot in split
  btrfs: iput on orphan cleanup failure
  btrfs: drop root refs properly when orphan cleanup fails
  btrfs: handle errors in walk_down_tree properly
  btrfs: abort the transaction if we get an error during snapshot drop

 fs/btrfs/ctree.c       | 55 +++++++++++++++++++++---------------------
 fs/btrfs/disk-io.c     |  4 +--
 fs/btrfs/extent-tree.c | 10 +++++---
 fs/btrfs/inode.c       |  5 +++-
 fs/btrfs/super.c       |  1 +
 5 files changed, 40 insertions(+), 35 deletions(-)

-- 
2.26.3

