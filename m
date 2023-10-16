Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9E77C9E47
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 06:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjJPEjV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 00:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjJPEjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 00:39:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA8FD9
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Oct 2023 21:39:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86A5321BC8
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697431151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oLjW/CU+b6IqAC9Q4iSTzMRQkNNlCpNt59nfFakTkHM=;
        b=lqb96eqCpe0k/8SN+Ifg8XNCEk8zCboaYfmWd5r1YM5hXTRm/L56BKkBf/fxmZDeOleUOC
        AHSZBbtms70IbvHV19Nwg9ZQrm9JzRpfVlTwFdPdeuoREy7NlVW3Mmnef9x8oWYMFBhcnt
        LxcsM7B+Z9OX/jMnd42xNdFNRWH7ALw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B21DC138EF
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bVYfHG6+LGUaFgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs-progs: mkfs: introduce an experimental --subvol option
Date:   Mon, 16 Oct 2023 15:08:46 +1030
Message-ID: <cover.1697430866.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -0.85
X-Spamd-Result: default: False [-0.85 / 50.00];
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
         BAYES_HAM(-1.75)[93.48%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

Qu Wenruo (6):
  btrfs-progs: enhance btrfs_mkdir() function
  btrfs-progs: enhance and rename btrfs_mksubvol() function
  btrfs-progs: enhance btrfs_create_root() function
  btrfs-progs: use a unified btrfs_make_subvol() implementation
  btrfs-progs: mkfs: introduce experimental --subvol option
  btrfs-progs: mkfs-tests: introduce a test case to verify --subvol
    option

 convert/main.c                             |  60 ++------
 kernel-shared/ctree.c                      | 106 ++++++--------
 kernel-shared/ctree.h                      |  12 +-
 kernel-shared/inode.c                      | 129 ++++++++++++-----
 kernel-shared/root-tree.c                  |  86 +++++++++++
 mkfs/common.c                              |  39 -----
 mkfs/common.h                              |   2 -
 mkfs/main.c                                | 103 ++++----------
 mkfs/rootdir.c                             | 157 +++++++++++++++++++++
 mkfs/rootdir.h                             |   1 +
 tests/mkfs-tests/031-subvol-option/test.sh |  39 +++++
 tune/convert-bgt.c                         |   3 +-
 tune/quota.c                               |   2 +-
 13 files changed, 473 insertions(+), 266 deletions(-)
 create mode 100755 tests/mkfs-tests/031-subvol-option/test.sh

--
2.42.0

