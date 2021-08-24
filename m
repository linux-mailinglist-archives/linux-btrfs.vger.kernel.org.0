Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F02D3F6533
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 19:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbhHXRKm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 13:10:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54240 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbhHXRJb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 13:09:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD3472006F;
        Tue, 24 Aug 2021 17:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629824925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fZ/wkva3I4GmpOse5lK8qkkjblQHqibBeNJyJNCRsyM=;
        b=uQFhIXZPhVkVLUcA5qWUOJeh/8b/oxhsFnpo2nzI0ExYNN56QQ3mEK1Vw0QC+VKd1ZAkL9
        lH/5PZYQzHEb4Kfk0l9P0YZvOmt7Bq/wBHmD5hbAT7dJJp7/JnYznVGs27sD4th6wYe6mK
        AtwmxS5bIlZYciwtApmLexWu/FvnLeE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81EB513B45;
        Tue, 24 Aug 2021 17:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WolgEpwnJWGDNwAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Tue, 24 Aug 2021 17:08:44 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 0/7] btrfs: Create macro to iterate slots
Date:   Tue, 24 Aug 2021 14:06:51 -0300
Message-Id: <20210824170658.12567-1-mpdesouza@suse.com>
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

Changes from RFC:
 * Add documentation to btrfs_for_each_slot macro and btrfs_valid_slot function
   (David)
 * Add documentation about the ret variable used as a macro argument (David)
 * Match function argument from prototype and implementation (David)
 * Changed ({ }) block to only () in btrfs_for_each_slot macro (David)
 * Add more patches to show the code being reduced by using this approach
   (Nikolay)

Marcos Paulo de Souza (7):
  fs: btrfs: Introduce btrfs_for_each_slot
  btrfs: block-group: use btrfs_for_each_slot in find_first_block_group
  btrfs: dev-replace: Use btrfs_for_each_slot in
    mark_block_group_to_copy
  btrfs: dir-item: use btrfs_for_each_slot in
    btrfs_search_dir_index_item
  btrfs: inode: use btrfs_for_each_slot in btrfs_read_readdir
  btrfs: send: Use btrfs_for_each_slot macro
  btrfs: volumes: use btrfs_for_each_slot in btrfs_read_chunk_tree

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

