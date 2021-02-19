Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B8E31FF84
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 20:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBSTlL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 14:41:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:49650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhBSTlK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 14:41:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6376FABAE;
        Fri, 19 Feb 2021 19:40:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E3A48DA783; Fri, 19 Feb 2021 20:38:30 +0100 (CET)
Date:   Fri, 19 Feb 2021 20:38:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs progs release 5.10.1
Message-ID: <20210219193830.GL1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210205112506.4274-1-dsterba@suse.com>
 <CAL3q7H58PJk3Fyq4b7WTWGrzVmz5zATDDTCKO3SPS0EF=x0k4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H58PJk3Fyq4b7WTWGrzVmz5zATDDTCKO3SPS0EF=x0k4g@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 16, 2021 at 11:00:18AM +0000, Filipe Manana wrote:
> On Fri, Feb 5, 2021 at 11:33 AM David Sterba <dsterba@suse.com> wrote:
> >
> > Hi,
> >
> > btrfs-progs version 5.10.1 have been released.
> >
> > The static build got broken due to libmount added in 5.10, this works now. The
> > minimum libmount version is 2.24 that is not available on some LTS distros like
> > CentOS 7. The plan is to bring the support back, reimplementing some libmount
> > functionality and dropping the dependency again.
> >
> > Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
> > Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
> >
> > Shortlog:
> >
> > David Sterba (6):
> >       btrfs-progs: build: fix linking with static libmount
> 
> Btw, this causes two fstests to fail:
> 
> $ ./check btrfs/100 btrfs/101
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian8 5.11.0-rc6-btrfs-next-80 #1 SMP
> PREEMPT Wed Feb 3 11:28:05 WET 2021
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/100 6s ... [failed, exit status 1]- output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/100.out.bad)
>     --- tests/btrfs/100.out 2020-06-10 19:29:03.818519162 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/100.out.bad
> 2021-02-16 10:55:53.145343890 +0000
>     @@ -2,10 +2,7 @@
>      Label: none  uuid: <UUID>
>       Total devices <NUM> FS bytes used <SIZE>
>       devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>     - devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
>     + devid <DEVID> size <SIZE> used <SIZE> path dm-0
> 
>     -Label: none  uuid: <UUID>
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/100.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/100.out.bad'  to see
> the entire diff)
> btrfs/101 8s ... [failed, exit status 1]- output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/101.out.bad)
>     --- tests/btrfs/101.out 2020-06-10 19:29:03.818519162 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/101.out.bad
> 2021-02-16 10:55:58.105503554 +0000
>     @@ -2,10 +2,7 @@
>      Label: none  uuid: <UUID>
>       Total devices <NUM> FS bytes used <SIZE>
>       devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>     - devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
>     + devid <DEVID> size <SIZE> used <SIZE> path dm-0
> 
>     -Label: none  uuid: <UUID>
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/101.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/101.out.bad'  to see
> the entire diff)
> Ran: btrfs/100 btrfs/101
> Failures: btrfs/100 btrfs/101
> Failed 2 of 2 tests
> 
> 
> Is there any plan to fix this?

Yes, it's fixed in devel, the path canonicalization got accidentally
broken by my libmount workarounds.
