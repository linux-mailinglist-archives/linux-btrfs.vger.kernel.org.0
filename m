Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD5F203C5B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 18:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgFVQUX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 12:20:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:46030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbgFVQUX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 12:20:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38D3BC220
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jun 2020 16:20:22 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] Rearrange inode locking
Date:   Mon, 22 Jun 2020 11:20:09 -0500
Message-Id: <20200622162017.21773-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series attempts to arrange inode locking and unlocking to be more
aligned to ext4 and xfs, and makes it simpler in logic. The main goal is
to have shared inode lock for direct reads and direct writes within EOF
to make sure we do not race with truncate.

The advantage is that we get rid of btrfs_inode->dio_sem in the DIO
path.

This patch is on top of btrfs-iomap-dio work and survived a run of
xfstests.

Git: https://github.com/goldwynr/linux/tree/btrfs-inode-lock

 btrfs_inode.h |   10 -
 ctree.h       |    8 +
 file.c        |  355 +++++++++++++++++++++++++++++++---------------------------
 inode.c       |   13 +-
 4 files changed, 207 insertions(+), 179 deletions(-)

-- 
Goldwyn


