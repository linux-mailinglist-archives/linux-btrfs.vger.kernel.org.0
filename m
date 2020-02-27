Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F830170D11
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 01:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgB0ANn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Feb 2020 19:13:43 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33385 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgB0ANm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Feb 2020 19:13:42 -0500
Received: by mail-wr1-f54.google.com with SMTP id u6so1138645wrt.0
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 16:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Eta5Y/dCrVejSSwjlRI77C6VVF9LDqSs3idWAYxezs=;
        b=B3cpxW/wMcDv/4OKvhh0N5Qf5cwn2P7JXX9+gja9EuLbn51nBE8MaKy9cMOl4MCF9l
         cmDULpor/sceVMWS9lGFH6jHnp1xeYsA3dAr2CS/pnNdLthwqep4wGAJaoMhYzUpEjhS
         tWqFye0FuSQIyX+CJcRfzisUlsBbJEPE2qdLzPSRnxStm7ueXIBMV0ryJRm6/pipSUZ2
         q9YhB4ykNRwq1UwJBlDsglBnTmA//TFkQOfNYRAsBWFvU6QP/X4Bw38XybwPIvoCp+x5
         fECQmgL6KTqHinIIqcPred0TqUl0JnUM7Iah2WiRJqkTn58+3KE1onjwkRsqiCO6Lx39
         WWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Eta5Y/dCrVejSSwjlRI77C6VVF9LDqSs3idWAYxezs=;
        b=hwvuMcy2ISPR2sg43+dT9V08E3adCoSBdk29DYEvaG7fXfvIAoVEXGcsK7P3MSH4ob
         jem8c1Xq3OpqUXAZ3EKDqXlQ7q96ZI9hIPtKUk+mjrqM4VfICal3NA36wvunNV7fA2nI
         w9sWySWm5QSdBqj2I2tESA1xU/ChNIqwBedglhMpPCy6cLpxOznMPJmBNqJPqpnE+Jx7
         CRyih3wKi/2Q1ZH6IpY1hLSsUGTUKQiHFYN2S8n3KJrNUdZaYppQAGmuZ3EWeNls8dMW
         vlQ0pF9/nxaLWwPiKfUS/PQEmxjNREIICn5iqHFszKfilRMzyK0bw/3zk+ofLcoBYSHr
         gU4A==
X-Gm-Message-State: APjAAAWMCB3Z5QholXRx+ObHZM0a+IQa14ZJltYLmD5r2tULl85RpY22
        CYcNX2zUuhDNJsrwmPbCmy8MYcuurGdTEmAX4zJYexw/
X-Google-Smtp-Source: APXvYqx8S5FD+Ux3YSrGoi0qZyuykRlHRtyiFCdE5DtILnk9HDtP7svvgXTVVgWJFVxNL5nmzVSAtWy4GXiwHO+RWzU=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr1183996wrp.236.1582762421133;
 Wed, 26 Feb 2020 16:13:41 -0800 (PST)
MIME-Version: 1.0
References: <cc151941-15c1-b15f-04ba-a2085724aa10@dubiel.pl>
In-Reply-To: <cc151941-15c1-b15f-04ba-a2085724aa10@dubiel.pl>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Feb 2020 17:13:25 -0700
Message-ID: <CAJCQCtT93kuFYM_j2WNR82bz79Af_J4S+WcqDZr_y=M-JWjtkw@mail.gmail.com>
Subject: Re: Newly added disks not used after "soft" rebalance, not used after
 rebalance < 1%
To:     Leszek Dubiel <leszek@dubiel.pl>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 26, 2020 at 7:45 AM Leszek Dubiel <leszek@dubiel.pl> wrote:
>
>
> Added /dev/sdb3, /dev/sdd3 and /dev/sdf3 to btrfs filesystem:
>
>
> Label: none  uuid: 44803366-3981-4ebb-853b-6c991380c8a6
>      Total devices 6 FS bytes used 8.20TiB
>      devid    2 size 5.45TiB used 4.36TiB path /dev/sda2
>      devid    3 size 5.45TiB used 4.36TiB path /dev/sdc2
>      devid    4 size 10.90TiB used 8.71TiB path /dev/sde3
>      devid    5 size 9.06TiB used 0.00B path /dev/sdb3 <<<
>      devid    6 size 5.43TiB used 0.00B path /dev/sdd3 <<<<
>      devid    7 size 3.61TiB used 0.00B path /dev/sdf3 <<<<
>
>
>
> Filessytem df looks good 20T of filesystem:
>
> root@wawel:~# df -h /
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/sda2        20T  8.3T  9.2T  48% /
>
>
>
> But disks seem to be NOT used by btrfs:
>
> root@wawel:~# btrfs dev usag /
> /dev/sda2, ID: 2
>     Device size:             5.45TiB
>     Device slack:              0.00B
>     Data,RAID1:              4.28TiB
>     Metadata,RAID1:         89.00GiB
>     Unallocated:             1.09TiB
>
> /dev/sdb3, ID: 5
>     Device size:             9.06TiB   <<<<  no data usage?
>     Device slack:            3.50KiB
>     Unallocated:             9.06TiB
>
> /dev/sdc2, ID: 3
>     Device size:             5.45TiB
>     Device slack:              0.00B
>     Data,RAID1:              4.28TiB
>     Metadata,RAID1:         83.00GiB
>     System,RAID1:           32.00MiB
>     Unallocated:             1.09TiB
>
> /dev/sdd3, ID: 6
>     Device size:             5.43TiB <<<<<<<<????
>     Device slack:            3.50KiB
>     Unallocated:             5.43TiB
>
> /dev/sde3, ID: 4
>     Device size:            10.90TiB
>     Device slack:            3.50KiB
>     Data,RAID1:              8.55TiB
>     Metadata,RAID1:        162.00GiB
>     System,RAID1:           32.00MiB
>     Unallocated:             2.19TiB
>
> /dev/sdf3, ID: 7
>     Device size:             3.61TiB   <????
>     Device slack:            3.50KiB
>     Unallocated:             3.61TiB
>
>
>
> Newly added disks seemed not to be used... So I've done:
>
> btrfs balance start -dconvert=raid1,soft -mconvert=raid1,soft /
>
>
> It didn't help. So I used:
>
>
>
> root@wawel:~# btrfs balance start -dusage=0 -musage=0 /
> Done, had to relocate 0 out of 9050 chunks
>
>
> then:
>
>
> root@wawel:~# btrfs balance start -dusage=1 -musage=1 /
> Done, had to relocate 106 out of 9050 chunks
>
>
>
> And I still don't see any usage of the devices...
>
>
> Shall I activate these newly added block devices somehow?
> Those 106 reallocated chunks should have been put to new devices, right?

Only if you do a full balance. It's not strictly necessary, and may
not be advantageous, but that depends on the workload. As you start
writing, eventually Btrfs will allocate a new raid1 block group, and
it will pick the devices that have the most free space. That suggests
/dev/sde3 and /dev/sdb3. They'll be used for quite a while, until one
or two other disks have the most free space remaining, and then
they'll accept the writes.

So you can let Btrfs balance them lazy style by doing nothing. Or you
can do a full balance to balance them now, which might take ~50 hours
depending on the performance of the drives.

-- 
Chris Murphy
