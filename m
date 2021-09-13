Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53F5408C73
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbhIMNTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 09:19:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39374 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbhIMNSr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 09:18:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F044621FEC;
        Mon, 13 Sep 2021 13:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631539050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fCEnKmR3VDuqMF5XQ7RbOvFwOj8x+HuPef79xPSh/IM=;
        b=IRpwtHF06XAkT30QsFkKhAA16D64ZN/uNvXwcefqATtPHdlSbTWjZP5wfe8ygyq1KU6cVf
        zSbgx/DPyoVzhM0ofcFSzMHaDh6wbfFSmuiAIs72+sMplXLAO8dCdwnj3Kdzxl+27pXcj5
        sPFwUy8Y/rr456EjBl2nOFQG+VC2u5Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C33C213AB4;
        Mon, 13 Sep 2021 13:17:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 01kpLWpPP2FNOwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Sep 2021 13:17:30 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/8] Implement progs support for removing received uuid on RW vols
Date:   Mon, 13 Sep 2021 16:17:21 +0300
Message-Id: <20210913131729.37897-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series is the userspace counter part to a kernel patch titled:
"btrfs: Remove received information from snapshot on ro->rw switch". This will
mainly serve people running old kernels that won't have this patch to be able to
remove received uuid et al from snapshots which have been switched RO->RW. This
is to ensure consistency.

First 3 patches are preparatory ones which pull needed code from the kernel as
well as removing some arguments making respective functions as close to their
kernel counterparts as possible. This enables to simply copy btrfs_uuid_tree_remove
with no changes from the kernel.

Next 2 patches implement detection and repair support for RO->RW-switched volumes
which have been received. And the final patch is an fs image with a received
subvolume that has been switched to RW following a receive.

Nikolay Borisov (8):
  btrfs-progs: Add btrfs_is_empty_uuid
  btrfs-progs: Remove root argument from btrfs_fixup_low_keys
  btrfs-progs: Remove fs_info argument from leaf_data_end
  btrfs-progs: Remove root argument from btrfs_truncate_item
  btrfs-progs: Add btrfs_uuid_tree_remove
  btrfs-progs: check/original: Implement removing received data for RW
    subvols
  btrfs-progs: check/lowmem: Implement received info clearing for RW
    volumes
  btrfs-progs: tests: Add test for received information removal

 check/main.c                                  |  48 ++++++++-
 check/mode-lowmem.c                           |  38 +++++++
 kernel-shared/ctree.c                         |  62 +++++-------
 kernel-shared/ctree.h                         |  12 ++-
 kernel-shared/dir-item.c                      |   2 +-
 kernel-shared/extent-tree.c                   |   2 +-
 kernel-shared/file-item.c                     |   4 +-
 kernel-shared/inode-item.c                    |   4 +-
 kernel-shared/uuid-tree.c                     |  93 ++++++++++++++++++
 .../050-subvol-recv-clear/test.raw.xz         | Bin 0 -> 493524 bytes
 10 files changed, 216 insertions(+), 49 deletions(-)
 create mode 100644 tests/fsck-tests/050-subvol-recv-clear/test.raw.xz

--
2.17.1

