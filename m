Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B407333F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 17:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfGXP7z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 11:59:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:34166 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfGXP7z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 11:59:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C642B128
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2019 15:59:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2166DDA808; Wed, 24 Jul 2019 18:00:30 +0200 (CEST)
Date:   Wed, 24 Jul 2019 18:00:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     WenRuo Qu <wqu@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/5] btrfs: extent_io: Do extra check for extent buffer
 read write functions
Message-ID: <20190724160029.GQ2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, WenRuo Qu <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190710080243.15988-1-wqu@suse.com>
 <20190710080243.15988-2-wqu@suse.com>
 <0c6525ff-63f5-6342-4c6c-2e229d0e98b2@suse.com>
 <47b88874-6cef-4eb2-74d8-5a1f51efa99d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47b88874-6cef-4eb2-74d8-5a1f51efa99d@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 10, 2019 at 10:58:40AM +0000, WenRuo Qu wrote:
> 
> 
> On 2019/7/10 下午6:42, Nikolay Borisov wrote:
> > 
> > 
> [...]
> >>  
> >> +/*
> >> + * Check if the [start, start + len) range is valid before reading/writing
> >> + * the eb.
> >> + *
> >> + * Caller should not touch the dst/src memory if this function returns error.
> >> + */
> >> +static int check_eb_range(const struct extent_buffer *eb, unsigned long start,
> >> +			  unsigned long len)
> >> +{
> >> +	unsigned long end;
> >> +
> >> +	/* start, start + len should not go beyond eb->len nor overflow */
> >> +	if (unlikely(start > eb->len || start + len > eb->len ||
> > 
> > I think your check here is wrong, it should be start + len > start +
> > eb->len. start is the logical address hence it can be a lot bigger than
> > the size of the eb which is 16k by default.
> 
> Definitely NO.
> 
> [start, start + len) must be in the range of [0, nodesize).
> So think again.

'start' is the logical address, that's always larger than eb->len (16K),
Nikolay is IMO right, the check

	start > eb->len

does not make sense, neither does 'start + len > eb->len'.

Your reference to nodesize probably means that the interval
[start, start + len] is subset of [start, start + nodesize].

The test condition in your patch must explode every time the function
is called.

> >> +		     check_add_overflow(start, len, &end))) {
> >> +		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG), KERN_ERR
> >> +"btrfs: bad eb rw request, eb bytenr=%llu len=%lu rw start=%lu len=%lu\n",
> >> +		     eb->start, eb->len, start, len);
> >> +		btrfs_warn(eb->fs_info,
> >> +"btrfs: bad eb rw request, eb bytenr=%llu len=%lu rw start=%lu len=%lu\n",
> >> +			   eb->start, eb->len, start, len);
> > 
> > If CONFIG_BTRFS_DEBUG is enabled then we will print the warning text
> > twice. Simply make  it:
> > 
> > WARN_ON(IS_ENABLED()) and leave the btrfs_Warn to always print the text.
> 
> WARN_ON() doesn't contain any text to indicate the reason of the stack dump.
> Thus I still prefer to show exact the reason other than takes developer
> several seconds to combine the stack with the following btrfs_warn()
> message.

I agree that a message next to a WARN is a good thing. Plain WARN does
not have the btrfs header (filesystem, device, ...) so we should use our
helpers and do WARN_ON(IS_ENABLED()) after that. Why after? Because with
panic-on-warn enabled the message won't be printed.

Duplicating the message or even the code does not seem like a good
practice to me.
