Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764D4ADBC3
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 17:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfIIPHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 11:07:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:34804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfIIPHh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 11:07:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A442AEEE
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Sep 2019 15:07:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 76067DA943; Mon,  9 Sep 2019 17:07:59 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
Subject: Next btrfs development cycle open - 5.5
Date:   Mon,  9 Sep 2019 17:07:57 +0200
Message-Id: <20190909150757.5713-1-dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.cz>

Hi,

a friendly reminder of the timetable and what's expected at this phase.

5.2 - current
5.3 - upcoming, urgent regression fixes only
5.4 - development closed, pull request in prep, fixes or regressions only
5.5 - development open, until 5.4-rc5 (at least)

(https://btrfs.wiki.kernel.org/index.php/Developer%27s_FAQ#Development_schedule)


Current status
--------------

Branch misc-5.4 has been forked off misc-next (based on 5.3-rc8) and contains
the first pull request changes.  I'm going to send an early pull request
before the merge window starts, due to travelling.

There are some fstest failures or things worth closer look, now is the time.


Hilights of 5.4 changes
------------------------

The space handling has been reworked, getting rid of some corner case behaviour
and improving the logic to address it from higher level (that's my interpretation).

Tree checker has learned some new tricks (inode item checks).

Again there are many cleanups and refactoring.


Pending features
----------------

There are several patchsets implementing new features. Please note that the
reviewer bandwidth stays mostly constant, not much chance to make things
faster.

The patchsets reworking the core things get a slight preference over features
as they can be verified by functional testing and do not impact user
interfaces.


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
  which is going to be named 'for-5.4' in my k.org tree.  Reviewed
  patches will be collected in a branch that's usually named 'misc-next'
  in my devel git repos and is part of the for-next at k.org git repo.

* merging of new patches to misc-next will be slow during the
  merge window

* review other developer patches, test them, find bugs before they are in a
  released kernel
