Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F3DC3F2B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 19:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfJAR53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 13:57:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:33318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731687AbfJAR53 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 13:57:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 049F9AF32;
        Tue,  1 Oct 2019 17:57:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D39A4DA88C; Tue,  1 Oct 2019 19:57:45 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/3] Coldify, constify, purify (function attributes)
Date:   Tue,  1 Oct 2019 19:57:45 +0200
Message-Id: <cover.1569587835.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a gcc option -Wsuggest-attribute that, as it says, suggests some
function attributes to provide some hints and allowing more
optimizations.

Debug build

   text    data     bss     dec     hex filename
1514058  146768   27496 1688322  19c302 pre/btrfs.ko
1512603  146736   27496 1686835  19bd33 post/btrfs.ko
DELTA: -1455

Release build

   text    data     bss     dec     hex filename
1079288   17316   14912 1111516  10f5dc pre/btrfs.ko
1078138   17316   14912 1110366  10f15e post/btrfs.ko
DELTA: -1150

David Sterba (3):
  btrfs: add __cold attribute to more functions
  btrfs: add const function attribute
  btrfs: add __pure attribute to functions

 fs/btrfs/async-thread.c | 6 ++----
 fs/btrfs/async-thread.h | 4 ++--
 fs/btrfs/ctree.c        | 2 +-
 fs/btrfs/ctree.h        | 6 +++---
 fs/btrfs/dev-replace.c  | 2 +-
 fs/btrfs/dev-replace.h  | 2 +-
 fs/btrfs/disk-io.c      | 4 ++--
 fs/btrfs/disk-io.h      | 4 ++--
 fs/btrfs/ioctl.c        | 2 +-
 fs/btrfs/space-info.c   | 2 +-
 fs/btrfs/space-info.h   | 2 +-
 fs/btrfs/super.c        | 4 ++--
 fs/btrfs/volumes.c      | 4 ++--
 fs/btrfs/volumes.h      | 2 +-
 14 files changed, 22 insertions(+), 24 deletions(-)

-- 
2.23.0

