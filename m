Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F78401541
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 05:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbhIFDh0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Sep 2021 23:37:26 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:21478 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230191AbhIFDhZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Sep 2021 23:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1630899379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnFNbAGXnR3Lwg7ARV1vLva12gcYyBSn5v3Lkg/Y7D8=;
        b=awZFZgbN+qYC7n6m1JljzxP4LNwVHTR5m7HKNwb/wIEK8/Fcb8q0NQiT6HAq6wh6YzTajP
        hjFxChhdfKeQMAZKQbuoze52/aHWp5nmPnPA0sUVm/YMb5aqVJhzicnu2YoatJns2GPbJB
        V+dk8kc4AVpS5fq7XczpKjvQAqDbkKE=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-m-odCcLwOqOGkuB1ZBJAeg-1; Mon, 06 Sep 2021 05:36:18 +0200
X-MC-Unique: m-odCcLwOqOGkuB1ZBJAeg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt0yWRom8UKrlZloOsjTZFD+FZP85VjG6em7Ed7yRpq/th4SWBlLUVkUH2Qg+J5QbbFjWXankCuAJD3o5RhkAi72ZVyXO5wCNniUvSCaqREa3Sz1XBXTFnp8NHzXCsjQ9cAmWEmX8XxuI5wCY+Mq8k1syw9KptCAnOPrlQCQjCWUAE/FSwBZrzh8x6YJE0ZOJu8416Pdn7kv4UsHW98bCmVAR3xH446KK3i4FptSvGQcmAeOdnQUirSL0IRoQYn/08avXGacWpcU/0nBs2oqtRGW3FSAsUsZsqe/DjlZxenfAi7byJiWbQyu8sNjSxnX9Bc+wjR3NEqyRDGGwOzmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/lHHMSXthU49IqcHPSUMpS60eYTaCPu212MIJed1JUQ=;
 b=SXKNA6MIm/xQbAUSRuk/yg5Br2JX7Ak1tdlp/TLoouPij+vxrHZcR2+4aVQ3t5qUqv96EzVwpVRvlfuvzWIAInuZ2GK86+IqK89R1IpJDJFEbIMk0J8shCbX7bGe+tElCI6SWh/tQUml+j/JnNE/1pz6FsBEUqZcSCDfFc0aH04pfes6CyYC7/ZKphKOyhQW9cxTf4il9aae6/4MlIsZtJP+OLFWBGspm26T8sSDby5Oewz0NWmgOJhvRcvZbNVuIzg7VsBL6vrAVRKY4Gob/tc49Aaw+8r5d8WI1gDy7qrR8wSSs5JTTsi/+sEMNdtT3v2VmWM2ehT+3G2WEYO4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8309.eurprd04.prod.outlook.com (2603:10a6:20b:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Mon, 6 Sep
 2021 03:36:17 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 03:36:16 +0000
To:     ahipp0 <ahipp0@pm.me>, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <IZ0izVVsQVN4TIg_nsujavw6xz3UG-k0C53QTbeghmAryLDm5vf13M_UyrvBZ9tgDT5Mh8VXrMKBfGNju1_FBaCksUTcqZRnfuRydexvfvA=@pm.me>
 <01bb7749-eccd-5a3e-eee3-3320c89ce075@gmx.com>
 <ozcaaGlwEFFj_mq4ZFf_hu1RHtOGruGz8Dwb8HHPEUhCn8Sn3G5BhbJxsMefPbtwacd-dcCJmCv6TbdX1Fdx4r-J_GoHa1rAbB4L4QQWZb0=@pm.me>
 <5ebaf4e2-a96e-a34a-f509-2a29154149eb@gmx.com>
 <tDw4sk7EvCGMpj-jprKJJ0hhti2ZS7oRNek_3A3F8IUrhpxQpMPgKRxrhBmWJoMqhA6iZ_OkO2qRUVYrtnB44rv02yPUh0YZe8Adc0IX1R8=@pm.me>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: BTRFS critical: corrupt leaf; BTRFS warning csum failed, expected
 csum 0x00000000 on AMD Ryzen 7 4800H, Samsung SSD 970 EVO Plus
Message-ID: <44dc1e9a-7739-f007-5189-00fd81c0ef26@suse.com>
Date:   Mon, 6 Sep 2021 11:36:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <tDw4sk7EvCGMpj-jprKJJ0hhti2ZS7oRNek_3A3F8IUrhpxQpMPgKRxrhBmWJoMqhA6iZ_OkO2qRUVYrtnB44rv02yPUh0YZe8Adc0IX1R8=@pm.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0178.namprd13.prod.outlook.com (2603:10b6:a03:2c7::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Mon, 6 Sep 2021 03:36:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60da156a-8a20-42f8-6a47-08d970e77bc5
X-MS-TrafficTypeDiagnostic: AS8PR04MB8309:
X-Microsoft-Antispam-PRVS: <AS8PR04MB83097210B7DB85F811FC0B0DD6D29@AS8PR04MB8309.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjx9tsSnJes9J0oZ0GwiGHJYf51yXy6IQ+C4TgA9ZLiuaYixlJcSrRj4YX7vUf9hCQiZAiHDtQh+u7eihIOnK8wn2KHxu+a1bRdkMbeDwBrTVLqiU/NIp9MyFEtWILcZ2GPAIRI2X4/SF95AMieUrSiR8raG8/VFOSTFXfhqV1aK/LWS1Udh01BVL9JnYLiZ5ACoyoPHWe6L4MoPPq9Fi7BTIEPHY/akOUZB9fR8vKeevS9pYt/AJiDFJwR0ayLiswCR6g4GseShGpRuZn1NffnJfHB3PuznXvxlGnG/nKcPscWRCR8UAos4IpzfTbOIOSbGbzYi9SF+nE2E2Jcasf/b+ZdqF4c6FJze9tLD9ebZwFFO8Gsi4lormCnTgxtRxkfRi1TEO/W8nPsQK3nk4sdHiGzu+1gksrCMZrnVhlD5MjNMqlvVv8VK5F+ccssJD7y2raEOgXnfQpyBNk6569JMI0CUYKKOlCAA89IB4dNn8yA+2Iy1mba58HKsb+N9thhQtdhiPVCQ+MUTfCO1DaPCwZKjgaprFuZoRj9VxIcyh7ppITvnSnck014U3TG0xj8/ykcCCFkIQt287YB8ayP1TbULMnixCONbS3ACEonkdZymp/RwaUYEhVzK7LKiBhhy2vyajvfV9Om1MuW/6KLBqOgJTneoXvC3+LPJ871Qh7dAofOnHekpqEBj2bVON7R93qPLt3XMQ7quZlE5/SkrwMasdSNyejmSVkvYHTmj5nLZExRTnR4mJM2Grzde
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(31686004)(2906002)(8936002)(83380400001)(86362001)(38100700002)(316002)(508600001)(16576012)(2616005)(4326008)(956004)(31696002)(110136005)(36756003)(5660300002)(186003)(26005)(30864003)(66476007)(66946007)(8676002)(66556008)(6666004)(6706004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1lYRVTbIQK1KNxPTI2VLQOEn07Nu0W9Fs1z5oXaq/jtCMfBRTNIn9eP3GfN2?=
 =?us-ascii?Q?QNHocun9/xlauC3uD1iXeOERoNhAtf1rPM9+bgO7pqNg+sakL7Du7J9rTvof?=
 =?us-ascii?Q?UTt9z12aQzPwf/PYzvYrg1td6gbpeAULWj0KevUZwG99O0i1QT3fnUR4PvEY?=
 =?us-ascii?Q?PmtnUIsyjUphl1RxL3EGKvRsbiVJPQ+3ch0oUmDxHf6Kbcpk3mNcy3FsTezY?=
 =?us-ascii?Q?9IpM8rbUvJG6uYlFLOciv4LenqBxQMbSRCx06ADtbzTXIz4k95pq5q0sAq/w?=
 =?us-ascii?Q?zUcW77XT2rpQhSJn2IXGiQ0l5/yq21KhqwFJ4pAEq8X+scDXEGOBhlauy0qs?=
 =?us-ascii?Q?ShqsBKXihBZ/lOCafDii38D2VlLkYHwghpKA7aZ1i9jXP0wf1IaqEuwWjoDM?=
 =?us-ascii?Q?M2/W8qTQ664H1uddnY5pTXp6w3t5YqKxiS7TWhwwB3/kg1F/pyLQ3nR2oPxi?=
 =?us-ascii?Q?imGqbhWWCXTmFQ0/pFgq5xZcUddUGZa5EcIXHqmIVtoAj3Ib3Q3nNG418gcX?=
 =?us-ascii?Q?rXqkTPwy1eT114xucQfJX3OubDnRK4Vwz455EQTD7oUIhKSv1y52sY9JxdD0?=
 =?us-ascii?Q?yzwBGsX8ahja/6mhWhaDovm/mVg1qa2w3uCXimrij3hUvHAjAd3K9oAgyb0I?=
 =?us-ascii?Q?CCTJoM/ldU5+OmWHWqK17CEv43SjI3VhYU9Y4/yOy8kjDkrorSWtDK6+JH4Q?=
 =?us-ascii?Q?/WJyud9eAjKNBjfxhZxqfKoH5ttgJIxA8x0Q5sz6ge5nCK+3hkJYwis9ndGq?=
 =?us-ascii?Q?AG+ZMTXzDM8rUESlzhRJd/qRMTdtO02HQPOeUk46P7GNPQD9wf8HGbkv4YAM?=
 =?us-ascii?Q?OyZmzIUeC7DmR6fRjpmVrXmLGtzfKV05P5VyVENidGF3RpvIC9LzmahAx6/g?=
 =?us-ascii?Q?xDj0WUpVDXUT0Kh3Ee7Pr8MoXV0kS940NGs6aq5pHqppXmEm0xXFfDIViU0V?=
 =?us-ascii?Q?lt3ifOEapdkhZsZ/BRex1Y9TCHal8TUmX1krvKm71+r4H4Afvt3+GjHafgKm?=
 =?us-ascii?Q?FRiPDLNv7PT0jObHS/ZrmoZ7SLWGcvRZ+4RCgWpEgQqk02HniTecnFNO3fQj?=
 =?us-ascii?Q?TomYDlD/m5K7vuLXi+o1UHNUMaP1AYRyK/2PMtUESu3ZOtxeKJwQEgLmw6GX?=
 =?us-ascii?Q?NlxxtVAaiLhkTpPUxvhenbP30bU2RC5wGdHgWGe4LPVkmq+1HqE7RSsuo6uP?=
 =?us-ascii?Q?x7KA2JvyAuw8ZH8q0RaeZj12kTrDNOZsiDc7mlvP8UjFubQbJDlaqcJ1LIOq?=
 =?us-ascii?Q?MLiHQHGqekYvxL27sqSB8gsY/fVn2RSooYs0V2gMdsg+Y2cgZW59muyDo1pW?=
 =?us-ascii?Q?cBmTYCA8BpKphd1tPvP8d/Fz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60da156a-8a20-42f8-6a47-08d970e77bc5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 03:36:16.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9TBvJm9rhYgNdQ3rGxQxxIzc1MLjfRmlsBCxo/blHcKb5s6r1pe9XxMB1Hv+lsq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8309
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/6 =E4=B8=8A=E5=8D=8811:05, ahipp0 wrote:
[...]
>=20
>> see the result of regular --repair.
>=20
> $ btrfs check --repair /dev/nvme0n1p4
>=20
> enabling repair mode
> WARNING:
>=20
> Do not use --repair unless you are advised to do so by a developer
> or an experienced user, and then only after having accepted that no
> fsck can successfully repair all types of filesystem corruption. Eg.
> some software or hardware bugs can fatally damage a volume.
> The operation will start in 10 seconds.
> Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p4
> UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> ref mismatch on [3111260160 8192] extent item 0, found 1
> data backref 3111260160 root 257 owner 488963 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3111260160 root 257 owner 488963 offset =
0 found 1 wanted 0 back 0x55d56b1ea2f0
> backpointer mismatch on [3111260160 8192]
> adding new data backref on 3111260160 root 257 owner 488963 offset 0 foun=
d 1
> Repaired extent references for 3111260160
> ref mismatch on [3111411712 12288] extent item 0, found 1
> data backref 3111411712 root 257 owner 488887 offset 4096 num_refs 0 not =
found in extent tree
> incorrect local backref count on 3111411712 root 257 owner 488887 offset =
4096 found 1 wanted 0 back 0x55d56c18ca50
> backpointer mismatch on [3111411712 12288]
> adding new data backref on 3111411712 root 257 owner 488887 offset 4096 f=
ound 1
> Repaired extent references for 3111411712
> ref mismatch on [3111436288 16384] extent item 0, found 1
> data backref 3111436288 root 257 owner 488889 offset 4096 num_refs 0 not =
found in extent tree
> incorrect local backref count on 3111436288 root 257 owner 488889 offset =
4096 found 1 wanted 0 back 0x55d576d8e290
> backpointer mismatch on [3111436288 16384]
> adding new data backref on 3111436288 root 257 owner 488889 offset 4096 f=
ound 1
> Repaired extent references for 3111436288
> ref mismatch on [3111489536 8192] extent item 0, found 1
> data backref 3111489536 root 257 owner 488964 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3111489536 root 257 owner 488964 offset =
0 found 1 wanted 0 back 0x55d5699f2700
> backpointer mismatch on [3111489536 8192]
> adding new data backref on 3111489536 root 257 owner 488964 offset 0 foun=
d 1
> Repaired extent references for 3111489536
> ref mismatch on [3111616512 638976] extent item 25, found 26
> data backref 3111616512 root 257 owner 488965 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3111616512 root 257 owner 488965 offset =
0 found 1 wanted 0 back 0x55d56c17dc00
> backref disk bytenr does not match extent record, bytenr=3D3111616512, re=
f bytenr=3D3112091648
> backref bytes do not match extent backref, bytenr=3D3111616512, ref bytes=
=3D638976, backref bytes=3D8192
> backpointer mismatch on [3111616512 638976]
> attempting to repair backref discrepancy for bytenr 3111616512
> ref mismatch on [3111260160 8192] extent item 0, found 1
> data backref 3111260160 root 257 owner 488963 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3111260160 root 257 owner 488963 offset =
0 found 1 wanted 0 back 0x55d578005140
> backpointer mismatch on [3111260160 8192]
> adding new data backref on 3111260160 root 257 owner 488963 offset 0 foun=
d 1
> Repaired extent references for 3111260160
> ref mismatch on [3111411712 12288] extent item 0, found 1
> data backref 3111411712 root 257 owner 488887 offset 4096 num_refs 0 not =
found in extent tree
> incorrect local backref count on 3111411712 root 257 owner 488887 offset =
4096 found 1 wanted 0 back 0x55d577576b70
> backpointer mismatch on [3111411712 12288]
> adding new data backref on 3111411712 root 257 owner 488887 offset 4096 f=
ound 1
> Repaired extent references for 3111411712
> ref mismatch on [3111436288 16384] extent item 0, found 1
> data backref 3111436288 root 257 owner 488889 offset 4096 num_refs 0 not =
found in extent tree
> incorrect local backref count on 3111436288 root 257 owner 488889 offset =
4096 found 1 wanted 0 back 0x55d56a2e5c40
> backpointer mismatch on [3111436288 16384]
> adding new data backref on 3111436288 root 257 owner 488889 offset 4096 f=
ound 1
> Repaired extent references for 3111436288
> ref mismatch on [3111489536 8192] extent item 0, found 1
> data backref 3111489536 root 257 owner 488964 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3111489536 root 257 owner 488964 offset =
0 found 1 wanted 0 back 0x55d56b770820
> backpointer mismatch on [3111489536 8192]
> adding new data backref on 3111489536 root 257 owner 488964 offset 0 foun=
d 1
> Repaired extent references for 3111489536
> ref mismatch on [3111616512 638976] extent item 25, found 26
> data backref 3111616512 root 257 owner 488965 offset 18446744073709076480=
 num_refs 0 not found in extent tree
> incorrect local backref count on 3111616512 root 257 owner 488965 offset =
18446744073709076480 found 1 wanted 0 back 0x55d576f3cab0
> backpointer mismatch on [3111616512 638976]
> repair deleting extent record: key [3111616512,168,638976]
> adding new data backref on 3111616512 root 257 owner 31924 offset 5496832=
 found 25
> adding new data backref on 3111616512 root 257 owner 488965 offset 184467=
44073709076480 found 1
> Repaired extent references for 3111616512
> ref mismatch on [3123773440 8192] extent item 0, found 1
> data backref 3123773440 root 257 owner 488966 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3123773440 root 257 owner 488966 offset =
0 found 1 wanted 0 back 0x55d56bb7b6e0
> backpointer mismatch on [3123773440 8192]
> adding new data backref on 3123773440 root 257 owner 488966 offset 0 foun=
d 1
> Repaired extent references for 3123773440
> ref mismatch on [3124051968 12288] extent item 0, found 1
> data backref 3124051968 root 257 owner 488895 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3124051968 root 257 owner 488895 offset =
0 found 1 wanted 0 back 0x55d56ac11990
> backpointer mismatch on [3124051968 12288]
> adding new data backref on 3124051968 root 257 owner 488895 offset 0 foun=
d 1
> Repaired extent references for 3124051968
> ref mismatch on [3124080640 8192] extent item 0, found 1
> data backref 3124080640 root 257 owner 488967 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3124080640 root 257 owner 488967 offset =
0 found 1 wanted 0 back 0x55d577900d10
> backpointer mismatch on [3124080640 8192]
> adding new data backref on 3124080640 root 257 owner 488967 offset 0 foun=
d 1
> Repaired extent references for 3124080640
> ref mismatch on [3124252672 208896] extent item 12, found 13
> data backref 3124252672 root 257 owner 488902 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3124252672 root 257 owner 488902 offset =
0 found 1 wanted 0 back 0x55d56b005980
> backref disk bytenr does not match extent record, bytenr=3D3124252672, re=
f bytenr=3D3124428800
> backref bytes do not match extent backref, bytenr=3D3124252672, ref bytes=
=3D208896, backref bytes=3D12288
> backpointer mismatch on [3124252672 208896]
> attempting to repair backref discrepancy for bytenr 3124252672
> ref mismatch on [3111260160 8192] extent item 0, found 1
> data backref 3111260160 root 257 owner 488963 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3111260160 root 257 owner 488963 offset =
0 found 1 wanted 0 back 0x55d576dbdef0
> backpointer mismatch on [3111260160 8192]
> adding new data backref on 3111260160 root 257 owner 488963 offset 0 foun=
d 1
> Repaired extent references for 3111260160
> ref mismatch on [3111411712 12288] extent item 0, found 1
> data backref 3111411712 root 257 owner 488887 offset 4096 num_refs 0 not =
found in extent tree
> incorrect local backref count on 3111411712 root 257 owner 488887 offset =
4096 found 1 wanted 0 back 0x55d56b68d090
> backpointer mismatch on [3111411712 12288]
> adding new data backref on 3111411712 root 257 owner 488887 offset 4096 f=
ound 1
> Repaired extent references for 3111411712
> ref mismatch on [3111436288 16384] extent item 0, found 1
> data backref 3111436288 root 257 owner 488889 offset 4096 num_refs 0 not =
found in extent tree
> incorrect local backref count on 3111436288 root 257 owner 488889 offset =
4096 found 1 wanted 0 back 0x55d576c0fb70
> backpointer mismatch on [3111436288 16384]
> adding new data backref on 3111436288 root 257 owner 488889 offset 4096 f=
ound 1
> Repaired extent references for 3111436288
> ref mismatch on [3111489536 8192] extent item 0, found 1
> data backref 3111489536 root 257 owner 488964 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3111489536 root 257 owner 488964 offset =
0 found 1 wanted 0 back 0x55d56ab85320
> backpointer mismatch on [3111489536 8192]
> adding new data backref on 3111489536 root 257 owner 488964 offset 0 foun=
d 1
> Repaired extent references for 3111489536
> ref mismatch on [3123773440 8192] extent item 0, found 1
> data backref 3123773440 root 257 owner 488966 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3123773440 root 257 owner 488966 offset =
0 found 1 wanted 0 back 0x55d56ab937e0
> backpointer mismatch on [3123773440 8192]
> adding new data backref on 3123773440 root 257 owner 488966 offset 0 foun=
d 1
> Repaired extent references for 3123773440
> ref mismatch on [3124051968 12288] extent item 0, found 1
> data backref 3124051968 root 257 owner 488895 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3124051968 root 257 owner 488895 offset =
0 found 1 wanted 0 back 0x55d576c155b0
> backpointer mismatch on [3124051968 12288]
> adding new data backref on 3124051968 root 257 owner 488895 offset 0 foun=
d 1
> Repaired extent references for 3124051968
> ref mismatch on [3124080640 8192] extent item 0, found 1
> data backref 3124080640 root 257 owner 488967 offset 0 num_refs 0 not fou=
nd in extent tree
> incorrect local backref count on 3124080640 root 257 owner 488967 offset =
0 found 1 wanted 0 back 0x55d56b031700
> backpointer mismatch on [3124080640 8192]
> adding new data backref on 3124080640 root 257 owner 488967 offset 0 foun=
d 1
> Repaired extent references for 3124080640
> ref mismatch on [3124252672 208896] extent item 12, found 13
> data backref 3124252672 root 257 owner 488902 offset 18446744073709375488=
 num_refs 0 not found in extent tree
> incorrect local backref count on 3124252672 root 257 owner 488902 offset =
18446744073709375488 found 1 wanted 0 back 0x55d5773b8b20
> backpointer mismatch on [3124252672 208896]
> repair deleting extent record: key [3124252672,168,208896]
> adding new data backref on 3124252672 root 257 owner 31924 offset 7163904=
 found 12
> adding new data backref on 3124252672 root 257 owner 488902 offset 184467=
44073709375488 found 1
> Repaired extent references for 3124252672
> No device size related problem found
> [3/7] checking free space cache
> [4/7] checking fs roots
> root 257 inode 31924 errors 1000, some csum missing
> ERROR: errors found in fs roots
> found 427087040512 bytes used, error(s) found
> total csum bytes: 415797096
> total tree bytes: 1277558784
> total fs tree bytes: 682033152
> total extent tree bytes: 89456640
> btree space waste bytes: 252979190
> file data blocks allocated: 516356227072
>   referenced 424745533440
>=20
>=20
> $ btrfs check /dev/nvme0n1p4
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p4
> UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> [1/7] checking root items
> [2/7] checking extents
> extent item 3109511168 has multiple extent items
> ref mismatch on [3109511168 2105344] extent item 1, found 5
> backref disk bytenr does not match extent record, bytenr=3D3109511168, re=
f bytenr=3D3111489536
> backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=
=3D2105344, backref bytes=3D8192
> backref disk bytenr does not match extent record, bytenr=3D3109511168, re=
f bytenr=3D3111260160
> backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=
=3D2105344, backref bytes=3D8192
> backref disk bytenr does not match extent record, bytenr=3D3109511168, re=
f bytenr=3D3111411712
> backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=
=3D2105344, backref bytes=3D12288
> backref disk bytenr does not match extent record, bytenr=3D3109511168, re=
f bytenr=3D3111436288
> backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=
=3D2105344, backref bytes=3D16384
> backpointer mismatch on [3109511168 2105344]
> extent item 3121950720 has multiple extent items
> ref mismatch on [3121950720 2220032] extent item 1, found 4
> backref disk bytenr does not match extent record, bytenr=3D3121950720, re=
f bytenr=3D3124080640
> backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=
=3D2220032, backref bytes=3D8192
> backref disk bytenr does not match extent record, bytenr=3D3121950720, re=
f bytenr=3D3123773440
> backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=
=3D2220032, backref bytes=3D8192
> backref disk bytenr does not match extent record, bytenr=3D3121950720, re=
f bytenr=3D3124051968
> backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=
=3D2220032, backref bytes=3D12288
> backpointer mismatch on [3121950720 2220032]

Those offending blocks are some data extents.

Can you use some newer btrfs-progs and run check on it again? (not yet=20
repair)
This time in both original and lowmem mode.

As the involved btrfs-progs is pretty old, thus newer btrfs-progs (the=20
newer the better) may cause some difference.
(Sorry, I should mention it earlier)

Thanks,
Qu

