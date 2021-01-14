Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457D32F6A01
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 19:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbhANSw3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 13:52:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:42400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbhANSw3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 13:52:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E16CB1C4;
        Thu, 14 Jan 2021 18:51:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 159B1DA7EE; Thu, 14 Jan 2021 19:49:55 +0100 (CET)
Date:   Thu, 14 Jan 2021 19:49:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs2@lesimple.fr>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check: allow force v1 space cache cleanup
 even the fs has v2 space cache enabled
Message-ID: <20210114184954.GE6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs2@lesimple.fr>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201229003035.13329-1-wqu@suse.com>
 <e471c466476658fd6c40cdaf71748d52@lesimple.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e471c466476658fd6c40cdaf71748d52@lesimple.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 29, 2020 at 09:34:51AM +0000, Stéphane Lesimple wrote:
> December 29, 2020 1:32 AM, "Qu Wenruo" <wqu@suse.com> wrote:
> 
> > There are cases where v1 free space cache is still left while user has
> > already enabled v2 cache.
> > 
> > In that case, we still want to force v1 space cache cleanup in
> > btrfs-check.
> > 
> > This patch will remove the v2 check if we're cleaning up v1 cache,
> > allowing us to cleanup the leftover.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> > check/main.c | 6 ------
> > 1 file changed, 6 deletions(-)
> > 
> > diff --git a/check/main.c b/check/main.c
> > index 8ad7f5886f06..f4755d260bfe 100644
> > --- a/check/main.c
> > +++ b/check/main.c
> > @@ -9917,12 +9917,6 @@ static int do_clear_free_space_cache(int clear_version)
> > int ret = 0;
> > 
> > if (clear_version == 1) {
> > - if (btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE)) {
> > - error(
> > - "free space cache v2 detected, use --clear-space-cache v2");
> > - ret = 1;
> > - goto close_out;
> > - }
> > ret = clear_free_space_cache();
> > if (ret) {
> > error("failed to clear free space cache");
> > -- 
> > 2.29.2
> 
> 
> Maybe we should keep the message but make it not fatal?
> Something like "free space cache v2 detected, use --clear-space-cache
> v2 to clear it. Proceeding in clearing potential v1 leftovers as
> asked..."?

This sounds like a good option, thanks. I'll update the patch when I
commit it.
