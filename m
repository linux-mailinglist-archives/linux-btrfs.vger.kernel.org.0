Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6127EF27
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 18:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbgI3Q1t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 12:27:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:57334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI3Q1r (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 12:27:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12D34AC8C;
        Wed, 30 Sep 2020 16:27:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 243E5DA781; Wed, 30 Sep 2020 18:26:26 +0200 (CEST)
Date:   Wed, 30 Sep 2020 18:26:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs-progs: subvolume: Add warning on deleting default
 subvolume
Message-ID: <20200930162625.GN6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
References: <20200928150729.2239-1-realwakka@gmail.com>
 <blhogiac.fsf@damenly.su>
 <20200924124513.GA23361@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924124513.GA23361@realwakka>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 24, 2020 at 12:45:13PM +0000, Sidong Yang wrote:
> On Wed, Sep 30, 2020 at 09:33:31AM +0800, Su Yue wrote:
> > On Mon 28 Sep 2020 at 23:07, Sidong Yang <realwakka@gmail.com> wrote:
> > > +	err = btrfs_util_get_default_subvolume_fd(fd, &default_subvol_id);
> > > +	if (fd < 0) {
> > > 
> > Should it be
> > "     if (err) { |
> >         error_btrfs_util(err);
> >         ...
> > "?
> 
> Hi Su! Thanks for review!
> 
> Yeah, I think it's definitely wrong. My mistake.
> 
> > > +		err = btrfs_util_subvolume_id(path, &target_subvol_id);
> > > +		if (fd < 0) {
> > > 
> > And here.
> > 
> 
> It's wrong too.
> 
> Dave, maybe this patch needs for Su's review.
> Usually in this case, Could you fix it directly ?
> or do I need to send a new patch?

Yes I'll fix it in the commit, no need to resend.
