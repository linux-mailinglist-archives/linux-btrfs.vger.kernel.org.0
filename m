Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F350135B585
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Apr 2021 15:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhDKN6O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Apr 2021 09:58:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:51918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233514AbhDKN6N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Apr 2021 09:58:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618149476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NRvrdUMQPsfy2+W9X3tI7YbnOGgdPIi8JAXEx3PrhwU=;
        b=ZVLkF0clR8BNYNUsYrnxe1L3zWGyMAfnbMxjAq9cBhnYfYe2wTCQdbd8pd8F/0dhTm+fmV
        +CEbr1ei33YEx2a8kCQwR+jouHWbwEY8yueTaOt10wbCzm/+EdCQaso6ooioqWiMjVDVHg
        y4J9hfWaGM+TBBSq1hT0mvILBd8xPQY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08140B1C3;
        Sun, 11 Apr 2021 13:57:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA905DAF1F; Sun, 11 Apr 2021 15:55:41 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 5.12-rc7
Date:   Sun, 11 Apr 2021 15:55:41 +0200
Message-Id: <cover.1618147058.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.cz>

Hi,

here's one more patch that we'd like to get to 5.12 before release, it's
changing where and how the superblock is stored in the zoned mode. It is
an on-disk format change but so far there are no implications for users
as the proper mkfs support hasn't been merged and is waiting for the
kernel side to settle.

Until now, the superblocks were derived from the zone index, but zone
size can differ per device. This is changed to be based on fixed offset
values, to make it independent of the device zone size.

The work on that got a bit delayed, we discussed the exact locations to
support potential device sizes and usecases. (Partially delayed also due
to my vacation.) Having that in the same release where the zoned mode is
declared usable is highly desired, there are userspace projects that
need to be updated to recognize the feature.  Pushing that to the next
release would make things harder to test.

Please pull, thanks.


----------------------------------------------------------------
The following changes since commit c1d6abdac46ca8127274bea195d804e3f2cec7ee:

  btrfs: fix check_data_csum() error message for direct I/O (2021-03-18 21:25:11 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc6-tag

for you to fetch changes up to 53b74fa990bf76f290aa5930abfcf37424a1a865:

  btrfs: zoned: move superblock logging zone location (2021-04-10 12:13:16 +0200)

----------------------------------------------------------------
Naohiro Aota (1):
      btrfs: zoned: move superblock logging zone location

 fs/btrfs/zoned.c | 53 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 11 deletions(-)
