Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2395F64F238
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 21:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiLPUQF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 15:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiLPUQD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 15:16:03 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082C626A99
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:02 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id 3so3355642vsq.7
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e8LctSXk/S6Othyhj7nqmrG5VOPWLDg//1T0W7noTzo=;
        b=cVeK6bXwOpZUZ5BCOs3A2Z/GrW9yq54PWVolVwTEaYyCS08LcAZ9XthDiLw7TQFRVR
         3A/89ZAgiwk3YLjQVVZ3IrsppleUakeBS+eKF3TAG/D/gjP9be95dvZYjSRz0/5FLAJq
         uoXkAgM1oIHJcdn9iAJSCZCeaNZLgR3EuuftxkT68Fkkqdv3OgmSBoki/Mpc3KBM9Xjo
         EzsKnb/pVoYSA68dNYCKCK1SDyeSnx38YmnkdjyS7rC3qZJANaPVPDXXUjKtHbCd1nlA
         cNLgr/vihru/mxzCMKL8YZ3URGiPhON8yd9SRd4x8L38cB7h8+ZCeR1ECVIWIDrYxUze
         n0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8LctSXk/S6Othyhj7nqmrG5VOPWLDg//1T0W7noTzo=;
        b=l6g7CVArmCiajx3z1UOCs7BZsyxR7YxMSxtXNy0B+tBCb225bviBSd6Lui/K4peqhI
         ZlE9PFiXnUKtLnYrbi1f86Km+vq3VZGwh3m2/2Bz+96IQtRpd4FoJQoSx+zAlr+SwVf6
         IV2D2nOZ5a4dp/zzUaaZUwrPjTC6W4ySklSySKOiMzh82H9JPsKZq7IAGNbiFeflWzPF
         PmJDtQHSl7n1+QxVf6v4h8WLqURjJ0XSJ677AkrY3pWv79bY+pcAOBIB2aeGLsZNwe9V
         zdYQftgrsYtalVSJoT7ZoO+XA4VtCbxcvlxqX0NqaHZaqXzbmAbE8MDfB0cpJ8xaY5NQ
         Y6/w==
X-Gm-Message-State: ANoB5pn4W+LXhvucLWQ9tyQfudxCxuk7cfn6yF+2Vrff55dnAbt2W6c7
        Qsw6pC9+/w3NRri3z5AG60uHVj8GywVUFAmn8hA=
X-Google-Smtp-Source: AA0mqf58xM5ETw9fGTfIE9/EUfbEV6y4m0mzHV+8ssUlD//mXL7Uz93GWyKJzwZVnLpOQrhAdXvgwA==
X-Received: by 2002:a05:6102:5709:b0:3a7:a0fa:91f2 with SMTP id dg9-20020a056102570900b003a7a0fa91f2mr18508858vsb.0.1671221760657;
        Fri, 16 Dec 2022 12:16:00 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bi4-20020a05620a318400b006fb0e638f12sm2177885qkb.4.2022.12.16.12.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:16:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8] Fixup uninitialized warnings and enable extra checks
Date:   Fri, 16 Dec 2022 15:15:50 -0500
Message-Id: <cover.1671221596.git.josef@toxicpanda.com>
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

We had been failing the raid56 related scrub tests on our overnight tests since
November.  Initially I asked Qu to look into these as I didn't have time to dig
in, and he was unable to reproduce.  I assumed it was some oddity in my setup,
so I ignored it.  However recently I got a report that I regressed some of these
tests with an unrelated change.  When debugging it I found it was because of an
uninitialized return value, which would have been caught by more modern gcc's
with -Wmaybe-uninitialized.

In order to avoid these sort of problems in the future lets fix up all the false
positivies that this warning brings, and then enable the option for btrfs so we
can avoid this style of failure in the future.  Thanks,

Josef

Josef Bacik (8):
  btrfs: fix uninit warning in run_one_async_start
  btrfs: fix uninit warning in btrfs_cleanup_ordered_extents
  btrfs: fix uninit warning from get_inode_gen usage
  btrfs: fix uninit warning in btrfs_update_block_group
  btrfs: fix uninit warning in __set_extent_bit and convert_extent_bit
  btrfs: extract out zone cache usage into it's own helper
  btrfs: fix uninit warning in btrfs_sb_log_location
  btrfs: turn on -Wmaybe-uninitialized

 fs/btrfs/Makefile         |  1 +
 fs/btrfs/block-group.c    |  2 +-
 fs/btrfs/disk-io.c        |  2 +-
 fs/btrfs/extent-io-tree.c |  8 ++---
 fs/btrfs/inode.c          |  2 +-
 fs/btrfs/send.c           |  8 ++---
 fs/btrfs/zoned.c          | 75 ++++++++++++++++++++++++---------------
 7 files changed, 57 insertions(+), 41 deletions(-)

-- 
2.26.3

