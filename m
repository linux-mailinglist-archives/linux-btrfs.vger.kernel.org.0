Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9677A1F3
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Aug 2023 21:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjHLTU2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Aug 2023 15:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLTU1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Aug 2023 15:20:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C956C19A5;
        Sat, 12 Aug 2023 12:20:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E2FED1F893;
        Sat, 12 Aug 2023 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691868019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dH61y9kNaLdRmil+OnsZ0prNTb/umt6kZofq+8GAD6I=;
        b=RMg01+0pXPvlmZkkf5WGb7U6w99Cf3c90qgqn8bxlpshruphti+y+1VfM9cOzBS7ZEAjKI
        cb5ejky+5XB0IVv0SzEfcSf2c88XoxMFMCVIRxPwP/bBEbgMP4kGrza9C8Ua5yTXnlP6wJ
        PXnihffeOjVtz67VTxfkh4INwwobv7k=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D28562C142;
        Sat, 12 Aug 2023 19:20:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D862BDA7CF; Sat, 12 Aug 2023 21:13:54 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.5-rc6
Date:   Sat, 12 Aug 2023 21:13:52 +0200
Message-ID: <cover.1691865526.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

more fixes, some of them going back to older releases and there are
fixes for hangs in stress tests regarding space caching.

- space caching hangs fixes to progress stracking, found by test
  generic/475

- writeback fixes, write pages in integrity mode and skip writing pages
  that have been written meanwhile

- properly clear end of extent range after an error

- relocation fixes
  - fix race betwen qgroup tree creation and relocation
  - detect and report invalid reloc roots

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit b28ff3a7d7e97456fd86b68d24caa32e1cfa7064:

  btrfs: check for commit error at btrfs_attach_transaction_barrier() (2023-07-26 13:57:47 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.5-rc5-tag

for you to fetch changes up to 92fb94b69c6accf1e49fff699640fa0ce03dc910:

  btrfs: set cache_block_group_error if we find an error (2023-08-10 17:16:45 +0200)

----------------------------------------------------------------
Christoph Hellwig (3):
      btrfs: don't stop integrity writeback too early
      btrfs: don't wait for writeback on clean pages in extent_write_cache_pages
      btrfs: properly clear end of the unreserved range in cow_file_range

Josef Bacik (2):
      btrfs: wait for actual caching progress during allocation
      btrfs: set cache_block_group_error if we find an error

Qu Wenruo (3):
      btrfs: avoid race between qgroup tree creation and relocation
      btrfs: exit gracefully if reloc roots don't match
      btrfs: reject invalid reloc tree root keys with stack dump

 fs/btrfs/block-group.c  | 17 +++++++++++++++--
 fs/btrfs/block-group.h  |  2 ++
 fs/btrfs/disk-io.c      | 13 ++++++++++++-
 fs/btrfs/extent-tree.c  |  5 ++++-
 fs/btrfs/extent_io.c    | 13 ++++++++++---
 fs/btrfs/inode.c        | 10 +++++-----
 fs/btrfs/relocation.c   | 45 +++++++++++++++++++++++++++++++++++++--------
 fs/btrfs/tree-checker.c | 14 ++++++++++++++
 8 files changed, 99 insertions(+), 20 deletions(-)
