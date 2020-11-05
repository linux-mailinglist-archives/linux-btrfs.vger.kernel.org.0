Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96F12A8ADB
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 00:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbgKEXkq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 18:40:46 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:28630 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732086AbgKEXkp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 18:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604619637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Z9YOvS2XZMJ5X6N7AFINRh+kme3NWsrAEjix4T5ovPM=;
        b=OhAf9C5ZfOjW9f2uNg6OoFWGTpImrfi8xVaKZOCtwOICQf9h+kl+hfXFZ1e9ZEJPKVDEss
        xlFHdqpsPmqLO1acfis6dn+4N7vxVYFJx7iM0JeDL7lpDjVoIx4o4AyF+CqhStHBg4tj7X
        rpvXw6bCdWY8RffI/LittZqqzXSPYBA=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-QmBCLUrsNveR6CkNXa2JOg-1; Fri, 06 Nov 2020 00:40:36 +0100
X-MC-Unique: QmBCLUrsNveR6CkNXa2JOg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dgor0Aian7qeZNNNjvMNQQg0rVY3kRPnHtLxkED1uJmsD5NozV7XPzh9A48q0nY8V7ucbSvU/k45rF+t4yV01qvK/YXsEtt9iFEGlsLewmA+2S3pVCA9YfpyQbn5olAWILN7IR/E6Efc2l+zIPThKlUJ3zQ6eYRsMAfOrWPDov4INJsVCM20ovqmoEBkbshZqkWJMkqDKMtuheaZ20UC0FpbIYCWBvJAxWyCpVc/UfliMWr4oMT9nnNL85BQsilSVc3qhUJ4mfB+4HAsn1H2I57sjoKQUSG7YhMM6TjUWdQV1fkY/HM5kvNWDUeHnn44fsCfsngWI0VTwt0+ubRtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJGFrRffndrbWpHdnhN6rCAhIIBhLAeszwnKM7c20Ro=;
 b=en6R4slrOje2OVcvzo16IZNkpdm7zlJhyneYQPZcrhUd+f4g8J/csNdZDZLsIimB0PVIEvGn0U88GMIj7Iorvi9rBg2vmhcptM14LKZdAuX7nz17ojJnYjPA8APRSfyTq8aqNb9uCrfcqyzkxPEj+1//m9iNSxSciSY7kUe+xDpOHwdRGW+JjqigBleaB5SaIGyoQN/p0c5/KutK5rEyH1mI1o9pkW+pdCuqjJUlS1UQGDSxWChm2GvNW/SLd2ZkGBM3BV/9bRQzR1mmFXNeSdqblyAEKSYBqT2HAhhO5XwUhuwIw1w1mp5FM760fKl7iNwRmgUkqUyRi3LmJRlDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB7518.eurprd04.prod.outlook.com (2603:10a6:102:e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 5 Nov
 2020 23:40:34 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.021; Thu, 5 Nov 2020
 23:40:34 +0000
Subject: Re: Fwd: Read time tree block corruption detected
To:     Ferry Toth <fntoth@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Tyler Richmond <t.d.richmond@gmail.com>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN25gNo-jgykeQ6=ZQAm1ZHG9+-rWhBp3S-x2c1xi5j-og@mail.gmail.com>
 <4d1bb444-921c-9773-ff68-b6ea074ff35d@gmx.com>
 <CAJheHN1+AQR-irSbaH8f7HGj=rDN4+uUCyqjvtezGewQkQoDpg@mail.gmail.com>
 <5346c4af-c73e-84b3-ec4f-8f169c0a732a@gmx.com>
 <CAJheHN0NmgVoGF+AsnUNQkQnEJ46JCmpg4o5nwAkqi+VoGMjfw@mail.gmail.com>
 <e04680b4-f4c0-254f-24ba-f2053e4ad8b3@gmx.com>
 <CAJheHN0THhKcqKY3cGtJqUGaub=E0tuCmi6wuNeCGBxyAHmecQ@mail.gmail.com>
 <e2c8eaaf-6adb-374f-4005-a1edcbcb8f79@gmx.com>
 <CAJheHN1U4j1KsD96oFuCVwP+6RVP6V6oAZP-aGOTtfm7tDL3BA@mail.gmail.com>
 <CAJheHN3pTj-6dOQZVKqA_r38F+WVNrjVO6-Z_hFeq96uTNK5zw@mail.gmail.com>
 <1f26ff53-f7c7-c497-b69f-8a3e5d8ce959@gmx.com>
 <b7383762-4a86-fdb9-12f3-89470808f4e6@gmail.com>
 <0d6a0602-897a-b170-f1a2-007cff1f23fb@gmx.com>
 <134e61b5-ecf7-bc1a-e16b-c95b14876e6e@gmail.com>
 <5b757c2b-6dbf-cbec-6c66-e4b14897f53c@gmx.com>
 <838490cf-fc40-0008-88bb-eeede1e8d873@gmail.com>
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
Message-ID: <50e0ef4d-061e-d02d-9dbf-61f83dfa7b3e@suse.com>
Date:   Fri, 6 Nov 2020 07:40:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <838490cf-fc40-0008-88bb-eeede1e8d873@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::34) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0119.namprd13.prod.outlook.com (2603:10b6:a03:2c5::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend Transport; Thu, 5 Nov 2020 23:40:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1fa7d0a-de63-4da9-6ad3-08d881e43054
X-MS-TrafficTypeDiagnostic: PA4PR04MB7518:
X-Microsoft-Antispam-PRVS: <PA4PR04MB7518DF7C848715A2B0BBE505D6EE0@PA4PR04MB7518.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +mOhVm7/0/VY4OLNMIUx/xMaCj9UGTP72qGAIE1R5X+lGEfh/Jnc7TSBF2uup+p7Lcu+0NecQfIDWLs8kysGFz8HQM4qHDg/OqdZNwNoQHQvAK6uCNKouhcTaA3aJKrdpcbrwKPyFUXduv4PnzNREL4r+jXDr3ZsKqUwyP13GuKMTltbq25eQgo+7YnSk1ynbyK7HNlDGVUh3KOpX1+EGycrCgiQgaxp9l/YpYSNf9AbGag8pK4ga/GXa+bPinvNg9hcCTpqISnWUd8fFD8qgkE5egVoQ1VEVF5QXi+sqjysFwqslk2Oxvr3FIUTEpkYgc+tLeRWvZfcSscDnDlYo4hJmQ7DobBDG9Hr2mpxiAHT7GThkT4vXEzzsgeHZCwy+EMIc8Ljdr2CAZQqr182atFJiFBjcY4yarJKU+IoAIv6W+emz3T7YX14ZslMiGTxoyClqejpEr+Gr+1+1D6q7legIUm6ZitnajL6itH3SEFXhb/PzjPPteVnWZu/+/eb9OtjrieyTZc0vlqwS4ucX33Eh/rJwIW/tAgqLRizRa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(396003)(39850400004)(31696002)(16576012)(8936002)(2616005)(16526019)(6666004)(8676002)(52116002)(4326008)(956004)(110136005)(478600001)(26005)(186003)(31686004)(30864003)(5660300002)(36756003)(316002)(53546011)(6706004)(2906002)(86362001)(66476007)(966005)(66946007)(6486002)(83380400001)(66556008)(10126625002)(518174003)(78286007)(43740500002)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QVwPufryvb5y1aij74fT18jx8M7gVP1MFCFPWmB/hG8FzQoMoPJhb/B9L9L/TG0uvzZSu1iEirXXn/6UEPea8eLDK8hJ1snPRSAG6j/k77AJjquEAQ/pCjGOlTjCv9JDPLQfbtzKvYGdneiRm6xBn1Fpi5BnjcXSwLPWj+5ikfuiPosfv/vKp1cZZFXGli4WM5YcSE9eCZg3aHEyQBjUtvl0WIiXGKUrIieK7EIX3PCZZ2/H+eaxnA8p8LaA0PQfcLiO4PS5tUaiTkCDpWrzJtFscSF5Be2teVTLT7gDP0uif4h9ff+SbqIyE7Jfyz5v0mA8Yu1xS+6NuMNX0M4Fe1aqDa7zzThvilZ/BYALUzTiKooJeQWxAhSBfZP1qPaAsnW5gHs4ux2p/iCCWnzPOTYVmxgaa/WJ0uPvGOKTIgGVFQG7Rul5/GHyJtxmic+jWEE7VR3Lua3tlMtTqp0BQOXPRwmMDBAAxoAKUNS8FZ14ikGzwZE82XGVPT7k/pQCzQobhLQr1tIVLsm7cstsFMVXoh2XsKad1XFg9RHYk7z6qz1DgAdRqsHDpX4TGPZgOO/vvpvql0r7LpVzExGbG7feTthHZWRlNO2OedBkL4lAiJRAQuIWiuobGoofDTmN8L0/dBbl9dEceVwHroC71w==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fa7d0a-de63-4da9-6ad3-08d881e43054
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 23:40:34.0691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utlh6QPmZsOu/caEYW8FHMgVGiORaY6vS8mRiT+XA59xqv5cdHRAIBdvJoZFvhNZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7518
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/6 =E4=B8=8A=E5=8D=887:37, Ferry Toth wrote:
> Hi
>=20
> Op 06-11-2020 om 00:32 schreef Qu Wenruo:
>>
>> On 2020/11/6 =E4=B8=8A=E5=8D=887:12, Ferry Toth wrote:
>>> Hi,
>>>
>>> Op 06-11-2020 om 00:00 schreef Qu Wenruo:
>>>> On 2020/11/6 =E4=B8=8A=E5=8D=884:08, Ferry Toth wrote:
>>>>> I am in a similar spot, during updating my distro (Kubuntu), I am
>>>>> unable
>>>>> to update a certain package. I know which file it is:
>>>>>
>>>>> ~$ ls -l /usr/share/doc/libatk1.0-data
>>>>> ls: kan geen toegang krijgen tot '/usr/share/doc/libatk1.0-data':
>>>>> Invoer-/uitvoerfout
>>>>>
>>>>> This creates the following in journal:
>>>>>
>>>>> kernel: BTRFS critical (device sda2): corrupt leaf: root=3D294
>>>>> block=3D1169152675840 slot=3D1 ino=3D915987, invalid inode generation=
: has
>>>>> 18446744073709551492 expect [0, 5851353]
>>>>> kernel: BTRFS error (device sda2): block=3D1169152675840 read time tr=
ee
>>>>> block corruption detected
>>>>>
>>>>> Now, the problem: this file is on my rootfs, which is mounted. apt
>>>>> (distribution updated) installed all packages but can't continue
>>>>> configuring, because libatk is a dependancy. I can't delete the file
>>>>> because of the I/O error. And btrfs check complains (I tried
>>>>> running RO)
>>>>> because the file system is mounted.
>>>>>
>>>>> But, on the sunny side, the file system is not RO.
>>>>>
>>>>> Is there any way to forcefully remove the file? Or do you have a
>>>>> recommendation how to proceed?
>>>> Newer kernel will reject to even read the item, thus will not be
>>>> able to
>>>> remove it.
>>> That's already the case. (input / output error)
>>>> I guess you have to use some distro ISO to fix the fs.
>>> And then? btrfs check --repair the disk offline?
>> Yep.
>>
>> You would want the latest btrfs-progs though.
> Groovy has 5.7. Would that be good enough? Otherwise will be difficult
> to build on/for live usb image.

For your particular case, the fix are already in btrfs-progs v5.4.

Although newer is always better, just in case you have extent item
generation corruption, you may want v5.4.1.

So your v5.7 should be good enough.

Thanks,
Qu

>>
>> THanks,
>> Qu
>>>> Thanks,
>>>> Qu
>>>>
>>>>> Linux =3D 5.6.0-1032-oem
>>>>>
>>>>> Thanks,
>>>>> Ferry
>>>>>
>>>>> Op 05-11-2020 om 08:19 schreef Qu Wenruo:
>>>>>> On 2020/11/5 =E4=B8=8B=E5=8D=883:01, Tyler Richmond wrote:
>>>>>>> Qu,
>>>>>>>
>>>>>>> I'm wondering, was a fix for this ever implemented?
>>>>>> Already implemented the --repair ability in latest btrfs-progs.
>>>>>>
>>>>>>> I recently added a
>>>>>>> new drive to expand the array, and during the rebalance it dropped
>>>>>>> itself back to a read only filesystem. I suspect it's related to th=
e
>>>>>>> issues discussed earlier in this thread. Is there anything I can
>>>>>>> do to
>>>>>>> complete the balance? The error that caused it to drop to read
>>>>>>> only is
>>>>>>> here: https://pastebin.com/GGYVMaiG
>>>>>> Yep, the same cause.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>> Thanks!
>>>>>>>
>>>>>>>
>>>>>>> On Tue, Aug 25, 2020 at 9:43 AM Tyler Richmond
>>>>>>> <t.d.richmond@gmail.com> wrote:
>>>>>>>> Great, glad we got somewhere! I'll look forward to the fix!
>>>>>>>>
>>>>>>>> On Tue, Aug 25, 2020 at 9:38 AM Qu Wenruo <quwenruo.btrfs@gmx.com>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> On 2020/8/25 =E4=B8=8B=E5=8D=889:30, Tyler Richmond wrote:
>>>>>>>>>> Qu,
>>>>>>>>>>
>>>>>>>>>> The dump of the block is:
>>>>>>>>>>
>>>>>>>>>> https://pastebin.com/ran85JJv
>>>>>>>>>>
>>>>>>>>>> I've also completed the btrfs-image, but it's almost 50gb.
>>>>>>>>>> What's the
>>>>>>>>>> best way to get it to you? Also, does it work with -ss or are th=
e
>>>>>>>>>> original filenames important?
>>>>>>>>> 50G is too big for me to even receive.
>>>>>>>>>
>>>>>>>>> But your dump shows the problem!
>>>>>>>>>
>>>>>>>>> It's not inode generation, but inode transid, which would affect
>>>>>>>>> send.
>>>>>>>>>
>>>>>>>>> This is not even checked in btrfs-progs, thus no wonder why it
>>>>>>>>> doesn't
>>>>>>>>> detect them.
>>>>>>>>>
>>>>>>>>> And copy-pasted kernel message shares the same "generation" word,
>>>>>>>>> not
>>>>>>>>> using proper transid to show the problem.
>>>>>>>>>
>>>>>>>>> Your dump really saved the day!
>>>>>>>>>
>>>>>>>>> The fix for kernel and btrfs-progs would come in next few days.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>> Thanks again!
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On Tue, Aug 25, 2020 at 2:37 AM Qu Wenruo
>>>>>>>>>> <quwenruo.btrfs@gmx.com>
>>>>>>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On 2020/8/25 =E4=B8=8B=E5=8D=881:25, Tyler Richmond wrote:
>>>>>>>>>>>> Qu,
>>>>>>>>>>>>
>>>>>>>>>>>> Yes, it's btrfs-progs 5.7. Here is the result of the lowmem
>>>>>>>>>>>> check:
>>>>>>>>>>>>
>>>>>>>>>>>> https://pastebin.com/8Tzx23EX
>>>>>>>>>>> That doesn't detect any inode generation problem at all,
>>>>>>>>>>> which is
>>>>>>>>>>> not a
>>>>>>>>>>> good sign.
>>>>>>>>>>>
>>>>>>>>>>> Would you also pvode the dump for the offending block?
>>>>>>>>>>>
>>>>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode
>>>>>>>>>>>> generation:
>>>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>>>>>
>>>>>>>>>>> For this case, would you please provide the tree dump of
>>>>>>>>>>> "203510940835840" ?
>>>>>>>>>>>
>>>>>>>>>>> # btrfs ins dump-tree -b 203510940835840 <device>
>>>>>>>>>>>
>>>>>>>>>>> And, since btrfs-image can't dump with regular extent tree, the
>>>>>>>>>>> "-w"
>>>>>>>>>>> dump would also help.
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Qu
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>
>>>>>>>>>>>> On Mon, Aug 24, 2020 at 4:26 AM Qu Wenruo
>>>>>>>>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 2020/8/24 =E4=B8=8A=E5=8D=8810:47, Tyler Richmond wrote:
>>>>>>>>>>>>>> Qu,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Finally finished another repair and captured the output.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> https://pastebin.com/ffcbwvd8
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Does that show you what you need? Or should I still do one i=
n
>>>>>>>>>>>>>> lowmem mode?
>>>>>>>>>>>>> Lowmem mode (no need for --repair) is recommended since
>>>>>>>>>>>>> original mode
>>>>>>>>>>>>> doesn't detect the inode generation problem.
>>>>>>>>>>>>>
>>>>>>>>>>>>> And it's already btrfs-progs v5.7 right?
>>>>>>>>>>>>>
>>>>>>>>>>>>> THanks,
>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>> Thanks for your help!
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Sun, Aug 23, 2020 at 12:28 AM Qu Wenruo
>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=8810:49, Tyler Richmond wrote:
>>>>>>>>>>>>>>>> Well, I can guarantee that I didn't create this fs before
>>>>>>>>>>>>>>>> 2015 (just
>>>>>>>>>>>>>>>> checked the order confirmation from when I bought the
>>>>>>>>>>>>>>>> server), but I
>>>>>>>>>>>>>>>> may have just used whatever was in the Ubuntu package
>>>>>>>>>>>>>>>> manager at the
>>>>>>>>>>>>>>>> time. So maybe I don't have a v0 ref?
>>>>>>>>>>>>>>> Then btrfs-image shouldn't report that.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> There is an item smaller than any valid btrfs item, normall=
y
>>>>>>>>>>>>>>> it means
>>>>>>>>>>>>>>> it's a v0 ref.
>>>>>>>>>>>>>>> If not, then it could be a bigger problem.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Could you please provide the full btrfs-check output?
>>>>>>>>>>>>>>> Also, if possible result from "btrfs check --mode=3Dlowmem"
>>>>>>>>>>>>>>> would also help.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Also, if you really go "--repair", then the full output
>>>>>>>>>>>>>>> would
>>>>>>>>>>>>>>> also be
>>>>>>>>>>>>>>> needed to determine what's going wrong.
>>>>>>>>>>>>>>> There is a report about "btrfs check --repair" didn't repai=
r
>>>>>>>>>>>>>>> the inode
>>>>>>>>>>>>>>> generation, if that's the case we must have a bug then.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>> On Sat, Aug 22, 2020 at 10:31 PM Qu Wenruo
>>>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=889:51, Qu Wenruo wrote:
>>>>>>>>>>>>>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=889:15, Tyler Richmond wrot=
e:
>>>>>>>>>>>>>>>>>>> Is my best bet just to downgrade the kernel and then tr=
y
>>>>>>>>>>>>>>>>>>> to delete the
>>>>>>>>>>>>>>>>>>> broken files? Or should I rebuild from scratch? Just
>>>>>>>>>>>>>>>>>>> don't know
>>>>>>>>>>>>>>>>>>> whether it's worth the time to try and figure this
>>>>>>>>>>>>>>>>>>> out or
>>>>>>>>>>>>>>>>>>> if the
>>>>>>>>>>>>>>>>>>> problems stem from the FS being too old and it's beyond
>>>>>>>>>>>>>>>>>>> trying to
>>>>>>>>>>>>>>>>>>> repair.
>>>>>>>>>>>>>>>>>> All invalid inode generations, should be able to be
>>>>>>>>>>>>>>>>>> repaired by latest
>>>>>>>>>>>>>>>>>> btrfs-check.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> If not, please provide the btrfs-image dump for us to
>>>>>>>>>>>>>>>>>> determine what's
>>>>>>>>>>>>>>>>>> going wrong.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>>>> On Tue, Aug 18, 2020 at 8:18 AM Tyler Richmond
>>>>>>>>>>>>>>>>>>> <t.d.richmond@gmail.com> wrote:
>>>>>>>>>>>>>>>>>>>> I didn't check dmesg during the btrfs check, but that
>>>>>>>>>>>>>>>>>>>> was the only
>>>>>>>>>>>>>>>>>>>> output during the rm -f before it was forced
>>>>>>>>>>>>>>>>>>>> readonly. I
>>>>>>>>>>>>>>>>>>>> just checked
>>>>>>>>>>>>>>>>>>>> dmesg for inode generation values, and there are a lot
>>>>>>>>>>>>>>>>>>>> of them.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> https://pastebin.com/stZdN0ta
>>>>>>>>>>>>>>>>>>>> The dmesg output had 990 lines containing inode
>>>>>>>>>>>>>>>>>>>> generation.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> However, these were at least later. I tried to do a
>>>>>>>>>>>>>>>>>>>> btrfs balance
>>>>>>>>>>>>>>>>>>>> -mconvert raid1 and it failed with an I/O error.
>>>>>>>>>>>>>>>>>>>> That is
>>>>>>>>>>>>>>>>>>>> probably what
>>>>>>>>>>>>>>>>>>>> generated these specific errors, but maybe they were
>>>>>>>>>>>>>>>>>>>> also happening
>>>>>>>>>>>>>>>>>>>> during the btrfs repair.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> The FS is ~45TB, but the btrfs-image -c9 failed anway
>>>>>>>>>>>>>>>>>>>> with:
>>>>>>>>>>>>>>>>>>>> ERROR: either extent tree is corrupted or deprecated
>>>>>>>>>>>>>>>>>>>> extent ref format
>>>>>>>>>>>>>>>>>>>> ERROR: create failed: -5
>>>>>>>>>>>>>>>>> Oh, forgot this part.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> This means you have v0 ref?!
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Then the fs is too old, no progs/kernel support after all=
.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> In that case, please rollback to the last working kernel
>>>>>>>>>>>>>>>>> and copy your data.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> In fact, that v0 ref should only be in the code base for
>>>>>>>>>>>>>>>>> several weeks
>>>>>>>>>>>>>>>>> before 2010, thus it's really too old.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> The good news is, with tree-checker, we should never
>>>>>>>>>>>>>>>>> experience such
>>>>>>>>>>>>>>>>> too-old-to-be-usable problem (at least I hope so)
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> On Tue, Aug 18, 2020 at 2:07 AM Qu Wenruo
>>>>>>>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> On 2020/8/18 =E4=B8=8A=E5=8D=8811:35, Tyler Richmond =
wrote:
>>>>>>>>>>>>>>>>>>>>>> Qu,
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> Sorry to resurrect this thread, but I just ran into
>>>>>>>>>>>>>>>>>>>>>> something that I
>>>>>>>>>>>>>>>>>>>>>> can't really just ignore. I've found a folder that i=
s
>>>>>>>>>>>>>>>>>>>>>> full of files
>>>>>>>>>>>>>>>>>>>>>> which I guess have been broken somehow. I found a
>>>>>>>>>>>>>>>>>>>>>> backup and restored
>>>>>>>>>>>>>>>>>>>>>> them, but I want to delete this folder of broken
>>>>>>>>>>>>>>>>>>>>>> files. But whenever I
>>>>>>>>>>>>>>>>>>>>>> try, the fs is forced into readonly mode again. I
>>>>>>>>>>>>>>>>>>>>>> just
>>>>>>>>>>>>>>>>>>>>>> finished another
>>>>>>>>>>>>>>>>>>>>>> btrfs check --repair but it didn't fix the problem.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> https://pastebin.com/eTV3s3fr
>>>>>>>>>>>>>>>>>>>>> Is that the full output?
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> No inode generation bugs?
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0 I'm already on btrfs-progs v5.7. =
Any new
>>>>>>>>>>>>>>>>>>>>>> suggestions?
>>>>>>>>>>>>>>>>>>>>> Strange.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> The detection and repair should have been merged into
>>>>>>>>>>>>>>>>>>>>> v5.5.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> If your fs is small enough, would you please provide
>>>>>>>>>>>>>>>>>>>>> the "btrfs-image
>>>>>>>>>>>>>>>>>>>>> -c9" dump?
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> It would contain the filenames and directories names,
>>>>>>>>>>>>>>>>>>>>> but doesn't
>>>>>>>>>>>>>>>>>>>>> contain file contents.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>>>>>>> On Fri, May 8, 2020 at 9:52 AM Tyler Richmond
>>>>>>>>>>>>>>>>>>>>>> <t.d.richmond@gmail.com
>>>>>>>>>>>>>>>>>>>>>> <mailto:t.d.richmond@gmail.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.6.1 also fail=
ed the same way. Here's the
>>>>>>>>>>>>>>>>>>>>>> usage
>>>>>>>>>>>>>>>>>>>>>> output. This is the
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part where you =
see I've been using RAID5 haha
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARNING: RAID56=
 detected, not implemented
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Overall:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 60.03TiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 98.06GiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 59.93TiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 92.56GiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>>>>>>>>>>>>>>>>>>>>>> (min: 8.00EiB)
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0.00
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512.00MiB
>>>>>>>>>>>>>>>>>>>>>> (used: 0.00B)
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Multiple profiles:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Data,RAID5: Siz=
e:40.35TiB, Used:40.12TiB
>>>>>>>>>>>>>>>>>>>>>> (99.42%)
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.07TiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.07TiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.07TiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.07TiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.07TiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sde=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.07TiB
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Metadata,RAID1:=
 Size:49.00GiB, Used:46.28GiB
>>>>>>>>>>>>>>>>>>>>>> (94.44%)
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 34.00GiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00GiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00GiB
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 System,RAID1: S=
ize:32.00MiB, Used:2.20MiB
>>>>>>>>>>>>>>>>>>>>>> (6.87%)
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00MiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00MiB
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Unallocated:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.81TiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.81TiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.81TiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.03TiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.03TiB
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /dev/sde=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.03TiB
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 On Fri, May 8, =
2020 at 1:47 AM Qu Wenruo
>>>>>>>>>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <mailto:quwenru=
o.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > On 2020/5/8 =
=E4=B8=8B=E5=8D=881:12, Tyler Richmond wrote:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > > If this is =
saying there's no extra
>>>>>>>>>>>>>>>>>>>>>> space for
>>>>>>>>>>>>>>>>>>>>>> metadata, is that why
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > > adding more=
 files often makes the
>>>>>>>>>>>>>>>>>>>>>> system hang
>>>>>>>>>>>>>>>>>>>>>> for 30-90s? Is there
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > > anything I =
should do about that?
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > I'm not sure =
about the hang though.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > It would be n=
ice to give more info to
>>>>>>>>>>>>>>>>>>>>>> diagnosis.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > The output of=
 'btrfs fi usage' is useful for
>>>>>>>>>>>>>>>>>>>>>> space usage problem.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > But the commo=
n idea is, to keep at 1~2 Gi
>>>>>>>>>>>>>>>>>>>>>> unallocated (not avaiable
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > space in vani=
lla df command) space for
>>>>>>>>>>>>>>>>>>>>>> btrfs.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Thanks,
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Qu
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > > Thank you s=
o much for all of your help. I
>>>>>>>>>>>>>>>>>>>>>> love how flexible BTRFS is
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > > but when th=
ings go wrong it's very hard
>>>>>>>>>>>>>>>>>>>>>> for
>>>>>>>>>>>>>>>>>>>>>> me to troubleshoot.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > > On Fri, May=
 8, 2020 at 1:07 AM Qu Wenruo
>>>>>>>>>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <mailto:quwenru=
o.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> On 2020/5/=
8 =E4=B8=8B=E5=8D=8812:23, Tyler Richmond
>>>>>>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> Something=
 went wrong:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> Reinitial=
ize checksum tree
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> Unable to=
 find block group for 0
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> Unable to=
 find block group for 0
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> Unable to=
 find block group for 0
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> ctree.c:2=
272: split_leaf: BUG_ON `1`
>>>>>>>>>>>>>>>>>>>>>> triggered, value 1
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> btrfs(+0x=
6dd94)[0x55a933af7d94]
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> btrfs(+0x=
71b94)[0x55a933afbb94]
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>
>>>>>>>>>>>>>>>>>>>>>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>
>>>>>>>>>>>>>>>>>>>>>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> btrfs(+0x=
360b2)[0x55a933ac00b2]
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> btrfs(+0x=
46a3e)[0x55a933ad0a3e]
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> btrfs(mai=
n+0x98)[0x55a933a9fe88]
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0
>>>>>>>>>>>>>>>>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x=
f3)[0x7f263ed550b3]
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> btrfs(_st=
art+0x2e)[0x55a933a9fa0e]
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> Aborted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> This means=
 no space for extra metadata...
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> Anyway the=
 csum tree problem shouldn't
>>>>>>>>>>>>>>>>>>>>>> be a
>>>>>>>>>>>>>>>>>>>>>> big thing, you
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 could leave
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> it and cal=
l it a day.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> BTW, as lo=
ng as btrfs check reports no
>>>>>>>>>>>>>>>>>>>>>> extra
>>>>>>>>>>>>>>>>>>>>>> problem for the inode
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> generation=
, it should be pretty safe
>>>>>>>>>>>>>>>>>>>>>> to use
>>>>>>>>>>>>>>>>>>>>>> the fs.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> Thanks,
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >> Qu
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> I just no=
ticed I have btrfs-progs 5.6
>>>>>>>>>>>>>>>>>>>>>> installed and 5.6.1 is
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> available=
. I'll let that try overnight?
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>> On Thu, M=
ay 7, 2020 at 8:11 PM Qu Wenruo
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <quwenruo.btrfs=
@gmx.com
>>>>>>>>>>>>>>>>>>>>>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> On 2020/=
5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond
>>>>>>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> Thank y=
ou for helping. The end
>>>>>>>>>>>>>>>>>>>>>> result of
>>>>>>>>>>>>>>>>>>>>>> the scan was:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [1/7] c=
hecking root items
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [2/7] c=
hecking extents
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [3/7] c=
hecking free space cache
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [4/7] c=
hecking fs roots
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> Good new=
s is, your fs is still mostly
>>>>>>>>>>>>>>>>>>>>>> fine.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [5/7] c=
hecking only csums items
>>>>>>>>>>>>>>>>>>>>>> (without
>>>>>>>>>>>>>>>>>>>>>> verifying data)
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> there a=
re no extents for csum range
>>>>>>>>>>>>>>>>>>>>>> 0-69632
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> csum ex=
ists for 0-69632 but there
>>>>>>>>>>>>>>>>>>>>>> is no
>>>>>>>>>>>>>>>>>>>>>> extent record
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> ...
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> ...
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> there a=
re no extents for csum range
>>>>>>>>>>>>>>>>>>>>>> 946692096-946827264
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> csum ex=
ists for 946692096-946827264
>>>>>>>>>>>>>>>>>>>>>> but
>>>>>>>>>>>>>>>>>>>>>> there is no extent
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 record
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> there a=
re no extents for csum range
>>>>>>>>>>>>>>>>>>>>>> 946831360-947912704
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> csum ex=
ists for 946831360-947912704
>>>>>>>>>>>>>>>>>>>>>> but
>>>>>>>>>>>>>>>>>>>>>> there is no extent
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 record
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> ERROR: =
errors found in csum tree
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> Only ext=
ent tree is corrupted.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> Normally=
 btrfs check --init-csum-tree
>>>>>>>>>>>>>>>>>>>>>> should be able to
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle it.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> But stil=
l, please be sure you're
>>>>>>>>>>>>>>>>>>>>>> using the
>>>>>>>>>>>>>>>>>>>>>> latest btrfs-progs
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to fix it.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> Thanks,
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>> Qu
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [6/7] c=
hecking root refs
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> [7/7] c=
hecking quota groups skipped
>>>>>>>>>>>>>>>>>>>>>> (not
>>>>>>>>>>>>>>>>>>>>>> enabled on this FS)
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> found 4=
4157956026368 bytes used,
>>>>>>>>>>>>>>>>>>>>>> error(s)
>>>>>>>>>>>>>>>>>>>>>> found
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> total c=
sum bytes: 42038602716
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> total t=
ree bytes: 49688616960
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> total f=
s tree bytes: 1256427520
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> total e=
xtent tree bytes: 1709105152
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> btree s=
pace waste bytes: 3172727316
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> file da=
ta blocks allocated:
>>>>>>>>>>>>>>>>>>>>>> 261625653436416
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>=C2=A0 r=
eferenced 47477768499200
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> What do=
 I need to do to fix all of
>>>>>>>>>>>>>>>>>>>>>> this?
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>> On Thu,=
 May 7, 2020 at 1:52 AM Qu
>>>>>>>>>>>>>>>>>>>>>> Wenruo
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <quwenruo.btrfs=
@gmx.com
>>>>>>>>>>>>>>>>>>>>>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> On 202=
0/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond
>>>>>>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Well,=
 the repair doesn't look
>>>>>>>>>>>>>>>>>>>>>> terribly
>>>>>>>>>>>>>>>>>>>>>> successful.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t transid verify failed on
>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6=
876224
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t transid verify failed on
>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6=
876224
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t transid verify failed on
>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6=
876224
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignor=
ing transid failure
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR=
: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t level=3D1
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
>>>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> This m=
eans there are more
>>>>>>>>>>>>>>>>>>>>>> problems, not
>>>>>>>>>>>>>>>>>>>>>> only the hash name
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mismatch.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> This m=
eans the fs is already
>>>>>>>>>>>>>>>>>>>>>> corrupted,
>>>>>>>>>>>>>>>>>>>>>> the name hash is
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 just one
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> unrela=
ted symptom.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> The on=
ly good news is, btrfs-progs
>>>>>>>>>>>>>>>>>>>>>> abort
>>>>>>>>>>>>>>>>>>>>>> the transaction,
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thus no
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> furthe=
r damage to the fs.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> Please=
 run a plain btrfs-check to
>>>>>>>>>>>>>>>>>>>>>> show
>>>>>>>>>>>>>>>>>>>>>> what's the problem
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> Thanks=
,
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>> Qu
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t transid verify failed on
>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6=
876224
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignor=
ing transid failure
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR=
: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t level=3D1
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
>>>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t transid verify failed on
>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6=
876224
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignor=
ing transid failure
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR=
: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t level=3D1
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
>>>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t transid verify failed on
>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6=
876224
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignor=
ing transid failure
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR=
: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t level=3D1
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
>>>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t transid verify failed on
>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6=
876224
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignor=
ing transid failure
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR=
: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t level=3D1
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
>>>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t transid verify failed on
>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6=
876224
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignor=
ing transid failure
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR=
: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t level=3D1
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
>>>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t transid verify failed on
>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6=
876224
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignor=
ing transid failure
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR=
: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t level=3D1
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
>>>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t transid verify failed on
>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6=
876224
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignor=
ing transid failure
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR=
: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t level=3D1
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
>>>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t transid verify failed on
>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6=
876224
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignor=
ing transid failure
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR=
: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t level=3D1
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
>>>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t transid verify failed on
>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6=
876224
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignor=
ing transid failure
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR=
: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t level=3D1
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
>>>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t transid verify failed on
>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6875841 found 6=
876224
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> Ignor=
ing transid failure
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR=
: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>> bytenr=3D225049956061184
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=3D84
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> paren=
t level=3D1
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
>>>>>>>>>>>>>>>>>>>>>> child level=3D4
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR=
: failed to zero log tree: -17
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> ERROR=
: attempt to start transaction
>>>>>>>>>>>>>>>>>>>>>> over already running one
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> WARNI=
NG: reserved space leaked,
>>>>>>>>>>>>>>>>>>>>>> flag=3D0x4 bytes_reserved=3D4096
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> exten=
t buffer leak: start
>>>>>>>>>>>>>>>>>>>>>> 225049066086400 len 4096
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> exten=
t buffer leak: start
>>>>>>>>>>>>>>>>>>>>>> 225049066086400 len 4096
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> WARNI=
NG: dirty eb leak (aborted
>>>>>>>>>>>>>>>>>>>>>> trans):
>>>>>>>>>>>>>>>>>>>>>> start
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 225049066086400=
 len 4096
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> exten=
t buffer leak: start
>>>>>>>>>>>>>>>>>>>>>> 225049066094592 len 4096
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> exten=
t buffer leak: start
>>>>>>>>>>>>>>>>>>>>>> 225049066094592 len 4096
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> WARNI=
NG: dirty eb leak (aborted
>>>>>>>>>>>>>>>>>>>>>> trans):
>>>>>>>>>>>>>>>>>>>>>> start
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 225049066094592=
 len 4096
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> exten=
t buffer leak: start
>>>>>>>>>>>>>>>>>>>>>> 225049066102784 len 4096
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> exten=
t buffer leak: start
>>>>>>>>>>>>>>>>>>>>>> 225049066102784 len 4096
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> WARNI=
NG: dirty eb leak (aborted
>>>>>>>>>>>>>>>>>>>>>> trans):
>>>>>>>>>>>>>>>>>>>>>> start
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 225049066102784=
 len 4096
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> exten=
t buffer leak: start
>>>>>>>>>>>>>>>>>>>>>> 225049066131456 len 4096
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> exten=
t buffer leak: start
>>>>>>>>>>>>>>>>>>>>>> 225049066131456 len 4096
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> WARNI=
NG: dirty eb leak (aborted
>>>>>>>>>>>>>>>>>>>>>> trans):
>>>>>>>>>>>>>>>>>>>>>> start
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 225049066131456=
 len 4096
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> What =
is going on?
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>> On We=
d, May 6, 2020 at 9:30 PM Tyler
>>>>>>>>>>>>>>>>>>>>>> Richmond
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <t.d.richmond@g=
mail.com
>>>>>>>>>>>>>>>>>>>>>> <mailto:t.d.richmond@gmail.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>> Chri=
s, I had used the correct
>>>>>>>>>>>>>>>>>>>>>> mountpoint in the command.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I just edited
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>> it i=
n the email to be
>>>>>>>>>>>>>>>>>>>>>> /mountpoint for
>>>>>>>>>>>>>>>>>>>>>> consistency.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>> Qu, =
I'll try the repair. Fingers
>>>>>>>>>>>>>>>>>>>>>> crossed!
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>> On W=
ed, May 6, 2020 at 9:13 PM Qu
>>>>>>>>>>>>>>>>>>>>>> Wenruo
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <quwenruo.btrfs=
@gmx.com
>>>>>>>>>>>>>>>>>>>>>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> On =
2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler
>>>>>>>>>>>>>>>>>>>>>> Richmond
>>>>>>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> He=
llo,
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> I =
looked up this error and it
>>>>>>>>>>>>>>>>>>>>>> basically says ask a
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 developer to
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> de=
termine if it's a false
>>>>>>>>>>>>>>>>>>>>>> error or
>>>>>>>>>>>>>>>>>>>>>> not. I just started
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 getting some
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> sl=
ow response times, and
>>>>>>>>>>>>>>>>>>>>>> looked at
>>>>>>>>>>>>>>>>>>>>>> the dmesg log to
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 find a ton of
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> th=
ese errors.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> [1=
92088.446299] BTRFS critical
>>>>>>>>>>>>>>>>>>>>>> (device sdh): corrupt
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf: root=3D5
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> bl=
ock=3D203510940835840 slot=3D4
>>>>>>>>>>>>>>>>>>>>>> ino=3D1311670, invalid inode
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> ha=
s 18446744073709551492
>>>>>>>>>>>>>>>>>>>>>> expect [0,
>>>>>>>>>>>>>>>>>>>>>> 6875827]
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> [1=
92088.449823] BTRFS error
>>>>>>>>>>>>>>>>>>>>>> (device
>>>>>>>>>>>>>>>>>>>>>> sdh):
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block=3D2035109=
40835840 read
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> ti=
me tree block corruption
>>>>>>>>>>>>>>>>>>>>>> detected
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> [1=
92088.459238] BTRFS critical
>>>>>>>>>>>>>>>>>>>>>> (device sdh): corrupt
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf: root=3D5
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> bl=
ock=3D203510940835840 slot=3D4
>>>>>>>>>>>>>>>>>>>>>> ino=3D1311670, invalid inode
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> ha=
s 18446744073709551492
>>>>>>>>>>>>>>>>>>>>>> expect [0,
>>>>>>>>>>>>>>>>>>>>>> 6875827]
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> [1=
92088.462773] BTRFS error
>>>>>>>>>>>>>>>>>>>>>> (device
>>>>>>>>>>>>>>>>>>>>>> sdh):
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block=3D2035109=
40835840 read
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> ti=
me tree block corruption
>>>>>>>>>>>>>>>>>>>>>> detected
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> [1=
92088.464711] BTRFS critical
>>>>>>>>>>>>>>>>>>>>>> (device sdh): corrupt
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf: root=3D5
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> bl=
ock=3D203510940835840 slot=3D4
>>>>>>>>>>>>>>>>>>>>>> ino=3D1311670, invalid inode
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation:
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> ha=
s 18446744073709551492
>>>>>>>>>>>>>>>>>>>>>> expect [0,
>>>>>>>>>>>>>>>>>>>>>> 6875827]
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> [1=
92088.468457] BTRFS error
>>>>>>>>>>>>>>>>>>>>>> (device
>>>>>>>>>>>>>>>>>>>>>> sdh):
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block=3D2035109=
40835840 read
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> ti=
me tree block corruption
>>>>>>>>>>>>>>>>>>>>>> detected
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> bt=
rfs device stats, however,
>>>>>>>>>>>>>>>>>>>>>> doesn't
>>>>>>>>>>>>>>>>>>>>>> show any errors.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> Is=
 there anything I should do
>>>>>>>>>>>>>>>>>>>>>> about
>>>>>>>>>>>>>>>>>>>>>> this, or should I
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 just continue
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> us=
ing my array as normal?
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> Thi=
s is caused by older kernel
>>>>>>>>>>>>>>>>>>>>>> underflow inode generation.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> Lat=
est btrfs-progs can fix it,
>>>>>>>>>>>>>>>>>>>>>> using
>>>>>>>>>>>>>>>>>>>>>> btrfs check --repair.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> Or =
you can go safer, by manually
>>>>>>>>>>>>>>>>>>>>>> locating the inode
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 using its inode
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> num=
ber (1311670), and copy it
>>>>>>>>>>>>>>>>>>>>>> to some
>>>>>>>>>>>>>>>>>>>>>> new location using
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 previous
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> wor=
king kernel, then delete the
>>>>>>>>>>>>>>>>>>>>>> old
>>>>>>>>>>>>>>>>>>>>>> file, copy the new
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 one back to fix=
 it.
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> Tha=
nks,
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>> Qu
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>> Th=
ank you!
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>>>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > >>
>>>>>>>>>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>>>>>>>>>>
>=20

