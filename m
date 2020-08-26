Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2963D2524DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 03:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHZBDq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 21:03:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:47804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgHZBDm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 21:03:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B06CAFFD;
        Wed, 26 Aug 2020 00:53:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Tyler Richmond <t.d.richmond@gmail.com>
Subject: [PATCH 0/3] btrfs-progs: check: add inode invalid transid detect and repair support
Date:   Wed, 26 Aug 2020 08:52:30 +0800
Message-Id: <20200826005233.90063-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Really nothing interesting here for btrfs-progs, just reusing existing
inode generation detect and repair code.

The interesting part is, how a wrongly copied error message delayed us
so long to locate a bug.

Reported-by: Tyler Richmond <t.d.richmond@gmail.com>

Qu Wenruo (3):
  btrfs-progs: check/lowmem: add inode transid detect and repair support
  btrfs-progs: check/original: add inode transid detect and repair
    support
  btrfs-progs: tests/fsck: add test image for inode transid repair

 check/main.c                                     |   8 +++++---
 check/mode-lowmem.c                              |  11 +++++++----
 .../bad_inode_transid.img.xz                     | Bin 0 -> 1888 bytes
 3 files changed, 12 insertions(+), 7 deletions(-)
 create mode 100644 tests/fsck-tests/043-bad-inode-generation/bad_inode_transid.img.xz

-- 
2.28.0

