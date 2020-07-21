Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7662281B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgGUOMx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:12:53 -0400
Received: from mail.nethype.de ([5.9.56.24]:40675 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgGUOMx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:12:53 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jul 2020 10:12:51 EDT
Received: from [10.9.0.40] (helo=oesi.home)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <stefan@hello-penguin.com>)
        id 1jxsmB-003P4A-EX; Tue, 21 Jul 2020 13:57:47 +0000
Received: from stefan by oesi.home with local (Exim 4.92)
        (envelope-from <stefan@hello-penguin.com>)
        id 1jxsmA-0006tl-VX; Tue, 21 Jul 2020 15:57:46 +0200
Date:   Tue, 21 Jul 2020 15:57:46 +0200
From:   Stefan Traby <stefan@hello-penguin.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, Christian Zangl <coralllama@gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for
 cctx->total_bytes
Message-ID: <20200721135746.GA19043@hello-penguin.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
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
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 4.19.0-9-amd64 (x86_64)
X-MIL:  A-6172171143
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> > 
> 
> My point here is, I don't want the reviewers or new contributors to
> bother about the promotion rules at all.

Reviewers and contributors need to understand the rules of C.

> They only need to know that using blocksize and blocks_count directly to
> do multiply would lead to overflow.
> 
> Other details like whether the multiply follows the highest factor or
> the left operator or the right operator, shouldn't be the point and we
> don't really need to bother.

This is like suggesting to use brackets on every int-expression
like ((5*3)+7) because the precedere rules are too complex.
Do you think that writing ((5*3)+7) is "extra safe"?

> Thus casting both would definitely be right, without the need to refer
> to the complex rule book, thus save the reviewer several minutes.

I don't think so.

-- 

  ciao - 
    Stefan
