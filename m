Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D737F6B3D64
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 12:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCJLMr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 06:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCJLMY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 06:12:24 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EAA107D53
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 03:12:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5W7yE+DORAoEYzltT8qsywFWnyGTmiv2zNFEZ7lzdwbMRbUh2xWhHLg9kn/K34Nq2Nynm7gTnHm+HnVdRgSreQFm+K/R1Gh+D0VIyxvO94qMSiUzVymVG3I9aJGEcNuL5eSln/+2C8IOgjPVTuB5Cheq2m0r5CwmtKq+u/R9AOvyrSNHfWbMT+mE8R6P1514m8uHSatluOAqVLKClAylZVh+/lfSpzB4HTmS58NU9EPzF+H2dyR9WYc+OIMMn+me51JbPD+jME9fuuv1eVVwQAPoLjiKcPbXT7nveNxoIpLjUSvQ3VoTcf/3tY7pdA/MCZNYNSG+pUPJis7GT9fdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YBCm2EQcITn+eazjeBej1PrZXM4fzhsMefVI4jCX/s=;
 b=TrZJJsRaiDItmut3qdEF0Zm/wQWhCm2n3UPpn6gJIJrrQ9DF+cTDdAp8Zqb1LwgA9Pio3IaxyCrsh2j9LRiWrIFUdPgrhUAeRx8OVaNJkvZdy2FAjzmUzQ/y+ygNk0vrI67Gh+BxpYFXD5cgFCWBjUsWDQ/ZbFjjovNeSvKXmIVFkOWgEBwIJjgGFeItzVKb4ZZeBjwykPXaxbTCr9d10c8nLoTjSt6QkiANuaPBi/iQ1sFINdAiE3br7YOZ5eg3rsqPtSkc0fWI90QD4PFPGpcU4IDtsB7A/2COgU/06ddVCKkbhFTk8/UG3bBEOqJsx3bgjM3kb8x9u/GLLJy33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YBCm2EQcITn+eazjeBej1PrZXM4fzhsMefVI4jCX/s=;
 b=ybuR2rDIr7VkW0Gpp+BMKXLCWQ6wXYc3zDFk2BrK7EpAJukjiYmxmlHtSWcr54wkFDA7S+IvHWeM+Qj7AhNdxQFGOncPVl6iz2vYniOdPr8Fr2hZ3PiXNWAYzoK2e993AeQw8EkJEbW+k5QPuLceaEj5z03NtFOreNg7Nhy/F4Y0Gs+DKunmBAJu6WwYlYRljb3Lck1gtXuS5t+ypyesGsPoPrpFqzubF+u3ybdH0h7Qmhn7Mm71dPOu2Mgy53StSN8lX2/ZMzeSL/c8PfDujFZj3Q/MWcGkFJwypDOditVStpulE9PIg8uKQTGmJ9xRHDWkRc4mvOPlLZpG56cD5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB8405.eurprd04.prod.outlook.com (2603:10a6:102:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 11:12:19 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 11:12:19 +0000
Message-ID: <418e65cb-7f86-bb52-2c8d-d8a6c4d86728@suse.com>
Date:   Fri, 10 Mar 2023 19:12:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 05/20] btrfs: simplify extent buffer reading
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-6-hch@lst.de>
 <52d760f4-dec8-7162-40b7-4f0be14848b8@gmx.com>
 <20230310074723.GA14897@lst.de>
 <CAL3q7H4qmpY1c=t2P8fRn-Si4WDPhbdEQuVY7M-spc7-GqXBrw@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAL3q7H4qmpY1c=t2P8fRn-Si4WDPhbdEQuVY7M-spc7-GqXBrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0035.prod.exchangelabs.com (2603:10b6:a02:80::48)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a769086-7204-4921-e791-08db21584fb6
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsRxDoDtMjN5fRLR7ALbwDqy6PEOW/ZeDwkkHCuGIHa1ykkruHgajGgkc/vu0Fbx4POYUutMgwPJQZPohHgSewSNEFkoQibIK7Iuk8X2RWcKZJF/VZcqdVNM/mo8LGp6YC88TmTWD0Nd9o53SHEQf/Hsw9c0kS2ppXxcXkbMoRfcaWZ6CHYHZSc8B6xV1YCSjLO04ZHXBd/LcQmGtNzE36MOURbvtwIh2ykJTtdUq1KXjGVCc1Ysq6B+jgLxJ5UT9mYB7xc1tj+dbXAng1WlYS21m9EbncEUUuZc4McKhH5f354eBDhX0nWhoSu1KuqHoGHo6TPoGAFzKYbuk7brc5lbC1+sGRcMTlsuxpe4AWUjmtT39WhTSNCsZMdW7CuUmh1v1Ic2vwj0dBvmp3THadV9MHGv/5ebivJ/YyI9bdRTJQUPazY4s+dcHgtkPjBv5TJFTajeI/ee5JaCNABsWwMcTUASJzEZAu4Xv36+a3CtDnSV9Z6kCbbnJE9rutMhDm9nPHTRLqAo8rOO6i1jMQ5rTWZwki0hjSxKJ1f05tel+LutkO9beZ4/ZXp1Uadz8BCxzNn42guHL1kYupIdHCDTIcBonIXqpsezlD0z2PzAVHbGooXtGFf2DRS7ewmXZFYvUYTXXSmC0zsJ7z7vMnlrhtgOLCkkn73VYPmBya9PRzElJcVW36uKqpa4aBwaCIPOxNyfum1dKAkJmyRgOy9zh819NGzC8oPQJOh6lQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199018)(4326008)(31686004)(83380400001)(66556008)(66946007)(8676002)(66476007)(41300700001)(38100700002)(316002)(2616005)(66899018)(6486002)(8936002)(53546011)(6506007)(54906003)(186003)(110136005)(6512007)(31696002)(36756003)(4744005)(478600001)(5660300002)(2906002)(6666004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFdWbjhkZGkyRjhLOUtPOHdDRndweEd3Z3EvSStLb3BDdXRqek5zZTErMjVC?=
 =?utf-8?B?aFNSMktKd3c0bk9OVmJJQ3pZaEFtc1p6NXZjQktTK2h1VUxIaFBFRlgrRHov?=
 =?utf-8?B?Z0pNUHJvOVE0eTgrb1doZ296S2l2SnFmT0lXNUM4VFBhL3RtT2Mza3pxdUVm?=
 =?utf-8?B?NnJtQ3ZqVmU5azg3bXJLeWxQRUIxMHJHYzFHV3hKc1dHS2ZQVzlLZFZXcFhY?=
 =?utf-8?B?dWVyOTRYejZlYW9SSUZSMGFkM1EycDRwNVFJTk9WdGJDeVdaS1JEOVd4eUdr?=
 =?utf-8?B?cU9HYW10TUVQZWZsK1lkTDhtVFFkbmkwY3ZBTWMzeURHU3lpMmlIQ1kzbm5q?=
 =?utf-8?B?M3c3cThsM0dGM05rd3h2Q2htQXZ4TW1ISzd0T1JFUk9HMkx5OUdQM0NUWGp5?=
 =?utf-8?B?bVQ1UkpLRlZNTkxzazVVWHF3U2FGMnFiZEovbzdzRXliOFRUN1lBUW8ySi9Y?=
 =?utf-8?B?MURPbXk5a0JONkVnZmt3M1B6djFSSTZvckJEekJXMVFGK0ZUVlNMSGorZnZQ?=
 =?utf-8?B?cUtUMzBpdnRMU1FOWWt2SVIzM3lON2J5NjNKUGt1TjRid1pKZU9OZEo4NVBS?=
 =?utf-8?B?R2JYbDZMRWdhMkt0Q3NrRnVrekMvNjJMSVg5Zk9ocWJHcTBjdjhFcUllRk1o?=
 =?utf-8?B?V2JlVjNLc1ZoOUh6QTgvVUR6US94cjEyZG45Vlh2d1M5MGlOL0ozSEd1c0s3?=
 =?utf-8?B?ZU1jVnhmZy91ZFl0UXBWTmU3SSs4ZlRZU2hSclgzdTVTYkJrMU9aYUZyWHds?=
 =?utf-8?B?REU3eTMzUGNpdnBRVnN2alJHbWxRTFgxQTJQbVdKWHBVZEI5dGJCTHI5ODJS?=
 =?utf-8?B?MG9PeFp6UDhCbFlzZFl5V1F0bTdYQWUrQm1PaGJxSU1LNmpLQk84L09MREtp?=
 =?utf-8?B?aUV1K1RVdXl0RUhja2tRbjJLKzhBSTdoMXI1QTdBam0xQTVHN2x1NERiQnF2?=
 =?utf-8?B?RjluN2J2bDBaalhzL2pNaTRwOWxxWmg2YW44QjZUWXg5Zkd4dmNHclFtYWhM?=
 =?utf-8?B?T0ZlWFhhSEJtOCtLTHltRGlIby8ydDdveDRFajBmc3ZONFpBRFVsUm0yekxU?=
 =?utf-8?B?bGRRNmhDWHEzS2w2QTNYcDN1bHp1dzJkNGlEcklpcC9iR3I1cVRYYXJiWTBU?=
 =?utf-8?B?d2FpQzMyelY0VHB2TkRTSTc1aTNjZTZPTzVVQ0dJMC8rb0RjZ2l4NXpSaU0w?=
 =?utf-8?B?dUVtd0JhcVpnRzZja3hTNENwelRDSjV6V2Q0cnZvRTV3RktVOHFNRHg2bkN5?=
 =?utf-8?B?U0FIcnltYlNEM3FlSHFHeUs1YXdpanQ2alJFaC96Rmt0WHJUSHVtNU1iVUxw?=
 =?utf-8?B?OUV3ZWdCaUYwS3pMbUM4OThmTnJaOW5QREg3TE9mTmZobEpWZGZUR3VyMUhE?=
 =?utf-8?B?UTZQSktxT3RDWDNMRXpFVlBURHVPUjllOHRkTmpPUXh0L09RM2lEbzVib0dL?=
 =?utf-8?B?cEl1dXh3SFFPVkZzSjRzY1hXeEtKR3RRRWpsU1dkZVRWYTdNZW1Wcm54Mmho?=
 =?utf-8?B?VDhDTmY4Uzd6ai9KT1lWbnBFemxpOVM5SnRZTG5iWXJhQlY2UzhFdzNKUkx0?=
 =?utf-8?B?eVJOeWRwZ0RlWXkvNDZ4Wm5ZMTEyc1AyOGtaSHlwd0FQclVyNGJZaHFzM1lF?=
 =?utf-8?B?YVZ4VElsV3FhekUrSnY4QnlSa3lGTURaYyszYkpEcDNxb0h1TFVvdXZSSmRz?=
 =?utf-8?B?SDVsSEhxUVoyRUdKeHdFK2pmV0YwRW9IVzVpSG5UN2RYa29QQ0lHWjRGdXpC?=
 =?utf-8?B?WXZCbnN4OFN4aDcraWtOcFZIcmFBSTZGeUFTd0tuT2N5VlNOa0E1U2JCdENN?=
 =?utf-8?B?QlNzbkdKRmlmQWRaM1NCQWxQVnBmWEFCbkQrVHJYYTZDaXRZNVBmMFcwWGVJ?=
 =?utf-8?B?MWdrUVZqdUNCRWZGTTJJeUlkZFhIOVJXTEV3N0RZa05aRDNYWnRUVklHZWRX?=
 =?utf-8?B?UnBqTHlqeHhUWGJWRk4xOFFvVEZuYjhGKzNOMVo1SFFqZFpXZHVSR0VGOTY2?=
 =?utf-8?B?TndpYjdYbU9xYStlU1JrUFBSRVFTRHQ3RTYzTkZWck8rb3o5SDlNZXBLcDBu?=
 =?utf-8?B?UFlESWtKMWtHZVVITk5rcS9pMUpFWGc5V2FMTC9vZENhU29WVWNLVUc5c3Mv?=
 =?utf-8?B?cTl0K2diMjlvZERxUHFWTmlCV3dqb0ZSb1RCclNTYlZCOHZHN2gxY21uWldJ?=
 =?utf-8?Q?rfGgBP/awF6/eLLUkyr2U3I=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a769086-7204-4921-e791-08db21584fb6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 11:12:18.8781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3X7GueHJRuTDvYSNicG4hVd3gDrIUxv6nuqV99tFfmEwOSbbNBGyeJPhN6B9hvuU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8405
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/10 18:54, Filipe Manana wrote:
> On Fri, Mar 10, 2023 at 8:02 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Fri, Mar 10, 2023 at 03:42:04PM +0800, Qu Wenruo wrote:
>>> This is the legacy left by older stripe boundary based bio split code.
>>> (Please note that, metadata crossing stripe boundaries is not ideal and is
>>> very rare nowadays, but we should still support it).
>>
>> How can metadata cross a stripe boundary?
> 
> Probably with mixed block groups (mkfs.btrfs -O mixed-bg) you can get
> that, as block groups are used to allocate both data extents (variable
> length) and metadata extents (fixed length).

Mixed block groups requires nodesize to be the same as sectorsize, thus 
not possible.

Thanks,
Qu
