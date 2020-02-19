Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7675F16464D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 15:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgBSOFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 09:05:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:46160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgBSOFo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 09:05:44 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32F8C2176D
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2020 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582121143;
        bh=8aeWqQDvGBQnaonKTNBXGQkyv/H7qazvWwhR3fRraVk=;
        h=From:To:Subject:Date:From;
        b=NxoVdENl7kQUlsPFKQ16plbv/ISNpoGYJSrhcNdDq1uJdgklBEVeESu6r36bc3y9Z
         EU1/fmhFQkvzDwMIgxwswe49zwtIs4fCtw1Vhzh/RNEIXt//X+w85vg92QzNczM7nF
         PsIthxhXsuhpYfsf5tWdyfdpkjlMrELHDLRHz7fY=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] Add full support for cloning ranges with inline extents
Date:   Wed, 19 Feb 2020 14:05:39 +0000
Message-Id: <20200219140539.1641457-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This patchset adds support for currently unsupported cases of reflink
operations that cover a file range that has inline extents, more details
on why/how in patch 4/4.

It also starts by moving all the reflink code out of ioctl.c into a new
file named reflink.c (like xfs does) since this code is quite significant
in size and has grown over the years.

Filipe Manana (4):
  Btrfs: move all reflink implementation code into its own file
  Btrfs: simplify inline extent handling when doing reflinks
  Btrfs: resurrect extent_read_full_page_nolock()
  Btrfs: implement full reflink support for inline extents

 fs/btrfs/Makefile      |   2 +-
 fs/btrfs/compression.c |   8 +-
 fs/btrfs/ctree.h       |   2 +
 fs/btrfs/extent_io.c   |  47 ++-
 fs/btrfs/extent_io.h   |   3 +
 fs/btrfs/ioctl.c       | 733 -------------------------------------
 fs/btrfs/reflink.c     | 803 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 854 insertions(+), 744 deletions(-)
 create mode 100644 fs/btrfs/reflink.c

-- 
2.25.0

