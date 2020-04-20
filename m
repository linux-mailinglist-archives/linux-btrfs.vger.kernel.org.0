Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A41B19F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 01:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDTXKQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 19:10:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:59534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDTXKQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 19:10:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0F2E1AE2A;
        Mon, 20 Apr 2020 23:10:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8AB3EDA72D; Tue, 21 Apr 2020 01:09:32 +0200 (CEST)
Date:   Tue, 21 Apr 2020 01:09:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] btrfs-progs: tests: Filter output for
 run_check_stdout
Message-ID: <20200420230932.GK18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200407071845.29428-1-wqu@suse.com>
 <20200407071845.29428-2-wqu@suse.com>
 <20200409155204.GD5920@twin.jikos.cz>
 <4b74897a-ea6a-9e9f-e735-a990acf2c9cc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b74897a-ea6a-9e9f-e735-a990acf2c9cc@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 10, 2020 at 08:25:28AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/4/9 下午11:52, David Sterba wrote:
> > On Tue, Apr 07, 2020 at 03:18:44PM +0800, Qu Wenruo wrote:
> >> Since run_check_stdout() can insert INSTRUMENT for all btrfs related
> >> programs, which could easily pollute the stdout, any caller of
> >> run_check_stdout() should do proper filter.
> >>
> >> The following callers are affected:
> >> - misc/004
> >>   Filter the output of "btrfs ins min-dev-size"
> >>
> >> - misc/009
> >> - misc/013
> >> - misc/024
> >>   They are all calling "btrfs ins rootid", so introduce get_subvolid()
> >>   function to grab the subvolid properly.
> >>
> >> - misc/031
> >>   Loose the filter for "btrfs qgroup show". No need for "tail -n 1".
> >>
> >> So we still have the same coverage, but now these tests won't cause
> >> false alert if we insert INSTRUMENT for all btrfs commands.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>  tests/common                                  | 13 ++++++++++++
> >>  tests/misc-tests/004-shrink-fs/test.sh        | 11 ++++++++--
> >>  .../009-subvolume-sync-must-wait/test.sh      |  2 +-
> >>  .../013-subvolume-sync-crash/test.sh          |  2 +-
> >>  .../024-inspect-internal-rootid/test.sh       | 21 +++++++------------
> >>  .../031-qgroup-parent-child-relation/test.sh  |  4 ++--
> >>  6 files changed, 33 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/tests/common b/tests/common
> >> index 71661e950db0..f8fc3cfd8b4f 100644
> >> --- a/tests/common
> >> +++ b/tests/common
> >> @@ -169,6 +169,9 @@ run_check()
> >>  
> >>  # same as run_check but the stderr+stdout output is duplicated on stdout and
> >>  # can be processed further
> >> +#
> >> +# NOTE: If this function is called on btrfs related command, caller should
> >> +#	filter the output, as INSTRUMENT can easily pollute the output.
> >>  run_check_stdout()
> >>  {
> >>  	local spec
> >> @@ -636,6 +639,16 @@ check_min_kernel_version()
> >>  	return 0
> >>  }
> >>  
> >> +# Get subvolume id for specified path
> >> +get_subvolid()
> >> +{
> >> +	# run_check_stdout may have INSTRUMENT pollating the output,
> >> +	# need to filter the output.
> >> +	run_check_stdout "$TOP/btrfs" inspect-internal rootid "$1" | \
> >> +		grep -e "^[[:digit:]]\+$"
> > 
> > This does not seem much better, now it's specific to the commands and
> > calling the commands directly in new tests will make it fail.
> > 
> > If we find another command where the extra output must be filtered,
> > another helper. The instrument-tool specific filtering is IMHO fixed in
> > one place and future proof.
> 
> I get your point and concern, and kinda support your point.
> 
> > 
> > I want to avoid adding yet another test coding style exception like "for
> > inspect-internal you must use this helper", we have already enough like
> > new tests not using the mount/umount helpers or opencoding other
> > existing helpers.
> 
> However the problem only happens for command with one line output.
> Like the min-dev-size and rootid of inspect group.
> 
> All other common tools will need filtering anyway, like qgroup show or
> dump-tree.
> 
> So just several exception would still be acceptable.
> > 
> > My idea is to let people write tests in a natural way and adapt the
> > instrumentation tools as we know what problems they could cause.
> > 
> I used to support valgrind specific options to solve the problem, until
> knowing you're using a simple wrapper to test.
> 
> Yes, we're only using valgrind anyway, but I'm not so sure for other
> guys, maybe one day some new tool developer would use their own fancy
> tool to check btrfs-progs.
> 
> And if they find that we're using valgrind specific option just to make
> all tests pass, and their tool fails due to that reason, they may just
> exclude btrfs-progs and express their disappointment against btrfs.
> 
> Considering the exception is really not that many, the trade at least
> looks good enough to me.

Ok, I understand, let's do it your way.
