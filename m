Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D3F7AA540
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjIUWyP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 18:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIUWyO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 18:54:14 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF7E91
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 15:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUd6OfI45Dejmnrqe1f4fuMyxZ6kuiXu6sYGcuRt2FKoQB17xFItMv8pk0U2P0QDoP9PQmmp5VxpqiMFoielioXjhwY2syBkCFEg39HEtRWAkGdd9r7Ta94IERX40Zg6p7WLkfb4OU/djIyGXCr+dhYOT3t6yEaYIu1LrfYRGnSl49pj8TUnAHGutMf9he1RTp8NQBQb4YhROtMGNFu2JhaksOkB57Vlp8GLcEsdUHJKl9e558EcweoPAiy2pjgDXevHLL99AZCnsWaxAfMiOfYyi6AxmecHFkqkY1RVXGh2gOVLcnyd0d375gHiiGwxeTr7xP83eBs48Knl2OeRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouNPcEJUUJflIuB/DGQxQSC88ZFz6O5Q40UDwME9tGk=;
 b=IIZFHhH1jI/Lr0d62hbETLP12+f0hOiHsLgB6JT04ShyOgin9AjC3UPA23slNzqv2eiVKo22l1p/IMQ5YsPr37oS7go/GY1iXpI/m9cwIhoGJNejniR6qdBorLslYnhhpYFE63c0l6frtzh1kAQRRzhj6lw1UFVKkuxLkPwV4iR9YcOk/in9sDrbZjHBRjtxKRuAzKPPOtLawJbRat8I5Y8YMiD3PiWyR86cdSshoYE316MzkioZlCw7dB+wx4QfECzFcXgC0dU0vcPFJpsdwDLVk5PlADVhyWMwV0l8aFc+maoy00CqUGd30QPCdkMZ2fXGL/VnvNPB5dk3C1PlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouNPcEJUUJflIuB/DGQxQSC88ZFz6O5Q40UDwME9tGk=;
 b=T9C63ov2LOydyKdQrNVdPVLiGfkYP5eUb9zn2AbBpNLpPhwkQ58wcnXrOYs1hDsxp4ZnVsnNYqJAa72M7BLUvN/MUYv+RrxJPjCtdBT/K29aN+xJr3v81C8HCv8WvNWRmWmluR8DiEx3ekD5mZKs7wxK5VzibMv9ZmvzVnfrXKkO42gm201afqROBle9rc4isd1jiZENk/hpyjCKbUafT2T41zrA2InClcFrgcnoCwHJOyT2KK6/lta0GnrbdGrDA3rhOhSl19cjte9r3Cz+yVY0s+gdy4yCbfCiFLBt8fAjnIV7epoyfFacqDqO3pxcqoN5TuZReJotNqaGo60xdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM0PR04MB6977.eurprd04.prod.outlook.com (2603:10a6:208:189::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 22:54:04 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b%6]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 22:54:04 +0000
Message-ID: <9dace590-06c7-4cc4-bfae-0cf51d3de70e@suse.com>
Date:   Fri, 22 Sep 2023 08:23:51 +0930
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] btrfs-progs: cmds/tune: add set/clear features
Content-Language: en-US
To:     waxhead@dirtcellar.net, linux-btrfs@vger.kernel.org
References: <cover.1693900169.git.wqu@suse.com>
 <81c4792e-b7d9-73ab-452b-d840917ebbee@dirtcellar.net>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <81c4792e-b7d9-73ab-452b-d840917ebbee@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MEWPR01CA0072.ausprd01.prod.outlook.com
 (2603:10c6:220:1de::10) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM0PR04MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 55baaaf3-1b84-430d-6f34-08dbbaf5a73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8tFAkpMKkH4cJ2J08Q2dsazZc9lYEIKYdx65axnjbAkURldzcB0zhVN+lUK0nfpes83zBPCcsn9mauTACptiS7ZLrENbK5bCMQUtmp3a4mtv4dO48EH01P+B+jlqAOhXU7IVBzduounrlyNZq6tGy2hkZQoXGGpqY1b4g9p9QWKT+L4GIwgCz7sYQCgnH9gFChSDoLEjxFDkF3f3mqvfoGb2+wLgnfBWHqWdTtrRfv9KOAcctXIXsy/HQ8Z0KRWUKZooyQqZ7Gv4YwGaobz3OqVNCiVJBjsStCj1Li+1owPd7XUYT442gyPZQ0i62Tc3YHdshzoqZAJbZUkOE9+J1Ltv4wQ52NOuEa1c8q+qQUYWf5bnCBNHwEBszDY84yOKC2hL4zTMr7C8Xp7TE7/eRLbnjVve/H/8nijAfQXfNTCBBs8J0tcG8FgAdb2myNZBtcPOW2dJOlBKkby0JOeoCBO8NL2RkioHZI0DB6TQWId3sge6ixuLi4DdnOraCvvLSM7HAJUqvYmDy9EDuYYmrww3rcvQNJO3in9UZ59Gc7FxwwTrlpUPdLrih99Dk4n7odOBAt3D23xQTRGDAKKh9u0rnaNyMsyR7wc0CTDQTuahgSZZtMrwt9/wpINxTxQ7HilHtBfXepPO2YXrTaHAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(186009)(1800799009)(451199024)(53546011)(8936002)(478600001)(31686004)(66946007)(66476007)(66556008)(6486002)(6512007)(6666004)(6506007)(8676002)(316002)(83380400001)(5660300002)(38100700002)(36756003)(31696002)(86362001)(2906002)(26005)(2616005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3gxYlhXNU9CSHJDdXFjbnY1OWNNQk9mMmhwbjVpQVdaeFFFUWs1L1hNUDhj?=
 =?utf-8?B?d1BHMnE5d2pVdGluRkRSMnVlaDRTdTAwVjVRYXRZY0tyYnQ5eGUvcktaR3c5?=
 =?utf-8?B?SWlLazhKQ1JoRDRZdW41Q205dnhBT000d1NJaVh1NXNESVdSYkpzVjRjY1pT?=
 =?utf-8?B?akVqd2M2S1QxV3M1aVZySlU1MmVQWTV0b1FRK2pVd001eWxuTzE0RjJvOVhq?=
 =?utf-8?B?eW1vbExmOWRYUm1Db0ZnSzRUcnlzeDRsNWFMaWNGM2NDS1BKaW1iS2YwV2VV?=
 =?utf-8?B?SVV3NHQycXQ4c0FKY1IwbWpCcDl1bnRqcW5vZ2lsWUk0U05xSWF3aWROY0F6?=
 =?utf-8?B?MkUxZ2lEVDVQQjI4Z0tmNk9GM2IreXpZSlhMMmp1eVpGbGFvamhkd2dTNXNO?=
 =?utf-8?B?UCswOCtRa2hqQWY5RUFDWlphV1lPeFVSb0o1T1VraFhaeG9QZm1qODlndGlY?=
 =?utf-8?B?M2YxaEpPTGJXK2dZVFlPM1FGZFpoRjFvejBTcWR3MGpsUDVySHpWWGNVTjUv?=
 =?utf-8?B?aXM3N0ZsMHB4VVMxVm5jekVVazVsR3VCYVpSc3lPeTVGRUZiUHhlWGQxVDJ6?=
 =?utf-8?B?TGQvQ1l1SmtSSzlGZkRHUG5lQUJnMzltZURQWEZPQ041OURHWHFKaVlPbXRJ?=
 =?utf-8?B?VjNaZkJUU3hOWGZBZnd0VHV4RHRkQUh5ZTg5cTZseXZKbW5yYzZ5a1RCM2c2?=
 =?utf-8?B?OXpSWUp2bVdleFZGeDRmeGNMZDI3UFhVajZQN3l5eFhaSUlHTllwVnFGKzFx?=
 =?utf-8?B?ak5MMmNzbHpRQTJMZ0lvN2VyTUx4dUw0eC9jYW1FckJLL05iK0pJMEd1TmhL?=
 =?utf-8?B?NlJZUytWM0d1T255WVdYSDhGOUVaaUV3ZGxRZzlxRlhVNDV0ZXp5anptV1N6?=
 =?utf-8?B?UUdxZDNISGk4bzFoWXA1cFowT242T1VWRDE5L2N2clVSaWI0ZURQRnhMWjBH?=
 =?utf-8?B?Qkd4YVF6MTV2MkdHclRHZWwzRnk3VTFHUTBlclF2WmRrVWllU3p6NVpOKzFF?=
 =?utf-8?B?Yyt2RDV2YWlNeSs3YklTTGNpcHZFY1NJS3dXcFBodmNsNmR0ZG94YXlBS3FM?=
 =?utf-8?B?OS9jRFpFazVYNXRWaWtVZ1l1bFNwYzdrR2svNGJseXN4anl5S0RFSWpqeTE1?=
 =?utf-8?B?bHVuejBUbXBsWG1RR2NCR29WdHAyT3F2VHNYMGE1Y1hEdmMwMFNYaktKcUxs?=
 =?utf-8?B?RDR4WWxzakRKcmF2WFdRdFB0UVI1Vk9acXRjU2JQUU5lalMxd2I4cnh3N0s4?=
 =?utf-8?B?UEJKRzNpelQzT3dGUi9UaW0xSzBYUlRRS1hUOGpRNHBNbUJuTTNCYU9xSEcx?=
 =?utf-8?B?N3BWL2xHV2dnLzdjbW5NZENxMlhLY0VBZzNsVXErc1YzeWtSSE05Y3k0VzQw?=
 =?utf-8?B?QzlvL0hsV0JSUml6bHpZWGpWL0hqdE9BSnJHTWpDcHFIaFBzcXR5M3BxUEVw?=
 =?utf-8?B?dUJYWkpUbElEMk1PemR0UVpudytUSTYxcGlBaHBtdi80WkVCOXZodUtubFZk?=
 =?utf-8?B?Vk9qWjducjZ3RExCbWFaVWtQZXZBS0dHMkwweEk3N3V4SDd5dXlmQStZaUw5?=
 =?utf-8?B?RkZIMXdIa1hVaktOOUMzZzRHMHBOVVgzTGdpNlB1R1BjYUhMYXZIY2xqNi9F?=
 =?utf-8?B?amJ5KytIdWRoY3RXd2t2Q1UxcWFnMTVPeXNKN1JwZXRpZkJJRmEvbFdJTUpr?=
 =?utf-8?B?NGZZRXAxQ1hRRVdYRW9QNTZHd3JyQWQyMExhRUFNWUdXYTRhRzc2STdKKzIx?=
 =?utf-8?B?dFBEZC9vQ3JPeHVYaGNXY25ERFBGUGhJK1Qrb3BPV1ZPWGQwQzk4aTZGUjZF?=
 =?utf-8?B?ajVDMUtqZnRqNko4cGc4b1Z1eVJ1T0I4QVFQSHNwV1lqTWlHZ1M4UHZXS2RF?=
 =?utf-8?B?eGdkdG9qY3RNUmNLL0wwYUY1M0NKQXBmVGdZckJXbmpaRjJKTTQyNWRWUUd1?=
 =?utf-8?B?S29vTUxQbFMvU0hISjBVUGRHZmNIdU1wZjU3WjZ1VUh6bmppVnFzRWVMUzBF?=
 =?utf-8?B?UXcrSW1iaWRlZkJkT3c3RmZzVVRONWFNRXZWcEdMTGhaMTVQY1FQajRKQWhE?=
 =?utf-8?B?Q0tIdE5EOWdhV0ZmQnp0N0NhMVc2SFpzRW9QeVMzMTVrUXVmZ0N6MHNrZTlv?=
 =?utf-8?Q?5fVg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55baaaf3-1b84-430d-6f34-08dbbaf5a73f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 22:54:04.0664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbCSF0K9akdUYYLlI0Y4kkp0z3au8bwLPG+xbadt3Xaey5zaED0h+dneBTcA7jA6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6977
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/22 08:03, waxhead wrote:
> Qu Wenruo wrote:
>> This is the first step to convert btrfstune functionality to "btrfs
>> tune" subcommand group.
>>
>> For now only binary features, aka set and clear, is supported,
>> thus uuid and csum change is not yet implemented.
>> (Both need their own subcommand groups other than set/clear groups)
>>
>> And even for set/clear, there is some changes to btrfstune:
>>
>> - Merge seed feature into set/clear
>>    To enable seeding, just go "btrfs tune set seed <device>".
>>
>> - All supported features can be checked by "list-all" feature
>>    Please note that, "btrfs tune set list-all" and
>>    "btrfs tune clear list-all" will have different output.
>>
> As just a regular BTRFS user I would like to please ask you to consider 
> having functions that may have consequences e.g. "dangerous" functions 
> disabled until enabled.
> 
> In other words much like you need to arm a missile or flip a safety 
> cover on a toggle switch
> 
> So if btrfs on every mount set a bit that disabled access to dangerous 
> functions (such as the tune functionality you would have to explicitly 
> enable it to be able to do scary stuff).
> 
> btrfs tune enable
> btrfs tune whatever_needs_tuning=123
> btrfs tune disable (manually disable scary functions)

We hide unsafe features behind the experimental flag of btrfs-progs, 
which is determined at compiling time.

Furthermore, all those features can be set/clear in "btrfs tune" must be 
done offline (unmounted).

Thus I think there is not much I can do to further improve the situation.

Thanks,
Qu

> 
> And yes, I am aware that root users have powers to do scary stuff, but 
> sometimes even root users need to be protected against free will.
> 
> Please consider something like the above...
