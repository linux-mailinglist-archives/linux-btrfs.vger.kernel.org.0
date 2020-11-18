Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68492B81AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 17:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKRQWl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 11:22:41 -0500
Received: from twin.jikos.cz ([91.219.245.39]:34865 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgKRQWl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 11:22:41 -0500
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 0AIGMZeB018720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 18 Nov 2020 17:22:36 +0100
Received: (from dave@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) id 0AIGMZW7018719;
        Wed, 18 Nov 2020 17:22:35 +0100
Date:   Wed, 18 Nov 2020 17:22:35 +0100
From:   David Sterba <dave@jikos.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 12/24] btrfs: extent_io: update num_extent_pages() to
 support subpage sized extent buffer
Message-ID: <20201118162235.GA17322@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-13-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-13-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:37PM +0800, Qu Wenruo wrote:
> For subpage sized extent buffer, we have ensured no extent buffer will
> cross page boundary, thus we would only need one page for any extent
> buffer.
> 
> This patch will update the function num_extent_pages() to handle such
> case.
> Now num_extent_pages() would return 1 instead of for subpage sized
> extent buffer.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index dfdef9c5c379..d39ebaee5ff7 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -206,8 +206,15 @@ void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
>  
>  static inline int num_extent_pages(const struct extent_buffer *eb)
>  {
> -	return (round_up(eb->start + eb->len, PAGE_SIZE) >> PAGE_SHIFT) -
> -	       (eb->start >> PAGE_SHIFT);
> +	/*
> +	 * For sectorsize == PAGE_SIZE case, since eb is always aligned to
> +	 * sectorsize, it's just (eb->len / PAGE_SIZE) >> PAGE_SHIFT.
> +	 *
> +	 * For sectorsize < PAGE_SIZE case, we only want to support 64K
> +	 * PAGE_SIZE, and ensured all tree blocks won't cross page boundary.
> +	 * So in that case we always got 1 page.
> +	 */
> +	return round_up(eb->len, PAGE_SIZE) >> PAGE_SHIFT;

	return max(eb->len, PAGE_SIZE) >> PAGE_SHIFT;

Looks simpler and looks understandable. A bit more compact way

	return eb->len >> PAGE_SHIFT ?: 1;

would be too much but maybe a potential optimiziation for later.
