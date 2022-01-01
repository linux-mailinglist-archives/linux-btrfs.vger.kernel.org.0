Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A07482895
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jan 2022 22:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiAAV5G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 16:57:06 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:48324 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbiAAV5G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Jan 2022 16:57:06 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 9352A405B6
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 15:57:50 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 6108D8034D34
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 15:57:05 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 51B778034D37
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 15:57:05 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VHAH4WWMfSzY for <linux-btrfs@vger.kernel.org>;
        Sat,  1 Jan 2022 15:57:05 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 084A68034D34
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 15:57:04 -0600 (CST)
Message-ID: <450cba2819b620f8553fd73417102a4c3a153bb9.camel@ericlevy.name>
Subject: Re: parent transid verify failed
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Sat, 01 Jan 2022 16:57:03 -0500
In-Reply-To: <CAJCQCtSYBv805+Yi4EJ-sZh6b4d0BX7=XAufQYtdqvmHvXKZMw@mail.gmail.com>
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
         <Yc9Wgsint947Tj59@hungrycats.org>
         <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
         <CAJCQCtRxkZ4NjQA9KrOvb_ybDE-sg_BzzMU=91fT_p8gMEKw6Q@mail.gmail.com>
         <7cffc181c0b01a52dfd82128eb656ec2ec44b94d.camel@ericlevy.name>
         <CAJCQCtSYBv805+Yi4EJ-sZh6b4d0BX7=XAufQYtdqvmHvXKZMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 2022-01-01 at 13:49 -0700, Chris Murphy wrote:


> OK except we've got kernel messages clearly showing /dev/sdc is
> rejecting writes, and that's what btrfs is complaining about. Since
> there's only a partial dmesg to go on, I can really say if there's
> something else going on, but pretty straightforward when there's
> multiple of these:

All I'm suggesting is that the write issue is far more likely to be
occurring at the layer of logical volumes than physical media, based on
the symptoms.
 
If you go back a few messages, you can find one with the full output,
attached as a file. 


> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev
> sdc, sector 523542288 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio
> class 0
> 
> That it will result in these:
> 
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev
> /dev/sdc1 errs: wr 10, rd 0, flush 0, corrupt 0, gen 0
> 
> Btrfs is telling us that writes are being dropped. I'm not sure why
> /dev/sdc is dropping writes but the block layer also knows they're
> being rejected and what sector, so I kinda suspect the block device
> itself is aware of and reporting the write failures with sector
> address to the kernel.

If the problem is at the logical layer, then I would suspect the same,
that the block layer knows whether block writes are committed.


> I can't tell if you've tried umounting this file system and then
> mounting it again cleanly (not remount) and what messages appear in
> dmesg if it fails.

Yes. Clean mount/umount only. No remount option.


> It's definitely an issue with /dev/sdc, but I can't tell from the
> available info why it's dropping writes, only that two parts of the
> kernel are seeing it, btrfs and blk_update_request

I'm simply giving the inference that there must have been some bock
writes on sdc(1) following the addition of sdd as a system device,
otherwise we would have seen failures trying to join the two devices
into the same file system. Right?

So there was some interval during which both block devices were
writable. Right?


> > If the problem is device-level, then there is much to try,
including
> 
> > renewing the iSCSI login. I can also restart the daemon, reboot the
> > host, even restart the iSCSI backend service or appliance.
> > 
> > Would any operations of such a kind be helpful to try?
> 
> iSCSI isn't my area of expertise, someone else might have an idea
> what
> could be going on.

Nor mine, but I'm trying to make infereences based on how the parts
fit together.



