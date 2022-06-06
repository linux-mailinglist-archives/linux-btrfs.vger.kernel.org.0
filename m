Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E4053E820
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiFFLWE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 07:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbiFFLV7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 07:21:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E818FD51
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654514506;
        bh=pknyOqIS96b5YL+ga+3FeNDKiSscKS1lRccBlRh23po=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=OGYg1HKuiYoZ3jHFO8jZUAfdL3j/uhIS8xekcFth9bsEEXpbbHRC/9NT/oitZHW6C
         cbGzXcQ0DGCg3vrvlcwU0zb72wA/BSG/uNN7Fq56adRMQHmxs+XrP5O770FLRCqFar
         Okn0ucFWBSY6T0AulpkvKtFgwZ0VR6piR3CbAbJg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTRMs-1oLBJ80Uay-00Ti8s; Mon, 06
 Jun 2022 13:21:46 +0200
Message-ID: <c4c298bf-ca54-1915-c22f-a6d87fc5a78f@gmx.com>
Date:   Mon, 6 Jun 2022 19:21:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     Martin Raiber <martin@urbackup.org>,
        Paul Jones <paul@pauljones.id.au>,
        Wang Yugui <wangyugui@e16-tech.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220601102532.D262.409509F4@e16-tech.com>
 <49fb1216-189d-8801-d134-596284f62f1f@gmx.com>
 <20220601170741.4B12.409509F4@e16-tech.com>
 <5f49c12e-4655-48dd-0d73-49dc351eae15@gmx.com>
 <SYCPR01MB4685030F15634C6C2FEC01369EDF9@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <6cbc718d-4afb-87e7-6f01-a1d06a74ab9e@gmx.com>
 <01020181209a0f8e-b97fa255-3146-4ced-b9c9-a6627a21d6e1-000000@eu-west-1.amazonses.com>
 <f56d4b11-1788-e4b5-35fa-d17b46a46d00@gmx.com>
 <20220603093207.6722d77a@gecko>
 <8c318892-0d36-51bb-18e0-a762dd75b723@gmx.com>
 <252577ba-1659-62f8-fc44-fea506eb97b7@gmx.com>
In-Reply-To: <252577ba-1659-62f8-fc44-fea506eb97b7@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aFvAO9t54tAHJGTBkqWjJnx/NF9RNCbqPt+hulVZIUmcYskiwpl
 BAsUN68jsnJszBxDcGET+egR5n2/InuxZQ9iNp5iBeIYFGfPQtfWdjus5j609b6JSgmm3RK
 sVjjTciDmR/J4F60COnJs9yMs4ub9EWqEld1WQn+pIgAaPXDt+hvzlSXU9MhzqQ4ljmHSgE
 +UDey7euUuRBcjPJ03CYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b3m1kjWUeL8=:mnhU/nKPunq4sNpjGIhiqc
 lOMUwtfE2KgpEIgRhj/gSSh1DhwaPSbwoiB9HjF/f6+M2xXxLjHhWuPnK78n/0QSCP3jLQSjL
 oPOsKSx++FZdKlgL9mhkZz0lmBoRcSdss1Qvbt5mtUcQepRmJmwTvSspkPue0m0xRDe740bEG
 cV19lvC28KnWycr+R23hTtZoQ2f05Jj1BZnJLNw+Utlnq3zcCgXVzQcUem8vU9Cl5jXQHoYC5
 psX89PvcngqTSROJqNVUv0eshG5ChkisHSq9rpjII32WhvZ8j5vVsNBge/wDjyDvvQOF76xM7
 7SFepEmo5OT4cOnxF6kOlgJGkcYfxTiXjcBkiVSXxY2bdVY7Jb+AdA2uV9OP/vA+62WTLUGuo
 FKoVVtORqwcDNni8djQraiIJoP/KBAAwOwE8bp3CYPDCbKF0+HNBaawIKpx0gXui5aLuQdgLm
 gfHR+n/UBsXLSSypBZIDDHazILZNcOGZDrnDqyMMU3CKrkhJa0KrMwbZH9yxxavVQlPY2gGrM
 TLBR7LRuf4BCOYxgkB6qsdaOzC4PPWrZKkeZB9WwdekM9fetlSDV2BolE8P7RI24cJ3/3+YlP
 Oyen7oXHwnln+omXC5hxD7k3nhhNCPKX3Hn1YDf9QEYG2Edj897i9PHllOee+5uofKUh8xuuE
 fX1/MEYUAA05/vWhNDbrVLV2cS+SRDx2o0f/3kyvysAuDg0XJUk/zEFHddGPzKrF/FGq0L7Qt
 liqq1IrW1ToAgldt7JJLNbcqbO+HaBZrI1KzLClwnEYfvk4ebDMDts6CvQHV5SiAwtc26H4fl
 Th91EjmJ7R8KLXIKkpDk3W0vYnZsqfpUAc9+NhYYVrfbpraTsyqYa73ieL1xcErqREwyZNu+T
 YCzpXEUFjvgdOSTCpjnR9M0wa/gUHcO9+3kl12wEDyLbNGpPZs/bbOwhmMuZTsuH17gHZEEyL
 iQiBA60DmlF7HQZHM7BYRK+jHrIu+a5d3Px1Iw8s2/gD5uW5KeIo52BYV+qWOwq0OtgA/mSax
 3EwCUl/UHa8dir8psejni6Halo1eRqUGSfgP5vIJDhcaC2jC/ga7mCKcVIRoNAmMOwcC16tmG
 t4a8L1vJvaehwe/2p4KkoiAJeWVskGmpcqJuWQH0mPwT4bkJgGsoCPA9A==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/6 16:16, Qu Wenruo wrote:
>
>
[...]
>>>
>>> Hello Qu,
>>>
>>> If you don't care about the write-hole, you can also use a dirty bitma=
p
>>> like mdraid 5/6 does. There, one bit in the bitmap represents for
>>> example one gigabyte of the disk that _may_ be dirty, and the bit is
>>> left
>>> dirty for a while and doesn't need to be set for each write. Or you
>>> could do a per-block-group dirty bit.
>>
>> That would be a pretty good way for auto scrub after dirty close.
>>
>> Currently we have quite some different ideas, but some are pretty
>> similar but at different side of a spectrum:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 Easier to implement=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ..=C2=A0=C2=A0=C2=A0=C2=A0 Harder to implement
>> |<- More on mount time scrub=C2=A0=C2=A0 ..=C2=A0=C2=A0=C2=A0=C2=A0 Mor=
e on journal ->|
>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0 \- Full journal
>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 \--- Per=
 bg dirty bitmap
>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \----------- Per bg dirty fl=
ag
>> \--------------------------------------------------- Per sb dirty flag
>
> In fact, recently I'm checking the MD code (including their MD-raid5).
>
> It turns out they have write-intent bitmap, which is almost the per-bg
> dirty bitmap in above spectrum.
>
> In fact, since btrfs has all the CoW and checksum for metadata (and part
> of its data), btrfs scrub can do a much better job than MD to resilver
> the range.
>
> Furthermore, we have a pretty good reserved space (1M), and has a pretty
> reasonable stripe length (1GiB).
> This means, we only need 32KiB for the bitmap for each RAID56 stripe,
> much smaller than the 1MiB we reserved.
>
> I think this can be a pretty reasonable middle ground, faster than full
> journal, while the amount to scrub should be reasonable enough to be
> done at mount time.

Furthermore, this even allows us to go something like bitmap tree, for
such write-intent bitmap.
And as long as the user is not using RAID56 for metadata (maybe even
it's OK to use RAID56 for metadata), it should be pretty safe against
most write-hole (for metadata and CoW data only though, nocow data is
still affected).

Thus I believe this can be a valid path to explore, and even have a
higher priority than full journal.

Thanks,
Qu


>
> Thanks,
> Qu
>>
>> In fact, the dirty bitmap is just a simplified version of journal (only
>> record the metadata, without data).
>> Unlike dm/dm-raid56, with btrfs scrub, we should be able to fully
>> recover the data without problem.
>>
>> Even with per-bg dirty bitmap, we still need some extra location to
>> record the bitmap. Thus it needs a on-disk format change anyway.
>>
>> Currently only sb dirty flag may be backward compatible.
>>
>> And whether we should wait for the scrub to finish before allowing use
>> to do anything into the fs is also another concern.
>>
>> Even using bitmap, we may have several GiB data needs to be scrubbed.
>> If we wait for the scrub to finish, it's the best and safest way, but
>> users won't be happy at all.
>>
>> If we go scrub resume way, it's faster but still leaves a large window
>> to allow write-hole to reduce our tolerance.
>>
>> Thanks,
>> Qu
>>>
>>> And while you're at it, add the same mechanism to all the other raid
>>> and dup modes to fix the inconsistency of NOCOW files after a crash.
>>>
>>> Regards,
>>> Lukas Straub
>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> Paul.
>>>>>
>>>>>
>>>
>>>
>>>
