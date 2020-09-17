Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D273526D3AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 08:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgIQGai (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 02:30:38 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:25234 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgIQGah (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 02:30:37 -0400
X-Greylist: delayed 23285 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 02:30:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600324231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=hjWsPqSXni0Iefm+TOLFDDaaQBia4YbVawG9D37iUOk=;
        b=LrC3Ws1nD32+y/bnhXQg8GdJPpGVTDIesjzuWs5llNC3p/enVorit8/kmNLtPAXPS6IT18
        YBP+JY5+JYhzqvCtWoOHuTTw8nQMSfq5ILZW0SypwJ8c2FQBeYj8zf//SlgyfONNnM4eZ3
        IndpUI3FPvTutNR65JyrNsBkKtAtXYw=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2058.outbound.protection.outlook.com [104.47.9.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-YTycXIsQPc-avX_gQnBB5A-1; Thu, 17 Sep 2020 08:30:29 +0200
X-MC-Unique: YTycXIsQPc-avX_gQnBB5A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE+aBTyoO1nkHab16OZA0OS7dNgynpWeGomU6VHlPLDsAud+1by1UiCyMUKNV2N1NMBRpJHq26joOip07F24hX+yPJ8wHRc2atjSvcm9j7rlybAGGneyC+YeG867yhecoYKiLbsJKtUQ5VMypNSR3CTvaQ4nOjB3NhMEqz+9xM5GELNoPng41pyWobbIozbNcJIybj3GkgD0aIdukSFlyOihMusElgA/QFtGO4Lb09hTt5QQJvQPXQvp8NpgnI/eorwjcjBF/FbSk7JqL6ZJ0EertZd8s3HR9yVIq8RtCxkvzZVhBRW2xJ/RVt2MsZKZ2Tq6k7RO1FozrkZvkXA+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcYpOi4Db94BPMdJlDCzw/W5U+WMwgcu8cLGLmI+zDI=;
 b=Mnlc1+Lu/XblDhderE1pS0EQlJgVA8SWCTALuJOcP8lSOsw7AKPJxzXpowouO9SUpAb3ve/vLHtj5w3bJi7LwimS6fKk1ERLz/c24/4vcAS83R1A1gYkpsTng22QaMN09kmIX1zMFI1de9Td/eKbzi+8wne59dc+4rzrBfWdIuF+/dEJTHIXgQvTP9Nb2ZtEoNIXCXwndhwBQjeuI8/9dLaz9jLduABDTLv5LxlTPA7q0AJsBQJlxtwQm4SLKxZ/n3Nrr7/hAZR3SNpcdgRAleDTcMHuW6LBlFOiUfeccAAkSzwwS7Xw/JtfZ5oZWUqw/sU5GsD+TMvde5cCq00jlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 06:30:28 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 06:30:28 +0000
Subject: Re: Need solution: BTRFS read-only
To:     Thommandra Gowtham <trgowtham123@gmail.com>
CC:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <CA+XNQ=ijYZbtTejEcdfgOAgmUu68d7c2YL-3BLQfokq3YYuZNQ@mail.gmail.com>
 <9b5706c1-fe21-6905-9c42-ffdc985202d9@gmx.com>
 <CA+XNQ=j1=XObwis138fphNcRVfwgXUcfm7JW1FJG2UWm8pBEGA@mail.gmail.com>
 <9415e33b-c018-7a60-33c5-4d2b992bca80@suse.com>
 <CA+XNQ=hVzU5vWB-hw=3vVpiH=Fmx5QAeE-uvmRkSavD2wspdbQ@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <927663a6-589d-e35e-99a7-3ef74b87d046@suse.com>
Date:   Thu, 17 Sep 2020 14:30:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <CA+XNQ=hVzU5vWB-hw=3vVpiH=Fmx5QAeE-uvmRkSavD2wspdbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:217::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 06:30:26 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 714e90f2-a038-4ef3-87c1-08d85ad32b79
X-MS-TrafficTypeDiagnostic: AM0PR04MB7091:
X-Microsoft-Antispam-PRVS: <AM0PR04MB7091DC4244979B71AC6E8E5DD63E0@AM0PR04MB7091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIv2nFyxEuVBzriSrAhuSn6Bd7CQ6CHfkjRjV6xP/wGjAsTxFe+FPFg6WWrPwsrzJ+mK2KmgALAS3IZvQPsLD2akzZfjl7krsYRKV/upn1SNYtxUGTRAcbHdKlmMwELL/Fzzguz0r+htpgEcMXdAxuiNtw9b12VgHp+8TLJsyKKx74eUiS09mI9hRAGlc0fgM51vzorGIVVgKwXIR+AEZNWksxON1kVvH8pCZ+lH8Mgmln/m7z8iRO3fg6NaVXu9TkeJS2T0KoR0/kbRbaQO451xPFv9B+ueE7kVyfzQ3iTGcsFzVjaX+Q2NGct7PJWO02zxWLu4VQUIEVdkg/rpLJibWznHfkAc2UkeLnbD/hD3oFqdvrdQGjMBn5VAv7wQtQuSWV5DM2GX0PptqJJ37F8VnNkdBlNgFcaUCO5Fo9V9KnHk4fdUUbnSPurvpLaY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(956004)(2906002)(2616005)(6666004)(186003)(316002)(26005)(16526019)(83380400001)(8936002)(478600001)(4326008)(31696002)(31686004)(86362001)(36756003)(53546011)(5660300002)(66946007)(8676002)(66556008)(6706004)(16576012)(66476007)(6486002)(6916009)(52116002)(518174003)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tWqSrra7piKUhrFQd8Kbuzl8FIMf61CSA+f/A9meyQBPKQSIXLgPPLRfVNq/fH3GSXsT3+w/pjVpcO0+UBklPAQTVEi69zxQq0Stm0+zFCBo4+kM6HZf1Js6OgM6ZHlzlvP/BEZEUOvym8yRP4Zp1ZP7b4hrU5LhKo7ZobyDv6AvkIBIPovAAs4kUsja8bxZOxxz5iFMHhIbCm8rjhJxIugMWfuB1YZZyxP6U3p58WewwVhgVHDe3t0xZh/Th/x1BOrc91Mst1Q+zLbGPFOCMSbahupASnVF51SrRqGUb2SmE9HmgMvwCKK4cdTLDbIdlFIheakSNgbGcAChq9TkXuCsD2RnF5XViFLrV7wpvaLBxwt+1EjEC98naHou/nSM0sWFdEpwommUnCKoUGyTb3Iewus1wF4mg+DrPKYUZBMYsTweg8LUF/6VzFB+8v4/kIej9KBiTZZRJ27MwNHBTkiWxWedWELu8+dFR+cTGb+ZMQEAIaBfgAfSC+DAgv0qa8coOqWgfy5L9ewg1YAY1LlNeTksURKGWc8kQgS79z0c9Tipk6O7zxujxtxMazsmcm9A5fxQX0FxtQk2Gsk69rtguPond42Ss2N/r+Nuq+VrgcRxuDYrXNa67bE0MwYYdNWHxNP3qYLq0jxIMPy1Pg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714e90f2-a038-4ef3-87c1-08d85ad32b79
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 06:30:28.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOnIaK6jsMAHF5xaPR2eALpMOiKGkU1k5t9/jypcrP6Seb3lB0Cf6T1BiNP6pKVs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/17 =E4=B8=8B=E5=8D=882:15, Thommandra Gowtham wrote:
> Thanks a lot for your response. A few questions
>=20
> - I had evaluated the SSD health by looking at the SMART attributes
> and did not find any faults. Is there any other way to evaluate if a
> problem is indeed hardware related?

SMART should report read error, but I'm not sure if all vendors follows
that.

> - If we had used duplication for metadata, would this issue not be
> seen?

It depends. If your SSD are not doing deduplication at firmware level,
it will increase the chance to survive such situation.

But if your SSD are doing deduplication at firmware level, then no
difference.
That's why mkfs.btrfs uses SINGLE for metadata profile by default on SSD.

> I mean can it survive a sudden power-loss to the system when
> BTRFS is writing to disk?

That's a requirement for all fses, not only btrfs.
And btrfs, just like all the other fses, relies on regular FLUSH/FUA
support from the hardware.
As long as the disk is doing proper FLUSH/FUA, btrfs can survive any
powerloss no matter what.

But I doubt if your problem is really related to power loss.
It really looks some random data are just written to the disk, and it's
not one or two blocks, but a range of disk is overwritten.

> Also, I believe with duplication of metadata
> we can see a performance dip, additional disk space used(critical
> because few of the SSD are low-end 8/16Gb disks as well). Right?

Yes.

Another guess is, since it's low end ssd (possibly without cache/DRAM),
I doubt if it has a fully functional firmware to handle power-loss
during erase-then-write circle of NAND.

Since we need to zero out the NAND row first, then write back the
to-be-written data with other existing data, if not properly
cached/protected, a powerloss during this cycle can screw up the data in
the whole row.

That may explain the problem, but if the corrupted SSD is NVME or has
proper cache/firmware, then it shouldn't be the case I guess.

> - Is there any way we can recover from this situation if we are able
> to clone the disk to a new SSD?

Btrfs-restore is your best chance so far.

Thanks,
Qu

>=20
> Thanks,
> Gowtham
>=20
> On Thu, Sep 17, 2020 at 11:16 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> On 2020/9/17 =E4=B8=8B=E5=8D=881:26, Thommandra Gowtham wrote:
>>> Attached the dmesg file.
>>>
>>> I think the primary cause are the below issues
>>
>> It's really better to see the first btrfs related error to grab a full v=
iew:
>>
>>> [   10.565736] BTRFS error (device sda4): bad tree block start
>> 12455654870318135914 4455038976
>>
>> This shows that, we want bytenr 4455038976 (0x1098a8000), but got
>> 12455654870318135914 (0xacdb601c962d3a6a), which is completely garbage.
>>
>> And according to the later more similar error messages, this means a lot
>> of your metadata are already filled with garbage.
>> This looks like a big problem already.
>>
>> What makes the problem even worse is, there is no duplication for your
>> metadata, thus btrfs can't grab a good copy.
>>
>> So far, this already indicates your fs is heavily damaged by losing tons
>> of its metadata.
>>
>>
>> But so far, btrfs is just failed to *read* tree blocks, not yet enough
>> to force the fs read-only.
>>
>> The killing blow happens here:
>>
>>> [   41.892643] BTRFS error (device sda4): bad tree block start
>> 16883770880424882955 4455632896
>>> [   41.902071] BTRFS: error (device sda4) in __btrfs_free_extent:6997:
>> errno=3D-5 IO failure
>>> [   41.911097] BTRFS info (device sda4): forced readonly
>>
>> When btrfs tries to read extent tree block to update its extent tree, it
>> failed due to garbage on-disk data again.
>>
>> And extent tree update is vital for btrfs, if it fails btrfs has to
>> force the fs RO to prevent further problems.
>>
>>
>> So your fs is too damaged to grab most tree blocks and finally leads to
>> fs RO.
>>
>> According to the error pattern, a range of garbage overwrites btrfs
>> metadata, and this looks more like a hardware problem.
>>
>> Thanks,
>> Qu
>>
>>
>>>
>>>    43.066928] BTRFS warning (device sda4): checksum error at logical
>>> 166334464 on dev /dev/sda4, physical 166334464, root 288, inode
>>> 350101, offset 2965504, length 4096, links 1 (path:
>>> var/etc/vport/vport.mtable.5)
>>> [   43.069662] BTRFS warning (device sda4): checksum error at logical
>>> 166334464 on dev /dev/sda4, physical 166334464, root 285, inode
>>> 350101, offset 2965504, length 4096, links 1 (path:
>>> var/etc/vport/vport.mtable.3)
>>> [   43.072073] BTRFS warning (device sda4): checksum error at logical
>>> 166334464 on dev /dev/sda4, physical 166334464, root 284, inode
>>> 350101, offset 2965504, length 4096, links 1 (path:
>>> var/etc/vport/vport.mtable.0)
>>> [   45.330412] BTRFS warning (device sda4): checksum error at logical
>>> 440729600 on dev /dev/sda4, physical 440729600, root 269, inode 11983,
>>> offset 3682304, length 4096, links 1 (path:
>>> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
>>> [   45.330532] BTRFS warning (device sda4): checksum error at logical
>>> 440860672 on dev /dev/sda4, physical 440860672, root 269, inode 11983,
>>> offset 3813376, length 4096, links 1 (path:
>>> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
>>> [   45.330542] BTRFS warning (device sda4): checksum error at logical
>>> 440668160 on dev /dev/sda4, physical 440668160, root 269, inode 11983,
>>> offset 3620864, length 4096, links 1 (path:
>>> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
>>> [   45.332656] BTRFS warning (device sda4): checksum error at logical
>>> 440729600 on dev /dev/sda4, physical 440729600, root 256, inode 11983,
>>> offset 3682304, length 4096, links 1 (path:
>>> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
>>> [   45.337842] BTRFS warning (device sda4): checksum error at logical
>>> 440860672 on dev /dev/sda4, physical 440860672, root 256, inode 11983,
>>> offset 3813376, length 4096, links 1 (path:
>>> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
>>> [   45.337977] BTRFS warning (device sda4): checksum error at logical
>>> 440668160 on dev /dev/sda4, physical 440668160, root 256, inode 11983,
>>> offset 3620864, length 4096, links 1 (path:
>>> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
>>> [   45.392220] BTRFS warning (device sda4): checksum error at logical
>>> 440672256 on dev /dev/sda4, physical 440672256, root 269, inode 11983,
>>> offset 3624960, length 4096, links 1 (path:
>>> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
>>>
>>> On Thu, Sep 17, 2020 at 10:42 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>>
>>>>
>>>>
>>>> On 2020/9/17 =E4=B8=8B=E5=8D=8812:52, Thommandra Gowtham wrote:
>>>>> Hi,
>>>>>
>>>>> We are using BTRFS as a root filesystem and after a power outage, the
>>>>> file-system is mounted read-only.  The system is stuck in that
>>>>> state(even after multiple reboots) with below errors on console
>>>>
>>>> Please provide full dmesg.
>>>>
>>>> The provided dmesg doesn't provide much help to show the root cause.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> [   35.099841] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
>>>>> rd 0, flush 0, corrupt 1, gen 0
>>>>> [   35.109822] BTRFS error (device sda4): unable to fixup (regular)
>>>>> error at logical 166334464 on dev /dev/sda4
>>>>> [   37.500975] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
>>>>> rd 0, flush 0, corrupt 2, gen 0
>>>>> [   37.510993] BTRFS error (device sda4): unable to fixup (regular)
>>>>> error at logical 440860672 on dev /dev/sda4
>>>>> [   37.522128] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
>>>>> rd 0, flush 0, corrupt 3, gen 0
>>>>>
>>>>> Is there a way to make BTRFS delay moving the filesystem to read-only
>>>>> after a reboot so that we can scrub the FS? Or is there a code-change
>>>>> we can use to modify the btrfs module to affect this change?
>>>>>
>>>>> Regards,
>>>>> Gowtham
>>>>>
>>>>>
>>>>> mount options used:
>>>>> rw,noatime,compress=3Dlzo,ssd,space_cache,commit=3D60,subvolid=3D263
>>>>>
>>>>> #   btrfs --version
>>>>> btrfs-progs v4.4
>>>>>
>>>>> Ubuntu 16.04: 4.15.0-36-generic #1 SMP Mon Oct 22 21:20:30 PDT 2018
>>>>> x86_64 x86_64 x86_64 GNU/Linux
>>>>>
>>>>
>>
>=20

