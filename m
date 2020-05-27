Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48F01E4D80
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 20:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgE0S4A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 14:56:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:55836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgE0Sz7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 14:55:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0E2FCAC5B;
        Wed, 27 May 2020 18:41:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5A6D2DA72D; Wed, 27 May 2020 20:40:47 +0200 (CEST)
Date:   Wed, 27 May 2020 20:40:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] Btrfs: fix wrong file range cleanup after an error
 filling dealloc range
Message-ID: <20200527184046.GK18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200527101553.25396-1-fdmanana@kernel.org>
 <20200527150159.GJ18421@twin.jikos.cz>
 <CAL3q7H4LZcnVZnzN3mExTq2r5gyMkHjm_qH0nvPkSPb12yNeUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4LZcnVZnzN3mExTq2r5gyMkHjm_qH0nvPkSPb12yNeUw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 27, 2020 at 05:31:48PM +0100, Filipe Manana wrote:
> On Wed, May 27, 2020 at 4:02 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Wed, May 27, 2020 at 11:15:53AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > If an error happens while running dellaloc in COW mode for a range, we can
> > > end up calling extent_clear_unlock_delalloc() for a range that goes beyond
> > > our range's end offset by 1 byte, which affects 1 extra page. This results
> > > in clearing bits and doing page operations (such as a page unlock) outside
> > > our target range.
> > >
> > > Fix that by calling extent_clear_unlock_delalloc() with an inclusive end
> > > offset, instead of an exclusive end offset, at cow_file_range().
> > >
> > > Fixes: a315e68f6e8b30 ("Btrfs: fix invalid attempt to free reserved space on failure to cow range")
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > 1-3 added to misc-next, thanks.
> 
> So I noticed earlier that in patch 3/3, I mention "generic/061"
> instead of "btrfs/061". Would you mind amending the changelog with
> just that?

Changelog updated, thanks.
