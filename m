Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C9C10238C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 12:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfKSLsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 06:48:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:39258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbfKSLsJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 06:48:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C3C1BDAC
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2019 11:48:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D6512DAAC2; Tue, 19 Nov 2019 12:48:08 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
Subject: Next btrfs development cycle open - 5.6
Date:   Tue, 19 Nov 2019 12:48:07 +0100
Message-Id: <20191119114807.14278-1-dsterba@suse.com>
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

5.3 - current
5.4 - upcoming, urgent regression fixes only
5.5 - development closed, pull request in prep, fixes or regressions only
5.6 - development open, until 5.5-rc5 (at least)

(https://btrfs.wiki.kernel.org/index.php/Developer%27s_FAQ#Development_schedule)


Current status
--------------

Branch misc-5.5 has been forked off misc-next (based on 5.4-rc8) and contains
the first pull request changes.


Hilights of 5.5 changes
------------------------

New checksum algorithms, 3- and 4-copy raid1 (RAID1C34).  Tree checker has
again learned some new tricks.  And as usual there are many cleanups and
refactoring.


Merge outlook
-------------

The async discard patchset looks in a good shape, but please have a look if you
have some spare cycles. The feature adjusts access to block groups but
otherwise is isolated and has to be explicitly selected so this lowers the
risks.

Otherwise there are several (read: many) proposals for smaller-sized features.
Reviews will start or continue and we'll see what we can merge.


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
  which is going to be named 'for-5.5' in my k.org tree.  Reviewed
  patches will be collected in a branch that's usually named 'misc-next'
  in my devel git repos and is part of the for-next at k.org git repo.

* merging of new patches to misc-next will be slow during the
  merge window, btrfs-progs release is planned for that period

* review other developer patches, test them, find bugs before they are in a
  released kernel
