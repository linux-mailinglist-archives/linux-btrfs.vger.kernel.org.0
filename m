Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6618B140477
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 08:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgAQHaF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 02:30:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:45060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbgAQHaF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 02:30:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7C2F9ABEA
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 07:30:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: Do proper extent item generation repair
Date:   Fri, 17 Jan 2020 15:29:56 +0800
Message-Id: <20200117072959.27929-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before this patchset, the only way to repair invalid extent item
generation is to use --init-extent-tree, which is really a bad idea.

To rebuild the whole extent tree just for one corrupted extent item?
I must be insane at that time.

This patch introduces the proper extent item generation repair
functionality for both mode, and alter existing test case to also test
repair.

Qu Wenruo (3):
  btrfs-progs: check/lowmem: Repair invalid extent item generation
  btrfs-progs: check/original: Repair extent item generation
  btrfs-progs: tests/fsck-044: Enable repair test for invalid extent
    item generation

 check/main.c                                  | 66 +++++++++++++++++
 check/mode-lowmem.c                           | 74 +++++++++++++++++++
 .../.lowmem_repairable                        |  0
 .../test.sh                                   | 19 -----
 4 files changed, 140 insertions(+), 19 deletions(-)
 create mode 100644 tests/fsck-tests/044-invalid-extent-item-generation/.lowmem_repairable
 delete mode 100755 tests/fsck-tests/044-invalid-extent-item-generation/test.sh

-- 
2.24.1

