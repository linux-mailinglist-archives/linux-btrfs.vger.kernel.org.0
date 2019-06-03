Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D6132B5F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 11:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfFCJFR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 05:05:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:37942 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbfFCJFR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 05:05:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC308AEBF
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2019 09:05:15 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] refactoring __btrfs_map_block
Date:   Mon,  3 Jun 2019 12:05:02 +0300
Message-Id: <20190603090505.16800-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

__btrfs_map_block is probably one of the longest functions in btrfs and is responsible 
for mapping high-level RW requests to a logical address to lower-level bios
that are sent to multiple devices (depending on the allocation profile the block
group this address belongs to). Additionally, it's also used to calculate the
various characteristic of the given (address,len) tuple such as the internal 
stripe len that remains if the given request is satisfied. 

This conflation of 2 actions make it a bit hard to follow the function, this 
patchset aims to rectify this by factoring out the "address calculation
mechanics" into a separate function. To reduce the number of variables having 
to pass also introduce a struct with the same name that holds all the output 
values. 

Nikolay Borisov (3):
  btrfs: Introduce struct btrfs_io_geometry
  btrfs: Introduce btrfs_io_geometry
  btrfs: Use btrfs_io_geometry appropriately

 fs/btrfs/inode.c   |  25 +++----
 fs/btrfs/volumes.c | 169 +++++++++++++++++++++++++++++----------------
 fs/btrfs/volumes.h |  11 +++
 3 files changed, 133 insertions(+), 72 deletions(-)

-- 
2.17.1

