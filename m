Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F6017291F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 21:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbgB0UBE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 15:01:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:55508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbgB0UBE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 15:01:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1D4C0B117;
        Thu, 27 Feb 2020 20:01:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1F4EFDA83A; Thu, 27 Feb 2020 21:00:43 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/4] Misc cleanups
Date:   Thu, 27 Feb 2020 21:00:42 +0100
Message-Id: <cover.1582832619.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few more cleanups that needed more testing.

David Sterba (4):
  btrfs: inline checksum name and driver definitions
  btrfs: simplify tree block checksumming loop
  btrfs: return void from csum_tree_block
  btrfs: balance: factor out convert profile validation

 fs/btrfs/ctree.c   |  7 ++++---
 fs/btrfs/disk-io.c | 45 +++++++++++----------------------------------
 fs/btrfs/volumes.c | 45 +++++++++++++++++++++------------------------
 3 files changed, 36 insertions(+), 61 deletions(-)

-- 
2.25.0

