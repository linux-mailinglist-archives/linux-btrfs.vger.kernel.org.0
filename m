Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67EB574634
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 09:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbiGNHxr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237791AbiGNHxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 03:53:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3398764F
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657785189;
        bh=cwYyGweQNwGSDrJpoV//68B/9733PLgLofVU46OlAWE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=UnA8NFj/n5ZIfb5ySpWbNOnNwttAfq3weVc1sbNGkdxqbX1WDVY4HS1/hQ4poI+7u
         cmn8WFKO/BNQNiAYmPGtlAwtQBRSQ/ndGHo2VBPL+u6KGIajWO8+NDijQqFmrJfnbR
         9XSI1XLidqU7AdxTf2bfbv+qld0HYiSI0Y6w//EU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAwbz-1oIFJ7368v-00BH6m; Thu, 14
 Jul 2022 09:53:09 +0200
Message-ID: <f54f6709-9b31-fc9c-6b5d-10dd43b089ca@gmx.com>
Date:   Thu, 14 Jul 2022 15:53:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:83/m7NUcMSbkqWjVAWBj1YMOQzto7/j2zsX3Hx6qpiE0p5O5W4S
 Te9Ho7ndGmbNQdTf0H/kvF00NslXqaRfBl3kpz1g+EsV1Ei5pilR42cnUH4rDJuWhHilwlo
 MsAZKjGLrfH5m3Em/ysElZaJflKFav0yQkiEKffRB5+JuZj/43GszqJ8d4MQ1xB7ZbZYtvA
 WY8zIGfR8KHNA9I53I3Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vtr/lKogQP0=:yaovDNXd98P08OjMca5lll
 PgMnIbIqRHtf6TfJ6b8CqEL9jWoPV4mAvIoEZyo33Nr2bxPflTByUwTZlwEJAejKb5ahIl3gH
 jza0Ea0hgymrl5HVnLsMpuiLTVET1G3zU9QiHHKJWrF6ra1yggqs8UcYaNWDAocWCOQj245fD
 DxY2PHmsqYOeLowHEWLSjb+Kq6SX3sxOVwjaoqaqIeouIthXZYQrQ4irCRQxUboYqqvFdZeH+
 /ExP04GDIIcSwY+vvNu/dzLQsL24sVwdnFCz6YXc1M3KeIYKXetTvtisPxVgrf2kFlhc0UhZ2
 d0vC2gqL1383Y+J4Upx98qMdV2U1WsC3aXfafPe4mYYcwsbvl48NvrCYdQMrtl+u70K5X/fGI
 jOa6AZASlQxiqgge2gwjm+jJHxVtiv3TfP12aTgisCF1dV7SoW8VrSBNgnZsIhSDfq1+NkoIV
 PrArGB0l8sJsOud7jJih3tYaVsz9XHTBXlm6peGCdeq5ne3uC4NUyP6057f3n+/1yybsdr3kD
 IOcylTNL2yFmp/weiIowo9tplxEjbSZskKNM8yobS452oaBDBJrPd5bQRXd1mbAC6wFODXzPw
 Sye8lVtXYd3BP6c0lisUQMuRuu7A7nz8GOsURuuPsqCHS0/9DQlZ8BiuQwqMhHTvZ61rGsMsU
 J1d6plweB2UNetZyqWRy3SPAhIiUAA2UHpMWWo+ExeVswp2nLr6I6kD6uzX6MlOXvzHL1Et2z
 VoDLm490MO7ZCsOfcnQOvg0z/24Fjeg0338yZGk8YXtfEOCqGXSB7dMpNeTQCfpBt88C5aUOI
 bf/IM1fUBrEtmnSk2lqSYOY5oPTlTpZ8dBDmibE0dbpBxupE9KElmenOxuB+AW65f+4MgPkOo
 Ty341JVQlPCj2IRvyXPBVwNuQY/iGK0Q5/1kw2qefFQaOiV2m3ITniG4JpyfZ5FqXWxZVQmsB
 t+T9DWSaHxZObLa1dZvXcCRe6/fqd1yIOsXz6oWPBJapTfnlvgj9zZq/922psCPA27oe0JzDn
 cCjEF0Mgn4QjvmBDEXf6MczVZmPOW2MTfsDhRcKt9M1HR5IBiBazIYYkGKDERYDtU7+yQCLvi
 qliLnRDRDkvtazCc20aMh1YQLDI4f+H+aSlKeNnvC/GWyETABJhZGLYzQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/14 15:46, Johannes Thumshirn wrote:
> On 14.07.22 09:32, Qu Wenruo wrote:
>>
>>
>> On 2022/7/14 15:08, Johannes Thumshirn wrote:
>>> On 14.07.22 03:08, Qu Wenruo wrote:> [CASE 2 CURRENT WRITE ORDER, PADD=
ING> No difference than case 1, just when we have finished sector 7, all >=
 zones are exhausted.>> Total written bytes: 64K> Expected written bytes: =
128K (nr_data * 64K)> Efficiency:	1 / nr_data.>
>>> I'm sorry but I have to disagree.
>>> If we're writing less than 64k, everything beyond these 64k will get f=
illed up with 0
>>>
>>>          0                               64K
>>> Disk 1 | D1| 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)
>>> Disk 2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)
>>> Disk 3 | P | P | P | P | P | P | P | P | (Parity stripe)
>>>
>>> So the next write (the CoW) will then be:
>>>
>>>         64k                              128K
>>> Disk 1 | D1| 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)
>>> Disk 2 | D2| 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)
>>> Disk 3 | P'| P'| P'| P'| P'| P'| P'| P'| (Parity stripe)
>>
>> Nope, currently full stripe write should still go into disk1, not disk =
2.
>> Sorry I did use a bad example from the very beginning.
>>
>> In that case, what we should have is:
>>
>>          0                               64K
>> Disk 1 | D1| D2| 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)
>> Disk 2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)
>> Disk 3 | P | P | 0 | 0 | 0 | 0 | 0 | 0 | (Parity stripe)
>>
>> In that case, Parity should still needs two blocks.
>>
>> And when Disk 1 get filled up, we have no way to write into Disk 2.
>>
>>>
>>> For zoned we can play this game zone_size/stripe_size times, which on =
a typical
>>> SMR HDD would be:
>>>
>>> 126M/64k =3D 4096 times until you fill up a zone.
>>
>> No difference.
>>
>> You have extra zone to use, but the result is, the space efficiency wil=
l
>> not be better than RAID1 for the worst case.
>>
>>>
>>> I.e. if you do stupid things you get stupid results. C'est la vie.
>>>
>>
>> You still didn't answer the space efficient problem.
>>
>> RAID56 really rely on overwrite on its P/Q stripes.
>
> Nope, btrfs raid56 does this. Another implementation could for instance
> buffer each stripe in an NVRAM (like described in [1]), or like Chris
> suggested in a RAID1 area on the drives, or doing variable stripe length
> like ZFS' RAID-Z, and so on.

Not only btrfs raid56, but also dm-raid56 also do this.

And what you mention is just an variant of journal, delay the write
until got a full stripe.

>
>> The total write amount is really twice the data writes, that's somethin=
g
>> you can not avoid.
>>
>
> Again if you're doing sub-stripe size writes, you're asking stupid thing=
s and
> then there's no reason to not give the user stupid answers.

No, you can not limit what users do.

As long as btrfs itself support writes in sectorsize (4K), you can not
stop user doing that.

In your argument, I can also say, write-intent is a problem of end
users, and no need to fix at all.

That's definitely not the correct way to do, let user to adapt the
limitation? No, just big no.

Thanks,
Qu

>
> If a user is concerned about the write or space amplicfication of sub-st=
ripe
> writes on RAID56 he/she really needs to rethink the architecture.
>
>
>
> [1]
> S. K. Mishra and P. Mohapatra,
> "Performance study of RAID-5 disk arrays with data and parity cache,"
> Proceedings of the 1996 ICPP Workshop on Challenges for Parallel Process=
ing,
> 1996, pp. 222-229 vol.1, doi: 10.1109/ICPP.1996.537164.
