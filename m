Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F346BF37
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfGQPhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 11:37:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:45224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfGQPhP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 11:37:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C562AFCE;
        Wed, 17 Jul 2019 15:36:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CD386DA8E1; Wed, 17 Jul 2019 17:37:06 +0200 (CEST)
Date:   Wed, 17 Jul 2019 17:37:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] uuid: Add inline helpers to operate on raw buffers
Message-ID: <20190717153706.GJ20977@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>, linux-btrfs@vger.kernel.org
References: <20190716150418.84018-1-andriy.shevchenko@linux.intel.com>
 <20190716151133.GA6073@lst.de>
 <20190716152222.GJ9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716152222.GJ9224@smile.fi.intel.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 16, 2019 at 06:22:22PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 16, 2019 at 05:11:33PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 16, 2019 at 06:04:16PM +0300, Andy Shevchenko wrote:
> > > +static inline void guid_copy_from_raw(guid_t *dst, const __u8 *src)
> > > +{
> > > +	memcpy(dst, (const guid_t *)src, sizeof(guid_t));
> > > +}
> > > +
> > > +static inline void guid_copy_to_raw(__u8 *dst, const guid_t *src)
> > > +{
> > > +	memcpy((guid_t *)dst, src, sizeof(guid_t));
> > > +}
> > 
> > Maybe import_guid/export_guid is a better name?
> 
> Yes, sounds good to me.
> 
> > Either way, I don't think we need the casts, and they probably want
> > kerneldoc comments describing their use.
> > 
> > Same for the uuid side.
> 
> Got it.
> 
> > > +static inline void guid_gen_raw(__u8 *guid)
> > > +{
> > > +	guid_gen((guid_t *)guid);
> > > +}
> > > +
> > > +static inline void uuid_gen_raw(__u8 *uuid)
> > > +{
> > > +	uuid_gen((uuid_t *)uuid);
> > > +}
> > 
> > I hate this raw naming.  If people really want to use the generators on
> > u8 fields a cast seems more descriptive then hiding it.
> 
> This entire patch because of BTRFS maintainers, they didn't want the explicit
> casts. Maybe something has been changed, I dunno.

No change on our side. The uuids are u8 in the on-disk structures, that
will stay. The uuid functions use a different type so the casts have to
be added, that's clear. The question is if it's up to the API to provide
functions that take u8, or btrfs code to put typecasts everywhere or
carry own wrappers that do that.

I tend to avoid the explicit typecasts for widely used functions because
it's easy to forget them, and it overrides the type checks (that could
be caught by compiler but also not).

Specifically for uuid, the endianness might matter, so that we use the
raw buffers makes things more explicit.
