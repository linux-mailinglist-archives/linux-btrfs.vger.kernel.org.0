Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096EB244805
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 12:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgHNKaW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Aug 2020 06:30:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:56030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgHNKaU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Aug 2020 06:30:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7CBACAD1A;
        Fri, 14 Aug 2020 10:30:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EE1FBDA6EF; Fri, 14 Aug 2020 12:29:13 +0200 (CEST)
Date:   Fri, 14 Aug 2020 12:29:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v4 1/4] btrfs: extent_io: Do extra check for extent
 buffer read write functions
Message-ID: <20200814102913.GU2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20200812060509.71590-1-wqu@suse.com>
 <20200812060509.71590-2-wqu@suse.com>
 <20200813140503.GH2026@twin.jikos.cz>
 <6f6a76e7-57b5-5e73-af6c-855cc5256a34@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f6a76e7-57b5-5e73-af6c-855cc5256a34@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 14, 2020 at 08:47:17AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/8/13 下午10:05, David Sterba wrote:
> > On Wed, Aug 12, 2020 at 02:05:06PM +0800, Qu Wenruo wrote:
> >> +/*
> >> + * Check if the [start, start + len) range is valid before reading/writing
> >> + * the eb.
> >> + * NOTE: @start and @len are offset *INSIDE* the eb, *NOT* logical address.
> >> + *
> >> + * Caller should not touch the dst/src memory if this function returns error.
> >> + */
> >> +static int check_eb_range(const struct extent_buffer *eb, unsigned long start,
> >> +			  unsigned long len)
> >> +{
> >> +	/* start, start + len should not go beyond eb->len nor overflow */
> >> +	if (unlikely(start > eb->len || start + len > eb->len ||
> >> +		     len > eb->len)) {
> >> +		btrfs_warn(eb->fs_info,
> >> +"btrfs: bad eb rw request, eb bytenr=%llu len=%lu rw start=%lu len=%lu\n",
> >> +			   eb->start, eb->len, start, len);
> >> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> >> +		return -EINVAL;
> >> +	}
> >> +	return 0;
> >> +}
> > 
> > This helper is similar to the check_setget_bounds that have some
> > performance impact,
> > https://lore.kernel.org/linux-btrfs/20200730110943.GE3703@twin.jikos.cz/
> > .
> > 
> > The extent buffer helpers are not called that often as the setget
> > helpers but still it could be improved to avoid the function call
> > penalty on the hot path.
> > 
> > static inline in check_eb_range(...) {
> > 	if (unlikely(out of range))
> > 		return report_eb_range(...)
> > 	return 0;
> > }
> 
> I thought we should avoid manual inline, but let the compiler to
> determine if it's needed.
> 
> Or in this particular case, we're better than the compiler?

In general it shouldn't be necessary to inline or partition the
functions. In the check_setget case it had a noticeable impact on
performance, so crafting the hot path manually produces a better
assembly and does not depend on the compiler optimizations. The
important part here is that this has been analyzed and measured that it
really makes a difference.

For sanity checks I think we should try to make it as fast as possible,
it's better to have them then not but we also don't want to sacrifice
performance. I haven't analyzed the asm code impact in this patch but
the pattern and flow of check_eb_range is the same.
