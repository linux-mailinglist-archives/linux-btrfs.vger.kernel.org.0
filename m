Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343633E8CB1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 10:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhHKI67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 04:58:59 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:35117 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234568AbhHKI67 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 04:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628672315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIhQOMIrBsYaBBFBsdjjysChzorjjs4A6X3fpufyESg=;
        b=fbnLTzYpORM+lZB+YbjBpw1VVHLBYQZW/YsQdFmphkXrK68DK573ulbTR7OJtcvSPwzI4y
        MYhHIo3eG0d96RtICqCd2/AFtln0XE7MZ0EiBrFEu8w+YewvBgR+A6lNcuE2kVtgnmXOAM
        XZeXJgR4pnSaSoqNPi/Dn/pnI5uuJcg=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-bCrpJrMxMFWQfu2zaQZQ4Q-1; Wed, 11 Aug 2021 10:58:34 +0200
X-MC-Unique: bCrpJrMxMFWQfu2zaQZQ4Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esl7JEDuvPxgUR1/8CoDeEgAx1vywknmT9H7LS0rNpit/E2gJstDde1kknLmekx93bkdIC7MnykcC1mtmMafnjJ1qBgB8Bhbr7ieejyxnabI65Hlmf89FgfEVHPOzG07JTL2lkoAEMLHvnLZiJ6mmQyLUpKN3Ye6+nMaWk6FSXbMVBTIcZ0OHc4Z1bB3s8c5wqFISRLog4J6YrpUqI6z3T391xGmFqFBi5jrDbj2TJNXZFjiQAKrs6WapVe2Npstai9qweb61pMllcxxvAwRpulefMlnEUUsMKZjj/POWVXcfZXidjgHVUqo7nKj+pGf94iRMAqMFqFP14l7US/2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neU4YRPrUHh5BPOwUsTP0naAWSJTZIeONHn9/sYhKf4=;
 b=Kyg58LRuY11qTtGICd+L/awv+wDs5sdqvctxXjQsJekzPIrLiv5BPV95Ob03aDh8SXOY46R1YFzxR8pfU/XuxxQY6hGwPn/aL5kDnES+YRoAkqeW3GfQ4hTc3Lxnj3pfvTkRzdCif6hOoj6Sa72DeRiRppniEvoEWXoyZKT0+SLMvNnOI2ElV/OUnz8Es3ojx3TtPJpC/TRLrqodlxhvMvoefuRH88XhvdQr7vQUT1Y+pzUqaS4p1D9I9ISZFpWm5YWLv0uGqEQnRGDI9ZtEC8fkapofdxUPUyeeUO9AKjWqvxCQ/21ayZ3MF4wcP/0NfXXQbXi9e5lmXf3YlAyO9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Wed, 11 Aug
 2021 08:58:32 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::3510:ed3f:66d7:cf48]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::3510:ed3f:66d7:cf48%6]) with mapi id 15.20.4394.024; Wed, 11 Aug 2021
 08:58:32 +0000
Subject: Re: [PATCH] btrfs-progs: map-logical: handle corrupted fs better
To:     Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20210810235445.44567-1-wqu@suse.com>
 <a9c908a2-ada5-24ab-dc01-ebd686294000@suse.com>
 <40072166-1fa6-33f0-ebad-b47e4c08b633@gmx.com>
 <26765bca-a9de-af53-2d9e-d1131de4d801@suse.com>
 <1d598b9f-830b-282f-0445-d7c2a8ba3d9d@gmx.com>
 <b32a36a6-3ef6-012a-4a96-a30f435ddf19@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <5e8f840b-e8cb-31df-c2b1-b6b444242da3@suse.com>
Date:   Wed, 11 Aug 2021 16:58:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <b32a36a6-3ef6-012a-4a96-a30f435ddf19@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::24) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:33a::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Wed, 11 Aug 2021 08:58:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cd1d0c8-e52b-4cd0-e813-08d95ca631c6
X-MS-TrafficTypeDiagnostic: AS8PR04MB8371:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB8371A5B12A9488EE1275C49FD6F89@AS8PR04MB8371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRriz3YlSqWAb8opWwatebzqkKurPD7N/F416dkN0TBYP6jRQG1HrcNPK9gHQS2pB+Jpb+b2hu5xPS9Uk5ywfN6w/4QNpfLsJHfhOnO+eNZT/w8FjAFpz8cDpIaUb00RXwEMIcrip3P8fDiBv2SaoLe+IgvtdABJLxCj1+VWY2HsOTdJAz68VsV0dYHgHu9oXOI9w/5oIXC7rFTBlTYOPQTzL2z32rkvruTYdJhUqUnIGisMOxW/TJUhU85qIB/QYS91iUCPkDxXkOOCTB8VZ3Bdn/pl0xCkAf2LRqk+m0Fr0DDxTM4nMwBQwS30zkhHQnoLq2cIKwJ/ULyPyAiHzvJQJVQtskQf40iFmXCYSS0Si5Pkr/toogwPA/IiVmvwkrzu38fxzEo1PiPyehZvYejUpKU2zGSXDCDMZ0t3i/75wAi/rNV2Mlxi9Xw+UN9xAEXuH0cXWD4PpEtgazMr5KRbqxPdOaA5rAqP8tKazn7npoQwtyfIn9DeXUFInOahS1XdAclb2PU1jAvqHqiqQ8MhHwXC8B6iOtDqn3QKNmOM0+jDj2EbkL5ZssuMeW5T0ChjmHFCrYUQchJICUg4Pdt4OY+Ce59IsqOoIDVKald+WxWOocwvHgTRH/bfjJ+DlJvi3jMMPVAXb3W+KODSxymj8oUab4OiB+53TYCs5ttkMsfNPL9YmDe/PlWPfDEZJYy27i+3nq5UzoKcF2VsWk2HsDcH+ymCbC/PB9y/U1i2Wx5OIxBY9JzVzd8ElzEj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(376002)(136003)(346002)(31686004)(66556008)(66476007)(6666004)(110136005)(2616005)(26005)(86362001)(6486002)(36756003)(16576012)(316002)(956004)(478600001)(83380400001)(66946007)(6706004)(31696002)(5660300002)(38100700002)(186003)(8936002)(8676002)(2906002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3tGZ0UNEexiRyYXcXGEvv3MbYVgv/85hMt2brJaWSYNoOQ1bfKi7E6rmHj7b?=
 =?us-ascii?Q?7MH9U3l/pG1+0ik8QsHAa2ZHyMUf2INjNotumVGsgKFjEQSuLt3w3kt5XKcW?=
 =?us-ascii?Q?RKZk+vtk0HpxNSza72qa1cGUoNh6YPb39AHmZifGaF7aRhT9UHWjq5OYaacs?=
 =?us-ascii?Q?kIllgwRSkoxXSkhWidh2oDvZ+HuToXUbwjuCnMsSBCFpkwaR6epzSHYOVUyN?=
 =?us-ascii?Q?PL+u9q8uft+BKt9fUU2Y1YjjahdCArolGgKc8UDdXX2cqiODmrLdFaFDCVrp?=
 =?us-ascii?Q?lTunY2N5Qdv8RcbNG3gihZor7Q73g+odaBZ85oPJx+qvRC6a2M+grntN+zE2?=
 =?us-ascii?Q?wlJJ/T8djQLqh5KtJlF5qdejJppds6FramgSkXLN+tfvYadGvSo54StpDZPa?=
 =?us-ascii?Q?v+heAZB8UXytLRKeRsnl5VeUef1cmy23UbLKvYc5+XLteMqGrplO4C/mKGYd?=
 =?us-ascii?Q?OrbeQTjb7pAQJ02AGicrDCRq7gYf3+U6jnW2W1gJ1owAHNWOTQM7kmPp+dwa?=
 =?us-ascii?Q?hoSnvfPLrDcX27HOYzwU8Yrn3zhw5gLrRWDrH3vjMTEQok3mr0TfnqEWh5Ht?=
 =?us-ascii?Q?ZRyrBLlEW0rfLLcPhKd4aYWrc0IM8ZebvtAUkP88e4S+IikBkZA2N5nKEXHn?=
 =?us-ascii?Q?Upb0R2w9fssbwEqPuE/1LnblBXHMlwOAhPP8sIYudwI2OsoPZ7g2UZJ0nk+u?=
 =?us-ascii?Q?hWbjgyuNXFBLmRxhU/gygF/6iF+NS4n2cYbVwMe9DBHKIJRCGaMxlHS9zZij?=
 =?us-ascii?Q?Y1BHTaiT8bRgnGD7gRX2Q/TIJQMuZWkCsqhyPjU34A4BGQ6OiN5Tr/Wz0pwl?=
 =?us-ascii?Q?JRC1NqVZVhy8TM2x1oEo+yEQW3YA5m9Q6lV/dBsamBDo/Wz2m7uSeYLQ82zt?=
 =?us-ascii?Q?ms4ysEjuLS7SnnBZKCmJuJFkzI2GhxzhFvBi8xiLIlLJGoPKcSqFQLm5Mz1d?=
 =?us-ascii?Q?KmYyw9UrvJwVzv52lZ7wWXKWOC1wO8wwng0/Q3C/e0s+Qb8pPgYuYnUxck3L?=
 =?us-ascii?Q?JU7JCgjuIs1Bj+Qv+GLywsIefBDNroH6F9wF/qqWWM+pSXUUyZ8nvkiKyYBg?=
 =?us-ascii?Q?nVk0qMoxD++WgdADWCZpSKGxxHz+WKzEMbt7VkPJ3K8Kp/QhLhSrcc71b2JE?=
 =?us-ascii?Q?0knMDJ++Muiv9r36iFugGrzaZQsRSCGmTt7Tqch7U1sDZHtxDVr9MvFdY5Hm?=
 =?us-ascii?Q?Twq6xi2/SwfrT6c2BG7+d0PbZLMuUDfAlwXcJDGOINN5w/uZ+9XhRirQs9ra?=
 =?us-ascii?Q?168G9D0B59/cQIrxkA6cSbMM04osHEaCZ8DMDw6/0TB3lhyUTNn1+VCY2apK?=
 =?us-ascii?Q?pH1St2Yy7HLMIkJDRdIerHw5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd1d0c8-e52b-4cd0-e813-08d95ca631c6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 08:58:32.0335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OROEU0mCqksgs+T7VIhW5MD+X2tSOZXHlwadaIi/A4a1prbNc2jkIlqLYvRY9L/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/11 =E4=B8=8B=E5=8D=884:56, Nikolay Borisov wrote:
>=20
>=20
> On 11.08.21 =D0=B3. 11:47, Qu Wenruo wrote:
>>
>>
>> On 2021/8/11 =E4=B8=8B=E5=8D=883:28, Nikolay Borisov wrote:
>>>
>>>
>>> On 11.08.21 =D0=B3. 10:17, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/8/11 =E4=B8=8B=E5=8D=883:03, Nikolay Borisov wrote:
>>>>>
>>>>>
>>>>> On 11.08.21 =D0=B3. 2:54, Qu Wenruo wrote:
>>>>>> Currently if running btrfs-map-logical on a filesystem with corrupte=
d
>>>>>> extent tree, it will fail due to open_ctree() error.
>>>>>>
>>>>>> But the truth is, btrfs-map-logical only requires chunk tree to do
>>>>>> logical bytenr mapping.
>>>>>>
>>>>>> Make btrfs-map-logical more robust by:
>>>>>>
>>>>>> - Loosen the open_ctree() requirement
>>>>>>  =C2=A0=C2=A0=C2=A0 Now it doesn't require an extent tree to work.
>>>>>>
>>>>>> - Don't return error for map_one_extent()
>>>>>>  =C2=A0=C2=A0=C2=A0 Function map_one_extent() is too lookup extent t=
ree to ensure
>>>>>> there is
>>>>>>  =C2=A0=C2=A0=C2=A0 at least one extent for the range we're looking =
for.
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0 But since now we don't require extent tree at al=
l, there is no
>>>>>> hard
>>>>>>  =C2=A0=C2=A0=C2=A0 requirement for that function.
>>>>>>  =C2=A0=C2=A0=C2=A0 Thus here we change it to return void, and only =
do the check when
>>>>>>  =C2=A0=C2=A0=C2=A0 possible.
>>>>>>
>>>>>> Now btrfs-map-logical can work on a filesystem with corrupted extent
>>>>>> tree.
>>>>>>
>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>> ---
>>>
>>> <snip>
>>>
>>>>>
>>>>>
>>>>> Furthermore with map_one_extent present the semantics of the program =
is
>>>>> that it prints the logical mapping of the real extent rather then the
>>>>> passed in bytes. Because the user is allowed to pass an offset for
>>>>> which
>>>>> there isn't a real extent. So if we want to retain this your change
>>>>> is a
>>>>> no-go.
>>>>
>>>> The change just makes the extent item lookup an optional operation.
>>>
>>>
>>>>
>>>> If by somehow we failed to lookup the extent item, we just continue wi=
th
>>>> the values passed-in, no longer to verify whether there is an extent.
>>>>
>>>> This is especially important for fs with corrupted extent tree.
>>>>
>>>>> OTOH if we want to have btrfs_map_logical to serve as a simple
>>>>> calculation aid i.e you pass in some logical byte, irrespective wheth=
er
>>>>> it contains a real extent or not, and have the program return what th=
e
>>>>> physical mapping is then map_one_extent becomes redundant altogether.
>>>>
>>>> Yeah, I was also thinking about that, but not sure if we should
>>>> completely remove map_one_extent().
>>>>
>>>> Thus I took the middle land by rendering it optional.
>>>
>>> IMO the middle ground would be to add a command line switch i.e force
>>> which would ignore map_one_extent. In such exceptional cases a user wit=
h
>>> a problem could be instructed to run the command with an '-f' switch fo=
r
>>> example. The rest of the time the program would preserve its old logic
>>> which guarantees returning mapping for real extents.
>>
>> But now I'm wondering, do we really need that extent check?
>>
>> I mean, yes rejecting the lookup for non-existing range may be helpful,
>> but it's not perfect.
>>
>> For example, if we are looking up a unwritten preallocated range, we can
>> pass the extent check, but still only gets garbage from the disk.
>=20
> Well yes and no. We will get a garbage if we try to read directly from
> the disk by using the resulting offset. OTOH we are getting valid data
> for an extent that exists - preallocated extents are real extents at the
> end of the day.
>=20
> Again, it all boils down to what semantics we'd like to offer. But the
> more I think about it, the more I'm inclined to say keep it simple, and
> do a conversion from logical->physical in which case map_one_extent can
> be removed as well.

Yep, let's try to make it simpler by making it just a logical ->=20
physical mapping.

And remove invalid cases like unaligned start/len.

Thanks,
Qu
>=20
>>
>> So why not just let users do whatever they want?
>>
>> (Well, I should ask the same questions to the older me from 5 years ago)
>>
>> Thanks,
>> Qu
>>>
>>>>
>>>> But if that's the way to go, I can't be more happier as that greatly
>>>> simplify the workflow of btrfs-map-logical.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> <snip>
>>>>>
>>>>
>>
>=20

