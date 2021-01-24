Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376BA301B97
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 12:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbhAXLww (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 06:52:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:40218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbhAXLwM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 06:52:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18424AD3E;
        Sun, 24 Jan 2021 11:51:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3DF8EDA7D7; Sun, 24 Jan 2021 12:49:44 +0100 (CET)
Date:   Sun, 24 Jan 2021 12:49:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 01/18] btrfs: update locked page dirty/writeback/error
 bits in __process_pages_contig()
Message-ID: <20210124114944.GE1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-2-wqu@suse.com>
 <b0360753-072a-f5c5-3ea6-08e9db2445dd@toxicpanda.com>
 <c4bd841c-6657-5a72-85ac-fc8359c87a74@gmx.com>
 <bab806e1-ad3d-b34c-b623-915b39621983@suse.com>
 <20210123191304.GA1993@twin.jikos.cz>
 <838b4acf-16fa-eaf8-e151-fc8b734c9b49@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <838b4acf-16fa-eaf8-e151-fc8b734c9b49@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 24, 2021 at 08:35:27AM +0800, Qu Wenruo wrote:
> On 2021/1/24 上午3:13, David Sterba wrote:
> > On Thu, Jan 21, 2021 at 02:51:46PM +0800, Qu Wenruo wrote:
> >> On 2021/1/21 下午2:32, Qu Wenruo wrote:
> >>> On 2021/1/20 上午5:41, Josef Bacik wrote:
> >>>> On 1/16/21 2:15 AM, Qu Wenruo wrote:
> >> To be more clear, we call extent_clear_unlock_delalloc() with
> >> locked_page == NULL, to allow __process_pages_contig() to unlock the
> >> locked page (while the locked page isn't locked by
> >> __process_pages_contig()).
> >>
> >> For subpage data, we need writers accounting for subpage, but that
> >> accounting only happens in __process_pages_contig(), thus we don't want
> >> pages without the accounting to be unlocked by __process_pages_contig().
> >>
> >> I can do extra page unlock/clear_dirty/end_writeback just for that
> >> exception, but it would definitely needs more comments.
> > 
> > This is patch 1 and other depend on the changed behaviour so if it's
> > just updated changelog and comments, and Josef is ok with the result, I
> > can take it but otherwise this could delay the series once the rest is
> > reworked.
> > 
> In fact there aren't many changes depending on it, until we hit RW support.
> 
> Thus I can move this patch to RW series, so that we can fully focus on 
> RO support.

That's a good option.

> The patchset will be delayed for a while (ETA in week 04), mostly due to 
> the change in how we handle metadata ref count (other than just 
> under_alloc).
> 
> Would this be OK for you?

Yes that OK, thanks.
