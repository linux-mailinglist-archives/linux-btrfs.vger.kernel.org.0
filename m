Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DED2DCBCA
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 05:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgLQE6d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 23:58:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:56150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgLQE6c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 23:58:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608181066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FKHYChwNjXM7El1RRq8VjTIpXE3+Fuj4qHFtWu4MkQU=;
        b=Oi7sL1qI6a2jUZ+W3bzfNLmTiWfNeI/Csey6A5iiVDfG8E7BlbiYujq/67SK3KnW4ZhIfu
        QB+BH0HIxMnG0d4np4w9gwHlyhR2C7oRf9WmtBuKJhwHUWFl4OZIRsCcqchDu+ZG5Csglw
        zNisDukL3Qt1/xLnqyS7fSUq8P/nf98=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ABB90AC7B
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 04:57:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: inode: btrfs_invalidatepage() related refactor and fix for subpage
Date:   Thu, 17 Dec 2020 12:57:33 +0800
Message-Id: <20201217045737.48100-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This small patchset contains 3 refactors which are subpage independent.

And the last patch is RFC where I'm not certain about the existing code,
but it solves the problem for subpage during test.

Thus I'm here asking for help on the btrfs_invalidatepage() behavior.

Qu Wenruo (4):
  btrfs: inode: use min() to replace open-code in btrfs_invalidatepage()
  btrfs: inode: remove variable shadowing in btrfs_invalidatepage()
  btrfs: inode: move the timing of TestClearPagePrivate() in
    btrfs_invalidatepage()
  btrfs: inode: make btrfs_invalidatepage() to be subpage compatible

 fs/btrfs/inode.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

-- 
2.29.2

