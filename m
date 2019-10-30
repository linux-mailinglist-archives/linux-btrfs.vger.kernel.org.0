Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0776E9B66
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 13:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfJ3MWb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 08:22:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:41562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfJ3MWa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 08:22:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1534B6C8;
        Wed, 30 Oct 2019 12:22:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] Misc btrfs-progs fixes 
Date:   Wed, 30 Oct 2019 14:22:24 +0200
Message-Id: <20191030122227.28496-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here are 2 cleanups and 1 minor fix for mkfs. The gist of the fix is to ensure 
sub_stripes is always set to 1 when mkfs creates blockgroups with alloc profile 
different than RAID10. This what kernels does. 

The other 2 patches are simple cleanups which reduce the number of arguments 
of btrfs_alloc_data_chunk. 

Nikolay Borisov (3):
  btrfs-progs: Initialize sub_stripes to 1 in btrfs_alloc_data_chunk
  btrfs-progs: Remove type argument from btrfs_alloc_data_chunk
  btrfs-progs: Remove convert param from btrfs_alloc_data_chunk

 convert/main.c |  4 +---
 volumes.c      | 52 ++++++++++++++++++----------------------------------
 volumes.h      |  3 +--
 3 files changed, 20 insertions(+), 39 deletions(-)

-- 
2.7.4

