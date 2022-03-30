Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375F24EBED5
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 12:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245414AbiC3KgN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 06:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbiC3KgN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 06:36:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87342BB0D
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 03:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E118CCE1D07
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 10:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C315CC340EE;
        Wed, 30 Mar 2022 10:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648636464;
        bh=+A4Bkmtyr8DrA/9y7AyRFb5tYaEV0qyfzcT3Jie4bPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+niFcOux+FfcuemOph4pEGoh37kHrmmEX1M09NXLftCzflf9cgXNondV2Zj/1mRM
         Q+YkFzzA/9ZpBVYth58ix0f5rVRYMvkZCBdAufUqbWRRoq/Z9yvZXqI8gwCDvacwWI
         stV8gJ6bmWb3av9BCVvANZj1jOShLFDKirIPcJJQ+8xxi5THrNkD0hlaoKF15WUY2o
         BmlUzLWOYbBfWB2YcDo4tib5Q3v3d/TKQp2Z/MlQZ961oU9c+Bkon8t2rLCceeMCo3
         xqHKqsFEBDBMjKZb23m9rjVvmgTrYBxk2BP86AI9cltWYzWI9UhOoVq/HijoWJIi7W
         1peNlfimTwFBg==
Date:   Wed, 30 Mar 2022 11:34:21 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Message-ID: <YkQyLfTjAjbPZR9y@debian9.Home>
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <20220328185121.GQ2237@twin.jikos.cz>
 <YkLYJ+xRvmm0yN9Y@debian9.Home>
 <ed81efec-0303-d152-a84d-74f4ff4f5058@gmx.com>
 <YkLwAf7SK95iOreD@debian9.Home>
 <d7e95b14-1e87-9c09-e172-680d53cb51c5@gmx.com>
 <YkQimcdT5KwU5i/P@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkQimcdT5KwU5i/P@debian9.Home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 30, 2022 at 10:27:53AM +0100, Filipe Manana wrote:
> On Wed, Mar 30, 2022 at 07:52:04AM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2022/3/29 19:39, Filipe Manana wrote:
> > > On Tue, Mar 29, 2022 at 06:49:10PM +0800, Qu Wenruo wrote:
> > > > 
> > > > 
> > > > On 2022/3/29 17:57, Filipe Manana wrote:
> > > > > On Mon, Mar 28, 2022 at 08:51:21PM +0200, David Sterba wrote:
> > > > > > On Fri, Mar 25, 2022 at 05:37:59PM +0800, Qu Wenruo wrote:
> > > > > > > The original code is not really setting the memory to 0x00 but 0x01.
> > > > > > > 
> > > > > > > To prevent such problem from happening, use memzero_page() instead.
> > > > > > 
> > > > > > This should at least mention we think that setting it to 0 is right, as
> > > > > > you call it wrong but give no hint why it's thought to be wrong.
> > > > > 
> > > > > My guess is that something different from zero makes it easier to spot
> > > > > the problem in user space, as 0 is not uncommon (holes, prealloced extents)
> > > > > and may get unnoticed by applications/users.
> > > > 
> > > > OK, that makes some sense.
> > > > 
> > > > But shouldn't user space tool get an -EIO directly?
> > > 
> > > It should.
> > > 
> > > But even if applications get -EIO, they may often ignore return values.
> > > It's their fault, but if we can make it less likely that errors are not noticed,
> > > the better. I think we all did often, ignore all or just some return values
> > > from read(), write(), open(), etc.
> > > 
> > > One recent example is the MariaDB case with io-uring. They were reporting
> > > corruption to the users, but the problem is that didn't properly check
> > > return values, ignoring partial reads and treating them as success:
> > > 
> > > https://jira.mariadb.org/browse/MDEV-27900?focusedCommentId=216582&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-216582
> > > 
> > > The data was fine, not corrupted, they just didn't deal with partial reads
> > > and then read the remaining data when a read returns less data than expected.
> > 
> > Then can we slightly improve the filling pattern?
> > 
> > Instead of 0x01, introduce some poison value?
> 
> Why isn't 0x01 a good enough value?
> 
> A long range of 0x01 values is certainly unexpected in text files, and very likely
> on binary formats as well. Or do you think there's some case where long sequences
> of 0x01 are common and not unexpected?
> 
> > 
> > And of course, change the lable "zeroit" to something like "poise_it"?
> 
> "poison_it", poise has a very different and unrelated meaning in English.

It's also worth considering if we should change the page content at all.

Adding a poison value makes it easier to detect the corruption, both for
developers and for sloppy applications that don't check error values.

However people often want to still have access to the corrupted data, they
can tolerate a few corrupted bytes and find the remaining useful. This has
been requested a few times in the past.

Thanks.

> 
> > 
> > Thanks,
> > Qu
> > > 
> > > 
> > > 
> > > > 
> > > > As the corrupted range won't have PageUptodate set anyway.
> > > > 
> > > > Thanks,
> > > > Qu
> > > > > 
> > > > > I don't see a good reason to change this behaviour. Maybe it's just the
> > > > > label name 'zeroit' that makes it confusing. >
> > > > > > 
> > > > > > > Since we're here, also make @len const since it's just sectorsize.
> > > > > > 
> > > > > > Please don't do that, adding const is fine when the line gets touched
> > > > > > but otherwise adding it to an unrelated fix is not what I want to
> > > > > > encourage.
> > > > > 
