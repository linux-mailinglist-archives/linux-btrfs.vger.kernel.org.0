Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DBF3B3D0D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jun 2021 09:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFYHPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Jun 2021 03:15:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59658 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhFYHPr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Jun 2021 03:15:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EB38C21BF2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Jun 2021 07:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624605205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZPh06r0sla+y+ayTKjoDVkYYvYzKQV3Y+71SQbif7JQ=;
        b=n3M/evAjin22TP78JIhZimFk3GTq6tJV5jx/WQ6xZKLXlkkin5KrZ8O2iZKemP2smedCcr
        hRm0+smtiVZIaX9EJVFOaVGBkUppdwxtz9HfXx7mmW2xIGOvMqaYX5abP1RgOlPEPvnXTq
        fkZr42QU4HUhoJLEvkWgxIoEtn/lpKc=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id E6989A3BB4
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Jun 2021 07:13:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: detect and fix orphan roots without orphan items
Date:   Fri, 25 Jun 2021 15:13:19 +0800
Message-Id: <20210625071322.221780-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is bug report from Zhenyu Wu <wuzy001@gmail.com>, where even there
is only one subvolume, his filesystem still consumes way more space than
expected.

The problem is, there are 58 snapshots, but all of them have no
ROOT_REF/ROOT_BACKREF, and all their root refs is 0.

But strangely there is no orphan items for them.

This means, btrfs kernel module won't detect them as orphan nor queue
them to be removed.

"btrfs subvolume delete -i" do no helps, as it still requires
ROOT_BACKREF to resolve the dentry.

For now, we should teach btrfs check to detect and repair the case by
adding new orphan items for them.

The root cause I guess is some strange behavior for orphan item insert
and subvolume unlink.
As the report mentioned that he had one forced power off.

Qu Wenruo (3):
  btrfs-progs: check/lowmem: add the ability to detect and repair orphan
    subvolume trees which doesn't have orphan item
  btrfs-progs: check/original: detect and repair orphan subvolume
    without orphan item
  btrfs-progs: fsck-tests: add test image for orphan roots without an
    orphan item

 check/main.c                                  |  37 ++++--------
 check/mode-common.c                           |  56 ++++++++++++++++++
 check/mode-common.h                           |   3 +
 check/mode-lowmem.c                           |  42 +++++++------
 .../048-orphan-roots/.lowmem_repairable       |   0
 .../048-orphan-roots/default.img.xz           | Bin 0 -> 2584 bytes
 6 files changed, 93 insertions(+), 45 deletions(-)
 create mode 100644 tests/fsck-tests/048-orphan-roots/.lowmem_repairable
 create mode 100644 tests/fsck-tests/048-orphan-roots/default.img.xz

-- 
2.32.0

