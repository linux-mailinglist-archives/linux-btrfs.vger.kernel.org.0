Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86F987270
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 08:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405566AbfHIGxc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 02:53:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:38116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728823AbfHIGxc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Aug 2019 02:53:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 268FBB03B
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2019 06:53:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: Check and repair invalid root item generation
Date:   Fri,  9 Aug 2019 14:53:17 +0800
Message-Id: <20190809065320.22702-1-wqu@suse.com>
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

Qu Wenruo (3):
  btrfs-progs: check/lowmem: Check and repair root generation
  btrfs-progs: check/original: Check and repair root item geneartion
  btrfs-progs: fsck-tests: Add test case for invalid root generation

 check/main.c                                  |  20 ++++++++++++
 check/mode-common.c                           |  29 ++++++++++++++++++
 check/mode-common.h                           |   1 +
 check/mode-lowmem.c                           |  16 ++++++++++
 check/mode-lowmem.h                           |   1 +
 .../default_case.img                          | Bin 0 -> 3072 bytes
 6 files changed, 67 insertions(+)
 create mode 100644 tests/fsck-tests/041-invalid-root-generation/default_case.img

-- 
2.22.0

