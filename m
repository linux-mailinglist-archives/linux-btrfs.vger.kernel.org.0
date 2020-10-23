Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D09E297587
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbgJWRIV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 13:08:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:39200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S375829AbgJWRIV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 13:08:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D15C0AB95;
        Fri, 23 Oct 2020 17:08:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EE9E9DA7F1; Fri, 23 Oct 2020 19:06:47 +0200 (CEST)
Date:   Fri, 23 Oct 2020 19:06:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: Use helpers to convert from seconds to
 jiffies in transaction_kthread
Message-ID: <20201023170647.GN6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20201008122430.93433-1-nborisov@suse.com>
 <20201008122430.93433-2-nborisov@suse.com>
 <50566dfc-0bcd-9a71-8e53-4aac42561489@toxicpanda.com>
 <4d6a4f4e-3f70-a984-f4b3-dfcd5731620c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d6a4f4e-3f70-a984-f4b3-dfcd5731620c@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 06:03:00PM +0300, Nikolay Borisov wrote:
> 
> 
> On 21.10.20 г. 17:51 ч., Josef Bacik wrote:
> > On 10/8/20 8:24 AM, Nikolay Borisov wrote:
> >> The kernel provides easy to understand helpers to convert from human
> >> understandable units to the kernel-friendly 'jiffies'. So let's use
> >> those to make the code easier to understand. No functional changes.
> >>
> >> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> >> ---
> >>   fs/btrfs/disk-io.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> >> index 764001609a15..77b52b724733 100644
> >> --- a/fs/btrfs/disk-io.c
> >> +++ b/fs/btrfs/disk-io.c
> >> @@ -1721,7 +1721,7 @@ static int transaction_kthread(void *arg)
> >>         do {
> >>           cannot_commit = false;
> >> -        delay = HZ * fs_info->commit_interval;
> >> +        delay = msecs_to_jiffies(fs_info->commit_interval * 1000);
> > 
> > Since we're now doing everything in msecs, why don't we just make sure
> > ->commit_interval is set to msecs, that way we don't have to carry
> > around the * 1000?  If we still need the multiplication we should be
> > using MSEC_PER_SEC.  Thanks,
> 
> Yes, as a matter of fact I intend on making commit_interval into
> jiffies, to completely eliminate the msecs_to_jiffies helpers here.
> 
> But that will be a follow on work once David merges the v2 of "Be
> smarter" patch.

As the commit_interval is an internal value, jiffies is ok, the
conversions happen happen for mount option set and print only. So ok
from me.
