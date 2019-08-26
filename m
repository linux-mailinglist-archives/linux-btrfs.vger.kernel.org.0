Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704259CABC
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 09:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbfHZHkq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 03:40:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:58298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728220AbfHZHkq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 03:40:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6385B052
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 07:40:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: tree-checker: Add checks to detect missing INODE_ITEM
Date:   Mon, 26 Aug 2019 15:40:37 +0800
Message-Id: <20190826074039.28517-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the following items, key->objectid is inode number:
- DIR_ITEM
- DIR_INDEX
- XATTR_ITEM
- EXTENT_DATA
- INODE_REF

So in btrfs btree, such items must have its previous item shares the
same objectid, e.g.:
 (257 INODE_ITEM 0)
 (257 DIR_INDEX xxx)
 (257 DIR_ITEM xxx)
 (258 INODE_ITEM 0)
 (258 INODE_REF 0)
 (258 XATTR_ITEM 0)
 (258 EXTENT_DATA 0)

But if we have the following sequence, then there is definitely
something wrong, normally some INODE_ITEM is missing, like:
 (257 INODE_ITEM 0)
 (257 DIR_INDEX xxx)
 (257 DIR_ITEM xxx)
 (258 XATTR_ITEM 0)  <<< objecitd suddenly changed to 258
 (258 EXTENT_DATA 0)

So just by checking the previous key for above inode based key types, we
can detect missing inode item.

In this patchset, we will enhance existing check_dir_item() and
check_extent_data_item() to detect missing INODE_ITEM first, then add
INODE_REF checker.

So now we can cover the INODE_ITEM missing case in tree-checker without
much cost, but achieve the check which is normally done by btrfs-check.
(I'm already a little concerned about the fact that kernel tree-checker
is getting stronger and stronger while btrfs-progs can't fix all
problems)

Of course, there is still a limitation that the first key of a leaf
can't be verified, but we have already cover all the rest keys, which is
way better than "good enough"(TM).

Qu Wenruo (2):
  btrfs: tree-checker: Try to detect missing INODE_ITEM
  btrfs: tree-checker: Add check for INODE_REF

 fs/btrfs/tree-checker.c | 78 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

-- 
2.23.0

