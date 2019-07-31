Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE557C3EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2019 15:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfGaNqw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Jul 2019 09:46:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:40692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfGaNqv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Jul 2019 09:46:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9497AECD;
        Wed, 31 Jul 2019 13:46:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5A8DFDA7ED; Wed, 31 Jul 2019 15:47:25 +0200 (CEST)
Date:   Wed, 31 Jul 2019 15:47:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] btrfs: extent_io: Do extra check for extent
 buffer read write functions
Message-ID: <20190731134725.GL28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190725061222.9581-1-wqu@suse.com>
 <20190725061222.9581-2-wqu@suse.com>
 <8b314cb7-880f-a5fc-0f8f-dd45116351a1@suse.com>
 <403a5d56-6d70-d983-25cc-e8481922f56d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403a5d56-6d70-d983-25cc-e8481922f56d@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 25, 2019 at 02:58:08PM +0800, Qu Wenruo wrote:
> [snip]
> >> -	if (dst_offset + len > dst->len) {
> >> -		btrfs_err(fs_info,
> >> -			"memmove bogus dst_offset %lu move len %lu dst len %lu",
> >> -			 dst_offset, len, dst->len);
> >> -		BUG();
> >> -	}
> >> +	if (check_eb_range(dst, dst_offset, len) ||
> >> +	    check_eb_range(dst, src_offset, len))
> >> +		return;
> >
> > I'm not sure about this. If the code expects memcpy_extent_buffer to
> > never fail then it will make more sense to do the range check outside of
> > this function. Otherwise it might silently fail and cause mayhem up the
> > call chain. Or just leave the BUG (I'd rather not).
> 
> Yes, that's also what I'm concerned.
> 
> But at least, for that case we're not making things worse.
> Furthermore, btrfs tree checker should have already rejected most
> invalid trees already.
> So I'm not so concerned.

I think this is the valid use of BUG, the check is supposed something
that's verified in advance and it must not happen inisdie the extent
buffer functions. Stress on the 'must not', so if it happens something
is seriously wrong, like a memory bitflip or accidental overwrite by
some other code and the BUG is there to stop propagating the error.
