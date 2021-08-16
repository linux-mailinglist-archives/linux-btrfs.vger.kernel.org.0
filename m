Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080823ED1D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbhHPKVs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 06:21:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48108 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbhHPKVf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 06:21:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CDAF51FF3F;
        Mon, 16 Aug 2021 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629109251;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b53m7g1XGzxUvh1WoxA5BSaCEW2Kfrih69wLOYDbmho=;
        b=UwcKG05C1Qca+V6lScbW4pEKCqatg2MyKC9QnCE/qMvn6Tw3ehOaPgCEKraMujahpAJoxK
        0R8rFQvWQMIU6RmD9+JVvT8Y4V8p9zZmrInk4P8bSZst7UB5wx+xNDfanPsga7r9ByvgWN
        lqegqh99LXXMKWdlJoKNVPRZdhy6LFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629109251;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b53m7g1XGzxUvh1WoxA5BSaCEW2Kfrih69wLOYDbmho=;
        b=9k21X8F21fgyN1kcV4woOhq9rJedBcn+POQPwt+zElaIQsHFKEl3TiJO2g0KSKWVeE5Idh
        lCZSVFsYaY2QKuDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C4BC8A3B87;
        Mon, 16 Aug 2021 10:20:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3CAB5DA72C; Mon, 16 Aug 2021 12:17:56 +0200 (CEST)
Date:   Mon, 16 Aug 2021 12:17:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: introduce btrfs_subpage_bitmap_info
Message-ID: <20210816101756.GT5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210816060036.57788-1-wqu@suse.com>
 <20210816060036.57788-2-wqu@suse.com>
 <35622671-e0e3-6600-cfbc-1e48da29b806@suse.com>
 <8ac274cc-18ab-55eb-f098-fa359841cfc8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ac274cc-18ab-55eb-f098-fa359841cfc8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 16, 2021 at 06:12:16PM +0800, Qu Wenruo wrote:
> > Also I believe a graphical representation is in order i.e
> >
> > [u][u][u][u][e][e][e][e][e]
> > ^			  ^
> > |-uptodate_start	  |- error_start etc
> 
> That looks awesome.
> 
> > Since it's a bit unexpected to have multiple, logically independent
> > bitmaps be tracked in the same physical location.
> 
> That's also I'm concerning of.
> 
> I haven't seen other code sides doing the same behavior.
> IOmap just waste all the memory by going full u32 bitmap even for case
> like 16K page size and 4K sectorsize, exactly I want to avoid.

Yeah, it is mixing independent things in one structure, but that is to
decrease the waste and memory consumption. The subpage is attached to
each page, that come in large numbers so this is a justified
optimization, even if it's not "conceptually clean".

In the first implementation there were 4 bitmaps, so we see how things
work without the optimization. The switch to one bitmap was about to
happen once we get things working.
