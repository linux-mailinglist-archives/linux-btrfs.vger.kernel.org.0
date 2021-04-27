Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B578D36C5F0
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Apr 2021 14:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhD0MSy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 08:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbhD0MSx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 08:18:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FD4C061574;
        Tue, 27 Apr 2021 05:18:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so50209599wrt.12;
        Tue, 27 Apr 2021 05:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nwYYP5GSWCGL21FGByVMgOz2Zp6qeL8goYySzJMMPZI=;
        b=pZ06IqKYI9QOQmdWQaJ3fwVk9NysimAqNIiWEmmGBUNFB6/SBToqHrjezZNFR+T0ln
         6G5rDTPSrf6k+jrApT6HaHex+sPZJVIVnpiuO08nIiKQHyj7zAZ9qaMVYvgLkvLq4nXs
         jGPAjikF/Hzv1FZ/kQN9RDAVlX0d9SWYxkTL8kMzhmqznq28+dou5e8Nmbtg1HCLQd7H
         ozDghsaljxPnT/+RHhF8h3heCNxQ1EWlDi0NP3R5EZ1dSffITkAEtwJh2mUlqqcYcgwQ
         H/P/gddHyp3P2gzU5CRmnB4bCTY5rJ0rM9cmziOeDRY0QX+5hwR3yc5bYL6ggsAkMX2r
         W1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nwYYP5GSWCGL21FGByVMgOz2Zp6qeL8goYySzJMMPZI=;
        b=YqqrU1gD8+ooTyhGsHsX0tgamKEGROrLGaeSMtFGW0ICdKfWtneao96A3lBrnFVpku
         o9ZxvYEK3jeHVSh60iUOx9M5aC5coR4oQfRUQNV0fGy7M3Ncap+6K99COVMyV4uSYKu+
         JaRPcEvtb9TUezAoI4PNWXHl8YlgfDBz2hRKyh2/iS2mfYUDrzxhB2l3Hxi7DL1yRHyi
         HVxssL9nC/tiEVt2stGkNyaTffcbVKF1lCaz1/AdKwWcdhM7+r+ms5NXog6+IhEbXksf
         z4g+c6CATMI4cauDNMt8eqW6ED9+cxV3RLCJa1bfEBa1M/dpX0F+FeOsoJppoaLwQhM4
         UeJg==
X-Gm-Message-State: AOAM533c9zQV602y9pCsRA/vyErMFvMNnxu83ojCBLxu9VATijvEpDAI
        wwuagij9907EziO0ecYJy7/LfMaYyXc=
X-Google-Smtp-Source: ABdhPJzam8dJzwU87MEnV6VEPQnVzXnAmet8lKqdZKK18xwRA1zD6QCWRZplqtdKDY2xZQFBKUSjSw==
X-Received: by 2002:adf:d1e8:: with SMTP id g8mr1791117wrd.80.1619525887682;
        Tue, 27 Apr 2021 05:18:07 -0700 (PDT)
Received: from ard0534 ([102.158.125.167])
        by smtp.gmail.com with ESMTPSA id q4sm1108136wrs.21.2021.04.27.05.18.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Apr 2021 05:18:07 -0700 (PDT)
Date:   Tue, 27 Apr 2021 13:18:04 +0100
From:   Khaled Romdhani <khaledromdhani216@gmail.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH-next] fs/btrfs: Fix uninitialized variable
Message-ID: <20210427121804.GA16179@ard0534>
References: <20210423124201.11262-1-khaledromdhani216@gmail.com>
 <20210426201929.GI7604@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426201929.GI7604@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 26, 2021 at 10:19:29PM +0200, David Sterba wrote:
> On Fri, Apr 23, 2021 at 01:42:01PM +0100, Khaled ROMDHANI wrote:
> > The variable 'zone' is uninitialized which
> > introduce some build warning.
> > 
> > It is not always set or overwritten within
> > the function. So explicitly initialize it.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> > ---
> >  fs/btrfs/zoned.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index 432509f4b3ac..42f99b25127f 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -136,7 +136,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
> >   */
> >  static inline u32 sb_zone_number(int shift, int mirror)
> >  {
> > -	u64 zone;
> > +	u64 zone = 0;
> 
> This is exactly same as v1
> https://lore.kernel.org/linux-btrfs/20210413130604.11487-1-khaledromdhani216@gmail.com/
> 
> It does fix the build warning but does not make sense in the code
> because it would would silently let mirror == 4 pass. I think there was
> enough feedback under the previous posts how to fix that properly.

Yes, it fixes the build warning. I implemented a tiny test
program before sending the patch. In which I explicitly
set 'm=5' to check the change results:

[356843.099365] assertion failed: z, in /home/khaled/fs_btrfs/test3.c:30

From the above output message, I think that it catchs the assertion.
Sorry, but let me know if I am missing something.

I absolutly agree with you regarding the waste of memory
when doing some pointless initializations. I will, come
back with a V2.

Thanks.
