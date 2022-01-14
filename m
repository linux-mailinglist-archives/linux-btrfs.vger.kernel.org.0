Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9487C48E1C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 01:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiANAvn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 19:51:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51580 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiANAvm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 19:51:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C94401F384
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642121501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XzTcaZgaAYZqusuBxoscy9NkFMadyaVPnrB53kgcSaw=;
        b=Ah5Qevm6ZoAQ7I+XE/YJ3rLwrOyK/jAkGHb7E0PPYLuOlNyWuFDyJnTU9sEZSsqM8KYsg/
        VhW42gL0WS3G96tpFsjwf8Kniflxe/um5ulo6z/m4gLgN7c2LnoYqDOue3FppSBIgvjKij
        /s5oQGM8ghZMX1CuPMWT8/7Dohwd4fo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15B1C1344A
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1/FdMhzJ4GFWZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/5] btrfs-progs: check: properly generate csum for various complex combinations
Date:   Fri, 14 Jan 2022 08:51:18 +0800
Message-Id: <20220114005123.19426-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
  There are some extreme corner cases to consider, in fact we can not
  really determine a range should have csum or not:
  * Preallocated, written, then hole punched range
    Should still have csum for the written (now hole) part.

  * Preallocated, then hole punched range.
    Should not have csum for the now hole part.

  * Regular written extent, then hole punched range
    Should have csum for the now hole part.

  But there is still one thing to follow, if a range is preallocated,
  it should not have csum.

  So here we go a different route, by always generate csum for the whole
  extent (as long as it's not belonging to NODATASUM inode), then remove
  csums for preallocated range.

- Fix for --init-csum-tree --init-extent-tree
  The same fix, just into a different context

- New test case

[CHANGELOG]
v2:
- Handle written extents then hole punched cases
  Now we always generate csum for a data extent as long as it doesn't
  belong to a NODATASUM inode, then remove the csum for preallocated
  range.

- Enhance test case to include hole punching and compressed extents


Qu Wenruo (5):
  btrfs-progs: backref: properly queue indirect refs
  btrfs-progs: check: move csum tree population into mode-common.[ch]
  btrfs-progs: check: don't calculate csum for preallocated file extents
  btrfs-progs: check: handle csum generation properly for
    `--init-csum-tree --init-extent-tree`
  btrfs-progs: fsck-tests: add test case for init-csum-tree

 check/main.c                                | 244 ------------
 check/mode-common.c                         | 393 ++++++++++++++++++++
 check/mode-common.h                         |   1 +
 kernel-shared/backref.c                     |  10 +-
 tests/fsck-tests/052-init-csum-tree/test.sh |  72 ++++
 5 files changed, 474 insertions(+), 246 deletions(-)
 create mode 100755 tests/fsck-tests/052-init-csum-tree/test.sh

-- 
2.34.1

