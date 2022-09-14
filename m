Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912D85B90D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiINXHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiINXHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:07:54 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C2387081
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:07:52 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id s9so9809384qkg.4
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=cFGsBWT9szEk3UEx8ZE8XPK2U3/YOBXqPFEDdMJBPMI=;
        b=UqciF5zf99WzZbRgmqWD3qKU4D4L6v1g+TK4BZtJf8GPhLIA3JYXjja6izLjn6K0iw
         b6+42NRizwdpEyRllrgZT9j2la5fwzyQxg9f24xO955+pzmyc50+mG2EfVYCC9aua7TV
         H8JDo3djwqXZUPGXaWocziXMUSK0kyY5iVrvmtl8dSM6kYfbvyVOpUbkF87oCpY7hSQr
         FlFedv1yZFNO5IP1ooQVU/zUDDRyCOAVHcSuEzqNSc2lcA8L3reayUE19fMCCrgntERJ
         ceErcAyb3gI+NLPVCdlzDqXWbhTJ7ixoOW/zkYWtL9VMT7Up+VixvYuUBGzdTzw1PKzw
         tTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=cFGsBWT9szEk3UEx8ZE8XPK2U3/YOBXqPFEDdMJBPMI=;
        b=RIiEQEYH+zA2qvxHaOP1/L3aMvG7n3qR+QeWCZaYultGgWTrTP7babPYg1C/biGckZ
         QxuQ8oba0/dt0TlTKtJCtPy38VjP4BJZpUikafBzrPIESEuJaoQVW8jm6Tlc9v0I/msP
         /MHaQqgKFyQnqASVXx8MR4bGRdlvjzpS/q4BPAKyQ7jOUOtUydqZaTyks0B8X7D7tCl8
         2s1jSZt8THAtCxV5+FrDyF2UpVqxOWP1WE3uvvolrpe3eD66c1AOg/CxFhkVVm3nmQG2
         Zh21d9V7uX4xKRVRPYz4K16Kzm2QmzoEetrff6WciQZZ60+DSFljzf0Zovj2B8ZZC+To
         pPYw==
X-Gm-Message-State: ACgBeo1FYZCnXGh2adyT3xKIrP0uTL93bklxFk7VQV+0cF2TFQzvkayG
        bpkX6M2wjtODSy825pJkc6fZU7PR1uqtqA==
X-Google-Smtp-Source: AA6agR7OW+wDHAscXONOkJAHJKrs6b9Uq4Om/NtszUcIofOauT1Llb0KLgh1MqD2rczQA8w2GvXcFw==
X-Received: by 2002:a05:620a:40c4:b0:6ce:9653:c09a with SMTP id g4-20020a05620a40c400b006ce9653c09amr2837213qko.219.1663196871678;
        Wed, 14 Sep 2022 16:07:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t21-20020a37ea15000000b006c61999caffsm2767419qkj.116.2022.09.14.16.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:07:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/10] btrfs: clean up zoned device helpers
Date:   Wed, 14 Sep 2022 19:07:40 -0400
Message-Id: <cover.1663196746.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

This is in the same vein as my other cleanups, however zoned has a lot of
different patches so I'm sending them as a group, additionally so I get the
appropriate review attention from the right people.

These cleanups are aimed at making any helpers inside of zoned.h only derefence
structs that are declared inside of zoned.h, which is just
btrfs_zoned_device_info.  This means moving helpers that aren't used anywhere
else into their respective C files, reworking some of the helpers, and other
related cleanups.  Thanks,

Josef

Josef Bacik (10):
  btrfs: add a helper for opening a new device to add to the fs
  btrfs: move btrfs_check_device_zone_type into volumes.c
  btrfs: move btrfs_can_zone_reset into extent-tree.c
  btrfs: move btrfs_check_super_location into scrub.c
  btrfs: move btrfs_zoned_meta_io_*lock to extent_io.c
  btrfs: move btrfs_clear_treelog_bg to extent-tree.c
  btrfs: move btrfs_zoned_data_reloc_*lock to extent_io.c
  btrfs: move btrfs_zoned_bg_is_full into block-group.c
  btrfs: make the zoned helpers take btrfs_zoned_device_info
  btrfs: delete btrfs_check_super_location helper

 fs/btrfs/block-group.c |   6 +++
 fs/btrfs/block-group.h |   1 +
 fs/btrfs/dev-replace.c |  10 +---
 fs/btrfs/extent-tree.c |  27 ++++++++++
 fs/btrfs/extent_io.c   |  30 +++++++++++
 fs/btrfs/scrub.c       |   8 +--
 fs/btrfs/volumes.c     |  49 ++++++++++++++---
 fs/btrfs/volumes.h     |   2 +
 fs/btrfs/zoned.c       |  20 +++----
 fs/btrfs/zoned.h       | 118 +++++------------------------------------
 10 files changed, 136 insertions(+), 135 deletions(-)

-- 
2.26.3

