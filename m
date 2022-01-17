Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B104A490046
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 03:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiAQCjK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 21:39:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45064 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiAQCjJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 21:39:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 354C5212BC
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 02:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642387148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2RVeVvhWGrqEF2c+m2HzlezyrT1HrAHiByFobCeT02s=;
        b=TXaIF8x+wvwZlKKpbtacoMWfiHoqIFERfUFkLK244o/zzpwOZA6ifimNqhflcR15uJVCfB
        0B1nlCqU9umlPcPQOur6v4OuA5nkCoHJgBc2uh7Dh595JqzWgl4yUXq3TfgaIoaNBNMwXC
        Y3/6AwNBvYltPXiSxRZ/QuU0LDToi3Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82F0713216
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 02:39:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x4bSEsvW5GG9MAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 02:39:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: fsck: detect obviously invalid metadata backref level
Date:   Mon, 17 Jan 2022 10:38:47 +0800
Message-Id: <20220117023850.40337-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a report that kernel tree-checker rejects a tree block of
extent tree, as it contains an obvious corrupted level (which is an
obvious bit flip).

But btrfs check, at least original mode, doesn't detect it at all.
While with my crafted image, lowmem mode would just crash due to the
large level value overflowing path->nodes[level].

Lowmem is enhanced to reject such level, and the existing code will
verify the level and report errors.

Original mode is more tricky, as it doesn't have level check at all.
I don't have a good idea to implement full level check at original mode,
so here I just introduced a basic check for tree level and reject it.

Finally introduce a test case for this.

Qu Wenruo (3):
  btrfs-progs: check/lowmem: fix crash when METADATA_ITEM has invalid
    level
  btrfs: check/original: reject bad metadata backref with invalid level
  btrfs-progs: tests/fsck: add test image with invalid metadata backref
    level

 check/main.c                                  |  19 ++++++++++++++++++
 check/mode-lowmem.c                           |  12 ++++++++++-
 .../053-bad-metadata-level/default.img.xz     | Bin 0 -> 2084 bytes
 .../fsck-tests/053-bad-metadata-level/test.sh |  19 ++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 tests/fsck-tests/053-bad-metadata-level/default.img.xz
 create mode 100755 tests/fsck-tests/053-bad-metadata-level/test.sh

-- 
2.34.1

