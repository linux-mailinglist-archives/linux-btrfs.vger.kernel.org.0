Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07598220A6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 12:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgGOKsx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 06:48:53 -0400
Received: from [195.135.220.15] ([195.135.220.15]:37910 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgGOKsx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 06:48:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C377EAAE8;
        Wed, 15 Jul 2020 10:48:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/5] Convert seed devices to proper list API
Date:   Wed, 15 Jul 2020 13:48:45 +0300
Message-Id: <20200715104850.19071-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series converts the existing seed devices pointer in btrfs_fs_devices to
proper list api. First 4 patches are cleanups preparing the code for the switch.
Patch 5 has more information about the required transformations, it might seem
lengthy but he logic everywhere is pretty much the same so shouldn't be that
cumbersome to review.

This series survived xfstest runs and even caught 2 bugs while developing it.

Nikolay Borisov (5):
  btrfs: Factor out reada loop in __reada_start_machine
  btrfs: Factor out loop logic from btrfs_free_extra_devids
  btrfs: Make close_fs_devices return void
  btrfs: Simplify setting/clearing fs_info to btrfs_fs_devices
  btrfs: Switch seed device to list api

 fs/btrfs/disk-io.c |  39 +++++------
 fs/btrfs/reada.c   |  26 ++++---
 fs/btrfs/sysfs.c   |   4 --
 fs/btrfs/volumes.c | 166 ++++++++++++++++++++-------------------------
 fs/btrfs/volumes.h |   6 +-
 5 files changed, 112 insertions(+), 129 deletions(-)

--
2.17.1

