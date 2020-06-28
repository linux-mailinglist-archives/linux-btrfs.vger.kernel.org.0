Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043A820C634
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jun 2020 07:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgF1FHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Jun 2020 01:07:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:50842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgF1FHW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Jun 2020 01:07:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6ECEAD7B
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jun 2020 05:07:20 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: add sysfs interface for qgroup
Date:   Sun, 28 Jun 2020 13:07:13 +0800
Message-Id: <20200628050715.60961-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset will add the following sysfs interfaces for qgroup:

  /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/reference
  /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/exclusive
  /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_reference
  /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_exclusive
  /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/limit_flags
   ^^^ Above are already in "btrfs qgroup show" command output ^^^
  
  /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_data
  /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_pertrans
  /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_prealloc

These interfaces are mostly for debug purpose, to give us a clear view
of which part is leaking.

Changelog:
v2:
- Add a new patch to change the return value type of
  btrfs_qgroup_level()

- Fix the wrong btrfs_sysfs_add_one_qgroup() call timming
  That function needs to allocate memory, thus can't be called in
  add_qgroup_rb() where some call sites are holding a spin lock.
  Delay btrfs_sysfs_add_one_qgroup() after add_qgroup_rb() until the
  spin lock is released.

- Skip qgroup sysfs interface for qgroup selftest
  This makes no sense for selftest to initialize the sysfs interface
  and since we don't initialize fs_devices->kobj either, it's not
  possible to utilize the sysfs interface in selftest.

- Use proper helpers for qgroup BTRFS_ATTRs

- Use more human-readable names in qgroup sysfs entries

- Remove the unneeded completion for qgroup


Qu Wenruo (2):
  btrfs: use __u16 for the return value of btrfs_qgroup_level()
  btrfs: qgroup: add sysfs interface for debug

 fs/btrfs/ctree.h                |   1 +
 fs/btrfs/qgroup.c               |  46 +++++++---
 fs/btrfs/qgroup.h               |  11 +++
 fs/btrfs/sysfs.c                | 151 ++++++++++++++++++++++++++++++++
 fs/btrfs/sysfs.h                |   6 ++
 include/uapi/linux/btrfs_tree.h |   4 +-
 6 files changed, 207 insertions(+), 12 deletions(-)

-- 
2.27.0

