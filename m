Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550E7403273
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 04:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347001AbhIHCG4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 22:06:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39892 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhIHCGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 22:06:55 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 90BFD1FFE4
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 02:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631066747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xu9d8zkgwlthrt5Gez9wxaW2GDmt+vwweF+eWuqMh6w=;
        b=d71PihGY5FqNIeoWzU9z1uFOrhPAjMPLyrEM/8cLcWRs8fGdiCVZik56QQxaiSoML/xxAW
        W+TtTICv6MAsKCuIT464Cy+HU+CMD8bPZr4cCF4qbc7p1swIhJXObHBNUiAtFwoMEUqM6q
        aioGHTzTOR7lt97ul7S5BhXqeUCKLjY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C0C8F13721
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 02:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 038iH3oaOGHDDgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Sep 2021 02:05:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: only allow certain commands to ignore transid errors
Date:   Wed,  8 Sep 2021 10:05:41 +0800
Message-Id: <20210908020543.54087-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug in reddit (well, really the last place I expect to see
bug reports), that btrfstune -u fails due to transid error, but it also
leaves CHANGING_FSID flag to the super block, prevent btrfs-check to
properly check the fs.

The problem is, all commands in btrfs-progs can ignore transid error,
but there are only very limited usage of such ability.

Btrfstune definitely should not utilize this feature.

This patchset will introduce a new open ctree flag to explicitly
indicate we want to ignore transid errors.

Currently only there are only 3 tools using this feature:

- btrfs-check
  It may fix transid error (at least for the specific test case)

- btrfs-restore
  It wants to ignore all errors.

- btrfs-image
  To make fsck/002 happy.

Also add a test case for btrfstune, to make sure btrfstune can rejects
the fs when an obvious transid mismatch is detected during open_ctree().

Qu Wenruo (2):
  btrfs-progs: introduce OPEN_CTREE_ALLOW_TRANSID_MISMATCH flag
  btrfs-progs: misc-tests: add new test case to make sure btrfstune
    rejects corrupted fs

 check/main.c                                     |  3 ++-
 cmds/restore.c                                   |  3 ++-
 image/main.c                                     | 11 +++++++----
 kernel-shared/ctree.h                            |  1 +
 kernel-shared/disk-io.c                          | 11 +++++++++--
 kernel-shared/disk-io.h                          |  6 ++++++
 .../default_case.img                             |  1 +
 .../049-btrfstune-transid-mismatch/test.sh       | 16 ++++++++++++++++
 8 files changed, 44 insertions(+), 8 deletions(-)
 create mode 120000 tests/misc-tests/049-btrfstune-transid-mismatch/default_case.img
 create mode 100755 tests/misc-tests/049-btrfstune-transid-mismatch/test.sh

-- 
2.33.0

