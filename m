Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD3EFA56
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 11:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbfKEKBU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Nov 2019 05:01:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:52452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388167AbfKEKBU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Nov 2019 05:01:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33EA1B473;
        Tue,  5 Nov 2019 10:01:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 25ED2DA796; Tue,  5 Nov 2019 11:01:26 +0100 (CET)
Date:   Tue, 5 Nov 2019 11:01:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Meng Xu <mengxu.gatech@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: potential data race on `delayed_rsv->full`
Message-ID: <20191105100125.GI3001@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Meng Xu <mengxu.gatech@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAAwBoOJDjei5Hnem155N_cJwiEkVwJYvgN-tQrwWbZQGhFU=cA@mail.gmail.com>
 <20191101154536.GW3001@twin.jikos.cz>
 <c8aaa244-f0f3-0611-0b2d-13a78a57f9bd@gmail.com>
 <20191101181606.7dlamcd3x3vf4x2q@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101181606.7dlamcd3x3vf4x2q@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 01, 2019 at 02:16:07PM -0400, Josef Bacik wrote:
> On Fri, Nov 01, 2019 at 01:09:30PM -0400, Meng Xu wrote:
> > Hi David,
> > 
> > Thank you for the confirmation and the additional information.
> > 
> > I feel the same that this race may not lead to serious issues, but would
> > rather prefer a confirmation from the developers. Thank you again for your
> > time!
> > 
> 
> Sorry I saw this while I was on vacation, I read through and determined that
> there were no cases where this would bite us.  This is just used as a lock free
> way to see if we should refill the delayed refs rsv.  Worst case we don't and
> the next guy does it, it doesn't affect us in an practical way.
> 
> However given our recent fun with inode->i_size it may be worth it to wrap
> access to ->full with WRITE_ONCE/READ_ONCE to make sure nothing squirrely
> happens in the future.  Thanks,

->full is used unlocked only in this one place, everywhere else it's
insde spinlock. With exception of
btrfs_clear_space_info_full/__find_space_info where it's only RCU
protection. Add in ONCE everywhere would be pointless, the one call can
be commented but adding READ_ONCE would not change anything as it's the
only access that must be loaded anyway.
