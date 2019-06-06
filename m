Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F76A37269
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 13:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfFFLGU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 07:06:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:34774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727683AbfFFLGS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 07:06:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0583AE54
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2019 11:06:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/9] btrfs-progs: image: Data dump support, restore optimization and small fixes
Date:   Thu,  6 Jun 2019 19:06:02 +0800
Message-Id: <20190606110611.27176-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset can be fetched from github:
https://github.com/adam900710/btrfs-progs/tree/image_data_dump
Which is based on v5.1 tag.

This patchset contains the following main features:
- various small fixes for btrfs-image
  From indent misalign, SZ_* cleanup to too many core cores causing
  btrfs-image crash.

- btrfs-image dump support 
  This introduce a new option -d to dump data.
  Due to item size limit, we have to enlarge the existing limit from
  256K (enough for tree blocks, but not enough for free space cache) to
  256M.
  This change will cause incompatibility, thus we have to introduce a
  new magic as version. While keeping all other on-disk format the same.

- btrfs-image restore optimization
  This will speed up chunk item search during restore.

Qu Wenruo (9):
  btrfs-progs: image: Use SZ_* to replace intermediate size
  btrfs-progs: image: Fix a indent misalign
  btrfs-progs: image: Fix a access-beyond-boundary bug when there are 32
    online CPUs
  btrfs-progs: image: Verify the superblock before restore
  btrfs-progs: image: Introduce framework for more dump versions
  btrfs-progs: image: Introduce -d option to dump data
  btrfs-progs: image: Allow restore to record system chunk ranges for
    later usage
  btrfs-progs: image: Introduce helper to determine if a tree block is
    in the range of system chunks
  btrfs-progs: image: Rework how we search chunk tree blocks

 disk-io.c        |   6 +-
 disk-io.h        |   1 +
 image/main.c     | 501 +++++++++++++++++++++++++++++++++++------------
 image/metadump.h |  15 +-
 4 files changed, 393 insertions(+), 130 deletions(-)

-- 
2.21.0

