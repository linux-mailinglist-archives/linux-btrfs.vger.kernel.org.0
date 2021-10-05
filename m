Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7342315F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 22:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhJEUOj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 16:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhJEUOi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 16:14:38 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA695C061749
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 13:12:47 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l13so342279qtv.3
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 13:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fi8dig7fuqso43xXmBVxI/dcm3mKfW9BZ+nSQd1VyAg=;
        b=oQpg2ba4NhISvM2lBMl6odT5Ot6BuW7/ovdjqW/BmtFIDWeMMgBMXxJyBPNSWIeSoX
         a493e97keioexzroMoYR5UFY5Kjtm97lOkYEiz0lOv+y1qdir+rEuTEHc8ReAhoOoJOa
         HHYOwzx4YEkiIbu84UBbO2P2XiYASxklHkCiD5rto56fqglg5AVoM2Gc22UYFvWFCk3U
         VzctQIlY/QkcorDS3cFgBDF3gmcime0/elD9W6QHLOs0R0vVTK4t2FzkGIgkMP8KxBi3
         gMmh5ULiSgxo1SEfsizXXG2zwFVrsUKhE/vJXt5c7jywm3zccpujPD2hOzmbl6kQAP13
         KHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fi8dig7fuqso43xXmBVxI/dcm3mKfW9BZ+nSQd1VyAg=;
        b=nTAwZn2Dk2Sxu+sI135548XjCVj7s88DtWJI1yXbcxs1V+5ravJnCk1H7Qai4bhIQR
         GSznR8kEKV+kNj1otMHLv9QvFv0gMUPuCWcuqJWRQY9598HUzdyQBQzDYemTHHz6Z5uW
         I9ieLCrCRZS7DEacgML89DTv2kfWTtNDPouxev9ntSCah0hNCOVtft0X44bVEkLCZwZV
         YZR6KCNXo+L5B5gl0gNigOS3PE0F9Mdj0EbA6kTfEirAvTz6j/tzFomnxycUthlFlhNL
         J6bc6IG7QoJsEL88TRI740DtXmDa3PH0lZWBvTG4gPgS9u8V/W7w9SvFNg8Ly6rhbup5
         2Ewg==
X-Gm-Message-State: AOAM533aI6U52H/fOMcuMKV4NjPpOy5xU4wqfSCeOY3VvnLk1eD5F+7g
        FlAVXoLLdp2Ox/sjWZF5sGj89AL0Iiwi3w==
X-Google-Smtp-Source: ABdhPJyYmtjfg4hvbIWuHrwkgrZ3tFAM69RAAohFT8pn2PC599ZcUohmrMA8X+bDEbH7+qj6/QmXPA==
X-Received: by 2002:ac8:718e:: with SMTP id w14mr22508895qto.316.1633464766634;
        Tue, 05 Oct 2021 13:12:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o66sm9524412qka.86.2021.10.05.13.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:12:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 0/6] Fix lockdep issues around device removal
Date:   Tue,  5 Oct 2021 16:12:38 -0400
Message-Id: <cover.1633464631.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3->v4:
- I had a fixup for assinging devid that I mis-merged into the wrong patch,
  fixed this up by putting it in the correct patch.

v2->v3:
- Dropped the patches that kdave already merged.
- Added some prep patches that Anand had that I need for my fixes.
- Reworked device lookup to take an args struct since we were getting a
  complicated mixture of function arguments.
- Reworked device removal to generate this args struct so we can pass it into
  device_remove in order to find the correct device to remove.

v1->v2:
- Rework the first patch as it was wrong because we need it for seed devices.
- Fix another lockdep splat I uncovered while testing against seed devices to
  make sure I hadn't broken anything.

--- Original email ---

Hello,

The commit 87579e9b7d8d ("loop: use worker per cgroup instead of kworker")
enabled the use of workqueues for loopback devices, which brought with it
lockdep annotations for the workqueues for loopback devices.  This uncovered a
cascade of lockdep warnings because of how we mess with the block_device while
under the sb writers lock while doing the device removal.

The first patch seems innocuous but we have a lockdep_assert_held(&uuid_mutex)
in one of the helpers, which is why I have it first.  The code should never be
called which is why it is removed, but I'm removing it specifically to remove
confusion about the role of the uuid_mutex here.

The next 4 patches are to resolve the lockdep messages as they occur.  There are
several issues and I address them one at a time until we're no longer getting
lockdep warnings.

The final patch doesn't necessarily have to go in right away, it's just a
cleanup as I noticed we have a lot of duplicated code between the v1 and v2
device removal handling.  Thanks,

Josef

Anand Jain (2):
  btrfs: use num_device to check for the last surviving seed device
  btrfs: add comments for device counts in struct btrfs_fs_devices

Josef Bacik (4):
  btrfs: do not call close_fs_devices in btrfs_rm_device
  btrfs: handle device lookup with btrfs_dev_lookup_args
  btrfs: add a btrfs_get_dev_args_from_path helper
  btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls

 fs/btrfs/dev-replace.c |  18 ++--
 fs/btrfs/ioctl.c       |  80 ++++++++-------
 fs/btrfs/scrub.c       |   6 +-
 fs/btrfs/volumes.c     | 215 +++++++++++++++++++++++++++--------------
 fs/btrfs/volumes.h     |  40 +++++++-
 5 files changed, 238 insertions(+), 121 deletions(-)

-- 
2.26.3

