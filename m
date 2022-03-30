Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDEA4EBDA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 11:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244818AbiC3J3n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 05:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244814AbiC3J3m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 05:29:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD0264573
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 02:27:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66951611BD
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 09:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738C3C340F0;
        Wed, 30 Mar 2022 09:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648632476;
        bh=P7Qe5wnFG+kEzpqH1wxg5MLMuuldVbBKQ/0cLM4qkvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m772jczCUpLTiUey4fmNao3Aa4X9gDD9BtE+pP4xzMIPp8l+ZEtQ0cTiYa5OgOjfP
         5VEuVUv7Dh6exiT9YViaZ47WpbJTxxAf8XJiGNUiVedMYfUN/+e0vfJ2SyRCqJoln/
         xj386ExKKyuW34OtnHntPjl9iFCmLPQO128tzhdfoo+Sbe4DIWzfGTuOw8IW9wAY4u
         eYHnG2TAYIS5FSLnfp3hOHocLtWZeKHDomlI/0aizFcmjlpHBSOryUNHdvHhheU5ME
         1RAJxXr8afvRozVuOFqKuEUTp7GTP1C/tGu7c5hheQo/D4hFOwYgwJFgrXSRQwFnQ2
         LtUFKuVMlu+fg==
Date:   Wed, 30 Mar 2022 10:27:53 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Message-ID: <YkQimcdT5KwU5i/P@debian9.Home>
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <20220328185121.GQ2237@twin.jikos.cz>
 <YkLYJ+xRvmm0yN9Y@debian9.Home>
 <ed81efec-0303-d152-a84d-74f4ff4f5058@gmx.com>
 <YkLwAf7SK95iOreD@debian9.Home>
 <d7e95b14-1e87-9c09-e172-680d53cb51c5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e95b14-1e87-9c09-e172-680d53cb51c5@gmx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 30, 2022 at 07:52:04AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/3/29 19:39, Filipe Manana wrote:
> > On Tue, Mar 29, 2022 at 06:49:10PM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2022/3/29 17:57, Filipe Manana wrote:
> > > > On Mon, Mar 28, 2022 at 08:51:21PM +0200, David Sterba wrote:
> > > > > On Fri, Mar 25, 2022 at 05:37:59PM +0800, Qu Wenruo wrote:
> > > > > > The original code is not really setting the memory to 0x00 but 0x01.
> > > > > > 
> > > > > > To prevent such problem from happening, use memzero_page() instead.
> > > > > 
> > > > > This should at least mention we think that setting it to 0 is right, as
> > > > > you call it wrong but give no hint why it's thought to be wrong.
> > > > 
> > > > My guess is that something different from zero makes it easier to spot
> > > > the problem in user space, as 0 is not uncommon (holes, prealloced extents)
> > > > and may get unnoticed by applications/users.
> > > 
> > > OK, that makes some sense.
> > > 
> > > But shouldn't user space tool get an -EIO directly?
> > 
> > It should.
> > 
> > But even if applications get -EIO, they may often ignore return values.
> > It's their fault, but if we can make it less likely that errors are not noticed,
> > the better. I think we all did often, ignore all or just some return values
> > from read(), write(), open(), etc.
> > 
> > One recent example is the MariaDB case with io-uring. They were reporting
> > corruption to the users, but the problem is that didn't properly check
> > return values, ignoring partial reads and treating them as success:
> > 
> > https://jira.mariadb.org/browse/MDEV-27900?focusedCommentId=216582&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-216582
> > 
> > The data was fine, not corrupted, they just didn't deal with partial reads
> > and then read the remaining data when a read returns less data than expected.
> 
> Then can we slightly improve the filling pattern?
> 
> Instead of 0x01, introduce some poison value?

Why isn't 0x01 a good enough value?

A long range of 0x01 values is certainly unexpected in text files, and very likely
on binary formats as well. Or do you think there's some case where long sequences
of 0x01 are common and not unexpected?

> 
> And of course, change the lable "zeroit" to something like "poise_it"?

"poison_it", poise has a very different and unrelated meaning in English.

> 
> Thanks,
> Qu
> > 
> > 
> > 
> > > 
> > > As the corrupted range won't have PageUptodate set anyway.
> > > 
> > > Thanks,
> > > Qu
> > > > 
> > > > I don't see a good reason to change this behaviour. Maybe it's just the
> > > > label name 'zeroit' that makes it confusing. >
> > > > > 
> > > > > > Since we're here, also make @len const since it's just sectorsize.
> > > > > 
> > > > > Please don't do that, adding const is fine when the line gets touched
> > > > > but otherwise adding it to an unrelated fix is not what I want to
> > > > > encourage.
> > > > 
