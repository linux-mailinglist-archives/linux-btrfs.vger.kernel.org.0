Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D592218B37B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 13:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgCSMdZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 08:33:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:40784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbgCSMdZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 08:33:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91951AD72;
        Thu, 19 Mar 2020 12:33:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] uboot: fs/btrfs: Fix read error on LZO compressed extents
Date:   Thu, 19 Mar 2020 20:33:17 +0800
Message-Id: <20200319123319.37848-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug that uboot can't load LZO compressed data extent while
kernel can handle it without any problem.

It turns out to be a page boundary case. The 2nd patch is the proper
fix, backported from btrfs-progs.

The first patch is just to make my eyes less hurt.

I guess it's time to backport proper code from btrfs-progs, other than
using tons of immediate numbers.

Qu Wenruo (2):
  uboot: fs/btrfs: Use LZO_LEN to replace immediate number
  uboot: fs/btrfs: Fix LZO false decompression error caused by pending
    zero

 fs/btrfs/compression.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

-- 
2.25.1

