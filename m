Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359724EAE0F
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 15:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiC2NEU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 09:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiC2NET (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 09:04:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A66D76FE
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 06:02:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A0E821FBB7;
        Tue, 29 Mar 2022 13:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648558955;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PxzK2EaMugaZMvJn7BV0SQo7A6LZ/KQizq0o3L/nOxY=;
        b=yFAya+h61GbNM40CLUfCyasBuUyFVyGN8T+AG+hNrcGG/KhPwvXs7GQ9NmQocrACyEH4p2
        kjI8/FTDz4Aec5hm3LzX4y0HP/VtIMKTZnXWbM9yzcWZ7FosAI/RLwXqUutRjildgPCQzY
        1GmlhIjJ1M8xYGarWYtC2yFZWcptSIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648558955;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PxzK2EaMugaZMvJn7BV0SQo7A6LZ/KQizq0o3L/nOxY=;
        b=svhmA5+xpAS4C48lQ/9Glbkna/0b+k0k0BeHW3cSAEzArEeczVqg2omFPMXmuOKI2uWuHh
        Nc3BhzflwLkFakCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 96DACA3B83;
        Tue, 29 Mar 2022 13:02:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2FDA9DA7F3; Tue, 29 Mar 2022 14:58:38 +0200 (CEST)
Date:   Tue, 29 Mar 2022 14:58:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Matt Corallo <blnxfsl@bluematt.me>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [5.16.14] csum mismatch on free space cache on subpage
Message-ID: <20220329125838.GX2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Matt Corallo <blnxfsl@bluematt.me>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <61aa27d1-30fc-c1a9-f0f4-9df544395ec3@bluematt.me>
 <9e32aa01-c712-1def-6d54-1db450fd2750@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e32aa01-c712-1def-6d54-1db450fd2750@gmx.com>
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

On Tue, Mar 29, 2022 at 01:57:18PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/3/29 05:18, Matt Corallo wrote:
> > Basically what the subject says. Any time I mount an fs on my 64K-page
> > PPC host mount a 4K-page device (so far two-of-two - once a flash drive
> > with mirror and nothing else, once a many-TB volume across multiple
> > disks) I see a stream of csum mismatches in the space cache in dmesg.
> > The FS' otherwise seem to work.
> >
> > Matt
> 
> Oh, so you're using the subpage feature recently introduced, awesome!
> 
> But it looks like there are still some v1 cache code using hardcoded
> PAGE_SIZE instead of sectorsize, thus it's reporting the problem.
> 
> You're completely fine to continue using the fs, as such PAGE_SIZE usage
> will invalidate all old cache, thus there is no chance of corruption.
> 
> Or you can convert to v2 cache as a workaround.
> 
> I'll need to investigate some time for this fix.

We can mandate free space tree for subpage, don't try to fix the v1 code
as it's going to be deleted in a year timeframe anyway.
