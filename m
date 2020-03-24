Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6B119166B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 17:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgCXQ3O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 12:29:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:50174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgCXQ3O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 12:29:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4B37EABCF;
        Tue, 24 Mar 2020 16:29:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A6264DA732; Tue, 24 Mar 2020 17:28:41 +0100 (CET)
Date:   Tue, 24 Mar 2020 17:28:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check/lowmem: Fix a false alert caused by
 hole beyond isize check
Message-ID: <20200324162841.GQ12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200321010303.124708-1-wqu@suse.com>
 <20200323193826.GN12659@twin.jikos.cz>
 <23f1c445-8a0d-b0b4-a557-51e602d58db7@gmx.com>
 <bc273897-6fa0-a315-0292-bc1de42939a2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc273897-6fa0-a315-0292-bc1de42939a2@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 24, 2020 at 03:07:28PM +0800, Qu Wenruo wrote:
> On 2020/3/24 上午7:15, Qu Wenruo wrote:
> > On 2020/3/24 上午3:38, David Sterba wrote:
> >> On Sat, Mar 21, 2020 at 09:03:03AM +0800, Qu Wenruo wrote:
> >>> Commit 91a12c0ddb00 ("btrfs-progs: fix lowmem check's handling of
> >>> holes") makes lowmem mode check to skip hole detection after isize.
> >>>
> >>> However it also skipped the extent end update if the extent ends just at
> >>> isize.
> >>>
> >>> This caused fsck-test/001 to fail with false hole error report.
> >>>
> >>> Fix it by updating the @end parameter if we have an extent ends at inode
> >>> size.
> >>>
> >>> Fixes: 91a12c0ddb00 ("btrfs-progs: fix lowmem check's handling of holes")
> >>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>> ---
> >>> David, please fold the fix into the original patch.
> >>
> >> Folded, thanks for the fix. The lowmem mode tests still don't pass for
> >> me, have been failing since 5.1. I've now added a make target for it so
> >> it's easier to run them without setting up the env variables.
> >>
> > 
> > Mind to provide the fsck-test-result.txt for me to further investigate
> > the problem?
> 
> My bad, I didn't catch the problem in the pull request, and my test
> environments all failed to catch the problem.
> 
> The lack of diversity makes it pretty hard to detect it, as it looks
> like all machines tends to zero the unintialized stack structure.
> 
> Anyway, the proper fix for that long existing v5.1 bug is here:
> https://patchwork.kernel.org/patch/11454395/

Thank you, that crash was probably the last big thing to do before a
release.

> And I'll look into the possibility to auto use valgrind in selftests to
> avoid similar bug to sneak in.

As you've found out, the valgrind or other instrumentation is there but
there are some problems. For that the GCCs sanitizers are more
lightweight option, but they make the test pass.
