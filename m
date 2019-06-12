Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5CE429B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbfFLOop (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 10:44:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:47896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732013AbfFLOoo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 10:44:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED210AE16;
        Wed, 12 Jun 2019 14:44:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BD53DDA8F5; Wed, 12 Jun 2019 16:45:33 +0200 (CEST)
Date:   Wed, 12 Jun 2019 16:45:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Tomasz =?utf-8?Q?K=C5=82oczko?= <kloczko.tomasz@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Linux fs Btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs progs release 5.1.1
Message-ID: <20190612144533.GN3563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Tomasz =?utf-8?Q?K=C5=82oczko?= <kloczko.tomasz@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Linux fs Btrfs <linux-btrfs@vger.kernel.org>
References: <20190611164740.14472-1-dsterba@suse.com>
 <CABB28Cx7UdEmOBOquBd8rHcCnJR4ff4AWP2P1gXnME7G0dLs4w@mail.gmail.com>
 <66406cde-c497-763a-68d6-9c21673108ac@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66406cde-c497-763a-68d6-9c21673108ac@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 12, 2019 at 10:11:31PM +0800, Qu Wenruo wrote:
> On 2019/6/12 下午9:51, Tomasz Kłoczko wrote:
> >     [TEST/fsck]   037-freespacetree-repair
> > failed: root_helper umount
> > /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
> > test failed for case 037-freespacetree-repair
> > make: *** [Makefile:352: test-fsck] Error 1
> > error: Bad exit status from /var/tmp/rpm-tmp.3DQ01g (%check)
> > 
> > In log line I found:
> > 
> > ====== RUN CHECK root_helper mount -t btrfs -o loop
> > /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
> > /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//mnt
> > ====== RUN CHECK root_helper fallocate -l 50m
> > /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//mnt/file
> > ====== RUN CHECK root_helper umount
> > /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
> > umount: /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests/mnt:
> > target is busy.
> > failed: root_helper umount
> > /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
> > 
> > After test suite fails I'm able to umount it manually.
> > 
> > [tkloczko@domek tests]$ sudo umount
> > /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
> > [tkloczko@domek tests]$
> > 
> > So looks like during umount still something is holding umount.
> 
> Similar situation here, but if you're using DE or things like udisk,
> it's mostly such tools affecting the umount.
> 
> For me, inside a minimal VM, without all the GUI things listening on
> mounted locations, 037 will pass without problem.

I'm running the tests on my desktop with a DE and the test passes every
time.

Tomas, can you please run the tests with the following diff:

--- a/tests/common
+++ b/tests/common
@@ -512,7 +512,10 @@ run_check_umount_test_dev()
        if [ "$#" = 0 ]; then
                set -- "$TEST_DEV"
        fi
-       run_check $SUDO_HELPER umount "$@"
+       if ! run_mayfail $SUDO_HELPER umount "$@"; then
+               run_check $SUDO_HELPER lsof "$TEST_MNT"
+               _fail "umount on $TEST_MNT failed"
+       fi
 }
 
---

This should dump all potential holders of the mount path when the umount
fails. I've tested here by cd'ing into the mount directory right after
the test starts and get something like this in the results:

  ====== RUN CHECK root_helper fallocate -l 4k .../btrfs-progs/tests//mnt/file.2779
  ====== RUN CHECK root_helper fallocate -l 4k .../btrfs-progs/tests//mnt/file.2319
  ====== RUN MAYFAIL root_helper umount .../btrfs-progs/tests//test.img
  umount: .../btrfs-progs/tests/mnt: target is busy.
  failed (ignored, ret=32): root_helper umount .../btrfs-progs/tests//test.img
  ====== RUN CHECK root_helper lsof .../btrfs-progs/tests//mnt
  bash    7777 dsterba  cwd    DIR   0,68    51840  256 .../btrfs-progs/tests//mnt
  umount on .../btrfs-progs/tests//mnt failed
  test failed for case 037-freespacetree-repair

As a workaround, a short delay, sync and repeated umount can be done in
the umount helper so the test is more reliable, but first I'd like to
know what's causing the problems.
