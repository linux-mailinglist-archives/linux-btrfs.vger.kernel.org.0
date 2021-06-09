Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7122E3A15A3
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 15:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhFINdO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 09:33:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42782 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhFINdK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 09:33:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 40EC6219B7;
        Wed,  9 Jun 2021 13:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623245475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NhKZvFBtEQxfAj7cWjLqd70+Y9y1riwEcdnv4y2iH6Y=;
        b=Lk++ZmkBOEAOqapfpJt1Soq5p/cQ61zBys5U/l0f4NbQ7XDnNc9PvZ/0qNEPv+uLFyuoZr
        vFiDipTrco/OuUWVWY/hWZi/l1I+yZgJ5vV4cmEouF4GbdfCRfJ2Ll8QuvVegl1Ll75RJz
        6XfI4SoKsezkNu77HMCa5yzhh4PwbzQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3958EA3B87;
        Wed,  9 Jun 2021 13:31:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32E5ADA908; Wed,  9 Jun 2021 15:28:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.13-rc6
Date:   Wed,  9 Jun 2021 15:28:28 +0200
Message-Id: <cover.1623242687.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes that people hit during testing. Please pull, thanks.

- in zomed mode, fix 32bit value wrapping when calculating superblock
  offsets

- error handling
  - properly check filesystema and device uuids
  - properly return errors when marking extents as written
  - do not write supers if we have an fs error

----------------------------------------------------------------
The following changes since commit 503d1acb01826b42e5afb496dfcc32751bec9478:

  MAINTAINERS: add btrfs IRC link (2021-06-03 15:40:38 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc5-tag

for you to fetch changes up to aefd7f7065567a4666f42c0fc8cdb379d2e036bf:

  btrfs: promote debugging asserts to full-fledged checks in validate_super (2021-06-04 13:12:06 +0200)

----------------------------------------------------------------
Josef Bacik (1):
      btrfs: do not write supers if we have an fs error

Naohiro Aota (1):
      btrfs: zoned: fix zone number to sector/physical calculation

Nikolay Borisov (1):
      btrfs: promote debugging asserts to full-fledged checks in validate_super

Ritesh Harjani (1):
      btrfs: return value from btrfs_mark_extent_written() in case of error

 fs/btrfs/disk-io.c  | 26 ++++++++++++++++++--------
 fs/btrfs/file.c     |  4 ++--
 fs/btrfs/tree-log.c | 16 ++++++++++++++++
 fs/btrfs/zoned.c    | 23 ++++++++++++++++++-----
 4 files changed, 54 insertions(+), 15 deletions(-)
