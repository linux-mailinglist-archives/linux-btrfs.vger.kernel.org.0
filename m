Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A97D04D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 00:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbjJSWak (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 18:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbjJSWaf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 18:30:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE9C124
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 15:30:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9066A1FD82
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697754627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=52LRG/LW7EnWYvmu5LqH+WQF1tTTKZvQY0NReQO9kJg=;
        b=E5MKjdG1N/LadYZGDKK20nTZuTaeUaFVbzU1/HognWuIk96MWC2dkJQMQIjUL3l9oUC7/q
        fMgTzrKiaUSIQspIs4GIPSY57769i93GWIwXEEQrye44cZYfgfD26GnFavnJlSA8ApvYtw
        OCYbRq4AUsmVQfrlIlohegtRQ0R9JR0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4FBD1357F
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q4TxIAKuMWXzWgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/9] btrfs-progs: mkfs: introduce an experimental --subvol option
Date:   Fri, 20 Oct 2023 08:59:59 +1030
Message-ID: <cover.1697754500.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_ONE(0.00)[1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
v2:
- Crossport fs_types from kernel
  So that we can have infrastructure more in-line with kernel code.
  Unfortunately we still need a new fs_ftypes_to_umode() helper for
  progs.

- More cleanups for btrfs_add_link()

- Make btrfs_add_link() have the same ability of the kernel one
  This is to allow btrfs_add_link() to link a subvolume to a parent
  inode.
  Unfortunately the parameter list is still quite different due to the
  lack of btrfs_inode and dentry.

- Merge btrfs_mksubvol() into btrfs_add_link()
  Since btrfs_add_link() can now handle linking of a subvolume, we
  can remove the progs specific code.

- New common/inode.[ch] for btrfs_create_subvol() and
  btrfs_make_root_dir()
  Those two functions are progs specific and would be utilized by code
  out of check/convert. Thus moving them to common/ would be better


Issue #42 (good number by the way) is suggesting a very useful feature
for rootfs image creation.

Currently we only support "mkfs.btrfs --rootdir" to fill the fs tree
with target directory, but there has no btrfs specific features
involved.

If we can create certain paths as subvolumes, not pure directories, it
can be very useful to create the whole btrfs image just by "mkfs.btrfs"

This series is the first step torwards this idea.

Now we have a new experimental option "--subvol" for mkfs.btrfs, but
with the following limits:

- No co-operation with --rootdir
  This requires --rootdir to have extra handling for any existing
  inodes.
  (Currently --rootdir assumes the fs tree is completely empty)

- No multiple --subvol options supports
  This requires us to collect and sort all the paths and start creating
  subvolumes from the shortest path.
  Furthermore this requires us to create subvolume under another
  subvolume.

Each limit would need a new series of patches to address, but this
series would already provide a working but not-that-useful
implementation of "--subvol" option, along with a basic test case for
it.

Qu Wenruo (9):
  btrfs-progs: cross-port fs_types from kernel
  btrfs-progs: remove add_backref parameter from btrfs_add_link()
  btrfs-progs: remove filetype parameter of btrfs_add_link()
  btrfs-progs: merge btrfs_mksubvol() into btrfs_add_link()
  btrfs-progs: enhance btrfs_mkdir() function
  btrfs-progs: enhance btrfs_create_root() function
  btrfs-progs: use a unified btrfs_make_subvol() implementation
  btrfs-progs: mkfs: introduce experimental --subvol option
  btrfs-progs: mkfs-tests: introduce a test case to verify --subvol
    option

 Makefile                                   |   2 +
 check/main.c                               |  17 +-
 check/mode-common.c                        |  12 +-
 check/mode-common.h                        |  32 --
 check/mode-lowmem.c                        |  40 ++-
 common/inode.c                             |  90 ++++++
 common/inode.h                             |  16 +
 convert/main.c                             | 139 ++++++---
 include/kerncompat.h                       |   1 +
 kernel-shared/ctree.c                      | 106 +++----
 kernel-shared/ctree.h                      |  17 +-
 kernel-shared/fs_types.c                   |  62 ++++
 kernel-shared/fs_types.h                   |  87 ++++++
 kernel-shared/inode.c                      | 347 ++++++++++-----------
 mkfs/common.c                              |  39 ---
 mkfs/common.h                              |   2 -
 mkfs/main.c                                | 106 ++-----
 mkfs/rootdir.c                             | 157 ++++++++++
 mkfs/rootdir.h                             |   1 +
 tests/mkfs-tests/031-subvol-option/test.sh |  39 +++
 tune/convert-bgt.c                         |   3 +-
 tune/quota.c                               |   2 +-
 22 files changed, 829 insertions(+), 488 deletions(-)
 create mode 100644 common/inode.c
 create mode 100644 common/inode.h
 create mode 100644 kernel-shared/fs_types.c
 create mode 100644 kernel-shared/fs_types.h
 create mode 100755 tests/mkfs-tests/031-subvol-option/test.sh

--
2.42.0

