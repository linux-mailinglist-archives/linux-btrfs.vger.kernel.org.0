Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CD23BFC6
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 01:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390520AbfFJXOH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 19:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390340AbfFJXOG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 19:14:06 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE52820859;
        Mon, 10 Jun 2019 23:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560208446;
        bh=1znbKbPJNbimnR4+MsOLwFF4y5Rj5sFfCVC3jk2xIAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXevS+q4qXOL7M6k9CFJifTza+Kp/5K8C/xY5scvGNIU/Y3g8+WncH2XXv3UZiud6
         NsxkAB6IUZdt34lejn50ijPpUuzPX/w3TYfTkcvYvd9XF72zEWpRug2xtjjMwWIB0L
         e1UO/HznlOcoQhP8TW8X7jq7yhqrKc1b/IihEZGc=
Date:   Mon, 10 Jun 2019 16:14:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Anand Jain <anand.jain@oracle.com>,
        syzbot <syzbot+5b658d997a83984507a6@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: kernel BUG at fs/btrfs/volumes.c:LINE!
Message-ID: <20190610231403.GZ63833@gmail.com>
References: <00000000000096009b056df92dc1@google.com>
 <70a3c2d1-3f53-d4c0-13b3-29f836ec46d9@oracle.com>
 <20180607153450.GF3215@twin.jikos.cz>
 <CACT4Y+arBwkwhD-kob9fg1pVBXiMepW6KBK2LkhwjQ9HnDcoqw@mail.gmail.com>
 <20180607165213.GI3215@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607165213.GI3215@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 07, 2018 at 06:52:13PM +0200, David Sterba wrote:
> On Thu, Jun 07, 2018 at 06:28:02PM +0200, Dmitry Vyukov wrote:
> > > Normally the GFP_NOFS allocations do not fail so I think the fuzzer
> > > environment is tuned to allow that, which is fine for coverage but does
> > > not happen in practice. This will be fixed eventually.
> > 
> > Isn't GFP_NOFS more restricted than normal allocations?  Are these
> > allocations accounted against memcg? It's easy to fail any allocation
> > within a memory container.
> 
> https://lwn.net/Articles/723317/ The 'too small to fail' and some
> unwritten semantics of GFP_NOFS but I think you're right about the
> memory controler that can fail any allocation though.
> 
> Error handling is being improved over time, the memory allocation
> failures are in some cases hard and this one would need to update some
> logic so it's not a oneliner.
> 

This bug is still there.  In btrfs_close_one_device():

	if (device->name) {
		name = rcu_string_strdup(device->name->str, GFP_NOFS);
		BUG_ON(!name); /* -ENOMEM */
		rcu_assign_pointer(new_device->name, name);
	}

It assumes that the memory allocation succeeded.

See syzbot report from v5.2-rc3 here: https://syzkaller.appspot.com/text?tag=CrashReport&x=16c839c1a00000

Is there any plan to fix this?

- Eric
