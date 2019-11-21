Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFFC105208
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 13:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKUMDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 07:03:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:52378 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfKUMDh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 07:03:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0023B18A;
        Thu, 21 Nov 2019 12:03:36 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] 3 misc patches
Date:   Thu, 21 Nov 2019 14:03:28 +0200
Message-Id: <20191121120331.29070-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here are 3 misc patches. First one is an optimsation to prevent issuing discards
for reserved but not written extents. The other 2 simply get rid of
__btrfs_free_reserved_extent by moving its relevant parts to the two wrappers.

Nikolay Borisov (3):
  btrfs: Don't discard unwritten extents
  btrfs: Open code __btrfs_free_reserved_extent in
    btrfs_free_reserved_extent
  btrfs: Rename __btrfs_free_reserved_extent to
    btrfs_pin_reserved_extent

 fs/btrfs/ctree.h       |  4 ++--
 fs/btrfs/extent-tree.c | 44 ++++++++++++++++++------------------------
 fs/btrfs/inode.c       |  7 ++++++-
 fs/btrfs/tree-log.c    | 12 +++++-------
 4 files changed, 32 insertions(+), 35 deletions(-)

--
2.17.1

