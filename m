Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D11717C68C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 20:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFTxZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 14:53:25 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41899 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFTxZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Mar 2020 14:53:25 -0500
Received: by mail-qv1-f68.google.com with SMTP id s15so1505213qvn.8
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Mar 2020 11:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QaNxcQb7Gg+vxIHDRqfm2dfWV4oEZhj/ZtvsBzj/+Bk=;
        b=qk06El3JD3uD38dR/+KpHsLyQqx2wruXRJgkstX2ahhw9X3IFGj5nLe2Z+o4giq/pM
         ldJs5F7oyuhAevtUXI557hIOqP78gga6BNTgb4Smwr0CdmuPgHBd9R/mpRAuAVFgT6Si
         FO4sdeP9aVDm3bSjSYygt3LXsi7uG2og5cDNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QaNxcQb7Gg+vxIHDRqfm2dfWV4oEZhj/ZtvsBzj/+Bk=;
        b=PXfc5V5wVHPAkKED9bCeroSaSjhsZ3djoS6SRyJ7lLA9+VNmsRhnVBButrq17rQDqT
         tMyRwwcD6cHXa2TVQEvfQ/7o3ZjxlQF9lGonvJUg9S4WTGos2qfUKg7hzsCrGVY12DJg
         8pas2V7N+kkx1iA9dVqWzRc7ZMCSj/YO1rB0EC6kmkHYPSayPxIlYLIofFikmfoyT4XT
         5EG+fJ8RgOgBblHcsSVBqnT96iYVQC+AmknogPyaneA8UPml0kpJlArewcjdUlrdUZiR
         7pnv1GR21qSPul4ZkYZteDHsiXdHuOHyrNxlblEBTulRJ+qn4oJ5ZUVlfKiIQgPYfulf
         fjng==
X-Gm-Message-State: ANhLgQ1d1vMCoBB3M+N2QMJb7V2BhA6n6IXDeyv6/lv8Qj3JYyaRN2t4
        3UyD3l852jvDPiuI6fwsuszNC2ssx6c=
X-Google-Smtp-Source: ADFU+vtbUmkkv8Fc33D5K6vbh/9sVOZA5kQ0oSPjOpP/B5uhae1bm0YKFhE+l4pQ9zfnhd2Fpzr5Rw==
X-Received: by 2002:a05:6214:1051:: with SMTP id l17mr4508705qvr.175.1583524404428;
        Fri, 06 Mar 2020 11:53:24 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x188sm8961139qka.53.2020.03.06.11.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 11:53:23 -0800 (PST)
Date:   Fri, 6 Mar 2020 14:53:23 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     dsterba@suse.cz,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        frextrite@gmail.com, linux@roeck-us.net
Subject: Re: [PATCH] fs: btrfs: block-group.c: Fix suspicious RCU usage
 warning
Message-ID: <20200306195323.GE60713@google.com>
References: <20200306065243.11699-1-madhuparnabhowmik10@gmail.com>
 <dfd2c14c-acda-3862-9f48-a512e16a895c@gmx.com>
 <20200306140023.GA14186@madhuparna-HP-Notebook>
 <20200306152527.GH2902@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200306152527.GH2902@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 06, 2020 at 04:25:27PM +0100, David Sterba wrote:
> On Fri, Mar 06, 2020 at 07:30:24PM +0530, Madhuparna Bhowmik wrote:
> > On Fri, Mar 06, 2020 at 03:16:53PM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2020/3/6 下午2:52, madhuparnabhowmik10@gmail.com wrote:
> > > > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > > 
> > > > The space_info list is rcu protected.
> > > > Hence, it should be traversed with rcu_read_lock held.
> > > > 
> > > > Warning:
> > > > [   29.104591] =============================
> > > > [   29.104756] WARNING: suspicious RCU usage
> > > > [   29.105046] 5.6.0-rc4-next-20200305 #1 Not tainted
> > > > [   29.105231] -----------------------------
> > > > [   29.105401] fs/btrfs/block-group.c:2011 RCU-list traversed in non-reader section!!
> > > > 
> > > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > > ---
> > > >  fs/btrfs/block-group.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > > index 404e050ce8ee..9cabeef66f5b 100644
> > > > --- a/fs/btrfs/block-group.c
> > > > +++ b/fs/btrfs/block-group.c
> > > > @@ -1987,6 +1987,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
> > > 
> > > This function is only triggered at mount time, where no other rcu
> > > operation can happen.
> > >
> > Thanks Qu.
> > 
> > Joel and Paul, what should we do in this case?
> > Should we just pass cond = true or use list_for_each_entry instead?
> 
> I think we can afford to add rcu lock/unlock, even if it's not strictly
> necessary due to the single threaded context where the function is run.
> There are some lightweight operations inside and inc_block_group starts
> with two spin locks so there's nothing we'd be losing with disabled
> preemption from the caller.

I think use list_for_each_entry().

thanks,

 - Joel

