Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27F64EAC7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 13:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiC2Llm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbiC2Lll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 07:41:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09084201B5
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 04:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A884AB8172E
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 11:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3788C340ED;
        Tue, 29 Mar 2022 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648553996;
        bh=HIe1VZItBIcM5KLxYsyIRrzcXbPQ6HYP0d2w2plimJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnXcUQUN8NqVS1AqMykwdLJM/Mbtk4SYu2TTZkz63Ns3VRaHCnr/Lmj2A0AvOh2wP
         u7BLSQVtbryjE+5ZV745HsuJDhCL+ySW3FO767DlxsTBNpqQEQnCorcVOBJq5uRSgZ
         +cm03SXptGEzoMxmi7VM0YGAlQsiLXkgByJlT1mnW3RV9/Zbyrow3n0aWCRw2aaG49
         eUpv8ZC+nkPmVe+Pv2NK7RDsokTqFr5ontnw+ofCWd2srgU+Gg2S5BrrlM9H23HZy2
         3zia3a396PO7AxTAmbt5xpoOy0lRr/R7nk+oC3HXahoC/h9/Kwxjb06TLHDncC8NXP
         dX4BqhL9lD8mQ==
Date:   Tue, 29 Mar 2022 12:39:45 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Message-ID: <YkLwAf7SK95iOreD@debian9.Home>
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <20220328185121.GQ2237@twin.jikos.cz>
 <YkLYJ+xRvmm0yN9Y@debian9.Home>
 <ed81efec-0303-d152-a84d-74f4ff4f5058@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed81efec-0303-d152-a84d-74f4ff4f5058@gmx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 29, 2022 at 06:49:10PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/3/29 17:57, Filipe Manana wrote:
> > On Mon, Mar 28, 2022 at 08:51:21PM +0200, David Sterba wrote:
> > > On Fri, Mar 25, 2022 at 05:37:59PM +0800, Qu Wenruo wrote:
> > > > The original code is not really setting the memory to 0x00 but 0x01.
> > > > 
> > > > To prevent such problem from happening, use memzero_page() instead.
> > > 
> > > This should at least mention we think that setting it to 0 is right, as
> > > you call it wrong but give no hint why it's thought to be wrong.
> > 
> > My guess is that something different from zero makes it easier to spot
> > the problem in user space, as 0 is not uncommon (holes, prealloced extents)
> > and may get unnoticed by applications/users.
> 
> OK, that makes some sense.
> 
> But shouldn't user space tool get an -EIO directly?

It should.

But even if applications get -EIO, they may often ignore return values.
It's their fault, but if we can make it less likely that errors are not noticed,
the better. I think we all did often, ignore all or just some return values
from read(), write(), open(), etc.

One recent example is the MariaDB case with io-uring. They were reporting
corruption to the users, but the problem is that didn't properly check
return values, ignoring partial reads and treating them as success:

https://jira.mariadb.org/browse/MDEV-27900?focusedCommentId=216582&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-216582

The data was fine, not corrupted, they just didn't deal with partial reads
and then read the remaining data when a read returns less data than expected.



> 
> As the corrupted range won't have PageUptodate set anyway.
> 
> Thanks,
> Qu
> > 
> > I don't see a good reason to change this behaviour. Maybe it's just the
> > label name 'zeroit' that makes it confusing. >
> > > 
> > > > Since we're here, also make @len const since it's just sectorsize.
> > > 
> > > Please don't do that, adding const is fine when the line gets touched
> > > but otherwise adding it to an unrelated fix is not what I want to
> > > encourage.
> > 
