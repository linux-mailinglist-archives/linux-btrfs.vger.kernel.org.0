Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0530547EBCD
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Dec 2021 06:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351406AbhLXFuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Dec 2021 00:50:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50510 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351403AbhLXFui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Dec 2021 00:50:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B55522112B
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Dec 2021 05:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640325037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6Pp1y6yqK/+BdbvXc7LVAKNjn4tweytgd32AoP8c5Vs=;
        b=MmuXTLtGFCrtIeNvcj6w4fL7ybapItU56R7whlA0f6bLqcpaz0+EvR7hEM/EQSYsqDTps+
        Gib1/hMVsUpZikgqJsieTxMT6bx3VtZtOSwG7kK/HqXE5UNX/k6XZdxhM7G3hGeSeAz3hb
        97VgIeD8TaYDinN/jsAOjlFQFw2I8rc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0489C13A97
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Dec 2021 05:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rWENL6xfxWGCGQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Dec 2021 05:50:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs-progs: check: properly skip preallocated/nodatasum extents when re-calculating csum tree
Date:   Fri, 24 Dec 2021 13:50:14 +0800
Message-Id: <20211224055019.51555-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Merry Christmas and happy new year!

[BUG]
Issue #420 mentions that --init-csum-tree creates extra csum for
preallocated extents.

Causing extra errors after --init-csum-tree.

[CAUSE]
Csum re-calculation code doesn't take the following factors into
consideration:

- NODATASUM inodes
- Preallocated extents
  No csum should be calculated for those data extents

- Partically written preallocated csum
  Csum should only be created for the referred part

So currently csum recalculation will just create csum for any data
extents it found, causing the mentioned errors.

[FIX]

- Bug fix for backref iteration
  Firstly fix a bug in backref code where indirect ref is not properly
  resolved.

  This allows us to use iterate_extent_inodes() to make our lives much
  easier checking the file extents.

- Code move for --init-csum-tree
  Move it to mode independent mode-common.[ch]

- Fix for --init-csum-tree
  Using iterate_extent_inodes() to do that.

- Fix for --init-csum-tree --init-extent-tree
  The same fix, just into a different context

- New test case

Qu Wenruo (5):
  btrfs-progs: backref: properly queue indirect refs
  btrfs-progs: check: move csum tree population into mode-common.[ch]
  btrfs-progs: check: don't calculate csum for preallocated file extents
  btrfs-progs: check: skip NODATASUM inodes for `--init-csum-tree
    --init-extent-tree`
  btrfs-progs: fsck-tests: add test case for init-csum-tree

 check/main.c                                | 244 -------------
 check/mode-common.c                         | 358 ++++++++++++++++++++
 check/mode-common.h                         |   1 +
 kernel-shared/backref.c                     |  10 +-
 tests/fsck-tests/052-init-csum-tree/test.sh |  54 +++
 5 files changed, 421 insertions(+), 246 deletions(-)
 create mode 100755 tests/fsck-tests/052-init-csum-tree/test.sh

-- 
2.34.1

