Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3F321C403
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jul 2020 13:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgGKLjF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jul 2020 07:39:05 -0400
Received: from mailrelay4-3.pub.mailoutpod1-cph3.one.com ([46.30.212.13]:17818
        "EHLO mailrelay4-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbgGKLjF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jul 2020 07:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:to:subject:from;
        bh=Wt0fWl5iDIJehgclAm5fr9JKyaMHKqTjT+uKcJxn8w8=;
        b=S89etDFmhI3UgXeufNjaRUeUaoE6GVjkyLT8JS6aGjfETVeEc3v02Xi19+13IX3bhJ5hdMN6mmSgc
         BKdHmnyw8wOxeNx8HL+Fe2mlc2vyYZcJ0qQtSLblqwmB/qA5wsAkXfy0pZTcLExV60UIntXMDpbylA
         FASB97dp5T+SY9MHTi52pyC8jnyeJfc6ToaChJge9Llx77EFcwaLaiB9QGAi9xaNa6vvDeZ4336gdu
         dUKew1t6Ueo7mNzcJyQwDpqGPCL0VJ0p7AWdE2muqFr6RspOE2NX6rdxPft+V3j6sgQYvXWBaq0pbB
         wnsoSoMIMbSBfp3KnDMUtjdU6Tza9yQ==
X-HalOne-Cookie: bdd34c3237860d34f7a477036999f3ea5fe8cda7
X-HalOne-ID: 1d91112b-c36b-11ea-9b1c-d0431ea8bb10
Received: from [10.0.88.22] (unknown [98.128.186.116])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 1d91112b-c36b-11ea-9b1c-d0431ea8bb10;
        Sat, 11 Jul 2020 11:39:01 +0000 (UTC)
Subject: Re: raid0 and different sized devices
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtRfXy9YDqZQgYz0_djd78oEMwiYY7Og2x=J=w361FENWg@mail.gmail.com>
From:   A L <mail@lechevalier.se>
Message-ID: <0326afd3-9e14-b682-30e7-1c8ae44813ea@lechevalier.se>
Date:   Sat, 11 Jul 2020 13:39:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRfXy9YDqZQgYz0_djd78oEMwiYY7Og2x=J=w361FENWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-07-11 03:37, Chris Murphy wrote:
> Summary:
>
> df claims this volume is full, which is how it actually behaves. Rsync
> fails with an out of space message. But 'btrfs fi us' reports
> seemingly misleading/incorrect information:
>
>      Free (estimated):          12.64GiB    (min: 6.33GiB)
>
> If Btrfs can't do single device raid0, and it seems it can't, then
> this free space reporting seems wrong twice. (Both values.)
>
> Details:
>
> # uname -r
> 5.8.0-0.rc3.20200701git7c30b859a947.1.fc33.x86_64
> # btrfs --version
> btrfs-progs v5.7
>
>
> # btrfs fi show
> Label: 'fedora_localhost-live'  uuid: 1fa3ab85-2dec-46f8-9a35-264c0f412dcc
>      Total devices 2 FS bytes used 885.83MiB
>      devid    1 size 730.00MiB used 709.00MiB path /dev/vda3
>      devid    2 size 13.30GiB used 709.00MiB path /dev/vdb1
>
>
> # df -h
> Filesystem           Size  Used Avail Use% Mounted on
> /dev/vda3             15G  905M   60M  94% /mnt/sysroot
>
>
> # btrfs fi us /mnt/sysroot
> Overall:
>      Device size:          14.01GiB
>      Device allocated:           1.38GiB
>      Device unallocated:          12.63GiB
>      Device missing:             0.00B
>      Used:             901.58MiB
>      Free (estimated):          12.64GiB    (min: 6.33GiB)
>      Data ratio:                  1.00
>      Metadata ratio:              2.00
>      Global reserve:           3.25MiB    (used: 0.00B)
>      Multiple profiles:                no
>
> Data,RAID0: Size:890.00MiB, Used:870.08MiB (97.76%)
>     /dev/vda3     445.00MiB
>     /dev/vdb1     445.00MiB
>
> Metadata,RAID1: Size:256.00MiB, Used:15.73MiB (6.15%)
>     /dev/vda3     256.00MiB
>     /dev/vdb1     256.00MiB
>
> System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
>     /dev/vda3       8.00MiB
>     /dev/vdb1       8.00MiB
>
> Unallocated:
>     /dev/vda3      21.00MiB
>     /dev/vdb1      12.61GiB
> #
>
The problem is no unallocated space on vda3, so there is not enough 
space to allocate another RAID chunk.RAID0,RAID1 and higher requires 
that block groups are allocated on minimum of two devices.

You could convert to DUP or SINGLE profile to free up space and then do 
a full balance.


