Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6C7155045
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 03:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgBGB7t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 20:59:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:35016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbgBGB7s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 20:59:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 48450AD7B;
        Fri,  7 Feb 2020 01:59:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] fstests: btrfs/022 fixes
Date:   Fri,  7 Feb 2020 09:59:39 +0800
Message-Id: <20200207015942.9079-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since now fsstress can create new subvolumes, it causes new problem for
btrfs/022.

First two patches will fix the problem by:
- Enhance _btrfs_get_subvolid()
  So it can catch correct subvolid

- Use proper qgroupid for grep
  This solves the random failure even after _btrfs_get_subvolid
  enhancement.

The last patch will add extra debug output for btrfs/022 to make our
lives easier.

Qu Wenruo (3):
  fstests: btrfs: Use word mathcing for _btrfs_get_subvolid()
  fstests: btrfs/022: Match qgroup id more correctly
  fstests: btrfs/022: Add debug output

 common/btrfs    |  2 +-
 tests/btrfs/022 | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.23.0

