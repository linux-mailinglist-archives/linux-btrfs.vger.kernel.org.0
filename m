Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E64632D80
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 12:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfFCKGF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 06:06:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:53964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbfFCKGF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 06:06:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A466FACAA
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2019 10:06:04 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/4] Further FITRIM improvements
Date:   Mon,  3 Jun 2019 13:05:58 +0300
Message-Id: <20190603100602.19362-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu reported beyond EOD (end of device) access with latest FITRIM improvements 
that were merged. Further testing also showed that if ranged FITRIM request is 
sent it's possible to cause u64 overflow which in turn cause calculations to 
go off rail in btrfs_issue_discard (because it's called with start and len 
as (u64)-1) and trim used data. 

This patchset aims to rectify this by: 

1. Documenting the internal __etree_search since due to the rather high 
number of output parameters it can be a bit confusing as to what the invariants 
are. Due to this I got initially confused about possible return values on 
boundary conditions. (Patch 1)

2. Remove ranged support in btrfs_trim_free_extents - having range support in 
btrfs_trim_free_extent is problematic because it's interpreted in device physical 
space whilst range values from userspace should always be interpreted in 
logical space. (Patch 2)

3. Change slightly the semantics of find_first_clear_extent_bit to return the 
range that contains the passed address or in case no such range exists the 
next one, document the function and finally add tests (Patch 3 preps 
btrfs_trim_free_extents to handle the change semantics and Patch 4 change 
the semantics). 

This has been fully tested with xfstest and no regressions were found. 

Nikolay Borisov (4):
  btrfs: Document __etree_search
  btrfs: Always trim all unallocated space in btrfs_trim_free_extents
  btrfs: Skip first megabyte on device when trimming
  btrfs: Don't trim returned range based on input value in
    find_first_clear_extent_bit

 fs/btrfs/extent-tree.c           | 32 +++---------
 fs/btrfs/extent_io.c             | 67 +++++++++++++++++++++---
 fs/btrfs/tests/extent-io-tests.c | 89 ++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 31 deletions(-)

-- 
2.17.1

