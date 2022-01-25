Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED92649B52F
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 14:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577206AbiAYNfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 08:35:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38490 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386668AbiAYN2n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 08:28:43 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AB965218EA;
        Tue, 25 Jan 2022 13:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643117315;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZibGAb2sfRz/91Q0i1t59fHQxMs76EL8ndOtUtOQCP0=;
        b=TrHvkqsH4J5JxOZMM43zmNGzfs9A9nNsqnnyhUoxIj9xqs2BUH8i44xU7BzzLNADocSasn
        TJt/95dCB+QHc2DAlXzUg96Jm4Sfdfi38hpfIy2orSsbh3whX8UhF/YrsSBLjxZcwP0Iri
        pZHz8dmC/7EkK7vuxUBXWAgjLt9hgAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643117315;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZibGAb2sfRz/91Q0i1t59fHQxMs76EL8ndOtUtOQCP0=;
        b=AcmY8GtMptcI/Bh9sAx7Rh0H6cVTt/wjrbcPCDZizasumfI0oAQJNezYIA4CQfwliglF5Y
        8W1bvRzVk4tnGZBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7C594A3B8C;
        Tue, 25 Jan 2022 13:28:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB670DA7A9; Tue, 25 Jan 2022 14:27:54 +0100 (CET)
Date:   Tue, 25 Jan 2022 14:27:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "wangyugui@e16-tech.com" <wangyugui@e16-tech.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: initialize variable cancel
Message-ID: <20220125132754.GN14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "wangyugui@e16-tech.com" <wangyugui@e16-tech.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220121134522.832207-1-trix@redhat.com>
 <20220125130429.75C1.409509F4@e16-tech.com>
 <266fc1c654a03bf8c5d83f4d9ca1ad5cb57908cb.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <266fc1c654a03bf8c5d83f4d9ca1ad5cb57908cb.camel@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 25, 2022 at 08:30:34AM +0000, Johannes Thumshirn wrote:
> On Tue, 2022-01-25 at 13:04 +0800, Wang Yugui wrote:
> > Hi,
> > 
> > Mabye we should enable '-Wmaybe-uninitialized' for btrfs 'make W=1'.
> > 
> > There is another warning  reproted by '-Wmaybe-uninitialized' 
> > in btrfs misc-next.
> > 
> > fs/btrfs/zoned.c:273:28: warning: ‘zno’ may be used uninitialized in
> > this function [-Wmaybe-uninitialized]
> >    memcpy(zinfo->zone_cache + zno, zones,
> >                             ^
> 
> 
> Isn't that one a false positive?
> 
>       u32 zno;                                                        
> 
> [...]                                                                 
>         /* Check cache */                                             
>         if (zinfo->zone_cache) {                                      
>                 unsigned int i;                                       
>                                                                                
>                 ASSERT(IS_ALIGNED(pos, zinfo->zone_size));            
>                 zno = pos >> zinfo->zone_size_shift;                  
> [...]
>         }                                                             
>                                                                                
> [...]    
>                                                                       
>         /* Populate cache */                                          
>         if (zinfo->zone_cache)                                        
>                 memcpy(zinfo->zone_cache + zno, zones,                
>                        sizeof(*zinfo->zone_cache) * *nr_zones);       
>                                     

Yeah looks like a false positive, maybe it can't reason that
zinfo->zone_cache won't change between the conditions from NULL to valid
pointer.

And as there are other warnings in sb_zone_number we can't set
-Wmaybe-uninitialized by default. I think this could be even more
problematic with older compiler versions.
