Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4C7301C36
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 14:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbhAXNZt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 08:25:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:45364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbhAXNZs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 08:25:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7AC9ACBA;
        Sun, 24 Jan 2021 13:25:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CDD8BDA7D7; Sun, 24 Jan 2021 14:23:20 +0100 (CET)
Date:   Sun, 24 Jan 2021 14:23:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 14/14] btrfs: Enable W=1 checks for btrfs
Message-ID: <20210124132320.GI1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20210120102526.310486-1-nborisov@suse.com>
 <20210120102526.310486-15-nborisov@suse.com>
 <7d769a82-e573-4d04-a125-13ca99136d49@toxicpanda.com>
 <16775909-3cb6-ab13-5416-6f55546b0349@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16775909-3cb6-ab13-5416-6f55546b0349@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 21, 2021 at 09:31:34AM +0200, Nikolay Borisov wrote:
> On 20.01.21 г. 17:55 ч., Josef Bacik wrote:
> > On 1/20/21 5:25 AM, Nikolay Borisov wrote:
> >> Now that the btrfs' codebase is clean of W=1 warning let's enable those
> >> checks unconditionally for the entire fs/btrfs/ and its subdirectories.
> >>
> >> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > 
> > Once this is enabled I get
> > 
> > fs/btrfs/zoned.c: In function ‘btrfs_sb_log_location_bdev’:
> > fs/btrfs/zoned.c:491:6: warning: variable ‘zone_size’ set but not used
> > [-Wunused-but-set-variable]
> >   491 |  u64 zone_size;
> >       |      ^~~~~~~~~
> > 
> > on misc-next.  Thanks,
> > 
> 
> I know, I intentionally haven't fixed it since:
> 
> a)  David might be intending to merge other patches which will utilize
> this member

That's one possibility, but would show the warning until the zoned
patches get merged. I'd rather have a clean build once the W=1 build is
on.

I can insert a patch removing the variable, the zoned patches get still
rebased so that's fixable. Let me know if you want to send the patch as
it's from your series, or I can do that too.

> b) It shows a genuine problem that this patchset has uncovered ( I even
> mentioned this in the initial cover letter)

This should have been mentioned in the v2+ cover letter as well, along
with the version-to-version changelog.
