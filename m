Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F530AB81
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 16:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhBAPex (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 10:34:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:33226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231499AbhBAPeq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 10:34:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0520AE7A;
        Mon,  1 Feb 2021 15:34:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 57943DA6FC; Mon,  1 Feb 2021 16:32:15 +0100 (CET)
Date:   Mon, 1 Feb 2021 16:32:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v5 06/18] btrfs: support subpage for extent buffer page
 release
Message-ID: <20210201153215.GP1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-7-wqu@suse.com>
 <8522b133-9bdf-c130-1a3c-15114755c47a@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8522b133-9bdf-c130-1a3c-15114755c47a@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 11:21:08AM -0500, Josef Bacik wrote:
> On 1/26/21 3:33 AM, Qu Wenruo wrote:
> > --- a/fs/btrfs/subpage.h
> > +++ b/fs/btrfs/subpage.h
> > @@ -4,6 +4,7 @@
> >   #define BTRFS_SUBPAGE_H
> >   
> >   #include <linux/spinlock.h>
> > +#include <linux/refcount.h>
> 
> I made this comment elsewhere, but the patch finally showed up in my email after 
> I refreshed (???? thunderbird wtf??).  Anyway you import refcount.h here, but 
> don't actually use refcount_t.  Please use refcount_t, so we get the benefit of 
> the debugging from the helpers.  Thanks,

Switching to refcount looks a bit complicated so for now let's use
atomics, it's affecting only the subpage case.
