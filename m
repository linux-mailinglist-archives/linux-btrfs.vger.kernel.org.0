Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F502577D15
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 10:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiGRIDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 04:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiGRIDv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 04:03:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91354C4D
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 01:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658131423;
        bh=iugevin3tXwbKcjBZpixlgjJ54UikQMBrMeEDHNz/8k=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=T5qVAQn7RMJ7H9b2uKvLwKfxGLrEH+QY9jp8ubkGeiiKr9q3URfn2UUILtypICUoE
         mqii7OKQDSi9aLLLw3jlTpcUu48VFSXjsCQAjCtiWvOkR1SmJeXT29Cs5dH4O0wlss
         /FsshBUqmH8DPs76KThalUi2NUgZ86tVto+IF4qk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRCOE-1nqJ3p3geK-00N75t; Mon, 18
 Jul 2022 10:03:42 +0200
Message-ID: <defbf99f-efc6-0497-2efd-04b9d9134d0c@gmx.com>
Date:   Mon, 18 Jul 2022 16:03:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
 <CAJCQCtTJ=gs7JT4Tdxt3cOVTjkDD1_rQRqv6rbfwohu-Escw6w@mail.gmail.com>
 <PH0PR04MB741662E24861B573FE93D0DD9B8C9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB741662E24861B573FE93D0DD9B8C9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XCJv2k/kn2Bnh944fykAoZfv3Lr2KBr8ySslNDghH6Bw6RDqdKc
 JIPDY/LvQnLUwdwM45iDTqNPis2NgSCzWRbfyDyKKDUWAB9kItcwMhaGfTFuCyf1w/TFp0+
 KEmiZ282Xu2d+IjIxlr0P2M6uhX+upuGSdUJpHLvAi1epZrtWrhLwC8E9X6A1pjlU2ipQGq
 Nqi6vGaaYgGnohpoJPYgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NwLmpTjZqLQ=:aM6UF+Gx9aQ2samMqyadL6
 YIfGZk4rPDhMG1Ewt2GyjxUq+nVtBs2DwVKDxViYuDqiGQOCJXTovRO3gkphKPcRzUzfGedcf
 cM1TX/8UzGROsHmZdFYif0rVEyewfVw+BWgr56G+gNKfe0ErSfGa6Cp8jTE16V8/L1ZTTmB4P
 UvcnDWX0P36pn96rRIQ8XXH/VaLSPZT38+tSNjALAD7+YxS13r68DmN81l3OaxBW/WbxSERPV
 TLcMk53l6y27hFlC8Kfmb7UYWaOS8mhMWqAxK6mjelNZ6Ma8DwIxNupI/LpEAgBvDQW3Wagmj
 a3O17iw22zSB5suaYjbkIoO3fDB62iOwcLsSUAlOaBEs/u1giWWl02OIEPzINK4XYyJNccOaN
 o/1wnQHZoApCEbIE6pVj3wmarILj7pn3rk3X2sF+mn1ePZyQQQLk8BYESSsb17k7IfymYW0+o
 cw5l+/o9YtbXGrwbGaGQVQzrc0xaQmit6h5RQ+RDk6Z4v9gHofyRxR/FaltNFrBhNtwS4jxdy
 vlKsjVWyAjbNBDyxbiUofEiDwYGqsorg33zXa8uWH2CrzItHjR3XMYVLlBAsPrJsHir0DRVd6
 d9tQWIERYvIv4Om/Hr2mztFQ6uXk7VST0MZHS2yf/48WiWUP9mB5u1B1VVyBpL6Uc1NQkiXGR
 Nm1GFmOtY/5unmRK9ljmAWTB+oFoXudX6hrGn1sh9iDyS+r7aiZhV+DgvpNLrxj5wZSUv22hE
 0WKQDPuxScaR31SwFggeR66mc/uvIbfCREuehe0RavfKnkHHEGpZRYZ+WZnrZ7Te77j/1etXW
 Bd/xZd+3kAaF7uXbHXOyL1ifwKZso4IFdHVTONPh1POx/GEA3HcQ279FQgy83aNzcQjxRGepy
 a4zKo7iEXte9q0ChXut9fL7Jjj1xU/1zZQCmc715wevkVxKGP5ixLQ33s2YeUvo6F6RCK9WUv
 fo1DCD9RQCL6qtx3BkPQT+RSoxvIDZH8JX3ysZA0nuS90FOjm6gfbKOkVHnY+7PFxrfyQWKgJ
 Mgn6ykKDVFrDlzdzxHPihRfOKMXve4tCYDDC9DRaYWFgT2dsqv5EAJmoE8US10+uwq5Uufx+i
 YRaWaMKscBZvOSdNRhjrOtYAmqm2sE/GWDxMJWW8Wstnfvp5a0ywrY1+Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/18 15:33, Johannes Thumshirn wrote:
> On 15.07.22 22:15, Chris Murphy wrote:
>> On Fri, Jul 15, 2022 at 1:55 PM Goffredo Baroncelli <kreijack@libero.it=
> wrote:
>>>
>>> On 14/07/2022 09.46, Johannes Thumshirn wrote:
>>>> On 14.07.22 09:32, Qu Wenruo wrote:
>>>>> [...]
>>>>
>>>> Again if you're doing sub-stripe size writes, you're asking stupid th=
ings and
>>>> then there's no reason to not give the user stupid answers.
>>>>
>>>
>>> Qu is right, if we consider only full stripe write the "raid hole" pro=
blem
>>> disappear, because if a "full stripe" is not fully written it is not
>>> referenced either.
>>>
>>>
>>> Personally I think that the ZFS variable stripe size, may be interesti=
ng
>>> to evaluate. Moreover, because the BTRFS disk format is quite flexible=
,
>>> we can store different BG with different number of disks. Let me to ma=
ke an
>>> example: if we have 10 disks, we could allocate:
>>> 1 BG RAID1
>>> 1 BG RAID5, spread over 4 disks only
>>> 1 BG RAID5, spread over 8 disks only
>>> 1 BG RAID5, spread over 10 disks
>>>
>>> So if we have short writes, we could put the extents in the RAID1 BG; =
for longer
>>> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by le=
ngth
>>> of the data.
>>>
>>> Yes this would require a sort of garbage collector to move the data to=
 the biggest
>>> raid5 BG, but this would avoid (or reduce) the fragmentation which aff=
ect the
>>> variable stripe size.
>>>
>>> Doing so we don't need any disk format change and it would be backward=
 compatible.
>>
>> My 2 cents...
>>
>> Regarding the current raid56 support, in order of preference:
>>
>> a. Fix the current bugs, without changing format. Zygo has an extensive=
 list.
>> b. Mostly fix the write hole, also without changing the format, by
>> only doing COW with full stripe writes. Yes you could somehow get
>> corrupt parity still and not know it until degraded operation produces
>> a bad reconstruction of data - but checksum will still catch that.
>> This kind of "unreplicated corruption" is not quite the same thing as
>> the write hole, because it isn't pernicious like the write hole.
>> c. A new de-clustered parity raid56 implementation that is not
>> backwards compatible.
>
> c) is what I'm leaning to/working on, simply for the fact, that it is
> the the only solution (I can think of at least) to make raid56 working
> on zoned drives. And given that zoned drives tend to have a higher
> capacity than regular drives, they are appealing for raid arrays.


That's what I can totally agree on.

RST is not an optional, but an essential thing to support RAID profiles
for data.

Thus I'm not against RST on zoned device at all, no matter if it's
RAID56 or not.

Thanks,
Qu

>
>> Ergo, I think it's best to not break the format twice. Even if a new
>> raid implementation is years off.
>
> Agreed.
>
>> Metadata centric workloads suck on parity raid anyway. If Btrfs always
>> does full stripe COW won't matter even if the performance is worse
>> because no one should use parity raid for this workload anyway.
>>
>
> Yup.
