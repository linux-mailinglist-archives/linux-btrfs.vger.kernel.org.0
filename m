Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B8C58E960
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 11:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiHJJOp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 05:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiHJJOj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 05:14:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584BE86C33
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 02:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660122869;
        bh=YWFvnXCx5voNdN7ep9bAmgHO+4VeAOGR+9Ri8nKxhFs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OoyNE9urjtc1YygcaOTslK6m754QE3RnnzsuIeFBiC88LQRFNIhpy7oE5ebZJkJCl
         1jPdzRTnYiH5GCD+erVEbzyWI2VdgV3vmz0IFRd8popghg/TTZpKE/fqSOvyrGRCcN
         cbcFiQudosjImMcQBsfXNFRrEusWdHqPg7s1/cj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXBp-1o8BFt35Xt-00DTpJ; Wed, 10
 Aug 2022 11:14:29 +0200
Message-ID: <7da6e44b-8e54-5e2f-66ea-b6d20b05521f@gmx.com>
Date:   Wed, 10 Aug 2022 17:14:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350!
 during raid5 recovery
Content-Language: en-US
To:     kreijack@inwind.it, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <YvHVJ8t5vzxH9fS9@hungrycats.org>
 <d3a3fea9-a260-dcdc-d3a0-70b1d1f0fb2d@gmx.com>
 <YvK1gqSvQRi0B+05@hungrycats.org>
 <9f504e1b-3ee2-9072-51c7-c533c0fb315f@gmx.com>
 <92a7cc01-4ecc-c56a-5ef4-26b28e0b2aae@libero.it>
 <8015f630-3dc9-4655-3e30-5d241af3e0bc@gmx.com>
 <8935ce6e-3801-b35a-7468-3f6fcbab82f0@inwind.it>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8935ce6e-3801-b35a-7468-3f6fcbab82f0@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mzTSdSG5nGe2IRos6nz3mla1/mK9Uhu6Qg0bWt/SgZk8oNnKUdv
 kdOoYWpmyDyu4hAQ0h/o0grh5MbzhbDfgmixkZclZT2mknG3vpapFR1BzEKH7H9WmleM4JO
 yEtw6NdHcBziaOQLVQFAEx09I+O2/ATl7Xh0w9oahXl/LpeS29J5O1R6W5TjsiKZTnlKbkt
 5CkTm1k1N9kbwMGEAwOIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BbbcyOx27XI=:rXoprROR49uYZd3OOKxtZ2
 2Y0dNyeRWCnmhVTC43tS8q28+e4F2bWsrFImR/WKCTG19s/Pz1tGbHLrS9zm5GVCk1HqPJxFf
 FU7wMk7SIvpqgUg2+5R+nEOwMdkkokKXtVoJSzl2VI+AtFAqfcbLaqalutOCCESwxICMRe6/7
 irEwCeNGntArkFonbCfd2HxGf/rMSNB93ySm49LVmqTcdas+7TmSoljkbFtRWr4LIp3FD/sBZ
 i2DLlxkNm3/YJXj53lJNfdeUrDxd68RK3lJxUFmP58R5ay1t1+P30fupMz4lWEq1oAKNcz1Bv
 cTJZIltEIa7+ca6jI7gsvaYFP2bvl5WSAMOZxLCXX2nZWwRQX1CW5OqlFbCVtWR/D1UcqExZr
 s5TPGR4KaxukeP8mi4WcqoAEFSaIlagN7b+6aKis8B88W7SM54CoHnCxsCfrIiUfpQ4/XzdF5
 txwT25PqBsLQcbApOvHklYEmGeqHUG9TUnu6+NmwbxUYnqu6/VdGi+BSNqcad756z0UgujQus
 0OPBNR5saIjAbjE4f2EAkyvQ1JUbJV2T7h8B7i9WNWbJIBfoHbprx39YY3ZNkC5POLp0yjuRD
 RUSAM7Z3HDAyPVyEMWX36t4aKA9wOpJrBpLJWXJb+/7Ral1egiBYPmopJx3BTSOMFjc23ilHn
 6Lu31+lnHV5HWI/G9sTJC9gc0kMUQmpRzS059JBByN0IpEaVdw5434ZNU3J1oHC71/b5FkeeH
 kQlp9pbO7cxspyv2+G9nWA9mBAPmEHC251Ql4FZfSFE5WP7KyEEx4vBHA7A3mTsPj+nC+hpZv
 NRjDLoRC/Gj6pyCR5THZbyU/gXq8voAwm3Z/YQJUL2LpYoL7Ez4dkiaZRPMFDU4xdd1LmhBIw
 W7XWcu0rLLMr0VZE8ciJYVGxd4E+Y8d+Ue6J6ZvNFdREa5JUWSbyTLbm4zW55SsqQXVEByQHV
 mEsvW07CmQtawVtpANNemIEQKWEeIqr9G1+dTRofaQpr3CYLC40mnDKEKJ/or6SXHBYwmoQOu
 I0lpF6uPSMZqVZlmyIg1rJRvnTTNYlH8OtB+Lm1xDFRQmK9NfSh8JlFy6uUAw1OCxpswl7May
 mWMMaf5ikrgu7ugAyxQDso1Hj4UU3iqHvjhyflFMsoGmYGKhQmYd3K93Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/10 16:45, Goffredo Baroncelli wrote:
[...]
>>
>>>
>>> The key factor is "read data", where we can face three cases:
>>> 1) the data is referenced and has a checksum: we can check against the
>>> checksum and if the checksum doesn't match we should perform a recover
>>> (on the basis of the data stored on the disk)
>>
>> Then let's talk about the detail problems in the btrfs specific areas.
>>
>> Yes, it's possible that we can try to check the csums when doing RMW fo=
r
>> sub-stripe writes.
>>
>> But there are problems:
>>
>> =3D=3D=3D csum tree race =3D=3D=3D
>>
>> 1) Data writes (with csum) into some data 1 stripes finished
>>
>> 2) By somehow the just written data is corrupted
>>
>> 3) RAID56 RMW triggered for write into data 2
>>
>> 4) We search csum tree, and found nothing, as the csum insert hasn't
>> =C2=A0=C2=A0=C2=A0 happen yet
>>
> This is the point. Theoretically this is doable, but this would require
> a "strict"
> order not only inside the stripe but also between all the data and
> metadata.
> This would have an impact on the performance; however I think that this
> is not
> the highest problem. The highest problem is increase of the complexity
> of the code.
>
> It seems that the ZFS approach (parity inside the extent) should not
> have this problem.
>
>
>> 5) Csum insert happens for data write in 1)
>>
>> Then we still have the destructive RMW.
>> Yes we can argue that 2) is so rare that we shouldn't really bother, bu=
t
>> in theory this can still happen, all just because the csum tree search
>> and csum insert has race window.
>>
>> =3D=3D=3D performance =3D=3D=3D
>>
>> This means, every time we do a RMW, we have to do a full csum tree and
>> extent tree search.
>> And this also mean, we have to read the full stripe, including the rang=
e
>> we're going to write data into.
>
> Likely we need to read the checksums in any case, because we need to upd=
ate
> the page that hosts it for the first write.

Checksum read and full stripe read are completely different.

Checksum read needs to involve several tree block reads by itself, and
the timing is way tricky.

For normal data read, we search csum tree beforehand, but for this
RAID56 RMW, we must search csum tree at the very end stage before we
submit the write.

I'm not 100% confident if the timing is fine.

And for normal write, even for RAID56 RMW, we never trigger read for
csum tree, we just read the full stripe at most.

Thus even the code change may not be that complex, the timing change can
be very tricky.

> Also we need to read the full stripe to compute the parity; only for
> raid 5 we can do:
>
>  =C2=A0=C2=A0=C2=A0=C2=A0new_parity =3D old_parity ^ new_data
>
>>
>> AKA, this is full scrub level check.
> Is the usual cost that we need to pay when we read a data from the disk.

Not the same. Scrub has extra setup, like marking the whole block group
RO, to avoid a lot of race.

For regular file read, we don't need to bother the race for the range we
want to read, we have page locked and no race can happen.

But this is no longer true for RAID56, at RAID56 level, we have nothing
like page cache to help us.

Thanks,
Qu

>
>>
>> This is definitely not a small cost, which will further slowdown the
>> RAID56 write.
>>
>> Thus even if we're going to implement such scrub level check, I'm not
>> going to make it the default option, but make it opt-in.
>>
>> Although recently since I'm working on RAID56, unless there are some
>> possible dead-lock, I believe it's possible to implement.
>>
>> Maybe in the near future we may see some prototypes to try to address
>> this problem.
>>
>> Thanks,
>> Qu
>>
>>
>>> 2) the data is referenced but doesn't have a checksum (nocow): we cann=
ot
>>> ensure the corruption of the data if checksum is not enabled. We can
>>> only ensure the availability of the data (which may be corrupted)
>>> 3) the data is not referenced: so the data is good.
>>>
>>> So in effect for the case 2) the data may be corrupted and not
>>> recoverable (but this is true in any case); but for the case 1) from a
>>> theoretical point of view it seems recoverable. Of course this has a
>>> cost: you need to read the stripe and their checksum (doing a recovery
>>> if needed) before updating any part of the stripe itself, maintaining =
a
>>> strict order between the read and the writing.
>>>
>>>
>
