Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD883725CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 08:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhEDG0Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 02:26:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:49890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhEDG0Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 May 2021 02:26:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620109529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FPSnteYEIYF4M4A/OX3Dx2D9KRGrI++gShXldx9hVHY=;
        b=bRz2UN4rXY8JiXRjw92TJqGZVxEAeD3oMppvcvQgVnKUPlmOFnn/nRsTfZ/65g95b0WoQr
        94X9XfEP9bpAmhqNl2cXiMAQ0vTT0K56/7jT1uuG6PD5YHZnknV+3niNv8OEu7EAN22qAy
        Rex1+V34w4f1OnhL3USo3uBu6jbklcA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA4C3AE03
        for <linux-btrfs@vger.kernel.org>; Tue,  4 May 2021 06:25:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: check: add the ability to detect and report mixed inline and regular data extents
Date:   Tue,  4 May 2021 14:25:21 +0800
Message-Id: <20210504062525.152540-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs check original mode can't detect mixed inline and regular data
extents at all, while lowmem mode reports the problem as hole gap, not
to the point.

This patchset will add the ability to detect such problem, with a test
image dumped from subpage branch (with the inline extent disable patch
reverted).

The patchset is here to detect such problem exposed during subpage
development, while also acts as the final safenet to catch such mixed
types bug.

Qu Wenruo (4):
  btrfs-progs: check/original: add the "0x" prefix for hex error number
  btrfs-progs: check/original: detect and report mixed inline and
    regular data extents
  btrfs-progs: check/lowmem: detect and report mixed inline and regular
    extents properly
  btrfs-progs: fsck-tests: add test image for mixed inline and regular
    data extents

 check/main.c                                  |   7 +++-
 check/mode-lowmem.c                           |  31 +++++++++++++++---
 check/mode-original.h                         |   2 ++
 .../047-mixed-extent-types/default.img.xz     | Bin 0 -> 2112 bytes
 .../fsck-tests/047-mixed-extent-types/test.sh |  19 +++++++++++
 5 files changed, 54 insertions(+), 5 deletions(-)
 create mode 100644 tests/fsck-tests/047-mixed-extent-types/default.img.xz
 create mode 100755 tests/fsck-tests/047-mixed-extent-types/test.sh

-- 
2.31.1

