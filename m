Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B0A6E832C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjDSVOC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDSVOB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:01 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA603AA4
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:13:59 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id qh25so1114149qvb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681938838; x=1684530838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+1jazNBCw1U4q4Oc3PFQV1+r4vLO2puCLaMCULmgRg=;
        b=heQqZvboXaqIjOunkqMiSDEIoB92VRzCtCBCU6rZYD/001pyaLuvhS+0A+P3pTVUoK
         Ll/7x9w9U4WRBWd7CGwGNF5xXk/Qo2PfiBCAaMmy8l4nhpwkE25bQeA6C/o6S7MpZTVL
         qmayxAM5ysE//RziYQl0IWg/lZhw7hfOffGYgvLy010MJMZVay9rU0Rh7588cF+IYNnj
         wmQuZ6/UVDXycFN9klwcAL5cEj0wLi46iDNE48NcZsW3vdVh4an2buW2rs/R9Rh/JyUR
         Kme46zqNkfcbVSlyNO912fyCqWYIotu/WPDBIxobAKHiOwR59rGIN3WwASlB/+5sltxm
         3xjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938838; x=1684530838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+1jazNBCw1U4q4Oc3PFQV1+r4vLO2puCLaMCULmgRg=;
        b=Scqyi5ukANlnwSoHbz2mb0dzSuXwrPBxyfSezAnD7eM1Lp2FQjZBMUGJMNr3NhkpHk
         BioYD1+ySMVWzxtRUzvs42QqbdSSxOvJ4CEeNBYFsINseUaPR0idlz6UezVIIJHf25u/
         DZeSWFExHr7B4heS1j0097TOCCbaIq0nWjfAEQazuqoBavtVcyFKpY/bGORYzKYxr22w
         ++2CYFPDhskKen3xR2XpCYaYvqe4CIg2+d5YklKRthXZuTsLaaXzOwO+mIIWyOAj7B62
         vTULZPEGBxxwoidMshJK9HkeYIbYfoZUMK5HUZ2jV5EEx+nOtuxbI30xDk1HHtd+pIxP
         wmKg==
X-Gm-Message-State: AAQBX9ftx+0vnetSsRKC26EClkNfzl1vgN5rbabvQcGztmJ3gFh28kfj
        7kTjauUI2NQq2EMHicRHIDPVfeCEPG2QQEQWp3F00w==
X-Google-Smtp-Source: AKy350buK8ATHSjt9ylbFYdt+tuPQW8eIdI/LtuB/LHQ6nLx5ljqWD2TK59NyxlgSuTNp4Emu82+gg==
X-Received: by 2002:a05:6214:76e:b0:5e0:2d2a:33d5 with SMTP id f14-20020a056214076e00b005e02d2a33d5mr22033073qvz.39.1681938838474;
        Wed, 19 Apr 2023 14:13:58 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id g16-20020a05620a279000b00748676d89e7sm1195721qkp.8.2023.04.19.14.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:13:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/11] btrfs-progs: prep work for syncing files into kernel-shared
Date:   Wed, 19 Apr 2023 17:13:42 -0400
Message-Id: <cover.1681938648.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
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

Hello,

These a variety of fixes, cleanups, and api changes to make it easier to sync
recent kernel changes into btrfs-progs.  They're relatively straightforward, and
have been run through the tests.  Thanks,

Josef

Josef Bacik (11):
  btrfs-progs: fix kerncompat.h include ordering for libbtrfs
  btrfs-progs: use $SUDO_HELPER in convert tests for temp files
  btrfs-progs: re-add __init to include/kerncompat.h
  btrfs-progs: introduce UASSERT() for purely userspace code
  btrfs-progs: move BTRFS_DISABLE_BACKTRACE check in print_trace
  btrfs-progs: remove the _on() related message helpers
  btrfs-progs: consolidate the btrfs message helpers
  btrfs-progs: rename the qgroup structs to match the kernel
  btrfs-progs: remove fs_info argument from btrfs_check_* helpers
  btrfs-progs: add a btrfs check helper for checking blocks
  btrfs-progs: remove parent_key arg from btrfs_check_* helpers

 check/clear-cache.c         |  4 +-
 check/main.c                | 26 ++++-------
 check/mode-common.c         | 12 ++---
 check/mode-lowmem.c         | 31 ++++++-------
 check/qgroup-verify.c       | 16 +++----
 check/repair.c              | 29 ++++++++++++
 check/repair.h              |  3 +-
 cmds/filesystem-du.c        |  2 +-
 cmds/filesystem-usage.c     |  6 +--
 cmds/qgroup.c               | 42 ++++++++----------
 cmds/replace.c              |  4 +-
 cmds/rescue-chunk-recover.c |  6 +--
 cmds/rescue.c               |  4 +-
 cmds/subvolume-list.c       | 20 ++++-----
 common/device-utils.c       |  4 +-
 common/messages.c           | 69 +----------------------------
 common/messages.h           | 56 ++++++++++++++---------
 common/units.c              |  4 +-
 convert/common.c            |  4 +-
 convert/main.c              |  2 +-
 image/main.c                |  2 +-
 include/kerncompat.h        | 14 ++----
 kernel-shared/ctree.c       | 43 ++++--------------
 kernel-shared/ctree.h       | 88 ++++++++++++++++++-------------------
 kernel-shared/disk-io.c     |  4 +-
 kernel-shared/print-tree.c  | 18 ++++----
 libbtrfs/ctree.h            |  4 +-
 libbtrfs/send-stream.c      |  3 +-
 libbtrfs/send-utils.c       |  2 +-
 mkfs/main.c                 |  4 +-
 tests/common.convert        | 16 +++----
 31 files changed, 231 insertions(+), 311 deletions(-)

-- 
2.39.1

