Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBEA2AA554
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Nov 2020 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgKGN22 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Nov 2020 08:28:28 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:59583 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgKGN22 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Nov 2020 08:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604755703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=uxDvwopyLQLTu5FXmUAcZV7T/qb8L1J+VwUFS0T3r9U=;
        b=h1O9FUSDM8OqLXCfhx6jv/V1NuuLabHONJ/YA/ujjbc1DCsAwv/TapCIHaUyCPoUpRRkll
        0swm8VGDbsJrNMukwjqWo8OuPd+GTYhcDLR6GryY23Plf7tf4BvlgXmt4wBB7r3XDDpJ6z
        fsyPj/LCa6XnQhwRsHdwoLiq2yVf8yg=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-4-gddWB7wTNNKcrv15WuM1gQ-1; Sat, 07 Nov 2020 14:28:22 +0100
X-MC-Unique: gddWB7wTNNKcrv15WuM1gQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OksbFyIg5FTcQCCRpx2PLHjpqFGAEbWiMNrAQwRQarsCCxckLYU1bhOouNEGo//J/jOqA515d+OzCRXsZ2IWVh8XIxVcpLwuymyedDOTRsAMP8XZX2eUFKyb/ExWyKo2yRGLMzZ5+HWhf9EFPjaOtPt+5WZO8VLZmc3oouNmZamMQ/lNcZyZcI7wsX4fMQLGvPboDKWAzepakudPIEVQcXpsThjYNZqcU36tcyqnrWTh7AeycDCm76oFSnn19De/M9BWemXrHiybqBZMu8TARP8gtpW8kcX5iCLYThKVLCor/Ogb2iS1zl8Zmy5VIWHmqgigQ/0vj2l4u0uCEtRRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtHHkbEdLBVNwkmTdeaeCbIR7NGrKpi35eMzOmVlMF8=;
 b=DH8i0H+6FbObeVN/0nAwsCtf1x78bM3r1IKMLW73ldo4eC8M4GEHinG4JxgdfP/PQMx1w6723hNIr+fewqe7ls9A1+FvZ8wcqdasCCYNbZDZ7O6CCQm4VUN9L2F8MRegFQDX7Dz+463yJ8jycePH8zifpp0wTm/9L9XPB1GraRocBj6K/pWXolAGBGmMdiE0i6iKToweBhdSh1nxvMV3wy/zf+cndeKKW8gAMsTLKpKufETQM7Gq0nbBPfR1m1oytT+NxJdkUZ5KsuPgwaTPAvNn/ug5uKGdDpPDKGdYGy7NHgEdlykkKprIMDAqq0agk+xD3u56I+ict7mnDbIYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7435.eurprd04.prod.outlook.com (2603:10a6:102:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sat, 7 Nov
 2020 13:28:21 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.022; Sat, 7 Nov 2020
 13:28:21 +0000
Subject: Re: Fwd: Read time tree block corruption detected
To:     Ferry Toth <fntoth@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Tyler Richmond <t.d.richmond@gmail.com>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
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
 <0acac733-233c-0c71-b9bc-c4bee1c724ba@suse.com>
 <4dd24fde-6d7f-202f-5d2f-b4478d797a93@gmail.com>
 <fcd272a5-a437-e918-8102-3813a608574c@gmx.com>
 <a26dc3fa-f68a-31fd-dbf8-692892df6019@gmail.com>
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
Message-ID: <d57d7430-c0c5-315e-9d74-08d4b38696aa@suse.com>
Date:   Sat, 7 Nov 2020 21:28:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <a26dc3fa-f68a-31fd-dbf8-692892df6019@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:a03:114::20) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR21CA0010.namprd21.prod.outlook.com (2603:10b6:a03:114::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6 via Frontend Transport; Sat, 7 Nov 2020 13:28:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06ae005f-0cee-4f54-0479-08d88320fee1
X-MS-TrafficTypeDiagnostic: PR3PR04MB7435:
X-Microsoft-Antispam-PRVS: <PR3PR04MB7435C56B282CE6D46ADB5F3AD6EC0@PR3PR04MB7435.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDtwOvjCg+aVevFmzQi/leoSgcr5eJsYG0vOO58EkvvmT97iZ64soxjoxCqDnKaAuPiYxMCYghhEKWKT4E+triBpSnFYNQ/VY6XfZdQVvbmN68oQz28bGqAOEGntNC6PZIwh8gw3lB+3dbXGIVtJCGnVNyvHL4P0vu1CYgLgN8FMA66bDvYaRTc1DSD75cfh01FspDtX2ilccfH/MKlp7cnv7hKKNZn68VIpo8ddqLAtIBD7RxBIMdZwV911wrtPHSvLYLiiMu9b3dAMX0xGyoPa08Ke3mD1Pt3YZH093fUhSFzjF3fjXkwKe9R8qWM7mr4jNBn6Nz9xmaoHhKXjTGspKjooDoS73abvYc9lPGU9hiSIr/c86as9xZ7zPXV+xjiEKtJfxlkd8mNfU4P3fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(6706004)(52116002)(110136005)(66476007)(16576012)(2906002)(2616005)(316002)(956004)(66946007)(66556008)(6666004)(86362001)(478600001)(4326008)(8676002)(31686004)(6486002)(31696002)(186003)(16526019)(8936002)(26005)(36756003)(83380400001)(5660300002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RrS8y6bxyBLJKa50vckjgVEVbZ16HMsLADxOQzy8/TOCrZIj/29JTiOQ/5C0u4GKrQpp0S9BuvlFva4b5KXG3OeO/jAGEVFhK9VQv0bjL14cRZUNegkPqQD9f+1TKpjfX84rGYzkCuhq6Ow6Kckfzevwtlvb3MebH7jSt1SDOvXLuTUAdBR81VWAlv8L0UZxbxdW9CR24e96BiMaU8EIKxuxrmgWyryPuSDhAdUOa1tK4Ive3xUppnS61XtPFDTHSqOLPBuTnH9v2s/PFN3kUpkaUjPFNSbZuQKOKyDZC2zScTFKuU1iwg146T7Ay0CztrwLCr3lCF6zSrzZtyz/DjD4A5syBZoJbIvtXgGXlc8voZb9REujeM7pph2RqEmzBNkLwVv/j0alSu2Y8F4c4abUgj96+/bvhz4Kp42+3V37MgiNB1V62u3psobjdhWNhgeaPwr5RQ73z0mJ1X7Lb2Lo6HWx0Hj5xImsEAEtQ/6jp22+dksQ6B3JaxWoUqTLppjEZ2VkzfF4EWDCt5lEGNhYOMUGy3ghmT4Osi8sIJIXWpvzTsF/PMlXJBqrWzT93HBEUk6oqFlBnxiUL/kSqimmpdp6rIfiStwNcRZQ7RB/z9OlQEx4arHpsV1zXedUXNrQfpkXTGCs8BjJD8l/Ow==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ae005f-0cee-4f54-0479-08d88320fee1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2020 13:28:21.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyvUXIpaFeXetc55sun+6+Mmad1cKuCUdsVtfb7HuTgnKUh+epBuPuzG6iGvxuL5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7435
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/7 =E4=B8=8B=E5=8D=889:19, Ferry Toth wrote:
> Hi
>=20
> Op 07-11-2020 om 12:35 schreef Qu Wenruo:
>>
>> On 2020/11/7 =E4=B8=8B=E5=8D=887:18, Ferry Toth wrote:
>>> Op 06-11-2020 om 11:32 schreef Qu Wenruo:
>>>>
>>>> On 2020/11/6 =E4=B8=8B=E5=8D=886:30, Ferry Toth wrote:
>>>>> Hi
>>>>>
>>>>> Op 06-11-2020 om 11:24 schreef Qu Wenruo:
>>>>>> On 2020/11/6 =E4=B8=8B=E5=8D=886:09, Ferry Toth wrote:
>>>>>>> Hi Qu
>>>>>>>
>>>>>>> Op 06-11-2020 om 00:40 schreef Qu Wenruo:
>>>>>>>> On 2020/11/6 =E4=B8=8A=E5=8D=887:37, Ferry Toth wrote:
>>>>>>>>> Hi
>>>>>>>>>
>>>>>>>>> Op 06-11-2020 om 00:32 schreef Qu Wenruo:
>>>>>>>>>> On 2020/11/6 =E4=B8=8A=E5=8D=887:12, Ferry Toth wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> Op 06-11-2020 om 00:00 schreef Qu Wenruo:
>>>>>>>>>>>> On 2020/11/6 =E4=B8=8A=E5=8D=884:08, Ferry Toth wrote:
>>>>>>>>>>>>> I am in a similar spot, during updating my distro (Kubuntu),
>>>>>>>>>>>>> I am
>>>>>>>>>>>>> unable
>>>>>>>>>>>>> to update a certain package. I know which file it is:
>>>>>>>>>>>>>
>>>>>>>>>>>>> ~$ ls -l /usr/share/doc/libatk1.0-data
>>>>>>>>>>>>> ls: kan geen toegang krijgen tot
>>>>>>>>>>>>> '/usr/share/doc/libatk1.0-data':
>>>>>>>>>>>>> Invoer-/uitvoerfout
>>>>>>>>>>>>>
>>>>>>>>>>>>> This creates the following in journal:
>>>>>>>>>>>>>
>>>>>>>>>>>>> kernel: BTRFS critical (device sda2): corrupt leaf: root=3D29=
4
>>>>>>>>>>>>> block=3D1169152675840 slot=3D1 ino=3D915987, invalid inode
>>>>>>>>>>>>> generation: has
>>>>>>>>>>>>> 18446744073709551492 expect [0, 5851353]
>>>>>>>>>>>>> kernel: BTRFS error (device sda2): block=3D1169152675840 read
>>>>>>>>>>>>> time
>>>>>>>>>>>>> tree
>>>>>>>>>>>>> block corruption detected
>>>>>>>>>>>>>
>>>>>>>>>>>>> Now, the problem: this file is on my rootfs, which is
>>>>>>>>>>>>> mounted. apt
>>>>>>>>>>>>> (distribution updated) installed all packages but can't
>>>>>>>>>>>>> continue
>>>>>>>>>>>>> configuring, because libatk is a dependancy. I can't delete
>>>>>>>>>>>>> the
>>>>>>>>>>>>> file
>>>>>>>>>>>>> because of the I/O error. And btrfs check complains (I tried
>>>>>>>>>>>>> running RO)
>>>>>>>>>>>>> because the file system is mounted.
>>>>>>>>>>>>>
>>>>>>>>>>>>> But, on the sunny side, the file system is not RO.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Is there any way to forcefully remove the file? Or do you
>>>>>>>>>>>>> have a
>>>>>>>>>>>>> recommendation how to proceed?
>>>>>>>>>>>> Newer kernel will reject to even read the item, thus will
>>>>>>>>>>>> not be
>>>>>>>>>>>> able to
>>>>>>>>>>>> remove it.
>>>>>>>>>>> That's already the case. (input / output error)
>>>>>>>>>>>> I guess you have to use some distro ISO to fix the fs.
>>>>>>>>>>> And then? btrfs check --repair the disk offline?
>>>>>>>>>> Yep.
>>>>>>>>>>
>>>>>>>>>> You would want the latest btrfs-progs though.
>>>>>>>>> Groovy has 5.7. Would that be good enough? Otherwise will be
>>>>>>>>> difficult
>>>>>>>>> to build on/for live usb image.
>>>>>>>> For your particular case, the fix are already in btrfs-progs v5.4.
>>>>>>>>
>>>>>>>> Although newer is always better, just in case you have extent item
>>>>>>>> generation corruption, you may want v5.4.1.
>>>>>>>>
>>>>>>>> So your v5.7 should be good enough.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>> I made a live usb and performed:
>>>>>>>
>>>>>>> btrfs check --repair /dev/sda2
>>>>>>>
>>>>>>> It found errors and fixed them. However, it did not fix the corrupt
>>>>>>> leaf. The file is actually a directory:
>>>>>>>
>>>>>>> ~$ stat /usr/share/doc/libatk1.0-data
>>>>>>> stat: cannot statx '/usr/share/doc/libatk1.0-data':
>>>>>>> Invoer-/uitvoerfout
>>>>>>>
>>>>>>> in journal:
>>>>>>>
>>>>>>> BTRFS critical (device sda2): corrupt leaf: root=3D294
>>>>>>> block=3D1169152675840
>>>>>>> slot=3D1 ino=3D915987, invalid inode generation: has
>>>>>>> 18446744073709551492
>>>>>>> expect [0, 5852829]
>>>>>>> BTRFS error (device sda2): block=3D1169152675840 read time tree blo=
ck
>>>>>>> corruption detected
>>>>>>>
>>>>>>> So how do I repair this? Am I doing something wrong?
>>>>>> Please provide the following dump:
>>>>>> btrfs ins dump-tree -b 1169152675840 /dev/sda2
>>>>>>
>>>>>> Feel free to remove the filenames in the dump.
>>>>> sudo btrfs ins dump-tree -b 1169152675840 /dev/sda2
>>>>> btrfs-progs v5.3-rc1
>>>>> leaf 1169152675840 items 36 free space 966 generation 5431733 owner
>>>>> 294
>>>>> leaf 1169152675840 flags 0x1(WRITTEN) backref revision 1
>>>>> fs uuid 27155120-9ef8-47fb-b248-eaac2b7c8375
>>>>> chunk uuid 5704f1ba-08fd-4f6b-9117-0e080b4e9ef0
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 0 key (91=
5986 DIR_INDEX 2) itemoff 3957 itemsize 38
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 location key (915987 INODE_ITEM 0) type F=
ILE
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transid 7782235549259005952 data_len 0 na=
me_len 8
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: smb.conf
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 1 key (91=
5987 INODE_ITEM 0) itemoff 3797 itemsize 160
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 1 transid 18446744073709551492=
 size 12464
>>>>> nbytes 16384
>>>> Yeah, corrupted transid.
>>>>
>>>> The v5.6 kernel doesn't get the fix backported...
>>>>
>>>> Now you have to use either the out-of-tree branch, or David's devel
>>>> branch to build a btrfs-progs which is able to repair the transid
>>>> error.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>> Just be to be clear, I tried to repair with the Kubuntu Groovy Live usb=
,
>>> which has linux 5.8 and btrfs-progs 5.7.
>>>
>>> I didn't fix the above transid, above was taken after booting normally
>>> again (linux 5.8), unfortunately with btrfs-progs v5.3-rc1 (that I buil=
t
>>> a year ago). See the other post for the result with btrfs-progs 5.7.
>>>
>>>
>> As I said already, you need either the devel branch to do the fix.
>> Current release btrfs-progs hasn't the repair ability merged.
>>
> Ah, I understood wrong. I thought 5.7 was enough.
>=20
> So, I need to build the latest and greatest and install on live usb. Or
> I need to wait for a future live usb with this incorporated.
>=20
It's strongly recommended to build right now.

As you may already find, the btrfs-progs release cycle is normally
behind schedule, thus you may need to wait way longer than you thought...

BTW, after repairing, it's recommended to use newer enought (v5.8 should
be enough) kernel to mount the repaired fs, to verify the transid error
get fixed.

Thanks,
Qu

