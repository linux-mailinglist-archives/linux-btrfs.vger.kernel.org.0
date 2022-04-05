Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2703C4F444E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 00:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbiDEPD2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 11:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391999AbiDENt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 09:49:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A569FFE
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 05:48:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B8457210EA
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649162928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8IEYzUhKxYrXLzg6TUfbpwH4IlFvHVWQG3dyYqPbqo0=;
        b=eJm3O2pP+YNqZAu/sejgeepUJT8fWr+dJyA/JpI0hFSP+as2LbE28kxyNaCAq8kEaUQse0
        USIDCs4X59lthvrqug8jsVQdy1dHc7nXppXyMvpBju0r/00E013lCX/eTEBZ1iUxSIWCT2
        COwK6ZuGzcjRzkzQwJh/WqxP1qDBQaE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13F3613A04
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RErEM686TGJLGgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 12:48:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs-progs: add RAID56 rebuild ability at read time
Date:   Tue,  5 Apr 2022 20:48:22 +0800
Message-Id: <cover.1649162174.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This branch can be fetched from github:
https://github.com/adam900710/btrfs-progs/tree/raid56_rebuild

Please note that, the last time I check devel branch, the RAID56 warning
patch is not yet merged.

So this is based on the latest devel branch from github.

And since we're adding proper RAID56 repair ability, there is no need
for the patchset "btrfs-progs: check: avoid false alerts for --check-data-csum on RAID56"

This patchset is mostly to add the ability to properly read data/metadata
for RAID56 when mirror_num > 1.

[PROBLEMS]
There are several for current btrfs-progs:

- No RAID56 rebuild ability
  Thus for any mirror > 1 on RAID56, we will read the parity data
  straight, causing no way to recover.

- No unified logical read/write entrance
  We have various different functions, for read we have
  read_data_from_disk(), read_extent_data() and read_extent_from_disk().

  Unlike kernel, we have no btrfs_map_bio() to address everything.

  This makes adding RAID56 rebuild even hard.

[FIXES]
To address the problem, this patchset will:

- Cleanup and refactors
  Mostly to unify the logical read/write entrance.
  In patch 1~6, we will unify the logical read write entrances to
  only two functions:
  * read_extent_from_disk()
  * write_extent_to_disk()

  They will do the chunk mapping and stripe splitting.

- Add RAID56 read rebuild ability
  We already have RAID56 RMW for write path.
  Just add a new helper for mirror > 1 read on RAID56.

- A new test case
  In fact the same test case from previous RAID56 warning patchset.

Qu Wenruo (8):
  btrfs-progs: remove the unnecessary BTRFS_SUPER_INFO_OFFSET path for
    tree block read
  btrfs-progs: extract metadata restore read code into its own helper
  btrfs-progs: don't use write_extent_to_disk() directly
  btrfs-progs: use write_data_to_disk() to replace
    write_extent_to_disk()
  btrfs-progs: use read_data_from_disk() to replace
    read_extent_from_disk() and replace read_extent_data()
  btrfs-progs: remove extent_buffer::fd and extent_buffer::dev_bytes
  btrfs-progs: allow read_data_from_disk() to rebuild RAID56 using P/Q
  btrfs-progs: tests/fsck: add test case for data csum check on raid5

 btrfs-corrupt-block.c                         |  38 +---
 btrfs-map-logical.c                           |   5 +-
 btrfstune.c                                   |   3 +-
 check/main.c                                  |   2 +-
 check/mode-common.c                           |   4 +-
 cmds/restore.c                                |   4 +-
 image/main.c                                  |   2 +-
 kernel-shared/ctree.c                         |   5 +-
 kernel-shared/disk-io.c                       | 140 +++++--------
 kernel-shared/disk-io.h                       |   2 -
 kernel-shared/extent_io.c                     | 188 ++++++++++++------
 kernel-shared/extent_io.h                     |   9 +-
 kernel-shared/file.c                          |  20 +-
 kernel-shared/free-space-cache.c              |  20 +-
 kernel-shared/volumes.c                       |  39 ++--
 kernel-shared/volumes.h                       |   1 +
 .../056-raid56-false-alerts/test.sh           |  31 +++
 17 files changed, 277 insertions(+), 236 deletions(-)
 create mode 100755 tests/fsck-tests/056-raid56-false-alerts/test.sh

-- 
2.35.1

