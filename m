Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864FA33054C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 01:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhCHAZM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 19:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbhCHAZM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 19:25:12 -0500
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C10DC06174A
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Mar 2021 16:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NlasRRTLZNbLVpkcgojtjxSCYyB3iCKNtKUDToGsFyQ=; b=egCq2g8jy9sb0LROak4y6fK0xt
        luOfEY3HleWV6nmOjmDSAXocTGd9+B0RyguN7feArHxBn4mzE2uei3smphtDY2sdDjcfR8GYt2iwO
        ZpZZnPead+3GsFYrwhgNgY4R2L5+uHbvPdztmGVuAS+tjxRvQT+ANV2qljlbYGcEMkZ6fBr9Vq7nE
        1SxcUh68iLlopzcCOBz9ULkCMrSfyx3Ze1EMqeRtBbXfDq/cwFw/1i8GQFMHcJhA6WcVC8h0knQLg
        1m1sfQfKTCidRHa/BLZEQbm6MRVUFKPOU2ztDyMTlL0RRYJCbzNu+Et0Fgl6FP+o+/xcIJI3bFSxr
        J05R20yA==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=burischnitzel.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1lJ3hr-0002S7-AM; Mon, 08 Mar 2021 00:25:07 +0000
Received: by burischnitzel.preining.info (Postfix, from userid 1000)
        id 63B3AB384531; Mon,  8 Mar 2021 09:25:03 +0900 (JST)
Date:   Mon, 8 Mar 2021 09:25:03 +0900
From:   Norbert Preining <norbert@preining.info>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs fails to mount on kernel 5.11.4 but works on 5.10.19
Message-ID: <YEVu36vR0QVWMcN6@burischnitzel.preining.info>
References: <YEVYbMdXdPzklSVc@bulldog.preining.info>
 <20210308081640.3774.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308081640.3774.409509F4@e16-tech.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi

(please cc)

thanks for your email. First some additional information. Since this
happened I searched and realized that there seem to have been a problem
with 5.12-rc1, which I tried for short time (checking whether AMD-GPU
hangs are fixed). Now I read that -rc1 is a btrfs-killer. I have swap
partition, not swap file, and 64G or RAM, so normally swap is not used,
though.

Then for your email:

On Mon, 08 Mar 2021, Wang Yugui wrote:
> If this is a boot btrfs filesystem, please try to mount it manually with
> a live linux with the kernel 5.11.4?

Hmmm, good idea, but how do I get a live system with that kernel? Not
that I know any having this as default by now.

I have booted systemrescue and run now
	btrfsck --check-data-csum
to see whether there are some other errors.

> When a boot btrfs filesystem with multiple disks, I have a question for
> a little long time.

What kind of problems do you see?

> If some but not all of the disks are scaned, systemd will try to mount
> it? and then btrfs mount will try to wait other disks to be scaned?

Hmm, but nothing has changed in the underlying boot configuration
(Debian/sid). Same system only kernel changes.

(Please cc)

Thanks and all the best

Norbert

> > not sure this is the right mailing list, but I cannot boot into 5.11.4 
> > it gives me
> > 	devid 9 uui .....  
> > 	failed to read the system array: -2
> > 	open_ctree failed
> > (only partial, typed in from photo)
> > 
> > OTOH, 5.10.19 boots without a hinch
> > $ btrfs fi show /
> > Label: none  uuid: 911600cb-bd76-4299-9445-666382e8ad20
> >         Total devices 8 FS bytes used 3.28TiB
> >         devid    1 size 899.01GiB used 670.00GiB path /dev/sdb3
> >         devid    2 size 489.05GiB used 271.00GiB path /dev/sdd
> >         devid    3 size 1.82TiB used 1.58TiB path /dev/sde1
> >         devid    4 size 931.51GiB used 708.00GiB path /dev/sdf1
> >         devid    5 size 1.82TiB used 1.58TiB path /dev/sdc1
> >         devid    7 size 931.51GiB used 675.00GiB path /dev/nvme2n1p1
> >         devid    8 size 931.51GiB used 680.03GiB path /dev/nvme1n1p1
> >         devid    9 size 931.51GiB used 678.03GiB path /dev/nvme0n1p1
> > 
> > That is a multi disk array with all data duplicated data/sys:
> > 
> > $ btrfs fi us -T /
> > Overall:
> >     Device size:                   8.63TiB
> >     Device allocated:              6.76TiB
> >     Device unallocated:            1.87TiB
> >     Device missing:                  0.00B
> >     Used:                          6.57TiB
> >     Free (estimated):              1.03TiB      (min: 1.03TiB)
> >     Free (statfs, df):             1.01TiB
> >     Data ratio:                       2.00
> >     Metadata ratio:                   2.00
> >     Global reserve:              512.00MiB      (used: 0.00B)
> >     Multiple profiles:                  no
> > 
> >                   Data      Metadata System               
> > Id Path           RAID1     RAID1    RAID1     Unallocated
> > -- -------------- --------- -------- --------- -----------
> >  1 /dev/sdb3      662.00GiB  8.00GiB         -   229.01GiB
> >  2 /dev/sdd       271.00GiB        -         -     1.55TiB
> >  3 /dev/sde1        1.58TiB  7.00GiB         -   241.02GiB
> >  4 /dev/sdf1      701.00GiB  7.00GiB         -   223.51GiB
> >  5 /dev/sdc1        1.57TiB 10.00GiB         -   241.02GiB
> >  7 /dev/nvme2n1p1 675.00GiB        -         -   256.51GiB
> >  8 /dev/nvme1n1p1 673.00GiB  7.00GiB  32.00MiB   251.48GiB
> >  9 /dev/nvme0n1p1 671.00GiB  7.00GiB  32.00MiB   253.48GiB
> > -- -------------- --------- -------- --------- -----------
> >    Total            3.36TiB 23.00GiB  32.00MiB     3.21TiB
> >    Used             3.27TiB 15.70GiB 528.00KiB            
> > $
> > 
> > Is there something wrong with the filesystem? Or the kernel?
> > Any hint how to debug this?

--
PREINING Norbert                              https://www.preining.info
Fujitsu Research Labs  +  IFMGA Guide + TU Wien + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
