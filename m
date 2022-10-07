Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B865F7C7D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 19:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiJGRvK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 13:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJGRvI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 13:51:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD90D25AE
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 10:51:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E36D12197F;
        Fri,  7 Oct 2022 17:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665165064;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=47rlIPCqoJoMOarIuulXh1QmiD1yUktP0wJ0IFfi8cM=;
        b=r5q+rADhk0XLMEmV1vQXc8laDeQbLxJ9zTgMpa+CVYS4JcgJiIB3QCMa0YJnZR3fyhNUTC
        RrhUvKc6KCPuwDwmqHG7yX6IdRmxwfdvG0k+HiTgoX1ceRqmHelCOg14hRBOWHdakFi9U0
        1x/tzLid4TR5SH4mamoPbf3+HvSTWOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665165064;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=47rlIPCqoJoMOarIuulXh1QmiD1yUktP0wJ0IFfi8cM=;
        b=9S8kl0zHQbpbxGux3iHC3RE5Fe89wbVpbvRNlfMmjgOeEkaLV3zLj5ukhQ/mgnOInyFksv
        V0wOR6EslDcUu1Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A85AA13A9A;
        Fri,  7 Oct 2022 17:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OxfYJwhnQGPnYQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 07 Oct 2022 17:51:04 +0000
Date:   Fri, 7 Oct 2022 19:51:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 00/17] btrfs: initial ctree.h cleanups, simple stuff
Message-ID: <20221007175101.GC13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663167823.git.josef@toxicpanda.com>
 <1f65c1a8-8d08-6aff-1764-b2549f195183@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f65c1a8-8d08-6aff-1764-b2549f195183@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 15, 2022 at 05:47:59PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/9/14 23:06, Josef Bacik wrote:
> > Hello,
> > 
> > This is the first part in what will probably be very many parts in my work to
> > cleanup ctree.h.  These are the smaller changes, mostly removing code that's not
> > used anymore, moving some stuff that's local to C files that don't need to be in
> > the header at all, and moving the rest of the on-disk definition stuff to
> > btrfs_tree.h.  There's a lot of patche here, but they're all relatively small,
> > the largest being the patch to move the on-disk definitions to btrfs_tree.h,
> > which is not very large compared to patches in the next several series.  This
> > has been built and tested, it's relatively low risk.  Thanks,
> 
> Looks good overall to me.
> 
> Just 3 small points of concern:
> 
> - About btrfs_tree.h usage.
> 
>    Really hope David can make it clear that, that UAPI header is for ALL
>    on-disk format definition.
> 
>    I'm not buying the old reason that the UAPI header is only for tree
>    search ioctl, and really want to move the whole super block definition
>    into UAPI header.

I have merged the patch but am expecting problems once people start
using the headers. I'll be addressed case by case.

>    (And I also think all upstream fses should have a concentrated UAPI
>     header too, just to make new comers easier to hack)
> 
> - Some tiny inline functions got unexported
> 
>    May not be a big thing though, just want to make sure we have no other
>    choice but make them uninlined.

This depends, trivial functions or where it's on a hot path it's better
to keep inline.

> 
> - Extra error tags in init_btrfs_fs()
                ^^^^
                labels

>    Just like open_ctree(), it's when but not whether to have wrong jump.
>    Thus a new series to make those cachep related exit function
>    conditional. (aka, we can call them unconditionally at error path)

You've sent the series that converts it to the array and we're going to
it that way. Please refresh the series as there were some minor changes
to the init/exit functions and resend. Thanks.
