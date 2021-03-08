Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AFB330546
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 01:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhCHARE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 19:17:04 -0500
Received: from out20-51.mail.aliyun.com ([115.124.20.51]:51686 "EHLO
        out20-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhCHAQm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 19:16:42 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0445812|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0438342-0.023588-0.932578;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JhkDvib_1615162599;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JhkDvib_1615162599)
          by smtp.aliyun-inc.com(10.147.40.44);
          Mon, 08 Mar 2021 08:16:40 +0800
Date:   Mon, 08 Mar 2021 08:16:41 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Norbert Preining <norbert@preining.info>
Subject: Re: btrfs fails to mount on kernel 5.11.4 but works on 5.10.19
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
In-Reply-To: <YEVYbMdXdPzklSVc@bulldog.preining.info>
References: <YEVYbMdXdPzklSVc@bulldog.preining.info>
Message-Id: <20210308081640.3774.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

If this is a boot btrfs filesystem, please try to mount it manually with
a live linux with the kernel 5.11.4?

When a boot btrfs filesystem with multiple disks, I have a question for
a little long time.

If some but not all of the disks are scaned, systemd will try to mount
it? and then btrfs mount will try to wait other disks to be scaned?

some but not all disks already make '/dev/disk/by-uuid/' or '/dev/disk/by-label/'
ready, and then systemd will try to mount it?

I have another problem about boot btrfs filesystem with multiple disks.
https://github.com/systemd-rhel/rhel-7/issues/129

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/03/08

> Dear all
> 
> (please cc)
> 
> not sure this is the right mailing list, but I cannot boot into 5.11.4 
> it gives me
> 	devid 9 uui .....
> 	failed to read the system array: -2
> 	open_ctree failed
> (only partial, typed in from photo)
> 
> OTOH, 5.10.19 boots without a hinch
> $ btrfs fi show /
> Label: none  uuid: 911600cb-bd76-4299-9445-666382e8ad20
>         Total devices 8 FS bytes used 3.28TiB
>         devid    1 size 899.01GiB used 670.00GiB path /dev/sdb3
>         devid    2 size 489.05GiB used 271.00GiB path /dev/sdd
>         devid    3 size 1.82TiB used 1.58TiB path /dev/sde1
>         devid    4 size 931.51GiB used 708.00GiB path /dev/sdf1
>         devid    5 size 1.82TiB used 1.58TiB path /dev/sdc1
>         devid    7 size 931.51GiB used 675.00GiB path /dev/nvme2n1p1
>         devid    8 size 931.51GiB used 680.03GiB path /dev/nvme1n1p1
>         devid    9 size 931.51GiB used 678.03GiB path /dev/nvme0n1p1
> 
> That is a multi disk array with all data duplicated data/sys:
> 
> $ btrfs fi us -T /
> Overall:
>     Device size:                   8.63TiB
>     Device allocated:              6.76TiB
>     Device unallocated:            1.87TiB
>     Device missing:                  0.00B
>     Used:                          6.57TiB
>     Free (estimated):              1.03TiB      (min: 1.03TiB)
>     Free (statfs, df):             1.01TiB
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
>                   Data      Metadata System               
> Id Path           RAID1     RAID1    RAID1     Unallocated
> -- -------------- --------- -------- --------- -----------
>  1 /dev/sdb3      662.00GiB  8.00GiB         -   229.01GiB
>  2 /dev/sdd       271.00GiB        -         -     1.55TiB
>  3 /dev/sde1        1.58TiB  7.00GiB         -   241.02GiB
>  4 /dev/sdf1      701.00GiB  7.00GiB         -   223.51GiB
>  5 /dev/sdc1        1.57TiB 10.00GiB         -   241.02GiB
>  7 /dev/nvme2n1p1 675.00GiB        -         -   256.51GiB
>  8 /dev/nvme1n1p1 673.00GiB  7.00GiB  32.00MiB   251.48GiB
>  9 /dev/nvme0n1p1 671.00GiB  7.00GiB  32.00MiB   253.48GiB
> -- -------------- --------- -------- --------- -----------
>    Total            3.36TiB 23.00GiB  32.00MiB     3.21TiB
>    Used             3.27TiB 15.70GiB 528.00KiB            
> $
> 
> Is there something wrong with the filesystem? Or the kernel?
> Any hint how to debug this?
> 
> (Please cc)
> 
> Thanks
> 
> Norbert
> 
> --
> PREINING Norbert                              https://www.preining.info
> Fujitsu Research Labs  +  IFMGA Guide + TU Wien + TeX Live + Debian Dev
> GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13


