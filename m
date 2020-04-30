Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2BA1BFC49
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 16:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgD3OEv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 10:04:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:35248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbgD3OEu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 10:04:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3FED1AC91;
        Thu, 30 Apr 2020 14:04:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8D01DDA728; Thu, 30 Apr 2020 16:04:01 +0200 (CEST)
Date:   Thu, 30 Apr 2020 16:04:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Goffredo Baroncelli <kreijack@libero.it>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH v3] btrfs-progs: add warning for mixed profiles filesystem
Message-ID: <20200430140401.GN18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Goffredo Baroncelli <kreijack@libero.it>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>
References: <20200404103212.40986-1-kreijack@libero.it>
 <SN4PR0401MB35985F2338F0F46A279ED5D59BAA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35985F2338F0F46A279ED5D59BAA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 01:37:39PM +0000, Johannes Thumshirn wrote:
> On 04/04/2020 12:32, Goffredo Baroncelli wrote:
> > 
> > Hi all,
> > 
> > the aim of this patch set is to issue a warning when a mixed profiles
> > filesystem is detected. This happens when the filesystems contains
> > (i.e.) raid1c3 and single chunk for data.
> > 
> > BTRFS has the capability to support a filesystem with mixed profiles.
> > However this could lead to an unexpected behavior when a new chunk is
> > allocated (i.e. the chunk profile is not what is wanted). Moreover
> > if the user is not aware of this, he could assume a redundancy which
> > doesn't exist (for example because there is some 'single' chunk when
> > it is expected the filesystem to be full raid1).
> > A possible cause of a mixed profiles filesystem is an interrupted
> > balance operation or a not fully balance due to very specific filter.
> > 
> > The check is added to the following btrfs commands:
> > - btrfs balance pause
> > - btrfs balance cancel
> > - btrfs device add
> > - btrfs device del
> > 
> > The warning is shorter than the before one. Below an example and
> > it is printed after the normal output of the command.
> > 
> >     WARNING: Multiple profiles detected.  See 'man btrfs(5)'.
> >     WARNING: data -> [raid1c3, single], metadata -> [raid1, single]
> > 
> > The command "btrfs fi us" doesn't show the warning above, instead
> > it was added a further line in the "Overall" section. The output now
> > is this:
> > 
> > $ sudo ./btrfs fi us /tmp/t/
> > [sudo] password for ghigo:
> > Overall:
> >      Device size:		  30.00GiB
> >      Device allocated:		   4.78GiB
> >      Device unallocated:		  25.22GiB
> >      Device missing:		     0.00B
> >      Used:			   1.95GiB
> >      Free (estimated):		  13.87GiB	(min: 9.67GiB)
> >      Data ratio:			      2.00
> >      Metadata ratio:		      1.50
> >      Global reserve:		   3.25MiB	(used: 0.00B)
> >      Multiple profile:		       YES
> > 
> > Data,single: Size:1.00GiB, Used:974.04MiB (95.12%)
> >     /dev/loop0	   1.00GiB
> > 
> > Data,RAID1C3: Size:1.00GiB, Used:178.59MiB (17.44%)
> >     /dev/loop0	   1.00GiB
> >     /dev/loop1	   1.00GiB
> >     /dev/loop2	   1.00GiB
> > 
> > Metadata,single: Size:256.00MiB, Used:76.22MiB (29.77%)
> >     /dev/loop1	 256.00MiB
> > 
> > Metadata,RAID1: Size:256.00MiB, Used:206.92MiB (80.83%)
> >     /dev/loop1	 256.00MiB
> >     /dev/loop2	 256.00MiB
> > 
> > System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
> >     /dev/loop2	  32.00MiB
> > 
> > Unallocated:
> >     /dev/loop0	   8.00GiB
> >     /dev/loop1	   8.50GiB
> >     /dev/loop2	   8.72GiB
> > 
> > 
> > In this case there are two kind of chunks for data (raid1c3 and single)
> > and metadata (raid1, single).
> > 
> > As the previous patch set, the warning is added also to the command
> > 'btrfs fi df' and 'btrfs dev us' as separate patch. If even in this
> > review nobody likes it, we can simply drop this patch.
> > 
> > Suggestion about which commands should (not) have this check are
> > welcome.
> > 
> > v1
> > - first issue
> > v2
> > - add some needed missing pieces about raid1c[34]
> > - add the check to more btrfs commands
> > v3
> > - add a section in btrfs(5) 'FILESYSTEM WITH MULTIPLE PROFILES'
> > - 'btrfs fi us': changed the worning in a info in the 'overall' section
> > 
> > Patch #1 contains the code for the check.
> > Patch #3 adds the check to the command 'btrfs dev {add,del}' and 'btrfs
> > bal {pause, stop}'
> > Patch #3 adds the check to the command 'btrfs fi us'
> > Patch #5 add the check to the command 'btrfs fi df' and 'btrfs dev us'
> > Patch #5 add the info in btrfs(5) man page
> 
> Btw with this patchset applied fstests choke on some tests (e.g. 
> btrfs/003) in my setup:
> 
> btrfs/003       - output mismatch (see 
> /home/johannes/src/xfstests-dev/results//btrfs/003.out.bad)
>      --- tests/btrfs/003.out     2020-01-02 08:43:50.000000000 +0000
>      +++ /home/johannes/src/xfstests-dev/results//btrfs/003.out.bad 
> 2020-04-30 13:20:43.050569551 +0000
>      @@ -1,2 +1,4 @@
>       QA output created by 003
>      +WARNING: Multiple profiles detected.  See 'man btrfs(5)'.
>      +WARNING:

Well, the tests need to be adjusted to filter that message out.
