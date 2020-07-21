Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7582228166
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 15:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGUN4A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 09:56:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:46706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgGUN4A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 09:56:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81960ACA9;
        Tue, 21 Jul 2020 13:56:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4FEA4DA70B; Tue, 21 Jul 2020 15:55:33 +0200 (CEST)
Date:   Tue, 21 Jul 2020 15:55:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, Christian Zangl <coralllama@gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for
 cctx->total_bytes
Message-ID: <20200721135533.GL3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        Christian Zangl <coralllama@gmail.com>
References: <20200720125109.93970-1-wqu@suse.com>
 <20200720160945.GH3703@twin.jikos.cz>
 <cf6386e1-a13b-e7cf-a365-db33a3afe2a9@gmx.com>
 <20200721095826.GJ3703@twin.jikos.cz>
 <0d3eb6c1-f88a-e7cd-7d12-92bce0f2025c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d3eb6c1-f88a-e7cd-7d12-92bce0f2025c@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 06:29:31PM +0800, Qu Wenruo wrote:
> On 2020/7/21 下午5:58, David Sterba wrote:
> > On Tue, Jul 21, 2020 at 07:51:00AM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2020/7/21 上午12:09, David Sterba wrote:
> >>> On Mon, Jul 20, 2020 at 08:51:08PM +0800, Qu Wenruo wrote:
> >>>> --- a/convert/source-ext2.c
> >>>> +++ b/convert/source-ext2.c
> >>>> @@ -87,7 +87,8 @@ static int ext2_open_fs(struct btrfs_convert_context *cctx, const char *name)
> >>>>  	cctx->fs_data = ext2_fs;
> >>>>  	cctx->blocksize = ext2_fs->blocksize;
> >>>>  	cctx->block_count = ext2_fs->super->s_blocks_count;
> >>>> -	cctx->total_bytes = ext2_fs->blocksize * ext2_fs->super->s_blocks_count;
> >>>> +	cctx->total_bytes = (u64)ext2_fs->blocksize *
> >>>> +			    (u64)ext2_fs->super->s_blocks_count;
> >>>
> >>> Do you need to cast both? Once one of the types is wide enough for the
> >>> result, there should be no loss.
> >>>
> >> I just want to be extra safe.
> > 
> > Typecasts in code raise questions why are they needed, 'to be extra'
> > safe is not a good reason. One typecast in multiplication/shifts is a
> > common pattern to widen the result but two look more like lack of
> > understanding of the integer promotion rules.
> 
> My point here is, I don't want the reviewers or new contributors to
> bother about the promotion rules at all.

Ouch, I hope you don't mean that contributors should ignore the trickier
parts of C language. Especially reviewers _have_ to bother about all
sorts of subtle behaviour.

> They only need to know that using blocksize and blocks_count directly to
> do multiply would lead to overflow.
> 
> Other details like whether the multiply follows the highest factor or
> the left operator or the right operator, shouldn't be the point and we
> don't really need to bother.

... and introduce bugs?

> Thus casting both would definitely be right, without the need to refer
> to the complex rule book, thus save the reviewer several minutes.

The opposite, if you send me code that's not following known schemes or
idiomatic schemes I'll be highly suspicious and looking for the reasons
why it's that way and making sure it's correct costs way more time.
