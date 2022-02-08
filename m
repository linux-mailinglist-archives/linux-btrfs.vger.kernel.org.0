Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB6A4ADEDF
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 18:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383684AbiBHRE2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 12:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244599AbiBHRE1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 12:04:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36FCC061578
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 09:04:25 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF33F210F0;
        Tue,  8 Feb 2022 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644339864;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aeb3/KYcoY6pFY2+sbCNf0TbDfLbAxtKSfjNG49Xz88=;
        b=CVgdKsNmzgc9ckhh8KQvz+1JUPshIqri5Abk4lALsbhA6NVXXq7QOze5/csbD1pG74XU/V
        LgRvqnvtmV8tkDvJvWZ5sH5LChhfKcKhJckMMhQl3Zh95n5wy2Xp1YWT+2lnIzU8JMGAr2
        WUZBej5d+V7Nw/ZXD4K1UcgZsERX6MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644339864;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aeb3/KYcoY6pFY2+sbCNf0TbDfLbAxtKSfjNG49Xz88=;
        b=aBlTlwMyF7HG733OscaVRW4I4hNrWAY3s5e5eZqTpqSokdzHyDgLmoso4XWr16+ziiSQuY
        xFQLolR/BJ+ELfCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A2CD5A3B89;
        Tue,  8 Feb 2022 17:04:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 530CADAB3F; Tue,  8 Feb 2022 18:00:44 +0100 (CET)
Date:   Tue, 8 Feb 2022 18:00:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: defrag: use btrfs_defrag_ctrl to replace
 btrfs_ioctl_defrag_range_args for btrfs_defrag_file()
Message-ID: <20220208170044.GD12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1643357469.git.wqu@suse.com>
 <34c2aa1e7c5e196420d68de1f67b8973d49e284b.1643357469.git.wqu@suse.com>
 <YfwOJ0UT5t64BhVG@debian9.Home>
 <64316118-4f91-a277-d28a-24f74f2e6056@gmx.com>
 <20220204175742.GG14046@twin.jikos.cz>
 <20220204180031.GH14046@twin.jikos.cz>
 <20220204181707.GI14046@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204181707.GI14046@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 04, 2022 at 07:17:07PM +0100, David Sterba wrote:
> > > > >> --- a/fs/btrfs/file.c
> > > > >> +++ b/fs/btrfs/file.c
> > > > >> @@ -277,8 +277,7 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
> > > > >>   {
> > > > >>   	struct btrfs_root *inode_root;
> > > > >>   	struct inode *inode;
> > > > >> -	struct btrfs_ioctl_defrag_range_args range;
> > > > >> -	int num_defrag;
> > > > >> +	struct btrfs_defrag_ctrl ctrl = {};
> > > > >
> > > > > Most of the code base uses { 0 } for this type of initialization.
> > > > > IIRC some compiler versions complained about {} and preferred the
> > > > > version with 0.
> > > > 
> > > > Exactly what I preferred, but David mentioned that kernel is moving
> > > > torwards {} thus I that's what I go.
> > > > 
> > > > > I think we should try to be consistent. Personally I find the 0 version
> > > > > more clear. Though this might be bike shedding territory.
> > > 
> > > The preferred style is {} because { 0 } does not consistently initialize
> > > the structures on all compilers. I can't find the mail/commit and
> > > reasoning, if there's a pointer as the first member, then it gets
> > > initialized (the 0 matches) but the rest of the structure is not
> > > initialized.
> > 
> > I thought we've had all the { 0 } converted to {} but no so I get the
> > consistency agrument.
> 
> https://lore.kernel.org/all/20210910225207.3272766-1-keescook@chromium.org/
> 
> A tree-wide change but it did not get pulled in the end. The problematic
> compiler was gcc 4.9 but the current minimum requirement is 5.1 so I
> wonder how much relevant it is.

I've asked Kees, seems that the conversion is not necessary. Thus, I'd
stay with { 0 } that we have now as it's the most used initializer.

No need to resend patches just if there's {}, I'll fix it up anywhere I
see it.
