Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B393B12659
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 04:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfECCmH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 May 2019 22:42:07 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:51588 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfECCmH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 May 2019 22:42:07 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-02.dd24.net (Postfix) with ESMTP id B15A15FFAF
        for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2019 02:42:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id FTaqSRp1536N for <linux-btrfs@vger.kernel.org>;
        Fri,  3 May 2019 02:42:03 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-188-174-64-185.dynamic.mnet-online.de [188.174.64.185])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2019 02:42:03 +0000 (UTC)
Message-ID: <4519c9cb9f53bd934ff7877a620a5fa684b607b1.camel@scientia.net>
Subject: Re: delayed_refs has NO entry / btrfs_update_root:136: Aborting
 unused transaction(No space left).
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-btrfs@vger.kernel.org
Date:   Fri, 03 May 2019 04:42:03 +0200
In-Reply-To: <e92b879b03f4838cc05c1b80d20917d3be1ba7f7.camel@scientia.net>
References: <b2a668d7124f1d3e410367f587926f622b3f03a4.camel@scientia.net>
         <d35fa8de087c746f9affb789cf3ab599a3d042c1.camel@scientia.net>
         <9ff84820-5d7e-f541-6adc-29c4949d44e0@suse.de>
         <e92b879b03f4838cc05c1b80d20917d3be1ba7f7.camel@scientia.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

Just asking... was anyone able to reproduce these errors (as described
below)?

Cheers,
Chris.


On Sat, 2019-04-13 at 00:46 +0200, Christoph Anton Mitterer wrote:
> On Wed, 2019-03-20 at 10:59 +0100, Johannes Thumshirn wrote:
> > First of all, have you tried a more recent kernel than the Debian
> > kernels you referenced? E.g. Linus' current master or David's misc-
> > next
> > branch? Just so we don't try to hunt down a bug that's already
> > fixed.
> 
> I haven't and that's a bit difficult for me unless it's packaged by
> the
> distro (policy reasons).
> 
> 
> Also giving out the image is a bit problematic as it's huge (8TB).
> 
> > Also if you can still reproduce the bug, please activate tracing in
> > btrfs and send the trace output.
> 
> How would I do that?
> 
> 
> In the meantime, I think I can reproduce it with fresh images so
> could
> you try the following:
> 
> # truncate --size 1G image
> # mkfs.btrfs image
> 
> # mount -o compress image /mnt
> # cd /mnt
> 
> # # create some data e.g.:
> # tar xaf /usr/src/linux-source-4.19.tar.xz
> # cd
> # umount /mnt
> 
> # losetup -r -f image
> # mount -o compress /dev/loop0 /mnt
> 
> # find /mnt -type f -exec filefrag -v {} \;
> 
> 
> And there your kernel log will explode ;-)
> 
> The culprit seems to be the device itself being read-only i.e.
> losetup's -r, respectively blockdev --setro DEVICE which I've used
> previously.
> 
> If you repeat the above from the losetup point, but with -r ...
> everything works fine.
> Haven't checked whether -o compress actually makes a difference.
> 
> 
> Cheers,
> Chris.
> 

