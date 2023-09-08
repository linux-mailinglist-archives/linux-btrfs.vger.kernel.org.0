Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E6F7986C3
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbjIHMJc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjIHMJb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B355B1BC5
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BC1C433C8
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174967;
        bh=TJQ3Oc/hJWt2rMA+QEvUNfR2P8cyZRjOqDdK1bvY2Ak=;
        h=From:To:Subject:Date:From;
        b=iekNL4OjHQoYETETg8DPDmppd6q4j3wv+0vMXnqoo1+4P97/B+MqUTHwIemnzF/tO
         9YpX4CuTCIwQWVXbipqGcSznQ7WdCP7bsI9qff6PX0SfwzTJyY0o4noL9wwvO8RrrS
         bQ1Tif83Cn09/WJ0DtMYLQIyb56Kvsbus2iQ7av69rysUICFhs4UNZjwBinXgQOtPy
         uRPtUc3EPO3WHX4g5uhaiB8w732q8XHCG5ZlsFdwQefrc5whja6ujJOGV2DDsjsZ8N
         XK54BfxKWVuW05KeHIO2/FJGcOn90+Rd2mu+03FmRQFhJkYpyynCzMxJ3Ewim6ZQaU
         nG78eVjXQ1W0g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/21] btrfs: updates to delayed refs accounting and space reservation
Date:   Fri,  8 Sep 2023 13:09:02 +0100
Message-Id: <cover.1694174371.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The following are some fixes, improvements and cleanups around delayed refs.
Mostly about space accouting and reservation and were motivated by a case
hit by a SLE (SUSE Linux Enterprise) user where a filesystem became unmountable
and unusable because it fails a RW mount with -ENOSPC when attempting to do
any orphan cleanup. The problem was that the device had no available space
for allocating new block groups and the available metadata space was about
1.5M, too little to commit any transaction, but enough to start a transaction,
as during the transaction commit we need to COW more than we accounted for
when starting the transaction (running delayed refs generates more delayed
refs to update the extent tree for example). Starting any transaction there,
either to do orphan cleanup, attempt to reclaim data block groups, unlink,
etc, always failed during the transaction commit and result in transaction
aborts.

We have some cases where we use and abuse of the global block reserve
because we don't reserve enough space when starting a transaction or account
delayed refs properly, and can therefore lead to exhaustion of metadata space
in case we don't have more unallocated space to allocate a new metadata block
group.

More details on the individual changelogs.

There are more cases that will be addressed later and depend on this patchset,
but they'll be sent later and separately.

Filipe Manana (21):
  btrfs: fix race when refilling delayed refs block reserve
  btrfs: prevent transaction block reserve underflow when starting transaction
  btrfs: pass a space_info argument to btrfs_reserve_metadata_bytes()
  btrfs: remove unnecessary logic when running new delayed references
  btrfs: remove the refcount warning/check at btrfs_put_delayed_ref()
  btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1
  btrfs: remove redundant BUG_ON() from __btrfs_inc_extent_ref()
  btrfs: remove refs_to_add argument from __btrfs_inc_extent_ref()
  btrfs: remove refs_to_drop argument from __btrfs_free_extent()
  btrfs: initialize key where it's used when running delayed data ref
  btrfs: remove pointless 'ref_root' variable from run_delayed_data_ref()
  btrfs: log message if extent item not found when running delayed extent op
  btrfs: use a single variable for return value at run_delayed_extent_op()
  btrfs: use a single variable for return value at lookup_inline_extent_backref()
  btrfs: return -EUCLEAN if extent item is missing when searching inline backref
  btrfs: simplify check for extent item overrun at lookup_inline_extent_backref()
  btrfs: allow to run delayed refs by bytes to be released instead of count
  btrfs: reserve space for delayed refs on a per ref basis
  btrfs: remove pointless initialization at btrfs_delayed_refs_rsv_release()
  btrfs: stop doing excessive space reservation for csum deletion
  btrfs: always reserve space for delayed refs when starting transaction

 fs/btrfs/block-group.c    |  11 +-
 fs/btrfs/block-rsv.c      |  18 ++--
 fs/btrfs/delalloc-space.c |   3 +-
 fs/btrfs/delayed-ref.c    | 132 +++++++++++++++++-------
 fs/btrfs/delayed-ref.h    |  15 ++-
 fs/btrfs/disk-io.c        |   3 +-
 fs/btrfs/extent-tree.c    | 208 +++++++++++++++++++-------------------
 fs/btrfs/extent-tree.h    |   4 +-
 fs/btrfs/space-info.c     |  29 ++----
 fs/btrfs/space-info.h     |   2 +-
 fs/btrfs/transaction.c    | 143 ++++++++++++++++++++------
 fs/btrfs/transaction.h    |   3 +
 12 files changed, 357 insertions(+), 214 deletions(-)

-- 
2.40.1

