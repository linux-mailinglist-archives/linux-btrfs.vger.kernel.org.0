Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E0C241A88
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 13:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgHKLnc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 07:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgHKLnc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 07:43:32 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EF6A20578
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597146211;
        bh=LC6IHD7tiH6gR3r8+GVjEZcjnfgUzHHaPwMVrPoJL6k=;
        h=From:To:Subject:Date:From;
        b=EMGtrilcByKTzYyc6755QkKEX8Qvx9q94nQ02sfzFcJOO+Yfh2kRJBLYe6jyfnFtg
         VyZrJ1DfaZnRUAebxnZi1HAjooulkyTjC4+595BTg6sbBgXdvkKVHRitnLt4kTuYtR
         7epFRgWqnSvlYs0Lbnwm5EVTyiz6HO+FFg6VSfFw=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: a few performance improvements for fsync and rename/link
Date:   Tue, 11 Aug 2020 12:43:28 +0100
Message-Id: <20200811114328.688282-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A small group of changes to improve performance of fsync, rename and link operations.
They are farily independent, but patch 3 needs to be applied before patch 2, the
order can be changed if needed.
Details and performance tests are mentioned in the change log of each patch.

Filipe Manana (3):
  btrfs: do not take the log_mutex of the subvolume when pinning the log
  btrfs: do not commit logs and transactions during link and rename
    operations
  btrfs: make fast fsyncs wait only for writeback

 fs/btrfs/btrfs_inode.h  |   5 +
 fs/btrfs/file.c         |  97 +++++++++-----
 fs/btrfs/inode.c        | 115 ++---------------
 fs/btrfs/ordered-data.c |  59 +++++++++
 fs/btrfs/ordered-data.h |  11 ++
 fs/btrfs/transaction.c  |  10 ++
 fs/btrfs/transaction.h  |   7 ++
 fs/btrfs/tree-log.c     | 272 +++++++++++++++++++++-------------------
 fs/btrfs/tree-log.h     |  32 +++--
 9 files changed, 334 insertions(+), 274 deletions(-)

-- 
2.26.2

