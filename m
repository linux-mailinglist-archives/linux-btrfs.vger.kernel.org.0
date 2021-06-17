Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BD93AB10E
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFQKOS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 06:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhFQKOS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 06:14:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73336613E7
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jun 2021 10:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623924730;
        bh=zSJA62zGCOLSVbR3m0pRWQfx4zV/FZiJ/01HBNLYtXw=;
        h=From:To:Subject:Date:From;
        b=BBpnLzAoFIk3QvuS5cVPDITPcnmVqILmuO0kdEI/MKM1HknUaUMhWt8rELrVbrOI7
         MDsy3eCGRHKW5M+4gFLrM27N/gX+v8F5c13o0jw7Y/pBOx7OnPeA/SWyLNv0VnbCYs
         gjqbX/19f1uOtvjLYXVNFG2dHgswgDnoguIIhDE9CV39pSz2kKCAuZ0xwc59NvdPg1
         CEbJYS31QHYmZheiWHWUebyDRnKoV+GRqw9FYGBU3BrauvjFd3CgItRB4lJCvRk5TP
         WqpeUkK56fBspP6qqu6kSkPMCwJBsP0JdvFCAe/QjtYGLKbzdenHp671aUwbdnbk9O
         NN/ii5Eo5RAMQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fixes for send with relocation and reclaim
Date:   Thu, 17 Jun 2021 11:12:06 +0100
Message-Id: <cover.1623924268.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There's a recent report from Chris Murphy on a crash caused by send
triggering reclaim and inode eviction due to page/memory allocation,
the second patch fixes that. The first one just prevents relocation from
happening while there are send operations in progress, as currently only
balance is prevented from running but other operations can trigger
relocation too (device shrinking and automatic chunk relocation on zoned
filesystems). Details are in the changelogs of the patches.

Filipe Manana (2):
  btrfs: ensure relocation never runs while we have send operations
    running
  btrfs: send: fix crash when memory allocations trigger reclaim

 fs/btrfs/block-group.c | 10 ++++++++--
 fs/btrfs/ctree.h       |  5 +++--
 fs/btrfs/disk-io.c     | 19 ++-----------------
 fs/btrfs/qgroup.c      |  8 +-------
 fs/btrfs/relocation.c  | 13 +++++++++++++
 fs/btrfs/send.c        | 12 +++++-------
 fs/btrfs/transaction.c |  3 ---
 fs/btrfs/transaction.h |  2 --
 fs/btrfs/volumes.c     |  8 --------
 9 files changed, 32 insertions(+), 48 deletions(-)

-- 
2.28.0

