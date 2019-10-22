Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102B5DFED5
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 09:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388021AbfJVH6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 03:58:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:48332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387999AbfJVH6P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 03:58:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9C58B86B;
        Tue, 22 Oct 2019 07:58:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: dm-log-writes test for fstrim with fsstress
Date:   Tue, 22 Oct 2019 15:58:04 +0800
Message-Id: <20191022075806.16616-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just to make sure the fstrim is not trimming anything vital (like tree
blocks still in use) on btrfs.

The first patch is to enhance log-writes to check each DISCARD
operation.
The feature is not used in test cases, as it's too time consuming.
But should be a pretty handy feature for small logwrites.

The second patch is the test case.
Which triggers fsstress and a loop of fstrim, all recorded by
dm-log-writes.
Then check each FLUSH after the 'prepare' mark.

The test case in theory can go generic, but I'm using various btrfs
specific hack to speed up the test and has a workaround to avoid false
alert.

So far I haven't triggered a bug.

Qu Wenruo (2):
  fstests: log-writes: Add new discard check point
  fstests: btrfs: dm-logwrites test for fstrim and fsstress workload

 src/log-writes/replay-log.c |  10 ++-
 tests/btrfs/197             | 131 ++++++++++++++++++++++++++++++++++++
 tests/btrfs/197.out         |   2 +
 tests/btrfs/group           |   1 +
 4 files changed, 142 insertions(+), 2 deletions(-)
 create mode 100755 tests/btrfs/197
 create mode 100644 tests/btrfs/197.out

-- 
2.23.0

