Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBC5798B5C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244531AbjIHRUq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjIHRUq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:20:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529E0CE6
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5265AC433C9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193641;
        bh=TJQ3Oc/hJWt2rMA+QEvUNfR2P8cyZRjOqDdK1bvY2Ak=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=spvtkdP1weXnkN6EhO0I5kc30z9Wh4WRSG6MAVMlH3LxhSM089mmN2BlfshoKmM+a
         PsawCEKmAMzJ2/+04NZXtfTOIBU8+2+9Vvq7qtMZjfqVvYV+s9MVmF1I9/eF6gtCgq
         TsPCid5jfUgZ6DpxRukLquyBy7yjR+9cGDgIU8Pvcd+c5+Q0MSaP8EVBV99lgM6lh5
         S9tjQBmzgpVggFeu4cv0f7aKrSj1ovu5oPQJMyynP8vzl4RHKm41ocAyaOTTzNUDUg
         /cGX6gJgRh2Ej+trU9e+NeEGWZzt/VTBdDX3uoqjCbZH6QVL8K1+K4r44IEQgcs9wm
         lpQFzThluON4g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/21] btrfs: updates to delayed refs accounting and space reservation
Date:   Fri,  8 Sep 2023 18:20:17 +0100
Message-Id: <cover.1694192469.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694174371.git.fdmanana@suse.com>
References: <cover.1694174371.git.fdmanana@suse.com>
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

