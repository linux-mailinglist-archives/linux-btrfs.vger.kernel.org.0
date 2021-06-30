Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E033B8289
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 14:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhF3M5y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 08:57:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37748 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbhF3M5x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 08:57:53 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08AF2225CA;
        Wed, 30 Jun 2021 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625057724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=17DidTDDjQGzLMbEcnZNuUjcsUsNfig01YbWI8/VEsI=;
        b=V7ymlQiBvO5QGlJbx/FpEG8pg/Gpd618dohEZPPANSBOi54YXJXaBpUW2XtB61XjI8JTVo
        7pKV3+0r00KiGysC8YAU/Bzg64TGWOLANnyA3hB1y6vEGRAj3Hgv0ewud3qwki7rFDHY5+
        0vQeuCvDcRwSHVU0QTCZh38Hj3N4Tqg=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id BA429118DD;
        Wed, 30 Jun 2021 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625057724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=17DidTDDjQGzLMbEcnZNuUjcsUsNfig01YbWI8/VEsI=;
        b=V7ymlQiBvO5QGlJbx/FpEG8pg/Gpd618dohEZPPANSBOi54YXJXaBpUW2XtB61XjI8JTVo
        7pKV3+0r00KiGysC8YAU/Bzg64TGWOLANnyA3hB1y6vEGRAj3Hgv0ewud3qwki7rFDHY5+
        0vQeuCvDcRwSHVU0QTCZh38Hj3N4Tqg=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id PGd5G7pp3GBqYAAALh3uQQ
        (envelope-from <wqu@suse.com>); Wed, 30 Jun 2021 12:55:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 0/4] btrfs: subpage compressed read path fixes
Date:   Wed, 30 Jun 2021 20:55:08 +0800
Message-Id: <20210630125512.325889-1-wqu@suse.com>
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

It will be re-sent with the unmerged subpage patches, but since it's
touching the common compression code, it's better to be merged early and
get more tests.

Thankfully all those patches should bring minimal amount of conflicts as
they are in compression path, not a location touched by subpage support.



Changelog:
v2:
- Fix an ASSERT() when compressed extent is reflinked to lower bytenr
  This is caused by cb->start which can underflow in that case.
  This makes it impossible to use file_offset as the main cursor

  Fix it by using offset inside the full decompressed extent.
  Since cb->start or any file offset will be substracted, with underflow
  value it will work correctly.

- Fix an false ASSERT() in btrfs_decompress_buf2page()
  It's caused by the wrong value involved in the ASSERT().

- Fix a bug that bio_advance() is only called when we reach page
  boudnary
  This prevents some bio from finishing.
  Fix it by always call bio_advance().

Qu Wenruo (4):
  btrfs: grab correct extent map for subpage compressed extent read
  btrfs: remove the GFP_HIGHMEM flag for compression code
  btrfs: rework btrfs_decompress_buf2page()
  btrfs: rework lzo_decompress_bio() to make it subpage compatible

 fs/btrfs/compression.c | 152 ++++++++++++++---------------
 fs/btrfs/compression.h |   5 +-
 fs/btrfs/lzo.c         | 210 +++++++++++++++++------------------------
 fs/btrfs/zlib.c        |  18 ++--
 fs/btrfs/zstd.c        |  12 +--
 5 files changed, 173 insertions(+), 224 deletions(-)

-- 
2.32.0

