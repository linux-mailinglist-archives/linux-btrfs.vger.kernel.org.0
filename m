Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8839617BFC8
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 15:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFOAe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 09:00:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33075 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgCFOAe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Mar 2020 09:00:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so913427plb.0;
        Fri, 06 Mar 2020 06:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=efYr67/bTkt21SGtVdNVaerWisMPAYyt0fWiDVwgGjk=;
        b=ZhFOhSckcSX8pV1bWCS4o4akz+nRynoamY/zQbaiHWh4a4IFicLY2Jk2OA1ffM/i96
         eKSC7h1EHCAaBCWypKBn5baMCTGxLnvA0ZoRF5qH3MVCUygz0pvYc4ujRChBBC2winPL
         saqJr4tzjm/7nPA7h/3U6NFw+J6EpK7EEKiQqDwhlRq68FbeHpxlOvw/xT1YlLaN4TPv
         P4F4KzqovD9pMu1zybSbESrlfUsJ7i1jt2NP7+iRv8sLn0VesWDFwofj1m1tPw2Us7SQ
         NVJE1uLk/ZZM8/7mH2Gdz/DybhRTFl0UmO/yWNOtoz0NGRC0QMsV0di74laEg8OwmWBw
         2/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=efYr67/bTkt21SGtVdNVaerWisMPAYyt0fWiDVwgGjk=;
        b=H5S1hDzZ1NZxCal+L06G1r/j2bBcoTG4rQ5eUuiFY4UaifIFQ7BM4yLzwZ0/R9Lxgj
         zhl5CARQh+DEddu2ljGufjy/EXgZLsC6NOqExRt3xniKIY6Y5NUpZEvbK8u1fPORsQEv
         RI02yD+D0ZNveOqILP/L35/3yg20uqTnGaxkwjfZ0s2VnWoMowLW5onVtfFQ9Z3oEw1r
         hFLWrQvnPhb3DzROG0S3aVRHtCBB8dfxVaovAgUAQ1tyxr32ZBf7Q6K98CyS10kRICJf
         8pWAlBM65JR84C2mHnthSBoQqYMtwkKbMXCGn6UWIOU+A3PCueFOhtZyCCZ575j0ctJ9
         gDww==
X-Gm-Message-State: ANhLgQ0P9M2+awHF/FDPmkEdRJDmJHOzNnwGNd+93tsPix3PT84B5ID6
        SBAYjdHfE3spmSiKaIZfXw==
X-Google-Smtp-Source: ADFU+vtNUgRRJn2bRpQQmczbG/BE5no1t/hK7c/TWORsRGmvhtlbbtZao22ZUYqyVEVeSlNkEM5WOw==
X-Received: by 2002:a17:90a:3701:: with SMTP id u1mr3681744pjb.25.1583503233154;
        Fri, 06 Mar 2020 06:00:33 -0800 (PST)
Received: from madhuparna-HP-Notebook ([218.248.46.83])
        by smtp.gmail.com with ESMTPSA id g11sm7631037pfo.184.2020.03.06.06.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Mar 2020 06:00:31 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Fri, 6 Mar 2020 19:30:24 +0530
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     madhuparnabhowmik10@gmail.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        frextrite@gmail.com, linux@roeck-us.net
Subject: Re: [PATCH] fs: btrfs: block-group.c: Fix suspicious RCU usage
 warning
Message-ID: <20200306140023.GA14186@madhuparna-HP-Notebook>
References: <20200306065243.11699-1-madhuparnabhowmik10@gmail.com>
 <dfd2c14c-acda-3862-9f48-a512e16a895c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfd2c14c-acda-3862-9f48-a512e16a895c@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 06, 2020 at 03:16:53PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/3/6 下午2:52, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > The space_info list is rcu protected.
> > Hence, it should be traversed with rcu_read_lock held.
> > 
> > Warning:
> > [   29.104591] =============================
> > [   29.104756] WARNING: suspicious RCU usage
> > [   29.105046] 5.6.0-rc4-next-20200305 #1 Not tainted
> > [   29.105231] -----------------------------
> > [   29.105401] fs/btrfs/block-group.c:2011 RCU-list traversed in non-reader section!!
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > ---
> >  fs/btrfs/block-group.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 404e050ce8ee..9cabeef66f5b 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1987,6 +1987,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
> 
> This function is only triggered at mount time, where no other rcu
> operation can happen.
>
Thanks Qu.

Joel and Paul, what should we do in this case?
Should we just pass cond = true or use list_for_each_entry instead?

Thank you,
Madhuparna

> Thanks,
> Qu
> >  		btrfs_release_path(path);
> >  	}
> >  
> > +	rcu_read_lock();
> >  	list_for_each_entry_rcu(space_info, &info->space_info, list) {
> >  		if (!(btrfs_get_alloc_profile(info, space_info->flags) &
> >  		      (BTRFS_BLOCK_GROUP_RAID10 |
> > @@ -2007,7 +2008,8 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
> >  				list)
> >  			inc_block_group_ro(cache, 1);
> >  	}
> > -
> > +	rcu_read_unlock();
> > +		
> >  	btrfs_init_global_block_rsv(info);
> >  	ret = check_chunk_block_group_mappings(info);
> >  error:
> > 
> 



