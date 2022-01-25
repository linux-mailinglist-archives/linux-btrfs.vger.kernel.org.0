Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7C749B270
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 12:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352502AbiAYK71 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 05:59:27 -0500
Received: from mout.gmx.net ([212.227.15.18]:39553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379684AbiAYKzy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 05:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643108145;
        bh=v+1VeN97IrVDTON32gvJTLqg60AysRebEWMrlq9ZNWI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FRFTxhYTPGEcBybptJIXcYiP9+LyQV+03fuEVUSmL+35KHxqpK5HMrkpsdj+qsR6d
         VvN0j8idthHjUR4oufaO4r9Y6/ZODEo+p16ymVSvJBV6jQTEUbELCqTIBxlIeJ+fXv
         Hn9hPDrqY4408hPV+CY4pTnLvFu0H2NneU1ywPbE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNbp3-1mw0cd0wEF-00P8se; Tue, 25
 Jan 2022 11:55:44 +0100
Message-ID: <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com>
Date:   Tue, 25 Jan 2022 18:55:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper
 defrag
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220125065057.35863-1-wqu@suse.com>
 <Ye/S15/clpSOG3y6@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Ye/S15/clpSOG3y6@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R7peluf9hxPcWXREOlPhImJ9blcluxkNHsolsGqarr/oJPYziwJ
 kFacZaxPrY7DhZ5ZiDhlccBdT+Txxf9rFHwskLhcba0Kv4F1P/MvE+u5n/k2pOMB4uB43Ne
 4tDvkrDRHTh9RKxvEKmCBl+tvVv7GvjBQ667wUpLUITYx/dIhcC/UphmB/XE2W0qxFnSeb2
 Qrkp2Vy+B1XexS0tI3Lug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q8afxsIdPds=:ODR3+o33eSi7q6MCB6ZCHH
 KqgnXHfd1NWuGJ1Dm+m5V6ocMLBLNN72md9gM+BFnWNXFbolpyIxSKZPVCB6tw6A3z9Z1H3v4
 YOGSkSTIdq1W9t5dS50YHBUXXB2bvkxgVS8bYtM9ZUBWoMdbM2/ir2olBjAptcpf0T+J31zmB
 gNQqx5tYHlaCAZDuTBe5Fd57At0S1q4D7/+2njg+TbqBXD9kWfVXmRky1eHxi/nlcnLqNeBCM
 LZKpzz45ZFueSy4ghtg2CcilEN+cKYp7aAl3/JL7DnZ403NaqKabSjVfkVJhx/VDQQOusOzqi
 9q9p5iaZo0TKwYvX4D/mgbHjvMA8Noy4UGyYMKIwR2W7V1XntUwk+2xGG3gtSpnBnApVhZNxx
 JCnKIPtgWMpqeGJPL2UiNNq/WMVOxdsT6j1jFuS3QOmk21r4k3ZXcFvy7UwLcWU5sy99BsIPv
 jNsHyziS98Bggf6R8sZvCD9+LSdvzJ3Uv3lDj1e7wEecwdS12o8PId+dC/2Mj+ZS+xmNaAJXu
 XozJiF4roeVe431rZDJoouOKMlN/fetbDK8Kb3rLgj1UT49TIMJooMiXhvEi+ojbXf/9+g52y
 jIm+7nCYZUP7p/reUpO+3Jcm7BOnq6KZ8NsEZZJ72vXR9ORI6hHwTShN6qmwuqNdLcwoLOlaS
 6IBStLrU1iR/SIjij1mqYAmsFK/0E0OmjeXhLMKuEsHxiITRHXg/78LMlslTL9480h5tfDAWZ
 KcHTtRlAvhGi2HkYTFc6PtPVxIb/nc8/7UYO/Sp0qbIWW3PjKskjpNP7dg2z2UIZOz8DmKcb1
 szSr8qZVCSe5GdN8fzDzo7VbsiP9szsYbJZLmVi7vvefVO7PlTjdsKI/Zj6gktx16NjB6sV4c
 5Ath75gqVJ3woTiEKj+IRGSm7WrO3vfTw5yGcoPzF+BB61ozMwPMLL5sG5DHFvULZaXtaPqG1
 jFYDODm0yCFSpCT3bG9KaTDcRxy+45sl1V2d24kGJykYUvgEge4bAencUh0zGctH9IvbVmNfJ
 BMAJ79ef+FyZvVciN2SrMBGsRBqcKwoUnDa1816nSWSA2JohMKcisMcSoV+B4CelZxYOD//6Q
 0TCD5Bkv0U4feg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/25 18:37, Filipe Manana wrote:
> On Tue, Jan 25, 2022 at 02:50:55PM +0800, Qu Wenruo wrote:
>> ** DON'T MERGE, THIS IS JUST A PROOF OF CONCEPT **
>>
>> There are several reports about v5.16 btrfs autodefrag is causing more
>> IO than v5.15.
>>
>> But it turns out that, commit f458a3873ae ("btrfs: fix race when
>> defragmenting leads to unnecessary IO") is making defrags doing less
>> work than it should.
>> Thus damping the IO for autodefrag.
>>
>> This POC series is to make v5.15 kernel to do proper defrag of all good
>> candidates while still not defrag any hole/preallocated range.
>>
>> The test script here looks like this:
>>
>> 	wipefs -fa $dev
>> 	mkfs.btrfs -f $dev -U $uuid > /dev/null
>> 	mount $dev $mnt -o autodefrag
>> 	$fsstress -w -n 2000 -p 1 -d $mnt -s 1642319517
>> 	sync
>> 	echo "=3D=3D=3D baseline =3D=3D=3D"
>> 	cat /sys/fs/btrfs/$uuid/debug/io_accounting/data_write
>> 	echo 0 > /sys/fs/btrfs/$uuid/debug/cleaner_trigger
>> 	sleep 3
>> 	sync
>> 	echo "=3D=3D=3D after autodefrag =3D=3D=3D"
>> 	cat /sys/fs/btrfs/$uuid/debug/io_accounting/data_write
>> 	umount $mnt
>>
>> <uuid>/debug/io_accounting/data_write is the new debug features showing
>> how many bytes has been written for a btrfs.
>> The numbers are before chunk mapping.
>> cleaer_trigger is the trigger to wake up cleaner_kthread so autodefrag
>> can do its work.
>>
>> Now there is result:
>>
>>                  | Data bytes written | Diff to baseline
>> ----------------+--------------------+------------------
>> no autodefrag   | 36896768           | 0
>> v5.15 vanilla   | 40079360           | +8.6%
>> v5.15 POC       | 42491904           | +15.2%
>> v5.16 fixes	| 42536960	     | +15.3%
>>
>> The data shows, although v5.15 vanilla is really causing the least
>> amount of IO for autodefrag, if v5.15 is patched with POC to do proper
>> defrag, the final IO is almost the same as v5.16 with submitted fixes.
>>
>> So this proves that, the v5.15 has lower IO is not a valid default, but
>> a regression which leads to less efficient defrag.
>>
>> And the IO increase is in fact a proof of a regression being fixed.
>
> Are you sure that's the only thing?

Not the only thing, but it's proving the baseline of v5.15 is not a
reliable one.

> Users report massive IO difference, 15% more does not seem to be massive=
.
> Fran=C3=A7ois for example reported a difference of 10 ops/s vs 1k ops/s =
[1]

This is just for the seed I'm using.
As it provides a reliable and constant baseline where all my previous
testing and debugging are based on.

It can be definitely way more IO if the load involves more full cluster
rejection.

>
> It also does not explain the 100% cpu usage of the cleaner kthread.
> Scanning the whole file based on extent maps and not using
> btrfs_search_forward() anymore, as discussed yesterday on slack, can
> however contribute to much higher cpu usage.

That's definitely one possible reason.

But this particular analyse has io_accounting focused on data_write,
thus metadata can definitely have its part in it.

Nevertheless, this has already shows there are problems in the old
autodefrag path and not really exposed.

Thanks,
Qu

>
> [1] https://lore.kernel.org/linux-btrfs/CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3D=
FFk2iK1X6OyyEWG5-mg@mail.gmail.com/
>
> Thanks.
>
>>
>> Qu Wenruo (2):
>>    btrfs: defrag: don't defrag preallocated extents
>>    btrfs: defrag: limit cluster size to the first hole/prealloc range
>>
>>   fs/btrfs/ioctl.c | 48 ++++++++++++++++++++++++++++++++++++++++++-----=
-
>>   1 file changed, 42 insertions(+), 6 deletions(-)
>>
>> --
>> 2.34.1
>>
