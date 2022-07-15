Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0FA5767A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiGOTpd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 15:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGOTpd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 15:45:33 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF4D6392F
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:32 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id mi10so4438921qvb.1
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3pLLRif0+ITK0IF/iQ0NFU22dk08s8Bs8YCFtfz7GTU=;
        b=jt6grtQPv+5XfxbUnahgDU2qNJS5yre+3sK+z2sSxnoUoCvmB+mxR6zYmBz6qqNBeE
         9OmQ1nnsgGp04NyAGHJzSlpSBPjO8xXGjY37XxAJegWsckvlfmSmh0BFN75MTsAMWpcO
         aT14kwrLN33tOwVqLZ4RxNy0wAhjXZZfWfwemqimT+3tIjCqG8sD2Q/DWseownsNR1tX
         umMTw1ZNRFuXkmmVF/eBpIBClLxlNbyJK1W9bhM8rgRzT62qvX54Iwdukb2gtZ4rw9mZ
         z2M3RSQ6thXRHK023WjufolapWdru15ho3NJh/f7xCdSAmtiOVj3/LEaA2n2bdzKMmQe
         soeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3pLLRif0+ITK0IF/iQ0NFU22dk08s8Bs8YCFtfz7GTU=;
        b=jwHoSezkjk2fTcdYoJbAxd5gRfbGvON4jsWWJ9XTO1MFH8hU5c/4udRDA7rxRFQXjr
         MhNt0luJtoOgXxjjpbusI8oUKPa+6AO/dcDrV/z8r/fNSNAUnADl9eXjnXOBI+ExG/Mp
         tB2rUTpX3/kCUE8CyAGkay8guhnBswbjgd66M9gfbgXTID7ZSMcHIVQe3MXFM7IOSctc
         7TLkKmoUoM/MP9wIpy58YMuL8qBCOsfSns6FUoejVbJ6fBaX6ryY3Qp31QdPqttyqIiT
         gCMPI8O+tCJ3kFu8ypUPddbXeiffmD1oiHdhca/t9ixSNlugHcJ4WbbRAF+vWe1mbi8+
         4Hog==
X-Gm-Message-State: AJIora9oZIqD19HpQ4QEkGwM7wjee4vAtxPzV1JbKmCJdrA2/5binRQb
        nfLHzN0aCY+xKZzsz/xevhF1WDBRrKPUtA==
X-Google-Smtp-Source: AGRyM1sjCdtm5iXuBkIiqn0W8ZtzZ4pTwjmjq2IlXk5e54AnQnNksdS96bHuE1skndvLugCuwkpD3w==
X-Received: by 2002:ad4:4e89:0:b0:472:fd70:ff88 with SMTP id dy9-20020ad44e89000000b00472fd70ff88mr13622919qvb.97.1657914330747;
        Fri, 15 Jul 2022 12:45:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bl25-20020a05620a1a9900b006a787380a5csm4806640qkb.67.2022.07.15.12.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:45:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/9] btrfs: block group cleanups
Date:   Fri, 15 Jul 2022 15:45:20 -0400
Message-Id: <cover.1657914198.git.josef@toxicpanda.com>
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

v1->v2:
- I'm an idiot and didn't rebase properly, so adding the two other cleanups I
  had that I didn't send.
- Rebased onto a recent misc-next and fixed the compile errors.
- Realized that with the new zoned patches that caused the compile error that
  btrfs_update_space_info needed to be cleaned up, so added patches for that.

--- Original email ---

I'm reworking our relocation and delete unused block group workqueues which
require some cleanups of how we deal with flags on the block group.  We've had a
bit field for various flags on the block group for a while, but there's a subtle
gotcha with this bitfield in that you have to protect every modification with
bg->lock in order to not mess with the values, and there were a few places that
we weren't holding the lock.

Rework these to be normal flags, and then go behind this conversion and cleanup
some of the usage of the different flags.  Additionally there's a cleanup around
when to break out of the background workers.  Thanks,

Josef

Josef Bacik (9):
  btrfs: use btrfs_fs_closing for background bg work
  btrfs: simplify btrfs_update_space_info
  btrfs: handle space_info setting of bg in btrfs_add_bg_to_space_info
  btrfs: convert block group bit field to use bit helpers
  btrfs: remove block_group->lock protection for TO_COPY
  btrfs: simplify btrfs_put_block_group_cache
  btrfs: remove BLOCK_GROUP_FLAG_HAS_CACHING_CTL
  btrfs: remove bg->lock protection for relocation repair flag
  btrfs: delete btrfs_wait_space_cache_v1_finished

 fs/btrfs/block-group.c      | 142 +++++++++++++-----------------------
 fs/btrfs/block-group.h      |  21 +++---
 fs/btrfs/dev-replace.c      |  11 +--
 fs/btrfs/extent-tree.c      |   7 +-
 fs/btrfs/free-space-cache.c |  18 ++---
 fs/btrfs/scrub.c            |  16 ++--
 fs/btrfs/space-info.c       |  38 +++++-----
 fs/btrfs/space-info.h       |   6 +-
 fs/btrfs/volumes.c          |  16 ++--
 fs/btrfs/zoned.c            |  34 ++++++---
 10 files changed, 137 insertions(+), 172 deletions(-)

-- 
2.26.3

