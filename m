Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16363C3C14
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jul 2021 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhGKMDF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Jul 2021 08:03:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:43243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhGKMDD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Jul 2021 08:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626004814;
        bh=EqapEuczmDM2Te3p4LAN/Zq41z1sx57PuL7wtVQ3w/E=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TnrB/8sRqswd+FVTdCS0rIn56ZUOcm6WjEZ/4X11hXSKDcYsKlZD17s9un+6kFuwv
         NJqcnC8wuMznvHQFapZrazo7dj/PWwS9nUpTvBe64lw4riSI/5vqdnUgFRl/QDw5fc
         ZB5OlJbiC7sxzB2Nxd4AjA+pXfSxO43ToEFLniI0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPGW7-1loQQS48Dt-00PaVS; Sun, 11
 Jul 2021 14:00:14 +0200
Subject: Re: btrfs cannot be mounted or checked
To:     Forza <forza@tnonline.net>, Zhenyu Wu <wuzy001@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
 <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2a9b53ea-fd95-5a92-34a5-3dcac304cec1@gmx.com>
Date:   Sun, 11 Jul 2021 20:00:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NXd6nmn02udL+vAthKu9/Oom2E/HW5VVokDDG7M9HEYylsGdV9f
 egzyisMujjXi1+XgQY4Mnco7Tu7oBKyrv/QumSn8fwCqmCVFvydmwW0RfnrtRKVeiUiavCX
 TeYjOhyejgUmuKOS6m/OP4B6VTm9GPL0xp3L6oKzbitd1TF5HQHatpTq6CzxwPVGvTGFDFj
 GT/Eey8Z7nVsiy14cMQuw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qOHR37OmsXo=:ocHH+Rm4hETrJg7J+3Y2BO
 oVKDzidrWj9IO1/aNJJv4bDDMJNjiGYo/38gLk7/IHnTHsZoxFhQcBo92205ua8tupl56rcOr
 CW4bgww8aGhG6iOZrJK0idAd++EL7Bu3B6adhhEEX+E4iMMCDF8OcbAf2Z/OBu+TJ1fdNXGNh
 vuy7MahcS75OOhjx6qsXoA78aSsTmLPovrHAtbHkHx/g6uu15Y0HOpkF2lp6pH207gCs25r1u
 Tuiu9WriSpmrXds48aQHM7ksBLY4GGgp1oSWpFFfxL++aje0S1MiHBUEQJkwT6yHjs0JK5dEu
 GL/L3MmOG7Gc1lAHZEdE9l7TAFdqGg0kG5zxB8qQdoFEvfYk2XEpiGp77uL0EogsYhP0bzVWq
 w7r05CL/niR1FwwtO088GHhsO8mLa9guJqR5gz9CBdD1uzeXjZKPxcCW0FdTxCZtvcTF/CJde
 To3fjgqbtn87yN1zgKKDc0MGSxe8UsW3ulr2w/5ph4SUbLqvCvavMd2d99X6NVO0e+yblXj13
 bjmvPVgPVdXuNajAxYfyA9OMDkpUmzoHhjNqCRXTtamkcO63Fz4vHFAVZClQ3g/pVhhHbumY2
 IFsqmAvP39Qm09WvrlPTTHt+Z2dmTSu/q0YWkUulss1HlgTksDCAk4XLbj5nwH/gg5m0ydReg
 E0H5aSugtQyRuW0UQFkvOID/qlgVTrhXcZeBNeQJxNQVHVo0mdduRzVp3+M4bpptjY8eMOudf
 Xhzd5bt+wu5NjGV6BSy9CoZpwsBLytxqc+eK2dRmv4UZsUOoXND43PrQt4CnxlRb8bvShel1I
 RHFjru7dUt3ejOd8rHgLY24K5ytpq7Ri9JrOsCtSOfdONmIMpRWSLyFuA+2htnlHw0QU9pClD
 mdaM2o+gWWIf80H6YN9iDG+3hsTiXge+/YMw8RMJZzWg201h3wegs/OFMbvLClAVmqbCaGLxA
 Q65TgSN2w+VwB7qGrnff/Mc+/w83bhHAZrPp3mou5K4j74wmDiywIqDFRWABvjYhxUw04VNxK
 1MrjBQ2pVlpx+sDYWJK1rrMoaHu2YzqOQC81/1Q5TJUUUypyUg4KH1xc52MBuGGj6aJ1gVK4w
 Mpo0n7f3bNd4naPnDyF/vpEr0LmjJbmC/Ha7JTm7L/IF/kHR0LAab/VRg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/11 =E4=B8=8B=E5=8D=887:37, Forza wrote:
>
>
> On 2021-07-11 10:59, Zhenyu Wu wrote:
>> Sorry for my disturbance.
>> After a dirty reboot because of a computer crash, my btrfs partition
>> cannot be mounted. The same thing happened before, but now `btrfs
>> rescue zero-log` cannot work.
>> ```
>> $ uname -r
>> 5.10.27-gentoo-x86_64
>> $ btrfs rescue zero-log /dev/sda2
>> Clearing log on /dev/sda2, previous log_root 0, level 0
>> $ mount /dev/sda2 /mnt/gentoo
>> mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
>> /dev/sda2, missing codepage or helper program, or other error.
>> $ btrfs check /dev/sda2
>> parent transid verify failed on 34308096 wanted 962175 found 961764
>> parent transid verify failed on 34308096 wanted 962175 found 961764
>> parent transid verify failed on 34308096 wanted 962175 found 961764
>> Ignoring transid failure
>> leaf parent key incorrect 34308096
>> ERROR: failed to read block groups: Operation not permitted
>> ERROR: cannot open file system
>> $ dmesg 2>&1|tee dmesg.txt
>> # see attachment
>> ```
>> Like `mount -o ro,usebackuproot` cannot work, too.
>>
>> Thanks for any help!
>>
>
>
> Hi!
>
> Parent transid failed is hard to recover from, as mentioned on
> https://btrfs.wiki.kernel.org/index.php/FAQ#How_do_I_recover_from_a_.22p=
arent_transid_verify_failed.22_error.3F
>
>
> I see you have "corrupt 5" sectors in dmesg. Is your disk healthy? You
> can check with "smartctl -x /dev/sda" to determine the health.
>
> One way of avoiding this error is to disable write-cache. Parent transid
> failed can happen when the disk re-orders writes in its write cache
> before flushing to disk. This violates barriers, but it is unfortately
> common. If you have a crash, SATA bus reset or other issues, unwritten
> content is lost. The problem here is the re-ordering. The superblock is
> written out before other metadata (which is now lost due to the crash).

To be extra accurate, all filesysmtems have taken the re-order into
consideration.
Thus we have flush (or called barrier) command to force the disk to
write all its cache back to disk or at least non-volatile cache.

Combined with mandatory metadata CoW, it means, no matter what the disk
re-order or not, we should only see either the newer data after the
flush, or the older data before the flush.

But unfortunately, hardware is unreliable, sometimes even lies about its
flush command.
Thus it's possible some disks, especially some cheap RAID cards, tend to
just ignore such flush commands, thus leaves the data corrupted after a
power loss.

Thanks,
Qu

>
> You disable write cache with "hdparm -W0 /dev/sda". It might be worth
> adding this to a cron-job every 5 minutes or so, as the setting is not
> persistent and can get reset if the disk looses power, goes to sleep, et=
c.
