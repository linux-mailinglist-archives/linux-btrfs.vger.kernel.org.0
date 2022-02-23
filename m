Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F704C17DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 16:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242504AbiBWP5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 10:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbiBWP5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 10:57:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB0A522D2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 07:56:51 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EC30C1F37D;
        Wed, 23 Feb 2022 15:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645631809;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJl2QUKd0J/CNcPXdb6tl7U8xAOrlcKDkTXBUgRGHiA=;
        b=soD1SNULMg5V6761C9W67lP7pQpRKf1NdGPEVCNj8s4KoF+nL5eKbMM/ftf0u11ILbc0GL
        l110ZrTemElDtusrYYIXwkGRv/CFgfH4PmKET6aH0qy8rylVxjt+ySVRBmXCP9DNH+we7Z
        jVKJbF0MHlPiJRVsTjmNldhRz46oRUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645631809;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJl2QUKd0J/CNcPXdb6tl7U8xAOrlcKDkTXBUgRGHiA=;
        b=ujhbrPOVQ20HuKWhGYrz2P1Fk7/tiwFTMauA1RHKZC/7+aRfZyn55cCTkZGIk1vhCBLibh
        VaCALc84+mA69iDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E3310A3B88;
        Wed, 23 Feb 2022 15:56:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 83142DA7F7; Wed, 23 Feb 2022 16:53:01 +0100 (CET)
Date:   Wed, 23 Feb 2022 16:53:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: autodefrag: only scan one inode once
Message-ID: <20220223155301.GP12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1644737297.git.wqu@suse.com>
 <7e33c57855a9d323be8f70123d365429a8463d7b.1644737297.git.wqu@suse.com>
 <20220222173202.GL12643@twin.jikos.cz>
 <64987622-6786-6a67-ffac-65dc92ea90d0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64987622-6786-6a67-ffac-65dc92ea90d0@gmx.com>
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

On Wed, Feb 23, 2022 at 07:42:05AM +0800, Qu Wenruo wrote:
> On 2022/2/23 01:32, David Sterba wrote:
> > On Sun, Feb 13, 2022 at 03:42:32PM +0800, Qu Wenruo wrote:
> > @@ -295,39 +265,29 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
> >   		goto cleanup;
> >   	}
> >
> > +	if (cur >= i_size_read(inode)) {
> > +		iput(inode);
> > +		break;
> 
> Would this even compile?
> Break without a while loop?

That was a typo, s/break/goto cleanup/.

> To me, the open-coded while loop using goto is even worse.
> I don't think just saving one indent is worthy.

Well for backport purposes the fix should be minimal and not necessarily
pretty. Indenting code produces a diff that replaces one blob with
another blob, with additional changes and increases line count, which is
one of the criteria for stable acceptance.

> Where can I find the final version to do more testing/review?

Now pushed to branch fix/autodefrag-io in my git repos, I've only
updated changelogs.
