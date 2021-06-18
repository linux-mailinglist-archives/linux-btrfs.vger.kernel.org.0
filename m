Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9883AD4CF
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jun 2021 00:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhFRWJC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 18:09:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50700 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbhFRWJB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 18:09:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3CA9721A95;
        Fri, 18 Jun 2021 22:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624054010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=eQ97ySKqUY5sJYiNs0e4ec4qGYY54ruXYkWNXH/lJUw=;
        b=U2F+C+QZaEKg00JMjrdlbQR0z5uvg2+I37mydQiNuF8bq/BhQfpJ/+DSB3bVyYG9sQz6XK
        YUEGoN+DuCXhf74NSljxfoVpbgBktdPHQD/3ex508+tmsc+ANYsZqw9WHmrOmKgevFbtfe
        VyIxLI5x1Fa1kGoCGkSqRUc5fpXTOHI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 32A3BA3BC2;
        Fri, 18 Jun 2021 22:06:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5992BDA79B; Sat, 19 Jun 2021 00:04:01 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 5.13-rc7
Date:   Sat, 19 Jun 2021 00:03:55 +0200
Message-Id: <cover.1624051838.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

one more fix, for a space accounting bug in zoned mode. It happens when
a block group is switched back rw->ro and unusable bytes (due to
zoned constraints) are subtracted twice.

It has user visible effects so I consider it important enough for late
-rc inclusion and backport to stable.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit aefd7f7065567a4666f42c0fc8cdb379d2e036bf:

  btrfs: promote debugging asserts to full-fledged checks in validate_super (2021-06-04 13:12:06 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc6-tag

for you to fetch changes up to f9f28e5bd0baee9708c9011897196f06ae3a2733:

  btrfs: zoned: fix negative space_info->bytes_readonly (2021-06-17 11:12:14 +0200)

----------------------------------------------------------------
Naohiro Aota (1):
      btrfs: zoned: fix negative space_info->bytes_readonly

 fs/btrfs/block-group.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
