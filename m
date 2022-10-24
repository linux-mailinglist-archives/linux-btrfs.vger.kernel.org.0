Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2760BA6F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 22:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiJXUhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 16:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiJXUge (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 16:36:34 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A391C1413AD
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:15 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a18so6681534qko.0
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/MbRxPeOJAxRICBCzPyw5SwEOXMMs2vpYHoZD9Ef3I=;
        b=IbeNiXuabi+VB4jgJyZpSKbKOkOILHruw2hXKqiTomLjS7Z1dq+zju7n69uShepSmR
         QE2KXysK63OfrArvCfz63gTOtwoO0dt80tKg/9pAFmdeRXtLKnALIHlmq5GPRP/+9dwn
         QZiRi2AaqxYr4sbdVLEB96fwWWkUi2F9aD1SfNNig7Tgj79hHxDN+CsLIPwelb2SOea9
         yEi1Lu+nV36r8QnxU5+X2aOgH7UnmL968l2WiUZDGC4VRUJt4V7gQl/BudvBkqCHs537
         rYTnAWev6mCSa6t3a3endC82UgckS0ZZ1LxNWxwhC/EHAztA7LIeY60gPkOeSb97Xywq
         9P4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/MbRxPeOJAxRICBCzPyw5SwEOXMMs2vpYHoZD9Ef3I=;
        b=7JDmVDazsoIQPM+oX6rvayzCs8B3ZpTXT4Ojav2fWSR3txz6pA+j0VpqZxxmamYf9r
         P4Xl0kYMeuo2LP6zuPjBPJifAAzvoLkos3AbiLSNsUCDDU8eIORISWCqjprSbOJdRvV7
         oqJX9oevbMgC9vILdwzICzKWViuFsXoyfYrDITgHXX69tfrzBKOtu8gJWRMNQvaNRAgu
         fDpVq8QXF8oYrN7Xa+FNm/RQj5QxEjl6p+hZYxjwBLJyzSNTg9+4mvH5L/UydlJ/tyNw
         Q2u9At6eIsRv+5Irq7eh/JNJCOJ4c1Uu3UWRwXiWodQRYLSLxDsGv4sDEa/vKEfDIiQU
         i8/w==
X-Gm-Message-State: ACrzQf3iqaft0iVbi5QHsQ2ORJHH8+0QC4Bu5jAtlGyYsJa7IWhS4CVF
        0/syo5/K37IHyfoEKBwFeF7BTcLPufymLQ==
X-Google-Smtp-Source: AMsMyM7a1yqR1squPdCGrX0kksgGV0smQ8z/fXtQbkA5ybbs3JOlogx4evURQCPMK28FAAHZ3PLcZg==
X-Received: by 2002:a05:620a:458d:b0:6ee:e940:4a6a with SMTP id bp13-20020a05620a458d00b006eee9404a6amr24085148qkb.235.1666637222685;
        Mon, 24 Oct 2022 11:47:02 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id k7-20020a05620a414700b006be8713f742sm484346qko.38.2022.10.24.11.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:47:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/9] btrfs: move btrfs_fs_info and some prototypes
Date:   Mon, 24 Oct 2022 14:46:51 -0400
Message-Id: <cover.1666637013.git.josef@toxicpanda.com>
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

This is the next batch of ctree.h cleanups, and likely the last one for a little
bit.  The remaining prototypes in ctree.h are going to be touched by a lot of
work that's currently happening, and I don't want to mess with peoples work now
that we're getting into the development cycle a little bit.

The big thing I've done is moved btrfs_fs_info into fs.h.  This is relatively
painless at this poing since I've organized everything up to now so I can just
copy and paste the big chunk of it out of ctree.h into fs.h.

Then I've gone through and cleaned up a lot of randomm little things, and then
moved some prototypes into their own headers.

I stopped where we got to the name stuff, as I know the fscrypt stuff is going
to touch all of that.  I don't want to make that harder to merge, so I've
stopped here so that code can go in when it's ready, and then we can pick back
up cleaning up the rest of ctree.h.

The entirety of these changes are just code moving, there's been no functional
changing.  Thanks,

Josef

Josef Bacik (9):
  btrfs: move btrfs_fs_info declarations into fs.h
  btrfs: move the lockdep helpers into locking.h
  btrfs: minor whitespace in ctree.h
  btrfs: remove extra space info prototypes in ctree.h
  btrfs: move btrfs_account_ro_block_groups_free_space into space-info.c
  btrfs: move extent-tree helpers into their own header file
  btrfs: move delalloc space related prototypes to delalloc-space.h
  btrfs: delete unused function prototypes in ctree.h
  btrfs: move root tree prototypes to their own header

 fs/btrfs/backref.c         |   1 +
 fs/btrfs/block-group.c     |   1 +
 fs/btrfs/ctree.c           |   1 +
 fs/btrfs/ctree.h           | 854 +------------------------------------
 fs/btrfs/delalloc-space.h  |   3 +
 fs/btrfs/disk-io.c         |   2 +
 fs/btrfs/extent-tree.c     |  36 +-
 fs/btrfs/extent-tree.h     |  76 ++++
 fs/btrfs/file.c            |   1 +
 fs/btrfs/free-space-tree.c |   2 +
 fs/btrfs/fs.h              | 657 ++++++++++++++++++++++++++++
 fs/btrfs/inode-item.c      |   1 +
 fs/btrfs/inode.c           |   2 +
 fs/btrfs/ioctl.c           |   2 +
 fs/btrfs/locking.h         |  76 ++++
 fs/btrfs/qgroup.c          |   2 +
 fs/btrfs/relocation.c      |   2 +
 fs/btrfs/root-tree.c       |   1 +
 fs/btrfs/root-tree.h       |  36 ++
 fs/btrfs/space-info.c      |  35 ++
 fs/btrfs/space-info.h      |   1 +
 fs/btrfs/transaction.c     |   2 +
 fs/btrfs/tree-log.c        |   2 +
 23 files changed, 909 insertions(+), 887 deletions(-)
 create mode 100644 fs/btrfs/extent-tree.h
 create mode 100644 fs/btrfs/root-tree.h

-- 
2.26.3

