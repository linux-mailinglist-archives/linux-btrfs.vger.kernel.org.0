Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09F6E1255
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 18:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDMQcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 12:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDMQcy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 12:32:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605B08A78
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 09:32:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C458B1FD6C;
        Thu, 13 Apr 2023 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681403571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YMZuEnB3i2vvSbRREhlTKmltYc3s5iskWm6Vif3GZew=;
        b=3Fr4ddTyN7jXCz80Hu3LiXUxIPIz6sgqKRxwobQNVPPKUdsKqXGTKl1PHgPHtfVbSFZuMy
        5F8c+jcl8lirEU2CQx8+xoovZgq+KYpBLmlUn9TWBgKdpdMgxEkZejs/alfQdTDrszpBjO
        HKxsgyo7az9gA1wWsighLdJVmpAegbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681403571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YMZuEnB3i2vvSbRREhlTKmltYc3s5iskWm6Vif3GZew=;
        b=CdgU1qPVZ8kTB3QHKp7OeD6tshYAGAI6PKg0rwOOKh8W9hAE7wXaHnFqyakBuqUMw8X3qi
        7ltnDeEbtHav5JAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95CFC13421;
        Thu, 13 Apr 2023 16:32:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hqyeI7MuOGQsewAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Apr 2023 16:32:51 +0000
Date:   Thu, 13 Apr 2023 18:32:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: mkfs: make -R|--runtime-features option
 deprecated
Message-ID: <20230413163245.GH19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681180159.git.wqu@suse.com>
 <1ca85433fb63d9c9cf66da72e407381c0146b76c.1681180159.git.wqu@suse.com>
 <4a280a4c-5c84-8ecc-5dc3-4258ecb6eaf5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a280a4c-5c84-8ecc-5dc3-4258ecb6eaf5@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 13, 2023 at 05:34:31PM +0530, Anand Jain wrote:
> On 4/11/23 08:01, Qu Wenruo wrote:
> > deprecated.
> > 
> > For now we still keep the old option as for compatibility purposes.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >   Documentation/mkfs.btrfs.rst | 25 ++++---------------------
> >   common/fsfeatures.c          |  6 ------
> >   mkfs/main.c                  |  3 ++-
> >   3 files changed, 6 insertions(+), 28 deletions(-)
> > 
> > diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
> > index ba7227b31f72..e80f4c5c83ee 100644
> > --- a/Documentation/mkfs.btrfs.rst
> > +++ b/Documentation/mkfs.btrfs.rst
> > @@ -161,18 +161,6 @@ OPTIONS
> >   
> >                   $ mkfs.btrfs -O list-all
> >   
> > --R|--runtime-features <feature1>[,<feature2>...]
> > -        A list of features that be can enabled at mkfs time,
> 
> 
> > otherwise would have
> > -        to be turned on on a mounted filesystem.
> 
>   --R option is useful, why not consider rename?

For what use case is it useful? The reason it's getting dropped is
because from user perspective it's not that important what kind of
feature is it and it gets enabled from one place. It was my idea to have
two options because other mkfs utilities have that, but with a different
semantics than mkfs-time/mount-time, rather per object type (inode,
journal, ...), and it turned out to be wrong.

> Such as:
>   --mount-with

In the context of mkfs I'd find such option very confusing especially
when there's no mount option like that.
