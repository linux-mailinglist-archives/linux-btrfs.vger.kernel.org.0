Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F498FB86F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 20:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfKMTG1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 14:06:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:33112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726311AbfKMTG1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 14:06:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 550E6B02C;
        Wed, 13 Nov 2019 19:06:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E7C15DA7AF; Wed, 13 Nov 2019 20:06:28 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 5.4-rc8
Date:   Wed, 13 Nov 2019 20:06:25 +0100
Message-Id: <cover.1573671550.git.dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following fix for an older bug that has started to show
up during testing (because of an updated test for rename exchange). It's
an in-memory corruption caused by local variable leaking out of the
function scope.

Thanks.

----------------------------------------------------------------
The following changes since commit a5009d3a318e9f02ddc9aa3d55e2c64d6285c4b9:

  btrfs: un-deprecate ioctls START_SYNC and WAIT_SYNC (2019-11-04 21:42:01 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc7-tag

for you to fetch changes up to e6c617102c7e4ac1398cb0b98ff1f0727755b520:

  Btrfs: fix log context list corruption after rename exchange operation (2019-11-11 19:46:02 +0100)

----------------------------------------------------------------
Filipe Manana (1):
      Btrfs: fix log context list corruption after rename exchange operation

 fs/btrfs/inode.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
