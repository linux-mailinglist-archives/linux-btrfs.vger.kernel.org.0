Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619B9233C3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 01:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgG3XoW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 19:44:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:47241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbgG3XoV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 19:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596152657;
        bh=uj8iFVI6PsFI+2I2spCAmV6Vlr0sNnEZHwh/DbGoTgg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LCCR2UAYGGdmaTmeOIUxFZOfjRey2s2LywtAemoYu99ILTHoBfzflmDm0up74S/3C
         jqA2plcintSiBr430uc6w6T8G4XTx/lQkIaM9zKXX+RfTyGuqRzA4Ibsvr96PJ4uKA
         xGUKm1kNo8W09pjk4NtGJeq7Go7PKzM26TaoP6WU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4s51-1k1ZKx3YZT-0020Hx; Fri, 31
 Jul 2020 01:44:17 +0200
Subject: Re: [PATCH] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200730111921.60051-1-wqu@suse.com>
 <CAL3q7H6LofjW9GozPR6_ds8YHZpLKOCF790XiSQ1aqWqsam+WA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <98c65b1a-2eef-fd99-b5d2-ab7231f5effc@gmx.com>
Date:   Fri, 31 Jul 2020 07:44:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6LofjW9GozPR6_ds8YHZpLKOCF790XiSQ1aqWqsam+WA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5i7OVPJu+tdG6LpdY8lYiDZSosTNHH+wFeSa9SPBQSILd4mDXvH
 dzTC5kcKDeMpJ2qckKvOHsPw5Ekj9JFSeXK1wT/f+GvqaSMrkx1uqcZ4YZ/v+Cg32M4mxPz
 fhzR54p+Svi0sohQNvsAaQNsUTJ02sSQxf1joX2P0lCgmooCA7WiETqec2g4n97koB35e1i
 yRep55FsV6hWSX9KRDsPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4hWf/MzNHIE=:nZm3XI61damBP4vnYH+StR
 BC2fqryMu18pWNlpOVdoetwiy6YCwpK3+XS7DaxQ7IHKF+WLyCF8M4XaWoJ3C3uhVmTnz7U7X
 Ut/0GZjz6ifdQxi3+acBSksgsTWQnbQnIS3b/Gdze3df/u9pw9xf6ycUThKvfOl7U2ntI4XVD
 N+Ej6uw8Z7K1R2+BWja2NaZeuDg+D4Zszzoe6wng/z/gLu8OGvm/3qhpZWHl3q73+3VoDvbfR
 hmzZWgg5kjal5xFS0JvH7Gg6b9a7SgzjVBFsoaISFakMMDly06pd5G6OjXiAu5FhU1B26gctl
 7kgcITjS8rz1SJ65vY/yU6AfBZ6pWtx/H8n690kR7IGphy0+1+RaMeImTaOR1q3g+0N5UpVeh
 R5J48hrO5S7J6U7WX5we3ATMKuddpJStIj/pm2rbmyfhHUolL1Tz2fIeuFmczcuLP8D9jCobi
 WDhXrTpijMfmKMKUl6fdj1iEvuEwVPHMI5KiUPhusvu+QF5lLEez/z4IWSDyYa4QgtyUCL20B
 0HyYIyGjbRT+ap9kfCNMqct/+JuMhbfQggqqWFuNAHsni3H41mE3IZE/KKRWnN9c5cW2Rkv07
 j2D15f8E9FeKFBRZT+K+8cM6rrgTBvqYSLNAVszWZ32gpeJFdT8/W7jgLziLoisvagnKIWl6q
 cHlCjWzCD5STliqvc0/KKNVIi4IrLXDv2hoFgTo/K+Tq91LWR8qztEERu6S9naJv/zCTYPH5U
 1JDledxwNXDmEHXYIf98e/VvtefaJAi2Xwn2FXfHECMZw2B+CmMfGbi9Pe45CwLbsgbaVWAob
 sWGQt0PZhy6GdlaIq3zN2ghmdsVbg5t12GrNJ5T5OjGUqoMT//k8NRyqtya/yyBpJtgZQpq0i
 ia+MZAk2MQD9nr6u6HZVW3HjTF2kkFhWs03Mkc1Q6IqQ2Tdk8UWJVMEq1gLw7TPDbolkODYXF
 eiaerLRXum0p/g38vL7nf+1EOgmjan5/xT1VP4ofS/bkzLrrmejc0A4aJVO/i4BplSjtYUSRk
 JNDSMe1ml9jfZHYcMKj3GK7yez3X5MCS5UoNLKPxeqk87cIvcxojt/NkmdySO8zh5z/UpwJ9U
 kIkorWhlwneUb7TJeKtEvPEyHHuNUfFMtMQ3JcFQWrvnPOfSIxlEp3jeOW5cjyFwq/7Mwfqs9
 Xvcgn8t812pF3L7PfFFUT+PD+BmF+dynph76Dug58GFVs8HFEYPNrUgEGkTE9byIwgq6GmLuE
 xPi9GoXPZLN+KM6K93EG+lU8649rYwXnQnFh7Qw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/31 =E4=B8=8A=E5=8D=8812:54, Filipe Manana wrote:
> On Thu, Jul 30, 2020 at 12:20 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> The following script can lead to tons of beyond device boundary access:
>>
>>   mkfs.btrfs -f $dev -b 10G
>>   mount $dev $mnt
>>   trimfs $mnt
>>   btrfs filesystem resize 1:-1G $mnt
>>   trimfs $mnt
>>
>> [CAUSE]
>> Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
>> find_first_clear_extent_bit"), we try to avoid trimming ranges that's
>> already trimmed.
>>
>> So we check device->alloc_state by finding the first range which doesn'=
t
>> have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.
>>
>> But if we shrunk the device, that bits are not cleared, thus we could
>> easily got a range starts beyond the shrunk device size.
>>
>> This results the returned @start and @end are all beyond device size,
>> then we call "end =3D min(end, device->total_bytes -1);" making @end
>> smaller than device size.
>>
>> Then finally we goes "len =3D end - start + 1", totally underflow the
>> result, and lead to the beyond-device-boundary access.
>>
>> [FIX]
>> This patch will fix the problem in two ways:
>> - Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
>>   This is the root fix
>>
>> - Add extra safe net when trimming free device extents
>>   We check if the returned range is already beyond current device
>>   boundary.
>>
>> Link: https://github.com/kdave/btrfs-progs/issues/282
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/extent-tree.c |  5 +++++
>>  fs/btrfs/volumes.c     | 12 ++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 61ede335f6c3..758f963feb96 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -5667,6 +5667,11 @@ static int btrfs_trim_free_extents(struct btrfs_=
device *device, u64 *trimmed)
>>                 find_first_clear_extent_bit(&device->alloc_state, start=
,
>>                                             &start, &end,
>>                                             CHUNK_TRIMMED | CHUNK_ALLOC=
ATED);
>> +               if (start >=3D device->total_bytes) {
>> +                       mutex_unlock(&fs_info->chunk_mutex);
>> +                       ret =3D 0;
>> +                       break;
>> +               }
>
> It's good to ensure we never trim beyond the end of the fs, to avoid
> corruption of whatever lies beyond it.
> However we should have at least a WARN_ON / WARN_ON_ONCE here to help
> more easily detect other current or future bugs that lead to the same
> type of issue.

Since you're also on the idea of extra warning, it's definitely worthy the=
n.

Thanks for the advice,
Qu

>
> Other than that it looks good to me.
> After that you can have,
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Thanks.
>
>>
>>                 /* Ensure we skip the reserved area in the first 1M */
>>                 start =3D max_t(u64, start, SZ_1M);
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 537ccf66ee20..906704c61a51 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -4705,6 +4705,18 @@ int btrfs_shrink_device(struct btrfs_device *dev=
ice, u64 new_size)
>>         }
>>
>>         mutex_lock(&fs_info->chunk_mutex);
>> +       /*
>> +        * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyond=
 the
>> +        * current device boundary.
>> +        */
>> +       ret =3D clear_extent_bits(&device->alloc_state, new_size, (u64)=
-1,
>> +                               CHUNK_TRIMMED | CHUNK_ALLOCATED);
>> +       if (ret < 0) {
>> +               mutex_unlock(&fs_info->chunk_mutex);
>> +               btrfs_abort_transaction(trans, ret);
>> +               btrfs_end_transaction(trans);
>> +               goto done;
>> +       }
>>         btrfs_device_set_disk_total_bytes(device, new_size);
>>         if (list_empty(&device->post_commit_list))
>>                 list_add_tail(&device->post_commit_list,
>> --
>> 2.28.0
>>
>
>
