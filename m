Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CB053A636
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 15:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242664AbiFANwK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 09:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350631AbiFANwJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 09:52:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7750F1EAC1
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 06:52:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 369D821AD7;
        Wed,  1 Jun 2022 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654091527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=so1ngK1hZ+iJGF0hP+XNqxWeXAf5HPDpGsvk2tyRdvc=;
        b=t/pzsULfQcq02oh9Ek/28XxtatwggT7uoGqzYq/B1DeO1uiuMKKnOr7jdGZqreyXxyxDeF
        2PKKdJeJixwGVrPgVsEmdslD+lVWa1n6eWp8EJCTyVzZfl2Z1ROsxAtrixFI+OeKhp+lj8
        gdUG0ILKkfHwth0CKQzkETfz7Lwq+Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654091527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=so1ngK1hZ+iJGF0hP+XNqxWeXAf5HPDpGsvk2tyRdvc=;
        b=2Ew/cPSmk9LE/sHdylFGVmgooLE8DCJLyNWMdZfWHIewfAZsCiKo0F7yLuQRn9go2AJkIF
        nadouZKTCBYnioCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F3FF13A8F;
        Wed,  1 Jun 2022 13:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G7ObAgdvl2IXAwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Jun 2022 13:52:07 +0000
Date:   Wed, 1 Jun 2022 15:47:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update stripe_sectors[]->uptodate in steal_rbio
Message-ID: <20220601134740.GN20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <e7fce81204d47e527e3d6d34ebcd9c9a1b281533.1654062760.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7fce81204d47e527e3d6d34ebcd9c9a1b281533.1654062760.git.wqu@suse.com>
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

On Wed, Jun 01, 2022 at 01:54:28PM +0800, Qu Wenruo wrote:
> [BUG]
> With recent debug output patch, it turns out the following write
> sequence would cause extra read which is unnecessary:
> 
>   # xfs_io -f -s -c "pwrite -b 32k 0 32k" -c "pwrite -b 32k 32k 32k" \
> 		 -c "pwrite -b 32k 64k 32k" -c "pwrite -b 32k 96k 32k" \
> 		 $mnt/file
> 
> The debug message looks like this (btrfs header skipped):
> 
>  partial rmw, full stripe=389152768 opf=0x0 devid=3 type=1 offset=32768 physical=323059712 len=32768
>  partial rmw, full stripe=389152768 opf=0x0 devid=1 type=2 offset=0 physical=67174400 len=65536
>  full stripe rmw, full stripe=389152768 opf=0x1 devid=3 type=1 offset=0 physical=323026944 len=32768
>  full stripe rmw, full stripe=389152768 opf=0x1 devid=2 type=-1 offset=0 physical=323026944 len=32768
>  partial rmw, full stripe=298844160 opf=0x0 devid=1 type=1 offset=32768 physical=22052864 len=32768
>  partial rmw, full stripe=298844160 opf=0x0 devid=2 type=2 offset=0 physical=277872640 len=65536
>  full stripe rmw, full stripe=298844160 opf=0x1 devid=1 type=1 offset=0 physical=22020096 len=32768
>  full stripe rmw, full stripe=298844160 opf=0x1 devid=3 type=-1 offset=0 physical=277872640 len=32768
>  partial rmw, full stripe=389152768 opf=0x0 devid=3 type=1 offset=0 physical=323026944 len=32768
>  partial rmw, full stripe=389152768 opf=0x0 devid=1 type=2 offset=0 physical=67174400 len=65536
>  ^^^^
>   Still partial read, even 389152768 is already cached by the first.
>   write.
> 
>  full stripe rmw, full stripe=389152768 opf=0x1 devid=3 type=1 offset=32768 physical=323059712 len=32768
>  full stripe rmw, full stripe=389152768 opf=0x1 devid=2 type=-1 offset=32768 physical=323059712 len=32768
>  partial rmw, full stripe=298844160 opf=0x0 devid=1 type=1 offset=0 physical=22020096 len=32768
>  partial rmw, full stripe=298844160 opf=0x0 devid=2 type=2 offset=0 physical=277872640 len=65536
>  ^^^^
>   Still partial read for 298844160.
> 
>  full stripe rmw, full stripe=298844160 opf=0x1 devid=1 type=1 offset=32768 physical=22052864 len=32768
>  full stripe rmw, full stripe=298844160 opf=0x1 devid=3 type=-1 offset=32768 physical=277905408 len=32768
> 
> This means every 32K writes, even they are in the same full stripe,
> still trigger read for previously cached data.
> 
> This would cause extra RAID56 IO, making the btrfs raid56 cache useless.
> 
> [CAUSE]
> Commit d4e28d9b5f04 ("btrfs: raid56: make steal_rbio() subpage
> compatible") tries to make steal_rbio() subpage compatible, but during
> that conversion, there is one thing missing.
> 
> We no longer rely on PageUptodate(rbio->stripe_pages[i]), but
> rbio->stripe_nsectors[i].uptodate to determine if a sector is uptodate.
> 
> This means, previously if we switch the pointer, everything is done,
> as the PageUptodate flag is still bond to that page.
> 
> But now we have to manually mark the involved sectors uptodate, or later
> raid56_rmw_stripe() will find the stolen sector is not uptodate, and
> assemble the read bio for it, wasting IO.
> 
> [FIX]
> We can easily fix the bug, by also update the
> rbio->stripe_sectors[].uptodate in steal_rbio().
> 
> With this fixed, now the same write patter no longer leads to the same
> unnecessary read:
> 
>  partial rmw, full stripe=389152768 opf=0x0 devid=3 type=1 offset=32768 physical=323059712 len=32768
>  partial rmw, full stripe=389152768 opf=0x0 devid=1 type=2 offset=0 physical=67174400 len=65536
>  full stripe rmw, full stripe=389152768 opf=0x1 devid=3 type=1 offset=0 physical=323026944 len=32768
>  full stripe rmw, full stripe=389152768 opf=0x1 devid=2 type=-1 offset=0 physical=323026944 len=32768
>  partial rmw, full stripe=298844160 opf=0x0 devid=1 type=1 offset=32768 physical=22052864 len=32768
>  partial rmw, full stripe=298844160 opf=0x0 devid=2 type=2 offset=0 physical=277872640 len=65536
>  full stripe rmw, full stripe=298844160 opf=0x1 devid=1 type=1 offset=0 physical=22020096 len=32768
>  full stripe rmw, full stripe=298844160 opf=0x1 devid=3 type=-1 offset=0 physical=277872640 len=32768
>  ^^^ No more partial read, directly into the write path.
>  full stripe rmw, full stripe=389152768 opf=0x1 devid=3 type=1 offset=32768 physical=323059712 len=32768
>  full stripe rmw, full stripe=389152768 opf=0x1 devid=2 type=-1 offset=32768 physical=323059712 len=32768
>  full stripe rmw, full stripe=298844160 opf=0x1 devid=1 type=1 offset=32768 physical=22052864 len=32768
>  full stripe rmw, full stripe=298844160 opf=0x1 devid=3 type=-1 offset=32768 physical=277905408 len=32768
> 
> Fixes: d4e28d9b5f04 ("btrfs: raid56: make steal_rbio() subpage compatible")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
