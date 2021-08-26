Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD06D3F8C62
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 18:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243085AbhHZQna (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 12:43:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38052 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbhHZQn3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 12:43:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4912E1FE58;
        Thu, 26 Aug 2021 16:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629996161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KKtFjiMujbnrVMLjjBZJHLTvzY/m0c3RKoZnOaZmnGA=;
        b=flFB2rBcfhX9VPP3J6ECr6r2KBf6nLnEIkZPp6XbMnJrmqPybCwB0Z1hd0yBbTqQibMUqd
        KIMCSYlN1SJ+SeQscDSC/WtaoKn2d2apLbCYGV0DR5HJR5XEhZ8VowgXNUiuY8S+bRZV7c
        MW0nx42ZslAhZFaGKcswwvSTdxE5m4E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19D6913B20;
        Thu, 26 Aug 2021 16:42:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kSBANH/EJ2EVIQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Thu, 26 Aug 2021 16:42:39 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv2 0/8]  btrfs: Create macro to iterate slots
Date:   Thu, 26 Aug 2021 13:40:46 -0300
Message-Id: <20210826164054.14993-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a common pattern when search for a key in btrfs:

 * Call btrfs_search_slot
 * Endless loop
     * If the found slot is bigger than the current items in the leaf, check the
       next one
     * If still not found in the next leaf, return 1
     * Do something with the code
     * Increment current slot, and continue

This pattern can be improved by creating an iterator macro, similar to
those for_each_X already existing in the linux kernel. using this
approach means to reduce significantly boilerplate code, along making it
easier to newcomers to understand how to code works.

This patchset survived a complete fstest run.

Changes from v1:
 * Separate xattr changes from the macro introducing code (Johannes)

Changes from RFC:
 * Add documentation to btrfs_for_each_slot macro and btrfs_valid_slot function
   (David)
 * Add documentation about the ret variable used as a macro argument (David)
 * Match function argument from prototype and implementation (David)
 * Changed ({ }) block to only () in btrfs_for_each_slot macro (David)
 * Add more patches to show the code being reduced by using this approach
   (Nikolay)

Marcos Paulo de Souza (8):
  fs: btrfs: Introduce btrfs_for_each_slot
  btrfs: block-group: use btrfs_for_each_slot in find_first_block_group
  btrfs: dev-replace: Use btrfs_for_each_slot in
    mark_block_group_to_copy
  btrfs: dir-item: use btrfs_for_each_slot in
    btrfs_search_dir_index_item
  btrfs: inode: use btrfs_for_each_slot in btrfs_read_readdir
  btrfs: send: Use btrfs_for_each_slot macro
  btrfs: volumes: use btrfs_for_each_slot in btrfs_read_chunk_tree
  btrfs: xattr: Use btrfs_for_each_slot macro in btrfs_listxattr

 fs/btrfs/block-group.c |  33 +-----
 fs/btrfs/ctree.c       |  28 ++++++
 fs/btrfs/ctree.h       |  25 +++++
 fs/btrfs/dev-replace.c |  51 ++--------
 fs/btrfs/dir-item.c    |  27 +----
 fs/btrfs/inode.c       |  46 ++++-----
 fs/btrfs/send.c        | 222 +++++++++++------------------------------
 fs/btrfs/volumes.c     |  23 ++---
 fs/btrfs/xattr.c       |  40 +++-----
 9 files changed, 169 insertions(+), 326 deletions(-)

-- 
2.31.1

