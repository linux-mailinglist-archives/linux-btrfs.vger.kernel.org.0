Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2779A17C1AB
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 16:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCFPZz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 10:25:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:47178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgCFPZx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Mar 2020 10:25:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8478BAD88;
        Fri,  6 Mar 2020 15:25:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0DAE8DA728; Fri,  6 Mar 2020 16:25:27 +0100 (CET)
Date:   Fri, 6 Mar 2020 16:25:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        frextrite@gmail.com, linux@roeck-us.net
Subject: Re: [PATCH] fs: btrfs: block-group.c: Fix suspicious RCU usage
 warning
Message-ID: <20200306152527.GH2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        frextrite@gmail.com, linux@roeck-us.net
References: <20200306065243.11699-1-madhuparnabhowmik10@gmail.com>
 <dfd2c14c-acda-3862-9f48-a512e16a895c@gmx.com>
 <20200306140023.GA14186@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200306140023.GA14186@madhuparna-HP-Notebook>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 06, 2020 at 07:30:24PM +0530, Madhuparna Bhowmik wrote:
> On Fri, Mar 06, 2020 at 03:16:53PM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2020/3/6 下午2:52, madhuparnabhowmik10@gmail.com wrote:
> > > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > 
> > > The space_info list is rcu protected.
> > > Hence, it should be traversed with rcu_read_lock held.
> > > 
> > > Warning:
> > > [   29.104591] =============================
> > > [   29.104756] WARNING: suspicious RCU usage
> > > [   29.105046] 5.6.0-rc4-next-20200305 #1 Not tainted
> > > [   29.105231] -----------------------------
> > > [   29.105401] fs/btrfs/block-group.c:2011 RCU-list traversed in non-reader section!!
> > > 
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > ---
> > >  fs/btrfs/block-group.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > index 404e050ce8ee..9cabeef66f5b 100644
> > > --- a/fs/btrfs/block-group.c
> > > +++ b/fs/btrfs/block-group.c
> > > @@ -1987,6 +1987,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
> > 
> > This function is only triggered at mount time, where no other rcu
> > operation can happen.
> >
> Thanks Qu.
> 
> Joel and Paul, what should we do in this case?
> Should we just pass cond = true or use list_for_each_entry instead?

I think we can afford to add rcu lock/unlock, even if it's not strictly
necessary due to the single threaded context where the function is run.
There are some lightweight operations inside and inc_block_group starts
with two spin locks so there's nothing we'd be losing with disabled
preemption from the caller.
