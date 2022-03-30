Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB444ECEE2
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 23:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiC3VgH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 17:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiC3VgG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 17:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A7CBC0B
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 14:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85D386170B
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 21:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A6EC340EE;
        Wed, 30 Mar 2022 21:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648676058;
        bh=X0kq7ccEavaSsnVfXy9qfEIwziwuKGhsXs1JAhPNGbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDgB9bK8ngv5UHhObswlMRIJSDMjY9Pm0wrwwHoO0enKad8NZwyBlYJ2FwSmbZv6e
         ZF7YTXXHo17Wb33RsshhxUVY+swMIUDO4xHLI/6MNj8ibHAPaFudzjmO5YORPEaIp3
         hxNEs4+voO+7ynPDrHYeJAxMwi5bFVKXe2zYXmaAPD0T9HmBv9ySUxmM4Iq76QfiSO
         tUHRMYNXEsFfp58ni3cmO/YKMTYtByXqFjvjCeNz0TKHpzcUUIR49su4m9CzwqMfd6
         c2KJXsmmHmbX8xp2uMCJsi8iB4wnAnu+4EW9AJwWkJmLql29JLiSro+xtcW8oVg/Ta
         EzfFUIJuVoLeg==
Date:   Wed, 30 Mar 2022 22:34:15 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Message-ID: <YkTM1yX2G02JyhHj@debian9.Home>
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <20220328185121.GQ2237@twin.jikos.cz>
 <YkLYJ+xRvmm0yN9Y@debian9.Home>
 <ed81efec-0303-d152-a84d-74f4ff4f5058@gmx.com>
 <YkLwAf7SK95iOreD@debian9.Home>
 <d7e95b14-1e87-9c09-e172-680d53cb51c5@gmx.com>
 <YkQimcdT5KwU5i/P@debian9.Home>
 <YkQyLfTjAjbPZR9y@debian9.Home>
 <6e5e4112-8b9f-fcb4-1a04-c68db2fa9880@gmx.com>
 <bc1c01bd-7f98-a2a3-8a2e-2a1c1d31e853@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc1c01bd-7f98-a2a3-8a2e-2a1c1d31e853@cobb.uk.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 30, 2022 at 12:03:36PM +0100, Graham Cobb wrote:
> 
> On 30/03/2022 11:42, Qu Wenruo wrote:
> > 
> > 
> > On 2022/3/30 18:34, Filipe Manana wrote:
> >> On Wed, Mar 30, 2022 at 10:27:53AM +0100, Filipe Manana wrote:
> >>> On Wed, Mar 30, 2022 at 07:52:04AM +0800, Qu Wenruo wrote:
> >>>>
> >>>>
> >>>> On 2022/3/29 19:39, Filipe Manana wrote:
> >>>>> On Tue, Mar 29, 2022 at 06:49:10PM +0800, Qu Wenruo wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 2022/3/29 17:57, Filipe Manana wrote:
> >>>>>>> On Mon, Mar 28, 2022 at 08:51:21PM +0200, David Sterba wrote:
> >>>>>>>> On Fri, Mar 25, 2022 at 05:37:59PM +0800, Qu Wenruo wrote:
> >>>>>>>>> The original code is not really setting the memory to 0x00 but
> >>>>>>>>> 0x01.
> >>>>>>>>>
> >>>>>>>>> To prevent such problem from happening, use memzero_page()
> >>>>>>>>> instead.
> >>>>>>>>
> >>>>>>>> This should at least mention we think that setting it to 0 is
> >>>>>>>> right, as
> >>>>>>>> you call it wrong but give no hint why it's thought to be wrong.
> >>>>>>>
> >>>>>>> My guess is that something different from zero makes it easier to
> >>>>>>> spot
> >>>>>>> the problem in user space, as 0 is not uncommon (holes,
> >>>>>>> prealloced extents)
> >>>>>>> and may get unnoticed by applications/users.
> >>>>>>
> >>>>>> OK, that makes some sense.
> >>>>>>
> >>>>>> But shouldn't user space tool get an -EIO directly?
> >>>>>
> >>>>> It should.
> >>>>>
> >>>>> But even if applications get -EIO, they may often ignore return
> >>>>> values.
> >>>>> It's their fault, but if we can make it less likely that errors are
> >>>>> not noticed,
> >>>>> the better. I think we all did often, ignore all or just some
> >>>>> return values
> >>>>> from read(), write(), open(), etc.
> >>>>>
> >>>>> One recent example is the MariaDB case with io-uring. They were
> >>>>> reporting
> >>>>> corruption to the users, but the problem is that didn't properly check
> >>>>> return values, ignoring partial reads and treating them as success:
> >>>>>
> >>>>> https://jira.mariadb.org/browse/MDEV-27900?focusedCommentId=216582&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-216582
> >>>>>
> >>>>>
> >>>>> The data was fine, not corrupted, they just didn't deal with
> >>>>> partial reads
> >>>>> and then read the remaining data when a read returns less data than
> >>>>> expected.
> >>>>
> >>>> Then can we slightly improve the filling pattern?
> >>>>
> >>>> Instead of 0x01, introduce some poison value?
> >>>
> >>> Why isn't 0x01 a good enough value?
> >>>
> >>> A long range of 0x01 values is certainly unexpected in text files,
> >>> and very likely
> >>> on binary formats as well. Or do you think there's some case where
> >>> long sequences
> >>> of 0x01 are common and not unexpected?
> >>>
> >>>>
> >>>> And of course, change the lable "zeroit" to something like "poise_it"?
> >>>
> >>> "poison_it", poise has a very different and unrelated meaning in
> >>> English.
> >>
> >> It's also worth considering if we should change the page content at all.
> >>
> >> Adding a poison value makes it easier to detect the corruption, both for
> >> developers and for sloppy applications that don't check error values.
> >>
> >> However people often want to still have access to the corrupted data,
> >> they
> >> can tolerate a few corrupted bytes and find the remaining useful. This
> >> has
> >> been requested a few times in the past.
> > 
> > This looks more favorable.
> > 
> > And I didn't think the change would break anything.
> > 
> > For proper user space programs checking the error, they know it's an
> > -EIO and will error out.
> > 
> > For bad programs not checking the error, it will just read the corrupted
> > data, and may even pass its internal sanity checks (if the corrupted
> > bytes are not in some critical part).
> > 
> > Or is there something we haven't taken into consideration?
> 
> Well.... If an error occurred something has gone wrong. It could be a
> simple bit flip in the storage itself, or it could be something else.
> The something else could be a software or firmware bug, or a memory
> corruption or memory controller power fluctuation blip, or .... I guess
> it might even be possible in some architectures that the problem could
> result in page table updates validating a page that actually was never
> written to at all and could still contain some previous contents.
> 
> In a time when we worry about things like Spectre, Meltdown, Rowhammer,
> stale cache leakage, etc it may be a good security principle that data
> left over from failed operations should never be made visible to user mode.
> 
> Possibly unnecessary worrying, but then who thought that jump prediction
> would create a side-channel for exposing data that can actually be
> exploited in real life.

Hum, then a filesystem that doesn't have data checksums (the vast majority of
them), like ext4, xfs, etc, has a serious security flaw, no? You ask to read an
extent, and it returns whatever is on disk, even if it has suffered some corruption.

Shall we open a CVE, and force all filesystems to implement data checksums? ;)
We would also have to drop support for nodatacow and nodatasum from btrfs.


> 
> Graham
