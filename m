Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A39BD8A1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 09:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbfJPHqH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 03:46:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:36809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfJPHqH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 03:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571211959;
        bh=RgUPt1Vi5xpPejCiizhkaGChyb6X2yw1yAApYKFHhmI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XRI5HCeEmA6WArw8vNFsF0vW070w2WB0wo+GEKVxBYc06AKrVWEQb8qwM45xOyJ0s
         8srV28KntoxpTpW0ptt5yhPKQ7F1q2LzvdOn7w/uaA7ifwVb+Z4LJE+q5Gnf/06UQx
         MW3AR2wuYzc2Wf0aE7UJz5DXb+h3QSZ5tUuFKeaA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK0X-1i37Bf3Dm5-00rITC; Wed, 16
 Oct 2019 09:45:59 +0200
Subject: Re: kernel 5.2 read time tree block corruption
To:     Nikolay Borisov <nborisov@suse.com>,
        =?UTF-8?Q?Jos=c3=a9_Luis?= <parajoseluis@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CADTa+SqDLtmmjnJ5gz-3jDxi1NGNAu=cyo0kFXSZfnu6QE_Fdw@mail.gmail.com>
 <66e27fee-7f64-6466-866d-42464fca130f@gmx.com>
 <a6d7a4c6-4295-e081-1bfc-74e9d13fd22d@gmx.com>
 <CADTa+SrurdZf5+T+QGNyLc7gKLuTFYsto+L4Q+30y-uQj+jutg@mail.gmail.com>
 <3e7acddf-6503-7746-db4b-a116b7f89c4d@gmx.com>
 <CADTa+SoDEcHvpJj6-QMHUubFcKACiKLQ6izr=uER-hYtqVg20g@mail.gmail.com>
 <0cae0d30-db18-37cc-562f-100c862099e3@gmx.com>
 <ab485a5a-04b4-a117-9b94-902f7dbcf8d4@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <375ce380-7b7d-03e5-212a-197d8cc2d5fc@gmx.com>
Date:   Wed, 16 Oct 2019 15:45:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ab485a5a-04b4-a117-9b94-902f7dbcf8d4@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Du6Vi6BRTrg/kWPoyOjk3TrI5kDX2fjaMBWCFvrJRggApSXRxAW
 6UBeTVEQMEnx8/PGvboAFk0IS06/PVN8VZgHXIJbp3y70cremAYIu9f1uq9hAwfT5K4cyJf
 zu/+oxgxpuVbazDfOa6pUKqyYYVsUbYymmj1pklRDOwayGy/Kp7BL440QaJtEURDP2wTHC7
 JYk9P1LXpPJ6amlOc1EZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yWs3irsjXRU=:t0wC38gKAsvP/513p8apEK
 Wqovb6VTqX4Z3r5jEg9m5CJe6Q1s62oFI1AVFk9boLwzX3S8FgIfg3nmb9U6Pe9f0Pvirz9uB
 ACs9unKfisA1SlmSV6lezT0m5GNN8l3xPZDOvwWx+wwohH2cUtSHgGPhPwDpUPDhzBS4uelFD
 Z34ecjstJwvqiJtlCFfYNW/iswXwhRMb/HDIwHluR8E2x2cWbM6XE5dPvL00DV5c2E9bcXUot
 vghF6zzY1/bPSP12fx2esPOJq7hTMB9YS4R2TSBWxin64vGy17ebj2mfOpdGYVuGqMB2zeOrN
 rXz1Pm470luyYTjR3fgl6LyhoAsB7PQNdR6QeEQxUDd4nzMdxVPeUUjKGSh9L62hgQgC3uFhR
 Gk3UA3/4lrCAYkIK4beVDO1XVaoXd+wpHLFf4TKT124OuLucDVRuEQurRKLkVE754zA7AvB6U
 0KOP6j9+AwI3WmKe3ivvtOMUzM6enNoDmzMoydEC/tb2+sxZDdNx6AobJoOek//wb+qlsnVQe
 RE7DguB5E071J+J1EkBZTehDv9puQkVWKCwkAQXEHI5+7xj1CT1H3ttcUzCrNc0Igxhnod1Dj
 MB0vXneUmoMqXQL+RxFtfOxxVUAVgdEGa0OlvseNL3GRgK4c4+jdpSZaApHnUh3H/C3j1lyP3
 vClMM5N8Kpxxm7IlqZk4fos1F/NmrnxxDMNvbpzof2kPOz3dumMO8Njun4hFD0FOZHm5NwMlK
 QaAGB+4imFfmhFRpeizD4Owe327KSxkszDlKH5WidVvWhCkNWCTLDB3bY25S/hEKkguK4IKTl
 BCpTHiE5wVF0L/qmIz1QE5oBl2O/DGFvKAFqclQUPs1AxxU0EQ+ZBvhMhB9Xg5ZPgdGGNf5wa
 2ufpUSbjEq0P52vSRM8onc1S6OwEtIoBEvBFVeTy/sZMsfwL1GJCWO3j6bvn890nZue/SVCTk
 3wnO7ZyFGto4xOZ9K2XIj9jP6/MBI4VpoER6Vr0LMG0SnYD1j2xV9Co/dcR7JXruMxF6ODgq2
 h3efjpRuaY76MNlbytjzdLDH/yiCgrlIk3ivIuUaIE0MeettduHUrG8O78KV2b+c+aYDkcgZx
 poDi+uEbJcDzU1bcpW8qrAsrZsFhitczOgkySk3UdtrrXp0qOtzKeHVb+N5hO7p4HLPaxeCxL
 VYIc4k6k4PtEcH/Vo3kRYuzFfWJNYrsmB0FCBFNmsb6EUWLlp+myuR8uUh1cHdWD9ImgC0eiU
 LMaPm9UQbjGb6K8p8UO6ANmqxg1suSY2SP6Je8yP7hx0/u761rQ5jXGLxOqw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/16 =E4=B8=8B=E5=8D=883:42, Nikolay Borisov wrote:
>
>
> On 16.10.19 =D0=B3. 3:43 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2019/10/16 =E4=B8=8A=E5=8D=881:55, Jos=C3=A9 Luis wrote:
>>> I also noticed the craziness of the previous dump. I cannot remember
>>> the kernel running by this date but I use to install the latest stable
>>> kernel on the Manjaro repositories (I'm an early adopter :P).
>>> According the Manjaro forum release news they roll up version 4.19 by
>>> these days so probably I was using kernel 4.19 or 4.18. Diggin on my
>>> memory, maybe I could access that filesystem from a Windows 10 running
>>> on another disk using the windows btrfs driver that could be the
>>> origin of the problem.
>>
>> That explains the problem why there are some strange windows related fi=
le.
>>
>> And that also explains why kernel tree-checker isn't happy about that a=
t
>> all.
>> Maybe Windows btrfs driver is using some strange inode number to do its
>> own work, but definitely not something friendly to upstream btrfs.
>>
>> You may want to report the bug to windows btrfs developers.
>>
>>>
>>> I added a \s to the pattern you provided to avoid undesired inode info=
rmation:
>>> [manjaro@manjaro ~]$ sudo btrfs ins dump-tree -t 5 /dev/sdb2 | grep "(=
431 " -A 7
>>> output --> https://pastebin.com/y3LzqNx6
>>
>> I see no obvious problem. Maybe some compressed data extent doesn't hav=
e
>> csum, then btrfs check reports it as bad file extent.
>>
>> Original mode doesn't report info as detailed as possible.
>> But anyway, it shouldn't be a big problem.
>>
>> If you're not confident about it, you can try to defrag those inodes, i=
t
>> should rewrite them and populate the csum.
>>
>>>
>>> Is there any magic command to repair my sdb2 filesystem? Or I have to
>>> backup data and rebuild those filesystems?
>>
>> In fact it's not that hard to repair, just remove the offending crazine=
ss.
>>
>> btrfs-corrupt-block should provide the ability to delete items.
>> It a tool included in btrfs-progs, but not provided in btrfs-progs
>> packages. You may need to compile it from source code.
>>
>> In your case, you need quite some calls to delete all the bad inodes:
>>
>> /* FREE_INO INODE_ITEM 0 */
>> # ./btrfs-corrupt-block -d 18446744073709551604,1,0 /dev/sdb2
>>
>> /* FREE_SPACE UNTYPED 0 */
>> # ./btrfs-corrupt-block -d 18446744073709551605,0,0 /dev/sdb2
>>
>> ...
>>
>> And so on. You need to parse the key output to numeric value and pass i=
t
>> to btrfs-corrupt-block, until all finished.
>>
>> If it's too slow, I could add a new hack into btrfs-corrupt-block to
>> delete them in a batch.
>
> Please don't. btrfs-corrupt-block is supposed to aid development not fix
> user problems. If it can fix them, by accident, then OK but it shouldn't
> be cluttered with code used in some _very_ specific cases.
>
> You can provide this code on your own accord but let's not merge it into
> the upstream btrfs-corrupt-block source code.

Of course, just as my usual dirty fixes (a special branch for the user
to do, never intended to upstream).

Thanks,
Qu

>
> <snip>
>
