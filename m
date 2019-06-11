Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C213C804
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 12:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404501AbfFKKDC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jun 2019 06:03:02 -0400
Received: from twin.jikos.cz ([91.219.245.39]:57146 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404406AbfFKKDC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jun 2019 06:03:02 -0400
Received: from twin.jikos.cz (dave@[127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id x5BA1sTh019587
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 11 Jun 2019 12:01:55 +0200
Received: (from dave@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) id x5BA1rtN019585;
        Tue, 11 Jun 2019 12:01:53 +0200
Date:   Tue, 11 Jun 2019 12:01:53 +0200
From:   David Sterba <dave@jikos.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Anand Jain <anand.jain@oracle.com>,
        syzbot <syzbot+5b658d997a83984507a6@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: kernel BUG at fs/btrfs/volumes.c:LINE!
Message-ID: <20190611100153.GD24160@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: Eric Biggers <ebiggers@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Anand Jain <anand.jain@oracle.com>,
        syzbot <syzbot+5b658d997a83984507a6@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <00000000000096009b056df92dc1@google.com>
 <70a3c2d1-3f53-d4c0-13b3-29f836ec46d9@oracle.com>
 <20180607153450.GF3215@twin.jikos.cz>
 <CACT4Y+arBwkwhD-kob9fg1pVBXiMepW6KBK2LkhwjQ9HnDcoqw@mail.gmail.com>
 <20180607165213.GI3215@twin.jikos.cz>
 <20190610231403.GZ63833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610231403.GZ63833@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 10, 2019 at 04:14:04PM -0700, Eric Biggers wrote:
> On Thu, Jun 07, 2018 at 06:52:13PM +0200, David Sterba wrote:
> > On Thu, Jun 07, 2018 at 06:28:02PM +0200, Dmitry Vyukov wrote:
> > > > Normally the GFP_NOFS allocations do not fail so I think the fuzzer
> > > > environment is tuned to allow that, which is fine for coverage but does
> > > > not happen in practice. This will be fixed eventually.
> > > 
> > > Isn't GFP_NOFS more restricted than normal allocations?  Are these
> > > allocations accounted against memcg? It's easy to fail any allocation
> > > within a memory container.
> > 
> > https://lwn.net/Articles/723317/ The 'too small to fail' and some
> > unwritten semantics of GFP_NOFS but I think you're right about the
> > memory controler that can fail any allocation though.
> > 
> > Error handling is being improved over time, the memory allocation
> > failures are in some cases hard and this one would need to update some
> > logic so it's not a oneliner.
> > 
> 
> This bug is still there.  In btrfs_close_one_device():
> 
> 	if (device->name) {
> 		name = rcu_string_strdup(device->name->str, GFP_NOFS);
> 		BUG_ON(!name); /* -ENOMEM */
> 		rcu_assign_pointer(new_device->name, name);
> 	}
> 
> It assumes that the memory allocation succeeded.
> 
> See syzbot report from v5.2-rc3 here: https://syzkaller.appspot.com/text?tag=CrashReport&x=16c839c1a00000
> 
> Is there any plan to fix this?

Yes there is, to avoid allocations when closing the device and tracking
the state in another way. As this has never been reported in practice
the priority to fix it is rather low so I can't give you an ETA.
