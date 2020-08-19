Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E51524A4A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 19:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHSRNQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 13:13:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:38380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgHSRNM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 13:13:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F7A1AD8D;
        Wed, 19 Aug 2020 17:13:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EFA5ADA703; Wed, 19 Aug 2020 19:11:59 +0200 (CEST)
Date:   Wed, 19 Aug 2020 19:11:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v5 1/4] btrfs: extent_io: do extra check for extent
 buffer read write functions
Message-ID: <20200819171159.GT2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200819063550.62832-1-wqu@suse.com>
 <20200819063550.62832-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819063550.62832-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 02:35:47PM +0800, Qu Wenruo wrote:
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5620,6 +5620,34 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
>  	return ret;
>  }
>  
> +static void report_eb_range(const struct extent_buffer *eb, unsigned long start,
> +			    unsigned long len)
> +{
> +	btrfs_warn(eb->fs_info,
> +"btrfs: bad eb rw request, eb bytenr=%llu len=%lu rw start=%lu len=%lu\n",

No "btrfs:" prefix needed, no "\n" at the end of the string. The format
now uses the 'key=value' style, while we have the 'key value' in many
other places, this should be consistent.

> +		   eb->start, eb->len, start, len);
> +	WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> +}
> +
> +/*
> + * Check if the [start, start + len) range is valid before reading/writing
> + * the eb.
> + * NOTE: @start and @len are offset *INSIDE* the eb, *NOT* logical address.
> + *
> + * Caller should not touch the dst/src memory if this function returns error.
> + */
> +static inline int check_eb_range(const struct extent_buffer *eb,
> +				 unsigned long start, unsigned long len)
> +{
> +	/* start, start + len should not go beyond eb->len nor overflow */
> +	if (unlikely(start > eb->len || start + len > eb->len ||
> +		     len > eb->len)) {

Can the number of condition be reduced? If 'start + len' overflows, then
we don't need to check 'start > eb->len', and for the case where
start = 1024 and len = -1024 the 'len > eb-len' would be enough.

> +		report_eb_range(eb, start, len);
> +		return -EINVAL;

This could be simply

		return report_eb_range(...);

It's not a big difference though, compiler produces the same code.
