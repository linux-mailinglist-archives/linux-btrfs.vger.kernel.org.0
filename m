Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B2A24C0DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 16:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHTOr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 10:47:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:37018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgHTOrz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 10:47:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26E4AAC6E;
        Thu, 20 Aug 2020 14:48:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1EAAEDA87C; Thu, 20 Aug 2020 16:46:48 +0200 (CEST)
Date:   Thu, 20 Aug 2020 16:46:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v5 1/4] btrfs: extent_io: do extra check for extent
 buffer read write functions
Message-ID: <20200820144647.GY2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200819063550.62832-1-wqu@suse.com>
 <20200819063550.62832-2-wqu@suse.com>
 <20200819171159.GT2026@twin.jikos.cz>
 <66f629fa-e636-6ab5-eda8-5299d996b2f4@suse.com>
 <20200820095024.GX2026@twin.jikos.cz>
 <1507884d-ad39-8edf-03fd-42e1d10f50e1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1507884d-ad39-8edf-03fd-42e1d10f50e1@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 20, 2020 at 05:58:53PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/8/20 下午5:50, David Sterba wrote:
> > On Thu, Aug 20, 2020 at 07:14:13AM +0800, Qu Wenruo wrote:
> >>>> +static inline int check_eb_range(const struct extent_buffer *eb,
> >>>> +				 unsigned long start, unsigned long len)
> >>>> +{
> >>>> +	/* start, start + len should not go beyond eb->len nor overflow */
> >>>> +	if (unlikely(start > eb->len || start + len > eb->len ||
> >>>> +		     len > eb->len)) {
> >>>
> >>> Can the number of condition be reduced? If 'start + len' overflows, then
> >>> we don't need to check 'start > eb->len', and for the case where
> >>> start = 1024 and len = -1024 the 'len > eb-len' would be enough.
> >>
> >> I'm afraid not.
> >> Although 'start > eb->len || len > eb->len' is enough to detect overflow
> >> case, it no longer detects cases like 'start = 2k, len = 3k' while
> >> eb->len == 4K case.
> >>
> >> So we still need all 3 checks.
> > 
> > I was suggesting 'start + len > eb->len', not 'start > eb-len'.
> > 
> > "start > eb->len" is implied by "start + len > eb->len".
> 
> start > eb->len is not implied if (start + len) over flows.
> 
> E.g. start = -2K, len = 2k, eb->len = 4K. We can still pass !(start +
> len > eb->len || len > eb->len).
> 
> In short, if we want overflow check along with each one checked, we
> really need 3 checks.

So what if we add overflow check, that would catch negative start or
negative length, and then do start + len > eb->len?

The check_setget_bounds is different becasue the len is known at compile
time so the overflows can't happen in the same way as for the eb range,
so this this confused me first.

	check_add_overflow(start, len) || start + len > eb->len
