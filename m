Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00A030AA4C
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 15:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhBAOyX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 09:54:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:55610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhBAOxh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 09:53:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DA01ABD5;
        Mon,  1 Feb 2021 14:52:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E70E9DA6FC; Mon,  1 Feb 2021 15:50:47 +0100 (CET)
Date:   Mon, 1 Feb 2021 15:50:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 00/18] btrfs: add read-only support for subpage sector
 size
Message-ID: <20210201145047.GO1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20210126083402.142577-1-wqu@suse.com>
 <a448ea77-957b-b7fc-c05a-29a4a13352b8@toxicpanda.com>
 <e370c8d6-8559-c8a0-9938-160e003e933b@gmx.com>
 <20210128103452.GG1993@twin.jikos.cz>
 <4e3811e2-a639-fc40-390e-afe9efef0e29@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e3811e2-a639-fc40-390e-afe9efef0e29@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 28, 2021 at 06:51:46PM +0800, Qu Wenruo wrote:
> On 2021/1/28 下午6:34, David Sterba wrote:
> > On Thu, Jan 28, 2021 at 08:30:21AM +0800, Qu Wenruo wrote:
> >>>>     btrfs: support subpage for extent buffer page release
> >>>
> >>> I don't have this patch in my inbox so I can't reply to it directly, but
> >>> you include refcount.h, but then use normal atomics.  Please used the
> >>> actual refcount_t, as it gets us all the debugging stuff that makes
> >>> finding problems much easier.  Thanks,
> >>
> >> My bad, my initial plan is to use refcount, but the use case has valid 0
> >> refcount usage, thus refcount is not good here.
> > 
> > In case you need to shift the "0" you can use refcount_dec_not_one or
> > refcount_inc/dec_not_zero, but I haven't seen the code so don't know if
> > this applies in your case.
> 
> In the code, what we want is inc on zero, which will cause warning on 
> refcount. (initial subpage allocation has zero ref, then increased to 
> one when one eb is attached to the page)
> 
> But maybe I can change the timing so that we can use refcount.
> Current code uses ASSERT()s to prevent underflow, so it would be 
> sufficient for current code base though.

Assert for an underflow is ok but the refcount catches inc from zero ie.
a potential use after free.

With lifted refcount it should be possible to distinguish states where
it's really freed (0, to be deallocated) and 1 which is some middle
state like initialized, valid but not yet attached. Usage will increase
the ref, once there are no users, compare to 1, and then final put is
back to 0. A similar pattern is done for extent buffers, the subpage
data probably have similar lifetime.
