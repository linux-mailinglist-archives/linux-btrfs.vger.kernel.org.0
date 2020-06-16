Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B889D1FA8CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 08:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgFPGcl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 02:32:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:37858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFPGcl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 02:32:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 541E1AC85
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 06:32:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: mkfs: fix mkfs --rootdir size problem
Date:   Tue, 16 Jun 2020 14:32:28 +0800
Message-Id: <20200616063230.90165-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug report that mkfs.btrfs with -b limit, -d dup, and
--rootdir with some contents filled, leads to unexpected ENOSPC.

It turns out that, the new chunk allocation code is broken quite some
time ago, and by coincident we're using SINGLE data profile by default,
it doesn't get exposed through existing test cases.

The patchset will fix it and add corresponding test case for it.

Qu Wenruo (2):
  btrfs-progs: fix wrong chunk profile for do_chunk_alloc()
  btrfs-progs: mkfs-tests: Add test case to verify the --rootdir size
    limit

 extent-tree.c                             | 14 ++++++++++----
 tests/mkfs-tests/021-rootdir-size/test.sh | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 4 deletions(-)
 create mode 100755 tests/mkfs-tests/021-rootdir-size/test.sh

-- 
2.27.0

