Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CE0390725
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhEYRMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 13:12:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:33804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhEYRMa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 13:12:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621962659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3LCjLRncmEW6efgOu9WOsADNe8tonAjeZtgtZORkUec=;
        b=j43drL4gzZvUIfo18P3lmShBsQr9MTum95FA1ihZCuFQD8zNzvimqICObyBdJe2opxwlCc
        ZFoM3bbC9JS0Idxl8bhJqMSUWf6Nm8xwxm/opksi65DoaDvD1JUIdGq72zfLX+2BHZMxOf
        JTkGQSnSxHRDIEjPX2izyNKHWMh/5Os=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0C96AEEB;
        Tue, 25 May 2021 17:10:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3121DDA70B; Tue, 25 May 2021 19:08:22 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/9] Misc fixups and cleanups
Date:   Tue, 25 May 2021 19:08:22 +0200
Message-Id: <cover.1621961965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David Sterba (9):
  btrfs: sysfs: fix format string for some discard stats
  btrfs: clear defrag status of a root if starting transaction fails
  btrfs: clear log tree recovering status if starting transaction fails
  btrfs: scrub: factor out common scrub_stripe constraints
  btrfs: document byte swap optimization of root_item::flags accessors
  btrfs: reduce compressed_bio members' types
  btrfs: remove extra sb::s_id from message in
    btrfs_validate_metadata_buffer
  btrfs: simplify eb checksum verification in
    btrfs_validate_metadata_buffer
  btrfs: clean up header members offsets in write helpers

 fs/btrfs/compression.c |  2 +-
 fs/btrfs/compression.h | 20 ++++++++++----------
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/disk-io.c     | 14 +++++++-------
 fs/btrfs/extent_io.c   | 13 +++++++------
 fs/btrfs/scrub.c       |  9 ++-------
 fs/btrfs/sysfs.c       |  4 ++--
 fs/btrfs/transaction.c |  6 ++++--
 fs/btrfs/tree-log.c    |  1 +
 9 files changed, 36 insertions(+), 35 deletions(-)

-- 
2.29.2

