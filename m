Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF937AEFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfG3RJe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 13:09:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728184AbfG3RJd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 13:09:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BBE5DAC10
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2019 17:09:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B4BFBDA808; Tue, 30 Jul 2019 19:10:07 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Sysfs updates
Date:   Tue, 30 Jul 2019 19:10:07 +0200
Message-Id: <cover.1564505777.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Export the potential debugging data in the per-filesystem directories we
already have, so we can drop debugfs. The new directories depend on
CONFIG_BTRFS_DEBUG so they're not affecting normal builds.

David Sterba (2):
  btrfs: sysfs: add debugging exports
  btrfs: delete debugfs code

 fs/btrfs/sysfs.c | 68 +++++++++++++++++++++++-------------------------
 fs/btrfs/sysfs.h |  5 ----
 2 files changed, 32 insertions(+), 41 deletions(-)

-- 
2.22.0

