Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB473D7EA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhG0Trw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhG0Trw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 15:47:52 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC1EC061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:47:52 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h27so10402908qtu.9
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5ATNRJVX6N7sRwY2h31PjQqIyzvPscaed0+Bd0tBiQ=;
        b=NPCqVaSEQDZ6qOxl3ShZytVjcUDxz4KeyK5n9UtLl0LJqg0Xk0wwSK8U1TPxXF+3vg
         TnzhWmJYeVBPEPFowBNBYGBMea6Fhmb9NKIZdpSUoVgTtETdj+xai7G4h58aomJ5z5tA
         UpcEjbWuWgcqWkj+TyNyHnSddEDhzMts2Vt53chI4plxp/FERmhpjnE8E+wZv0tUZYoS
         gLsnOU0rNxwu2CGqufP5GOSazV8k9SONAdV8hxEd92QmZhw/m2V/tFF3WC3glhVW4Qmr
         88TrUEWQOogDJk/Olw15nCjrn+LXPEX1SYoTDsMf2RGN+Fqz0NFqwGHguusTsrtfOuVB
         O3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5ATNRJVX6N7sRwY2h31PjQqIyzvPscaed0+Bd0tBiQ=;
        b=KaIxl1xNnepF8O0DHH+tmx+z52JA8dk06jCewZ5JxP6IRPLKkjfAPZkfkubM37zVZX
         Nfmw/Ie4vKbaLHm60a7Ga2QX2kzbAPw8h8OvwEOVozCczKRT0Q/tupmJQ/qBDVlNUIJn
         Fpnuq4NlAleuFek+V4EQ6/KVpB4/A/VeeOgH11CV+GPceU+yMZSwBjkxQUO0pNPaXddu
         CMlJRMCOIKvo+DUQwuB4ryh+a/jMJmipig25DssIMomldTbcC4eZu9X+URtFv6UcwFXf
         iiTOZIdo3dyEndvulH8BzPHEUZ4hH5ke4lhbOUBovhJs0Cu2kBH+sHrdshqm8GuGprBy
         PmJg==
X-Gm-Message-State: AOAM5335aQ8yNp7YlB7JbRA/9YdTFEh3huQToj0JMIbEhl3y+sW152pn
        5PWQEp0VHka578jNpWrlT/CQeqKmQEXAsWCk
X-Google-Smtp-Source: ABdhPJziCy4bvZwauv3zrMv7Hmf2dt0iB9fTdkrEsQ3hOYZlw6ijmbzK64TZrg3TPlbcqLwRtjlw8g==
X-Received: by 2002:ac8:7207:: with SMTP id a7mr21147039qtp.32.1627415270777;
        Tue, 27 Jul 2021 12:47:50 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j7sm1732142qtx.39.2021.07.27.12.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:47:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/6] Fix lockdep issues around device removal
Date:   Tue, 27 Jul 2021 15:47:42 -0400
Message-Id: <cover.1627414703.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

Josef Bacik (6):
  btrfs: do not check for ->num_devices == 0 in rm_device
  btrfs: do not take the uuid_mutex in btrfs_rm_device
  btrfs: do not read super look for a device path
  btrfs: update the bdev time directly when closing
  btrfs: delay blkdev_put until after the device remove
  btrfs: unify common code for the v1 and v2 versions of device remove

 fs/btrfs/ioctl.c   |  92 +++++++++++++++++--------------------
 fs/btrfs/volumes.c | 110 ++++++++++++++++++++-------------------------
 fs/btrfs/volumes.h |   3 +-
 3 files changed, 90 insertions(+), 115 deletions(-)

-- 
2.26.3

