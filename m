Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968D526C4F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIPQO4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 12:14:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:60118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgIPQOc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F0F8AFEA;
        Wed, 16 Sep 2020 16:02:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0339DA7C7; Wed, 16 Sep 2020 18:01:15 +0200 (CEST)
Date:   Wed, 16 Sep 2020 18:01:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 04/19] btrfs: remove the open-code to read disk-key
Message-ID: <20200916160115.GN1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-5-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915053532.63279-5-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 15, 2020 at 01:35:17PM +0800, Qu Wenruo wrote:
> generic_bin_search() distinguishes between reading a key which doesn't
> cross a page and one which does. However this distinction is not
> necessary since read_extent_buffer handles both cases transparently.
> 
> Just use read_extent_buffer to streamline the code.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index cd1cd673bc0b..e204e1320745 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1697,7 +1697,6 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
>  	}
>  
>  	while (low < high) {
> -		unsigned long oip;
>  		unsigned long offset;
>  		struct btrfs_disk_key *tmp;
>  		struct btrfs_disk_key unaligned;
> @@ -1705,17 +1704,9 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
>  
>  		mid = (low + high) / 2;
>  		offset = p + mid * item_size;
> -		oip = offset_in_page(offset);
>  
> -		if (oip + key_size <= PAGE_SIZE) {
> -			const unsigned long idx = offset >> PAGE_SHIFT;
> -			char *kaddr = page_address(eb->pages[idx]);
> -
> -			tmp = (struct btrfs_disk_key *)(kaddr + oip);
> -		} else {
> -			read_extent_buffer(eb, &unaligned, offset, key_size);
> -			tmp = &unaligned;
> -		}
> +		read_extent_buffer(eb, &unaligned, offset, key_size);
> +		tmp = &unaligned;

Reading from the first page is a performance optimization on systems
with 4K pages, ie. the majority. I'm not in favor removing it just to
make the code look nicer.
