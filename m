Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED1E49B7CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 16:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582081AbiAYPkK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 10:40:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46108 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445727AbiAYPhp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 10:37:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2E4D61F380;
        Tue, 25 Jan 2022 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643125061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HJQ29oRt223Ea++rW0n+gWnf5Ie/PrsbXAgUL9gxVF0=;
        b=JoQVzhpvcz0LeZUrm+SbsH32H3rGAxtFWBZI6pl2V+PkQLKuMNlPZrBJGRoRECmVGUyLUC
        fuXtFz8SjX2BToNKQ9kDzNusRqHGPL6+y9eEvMAJy3sYSXRX7PEa5Yp66XX/SnQyZjnHiM
        WHXeyxO9QjuDnacp1omyNVIJMmbXfrY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 26C15A3B83;
        Tue, 25 Jan 2022 15:37:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D8943DA7A9; Tue, 25 Jan 2022 16:37:00 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.17-rc2
Date:   Tue, 25 Jan 2022 16:36:59 +0100
Message-Id: <cover.1643122662.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

several fixes for defragmentation that got broken in 5.16 after
refactoring and added subpage support. The observed bugs are excessive
IO or uninterruptible ioctl.

All stable material. Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 36c86a9e1be3b29f9f075a946df55dfe1d818019:

  btrfs: output more debug messages for uncommitted transaction (2022-01-07 14:18:27 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-rc1-tag

for you to fetch changes up to 27cdfde181bcacd226c230b2fd831f6f5b8c215f:

  btrfs: update writeback index when starting defrag (2022-01-24 18:16:28 +0100)

----------------------------------------------------------------
Filipe Manana (5):
      btrfs: fix too long loop when defragging a 1 byte file
      btrfs: allow defrag to be interruptible
      btrfs: fix deadlock when reserving space during defrag
      btrfs: add back missing dirty page rate limiting to defrag
      btrfs: update writeback index when starting defrag

Qu Wenruo (2):
      btrfs: defrag: fix wrong number of defragged sectors
      btrfs: defrag: properly update range->start for autodefrag

 fs/btrfs/ioctl.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 75 insertions(+), 9 deletions(-)
