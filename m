Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0D578683
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 09:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfG2Hnp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 03:43:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfG2Hno (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 03:43:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7294AE1C
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2019 07:43:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: tree-checker: Add extent items check
Date:   Mon, 29 Jul 2019 15:43:34 +0800
Message-Id: <20190729074337.10573-1-wqu@suse.com>
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

Qu Wenruo (3):
  btrfs: tree-checker: Add EXTENT_ITEM and METADATA_ITEM check
  btrfs: tree-checker: Add simple keyed refs check
  btrfs: tree-checker: Add EXTENT_DATA_REF check

 fs/btrfs/ctree.h        |   1 +
 fs/btrfs/extent-tree.c  |   2 +-
 fs/btrfs/tree-checker.c | 335 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 337 insertions(+), 1 deletion(-)

-- 
2.22.0

