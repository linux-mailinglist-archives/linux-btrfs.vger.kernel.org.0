Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A30612FBB2
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 18:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgACRnr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 12:43:47 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39184 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgACRnr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 12:43:47 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so37380126qtm.6
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2020 09:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l25yy0ARofBl8zc0HFe3XGYRgSUIOXsm16tl1LH+rKI=;
        b=IqmidU9BbBLAIlV08Vqn385DrigDTzpscCF8sgqL+x0gizFUeCOos/9JLtTxaDCUFj
         d1e6b2Z0m88ZrxuLmCqs/nyuLQwqJrwL8tF3XmM8eMq4N7Ew2ecYi+fcNGlqrB/Gm9HJ
         nKfY7cgDsChLExDrnD1moT1Zv5UrOwdF7qdMrjN3OWZIF/USYJ4QsmaoWrQFtwyYExCF
         RGFhYYKNetrgvvAGvIIbub+TMPykjktZhQItsI3csVZeeEWDsJkKAic11m1oE5bL6UeN
         f+jOqIcRKiJWHe4MkUnCoMPyyq3/BzRO8ydwhPZdTshzNtmhruZBwGLs67g8NgGaXzus
         Qv0Q==
X-Gm-Message-State: APjAAAX/Z7CxGohZjSkOMQD2otAC0KTonQUDJ2a70e20yDeyGpSx84uZ
        R02OzseNYx0/4XyB6ZpgJaE=
X-Google-Smtp-Source: APXvYqye86MSznDxpmTIuW9Kv7mUUDP0IKI7L1c6uikCVmkFWzewhpZfJe5co1MH37fNSDi20F1pIw==
X-Received: by 2002:ac8:42de:: with SMTP id g30mr64506162qtm.195.1578073426431;
        Fri, 03 Jan 2020 09:43:46 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::3:3853])
        by smtp.gmail.com with ESMTPSA id c13sm16751208qko.87.2020.01.03.09.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 09:43:45 -0800 (PST)
Date:   Fri, 3 Jan 2020 12:43:43 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: async discard follow up
Message-ID: <20200103174343.GA97540@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1577999991.git.dennis@kernel.org>
 <20200103145125.GX3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103145125.GX3929@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 03, 2020 at 03:51:25PM +0100, David Sterba wrote:
> On Thu, Jan 02, 2020 at 04:26:34PM -0500, Dennis Zhou wrote:
> > Hello,
> > 
> > Dave applied 1-12 from v6 [1]. This is a follow up cleaning up the
> > remaining 10 patches adding 2 more to deal with a rare -1 [2] that I
> > haven't quite figured out how to repro. This is also available at [3].
> > 
> > This series is on top of btrfs-devel#misc-next-with-discard-v6 0c7be920bd7d.
> > 
> > [1] https://lore.kernel.org/linux-btrfs/cover.1576195673.git.dennis@kernel.org/
> > [2] https://lore.kernel.org/linux-btrfs/20191217145541.GE3929@suse.cz/
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/dennis/misc.git/log/?h=async-discard
> > 
> > Dennis Zhou (12):
> >   btrfs: calculate discard delay based on number of extents
> >   btrfs: add bps discard rate limit for async discard
> >   btrfs: limit max discard size for async discard
> >   btrfs: make max async discard size tunable
> >   btrfs: have multiple discard lists
> >   btrfs: only keep track of data extents for async discard
> >   btrfs: keep track of discard reuse stats
> >   btrfs: add async discard header
> >   btrfs: increase the metadata allowance for the free_space_cache
> >   btrfs: make smaller extents more likely to go into bitmaps
> >   btrfs: ensure removal of discardable_* in free_bitmap()
> >   btrfs: add correction to handle -1 edge case in async discard
> 
> Besides the changes posted to the patches, I did more style cleanups and
> formatting adjustments as I went through the patches. I'll do some
> testing again to be sure there are no bugs introduced by that, but
> otherwise the patchset can be considered merged to misc-next. I'll push
> the branch today.
> 
> It's a lot of new code but I was able to comprehend what's going on,
> great that there's the patch adding implementation overview.
> As the feature is not on by default and requires "special" hardware, it
> should be safe, basisc tests passed so now we're left with the hard bugs
> and corner cases. Thanks.

Ah I apologize for the few misses. Thanks for fixing them and taking
this series! It definitely wasn't an easy series, so I appreciate the
help and patience!

Thanks,
Dennis
