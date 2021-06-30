Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1C93B8009
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 11:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhF3JfI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 05:35:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60188 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhF3JfH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 05:35:07 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E34F1FE5F;
        Wed, 30 Jun 2021 09:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625045558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KyU/x4OsFTOgK8JG0QU+epFDTuC6jL58APtB5n/wF70=;
        b=GdpLhqXE1bir63UuYUPg+nd/dgSW4RAxUgx21cEOIbyN+ZZRVqtkmnm+wcHeiqdlmP1ycw
        QX+L5olKYcD4RmKA5xTSlpnT0S+LToL69GY6nVdVY6ER3flbn7m/7VS8+qlUaAIf5TVbQt
        NSe5meRdOxCRuxsZJHl12iXYNlC0o4M=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3834611906;
        Wed, 30 Jun 2021 09:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625045558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KyU/x4OsFTOgK8JG0QU+epFDTuC6jL58APtB5n/wF70=;
        b=GdpLhqXE1bir63UuYUPg+nd/dgSW4RAxUgx21cEOIbyN+ZZRVqtkmnm+wcHeiqdlmP1ycw
        QX+L5olKYcD4RmKA5xTSlpnT0S+LToL69GY6nVdVY6ER3flbn7m/7VS8+qlUaAIf5TVbQt
        NSe5meRdOxCRuxsZJHl12iXYNlC0o4M=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id P6BIOTQ63GAjZwAALh3uQQ
        (envelope-from <wqu@suse.com>); Wed, 30 Jun 2021 09:32:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH 0/4] btrfs: subpage compressed read path fixes
Date:   Wed, 30 Jun 2021 17:32:29 +0800
Message-Id: <20210630093233.238032-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

During the development of subpage write support for compressed file
extents, there is a strange failure in btrfs/038 which results -EIO
during file read on compressed extents.

It exposed a rabbit hole of problems inside compression code, especially
for subpage case. Those problems including:

- bv_offset is not taken into consideration
  This involves several functions:

  * btrfs_submit_compressed_read()
    Without bv_offset taken into consideration, it can get a wrong
    extent map (can even be uncompressed extent) and cause tons
    of problems when doing decompression

  * btrfs_decompress_buf2page()
    It doesn't take bv_offset into consideration, which means it can
    copy wrong data into inode pages.

- PAGE_SIZE abuse inside lzo decompress code
  This makes padding zero behavior differ between different page size.

- Super awful code quality
  Anything involving two page switching is way more complex than it
  needs to be.
  Tons of comments for parameters are completely meaningless.
  Way too many helper variables, that makes it super hard to grab which
  is the main iteration cursor.

This patchset will fix them by:

- Make btrfs_submit_compressed_read() to do proper calculation
  Just a small fix

- Rework btrfs_decompress_buf2page()
  Not only to make it subpage compatible, but also introduce ASCII art
  to explain the parameter list.
  As there are several different offsets involved.

  Use single cursor for the main loop, separate page switching to
  different loops

- Rework lzo_decompress_bio()
  The same style applied to lzo_decompress_bio(), with proper
  sectorsize/PAGE_SIZE usage.

All the rework result smaller code size, even with the excessive
comments style and extra ASSERT()s.

Since this affects the enablement of basic subpage support (affects the
ability to read existing compressed extents), thus this patchset needs
to be merged before the enablement patch.

Thankfully all those patches should bring minimal amount of conflicts as
they are in compression path, not a location touched by subpage support.


If possible, please merge this patchset early so that we can get more
tests to ensure everything at least works fine for 4K page size.

Qu Wenruo (4):
  btrfs: grab correct extent map for subpage compressed extent read
  btrfs: remove the GFP_HIGHMEM flag for compression code
  btrfs: rework btrfs_decompress_buf2page()
  btrfs: rework lzo_decompress_bio() to make it subpage compatible

 fs/btrfs/compression.c | 171 +++++++++++++++++----------------
 fs/btrfs/compression.h |   5 +-
 fs/btrfs/lzo.c         | 210 +++++++++++++++++------------------------
 fs/btrfs/zlib.c        |  18 ++--
 fs/btrfs/zstd.c        |  12 +--
 5 files changed, 188 insertions(+), 228 deletions(-)

-- 
2.32.0

