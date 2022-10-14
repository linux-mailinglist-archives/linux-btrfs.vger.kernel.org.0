Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF17B5FEDD2
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 14:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJNMIl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 08:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJNMIk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 08:08:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCF51BF204
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 05:08:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 699EC1F385;
        Fri, 14 Oct 2022 12:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665749318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWsXC5MfxUjSsSczFpdR37Q1Uiu0fCnLJjqff4aWOGI=;
        b=gDZdzFV0gJNWLwFLaNi2UKhdIQUmORYZ8VBOBP1F+x58ede/8v8XVZeTCUjqGO5G4hmeZb
        w0P9Zu47yYuEMxefb8GKV90PkjEGP0OvoEUMyICM04W2NvAWuWOAqpzZLGAZsAxW6IRij1
        u9D2efLICvxzhb2ZZVzpOSHTXFHxRBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665749318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWsXC5MfxUjSsSczFpdR37Q1Uiu0fCnLJjqff4aWOGI=;
        b=Xx3BtwvMHmBuJGEdBsY+7md1i1LtZKGDz1k2x9WI+sX8MBk8BVSZw+IM4nKGBYelODfwIe
        6q5zDymReNdd8tAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46AED13A4A;
        Fri, 14 Oct 2022 12:08:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XrNVEEZRSWMPfAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Oct 2022 12:08:38 +0000
Date:   Fri, 14 Oct 2022 14:08:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: make btrfs module init/exit match their
 sequence
Message-ID: <20221014120831.GF13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
 <63038e02-81fc-92b7-4e33-0a2c6c356698@oracle.com>
 <a2633456-dd2f-534c-6505-fa4c8121f3e5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2633456-dd2f-534c-6505-fa4c8121f3e5@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 13, 2022 at 02:44:49PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/10/13 14:03, Anand Jain wrote:
> >
> >> With this patch, init_btrfs_fs()/exit_btrfs_fs() will be much easier to
> >> expand and will always follow the strict order.
> >>
> >
> > Nice idea.
> >
> >
> >> -    btrfs_print_mod_info();
> > ::
> >> -    err = btrfs_run_sanity_tests();
> >
> > ::
> >
> >> +    }, {
> >> +        .init_func = btrfs_run_sanity_tests,
> >> +        .exit_func = NULL,
> >> +    }, {
> >> +        .init_func = btrfs_print_mod_info,
> >> +        .exit_func = NULL,
> >> +    }, {
> >
> >
> >   Is there any special reason to switch the order of calling for
> > sanity_tests() and mod_info()?
> 
> Mentioned in the commit message:
> 
> 
>    Only one modification in the order, now we call btrfs_print_mod_info()
>    after sanity checks.
>    As it makes no sense to print the mod into, and fail the sanity tests.

I find the order 1. mod info, 2. tests, OK. Once the subsystem
initialization finishes without problems the modinfo is printed and then
the self tests start rolling. It's probably a cosmetic change but unless
there's a clear reason to change it I'd rather keep it as is.
