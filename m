Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120503073E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jan 2021 11:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhA1Khj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jan 2021 05:37:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:57860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhA1KhW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jan 2021 05:37:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64F1CAC45;
        Thu, 28 Jan 2021 10:36:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BC01FDA7D9; Thu, 28 Jan 2021 11:34:52 +0100 (CET)
Date:   Thu, 28 Jan 2021 11:34:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 00/18] btrfs: add read-only support for subpage sector
 size
Message-ID: <20210128103452.GG1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210126083402.142577-1-wqu@suse.com>
 <a448ea77-957b-b7fc-c05a-29a4a13352b8@toxicpanda.com>
 <e370c8d6-8559-c8a0-9938-160e003e933b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e370c8d6-8559-c8a0-9938-160e003e933b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 28, 2021 at 08:30:21AM +0800, Qu Wenruo wrote:
> >>    btrfs: support subpage for extent buffer page release
> >
> > I don't have this patch in my inbox so I can't reply to it directly, but
> > you include refcount.h, but then use normal atomics.  Please used the
> > actual refcount_t, as it gets us all the debugging stuff that makes
> > finding problems much easier.  Thanks,
> 
> My bad, my initial plan is to use refcount, but the use case has valid 0
> refcount usage, thus refcount is not good here.

In case you need to shift the "0" you can use refcount_dec_not_one or
refcount_inc/dec_not_zero, but I haven't seen the code so don't know if
this applies in your case.
