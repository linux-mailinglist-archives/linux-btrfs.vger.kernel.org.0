Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA9212516
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgGBNqx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:46:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:45792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgGBNqx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:46:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A567AD76;
        Thu,  2 Jul 2020 13:46:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 00/10] A bunch of misc cleanups
Date:   Thu,  2 Jul 2020 16:46:40 +0300
Message-Id: <20200702134650.16550-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here's an assortment of little quality-of-life patches that I created while
looking into the raid56 code. They should bear no functional changes and have
tested them with xfstest and nothing fell over so should be rather low risk.

Patch 1 moves code in __btrfs_map_block, essentially assigning tgtdev_map/raid_map
closet to where space for them is allocated. This also neccesiated moving the
call to sort_parity_stripes. The end result is (hopefully) slightly easier to
follow __btrfs_map_block.

Next 5 patches cleanup minor things in raid56.c such as removing redundant checks,
making code interacting with bio_list more in line with what the rest of the
kernel is doing. Finally it's using some macros/functions instead of open-coding
them. Really just a bunch of low hanging fruit.

Final 4 patches gradually remove all labels in btrfs_submit_compressed_read.
Current failures can be handled "inline" so to speak, without the need for
extra labels. This likely will change once the BUG_ONs are removed but we are
not there yet.

Nikolay Borisov (10):
  btrfs: Always initialize btrfs_bio::tgtdev_map/raid_map pointers
  btrfs: raid56: Remove redundant check in rbio_add_io_page
  btrfs: raid56: Assign bio in while()
  btrfs: raid56: Remove out label in __raid56_parity_recover
  btrfs: raid56: Use in_range where applicable
  btrfs: raid56: Don't opencode swap()
  btrfs: Remove fail label in check_compressed_csum
  btrfs: Remove fail1 label in btrfs_submit_compressed_read
  btrfs: Remove fail2 label from btrfs_submit_compressed_read
  btrfs: Remove out label in btrfs_submit_compressed_read

 fs/btrfs/compression.c | 48 +++++++++++++-------------------
 fs/btrfs/raid56.c      | 63 ++++++++++--------------------------------
 fs/btrfs/volumes.c     | 34 ++++++++++-------------
 3 files changed, 49 insertions(+), 96 deletions(-)

--
2.17.1

