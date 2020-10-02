Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF46F2816AA
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 17:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbgJBPb7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 11:31:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:34436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387990AbgJBPb6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Oct 2020 11:31:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601652717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rYdY+SvDQe9ZTpqrFD5hOVBkZqgE/qo9AF1sRrTlM2I=;
        b=OGdyVc6ybZl2vxu5UQJGx/wSEalchdBO3uXPEUUpNn5PyMR+ZqNdQlXcuPoeMI8Ugt0VpP
        W1Nq5DVWiCn0dDB/ROv0XOfYXrdk+nmQYddJSdwo/k952UY8e7uO39JQ318Wpp87LJZwfu
        BTJ+dUeB/AIXadTeGtB6ydsb2KxZnw4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2367AD18;
        Fri,  2 Oct 2020 15:31:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EC5D8DA781; Fri,  2 Oct 2020 17:30:36 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.9-rc8
Date:   Fri,  2 Oct 2020 17:30:36 +0200
Message-Id: <cover.1601650060.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

two more fixes. One is for a lockdep warning/lockup (also caught by
syzbot), that one has been seen in practice.  Regarding the other syzbot
reports mentioned last time, they don't seem to be urgent and reliably
reproducible so they'll be fixed later.

The second fix is for a potential corruption when device replace
finishes and the in-memory state of trim is not copied to the new
device.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit b5ddcffa37778244d5e786fe32f778edf2bfc93e:

  btrfs: fix put of uninitialized kobject after seed device delete (2020-09-22 15:57:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc7-tag

for you to fetch changes up to 4c8f353272dd1262013873990c0fafd0e3c8f274:

  btrfs: fix filesystem corruption after a device replace (2020-09-30 19:40:51 +0200)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: fix filesystem corruption after a device replace

Josef Bacik (2):
      btrfs: move btrfs_scratch_superblocks into btrfs_dev_replace_finishing
      btrfs: move btrfs_rm_dev_replace_free_srcdev outside of all locks

 fs/btrfs/dev-replace.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.c     | 13 +++++--------
 fs/btrfs/volumes.h     |  3 +++
 3 files changed, 52 insertions(+), 10 deletions(-)
