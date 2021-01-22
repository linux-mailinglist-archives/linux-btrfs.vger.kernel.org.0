Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6618F2FFFFE
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 11:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbhAVKPy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 05:15:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:56126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbhAVJ7J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 04:59:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611309487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jvk0X0YA4edBTpokqgzFwclb/my95T3acqb6Sb/Tp3E=;
        b=Ivm+vf1uSyQzPkbXjPMoWneVyWv1PXqXz9ZmbLOYOiUw9N65pK+6gdXQ5Mz+DCdNpnpgg0
        WUGMQwFwdPi8l2Yc0VDKK0f3obZa+vzJZCNdUQzJxSNEyV/r8eivnmb2NNlXdsDqFVMmJ6
        VR8gT3Ofgw2rIMwJhSu4CerzMtnxt04=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE905AB9F;
        Fri, 22 Jan 2021 09:58:06 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 00/14] Make btrfs W=1 clean
Date:   Fri, 22 Jan 2021 11:57:51 +0200
Message-Id: <20210122095805.620458-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reworked patches to make touched kdocs adhere to the style described at
https://btrfs.wiki.kernel.org/index.php/Development_notes#Coding_style_preferences

Namely:

 * Removed function names from first line and left only short description
 * Aligned all arguments


Nikolay Borisov (14):
  btrfs: Document modified parameter of add_extent_mapping
  btrfs: Fix parameter description of btrfs_add_extent_mapping
  btrfs: Fix function description format
  btrfs: Fix parameter description in delayed-ref.c functions
  btrfs: Improve parameter description for __btrfs_write_out_cache
  btrfs: Document now parameter of peek_discard_list
  btrfs: Document fs_info in btrfs_rmap_block
  btrfs: Fix description format of fs_info parameter of
    btrfs_wait_on_delayed_iputs
  btrfs: Document btrfs_check_shared parameters
  btrfs: Fix parameter description of
    btrfs_inode_rsv_release/btrfs_delalloc_release_space
  btrfs: Fix parameter description in space-info.c
  btrfs: Fix parameter description for functions in extent_io.c
  lib/zstd: Convert constants to defines
  btrfs: Enable W=1 checks for btrfs

 fs/btrfs/Makefile           | 17 +++++++++++++
 fs/btrfs/backref.c          |  8 +++++-
 fs/btrfs/block-group.c      |  4 ++-
 fs/btrfs/delalloc-space.c   | 29 ++++++++++++---------
 fs/btrfs/delayed-ref.c      | 23 +++++++++--------
 fs/btrfs/discard.c          |  6 +++--
 fs/btrfs/extent_io.c        | 50 +++++++++++++++++++------------------
 fs/btrfs/extent_map.c       | 18 +++++++------
 fs/btrfs/file-item.c        | 22 ++++++++++------
 fs/btrfs/free-space-cache.c | 13 ++++++----
 fs/btrfs/inode.c            |  5 ++--
 fs/btrfs/space-info.c       | 46 ++++++++++++++++++----------------
 include/linux/zstd.h        |  8 +++---
 13 files changed, 151 insertions(+), 98 deletions(-)

--
2.25.1

