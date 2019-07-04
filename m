Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 341DD5FC2E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 19:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfGDREt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 13:04:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727231AbfGDREs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 13:04:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37039AB9D
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2019 17:04:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4AA8FDA89D; Thu,  4 Jul 2019 19:05:30 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
Subject: Next btrfs development cycle open - 5.4
Date:   Thu,  4 Jul 2019 19:05:25 +0200
Message-Id: <20190704170525.26216-1-dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.cz>

Hi,

a friendly reminder of the timetable and what's expected at this phase.

5.1 - current
5.2 - upcoming, urgent regression fixes only
5.3 - development closed, pull request in prep, fixes or regressions only
5.4 - development open, until 5.3-rc5 (at least)

(https://btrfs.wiki.kernel.org/index.php/Developer%27s_FAQ#Development_schedule)


Current status
--------------

I've forked the misc-next branch to 5.3 from the point where I did enough
testing, there are more patches coming from misc-next still.

There are some strange problems still hit on testing machines so at this point
I don't want to add more patches until we know what's the cause and we have the
fixes ready.


Hilights of 5.3 changes
------------------------

Not much this time, there's majority of cleanups, refactoring and preparatory
patches. The raid1c34 feature is postponed as replace of missing device(s) does
not work as expected. More hash algorithms need the real evaluation, other
feature patchsets don't seem to be near-merge either due to lack of reviews or
more work required.


Git development repos
---------------------

  k.org: https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
  devel1: https://gitlab.com/kdave/btrfs-devel
  devel2: https://github.com/kdave/btrfs-devel


Usual points
------------

* the current patch queue (as is in misc-next) looks stable, so no big
  changes are going to be applied at this time. The usual exceptions are
  bugfixes or obvious cleanups.

* the base of the patches should be the last announced pull request,
  which is going to be named 'for-5.3' in my k.org tree.  Reviewed
  patches will be collected in a branch that's usually named 'misc-next'
  in my devel git repos and is part of the for-next at k.org git repo.

* merging of new patches to misc-next will be slow during the
  merge window

* review other developer patches, test them, find bugs before they are in a
  released kernel
