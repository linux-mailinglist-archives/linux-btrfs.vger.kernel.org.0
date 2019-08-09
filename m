Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E986F3C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 03:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404558AbfHIBYa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 21:24:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404422AbfHIBYa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Aug 2019 21:24:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 374ADAEA4
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2019 01:24:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1.2 0/3] btrfs: tree-checker: Add extent items check
Date:   Fri,  9 Aug 2019 09:24:21 +0800
Message-Id: <20190809012424.11420-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Finally, we are going to add tree-checker support for extent items,
which includes:
- EXTENT_ITEM/METADATA_ITEM
  Which futher contains inline backrefs of:
  * TREE_BLOCK_REF
  * SHARED_BLOCK_REF
  * EXETNT_DATA_REF
  * SHARED_DATA_REF

- TREE_BLOCK_REF
- SHARED_BLOCK_REF
- EXTENT_DATA_REF
- SHARED_DATA_REF
  Keyed version of the above types

The complexity of the on-disk format can be found in the first patch,
which contains a basic introduction as comment.

Hidden pitfalls are everywhere, e.g. inlined EXTENT_DATA_REF don't use
iref->offset, but put its own data at iref->offset.
But SHARED_DATA_REF uses iref->offset, and put extra data after iref.

Such on-disk layout makes sense, but definitely a mess to read.
Thankfully we at least have print-tree code from btrfs-progs as a
reference.

Changelog:
v1.1:
- If branches optimization
  Make some if branches more readable.

- Range notion update
  Use regular set notion ([],[),(],()) to show possible value range.

- Fix a wrong range notion
  The valid range for tree level is [0, MAX_LEVEL - 1], not
  [0, MAX_LEVEL -1)

v1.2:
- Use "unsigned long" for pointer convertion

- Use "%zu" format for sizeof() in the 3rd patch

Qu Wenruo (3):
  btrfs: tree-checker: Add EXTENT_ITEM and METADATA_ITEM check
  btrfs: tree-checker: Add simple keyed refs check
  btrfs: tree-checker: Add EXTENT_DATA_REF check

 fs/btrfs/ctree.h        |   1 +
 fs/btrfs/extent-tree.c  |   2 +-
 fs/btrfs/tree-checker.c | 336 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+), 1 deletion(-)

-- 
2.22.0

