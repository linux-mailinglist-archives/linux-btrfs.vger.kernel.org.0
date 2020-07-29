Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4662322A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 18:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgG2Q06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 12:26:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:57846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgG2Q06 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 12:26:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5E3DAD93
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 16:27:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EAF95DA882; Wed, 29 Jul 2020 18:26:27 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
Subject: Next btrfs development cycle - 5.10
Date:   Wed, 29 Jul 2020 18:26:27 +0200
Message-Id: <20200729162627.30743-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.cz>

Hi,

a belated friendly reminder of the timetable and what's expected at this phase.

5.7 - current
5.8 - upcoming, urgent regression fixes only
5.9 - development closed, pull request in prep, fixes or regressions only
5.10 - development open, until 5.9-rc5 (at least)

(https://btrfs.wiki.kernel.org/index.php/Developer%27s_FAQ#Development_schedule)


Current status
--------------

The pull request branch has been forked off misc-next, it's named misc-5.9.
Merge window most likely opens on Monday and I'm going to send early pull
request on Friday.

Hilights:

- mount option updates
- performance improvements (parallel fsync)
- balance interruptible by ctrl-c
- more information exported in sysfs (qgroups, bdi)

Lots of cleanups and fixes otherwise.


Merge outlook
-------------

First look back, 5.9 queue does not have any big core changes, rather lots of
cleanups, small enhancements and stabilization. The mirror balancing or chunk
dump ioctl have not made much progress, so that's for another cycle. I should
rather not make any predictions.

From now on only selected fixes will be merged to 5.9 queue. In 5.10 we'll do
the reworked ticket reservations for data, the reviews came too close to the
freeze.  The dio-iomap will probably be merged too as the wider iomap updates
are about to be merged. Otherwise, there are several RFC patches or older
patchsets, we'll see what will be in mergeable state.


Git development repos
---------------------

  k.org: https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
  devel1: https://gitlab.com/kdave/btrfs-devel
  devel2: https://github.com/kdave/btrfs-devel
