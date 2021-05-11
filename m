Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BE937A268
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 10:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhEKIpr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 04:45:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:48963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhEKIpr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 04:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620722672;
        bh=4yQc+rBff6PRq91jkXcsAhLZnOklA4I/vpG+8ie2nmY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VaZE6wr4hOods62kCC42V6OxCoLOWY5tUZF80VFZYO7j7Mq/XG9/aX1XxOpyUZKKa
         Eyb6QGDD42/IU03A4WV7NvKDYDcMIuu48+8m0zrHb8drxBM8NKszUC/cqaZhvrL3N9
         2Xz2pRUhgDJRCEef+0PJNJtXf/E97L8X49Nk4lfQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5G9t-1lZ4DS1sGr-0119KT; Tue, 11
 May 2021 10:44:32 +0200
Subject: Re: Leaf corruption due to csum range
To:     Wang Yugui <wangyugui@e16-tech.com>, Philipp Fent <fent@in.tum.de>
Cc:     linux-btrfs@vger.kernel.org
References: <93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de>
 <20210511161806.B601.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <36f2cb11-e87e-2eb6-56e2-19c87b061b49@gmx.com>
Date:   Tue, 11 May 2021 16:44:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511161806.B601.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EjtEWkV2Mqp+/jMswcauSOcgbnq049DMwbpWd0wB5X0Zy+mdGbL
 S0g6B1C1iuvPq5w8vmIPVANvxDHvc07S7NSpnMy9AYaE9Mb7pQel+pVbctnli0c1UArBOxO
 /tNChfQjpjbFLULAeQQ/6HBiPRYnj5xnAq6Gaywz8JvFeWX9cI0q8gJWWPBoeK5Q4BODTxn
 Z8c6cRoqww86Msvy8i+0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tWXxEzrMD/U=:F6kR2DvfuiVGTkNQHfAg2U
 OjqIVXjaqt0svTYSXzlUCCTZQiHFXs1h6+xgpj5mKY/N5dNDLCpzPmzeEXws4uOWIu5KDSMeq
 fM04m8Chauy3MGolXMqNkUBfTY9fX07mq7z4lniwKBTaE7um3CxNS6GVTDoAXDc4nYznnJU/s
 LAlCoB/jJ0vffWZ2hmlQLIzFJP06yZngv107UnQv+KcLJuma+0aisEqh+xb7ghyX7H/oXmeGV
 E6ss5BGQ1GkqbtvjjotuiwPzLXqmqVyODOb+KIos7jaQZ0eHIIGk+KM2HH/a5vKZJ2jOzAsmd
 GvbL+TSVuvM6Hh4x5NkPYSF6rJhnQCswmGZ9PEQwlb/NPVT66VyjEDdrrWWtyZCLVNy5e6GQs
 7F/3L8IDWbvl0m39lUiJ1cZ9jAp8VA2cl5BNL9d3jRmFwiNvQl2C2+1IXcuUrva2GkNGb/kVR
 fvYu1Tqz9KEKnvshvDf5NPB6YPDoG8pSsELWlrpEAnc2+65BbLLS3521vb+6kII9C175nxCyS
 Zwt0O4iQh0B0Vm965u3veQPeFKr6YROuecPzf7QptLOz06MZU7azjV11ovHUQ8vBbw2zQFX2G
 9cgujwj6idM4aTg4ChU/z/WsFRY+8qbkqAv1Bm9HklFbnOLyiRSQmDx7rQLg3j5zr8Qq2kKKu
 W5uFisbg3CNn/NhsvJiluYF51VIntbkz1uN+KI7Lp6eF6GPeqtL5yBVJAERV1dEPTS3W67+iW
 2eUTGSRKXG5HDqFxYnoiaoSxv+GFg1OX60AYtfPpoKtSeERkyqNCKyuRWCyhvt9DF2w2YaSWY
 wlJOb34JQcpNgofCICxdnGiH9FNi+pYYgxL9ZIxFVt3ZsrVtpiniKv6gea8AFSY+0e2LEUYjw
 7Wg8uYzGd/X8wrCO8pmMyZwl2dtW+3zH+ih2mQ+st2nZEz14xH2dYWXsjtJdOwnVL0iXbLQNo
 dVtGsxflaKb6uzR5L3OpQu7deWrGO5GnNqZYmHyesgqEnwzq6+UUw1YjkvFxPK3NCvgF2Kn1Z
 jJB8XtPB8QnetBUi6VBbEB9XZsbcWvizebPOG2MiwJr/WCF2mRQuD0atyNbLHotsT3nmZgH8T
 YyccxHiAb8gp3Q0uA3W5C98A1+Dd83J0eMt5BZYkSlouKH1knmW+wTwH06939/U9zZuvpS3Ot
 OmO5ieYh4a+EioCftAtdJDeefZa/Yu9aT0LTfUkIH/yrRkPZ8LCXo/7Epjd6tVLEsTfiHmpDj
 fN5SWTkpCdv2oY8QO
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/11 =E4=B8=8B=E5=8D=884:18, Wang Yugui wrote:
> hi,
>
> the last 'write time tree block corruption detected' is marked as
> memory ECC error.

So ECC can failed to recovery the bitflip?

Now I can't even rely on ECC memories nowadays?
(At least tree-check rocks again)

Thanks,
QU
>
>   From:    chil L1n <devchill1n@gmail.com>
>   To:      linux-btrfs@vger.kernel.org
>   Date:    Sat, 6 Mar 2021 10:10:11 +0100
>   Subject: btrfs error: write time tree block corruption detected
>
> Is this a server with ECC memory?
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/05/11
>
>> I encountered a btrfs error on my system. I run Microsoft SQL Server in
>> a docker container on a btrfs filesystem on an SSD. When bulk-loading
>> some benchmark data, my system reproducibly enters in the following
>> failing state:
>>
>> [  366.665714] BTRFS critical (device sda): corrupt leaf:
>> root=3D18446744073709551610 block=3D507544305664 slot=3D0, csum end ran=
ge
>> (308900515840) goes beyond the start range (308900384768) of the next
>> csum item
>> [  366.665723] BTRFS info (device sda): leaf 507544305664 gen 18292
>> total ptrs 4 free space 3 owner 18446744073709551610
>> [  366.665725]  item 0 key (18446744073709551606 128 308891275264)
>> itemoff 7259 itemsize 9024
>> [  366.665727]  item 1 key (18446744073709551606 128 308900384768)
>> itemoff 7067 itemsize 192
>> [  366.665728]  item 2 key (18446744073709551606 128 309036716032)
>> itemoff 2587 itemsize 4480
>> [  366.665730]  item 3 key (18446744073709551606 128 309041303552)
>> itemoff 103 itemsize 2484
>> [  366.665731] BTRFS error (device sda): block=3D507544305664 write tim=
e
>> tree block corruption detected
>> [  366.665821] BTRFS: error (device sda) in btrfs_sync_log:3136:
>> errno=3D-5 IO failure
>> [  366.665824] BTRFS info (device sda): forced readonly
>>
>> Please note the erroring ranges:
>> csum end:   308900515840
>> Start next: 308900384768
>> which is a difference of (1 << 17) =3D=3D 0b100000000000000000 =3D=3D 1=
28KB
>> To me, this looks suspiciously like an off-by-one error, but I'm not to=
o
>> versed in debugging btrfs.
>>
>> I reproduced this several times on my machine using the attached
>> scripts. The only obvious similarity between the crashes is this 128KB
>> csum end / start next. Sometimes a get one corrupt leaf, sometimes many=
.
>> I tried to reproduce it on another machine with an HDD, but didn't
>> encounter this error there.
>> Can you help me to debug this further?
>>
>> # uname -a
>> Linux desk 5.12.2-arch1-1 #1 SMP PREEMPT Fri, 07 May 2021 15:36:06 +000=
0
>> x86_64 GNU/Linux
>> # btrfs --version
>> btrfs-progs v5.11.1
>> # btrfs fi show
>> Label: none  uuid: 6733acf5-be40-4fe2-9d6f-819d39e49720
>>          Total devices 1 FS bytes used 187.11GiB
>>          devid    1 size 931.51GiB used 208.03GiB path /dev/sda
>> # btrfs fi df /ssdSpace
>> Data, single: total=3D207.00GiB, used=3D186.67GiB
>> System, single: total=3D32.00MiB, used=3D48.00KiB
>> Metadata, single: total=3D1.00GiB, used=3D450.08MiB
>> GlobalReserve, single: total=3D215.41MiB, used=3D0.00B
>
>
