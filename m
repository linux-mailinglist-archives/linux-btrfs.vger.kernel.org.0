Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDE32F33AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 16:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389273AbhALPLD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 10:11:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:43822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbhALPLD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 10:11:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A63EABD6;
        Tue, 12 Jan 2021 15:10:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 02110DA87C; Tue, 12 Jan 2021 16:08:29 +0100 (CET)
Date:   Tue, 12 Jan 2021 16:08:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 06/22] btrfs: extent_io: introduce a helper to grab an
 existing extent buffer from a page
Message-ID: <20210112150829.GQ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20210106010201.37864-1-wqu@suse.com>
 <20210106010201.37864-7-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106010201.37864-7-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 06, 2021 at 09:01:45AM +0800, Qu Wenruo wrote:
> +static struct extent_buffer *grab_extent_buffer(struct page *page)
> +{
> +	struct extent_buffer *exists;
> +
> +	/* Page not yet attached to an extent buffer */
> +	if (!PagePrivate(page))
> +		return NULL;
> +
> +	/*
> +	 * We could have already allocated an eb for this page
> +	 * and attached one so lets see if we can get a ref on
> +	 * the existing eb, and if we can we know it's good and
> +	 * we can just return that one, else we know we can just
> +	 * overwrite page->private.
> +	 */

Please reformat comments that get moved to full 80 columns line. Fixed.
