Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7564EBF7F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245757AbiC3LEy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 07:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbiC3LEv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 07:04:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D1EC5584
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 04:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60E93B81C0F
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 11:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81A9C340F3;
        Wed, 30 Mar 2022 11:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648638184;
        bh=+xBinEzFwvu7IVfynWyeI7qYI5nHEaUdKwFPbmlqm0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PKeuLrZZvWp9erY3bZ1aXw4CsuAzgnRfL3YQUBF5DakbGNRHYy2X4kQcocY9kgS+e
         CMPOI1TzgvrmB8h0YV2KSVBc3Ukdwl9OfJ9223DbUi1u874l8rWoEAAr7u6dnDkOPR
         7HmCWWSUUj0TMLdoK3wZ2amMHYmwxRnhRfdYiWQYE7MF3h7KwKNplhfonAu2F3DD+S
         r5vIJTF2IGdwZoLaViKt/Aul2tpX1ZAYts6e/L3UeLC3aRmKd9OrEhWSOSynMYp6dG
         L1ybmjkbeXLM0zpyS0FnE/28EAPKr0K4gzoSMrYbJMw32vzwc3IowIVV1uaPnCANYD
         cXJWGrzYvlpNQ==
Date:   Wed, 30 Mar 2022 12:02:55 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Message-ID: <YkQ43xyYOYtNvpcr@debian9.Home>
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <20220328185121.GQ2237@twin.jikos.cz>
 <YkLYJ+xRvmm0yN9Y@debian9.Home>
 <ed81efec-0303-d152-a84d-74f4ff4f5058@gmx.com>
 <YkLwAf7SK95iOreD@debian9.Home>
 <d7e95b14-1e87-9c09-e172-680d53cb51c5@gmx.com>
 <YkQimcdT5KwU5i/P@debian9.Home>
 <YkQyLfTjAjbPZR9y@debian9.Home>
 <6e5e4112-8b9f-fcb4-1a04-c68db2fa9880@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5e4112-8b9f-fcb4-1a04-c68db2fa9880@gmx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 30, 2022 at 06:42:39PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/3/30 18:34, Filipe Manana wrote:
> > On Wed, Mar 30, 2022 at 10:27:53AM +0100, Filipe Manana wrote:
> > > On Wed, Mar 30, 2022 at 07:52:04AM +0800, Qu Wenruo wrote:
> > > > 
> > > > 
> > > > On 2022/3/29 19:39, Filipe Manana wrote:
> > > > > On Tue, Mar 29, 2022 at 06:49:10PM +0800, Qu Wenruo wrote:
> > > > > > 
> > > > > > 
> > > > > > On 2022/3/29 17:57, Filipe Manana wrote:
> > > > > > > On Mon, Mar 28, 2022 at 08:51:21PM +0200, David Sterba wrote:
> > > > > > > > On Fri, Mar 25, 2022 at 05:37:59PM +0800, Qu Wenruo wrote:
> > > > > > > > > The original code is not really setting the memory to 0x00 but 0x01.
> > > > > > > > > 
> > > > > > > > > To prevent such problem from happening, use memzero_page() instead.
> > > > > > > > 
> > > > > > > > This should at least mention we think that setting it to 0 is right, as
> > > > > > > > you call it wrong but give no hint why it's thought to be wrong.
> > > > > > > 
> > > > > > > My guess is that something different from zero makes it easier to spot
> > > > > > > the problem in user space, as 0 is not uncommon (holes, prealloced extents)
> > > > > > > and may get unnoticed by applications/users.
> > > > > > 
> > > > > > OK, that makes some sense.
> > > > > > 
> > > > > > But shouldn't user space tool get an -EIO directly?
> > > > > 
> > > > > It should.
> > > > > 
> > > > > But even if applications get -EIO, they may often ignore return values.
> > > > > It's their fault, but if we can make it less likely that errors are not noticed,
> > > > > the better. I think we all did often, ignore all or just some return values
> > > > > from read(), write(), open(), etc.
> > > > > 
> > > > > One recent example is the MariaDB case with io-uring. They were reporting
> > > > > corruption to the users, but the problem is that didn't properly check
> > > > > return values, ignoring partial reads and treating them as success:
> > > > > 
> > > > > https://jira.mariadb.org/browse/MDEV-27900?focusedCommentId=216582&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-216582
> > > > > 
> > > > > The data was fine, not corrupted, they just didn't deal with partial reads
> > > > > and then read the remaining data when a read returns less data than expected.
> > > > 
> > > > Then can we slightly improve the filling pattern?
> > > > 
> > > > Instead of 0x01, introduce some poison value?
> > > 
> > > Why isn't 0x01 a good enough value?
> > > 
> > > A long range of 0x01 values is certainly unexpected in text files, and very likely
> > > on binary formats as well. Or do you think there's some case where long sequences
> > > of 0x01 are common and not unexpected?
> > > 
> > > > 
> > > > And of course, change the lable "zeroit" to something like "poise_it"?
> > > 
> > > "poison_it", poise has a very different and unrelated meaning in English.
> > 
> > It's also worth considering if we should change the page content at all.
> > 
> > Adding a poison value makes it easier to detect the corruption, both for
> > developers and for sloppy applications that don't check error values.
> > 
> > However people often want to still have access to the corrupted data, they
> > can tolerate a few corrupted bytes and find the remaining useful. This has
> > been requested a few times in the past.
> 
> This looks more favorable.
> 
> And I didn't think the change would break anything.
> 
> For proper user space programs checking the error, they know it's an
> -EIO and will error out.
> 
> For bad programs not checking the error, it will just read the corrupted
> data, and may even pass its internal sanity checks (if the corrupted
> bytes are not in some critical part).
> 
> Or is there something we haven't taken into consideration?

Apart from that, applications ignoring error code returned from read()/pread()/etc,
I can't think about anything else to worry about (at least for now).

I believe the poison value was intended only for the early days of development, or
at least it's something I would do myself because it makes sense and I've seen it
elsewhere too. But there are no comments in the code or change logs to validate
that assumption.

Certainly zeroing out the conent is not useful, so either a poison value or don't
change the page data at all. We should really have a test for this - for example
use a single data profile, corrupt 1 byte of data, mount the fs, read the data,
check we get -EIO and verify that the page content is either the data we have on
disk or the poison value.

> 
> Thanks,
> Qu
> 
> > 
> > Thanks.
> > 
> > > 
> > > > 
> > > > Thanks,
> > > > Qu
> > > > > 
> > > > > 
> > > > > 
> > > > > > 
> > > > > > As the corrupted range won't have PageUptodate set anyway.
> > > > > > 
> > > > > > Thanks,
> > > > > > Qu
> > > > > > > 
> > > > > > > I don't see a good reason to change this behaviour. Maybe it's just the
> > > > > > > label name 'zeroit' that makes it confusing. >
> > > > > > > > 
> > > > > > > > > Since we're here, also make @len const since it's just sectorsize.
> > > > > > > > 
> > > > > > > > Please don't do that, adding const is fine when the line gets touched
> > > > > > > > but otherwise adding it to an unrelated fix is not what I want to
> > > > > > > > encourage.
> > > > > > > 
