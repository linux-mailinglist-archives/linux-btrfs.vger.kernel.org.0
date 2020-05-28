Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC321E63B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391104AbgE1OWu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 10:22:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:53516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391022AbgE1OWt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 10:22:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A3E11AA4F
        for <linux-btrfs@vger.kernel.org>; Thu, 28 May 2020 14:22:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF225DA72D; Thu, 28 May 2020 16:21:48 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
Subject: Next btrfs development cycle - 5.9
Date:   Thu, 28 May 2020 16:21:47 +0200
Message-Id: <20200528142147.9199-1-dsterba@suse.com>
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

5.6 - current
5.7 - upcoming, urgent regression fixes only
5.8 - development closed, pull request in prep, fixes or regressions only
5.9 - development open, until 5.8-rc5 (at least)

(https://btrfs.wiki.kernel.org/index.php/Developer%27s_FAQ#Development_schedule)


Current status
--------------

The pull request branch has been forked off misc-next, it's named misc-5.8.
Merge window most likely opens on Monday.

Fixes, improvements, hilights:

* improved global reserve utilization
* speedup dead root detection during orphan cleanup
* send: emit file capabilities after chown
* direct io port to iomap infrastructure

Cleanups:

* backref iterators factored out, used for normal backrefs and relocation
* direct io simplified and cleaned up
* block group reading
* set/get helpers
* REF_COWS renamed to SHAREABLE


Merge outlook
-------------

From now on only selected fixes will be merged to 5.8 queue.  In 5.9 I'd like
to do a stabilization release, we've had quite some core updates in 5.7.
So, merge less intrusive features (ioctls, sysfs updates, ...) and reasonable
cleanups, besides the usual fixes.

I have looked at the following patchsets and think that we should be able to
finalize them in time:

* device mirror balancing - besides the manual mirror selection we need a
			    better default balancing policy and may need to
			    experiment a bit to find replacement for the
			    pid-based one

* ioctl to dump chunks - to replace search tree ioctl where possible, eg. df or
                         usage, (also this might be used as a heuristic for
			 balancing or to suggest what to balance but that would
			 be a bonus)

The authenticated checksums patchset is on a good track, the core is done but
as this is a security-related feature we don't want to rush it.


Git development repos
---------------------

  k.org: https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
  devel1: https://gitlab.com/kdave/btrfs-devel
  devel2: https://github.com/kdave/btrfs-devel
