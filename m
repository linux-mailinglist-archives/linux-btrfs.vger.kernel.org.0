Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4185F54
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 12:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389870AbfHHKNJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 06:13:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:45909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389793AbfHHKNJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Aug 2019 06:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565259176;
        bh=MwRqdCWItuAqMyguqVyj5ADbky7CE/cLBV9ePIjZTFk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GfQ4ZyulRefIPODrKOLToZYr1Tx7SCAOsCXaT45ED1xqjciqUaUVa34c5Adr1L7u7
         X93mt/BHH9hUeCRmQdD9KkFR0sLJlnhrmBlTkwEsV5WcB0W3HbAGROolLqE5ytsV4p
         ZSGuuUyHnuoyF0SO/4ifubqcT3Cocw1WxrjjeWGs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LbgyV-1iaTbZ0B6B-00lB6t; Thu, 08
 Aug 2019 12:12:56 +0200
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        Anand Jain <anand.jain@oracle.com>
Cc:     Lionel Bouton <lionel-subscription@bouton.name>,
        linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <f8b08aec-2c43-9545-906e-7e41953d9ed4@bouton.name>
 <02f206eb-0c36-6ba7-94ce-f50fa3061271@bouton.name>
 <6fb5af6c-d7b8-951b-f213-e2b9b536ae6a@petaramesh.org>
 <d8c571e4-718e-1241-66ab-176d091d6b48@bouton.name>
 <f8dfd578-95ac-1711-e382-7304bf800fb2@petaramesh.org>
 <c4885e92-937c-8fc7-625a-3bfc372e3bf5@oracle.com>
 <0bba3536-391b-42ea-1030-bd4598f39140@petaramesh.org>
 <a199a382-3ea4-e061-e5fc-dc8c2cc66e73@gmx.com>
 <e73421f5-444b-2daa-4c28-45f3b5db007c@petaramesh.org>
 <e952ed13-07d4-426e-e872-60d8b4506619@gmx.com>
 <BD134906-E79B-49D4-80C4-954D574CCC68@oracle.com>
 <54d0f80f-a7b8-8b10-f142-c9b60c9f0d7c@petaramesh.org>
 <69c47874-6608-2509-c059-659c4a1b6782@gmx.com>
 <22973d72-5709-c705-1c8d-1b438df1cc49@petaramesh.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <ae330c40-4cd5-2e1f-feae-210d7af85a70@gmx.com>
Date:   Thu, 8 Aug 2019 18:12:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <22973d72-5709-c705-1c8d-1b438df1cc49@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PTq+feOIu0+/nfyx8immIrx2by/tTVnHzQvCLYfInHQrLMEMHef
 zM5azG3QzRlj7FqMMPFopXNnlF3+9Im8ZZblfnUFD+1/Ck7V7Ams3HGBnGZU/ZdIrkKLCbh
 SLanaHJvt40BfIKkY+PZiGcJGiaux5sVM4I8dMlmfg2f4pDhU72ox+4rlsMXI5muNHFRrvQ
 1lN8noJTWSKJSjmbZRs0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O2hGGespFD4=:LYV/FmO2g3/G3EhCjOx1qG
 kZREFQM3gTkpWeDlXWd13FwYVQH/c177LWU50ctg7rVQHnQnNkYoWinOihAAnu3HjqXJ9jfFl
 36+O9i7xIAWOd9MypctkOUVilOrrYxf6iieIt/nPsUd6+rlKWfvVj20+rOF0+sabNZjjytslc
 3tJ0eUjbkCr18GayfdUmBVOZi/TWwECjMm7D7jhqTHXsdupUI7ufz43apv2RGAQqP0dX7WclV
 jbRXCYPUAFJThiCxTrk2+FG0izZXS5h8d7t7RXGjgCC6576F3jCec53ccCikkJeukMongSMUo
 SDff6V3qYkth3VVuakLo+NmLyk/xJXXLSBpb9gezYQ7ocjE++Bt5SdbUMN9shRaF/8XS/uj7P
 U+bcBENULrX1AbFTJIi0qwNP/Mu0KJxPRP6MKRS4t9S+R9iuwAE5OPbu/pjV15a/Bbt2sa7RS
 0rOrcvNt1mMCoJoCQAg93dGsNe6KEwe7CUTfunou+vy/gXtpEHff49OvnJ+/Z8gHB5V4kAnm6
 RZla2MNYLoFJgJeNaC0erNYH0X+vDU6Kybs941akPpRlk740K6QFRRyy8ELz87dZ/uBZZYRjS
 2H57THX5aWlyjcudtikpXPkvQmlYKNd+9StyBCcbDfz8zhzHdBIqEVt0glD+aZiNBHs5ORx5I
 WzUyIOKei1AkA+IVw+LhbbeiIVjHXJihyT2JeM2HK1MnHpjxHFWEjLDTLYHz47G4XrNa1oWHf
 kIvhU30EvC3FQl8PdoZZzS+BEAwlB+91+clVd7u/6jFGnFW1chvNnYt1STQ/tOG4SVLRFEsGI
 CSaMr/KvkFaCB0OkW2cGgVhHs5kgBjXKoiA41QZabSFIJBxi9OFyxlbKk/YjTPPJh1uxCTvaT
 ehptcX8tSu6TK1qtVkxi+ReOaCfZR77Ay+Q/Qa8JU96Ve0+u3cBeGslspQ2bCRqFr+yOsw6qq
 gEHLTPPWZk1AJU1si86A2cQrYndPOg41+wp6pBiQnIh3EAuhGzwlkhEMj4R5iFHwILYFih5JS
 ujvV56EXovIIUKbOKNVI8i8sEdBOvstjPPUIsbH23JDorSyp8yUGGskOJsHMzET8BbPqfcfxe
 l5y3F4pw4NGC2tk3kZ6cGtzRGFmWtqAvlQLQBVDiVlNxbKxzJqX/Ij1xkZDoktA7+9Ybbz8d+
 3GphM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/8 =E4=B8=8B=E5=8D=885:55, Sw=C3=A2mi Petaramesh wrote:
> Hi Qu,
>
> On 8/8/19 10:46 AM, Qu Wenruo wrote:
>> Follow up questions about the corruption.
>>
>> Is there enough free space (not only unallocated, but allocated bg) for
>> metadata?
>>
>> As further digging into the case, it looks like btrfs is even harder to
>> get corrupted for tree blocks.
>>
>> If we have enough metadata free space, we will try to allocate tree
>> blocks at bytenr sequence, without reusing old bytenr until there is no=
t
>> enough space or hit the end of the block group.
>>
>> This means, even we have something wrong implementing barrier, we still
>> won't write new data to old tree blocks (even several trans ago).
>
>
> It's kind of hard for me to say if the 2 filesystems that got corrupt
> lacked allocated metadata space at any time, and now both filesystems
> have been reformatted, so I cannot tell.
>
> What I can be 100% sure is that I never got any =E2=80=9CNo space left o=
n
> device=E2=80=9D ENOSPC on any of them.

No need to hit ENOSPC, although it needs extra info to get the metadata
bg usage to determine, so I didn't expect it to be easy to get.

>
> *BUT* the SSD on which the machine runs may have run close to full as I
> had copied a bunch of ISOs on it shortly before upgrading packages - and
> kernel.
>
> However the upgrade went seemingly good and I didn't see no ENOSPC at
> any time.
>
>
> On the external HD that went corrupt as well, I'm pretty sure it
> happened as follows :
>
> - I started a full backup onto it in an emergency ;
>
> - I asked myself =C2=AB Will I have enough space =C2=BB and checked with=
 =E2=80=9Cdf=E2=80=9D.
>
> - There were still several dozens of GBs free but not enough for a full
> system backup. I cannot tell if these had been allocated or not in the p=
ast.
>
> - Noticing that I would miss HD space (but far before it actually
> happened) I deleted a high number of snapshots from the HD.
>
> - I thus assume that the deletion of snapshots would have freed a good
> amount of data AND metadata space.
>
> So the situation of the external HD was that a full backup was in
> progress and a vast number of snapshots have been deleted meanwhile.
>
> After that the FS got corrupt at some point.
>
>
> For the internal SSD, it looks like the kernel upgrade went good and the
> machine rebooted OK, then midnight came and with it probably the cron
> task that performs =E2=80=9Csnapper=E2=80=9D timeline snapshots deletion=
.
>
>
> Then the machine was turned off and rebooted next day, and by that time
> the FS was corrupt.
>
>
> So I strongly suspect the issue has something to do with snapshots
> deletion, but I cannot tell more.

I was also working on that in recent days, hasn't yet got any clue. (In
fact, just find btrfs harder to get corrupted if there is enough
metadata space).
But will definitely continue digging.

>
>
> It may be worth noticing that the machine has been running a lot since I
> reverted back to kernel 5.1 and reformatted the filesystems, and that no
> corruption has occurred since, even though I performed quite a lot of
> backups on the external HD after it has been reformatted.
>
> Everything is in the exact same setup as before, except for the kernel.
>
> So I would definitely exclude an hardware problem on the machine : it's
> now running fine as it ever did.
>
> I plan to retry upgrading to Arch kernel 5.2 in the coming weeks after
> having performed a full disk binary clone in case it happens again.
>
> (However I've seen that Arch has released 3-4 kernel 5.2 package updates
> since, so it won't be the exact same kernel by the time I test again).

No problem, not that many fixes get backport, none of them are really
high priority so I'd say it would not make much difference.

>
> I will be on vacation until August, 20, so I cannot perform this test
> before I'm back.
>
> But I'll be glad to help if I can and thank you very much for your help
> with this issue.

My pleasure, if we could finally pin down the cause, it would be a great
improvement for btrfs.

Thanks,
Qu
>
> Best regards.
>
> =E0=A5=90
>
