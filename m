Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8AB6F126B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 09:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbjD1HfG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 03:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjD1HfF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 03:35:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C5F26B9;
        Fri, 28 Apr 2023 00:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6797161050;
        Fri, 28 Apr 2023 07:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A17C433EF;
        Fri, 28 Apr 2023 07:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682667301;
        bh=HtXEKyZ+SeW3yKVP526Ucm0QpU6JFEOGDSj9KpDTkVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XrxdkVhL0B+9dFgyS5EtFVko1FawTCdRD9Ijs1CjYMg9NTmMBYlMCIqzfyn/fLok5
         tj7Mq1NRwYV8S6HpYNlgVP/mk6Y79wEFWGPzeoYwaUC0IYrOKleHxnngKLGbhaeU2b
         nzaayA78kjvuBx+G91MQovDZVoTjzwamOFSXXzpE=
Date:   Fri, 28 Apr 2023 09:34:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     David Sterba <dsterba@suse.cz>, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Memet <zxce3@gnuweeb.org>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [GIT PULL] Btrfs updates for 6.3
Message-ID: <2023042839-cube-snowflake-0721@gregkh>
References: <cover.1676908729.git.dsterba@suse.com>
 <CAHk-=wh6-qpZ=yzseD_CQn8Gc+nGDLrufFxSFvVO2qK6+8fGUw@mail.gmail.com>
 <4b35f3a4-9972-b7f0-287f-165a817c0f73@gnuweeb.org>
 <20230425145412.GC19619@suse.cz>
 <ZEs6Mnx0s/siIZwv@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEs6Mnx0s/siIZwv@biznet-home.integral.gnuweeb.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 28, 2023 at 10:14:58AM +0700, Ammar Faizi wrote:
> On Tue, Apr 25, 2023 at 04:54:12PM +0200, David Sterba wrote:
> > On Sun, Apr 23, 2023 at 09:27:30AM +0700, Ammar Faizi wrote:
> > > On 2/21/23 4:02 AM, Linus Torvalds wrote:
> > > > On Mon, Feb 20, 2023 at 11:26 AM David Sterba <dsterba@suse.com> wrote:
> > > >> Other:
> > > >>
> > > >> - locally enable -Wmaybe-uninitialized after fixing all warnings
> > > > 
> > > > I've pulled this, but I strongly suspect this change will get reverted.
> > > > 
> > > > I bet neither you nor linux-next is testing even _remotely_ a big
> > > > chunk of the different compiler versions that are out there, and the
> > > > reason flags like '-Wmaybe-uninitialized' get undone is because some
> > > > random compiler version on some random config and target archiecture
> > > > gives completely nonsensical warnings for odd reasons.
> > > > 
> > > > But hey, maybe the btrfs code is special.
> > > 
> > > Maybe it's too late for 6.3. So please fix this in 6.4 and backport it to
> > > 6.3 stable.
> > 
> > Fix for this warning is in 6.4 pull request, there's no CC:stable tag
> > but we can ask to add it once the code lands in master.
> 
> It landed in master.
> 
> [ Adding stable team to the Cc list ]
> 
> Hi Greg and stable team, could you please backport:
> 
>   commit 8ba7d5f5ba931be68a94b8c91bcced1622934e7a upstream
>   ("btrfs: fix uninitialized variable warnings")
> 
> to v6.3 to fix gcc (10, 9, 7) build error?
> 
> The fs/btrfs/volumes.c hunk won't apply cleanly, but it can auto-merge:
> 
>   $ git cherry-pick 8ba7d5f5ba931be68a94b8c91bcced1622934e7a
>   Auto-merging fs/btrfs/volumes.c
>   [detached HEAD 572410288a1070c1] btrfs: fix uninitialized variable warnings
>    Author: Genjian Zhang <zhanggenjian@kylinos.cn>
>    Date: Fri Mar 24 10:08:38 2023 +0800
>    2 files changed, 2 insertions(+), 2 deletions(-)

Now queued up, thanks.

greg k-h
