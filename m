Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E74DF371
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfJUQpC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 12:45:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:52876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbfJUQpC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 12:45:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1B4CABC7;
        Mon, 21 Oct 2019 16:45:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D918BDA733; Mon, 21 Oct 2019 18:45:13 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2 + 0/2] Add BLAKE2 checksumming support
Date:   Mon, 21 Oct 2019 18:45:13 +0200
Message-Id: <cover.1571674940.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The two patches apply on top of Johaness' series adding SHA256. To
make it actually work the patch adding BLAKE2 to kernel is needed. You
can find it here (v5) https://patchwork.kernel.org/patch/11188109/ .

WARNING: This is for testing only!

All in one can be pulled from

  git://github.com/kdave/btrfs-devel preview/checksums-5

and the btrfs-progs patches are in the devel branch

  git://github.com/kdave/btrfs-progs devel

David Sterba (2):
  btrfs: add member for a specific checksum driver
  btrfs: add blake2b to checksumming algorithms

 fs/btrfs/ctree.c                | 14 ++++++++++++++
 fs/btrfs/ctree.h                |  1 +
 fs/btrfs/disk-io.c              |  7 ++++---
 fs/btrfs/super.c                |  1 +
 include/uapi/linux/btrfs_tree.h |  1 +
 5 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.23.0

