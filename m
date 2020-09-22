Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5D274477
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgIVOlH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 10:41:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:48658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgIVOlG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 10:41:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5063ACC2;
        Tue, 22 Sep 2020 14:41:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AD317DA6E9; Tue, 22 Sep 2020 16:39:49 +0200 (CEST)
Date:   Tue, 22 Sep 2020 16:39:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Filipe Manana <fdmanana@suse.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org
Subject: Re: [PATCH] btrfs: fix memdup.cocci warnings
Message-ID: <20200922143949.GB6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Filipe Manana <fdmanana@suse.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org
References: <alpine.DEB.2.22.394.2009221219560.2659@hadrien>
 <CAL3q7H6e7gQWs9X-N4RMxK+UhZKHGxNmP0-q+B6x19uyH9TOwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6e7gQWs9X-N4RMxK+UhZKHGxNmP0-q+B6x19uyH9TOwA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 22, 2020 at 03:05:59PM +0100, Filipe Manana wrote:
> On Tue, Sep 22, 2020 at 11:29 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > From: kernel test robot <lkp@intel.com>
> >
> > fs/btrfs/send.c:3854:8-15: WARNING opportunity for kmemdup
> >
> >  Use kmemdup rather than duplicating its implementation
> >
> > Generated by: scripts/coccinelle/api/memdup.cocci
> >
> > Fixes: 28314eb24e6c ("btrfs: send, recompute reference path after orphanization of a directory")
> > Signed-off-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
> 
> Since this is not in Linus' tree yet, it can be folded in the original patch.
> David, can you do that when you pick it?

Yes, I'll do that.

> Btw, isn't the Fixes tag meant only for bug fixes? This is a pure
> cleanup afaics.

Agreed.
