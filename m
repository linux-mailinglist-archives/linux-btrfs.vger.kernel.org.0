Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906A814347C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 00:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgATXfe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 18:35:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:46226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbgATXfe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 18:35:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7CA78AFD4
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2020 23:35:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BAB32DA733; Tue, 21 Jan 2020 00:35:16 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
Subject: Next btrfs development cycle - 5.7
Date:   Tue, 21 Jan 2020 00:35:15 +0100
Message-Id: <20200120233515.4209-1-dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.cz>

Hi,

a friendly reminder of the timetable and what's expected at this phase.

5.4 - current
5.5 - upcoming, urgent regression fixes only
5.6 - development closed, pull request in prep, fixes or regressions only
5.7 - development open, until 5.5-rc6 (at least)

(https://btrfs.wiki.kernel.org/index.php/Developer%27s_FAQ#Development_schedule)


Current status
--------------

The amount of patches merged for 5.5 is heavily affected by the end of year
break, that is about 2 weeks long and the following week it takes to everybody
sync up again. So this is 3 less weeks of testing and I got the feeling that
everybody just dumped patches before going for the vacation.  So the patch
backlog has grown again.

Current misc-next is reasonably stable, only selected fixes will be merged but
now it's effectively frozen. The merge window will probably open next week so
the timing is adequate.


Hilights of 5.6 changes
-----------------------

Async discard:

* an improved implementation of the -o discard, that leaves more time to freed
  extents to coalesce to longer chunks that are more suitable for trimminng and
  also limits the discard IO not to interfere with regular IO

* the current default IO submission rate should be good enough for most
  usecases, but this might get tuned further, possibly adding some tunables if
  required

Tree-checker got more b-tree leaf checks, and for location key for various
directory items.


Merge outlook
-------------

1. fixes, minor cleanups
2. fixes that need refactoring or cleanups
3. small-sized features, with acked interface
4. the rest (big features, intrusive core changes, ...)

I do want to shake down the backlog, but please understand that it will be one
thing at a time, so it can be tested and reviewed. You don't have to ping or
resend. Wild ride ahead.


Git development repos
---------------------

  k.org: https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
  devel1: https://gitlab.com/kdave/btrfs-devel
  devel2: https://github.com/kdave/btrfs-devel
