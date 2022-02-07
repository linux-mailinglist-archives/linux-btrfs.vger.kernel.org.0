Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EED4ABF77
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 14:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383357AbiBGM6N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 07:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447087AbiBGMxQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Feb 2022 07:53:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BDDC043189
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 04:53:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0339BB8102E
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 12:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DE1C004E1;
        Mon,  7 Feb 2022 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644238384;
        bh=wklwhWvN5Q9wlBdsABsZprjhy5Ponkaczj4dEa2UwJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mcdxdu4XXzdRHu4Tg0+ZQYTDvF/SKq5H7aqB0R4mOzedjSP7SNm6eatXcriS6INng
         ciNAudpVrs51PWqsHwp//zTeJlbv0Innns4T9xFqWNVQUpXFR2JLvmcS4ezucYHYiI
         JOcOSQ0iVGEb1GnUapRWaAenF93AHPqshNlqXEgAZh1fnP3/jBQAQbcaw0QzizTsbH
         MIp0WPMLHoY+oMne4Vmt6AvngzB/YYbl6aLdBnVPw7d1/07SBqad1BIonU9erbgPXu
         tSCJLCdshDEPTMYjRe3x7E4SWSyJHWmaH4uysBJQNNk7opIXkmQwknz3d4mVp9DnqJ
         yyoUbhK38A0UQ==
Date:   Mon, 7 Feb 2022 12:53:01 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: defrag: don't try to defrag extent which is going
 to be written back
Message-ID: <YgEWLXu0x3j4OA9L@debian9.Home>
References: <9df1dce96466f4314190cc4120f19d5b7d0fe5ed.1644210926.git.wqu@suse.com>
 <YgD17pDNz8b165yN@debian9.Home>
 <05e40ca7-dcd6-b605-b109-e47b79baeca3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05e40ca7-dcd6-b605-b109-e47b79baeca3@gmx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 07, 2022 at 07:06:27PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/7 18:35, Filipe Manana wrote:
> > On Mon, Feb 07, 2022 at 01:17:15PM +0800, Qu Wenruo wrote:
> > > In defrag_collect_targets() if we hit an extent map which is created by
> > > create_io_em(), it will be considered as target as its generation is
> > > (u64)-1, thus will pass the generation check.
> > > 
> > > Furthermore since all delalloc functions will clear EXTENT_DELALLOC,
> > 
> > What are delalloc functions?
> > This should say that once we start writeback (we run delalloc), we allocate
> > an extent, create an extent map point to that extent, with a generation of
> > (u64)-1, created the ordered extent and then clear the DELALLOC bit from the
> > range in the inode's io tree.
> 
> I mean the functions called inside btrfs_run_dealloc_ranges(), like
> cow_file_range() etc.
> 
> > 
> > > such extent map will also pass the EXTENT_DELALLOC check.
> > > 
> > > Defragging such extent will make no sense, in fact this will cause extra
> > > IO as we will just re-dirty the range and submit it for writeback again,
> > > causing wasted IO.
> > 
> > defrag_prepare_one_page() will wait for the ordered extent to complete,
> > and after the wait, the extent map's generation is updated from (u64)-1 to
> > something else.
> > 
> > So the second pass of defrag_collect_targets() will see a generation that
> > is not (u64)-1.
> 
> Yes, for the 2nd loop we will no longer see the (u64)-1 generations.
> 
> > 
> > > 
> > > Unfortunately this behavior seems to exist in older kernels too (v5.15
> > > and older), but I don't have a solid test case to prove it nor test the
> > > patched behavior.
> > 
> > This is exactly the first patch I sent François when the first report
> > of unusable autodefrag popped up:
> > 
> > https://lore.kernel.org/linux-btrfs/YeVawBBE3r6hVhgs@debian9.Home/T/#ma1c8a9848c9b7e4edb471f7be184599d38e288bb
> 
> Oh, mind to send out the proper patch as you're the original author with
> this idea?

I don't mind if you send your version. That's fine, my comment there about
the infinite loop is not correct, as that was before having a better understanding
of all that changed in the refactoring and before finding out the 1 byte file
case triggering the almost infinite loop.

Just the correction to the change log, comment, and also the subject ("which is going
to be written back" should be "which is under writeback").

Thanks.


> 
> Thanks,
> Qu
> > 
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   fs/btrfs/ioctl.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > index 133e3e2e2e79..0ba98e1d9329 100644
> > > --- a/fs/btrfs/ioctl.c
> > > +++ b/fs/btrfs/ioctl.c
> > > @@ -1353,6 +1353,10 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
> > >   		if (em->generation < ctrl->newer_than)
> > >   			goto next;
> > > 
> > > +		/* This em is goging to be written back, no need to defrag */
> > 
> > goging -> going
> > 
> > Saying that it is under writeback is more correct.
> > By saying is "going to be", it gives the idea that writeback may have not started yet,
> > but an extent map with a generation of (u64)-1 is created when writeback starts.
> > 
> > 
> > > +		if (em->generation == (u64)-1)
> > > +			goto next;
> > > +
> > >   		/*
> > >   		 * Our start offset might be in the middle of an existing extent
> > >   		 * map, so take that into account.
> > > --
> > > 2.35.0
> > > 
