Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AEC57A924
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 23:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbiGSVnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 17:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbiGSVnB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 17:43:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F24F6A2
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 14:43:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE1E833BFF;
        Tue, 19 Jul 2022 21:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658266977;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BWQqa+d3aS+BabcMKcyI5xEDHWZO5kuqXoQZ0VAMrNE=;
        b=r/Ff/mw8NYmMYPhpcAwtsGvTRDWQmWnYAnUw2ecUrk1+t6n1cBPSzvLYxFIvvembWj9I3C
        TjDTVeOGyUBEmAmU0yNhV6jRcaWyCnngybpI5stMNbNIekQmfEOmjL6cg/8RY7tFTHyqCf
        Kq+a2v3ZMcOy8X6EKT0s7YcX1GCv8oI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658266977;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BWQqa+d3aS+BabcMKcyI5xEDHWZO5kuqXoQZ0VAMrNE=;
        b=tpDOMaZh3zEvZlXPxBFVNCCydN3U0X2jg6gtkkGGZ58F/PShVERnuh+83IQaKcmb4aKJH3
        be1eah+XK04w3SBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCAB413488;
        Tue, 19 Jul 2022 21:42:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2IwkLWEl12IoGgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Jul 2022 21:42:57 +0000
Date:   Tue, 19 Jul 2022 23:38:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/4] btrfs: make __btrfs_dump_space_info() output
 better formatted
Message-ID: <20220719213804.GT13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <dc40ddc78b7173d757065dcdde910bcf593d3a5c.1658207325.git.wqu@suse.com>
 <a5321725-1667-fd6f-2bfd-8ddb7b78d038@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5321725-1667-fd6f-2bfd-8ddb7b78d038@dorminy.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 19, 2022 at 04:56:00PM -0400, Sweet Tea Dorminy wrote:
> On 7/19/22 01:11, Qu Wenruo wrote:
> > 
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index 36b466525318..623fa0488545 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -475,11 +475,15 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
> >   		   flag_str,
> >   		   (s64)(info->total_bytes - btrfs_space_info_used(info, true)),
> >   		   info->full ? "" : "not ");
> > -	btrfs_info(fs_info,
> > -		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu zone_unusable=%llu",
> > -		info->total_bytes, info->bytes_used, info->bytes_pinned,
> > -		info->bytes_reserved, info->bytes_may_use,
> > -		info->bytes_readonly, info->bytes_zone_unusable);
> > +	btrfs_info(fs_info, "  total:         %llu", info->total_bytes);
> > +	btrfs_info(fs_info, "  used:          %llu", info->bytes_used);
> > +	btrfs_info(fs_info, "  pinned:        %llu", info->bytes_pinned);
> > +	btrfs_info(fs_info, "  reserved:      %llu", info->bytes_reserved);
> > +	btrfs_info(fs_info, "  may_use:       %llu", info->bytes_may_use);
> > +	btrfs_info(fs_info, "  read_only:     %llu", info->bytes_readonly);
> > +	if (btrfs_is_zoned(fs_info))
> > +		btrfs_info(fs_info,
> > +			    "  zone_unusable: %llu", info->bytes_zone_unusable);
> 
> I'm (perhaps needlessly) worried about splitting this up into six/seven 
> messages, because of the ratelimiting rolled into btrfs_printk. The 
> ratelimit is 100 messages per 5 * HZ, and it seems like it would be 
> unfortunate if it kicked in during the middle of this dump and prevented 
> later info from being dumped.
> 
> Maybe we should add a btrfs_dump_printk() helper that doesn't have a 
> ratelimit built in, for exceptional cases like this where we really, 
> really don't want anything ratelimited?

Splitting the message is IMHO wrong thing, there are other subysystems
writing to the log so the lines can become scattered or interleaved with
the same message from other threads.

We should prefer single line messages if possible, if not only for
better grep-ability, pretty printing can be done by any utility that
parses the logs.

I did not think about the rate limiting, but you're right that it could
be problematic.
