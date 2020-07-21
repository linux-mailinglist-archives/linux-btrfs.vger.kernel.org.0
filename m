Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F23227C48
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 11:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgGUJ6x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 05:58:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:45884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgGUJ6w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 05:58:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C695AC12;
        Tue, 21 Jul 2020 09:58:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7BD77DA9B7; Tue, 21 Jul 2020 11:58:26 +0200 (CEST)
Date:   Tue, 21 Jul 2020 11:58:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Christian Zangl <coralllama@gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for
 cctx->total_bytes
Message-ID: <20200721095826.GJ3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Christian Zangl <coralllama@gmail.com>
References: <20200720125109.93970-1-wqu@suse.com>
 <20200720160945.GH3703@twin.jikos.cz>
 <cf6386e1-a13b-e7cf-a365-db33a3afe2a9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf6386e1-a13b-e7cf-a365-db33a3afe2a9@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 07:51:00AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/7/21 上午12:09, David Sterba wrote:
> > On Mon, Jul 20, 2020 at 08:51:08PM +0800, Qu Wenruo wrote:
> >> --- a/convert/source-ext2.c
> >> +++ b/convert/source-ext2.c
> >> @@ -87,7 +87,8 @@ static int ext2_open_fs(struct btrfs_convert_context *cctx, const char *name)
> >>  	cctx->fs_data = ext2_fs;
> >>  	cctx->blocksize = ext2_fs->blocksize;
> >>  	cctx->block_count = ext2_fs->super->s_blocks_count;
> >> -	cctx->total_bytes = ext2_fs->blocksize * ext2_fs->super->s_blocks_count;
> >> +	cctx->total_bytes = (u64)ext2_fs->blocksize *
> >> +			    (u64)ext2_fs->super->s_blocks_count;
> > 
> > Do you need to cast both? Once one of the types is wide enough for the
> > result, there should be no loss.
> > 
> I just want to be extra safe.

Typecasts in code raise questions why are they needed, 'to be extra'
safe is not a good reason. One typecast in multiplication/shifts is a
common pattern to widen the result but two look more like lack of
understanding of the integer promotion rules.
