Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC17FDB5B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 11:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKOK22 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 05:28:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:37998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbfKOK22 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 05:28:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B723AB271;
        Fri, 15 Nov 2019 10:28:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 91B7FDA783; Fri, 15 Nov 2019 11:28:29 +0100 (CET)
Date:   Fri, 15 Nov 2019 11:28:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] RAID1 with 3- and 4- copies
Message-ID: <20191115102829.GP3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Neal Gompa <ngompa13@gmail.com>, David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cover.1572534591.git.dsterba@suse.com>
 <CAEg-Je_oNz5BtpRAF3fzfX1G-Dhh7yjpshyy47NwLaREWv0wBQ@mail.gmail.com>
 <20191101150908.GU3001@twin.jikos.cz>
 <20191114051324.GZ22121@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114051324.GZ22121@hungrycats.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 14, 2019 at 12:13:24AM -0500, Zygo Blaxell wrote:
> On Fri, Nov 01, 2019 at 04:09:08PM +0100, David Sterba wrote:
> > The raid1c34 patches are not intrusive and could be backported on top of
> > 5.3 because all the preparatory work has been merged already.
> 
> Indeed, that's how I ended up testing them.  I couldn't get the 5.4-rc
> kernels to run long enough to do meaningful testing before they locked
> up.  I tested with 5.3.8 + patches.
> 
> I left out the last patch that removes the raid1c3 incompat flag because
> 5.3 didn't have the block group tree code to apply it to.
> 
> I ran my raid1 and raid56 corruption recovery tests modified for raid1c3.
> The first test is roughly:
> 
> 	mkfs.btrfs -draid1c3 -mraid1c3 /dev/vd[bcdef]
> 	mount /dev/vdb /test
> 	cp -a 9GB_data /test
> 	sync
> 	sysctl vm.drop_caches=3
> 	diff -r 9GB_data /test
> 	head -c 9g /dev/urandom > /dev/vdb
> 	head -c 9g /dev/urandom > /dev/vdc
> 	sync
> 	sysctl vm.drop_caches=3
> 	diff -r 9GB_data /test
> 	btrfs scrub start -Bd /test
> 	sysctl vm.drop_caches=3
> 	diff -r 9GB_data /test
> 	btrfs scrub start -Bd /test
> 	sysctl vm.drop_caches=3
> 	diff -r 9GB_data /test
> 
> First scrub reported a lot of corruption on /dev/vdb and /dev/vdc.  Second
> scrub reported no errors.  diff (all instances) reported no differences.
> 
> Second test is:
> 
> 	mkfs.btrfs -draid6 -mraid1c3 /dev/vd[bcdef]
> 	# rest as above...
> 
> Similar results:  first scrub reported many errors as expected.
> Second scrub reported no errors.  No diffs.

Thanks for the tests.
