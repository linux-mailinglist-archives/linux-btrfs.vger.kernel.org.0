Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE1763BBB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjGZP5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjGZP5T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4677B2109
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D812361AFE
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB533C433C7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387037;
        bh=DtYWMO2ODBM6RzNoZxjLEYoH7xF36vQOsWgYxR6h1Xo=;
        h=From:To:Subject:Date:From;
        b=gcELJvnmF4v5fjbOBQUNY9mR/r0azPdkcVlaHeB6UbiveVLuezoJ+OncoJqaV1us8
         X/NG3/NrmTrtZBivoDKftijmm2RB5438As/iAkNcURhagh6mXFyuGp/KXfZLg54Zq6
         pqeaCei7KeSClMYjKeIAh/o+g/JKLRR3SHiF27D9SxnAptzBXghPtZ7koW7a9dUzuB
         l8pCXysOZybJYpzQJ7jP5u2vLFDRsxrHN4PKK4XMeLzIrU2IB2hZLgMaRfaiM0B8lp
         EacM8MNT1Ln47eytqLFEXJCkLXdg4c2PQ48/8+Y3SlW1H1LXKa8St4x7Qsfn4cApX5
         zN7YctcA/KVqA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/17] btrfs: some misc stuff around space flushing and enospc handling
Date:   Wed, 26 Jul 2023 16:56:56 +0100
Message-Id: <cover.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A few fixes, improvements, cleanups around space flushing, enospc handling,
debugging. These came out while debugging an image of a fs that fails to
mount due to being out of unallocated space and having only about 1.6M of
free metadata space, which is not enough to commit any transaction triggered
during mount while doing orphan cleanup, resulting in transactions aborts
either when running delayed refs or somewhere in the critical section of a
transaction commit. These patches do not prevent getting into that situation,
but that will be attempted by other patches in a separate patchset.

Filipe Manana (17):
  btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART
  btrfs: update comment for btrfs_join_transaction_nostart()
  btrfs: print target number of bytes when dumping free space
  btrfs: print block group super and delalloc bytes when dumping space info
  btrfs: print available space for a block group when dumping a space info
  btrfs: print available space across all block groups when dumping space info
  btrfs: don't steal space from global rsv after a transaction abort
  btrfs: store the error that turned the fs into error state
  btrfs: return real error when orphan cleanup fails due to a transaction abort
  btrfs: fail priority metadata ticket with real fs error
  btrfs: make btrfs_cleanup_fs_roots() static
  btrfs: make find_free_dev_extent() static
  btrfs: merge find_free_dev_extent() and find_free_dev_extent_start()
  btrfs: avoid starting new transaction when flushing delayed items and refs
  btrfs: avoid starting and committing empty transaction when flushing space
  btrfs: avoid start and commit empty transaction when starting qgroup rescan
  btrfs: avoid start and commit empty transaction when flushing qgroups

 fs/btrfs/disk-io.c          | 102 ++++++++++++++++++------------------
 fs/btrfs/disk-io.h          |   1 -
 fs/btrfs/free-space-cache.c |   3 +-
 fs/btrfs/fs.h               |  12 +++--
 fs/btrfs/inode.c            |   9 +++-
 fs/btrfs/messages.c         |  10 ++--
 fs/btrfs/qgroup.c           |  19 ++++---
 fs/btrfs/space-info.c       |  51 ++++++++++++++----
 fs/btrfs/transaction.c      |  12 +++--
 fs/btrfs/volumes.c          |  21 +++-----
 fs/btrfs/volumes.h          |   2 -
 11 files changed, 144 insertions(+), 98 deletions(-)

-- 
2.34.1

