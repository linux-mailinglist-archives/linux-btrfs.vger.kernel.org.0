Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7747E0046
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 11:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjKCG4t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 02:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjKCG4s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 02:56:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02B51BD
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 23:56:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224E4C433C8;
        Fri,  3 Nov 2023 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698994605;
        bh=gXZtlJJO0m0VCRUln3Vut2rUuEGepVckJih3S/2TJZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVkwcQSOi67LzNjQ82OqhP+JfqEXAC3bFpVVeiukbIiusGHCmURpgA9R/PtNT0vEr
         i3XXOwipCL+WQNk3NWSeU5Cjg6due2ukrbDWMFpkap/bRYGwfbWUPZ/4WqjdkRo0Nl
         uYEDo8vJ7/budZ49hsOWV3ywzBeJQ11WP+W1WSciIeFdWyWTjQ2wohVaFyf32d0lfG
         3T5Bef6svqPJf0AaBZRxydgW6Ks38GHVvKN+3R90kBgYRmRTp3GlM2CpGdlNCuPARh
         6FO40l9XfUlsOxP1FqKmQ4H6+TZ+1sUS6MnlrPG/ES1TuINnrscZf3lxf5gDvCTK6F
         WdB7e7KgQeoOg==
Date:   Fri, 3 Nov 2023 07:56:39 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231103-wichen-shrimps-1ddd9565d6a6@brauner>
References: <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-ankurbeln-eingearbeitet-cbeb018bfedc@brauner>
 <20231102123446.GA3305034@perftesting>
 <20231102170745.GF11264@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102170745.GF11264@suse.cz>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 02, 2023 at 06:07:45PM +0100, David Sterba wrote:
> On Thu, Nov 02, 2023 at 08:34:46AM -0400, Josef Bacik wrote:
> > On Thu, Nov 02, 2023 at 10:48:35AM +0100, Christian Brauner wrote:
> > > > We'll be converted to the new mount API tho, so I suppose that's something.
> > > > Thanks,
> > > 
> > > Just in case you forgot about it. I did send a patch to convert btrfs to
> > > the new mount api in June:
> > > 
> > > https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org
> > > 
> > 
> > Yeah Daan told me about this after I had done the bulk of the work.  I
> > shamelessly stole the dup idea, I had been doing something uglier.
> > 
> > > Can I ask you to please please copy just two things from that series:
> > > 
> > > (1) Please get rid of the second filesystems type.
> > > (2) Please fix the silent remount behavior when mounting a subvolume.
> > >
> > 
> > Yeah I've gotten rid of the second file system type, the remount thing is odd,
> > I'm going to see if I can get away with not bringing that over.  I *think* it's
> > because the standard distro way of doing things is to do
> > 
> > mount -o ro,subvol=/my/root/vol /
> > mount -o rw,subvol=/my/home/vol /home
> > <boot some more>
> > mount -o remount,rw /
> > 
> > but I haven't messed with it yet to see if it breaks.  That's on the list to
> > investigate today.  Thanks,
> 
> It's a use case for distros, 0723a0473fb4 ("btrfs: allow mounting btrfs
> subvolumes with different ro/rw options"), the functionality should
> be preserved else it's a regression.

My series explicitly made sure that it _isn't_ broken. Which is pretty
obvious from the description I put in there where that example is
explained at length.

It just handles it _cleanly_ through the new mount api while retaining
the behavior through the old mount api. The details - as Josef noted -
I've explained extensively.
