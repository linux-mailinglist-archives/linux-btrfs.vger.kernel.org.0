Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700393E9A95
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 23:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhHKVwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 17:52:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:35305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232270AbhHKVwL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 17:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628718686;
        bh=4nZEm6xMfAJuJ+2cRGtffu0+Is54E1AQLnJ0KV4nMTU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dNmQL2ybvlXn4GxVzhBCTqctiBTsLJ40W0czNDkFBv/tSOkFM8wXc4mI0+478Wj4l
         EeoKOPEKT+zkLfegI2l3MKpW3v/z0bu+iUPFzmwz8PCvLGKtPgBtlST6RKqjDcRvfk
         fR45+lTzRYH5cKRP5T4e7Y2egcMPkahkKuOBssb8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHXBj-1mIfEK1kxt-00DV1U; Wed, 11
 Aug 2021 23:51:26 +0200
Subject: Re: Trying to recover data from SSD
To:     Konstantin Svist <fry.kun@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
 <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
 <1c066a71-bc66-3b12-c566-bac46d740960@gmx.com>
 <d60cca92-5fe2-6059-3591-8830ca9cf35c@gmail.com>
 <c7fed97e-d034-3af1-2072-65a9bb0e49ef@gmx.com>
 <544e3e73-5490-2cae-c889-88d80e583ac4@gmail.com>
 <c03628f0-585c-cfa8-5d80-bd1f1e4fb9c1@gmx.com>
 <d7c65e1d-6f4e-484b-a52f-60084160969f@gmail.com>
 <2684f59f-679d-5ee7-2591-f0a4ea4e9fbe@gmx.com>
 <238d1f6c-20a9-f002-e03a-722175c63bd6@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4bd90f4a-7ced-3477-f113-eee72bc05cbb@gmx.com>
Date:   Thu, 12 Aug 2021 05:51:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <238d1f6c-20a9-f002-e03a-722175c63bd6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IguvIU0MWXe25p/uqx88qJKQhRVacFkb21p+wJ4bFY60YTXau3E
 0FB3I004SHfwl8jDH04oghFpzDMLmUZemeFYDfkW5dR+TroZ+VeB3KsQmwHA5NQob7avucz
 sBEyERc4kBFektD5w45E6VajGDGMGOMZvmgvcHMTt2G9PfEGnwF6pJUHLZoCW9lY1/OzZIn
 cPazO1Tv1nvd8Ak+IyLpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cDGvN3z3fj4=:xffNAry835A/0oUguD3Y65
 qZW1t4iQ9TSXg7DeE4FqTuT7JzmnFAkBhUxltOOfsjwuwsMc0qTXbcBmnUsHj/c7649cwSB9F
 pQTCj8UOH0rMMC8GcaqA1f8Sb2E7uDnROD9fIyG3j5j3Dj4SSeE7PDpZ96R3RDtTqKzHhRSyB
 TKFcRAUFIFXoDtFdOkrU50SIAOrhUaNyBPkeWqmqkzUL7aDcqvF3ka6NA0bEzQt8StKwTgOcD
 Hlkpg+guPrORGls7OXvdzFxa/eoVVhGnnFT7vWAzQFoMLjidSYEmIHiEKROLzh0FCS/WOzeIT
 n+UGmr8EsQAnF4dbPuN5kkKxElu11i0cWYGEdxfBFfZr7XBHq/SxoGMT8JvWb4IVYwY9aVfEj
 fg09VNRKGYBulW6Gs9+tDzS4sqASxWErZ8qp+Zn+Jn7QTa045QPSMFcHJ+l6jIM22RITJ2ZA2
 aP3rLjzfuEFCx/q1aSQHk7T0jUPF7KgNmM3UDjU1PgJ1UOAodDiH7a0dHju7Qo2wZn0+BsgPT
 6bYmgS50qaxoMAOHHfi1pvBD2pA9zeARogYrAMvKsQqvvDAh9nKc1ZCjAdv/Voy7lb0TFP5iD
 A1ueviKCEBBDiOkYBWp3GLD8Fc2/Ys71P7p86Wb7izwQbjWhZgbgoIjddkEuKy3+NdBaFNenO
 jIFz1P/CaOJHwfjQCYt7GjYjlsCl+euTkS3jH4vjDudTrUwmgWtzGvPoEeRH7xhdlii4MAbHd
 DKJb927WCsvVNLBD8Jg/wuTjRKm4OQ2pGDtUCiskL84SM74Qz4kxAV/E6rIOqPtp3VXMabJaR
 MOeLVk0XZAi78F/79i0j4UhApAuvGyMpGasKbEyM4//htweMTF/cgeDKkFhr0pwKUqNSAMPs+
 4VWinMUpWnHtA6M4jDiNUrKRJSbYFX2oGvCcjoEOIv+JTLqeRwBBQt+cOfvmx/e9U5uTbSwWX
 Ic2H4Tb2ydF4pn8NKuWIwgwngsblF3RWPKo213ItapypoWYW6kLQeLO9NbvS/MoFZgcD7qvag
 GoF+/QY5lTrR+tI3krDL7s8AOJwDOaLEudXHdBiY4cXtDZlTwF6dl1nw8dtkZLG6pCNtDZnhk
 ti+iMshSzB7TVUfpwldJP2JT2GeDJJS7HUR5vK9+T+Vlwo1cOTx+3ZmaA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/12 =E4=B8=8A=E5=8D=883:33, Konstantin Svist wrote:
> On 8/10/21 22:49, Qu Wenruo wrote:
>>
>>
>> On 2021/8/11 =E4=B8=8B=E5=8D=881:34, Konstantin Svist wrote:
>>> On 8/10/21 22:24, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/8/11 =E4=B8=8B=E5=8D=881:22, Konstantin Svist wrote:
>>>>> On 8/10/21 16:54, Qu Wenruo wrote:
>>>>>>
>>>>>> Oh, that btrfs-map-logical is requiring unnecessary trees to
>>>>>> continue.
>>>>>>
>>>>>> Can you re-compile btrfs-progs with the attached patch?
>>>>>> Then the re-compiled btrfs-map-logical should work without problem.
>>>>>
>>>>>
>>>>>
>>>>> Awesome, that worked to map the sector & mount the partition.. but I
>>>>> still can't access subvol_root, where the recent data is:
>>>>
>>>> Is subvol_root a subvolume?
>>>>
>>>> If so, you can try to mount the subvolume using subvolume id.
>>>>
>>>> But in that case, it would be not much different than using
>>>> btrfs-restore with "-r" option.
>>>
>>>
>>> Yes it is.
>>>
>>> # mount -oro,rescue=3Dall,subvol=3Dsubvol_root /dev/sdb3 /mnt/
>>> mount: /mnt: can't read superblock on /dev/sdb3.
>>
>> I mean using subvolid=3D<number>
>>
>> Using subvol=3D will still trigger the same path lookup code and get
>> aborted by the IO error.
>>
>> To get the number, I guess the regular tools are not helpful.
>>
>> You may want to manually exam the root tree:
>>
>> # btrfs ins dump-tree -t root <device>
>>
>> Then look for the keys like (<number> ROOT_ITEM <0 or number>), and try
>> passing the first number to "subvolid=3D" option.
>
> This works (and numbers seem to be the same as from dump-tree):
> # mount -oro,rescue=3Dall /dev/sdb3 /mnt/
> # btrfs su li /mnt/
> ID 257 gen 166932 top level 5 path subvol_root
> ID 258 gen 56693 top level 5 path subvol_snapshots
> ID 498 gen 56479 top level 258 path subvol_snapshots/29/snapshot
> ID 499 gen 56642 top level 258 path subvol_snapshots/30/snapshot
> ID 500 gen 56691 top level 258 path subvol_snapshots/31/snapshot
>
> This also works (not what I want):
> # mount -oro,rescue=3Dall,subvol=3Dsubvol_snapshots /dev/sdb3 /mnt/
>
>
> But this doesn't:
>
> # mount -oro,rescue=3Dall,subvolid=3D257 /dev/sdb3 /mnt/
> mount: /mnt: can't read superblock on /dev/sdb3.
>
> dmesg:
> BTRFS error (device sdb3): bad tree block start, want 920748032 have 0
>
>
Then it means, the tree blocks of that subvolume is corrupted, thus no
way to read that subvolume, unfortunately.

Thanks,
Qu
