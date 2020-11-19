Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD7F2B9AB3
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 19:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgKSSdx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Nov 2020 13:33:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:45254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbgKSSdx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Nov 2020 13:33:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B94E0AC24;
        Thu, 19 Nov 2020 18:33:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 888D2DA701; Thu, 19 Nov 2020 19:32:06 +0100 (CET)
Date:   Thu, 19 Nov 2020 19:32:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 04/24] btrfs: extent_io: introduce helper to handle
 page status update in end_bio_extent_readpage()
Message-ID: <20201119183206.GI20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-5-wqu@suse.com>
 <20201118202745.GG20563@twin.jikos.cz>
 <0d9e346a-6ea7-893c-ce64-8f8d9a5f2785@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d9e346a-6ea7-893c-ce64-8f8d9a5f2785@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 19, 2020 at 07:43:56AM +0800, Qu Wenruo wrote:
> On 2020/11/19 上午4:27, David Sterba wrote:
> > On Fri, Nov 13, 2020 at 08:51:29PM +0800, Qu Wenruo wrote:
> >> +static void endio_readpage_update_page_status(struct page *page, bool uptodate)
> >> +{
> >> +	if (uptodate) {
> >> +		SetPageUptodate(page);
> >> +	} else {
> >> +		ClearPageUptodate(page);
> >> +		SetPageError(page);
> >> +	}
> >> +	unlock_page(page);
> > 
> > That would be better left in the caller as it's quite important
> > information but the helper name does not say anything about it.
> 
> It may be the case for now, but for incoming subpage, check the patch
> "btrfs: integrate page status update for read path into
> begin/end_page_read()" to see why we want page unlocking to be done here.

Ok. I added a comment to the call that it also unlocks the page.
