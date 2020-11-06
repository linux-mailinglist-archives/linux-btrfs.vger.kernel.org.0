Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E2C2A9466
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 11:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgKFKci (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 05:32:38 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:35196 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbgKFKch (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 05:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604658753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=l/wM8/jX9oKYSyhJmEtLQ66f3EstjoHIOdaMDhS99ZM=;
        b=LrP8iitRcGk1ll27YQ6qy55KX/cPiYphk0Ksr3zXaKBbuf61qH3c4siq1JN3BEXhYBurqL
        TMrkkf4voi9I6E5sYHRUgY61fKAI7l7tm6xZ+A6MhQszLHyyjDya+q1w5QgUpxe0iZzbp+
        HEoZSL1SRScdxgeO2AgvtqDkflYsBU8=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2058.outbound.protection.outlook.com [104.47.5.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-fn2QEO2lMEec_-kL1v9_wA-1; Fri, 06 Nov 2020 11:32:32 +0100
X-MC-Unique: fn2QEO2lMEec_-kL1v9_wA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGR2gn0a3/X55pwFy5HbVP/Tjwhcx+AzXi6yvl/jrVDaLVZ1sLi2219/c0atdQYyFOvLu2hmO58r40deJIARrh++KW76RPjUQhIvCeWCzF4Xjh3kdL2NojBb9k7H8r1ywccEQjihROSbMeajPM615/XsBKOpW2Dzaj1RqYS32hmut5YIuLbe9jiMOFEpc7hEU6JGXRehixskchZC1mUZZUVp/82xA1jIjlJbpVdBoo6Jg77ItSr45peXDgiFxRCPyIlyN4JvJN2jmiiJ6CqsdSjDCfa5549ZbslWRCAYToejSMEhAn8N+vXT9qrUqqx5XWZj7f2F+5CnNBCWqiXb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDLSQ1pFROfAweDU3f03zZEKiXxHlzzOjkCxF6mT9EA=;
 b=aLJHNfJTvG4xtWmAv9MLuklOCI8ijKGxddS77bwSNBcy6Jm/Xpr1OJret+lopj12kxXsHGCmIe+zK12ewOCp/xUubnV42atteGytZcO7dKgDYfLdXuY/CW5P+CudVmTqhNPTlE94Lz03iObGuFXlqVbh7ZkMaN/ofP+NqgdCC9WWaSLuBUTvhL54uWAe9NiYYFOYofs4DHufAgPjAM5vsf6iFuQkHXE448qQb5KyyHOiY4Zjr+TAPMHGf6ye9l8SBXdNQumZJ8KjXemk5LodIyP5ueJDsW9Q1gsY+doXDBUXNenh9d9P/+eXRRv7NwE8jfudPpE2gbBmu4e2jDhFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7212.eurprd04.prod.outlook.com (2603:10a6:102:80::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 10:32:31 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.022; Fri, 6 Nov 2020
 10:32:31 +0000
Subject: Re: Fwd: Read time tree block corruption detected
To:     Ferry Toth <fntoth@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Tyler Richmond <t.d.richmond@gmail.com>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
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
 <50e0ef4d-061e-d02d-9dbf-61f83dfa7b3e@suse.com>
 <117797ff-c28b-c755-da17-fb7ce3169f0f@gmail.com>
 <51578ec7-f2e5-a09a-520e-f0577300d5ce@gmx.com>
 <ca811ad9-5ae4-602e-98a4-5d4d6c860a1c@gmail.com>
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
Message-ID: <0acac733-233c-0c71-b9bc-c4bee1c724ba@suse.com>
Date:   Fri, 6 Nov 2020 18:32:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <ca811ad9-5ae4-602e-98a4-5d4d6c860a1c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::31) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:e0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Fri, 6 Nov 2020 10:32:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee9cfbc7-8781-4e43-ee2b-08d8823f4419
X-MS-TrafficTypeDiagnostic: PR3PR04MB7212:
X-Microsoft-Antispam-PRVS: <PR3PR04MB72123881CFD6744343825F14D6ED0@PR3PR04MB7212.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wb5N2Ynl8SEf3GdtJCa3Fen1Q9Mccd5UzzpDFyfzPRVRkYvl+E/GeIe3HDjEVsp99Ti5Bp+pIhpKFdQrQHuDP7O5lX13fvmxir72YxQO3cCwuu8PeYabe0RtFrgjTX1jbwxkPzlmpWfzIavpUwJP5Dq2WEjH4fuD/li2LxHyOF3jPE2gadqoiNQ3PDLb3oy5EgYixhOuTTiZNNVD6Te3fjVODYZNov3ACV/AWLuer5pdBRIKgV0NphaNqnFyc/HDGfAPc68gFCXGGCBetqbEmTi7pLGGje706dvwN7Nr0cHe5vylfu4DgRulF4HmVIt529Sp2nGXBvLRSjF8fOJX8nkXqXNkWomj3sJu+0n9ZedtLpAqqNLHbOU0XaLLK5o23rqo10NV8JFxdFsE8J1WQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(396003)(366004)(136003)(31696002)(110136005)(2906002)(2616005)(16576012)(26005)(956004)(52116002)(316002)(478600001)(186003)(36756003)(86362001)(4326008)(83380400001)(16526019)(6666004)(66556008)(66946007)(5660300002)(31686004)(66476007)(6486002)(8936002)(6706004)(8676002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UPYWiZpyqIvkoVIvRa415sJydJGH1zLkcov0i5DfqKslrmuciUW7vNWP04Hj9TX42vdqls5Oh4JdP2ryTjnZ8xs0TD+E40haXwoDYGxg6yun401O/AoiTI2c89ygFYmgoOEdiUC1JAPotfHeQsavIRxmbbPY1wy/zsEUApt5ulnnY7QqUtJCSDGHn587lRfQcoUWwTUqedr4Qsxa0TAsWicfN62ffSthcAXpE7macuHClv96IhOlJkGb0Nt6euzvce5q0UOjxdynoeBcdqLqCEj75nBd1bFIN0UqahEZKF3RL/Qg+anhHfE6cqYNeBHTxL5PDEgU5Yvx0hshC73EReeMX0hVWKMK+rXPhNCgAB3ZjZ3SJTInv59ejvZooiY4tiY+JMBCb0iaQzGL5eT9yptnDKLCCUAYV9cS+uH9ZJAJzLt56xqY4mrdp/Kfh9pPPcakjECuidcl41VVduYxEPjVamqPPaFyxdXSn+VPIRi2gZTj6NF8CH57Sb3Aek02ZKgLo+U/99TIdVZThVuRhU/zsOkI5/hW1nFBZaMnndggGPywrf03R2uMK6DY9vQ1gvdg8xP/mwzqWpu4d5rVGdqv1aVYxioukGdtoFiWaZ8+METvveEuOFnZyMnfNSg/6jO2GQ56jpKCFp7THh38fA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9cfbc7-8781-4e43-ee2b-08d8823f4419
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 10:32:31.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSBgrEOiWj7+GNT41zETdZMzzNIyMQdelGxPqjwTM2SNaicYf8WCmciQj4BqOT8o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7212
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/6 =E4=B8=8B=E5=8D=886:30, Ferry Toth wrote:
> Hi
>=20
> Op 06-11-2020 om 11:24 schreef Qu Wenruo:
>>
>> On 2020/11/6 =E4=B8=8B=E5=8D=886:09, Ferry Toth wrote:
>>> Hi Qu
>>>
>>> Op 06-11-2020 om 00:40 schreef Qu Wenruo:
>>>> On 2020/11/6 =E4=B8=8A=E5=8D=887:37, Ferry Toth wrote:
>>>>> Hi
>>>>>
>>>>> Op 06-11-2020 om 00:32 schreef Qu Wenruo:
>>>>>> On 2020/11/6 =E4=B8=8A=E5=8D=887:12, Ferry Toth wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Op 06-11-2020 om 00:00 schreef Qu Wenruo:
>>>>>>>> On 2020/11/6 =E4=B8=8A=E5=8D=884:08, Ferry Toth wrote:
>>>>>>>>> I am in a similar spot, during updating my distro (Kubuntu), I am
>>>>>>>>> unable
>>>>>>>>> to update a certain package. I know which file it is:
>>>>>>>>>
>>>>>>>>> ~$ ls -l /usr/share/doc/libatk1.0-data
>>>>>>>>> ls: kan geen toegang krijgen tot '/usr/share/doc/libatk1.0-data':
>>>>>>>>> Invoer-/uitvoerfout
>>>>>>>>>
>>>>>>>>> This creates the following in journal:
>>>>>>>>>
>>>>>>>>> kernel: BTRFS critical (device sda2): corrupt leaf: root=3D294
>>>>>>>>> block=3D1169152675840 slot=3D1 ino=3D915987, invalid inode
>>>>>>>>> generation: has
>>>>>>>>> 18446744073709551492 expect [0, 5851353]
>>>>>>>>> kernel: BTRFS error (device sda2): block=3D1169152675840 read tim=
e
>>>>>>>>> tree
>>>>>>>>> block corruption detected
>>>>>>>>>
>>>>>>>>> Now, the problem: this file is on my rootfs, which is mounted. ap=
t
>>>>>>>>> (distribution updated) installed all packages but can't continue
>>>>>>>>> configuring, because libatk is a dependancy. I can't delete the
>>>>>>>>> file
>>>>>>>>> because of the I/O error. And btrfs check complains (I tried
>>>>>>>>> running RO)
>>>>>>>>> because the file system is mounted.
>>>>>>>>>
>>>>>>>>> But, on the sunny side, the file system is not RO.
>>>>>>>>>
>>>>>>>>> Is there any way to forcefully remove the file? Or do you have a
>>>>>>>>> recommendation how to proceed?
>>>>>>>> Newer kernel will reject to even read the item, thus will not be
>>>>>>>> able to
>>>>>>>> remove it.
>>>>>>> That's already the case. (input / output error)
>>>>>>>> I guess you have to use some distro ISO to fix the fs.
>>>>>>> And then? btrfs check --repair the disk offline?
>>>>>> Yep.
>>>>>>
>>>>>> You would want the latest btrfs-progs though.
>>>>> Groovy has 5.7. Would that be good enough? Otherwise will be difficul=
t
>>>>> to build on/for live usb image.
>>>> For your particular case, the fix are already in btrfs-progs v5.4.
>>>>
>>>> Although newer is always better, just in case you have extent item
>>>> generation corruption, you may want v5.4.1.
>>>>
>>>> So your v5.7 should be good enough.
>>>>
>>>> Thanks,
>>>> Qu
>>> I made a live usb and performed:
>>>
>>> btrfs check --repair /dev/sda2
>>>
>>> It found errors and fixed them. However, it did not fix the corrupt
>>> leaf. The file is actually a directory:
>>>
>>> ~$ stat /usr/share/doc/libatk1.0-data
>>> stat: cannot statx '/usr/share/doc/libatk1.0-data': Invoer-/uitvoerfout
>>>
>>> in journal:
>>>
>>> BTRFS critical (device sda2): corrupt leaf: root=3D294 block=3D11691526=
75840
>>> slot=3D1 ino=3D915987, invalid inode generation: has 184467440737095514=
92
>>> expect [0, 5852829]
>>> BTRFS error (device sda2): block=3D1169152675840 read time tree block
>>> corruption detected
>>>
>>> So how do I repair this? Am I doing something wrong?
>> Please provide the following dump:
>> btrfs ins dump-tree -b 1169152675840 /dev/sda2
>>
>> Feel free to remove the filenames in the dump.
> sudo btrfs ins dump-tree -b 1169152675840 /dev/sda2
> btrfs-progs v5.3-rc1
> leaf 1169152675840 items 36 free space 966 generation 5431733 owner 294
> leaf 1169152675840 flags 0x1(WRITTEN) backref revision 1
> fs uuid 27155120-9ef8-47fb-b248-eaac2b7c8375
> chunk uuid 5704f1ba-08fd-4f6b-9117-0e080b4e9ef0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 0 key (915986 DIR_INDEX 2=
) itemoff 3957 itemsize 38
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (915987 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 7782235549259005952 data_len 0 name_len 8
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: smb.conf
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 1 key (915987 INODE_ITEM =
0) itemoff 3797 itemsize 160
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 1 transid 18446744073709551492 size 12464
> nbytes 16384
Yeah, corrupted transid.

The v5.6 kernel doesn't get the fix backported...

Now you have to use either the out-of-tree branch, or David's devel
branch to build a btrfs-progs which is able to repair the transid error.

Thanks,
Qu

