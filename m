Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15AC1875BD
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 23:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbgCPWit (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 18:38:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:45888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732739AbgCPWit (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 18:38:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E3A1ABCF
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Mar 2020 22:38:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1A87DDA726; Mon, 16 Mar 2020 23:38:20 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
Subject: Next btrfs development cycle - 5.8
Date:   Mon, 16 Mar 2020 23:38:19 +0100
Message-Id: <20200316223819.13329-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.cz>

Hi,

a friendly reminder of the timetable and what's expected at this phase.

5.5 - current
5.6 - upcoming, urgent regression fixes only
5.7 - development closed, pull request in prep, fixes or regressions only
5.8 - development open, until 5.7-rc5 (at least)

(https://btrfs.wiki.kernel.org/index.php/Developer%27s_FAQ#Development_schedule)


Current status
--------------

Short summary of patch groups:

* per-inode file extent tree
* SRCU root protection replaced by reference counting
* leak detector for root in-memory structures
* per-transaction pinned extents
* buffer heads replaced by bios for super block reading
* backref resolution speedup
* v2 ioctl for subvolume deletion (delete by id possible)
* DREW lock (double reader/writer exclusion lock) abstracted from subvolume
  writer vs NOCOW
* support reflink/clone of inline files
* more cancellation points for relocation
* make ranged full fsyncs more efficient
* several relocation fixes
* removal of deprecated async subvolume creation mode

Cleanups:

* submit extent pages
* sysfs handlers
* uuid wrappers
* chunk allocation (in preparation for zoned allocator)

+ many other fixes

There are 200+ patches, but I'm more worried about possible interactions
between the various parts that got changed. Misc-next should be in a good
shape but stress testing could reveal some corner cases. There are changes in
independent areas same as core building blocks.

Merge outlook
-------------

From now on only selected fixes will be merged so 5.7 queue is effectively
frozen.  The merge window will probably open next week, and if not I don't want
to do any risky changes.

With the flood of new patchsets in the mailinglist the 5.8 round will start
soonish. As in the previous development cycle, the order of patches is roughly
this

1. fixes, minor cleanups
2. fixes that need refactoring or cleanups
3. small-sized features, with acked interface
4. the rest (big features, intrusive core changes, ...)


Git development repos
---------------------

  k.org: https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
  devel1: https://gitlab.com/kdave/btrfs-devel
  devel2: https://github.com/kdave/btrfs-devel
