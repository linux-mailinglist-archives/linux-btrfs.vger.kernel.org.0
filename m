Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB64A6065EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 18:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiJTQf1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 12:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJTQfZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 12:35:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA22263B
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 09:35:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 069CA22414;
        Thu, 20 Oct 2022 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666283723;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aEUSjDEXGSdASOrUbHf3UQBppW92v5t3hy/TwG5hkVM=;
        b=q7GIluKbBoM/5VTNtWgT1Q8r2dUzwAtBp7Xh1wG9KmrIMSU21kCHlL3pHL6rmxSSDr2oMK
        brfOfX2Md6mpb2J9ITSUMUckkduO7ZQpulg59/vFEDADRrn5OzGV3BLrZqx3nrSbNAw2EL
        6Dpk+jNRlvvjbt2DOWBQ7OsOIq42ipM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666283723;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aEUSjDEXGSdASOrUbHf3UQBppW92v5t3hy/TwG5hkVM=;
        b=b6b2kVSXcCKJo4wnS+yN1qwI3HIzfpM+IIi79qxXZoJw1nipGxByJx2wZsd209t1F/oQuP
        cfdBd0zrQV066WBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCF9613494;
        Thu, 20 Oct 2022 16:35:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2pAiMcp4UWPmKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Oct 2022 16:35:22 +0000
Date:   Thu, 20 Oct 2022 18:35:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: switch GFP_NOFS to GFP_KERNEL in
 scrub_setup_recheck_block
Message-ID: <20221020163511.GM13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1666103172.git.dsterba@suse.com>
 <aed6063361919c409c72b208d361be0a5d094b3a.1666103172.git.dsterba@suse.com>
 <d21439a6-1adf-50ff-c409-b87ef87f54c8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21439a6-1adf-50ff-c409-b87ef87f54c8@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 20, 2022 at 03:27:31PM +0800, Anand Jain wrote:
> On 18/10/2022 22:27, David Sterba wrote:
> > There's only one caller that calls scrub_setup_recheck_block in the
> > memalloc_nofs_save/_restore protection so it's effectively already
> > GFP_NOFS and it's safe to use GFP_KERNEL.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/scrub.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> > index 9e3b2e60e571..2fc70a2cc7fe 100644
> > --- a/fs/btrfs/scrub.c
> > +++ b/fs/btrfs/scrub.c
> > @@ -1491,7 +1491,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
> >   			return -EIO;
> >   		}
> >   
> > -		recover = kzalloc(sizeof(struct scrub_recover), GFP_NOFS);
> > +		recover = kzalloc(sizeof(struct scrub_recover), GFP_KERNEL);
> 
> 
> I didn't get why GFP_KERNEL is better here, or would it make any 
> difference, given that we are already (and rightly) in the 
> memalloc_nofs_save() scope.

You said what's the reason, so I can only repeat the patterns:

1) plain GFP_NOFS, with notice that it does not work with kvalloc
2) memalloc_nofs_save/k.alloc(GFP_KERNEL)/memalloc_nofs_restore

I.e. GFP_NOFS in the memalloc_nofs_ protection is redundant because we
get th NOFS protection and can safely use GFP_KERNEL. Because we want to
minimize use of GFP_NOFS or completely switch to scoped nofs, but this
requires other changes and we do that incrementally.
