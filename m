Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10164EF7E7
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 18:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243721AbiDAQaL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 12:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347836AbiDAQ14 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 12:27:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CFD2F3B0;
        Fri,  1 Apr 2022 08:58:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A06F01FD00;
        Fri,  1 Apr 2022 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648828735;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhAtGdRSnzMlSPMcK6cQ4fm3keZyBBT8jVyV6htCkSA=;
        b=XYFKtOMxC1z7G48Ru9i9yaghtTen1k6QgMMoW1yDbTdRh2Mxk4rvCxEvOel1smUvC+c9ZJ
        mkw8hCV19Z1MK14DWbOUh0luB3JVBHboGye8d8wXYI6wGOAflZKJbyzQJLRv6t94VvSDBS
        batoXhMZrdBijBpsCxR4V2F5Cj0C5Mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648828735;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhAtGdRSnzMlSPMcK6cQ4fm3keZyBBT8jVyV6htCkSA=;
        b=BGqogJOxtfE3A31RcWCAOp27zO7LF4mbxSJJfGdpPI7m4+RiZx9t9EsWffvqPLCKmjGOII
        hW+lntlrcpaoVWCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 969D8A3B82;
        Fri,  1 Apr 2022 15:58:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82ED0DA7F3; Fri,  1 Apr 2022 17:54:56 +0200 (CEST)
Date:   Fri, 1 Apr 2022 17:54:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: fix possible use-after-free bug in error
 handling code of btrfs_get_root_ref()
Message-ID: <20220401155456.GL15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jia-Ju Bai <baijiaju1990@gmail.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220324134454.15192-1-baijiaju1990@gmail.com>
 <20220324181940.GK2237@suse.cz>
 <84720b1d-831e-4a2e-e2c5-4f20ac7bb778@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84720b1d-831e-4a2e-e2c5-4f20ac7bb778@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 25, 2022 at 04:04:17PM +0800, Jia-Ju Bai wrote:
> >> @@ -1850,9 +1850,10 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
> >>   
> >>   	ret = btrfs_insert_fs_root(fs_info, root);
> >>   	if (ret) {
> >> -		btrfs_put_root(root);
> >> -		if (ret == -EEXIST)
> >> +		if (ret == -EEXIST) {
> >> +			btrfs_put_root(root);
> > I think this fix is correct, though it's not that clear. If you look how
> > the code changed, there was the unconditional put and then followed by a
> > free:
> >
> > 8c38938c7bb0 ("btrfs: move the root freeing stuff into btrfs_put_root")
> >
> > Here it's putting twice where one will be the final free.
> >
> > And then the whole refcounting gets updated in
> >
> > 4785e24fa5d2 ("btrfs: don't take an extra root ref at allocation time")
> >
> > which could be removing the wrong put, I'm not yet sure.
> 
> Thanks for the reply!
> 
> I think the bug should be introduced by this commit:
> bc44d7c4b2b1 ("btrfs: push btrfs_grab_fs_root into btrfs_get_fs_root")
> 
> This commit has a change:
>       ret = btrfs_insert_fs_root(fs_info, root);
>       if (ret) {
> +      btrfs_put_fs_root(root);
>           if (ret == -EEXIST) {
>               btrfs_free_fs_root(root);
>               goto again;
>           }
> 
> I could add a Fixes tag of this commit in my V2 patch.
> Is it okay?

I can add it myself, that's a minor thing. The fix is correct, I've
rewritten the changelog a bit, patch now added to misc-next, thanks.
