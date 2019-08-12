Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F0189730
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 08:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfHLGe1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 02:34:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:51918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbfHLGe1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 02:34:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC4E0AC63
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2019 06:34:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2.1 0/3] btrfs-progs: Check and repair invalid root item generation
Date:   Mon, 12 Aug 2019 14:34:19 +0800
Message-Id: <20190812063422.22219-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Kernel is going to reject invalid root generation.

Consider the existing checks are causing some error reports, we should
handle such problem in advance, so that's the patchset is going to do,
check and repair such invalid root generation.

Changelog:
v2:
- Use existing recow_extent_buffer() to do the repair

v2.1:
- Add beacon file to allow lowmem mode repair for newly added test case.

Qu Wenruo (3):
  btrfs-progs: check/lowmem: Check and repair root generation
  btrfs-progs: check/original: Check and repair root item geneartion
  btrfs-progs: fsck-tests: Add test case for invalid root generation

 check/main.c                                  |  57 +++++++-----------
 check/mode-common.c                           |  36 +++++++++++
 check/mode-common.h                           |   1 +
 check/mode-lowmem.c                           |  17 ++++++
 check/mode-lowmem.h                           |   1 +
 .../.lowmem_repairable                        |   0
 .../default_case.img                          | Bin 0 -> 3072 bytes
 7 files changed, 76 insertions(+), 36 deletions(-)
 create mode 100644 tests/fsck-tests/041-invalid-root-generation/.lowmem_repairable
 create mode 100644 tests/fsck-tests/041-invalid-root-generation/default_case.img

-- 
2.22.0

