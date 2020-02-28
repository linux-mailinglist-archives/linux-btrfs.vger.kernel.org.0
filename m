Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B4C1737D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 14:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgB1NEX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 08:04:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgB1NEW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 08:04:22 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05DAD222C4
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2020 13:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582895062;
        bh=UJjvIx1rFCSTwGMwfL7bMzYUug8u913A0pifGpJI3NE=;
        h=From:To:Subject:Date:From;
        b=nU/sgcR5WxqOWuzWUeqJ+c0YrhfjEpWH2EEd+JHKzYgbwQqg+myiUSBlRTTsGJzSy
         T3BM9hr2oH7iFa5d0E21VXWaUDS4iW4BklSeo96Sx+A6flLWNx50h+grZ1UBhNnKsD
         GVDxLZc1GeoZ6OJj8LqOkoHe9cr0sUrCn4C8qJQA=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/3] Add full support for cloning inline extents
Date:   Fri, 28 Feb 2020 13:04:16 +0000
Message-Id: <20200228130419.16719-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This patchset adds support for currently unsupported cases of reflink
operations that cover a file range that has inline extents, more details
on why/how in patch 3/3.

It also starts by moving all the reflink code out of ioctl.c into a new
file named reflink.c (like xfs does) since this code is quite significant
in size and has grown over the years.

V4: Updated patch 3 to fix a deadlock due to allocating space while holding
    a transaction open. No changes to the first two patches.

V3: Updated first patch to introduce reflink.h as well, besides reflink.c.

V2: Removed third patch from the previous patchset version. Since the full
    page ends up getting written, it's not necessary to read it before
    writing to it in case it's not uptodate. The final patch, which is
    now patch number 3, ends up being simpler as well.

Filipe Manana (3):
  Btrfs: move all reflink implementation code into its own file
  Btrfs: simplify inline extent handling when doing reflinks
  Btrfs: implement full reflink support for inline extents

 fs/btrfs/Makefile  |   2 +-
 fs/btrfs/ctree.h   |   3 -
 fs/btrfs/file.c    |   1 +
 fs/btrfs/ioctl.c   | 733 -----------------------------------------------
 fs/btrfs/reflink.c | 811 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/reflink.h |  12 +
 6 files changed, 825 insertions(+), 737 deletions(-)
 create mode 100644 fs/btrfs/reflink.c
 create mode 100644 fs/btrfs/reflink.h

-- 
2.11.0

