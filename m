Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E40628AB4
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 21:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiKNUqP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 15:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbiKNUqN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 15:46:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B0C21A7;
        Mon, 14 Nov 2022 12:46:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 969AF202CF;
        Mon, 14 Nov 2022 20:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668458771;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wb4O7lLXD9XIPmsq/fgChivZD1DA6NsEAi7ItoReySI=;
        b=zV5n/LJkrjMApj9pcYixvHtBQxMhgst7PvBJhFMosUSFekJO3P93V557ZUEXHiNCeMp+tA
        a10oMsgDSNVLmKhNbiZngufxZqPiKw4b83sqPEk5ue9rbZOwPJ9EqaIyhaVepiNG76ukoJ
        Z5eq9SQAjr0T2HamFZViIhEvX9at2sQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668458771;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wb4O7lLXD9XIPmsq/fgChivZD1DA6NsEAi7ItoReySI=;
        b=KYC+LG7lwwa2agl/O+HdnbT1z24eFyUEJlZRIOmLHuTBubf7Eb3ArF/5lQLNMP3+5ELS0t
        GHmThhdyBf1XMJDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B57E13A92;
        Mon, 14 Nov 2022 20:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q3laEROpcmMzOwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 14 Nov 2022 20:46:11 +0000
Date:   Mon, 14 Nov 2022 21:45:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Li zeming <zeming@nfschina.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: volumes: Increase bioc pointer check
Message-ID: <20221114204545.GB5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221026013611.2900-1-zeming@nfschina.com>
 <26b65420-2609-26a5-9cc2-c12cabd310e0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b65420-2609-26a5-9cc2-c12cabd310e0@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 26, 2022 at 02:42:51PM +0800, Qu Wenruo wrote:
> On 2022/10/26 09:36, Li zeming wrote:
> > The __GFP_NOFAIL flag will cause memory to be allocated an infinite
> > number of times until the allocation is successful, but it is best to
> > use it only for very necessary code, and try not to use it.
> >
> > The alloc_btrfs_io_context function looks a little closer to normal
> > (excuse my analysis), but I think we can remove __GFP_NOFAIL from it and
> > add a bioc pointer allocation check that returns NULL if the allocation
> > fails.
> >
> > Signed-off-by: Li zeming <zeming@nfschina.com>
> > ---
> >   v2: Add annotation vocabulary modify, remove __GFP_NOFAIL flag.
> >   v3: Modifying the Description.
> >
> >   fs/btrfs/volumes.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 064ab2a79c80..b8d901f58995 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -5891,7 +5891,9 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
> >   		 * and the stripes.
> >   		 */
> >   		sizeof(u64) * (total_stripes),
> > -		GFP_NOFS|__GFP_NOFAIL);
> > +		GFP_NOFS);
> > +	if (!bioc)
> > +		return NULL;
> >
> >   	atomic_set(&bioc->error, 0);
> >   	refcount_set(&bioc->refs, 1);
> > @@ -6071,7 +6073,7 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
> >    * array of stripes.
> >    * For READ, it also needs to be supported using the same mirror number.
> >    *
> > - * If the requested block is not left of the left cursor, EIO is returned. This
> > + * If the requested block is not left of the left cursor, EIO should be returned. This
> 
> Is there any need for this change?
> 
> I don't think your patch has even touched the call chain of
> get_extra_mirror_from_replace().

That's maybe an accidental change, not relevant to the NOFAIL removal.
