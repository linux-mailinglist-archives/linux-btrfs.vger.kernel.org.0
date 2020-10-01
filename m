Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A49B280B61
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 01:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbgJAXjH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 19:39:07 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:22307 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733002AbgJAXjH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 19:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1601595543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ON0qukXJt77O+2tUXxanrmvCpCuIBJSQ+u0OEKyhhT4=;
        b=f/+nI/w7J/nePStHwxKXBBFQEisT4VoY0UOd8M6yujEWl8PuPpvr0mJ6WDpBq0p7c61BD3
        /APvQGlzP7d8DI3zokI0nEIYR6fIVUQgFKM12AISyeDDS6TIJ/t1G8Ql+N5LtE7h9Nu2+j
        viRk0fUwDur1NqwoQWS9IK6mOKn9ihQ=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2058.outbound.protection.outlook.com [104.47.8.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-ohaOIWPoMWe0s-lIv46MQw-1; Fri, 02 Oct 2020 01:39:02 +0200
X-MC-Unique: ohaOIWPoMWe0s-lIv46MQw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSVtCZA4Mr3eDYpUsLKSmZ9/MWFOmYdqJYFaqc+tbgTVsi6kLbs78vKHQyblV2Z2oFECtp1J9FtQNMNvbM78JZKWp9u42CvAhHDw23HC4h8DyaKr6Qpp9JjMX06qteVSzhSmoZvLE1TqY8GTFxvl7yQqZStdb67MmLszDMVTewgxstUHl1/JFPqexlX9G99Yw9nfdajD1qU/gOlkpfL2VnlJheOkMRyWfjhbGnR9f+9XKi+/kb856LNmgk2B6MONTfhXjlt+yCRMGGPz2vL4MXBLUYjJaDg0Y+Y0wA9TQKCztiwCOmzAYU9TLUSHHH+dZBTxJp0VUNRTQMBNa1cBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkdzbt2dpcEccanDyBQEs3WgS60SYgGVcBNLscWFAOg=;
 b=OKgo/tPY7gpI9diU2Wsj/MOHhxjM15rukqj+CrGOPLwIbInYKK+jzXU3C/4q0st5wvE0p+QBB0E/32SgyBsTEvW705tK95U+XLhDKJynWdgLeL0htZJ0q1y83siowULX0PGcZR1b3isCwx+tgRF7dgYFElwXG0KXWRyc4EFvhNX366S93tOmFhafkvPiMHJXcUok7Qv7A7MIzh7hqrnucfW3qBf+0WmI9xMgvWN36Zwi2/fb2vkfWmnjCcQaHpS8i9RwEeXkrKh4VXTK1geUzKMoJ4TaYkIE6tnjp0KtphPgNj5k6StvROfMfF7oDKtfc/HDmxQj9hY1Q53VqqTXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB5715.eurprd04.prod.outlook.com (2603:10a6:208:124::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Thu, 1 Oct
 2020 23:39:01 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3433.036; Thu, 1 Oct 2020
 23:39:01 +0000
Subject: Re: simple Chunk allocator like calculation to replace Factor based
 calculation
To:     Wang Yugui <wangyugui@e16-tech.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20201001212617.82BC.409509F4@e16-tech.com>
 <20201001233649.888B.409509F4@e16-tech.com>
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
Message-ID: <7b8600fa-e04e-2b87-3ddb-ba16d4f2824f@suse.com>
Date:   Fri, 2 Oct 2020 07:38:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201001233649.888B.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:180::27) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR13CA0014.namprd13.prod.outlook.com (2603:10b6:a03:180::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.15 via Frontend Transport; Thu, 1 Oct 2020 23:39:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce9b37ae-3808-4d71-fdab-08d866632cc2
X-MS-TrafficTypeDiagnostic: AM0PR04MB5715:
X-Microsoft-Antispam-PRVS: <AM0PR04MB5715F3C52D77E6AC9D4D6653D6300@AM0PR04MB5715.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnB+fYhCWzLEFZk+9pZEFuTFiFgIBFuhseAXkdjht3V+JeZVbMSBf2V9pVLh8TmhdhLiiYjMinGsH5MS1/XX0pNTYHlnIYvIy4DR0hiBFhhD4cnl3OUpLqvJW1lbkJ/Z6uSWUWOuFx0S4+8sB++gdnHJJMxxSpPASGu0mYEfwFkZupKEKfjsxUo/bh/hsI5tOt9JXaCzt6IOyhceMhB0Tm4BjZxrBYFsWLYiWmBMlqmK5vZI7jXUbvcsZs88wLmZOCt1o9bwVU0qMMKQK9+3Z8PO3W1rBO7of5ciabyw01/KcxLE+4huSuUXIVfpyvlGIj1Zgn5pW1LtAaHjSrmgoREkZCzFAciSM0BFBjYeu0RuzGsy5SSjIFFU6z7X0UThiQ8/X9E8M46vnn7GAIQpGSvbePdTpMooGYvikxsuoS71EViEzSejEUBRNJ3zRaIEU+XhzsAoU1oRwz4/oa/DLO/0bIzTfTUCcCchQpO4JgdNWl00MxNqC1gyrM5DqUZlEuyZ7Yyw1XKR4XxuSacbMVAHgsuXEDFkxYm/SDvqpUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39860400002)(346002)(376002)(5660300002)(52116002)(83380400001)(16576012)(6666004)(86362001)(66476007)(316002)(66946007)(66556008)(31696002)(110136005)(36756003)(2906002)(26005)(956004)(966005)(2616005)(31686004)(186003)(478600001)(6486002)(8936002)(8676002)(6706004)(16526019)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nX0T/7qSe6uPvF1meb850zMWx9lx7m4v+Z/KfnrXAEgAGs6jG30WcGfhKO3YbmqfgB9qLX80EpQislrO6a9PPpk+jL4xC7Ey8ksAerRaxCiE0VRaNiANbAxJpYitrO+CtxDT7itJeDnWWd+56tJiKjWvgJ2dYRn+tRB75mg07lw1zrQeB4ADh39jdekqRDC9OYf/CL+0gUl6g7l2XUkv5GCcVyfW+279WmdcZ0Zk0mr/zzwMWFOwCdwH3ulVPX8bv0p9+ekWR4ipBV3mt5rbL0KsTIBH4IcDffVluKzxR4cOd28wzmiWjRfXtvkG/cZYh0sX+Wy5tqkOHHafP3wHA1rOyut5LXA9o1154kJ+zdAYgx+mRDKqDUkocRTko4gDUJA9xYeDQ/sXOWofj2Sek39Ce2Q0QKXjiyIE6A9PaVwdbyGtlrVHI/nq+zsRklFch+E0vQqZcFmFtve/P90WeEL37lTZvu9S15SpdPg/sK9zwAFApNkgFmxW4I511thSyuqk/PGAw0wRmTi5y5tWUuRx7tVlE/9nfifNw6AvXr5Jn8ceqsFVKrBuSkW2f/NhoQU0MRp2kov9Flw5XymGnkJF/ksST4deJc2UKBpirm0y3m/VLbf7n/Z7FELT0YuaR14g8+TjxRRRfFCiU4OjdQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9b37ae-3808-4d71-fdab-08d866632cc2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 23:39:01.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/oITr5ujepNeIfjYb/2dtMLHsg1N3Hg0fY5Kr/tOt1azpo01+2MYozpZd1IP9BK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5715
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/10/1 =E4=B8=8B=E5=8D=8811:36, Wang Yugui wrote:
> Hi, Qu Wenruo
>=20
> Chunk allocator like calculation will get the right value, but it is
> slow for big file system such as 500T.

Nope, the ballon allocator doesn't have any size limit, thus it will try
to use as much space as possible in a single run.

If the 500T fs only has say 100T used, and the remaining 400T is split
into, say 2 parts, then just two small run would finish.

On the other hand, if the 500T is mostly used, only 100T unallocated and
the 100T is in a big unallocate chunk (under most cases it's true), then
just one allocation run is enough.

So in short, it's unrelated to the fs, but how fragmented the
unallocated space is.
And normally unallocated space is not fragmented at all, thus it's very
speedy.

>=20
> we can call this 'Simple Chunk allocator' as 'free_space_by_min_profile',
> it is good enough to prevent over commit, and fast enough too.
>=20
> N =3D .devs_min + .nparity
>=20
> (N-th big free space) * (.devs_min) / (.devs_min + .nparity)  / .ncopies.

Nope. Check the basic unbalance case of 10T + 1T raid1, and cases like 6
disk RAID10 with 10T, 10T, 5T, 5T, 1T, 1T.

Last but not the least, please send such feedback to the mail list.
Open-source doesn't only mean source open, but also open discussion.

Without an open environment to discuss, it will be lame open-source
practice just like almost all Chinese companies do, publish a tarball
and call it a day. That's not open at all.

Thanks,
Qu

>=20
> Best Regards
> =E7=8E=8B=E7=8E=89=E8=B4=B5
> 2020/10/01
>=20
>> Hi, Qu Wenruo
>>
>> https://patchwork.kernel.org/patch/11810913/
>> is a good job.
>>
>> We have two types of estimation:
>> - Factor based calculation
>> - Chunk allocator like calculation
>>
>> In factor, we can have a simple Chunk allocator like calculation to
>> replace Factor based calculation to prevent overcommit.
>>
>> -Simple Chunk allocator like calculation
>> we just use the top devs_min devices to get the free space.
>> we use this value to prevent overcommit.
>>
>> this Simple Chunk allocator like calculation is always <=3D Chunk alloca=
tor like calculation.
>>
>> for  this example:
>>   devid 1 unallocated:	1T
>>   devid 2 unallocated:  1T
>>   devid 3 unallocated:	10T
>>   devid 4 unallocated:	5T
>>
>> RAID1 of Simple Chunk allocator like calculation :	5T(top 2 device)
>> RAID5 of Simple Chunk allocator like calculation :	2T(top 3 device)
>>
>> Simple Chunk allocator like calculation is fast for big file system just=
 like
>> Factor based calculation.
>>
>> Best Regards
>> =E7=8E=8B=E7=8E=89=E8=B4=B5
>> 2020/10/01
>>
>> --------------------------------------
>> =E5=8C=97=E4=BA=AC=E4=BA=AC=E5=9E=93=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=
=E5=85=AC=E5=8F=B8
>> =E7=8E=8B=E7=8E=89=E8=B4=B5	wangyugui@e16-tech.com
>> =E7=94=B5=E8=AF=9D=EF=BC=9A+86-136-71123776
>=20
> --------------------------------------
> =E5=8C=97=E4=BA=AC=E4=BA=AC=E5=9E=93=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=
=E5=85=AC=E5=8F=B8
> =E7=8E=8B=E7=8E=89=E8=B4=B5	wangyugui@e16-tech.com
> =E7=94=B5=E8=AF=9D=EF=BC=9A+86-136-71123776
>=20

