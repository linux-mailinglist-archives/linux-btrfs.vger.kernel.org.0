Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834BC629A10
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 14:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiKONZY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 08:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKONZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 08:25:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E71C15A21
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 05:25:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA63422510;
        Tue, 15 Nov 2022 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668518718;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X6OR6yBSGoDX90D6Dbj6XMsPaIiYD/PBsPga6KC909E=;
        b=M7llIyffwweC7ixrxidbepRvNbfnWj2UuuZ1151kcBRbXC1xEZC7kXku7hNV4/f/EYu3bP
        eu6qF/bqlgJhzoh6aiPKOGrUzXZdJ+M2OPIR5KfXEuw5uSGqkOY+dIJshznLAhNvKEGn3o
        Juvatey929hvJA5GvyGCET9XiGa9gIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668518718;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X6OR6yBSGoDX90D6Dbj6XMsPaIiYD/PBsPga6KC909E=;
        b=MFrmXCkY3kluEEcPAeRRdNMxr5AgNek65Vir03JseTcAVBnnKE0z/sx6jAUjz+X4C9m/K5
        9W/Oa2aZ49Zf6tBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB82713A91;
        Tue, 15 Nov 2022 13:25:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DqnRLD6Tc2P5YQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 15 Nov 2022 13:25:18 +0000
Date:   Tue, 15 Nov 2022 14:24:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: raid56: destructive RMW fix for RAID5 data
 profiles
Message-ID: <20221115132452.GH5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1668384746.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668384746.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 14, 2022 at 08:26:29AM +0800, Qu Wenruo wrote:
> [DESTRUCTIVE RMW]
> Btrfs (and generic) RAID56 is always vulnerable against destructive RMW.
> 
> Such destructive RMW can happen when one of the data stripe is
> corrupted, then a sub-stripe write into other data stripes happens, like
> the following:
> 
> 
>   Disk 1: data 1 |0x000000000000| <- Corrupted
>   Disk 2: data 2 |0x000000000000|
>   Disk 2: parity |0xffffffffffff|
> 
> In above case, if we write data into disk 2, we will got something like
> this:
> 
>   Disk 1: data 1 |0x000000000000| <- Corrupted
>   Disk 2: data 2 |0x000000000000| <- New '0x00' writes
>   Disk 2: parity |0x000000000000| <- New Parity.
> 
> Since the new parity is calculated using the new writes and the
> corrupted data, we lost the chance to recovery data stripe 1, and that
> corruption will forever be there.
...
> [TODO]
> - Iterate all RAID6 combinations
>   Currently we don't try all combinations of RAID6 during the repair.
>   Thus for RAID6 we treat it just like RAID5 in RMW.
> 
>   Currently the RAID6 recovery combination is only exhausted during
>   recovery path, relying on the caller the increase the mirror number.
> 
>   Can be implemented later for RMW path.
> 
> - Write back the repaired sectors
>   Currently we don't write back the repaired sectors, thus if we read
>   the corrupted sectors, we rely on the recover path, and since the new
>   parity is calculated using the recovered sectors, we can get the
>   correct data without any problem.
> 
>   But if we write back the repaired sectors during RMW, we can save the
>   reader some time without going into recovery path at all.
> 
>   This is just a performance optimization, thus I believe it can be
>   implemented later.

Even with the todo and potential performance drop due to mandatory
stripe caching I think this is worth merging at this point, so patches
are in misc-next now.

Regarding the perf drop, I'll try to get some results besides functional
testing but if anybody with a decent setup for raid5 can do some
destructive tests it would be most welcome.

Fallback plan is to revert the last patch if it turns out to be too
problematic.
