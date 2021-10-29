Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0676E440003
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhJ2QGE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 12:06:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42270 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2QGD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 12:06:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0CF5021979;
        Fri, 29 Oct 2021 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635523414;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sw3zdEN9nfFPtZag7wthC6B16S94bC/1qnJjoOZVqSM=;
        b=MVt9rRWrCymIg1t6VClbeIEVDmdDjhVvXUStRRpauLAemsHpV1bJ6XNEPbOjDhD7g3azKz
        sacntX942ZEyFbU4lKK3SYezTMQg9mCEH8DGFG2KPbFpNCvyNQh2gQloDiPK5M8+HzaKRu
        WIxCG58L2Dzp6N8ZRk3uzO0vEQgNLKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635523414;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sw3zdEN9nfFPtZag7wthC6B16S94bC/1qnJjoOZVqSM=;
        b=PYK8zxHICMpz3Qzv9nJkSWschrxBRe47jcNpDxMr9ZxI6h0eFVL00T9zlLUNYZl9XPYtEH
        wsa6Wc/swsX9C/Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F3C58A3B84;
        Fri, 29 Oct 2021 16:03:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E4CD9DA7A9; Fri, 29 Oct 2021 18:03:00 +0200 (CEST)
Date:   Fri, 29 Oct 2021 18:03:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        osandov@osandov.com, nborisov@suse.com
Subject: Re: [PATCH v2] btrfs: send: prepare for v2 protocol
Message-ID: <20211029160300.GF20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        osandov@osandov.com, nborisov@suse.com
References: <20211022145336.29711-1-dsterba@suse.com>
 <72708fe4-5886-8814-f5e2-3c1dbf523965@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72708fe4-5886-8814-f5e2-3c1dbf523965@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 27, 2021 at 03:17:46PM +0800, Anand Jain wrote:
> On 22/10/2021 22:53, David Sterba wrote:
> > --- a/fs/btrfs/send.h
> > +++ b/fs/btrfs/send.h
> > @@ -48,6 +48,7 @@ struct btrfs_tlv_header {
> >   enum btrfs_send_cmd {
> >   	BTRFS_SEND_C_UNSPEC,
> >   
> > +	/* Version 1 */
> >   	BTRFS_SEND_C_SUBVOL,
> >   	BTRFS_SEND_C_SNAPSHOT,
> >   
> > @@ -76,6 +77,12 @@ enum btrfs_send_cmd {
> >   
> >   	BTRFS_SEND_C_END,
> >   	BTRFS_SEND_C_UPDATE_EXTENT,
> > +	__BTRFS_SEND_C_MAX_V1,
> > +
> > +	/* Version 2 */
> > +	__BTRFS_SEND_C_MAX_V2,
> > +
> 
>   Isn't this has to be in tandem with BTRFS_SEND_STREAM_VERSION == 2?

The patch is only preparatory and adds the base code for the real
protocol updates where the STREAM_VERSION will be increased, but does
not do that yet so we don't falsely advertise v2 support when there's no
such thing.

>   The changelog doesn't explain the plan of __BTRFS_SEND_C_MAX_Vx use case.

It's supposed to prevent doubts and questions "what should I do when I
want to add v2 command" and make the code ready for anybody working on
the v2 update.
