Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDFE797F1E
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjIGXQA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjIGXP6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:15:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA28BD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:15:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C29C91F747;
        Thu,  7 Sep 2023 23:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694128552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DQtePmHI6MVbUAxAYpZbZ9LSluUPOQonyVohXrznlNk=;
        b=VmL2VZwXmFvdWEmZBIpc8/NrTlg5yA2NRKmbe/hnjKtKlsQtsXX9hq4IQCouvACEoUkOCe
        JdRf4i+8CcTkPuVBghN6tnGbo9J9dhFKdacR/kp7ztnjZPQ+LsXm5BpZwVpUFIKiEE6x+q
        +x0JbjIFtK7kulDC3fmLz7dmHB2qQTs=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B68E72C142;
        Thu,  7 Sep 2023 23:15:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E3865DA8C5; Fri,  8 Sep 2023 01:09:20 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 00/10] Cleanups and struct packing
Date:   Fri,  8 Sep 2023 01:09:20 +0200
Message-ID: <cover.1694126893.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few cleanups in comments and size reduction of several structures.

- btrfs_inode	1112 -> 1104
- btrfs_ref	  64 ->   56
- extent_buffer	 240 ->  232
- prelim_ref	  88 ->   80

David Sterba (10):
  btrfs: move functions comments from qgroup.h to qgroup.c
  btrfs: reformat remaining kdoc style comments
  btrfs: drop __must_check annotations
  btrfs: reduce parameters of btrfs_pin_reserved_extent
  btrfs: reduce parameters of btrfs_pin_extent_for_log_replay
  btrfs: reduce arguments of helpers space accounting root item
  btrfs: reduce size of prelim_ref::level
  btrfs: reduce size and reorder compression members in struct
    btrfs_inode
  btrfs: reduce size of struct btrfs_ref
  btrfs: move extent_buffer::lock_owner to debug section

 fs/btrfs/backref.h       |  2 +-
 fs/btrfs/btrfs_inode.h   | 20 +++++------
 fs/btrfs/ctree.c         | 27 +++++++-------
 fs/btrfs/delayed-inode.c |  6 ++--
 fs/btrfs/delayed-ref.c   |  3 +-
 fs/btrfs/delayed-ref.h   | 18 ++++++----
 fs/btrfs/disk-io.c       | 11 +++---
 fs/btrfs/extent-tree.c   | 56 ++++++++++++++++++-----------
 fs/btrfs/extent-tree.h   |  7 ++--
 fs/btrfs/extent_io.c     | 22 ++++++------
 fs/btrfs/extent_io.h     |  4 +--
 fs/btrfs/inode-item.c    |  2 +-
 fs/btrfs/inode.c         |  9 ++---
 fs/btrfs/locking.c       | 18 +++++++---
 fs/btrfs/messages.c      |  8 ++---
 fs/btrfs/qgroup.c        | 71 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h        | 76 ----------------------------------------
 fs/btrfs/ref-verify.c    |  2 +-
 fs/btrfs/relocation.c    |  2 +-
 fs/btrfs/root-tree.c     |  6 ++--
 fs/btrfs/root-tree.h     |  6 ++--
 fs/btrfs/space-info.c    |  3 +-
 fs/btrfs/transaction.c   |  4 +--
 fs/btrfs/tree-log.c      | 16 ++++-----
 fs/btrfs/ulist.c         |  3 +-
 fs/btrfs/volumes.c       |  3 +-
 fs/btrfs/zstd.c          | 11 +++---
 27 files changed, 223 insertions(+), 193 deletions(-)

-- 
2.41.0

