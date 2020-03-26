Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1DC11937E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 06:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgCZFgC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 01:36:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgCZFgC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 01:36:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 27E26AB98;
        Thu, 26 Mar 2020 05:36:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH U-BOOT v2 0/3] fs: btrfs: Fix false LZO decompression error due to missing page boundary check
Date:   Thu, 26 Mar 2020 13:35:53 +0800
Message-Id: <20200326053556.20492-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug that uboot can't load LZO compressed data extent while
kernel can handle it without any problem.

It turns out to be a page boundary case. The 3nd patch is the proper
fix, cross-ported from btrfs-progs.

The first patch is just to make my eyes less hurt.
The second patch is to make sure the driver will reject sector size not
matching PAGE_SIZE.
This keeps the behavior the same as kernel, even in theory we could do
better in U-boot. This is just a temporary fix, before better btrfs
driver implemented.

I guess it's time to backport proper code from btrfs-progs, other than
using tons of immediate codes.

Changelog:
v2:
- Fix code style problems
- Add a new patch to reject non-page-sized sector size
  Since kernel does the same thing, and non-4K page size u-boot boards
  are really rare, it shouldn't be a big problem.

Qu Wenruo (3):
  fs: btrfs: Use LZO_LEN to replace immediate number
  fs: btrfs: Reject fs with sector size other than PAGE_SIZE
  fs: btrfs: Fix LZO false decompression error caused by pending zero

 fs/btrfs/compression.c | 42 +++++++++++++++++++++++++++++++-----------
 fs/btrfs/super.c       |  8 ++++++++
 2 files changed, 39 insertions(+), 11 deletions(-)

-- 
2.26.0

