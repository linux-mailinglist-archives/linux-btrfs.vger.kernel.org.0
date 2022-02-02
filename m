Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A547A4A6BCC
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 07:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244857AbiBBGwr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 01:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244792AbiBBGwj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Feb 2022 01:52:39 -0500
Received: from ravenhurst.kallisti.us (ravenhurst-smtp-tx.kallisti.us [IPv6:2600:3c03:e000:2e0::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00F6C061756
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Feb 2022 22:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kallisti.us
        ; s=20220106; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BfLc5KHDW3nJsQC9d6YoC1XQWrKXX6XsS8O6hzzsnlA=; b=odBg3m+z+m680p6ZGmtVRnJNyG
        8Pxvs7e9q4zqd0CQhxjM0MZoe+kXbfnnxbhisXPMhbLwM+EhcTdQk2VKS9kEvZcIb5HeKL+7ZEfFS
        A6bAh8COVYdqaFYoH8fXeGpoIIZTJnf9F53SF3SXAFnqeRMij6z3XRTEOiHt8zboRcJifHXNhvCn9
        OOF5TlBfzRfOzyIhMq7VLL3/bBt7bjkEXb798AUXM9jwQ/9jLVtvo5/gtSbTa5BERBpggqFQiPWdU
        QhmsG2RjBfUUc9Bf+Mc/1lSovkBSBopWLhE7SUfsA01EpsuN1RnRptUI1h3I5AZsGhgU06qpnurTD
        x2ZfF7HA==;
Received: from [50.46.16.53] (helo=stgulik)
        by ravenhurst.kallisti.us with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ross@kallisti.us>)
        id 1nF8oy-00CsdE-Kx; Wed, 02 Feb 2022 01:08:48 -0500
Date:   Tue, 1 Feb 2022 22:08:44 -0800
From:   Ross Vandegrift <ross@kallisti.us>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: unable to remove device due to enospc
Message-ID: <20220202060805.2qxputhf2ezozi7p@stgulik>
References: <20220111072058.2qehmc7qip2mtkr4@stgulik>
 <CAJCQCtTKd_yMUa_Fr9bGuhPvfYWPuY0=Vs=-+k85gfZJqLK_FA@mail.gmail.com>
 <20220116064857.axyfyppj5x5kpsa5@stgulik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116064857.axyfyppj5x5kpsa5@stgulik>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris,

On Sat, Jan 15, 2022 at 10:49:01PM -0800, Ross Vandegrift wrote:
> On Sat, Jan 15, 2022 at 05:39:12PM -0700, Chris Murphy wrote:
> > On Tue, Jan 11, 2022 at 12:41 AM Ross Vandegrift <ross@kallisti.us> wrote:
> > >
> > > Unallocated:
> > >    /dev/mapper/backup      7.24TiB
> > >    /dev/mapper/backup_a    2.55TiB
> > >    /dev/mapper/backup_b    2.55TiB
> > 
> > You might be running into this bug I mentioned today in another
> > thread. It's an overcommit related bug where the initial overcommit is
> > based on a single device's unallocated space, in this case the 7T
> > device - but then later logic results in ENOSPC because there aren't
> > two devices that can handle that amount of overcommit. If you  can
> > remove /dev/mapper/backup, leaving just _a and _b with equal
> > unallocated, then try to reproduce. If you can't, you've likely hit
> > the bug I'm thinking of. If you still can, then you're hitting
> > something different.
> > 
> > However, since these unallocated values are orders of magnitude bigger
> > than discussed in the other thread, and orders of magnitude more space
> > than is needed to successfully create new chunks on multiple devices -
> > I'm not sure. Also I'm not sure without going through the change log
> > for 5.15 and 5.16 if this is fixed in one of those so the easiest
> > thing to do is try and reproduce it with 5.16. If ENOSPC happens, then
> > try to remove the device with 7T unallocated.
> 
> Same behavior with 5.16:

Any other ideas on this issue?  Would images of these devices be interesting or
useful?

Ross


> 
> $ uname -a
> Linux vanvanmojo 5.16.0 #3 SMP PREEMPT Sat Jan 15 21:39:38 PST 2022 x86_64 GNU/Linux
> $ sudo btrfs device remove /dev/mapper/backup /mnt/backup
> ERROR: error removing device '/dev/mapper/backup': No space left on device
> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
> WARNING:   Data: single, raid1
> $ sudo btrfs fi usage /mnt/backup
> Overall:
>     Device size:	          18.80TiB
>     Device allocated:	          12.52TiB
>     Device unallocated:	           6.27TiB
>     Device missing:	             0.00B
>     Used:		          12.47TiB
>     Free (estimated):	           3.17TiB	(min: 3.16TiB)
>     Free (statfs, df):	           5.63TiB
>     Data ratio:	                      1.99
>     Metadata ratio:	              2.00
>     Global reserve:	         512.00MiB	(used: 0.00B)
>     Multiple profiles:	               yes	(data)
> 
> Data,single: Size:35.00GiB, Used:34.87GiB (99.63%)
>    /dev/mapper/backup	  35.00GiB
> 
> Data,RAID1: Size:6.23TiB, Used:6.20TiB (99.57%)
>    /dev/mapper/backup_b    6.23TiB
>    /dev/mapper/backup_a    6.23TiB
> 
> Metadata,RAID1: Size:16.00GiB, Used:14.85GiB (92.80%)
>    /dev/mapper/backup_b    16.00GiB
>    /dev/mapper/backup_a    16.00GiB
> 
> System,RAID1: Size:32.00MiB, Used:900.00KiB (2.75%)
>    /dev/mapper/backup_b    32.00MiB
>    /dev/mapper/backup_a    32.00MiB
> 
> Unallocated:
>    /dev/mapper/backup	 715.00GiB
>    /dev/mapper/backup_b    2.79TiB
>    /dev/mapper/backup_a    2.79TiB
> 
> 
> Here's the dmesg output from the removal attempt:
> [  581.830800] BTRFS info (device dm-16): relocating block group 749505347584 flags data
> [  648.464705] BTRFS info (device dm-16): relocating block group 419866607616 flags data
> [  724.635005] BTRFS info (device dm-16): relocating block group 411276673024 flags data
> [  752.047813] BTRFS info (device dm-16): relocating block group 403760480256 flags data
> [  756.749221] BTRFS info (device dm-16): relocating block group 395170545664 flags data
> [  760.778891] BTRFS info (device dm-16): relocating block group 387654352896 flags data
> [  787.116859] BTRFS info (device dm-16): relocating block group 379064418304 flags data
> [  812.351256] BTRFS info (device dm-16): relocating block group 749505347584 flags data
> [  838.589207] BTRFS info (device dm-16): relocating block group 419866607616 flags data
> [  885.964951] BTRFS info (device dm-16): relocating block group 411276673024 flags data
> [  901.889074] BTRFS info (device dm-16): relocating block group 403760480256 flags data
> [  904.306416] BTRFS info (device dm-16): relocating block group 395170545664 flags data
> [  906.514675] BTRFS info (device dm-16): relocating block group 387654352896 flags data
> [  923.680623] BTRFS info (device dm-16): relocating block group 379064418304 flags data
> 
> 
> Ross
