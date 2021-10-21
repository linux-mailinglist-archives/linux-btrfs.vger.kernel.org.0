Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425BF43585A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 03:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhJUBm7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 21:42:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40612 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhJUBmy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 21:42:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D94121FD53
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 01:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634780438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lNkgCAye9MBuSzt54gVdU7JKjC6F4JB0qsZZULqrg58=;
        b=kISg4HVsgf+lSbWHjQavilmEkhm1+bTCvOc+fcaKur7H7b0IvuIieEvNW6qWjvpegHaPWi
        P1xkbDeSPjCgEw2KdJukotgj9NLL5/xtAw6kk/1UkBshwEW3rFi4lXRf5DkIvpk7HgN2x/
        GjIMja4PmKyZ4SbBJsOJNjns7kuyWD8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3182013F8A
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 01:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bwpVOhXFcGFYIQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 01:40:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: cleanup related to btrfs super block
Date:   Thu, 21 Oct 2021 09:40:17 +0800
Message-Id: <20211021014020.482242-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset mostly cleans up the mismatch between
BTRFS_SUPER_INFO_SIZE and sizeof(struct btrfs_super_block).

This cleanup itself is going to replace all the following snippets:

	u8 super_block_data[BTRFS_SUPER_INFO_SIZE];
	struct btrfs_super_block *sb;

	sb = (struct btrfs_super_block *)super_block_data;

With:

	struct btrfs_super_block sb;

Also since we're here, also cache csum_type and csum_size in fs_info,
just like what we did in the kernel.

Qu Wenruo (3):
  btrfs-progs: unify sizeof(struct btrfs_super_block) and
    BTRFS_SUPER_INFO_SIZE
  btrfs-progs: remove temporary buffer for super block
  btrfs-progs: cache csum_size and csum_type in btrfs_fs_info

 btrfs-corrupt-block.c       |  6 +--
 check/main.c                |  6 +--
 check/mode-common.c         |  2 +-
 cmds/filesystem-usage.c     |  8 ++--
 cmds/inspect-dump-super.c   | 11 ++----
 cmds/rescue-chunk-recover.c | 24 ++++++-----
 cmds/rescue-super-recover.c | 11 +++---
 common/device-scan.c        | 23 ++++-------
 common/utils.c              |  8 ++--
 convert/common.c            | 79 +++++++++++++++++--------------------
 convert/main.c              | 29 ++++++--------
 image/main.c                | 14 +++----
 kernel-shared/ctree.h       |  9 +++++
 kernel-shared/disk-io.c     | 41 +++++++++----------
 kernel-shared/disk-io.h     |  3 --
 kernel-shared/file-item.c   | 15 +++----
 kernel-shared/print-tree.c  |  4 +-
 kernel-shared/volumes.c     | 14 +++----
 mkfs/common.c               |  8 ++--
 19 files changed, 141 insertions(+), 174 deletions(-)

-- 
2.33.0

