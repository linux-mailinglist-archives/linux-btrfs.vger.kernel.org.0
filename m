Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0C139761
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 18:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgAMRTS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 12:19:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:35062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbgAMRTS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 12:19:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CAC05ABD1;
        Mon, 13 Jan 2020 17:19:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E2E13DA78B; Mon, 13 Jan 2020 18:19:03 +0100 (CET)
Date:   Mon, 13 Jan 2020 18:19:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs: relocation: Fix KASAN reports caused by
 extended reloc tree lifespan
Message-ID: <20200113171903.GZ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200108051200.8909-1-wqu@suse.com>
 <7482d2f3-f3a1-7dd9-6003-9042c1781207@toxicpanda.com>
 <2bfd87cf-2733-af0d-f33f-59e07c25d500@suse.com>
 <20200108150841.GH3929@twin.jikos.cz>
 <20200108151159.GI3929@twin.jikos.cz>
 <85422cb2-e140-563b-fadd-f820354ed156@gmx.com>
 <20200109143742.GN3929@twin.jikos.cz>
 <f8458b9c-0b6c-024e-399d-ea530abd1204@gmx.com>
 <d4322bd6-c2dd-e3e6-e8eb-2cda1963f9d7@gmx.com>
 <8b1245b4-ecac-57c1-d1bf-28360f089f6d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b1245b4-ecac-57c1-d1bf-28360f089f6d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 13, 2020 at 12:41:45PM +0800, Qu Wenruo wrote:
> On 2020/1/10 上午8:58, Qu Wenruo wrote:
> > On 2020/1/10 上午8:21, Qu Wenruo wrote:
> >> On 2020/1/9 下午10:37, David Sterba wrote:
> >>> On Thu, Jan 09, 2020 at 01:54:34PM +0800, Qu Wenruo wrote:
> >>> We use smp_mb() because this serializes memory among multipe CPUs, when
> >>> one changes memory but stores it to some temporary structures, while
> >>> other CPUs don't see the effects. I'm sure you've read about that in the
> >>> memory barrier docs.
> >
> > I guess the main difference between us is the effect of "per-cpu
> > viewable temporary value".
> >
> > It looks like your point is, without rmb() we can't see consistent
> > values the writer sees.
> >
> > But my point is, even we can only see a temporary value, the
> > __before_atomic() mb at the writer side, ensures only 3 possible
> > temporary values combination can be seen.
> > (PTR, DEAD), (NULL, DEAD), (NULL, 0).
> >
> > The killed (PTR, 0) combination is killed by that writer side mb.
> > Thus no need for the reader side mb before test_bit().
> >
> > That's why I insist on the "test_bit() can happen whenever they like"
> > point, as that has the same effect as schedule.
> 
> Can we push the fix to upstream? I hope it to be fixed in late rc of v5.5.

Yes the plan is to push it to 5.5-rc so we can get the stable backports.

About the barriers, we seem to have a conclusion to use smp_rmb/smp_wmb
and not the smp_mb__before/after_atomic. Zygo also tested the patch and
reported it's ok so I don't want to hold it back.

Understanding the memory barriers takes time to digest (which basically
means to develop a cpu simulator in ones head with speculative writes
and execution and then keep sanity when reasoning about them).
