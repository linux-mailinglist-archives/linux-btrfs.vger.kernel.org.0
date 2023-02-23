Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249DC6A1192
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 22:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBWVB4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 16:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBWVBz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 16:01:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABD75C162
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 13:01:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD3171FE3A;
        Thu, 23 Feb 2023 21:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677186112;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sM2fw/2XEX0PqSdcSzA/sE1rCndrdjChszQGoRakBHo=;
        b=XTnFFwyhXN2WkNUSlN8owAZ7GYkhER0d3jcQg++5svSou5GUPa9689Yt4qU4IkuKg2hoTZ
        3th0Qc5yLZb64a3WIBG2HoPmTORLqzO1XZ4tn67OilHFtKWt2cDLMoJ4RmeMpe+gOsROJR
        Po+MGhTfBlqX7lJf1140oPc46m4k+EI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677186112;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sM2fw/2XEX0PqSdcSzA/sE1rCndrdjChszQGoRakBHo=;
        b=WxOL8HELT25fD/bt0TmIg4mvKnons09Idz4r0NlVPi73xaojLy4jSebIN27ZKaXvsfy3ID
        wBRyFrMlbdoJfWBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7516813928;
        Thu, 23 Feb 2023 21:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vpqfG0DU92MmawAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Feb 2023 21:01:52 +0000
Date:   Thu, 23 Feb 2023 21:55:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/4] btrfs: small improvement for btrfs_io_context
 structure
Message-ID: <20230223205555.GB10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1675743217.git.wqu@suse.com>
 <63c3c509ec42d83e8038b33e2f21e036c591fe0b.1675743217.git.wqu@suse.com>
 <20230215200209.GV28288@twin.jikos.cz>
 <0a9aba30-0037-4947-c619-a877b473cd47@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a9aba30-0037-4947-c619-a877b473cd47@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 17, 2023 at 01:03:28PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/2/16 04:02, David Sterba wrote:
> > On Tue, Feb 07, 2023 at 12:26:13PM +0800, Qu Wenruo wrote:
> >> That structure is our ultimate objective for all __btrfs_map_block()
> >> related functions.
> >>
> >> We have some hard to understand members, like tgtdev_map, but without
> >> any comments.
> >>
> >> This patch will improve the situation by:
> >>
> >> - Add extra comments for num_stripes, mirror_num, num_tgtdevs and
> >>    tgtdev_map[]
> >>    Especially for the last two members, add a dedicated (thus very long)
> >>    comments for them, with example to explain it.
> >>
> >> - Shrink those int members to u16.
> >>    In fact our on-disk format is only using u16 for num_stripes, thus
> >>    no need to go int at all.
> > 
> > Note that u16 is maybe good for space saving in structures but otherwise
> > it's a type that's a bit clumsy for CPU to handle. Int for passing it
> > around does not require masking or other sorts of conversions when
> > there's arithmetic done. This can be cleaned up later with close
> > inspection of the effects, so far we have u16 for fs_info::csum_type or
> > some item lengths.
> 
> I'm not sure if the extra masking for CPU is a big deal.

It's a microoptimization so it's always a question if it's worth or not.
More instructions to do the same thing fill the i-cache and on hot paths
it counts. We have a lot of IO in btrfs code so we are not focused on
such things. In this case I don't want to let us use u16 freely as it's
not a native type and any operation on the data will lead to asm code
bloat here and there.

I measure size of final .ko object for many patches to see effects of
various changes and the size tendency is going upward. This over time
makes the code less effective regarding CPU.

> If the compiler choose to do extra padding and not saving much space, 
> I'll still stick to u16.
> 
>  From my recent learning on Rust, one of the best practice is the strong 
> size limits on their variables.
> For a lot of usages, we shouldn't really need to 32bit values, and in 
> that case, I strongly prefer narrower variables.

I'd prefer to keep using native CPU types so that the narrow types are
in structures either memory or disk but the calculations done in natural
types and then checked for eventual overflows, instead of hoping that
silent overflows won't affect.

> If there is a better way to let compiler do 32bit operations while still 
> do a u16 size limits, I'm pretty happy to follow.

read u16 -> int/u32 -> do the calculations -> check/assert -> write back
to u16

We have do that explicitly for validaing input, that rust does something
else won't help us.

> Otherwise I think the extra CPU time (if any) is still worthy for a more 
> explicit size limit.

Yeah it's not directly measurable and would depend on other things like
cachelines an internal CPU state at the time of executing but my point
is to think about such changes and not let inefficiencies silently creep
in.
