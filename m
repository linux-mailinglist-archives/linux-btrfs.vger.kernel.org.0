Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AC074282A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 16:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjF2OUC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 10:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjF2OTv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 10:19:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7730113D
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 07:19:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 28B301F8BE;
        Thu, 29 Jun 2023 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688048389;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vv/env6PqDK7d+JkfZAgl2FL5Gov9GjeUwekpsS6vkc=;
        b=BHC1p0JRSz+yj74y3CynklCx2c49dhARGEnR+XzQ3X/sc8/lqmSx1BC7GAjNUUVpfSm+BN
        dLnTNw9sHifCyT+Em3/xLoMQAdFEFqOXZ6iDeILzETEvGUtjR4dJkBtN/DuAPkEHCah30e
        LB7UIU4vIHpEvFnIXiYf2MDnT+Lu/+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688048389;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vv/env6PqDK7d+JkfZAgl2FL5Gov9GjeUwekpsS6vkc=;
        b=Aw5EfUTX5fTcnhejLMPcdZz720T1s162y4PWCk97OcO//HZ8vbUI6cxVd97qY7aoiyto2C
        YZKMCDrWa9aaXNAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAAE113905;
        Thu, 29 Jun 2023 14:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id naLMNwSTnWTeEwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Jun 2023 14:19:48 +0000
Date:   Thu, 29 Jun 2023 16:13:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: remove unused btrfs_path in
 scrub_simple_mirror()
Message-ID: <20230629141320.GI16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9a09b2850b25de2eb9142d95bcdb1b46ff0207af.1686724789.git.wqu@suse.com>
 <20230614163357.GN13486@twin.jikos.cz>
 <2770a5b7-1101-b3a3-0824-3ab40c694f35@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2770a5b7-1101-b3a3-0824-3ab40c694f35@gmx.com>
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

On Tue, Jun 27, 2023 at 01:20:49PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/6/15 00:33, David Sterba wrote:
> > On Wed, Jun 14, 2023 at 02:39:55PM +0800, Qu Wenruo wrote:
> >> The @path in scrub_simple_mirror() is no longer utilized after commit
> >> e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe
> >> infrastructure").
> >>
> >> Before that commit, we call find_first_extent_item() directly, which
> >> needs a path and that path can be reused.
> >>
> >> But after that switch commit, the extent search is done inside
> >> queue_scrub_stripe(), which will no longer accept a path from outside.
> >>
> >> So the @path variable can be removed safed.
> >>
> >> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > Added to misc-next, thanks.
> 
> BTW, I didn't see the patch merged in misc-next nor in the latest 6.5
> pull request.
> 
> Is it missing by somehow?

Yes it got accidentaly lost, I don't know where. This could happen when
I'm rebasing branches and pick the wrong reference commit. Now added
back, thanks.
