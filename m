Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB13C231B5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 10:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgG2Ikn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 04:40:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:43080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbgG2Ikn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 04:40:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1F59AC22
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 08:40:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: convert: better ENOSPC handling
Date:   Wed, 29 Jul 2020 16:40:35 +0800
Message-Id: <20200729084038.78151-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset is to address a bug report [1], where even with the bit
overflow bug fixed, the user is still unable to convert an ext4 fs to
btrfs.

The error is -ENOSPC, which triggers BUG_ON() and brings the end to the
convertion.

We're still waiting for the image dump to determine what's the real
cause is, but considering the user is still reporting around 40% free
space, I guess it's something wrong with the extent allocator.

But still, we can enhance btrfs-convert to make it handle errors more
gracefully, with better error message, and even some debugging info like
the available space / total space ratio.

Qu Wenruo (3):
  btrfs-progs: convert: handle errors better in ext2_copy_inodes()
  btrfs-progs: convert: update error message to reflect original fs
    unmodified cases
  btrfs-progs: convert: report available space before convertion happens

 convert/common.h      |  9 +++++++++
 convert/main.c        | 34 +++++++++++++++++++++++++++++++---
 convert/source-ext2.c | 42 +++++++++++++++++++++++++++++++-----------
 convert/source-fs.c   |  1 +
 4 files changed, 72 insertions(+), 14 deletions(-)

-- 
2.27.0

