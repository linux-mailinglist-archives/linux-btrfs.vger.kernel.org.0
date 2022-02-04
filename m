Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B1A4A9E76
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 18:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377266AbiBDR6d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 12:58:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55030 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377272AbiBDR63 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 12:58:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 208AF1F382;
        Fri,  4 Feb 2022 17:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643997508;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hdq2M29fYQmOqyheMFe7t2v48Fw9HkKJ87zKmX/4UlY=;
        b=GLQcBWItnixGzTjDqcKU0hz50V6ARsnKLYjQtWSTmI2BF94p2/iYEIHEorhqbHrtwMomne
        gg0T6licnkpB+gaFz3CUsSvOk3Lqtbf1AKyIvgYtn5iTEajQ963p2E1LPUpzohPrXTQvhs
        h7ytNLMyZHnKGeejWrRF5tIxXvIP8vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643997508;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hdq2M29fYQmOqyheMFe7t2v48Fw9HkKJ87zKmX/4UlY=;
        b=YV9WJAW5GLU8vnEGD4HzbtbymcuB316ULxRn0V5MGOF8mNs85TQ4S6CU/CZApWaZtbjdhb
        to+QrYvIh2zz3FCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 17EB6A3B83;
        Fri,  4 Feb 2022 17:58:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6B33BDA781; Fri,  4 Feb 2022 18:57:42 +0100 (CET)
Date:   Fri, 4 Feb 2022 18:57:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: defrag: use btrfs_defrag_ctrl to replace
 btrfs_ioctl_defrag_range_args for btrfs_defrag_file()
Message-ID: <20220204175742.GG14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1643357469.git.wqu@suse.com>
 <34c2aa1e7c5e196420d68de1f67b8973d49e284b.1643357469.git.wqu@suse.com>
 <YfwOJ0UT5t64BhVG@debian9.Home>
 <64316118-4f91-a277-d28a-24f74f2e6056@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64316118-4f91-a277-d28a-24f74f2e6056@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 04, 2022 at 08:30:01AM +0800, Qu Wenruo wrote:
> On 2022/2/4 01:17, Filipe Manana wrote:
> > On Fri, Jan 28, 2022 at 04:12:57PM +0800, Qu Wenruo wrote:
> >> --- a/fs/btrfs/file.c
> >> +++ b/fs/btrfs/file.c
> >> @@ -277,8 +277,7 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
> >>   {
> >>   	struct btrfs_root *inode_root;
> >>   	struct inode *inode;
> >> -	struct btrfs_ioctl_defrag_range_args range;
> >> -	int num_defrag;
> >> +	struct btrfs_defrag_ctrl ctrl = {};
> >
> > Most of the code base uses { 0 } for this type of initialization.
> > IIRC some compiler versions complained about {} and preferred the
> > version with 0.
> 
> Exactly what I preferred, but David mentioned that kernel is moving
> torwards {} thus I that's what I go.
> 
> > I think we should try to be consistent. Personally I find the 0 version
> > more clear. Though this might be bike shedding territory.

The preferred style is {} because { 0 } does not consistently initialize
the structures on all compilers. I can't find the mail/commit and
reasoning, if there's a pointer as the first member, then it gets
initialized (the 0 matches) but the rest of the structure is not
initialized.
