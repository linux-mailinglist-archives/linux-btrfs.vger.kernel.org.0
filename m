Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E774CC9ED
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiCCXUJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiCCXUH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:20:07 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B923B285
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 15:19:21 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t187so1725261pgb.1
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 15:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4awC6VjgeW0OkclubdMPbX6MrFmGQ92JYHxAx/YGpE=;
        b=UmsHMJjpDJWDBKTqe2DxAFR6vUVR8j7K+UQWXseF0dKInYDPPKCKpqH31EheE9w6Ug
         ppsV08vdDKMGT7SWXaKGM+SylgCzlV8PhIM1akOz9tXCX6lmI2pITFMcrpDi51fzNpt2
         Vm1BslKDPjMgq4SFuTx2r0trWdHZkTxc1lgDJlIU2B2SXxnZlJeouZvdT3Mqd2y4uouM
         knrobiK3EOf+HdkxxJKgR++mx+bUhN7U+yvNnm6FAvVfZT4B4aHzYcCkHy8tZ/1IzjEQ
         dkLoKfDULieXlfC2SAwBRma8DJ6mpUGzktk/PO8yae3YweRpJNMuSSN6J6veidXEQaOa
         ylTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4awC6VjgeW0OkclubdMPbX6MrFmGQ92JYHxAx/YGpE=;
        b=qhgkcSmybRm6ewAXj9G5DgJO2akFJWu0ERaVy2FwxNTmoa+X+/2NCFFDOEBiJyDYrt
         dCIMwhiQ7F7shF/4o1xfcZCUwSlwfZlf/J11+ed+wCXEg5u2RiU5FLWQ35xNjMHtIn7q
         If0JFEVT0za+fU/0kS6kQeSkX356GtZnYDav9Hz0Jz4DklOFbJkocb2hy7ejK5Mykdp3
         WLArojXOpiEgpo5r6+WWEjuyDoB62T1Uq5ZhgC9tEHiQBQRO/aMH3Bv8AuC02UqJ4eri
         u2/a+0lb/u8j6jnwrphUB24QZ4Kmf/s6ppRHG1DfGKtKVct71HHLUvoRlYfUB2+xo8ex
         mQUw==
X-Gm-Message-State: AOAM531S/0Z01yjwJO6E35XUvY45OtN8eUUlFvGPedSyMuij/4q42JaN
        VJqu777GsyauQE8qFg5tjwhF9Zu9W4iCeA==
X-Google-Smtp-Source: ABdhPJzD5QLG23HoKXcnuG798p6rey1qaqSY64tfujrMDsz0BVOCafisiQ0p6yexZw3sYso6mkOA8w==
X-Received: by 2002:a65:6943:0:b0:376:333b:1025 with SMTP id w3-20020a656943000000b00376333b1025mr29428587pgq.164.1646349560225;
        Thu, 03 Mar 2022 15:19:20 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:76ce])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm1103507pja.23.2022.03.03.15.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:19 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 00/12] btrfs: inode creation cleanups and fixes
Date:   Thu,  3 Mar 2022 15:18:50 -0800
Message-Id: <cover.1646348486.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This series contains several cleanups and fixes for our inode creation
codepaths. The main motivation for this is preparation for fscrypt
support (in particular, setting up the fscrypt context at inode creation
time). But, it also reduces a lot of code duplication and fixes some
minor bugs, so it's worth getting in ahead of time.

Patch 12 is the main change, which unifies and simplifies all of our
inode creation codepaths. Patches 1-11 are small cleanups that I was
able to peel off of the big patch.

Thanks!

Omar Sandoval (12):
  btrfs: reserve correct number of items for unlink and rmdir
  btrfs: reserve correct number of items for rename
  btrfs: get rid of btrfs_add_nondir()
  btrfs: remove unnecessary btrfs_i_size_write(0) calls
  btrfs: remove unnecessary inode_set_bytes(0) call
  btrfs: remove unnecessary set_nlink() in btrfs_create_subvol_root()
  btrfs: remove unused mnt_userns parameter from __btrfs_set_acl
  btrfs: remove redundant name and name_len parameters to create_subvol
  btrfs: don't pass parent objectid to btrfs_new_inode() explicitly
  btrfs: move btrfs_get_free_objectid() call into btrfs_new_inode()
  btrfs: set inode flags earlier in btrfs_new_inode()
  btrfs: rework inode creation to fix several issues

 fs/btrfs/acl.c   |  39 +-
 fs/btrfs/ctree.h |  39 +-
 fs/btrfs/inode.c | 944 +++++++++++++++++++++++------------------------
 fs/btrfs/ioctl.c | 175 ++++-----
 fs/btrfs/props.c |  40 +-
 fs/btrfs/props.h |   4 -
 6 files changed, 581 insertions(+), 660 deletions(-)

-- 
2.35.1

