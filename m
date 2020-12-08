Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6332D23F2
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 07:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgLHGzG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 01:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLHGzG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 01:55:06 -0500
Received: from ravenhurst.kallisti.us (ravenhurst-smtp-tx.kallisti.us [IPv6:2600:3c03:e000:2e0::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075E9C0613D6
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 22:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kallisti.us
        ; s=20180707; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NXUV9Ummod0l+85XoTV0E6XrtFw9NzFeA3LQyyYgcQM=; b=K/61T3t8ujB2cNNz7qZSDc1Zid
        uE2JpkhXwq2/AiikP/dJg1eL/1SN2KxJG74EVKQQ6tsTWjSQdwq3Q0OUwNVyvXDIUvSoSrvGIa1R5
        Zi72XTTd/o/NNpIfHIRiA5W1XZu4CEwRNGIcbeyPT8BnQTjgOM2wW193y2j6ypIwGfdAwd4LrXvRw
        cnM1rfOEcBFXJb8NuA08hby8cYu3oQJDwAMPmCErfCFJUWl8oj4hxc7pQiouLJ151P+9rA/DY4n2L
        h/hmnxdBHJ1OsfmhtIl1Wv8vnzDB86NBDFfluCsn2dSHIGSUMNXIzkuQCcL3I0Fo1GS8RNJTBlUL0
        5Q1O3PUw==;
Received: from [2606:6000:4500:1400:254a:4d71:ec95:4de7] (helo=stgulik)
        by ravenhurst.kallisti.us with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ross@kallisti.us>)
        id 1kmWtE-0004Gk-Ug; Tue, 08 Dec 2020 01:54:25 -0500
Date:   Mon, 7 Dec 2020 22:54:20 -0800
From:   Ross Vandegrift <ross@kallisti.us>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: tree-checker corrupt leaf error
Message-ID: <20201208065420.sftpdmth34lsnsnx@stgulik>
References: <20201208010653.7r5smyo6vloqk7qv@vanvanmojo.kallisti.us>
 <CAJCQCtQe=1m-43Fg_QQ8eOjWyTjHibs_0yiBFg=+wVQBUc_NMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtQe=1m-43Fg_QQ8eOjWyTjHibs_0yiBFg=+wVQBUc_NMw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 07, 2020 at 08:17:22PM -0700, Chris Murphy wrote:
> On Mon, Dec 7, 2020 at 6:47 PM Ross Vandegrift <ross@kallisti.us> wrote:
> > I've got a single-device btrfs filesystem that fails to mount and I'm
> > not sure how to proceed:
> >
> > [  118.556075] BTRFS: device label backup devid 1 transid 55709 /dev/dm-21
> > [  118.581857] BTRFS info (device dm-21): use zlib compression, level 3
> > [  118.581858] BTRFS info (device dm-21): disk space caching is enabled
> > [  120.035857] BTRFS info (device dm-21): enabling ssd optimizations
> > [  120.037493] BTRFS critical (device dm-21): corrupt leaf: root=5 block=3420303224832 slot=18 ino=265, invalid inode transid: has 140301292396544 expect [0, 55710]
> > [  120.065595] BTRFS critical (device dm-21): corrupt leaf: root=5 block=3420303224832 slot=18 ino=265, invalid inode transid: has 140301292396544 expect [0, 55710]
> 
> $ printf '%x %x\n' 140301292396544 55710
> 7f9a70b1e000 d99e
> 
> Looks like it's just garbage, not a bit flip. It'd be useful to know
> if there are other issues:
> 
> $ sudo btrfs check --check-data-csum /dev/sdXY
> 
> This is read-only.

The output is exactly the same as the first run, without --check-data-csum.
Many other errors, some examples:

root 5 inode 12718874 errors 100000, invalid inode generation or transid
root 958 inode 1293 errors 400, nbytes wrong
root 958 inode 172954 errors 100, file extent discount
Found file extent holes:
        start: 57344, len: 4096

(My first message has full log attached.)

> > The wiki suggests reverting to the working kernel, so I rebooted into
> > 4.19.160 (stable was updated) - but now I get the same error on 4.19.
> 
> I'm going to guess it was due to a bug in an older kernel and it just
> got exposed by a newer kernel, and bad luck that it's now also visible
> with the old kernel. It could also be some kind of device (firmware)
> bug that got hit at one time, but is just now seen by the kernel.
> 
> >
> > The list archives point to using `btrfs inspect-internal inode-resolve`
> > to find problematic files and copying-then-deleting them.  But since I
> > cannot mount, this doesn't work.
> 
> It might be possible to use a backuproot, but with rw it's possible it
> makes things worse if it actually uses a stale tree.
> 
> mount -o ro,usebackuproot
> 
> Does that mount?

Nope- same/similar failure in dmesg:

[23818.342270] BTRFS critical (device dm-21): corrupt leaf: root=5 block=3420303224832 slot=18 ino=265, invalid inode transid: has 140301292396544 expect [0, 55711]
[23818.575658] BTRFS critical (device dm-21): corrupt leaf: root=5 block=3420303224832 slot=18 ino=265, invalid inode transid: has 140301292396544 expect [0, 55711]

> If so, at least you can update your backups. Only then is it OK to try
> btrfs check --repair because while it should be safe, it can make
> things worse.

This fs is my backups.  So while it's a bummer, losing the data isn't the end
of the world.

> https://btrfs.wiki.kernel.org/index.php/Restore
> 
> That's quite tedious to figure out. It might help to ask on #btrfs and
> wait for a reply, because sometimes there's a lot of back and forth to
> iterate.

Thanks for the reference, I'll take a look.  I will probably decide to try a
repair and write off the data if necessary, since it's just backups.

Ross
