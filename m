Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521AF26DC18
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 14:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgIQMxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 08:53:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:35584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgIQMxp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 08:53:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98C52ACBF;
        Thu, 17 Sep 2020 12:39:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 25500DA7C7; Thu, 17 Sep 2020 14:37:39 +0200 (CEST)
Date:   Thu, 17 Sep 2020 14:37:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 04/19] btrfs: remove the open-code to read disk-key
Message-ID: <20200917123738.GR1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-5-wqu@suse.com>
 <20200916160115.GN1791@twin.jikos.cz>
 <e5a6d6a4-93b7-9845-5448-ac56ecf97075@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5a6d6a4-93b7-9845-5448-ac56ecf97075@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 17, 2020 at 04:02:37PM +0800, Qu Wenruo wrote:
> On 2020/9/17 上午12:01, David Sterba wrote:
> > On Tue, Sep 15, 2020 at 01:35:17PM +0800, Qu Wenruo wrote:
> >> generic_bin_search() distinguishes between reading a key which doesn't
> >> cross a page and one which does. However this distinction is not
> >> necessary since read_extent_buffer handles both cases transparently.
> >>
> >> Just use read_extent_buffer to streamline the code.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>  fs/btrfs/ctree.c | 13 ++-----------
> >>  1 file changed, 2 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> >> index cd1cd673bc0b..e204e1320745 100644
> >> --- a/fs/btrfs/ctree.c
> >> +++ b/fs/btrfs/ctree.c
> >> @@ -1697,7 +1697,6 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
> >>  	}
> >>  
> >>  	while (low < high) {
> >> -		unsigned long oip;
> >>  		unsigned long offset;
> >>  		struct btrfs_disk_key *tmp;
> >>  		struct btrfs_disk_key unaligned;
> >> @@ -1705,17 +1704,9 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
> >>  
> >>  		mid = (low + high) / 2;
> >>  		offset = p + mid * item_size;
> >> -		oip = offset_in_page(offset);
> >>  
> >> -		if (oip + key_size <= PAGE_SIZE) {
> >> -			const unsigned long idx = offset >> PAGE_SHIFT;
> >> -			char *kaddr = page_address(eb->pages[idx]);
> >> -
> >> -			tmp = (struct btrfs_disk_key *)(kaddr + oip);
> >> -		} else {
> >> -			read_extent_buffer(eb, &unaligned, offset, key_size);
> >> -			tmp = &unaligned;
> >> -		}
> >> +		read_extent_buffer(eb, &unaligned, offset, key_size);
> >> +		tmp = &unaligned;
> > 
> > Reading from the first page is a performance optimization on systems
> > with 4K pages, ie. the majority. I'm not in favor removing it just to
> > make the code look nicer.
> 
> For 4K system, with the optimization it only saves one
> read_extent_buffer() call cost.

This evaluation is wrong, you missed several things that
generic_bin_search and read_extent_buffer do.

generic_bin_search is called very often, each search slot so
optimization is worth here

read_extent_buffer is used _only_ for keys that cross page boundary, so
we need to read the bytes in two steps and this is wrapped into a
function that we call in a limited number of cases

In all other cases, when the whole key is contained in the page the call
is inline in generic_bin_search, ie. no function call overhead

> Or we will need to manually call get_eb_page_offset() here to make it
> work for subpage.

For nodesize that is smaller than PAGE_SIZE there's no page crossing at
all so using read_extent_buffer would be making things worse.
