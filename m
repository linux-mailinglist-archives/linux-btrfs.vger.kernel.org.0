Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183DF7A90CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 04:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjIUCNj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 22:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjIUCNi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 22:13:38 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6535FCC
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 19:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIgFkuJjLHobITzzjRcEtKk39bXuqVY8Y6KAMxWIAHIzWNzlszlwJNLG70wpcTML2cTASQmhoiZGdMZPmSTAT5/pCfyZaGHpyccAz5boD7cnqhAHc2pzcMbeUchVWvcD/iMqdge85gmrpPfAUZIGfJwm2B581EZFDSlEg3ktH2g/IOIRxPjxQsmyTYXyR4JWaOH0WE8/tUx+ojGmvtqsVz0jyxDUVW026gnTufbyA18DvSf3KqecPAPId3peLZMnuRHh3sgbBZC5arnIR/jdXr+tDsKManAkoGaFJZ4HUQRPpyWLy+IhkBZ4hH0AGIrOmSl6oEwfx6b15n1vcMElSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk9TqCBihA+nSHzTOXUPZ1kCfHlxAbA2pxQhKCoNaWM=;
 b=RfEqFJ1485ODU994MAulygnj+C/FdyyfbNxDCdvY44MONsTYyr6b/pABLMqWPAY10zx5dbKIrxztZpphp0udzadW7N0Gm25cowW7mH9vR08w8NtCsIBuxbAeEviXQgFQE+yTu6TJ56CDR41QZ0Ca3/R3AyyFg4M2UYegf0NrjilSPwxXnxEtmmBT0it9cDc0zi06+bckx0ix0h8sXHbv/8Ja744/NzFEHACunwWCJd/TipYXdiDD9vb3f7REFaEXfFhcNwAnNQ2Yl3mo4PowmS6OQFKIW93J3N5CnBvqvchWi4PnQTHreV0A2yD1u9a5xGOPZQwadUkVTtGrBqnZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk9TqCBihA+nSHzTOXUPZ1kCfHlxAbA2pxQhKCoNaWM=;
 b=eUOd6zKOHIE6a5PRyt5nL7HDIfSopIHG7IcsVbqAEe3aeCJ3SZ4fLLgaUWX6etw1+FUtc1rlNaw4Fbs7RF40ppv7ICqE7Hvcp6faitKZ3PRyiDZ4Vqwd7ZJqJGcM375F+hGKURYRnZpgLDj7WLYQKF6etO1jZqzsDKXWK8FfxTTLt4vtO19RXA+k5bGAeZhxshsZRf3FNVLDRpBMEsK0g1q7dKz1XYqJZg5Jc41JQyteh1BxAr9t3lkA/pL96xjImGx8yRzFBsQgza1InotiHEftg/CJLh/LaThoQHgS72LZJ97hYppG+iMK8DSqzdn6ke2KWsrjl7CaIh4ETYGW9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 02:13:27 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b%6]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 02:13:27 +0000
Message-ID: <c03e9f3f-39a6-457c-a1d7-f6f4d0388f55@suse.com>
Date:   Thu, 21 Sep 2023 11:43:15 +0930
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] btrfs-progs: cmds: add "btrfs tune set" subcommand
 group
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1693900169.git.wqu@suse.com>
 <1c294f739f028da499cf7f57deb334f419979097.1693900169.git.wqu@suse.com>
 <2adb8c79-d1d2-dffa-dd6b-5254d75c9c86@oracle.com>
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
In-Reply-To: <2adb8c79-d1d2-dffa-dd6b-5254d75c9c86@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MEWP282CA0135.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d1::20) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cc6d5a-e0f3-49d9-23aa-08dbba485786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mslVGIdGKSvKm4Zv62rUFgndtMBuPEW/8Pkz9ZfdateU6T0ti1Vq8Xqd6oXDcKjKoJIpLqasXVlAc+rvMFEIkSWXk7Y7GUy2f3usxGqFwMGBE7TS2vhvfFYAYJlqvO1RHfsLU8UAbkGLd1N4FzRk2A+0G5Dh+XwRb1qwuEQGGcW7Stiy5wg5FByxuVFNrvKdvQXYb6HJBdKaceyoSkTNZbfmukhM6+FESIhYSC1cC8FVJBmqrpWbc+SGCJdo1LHFDgviCrDncyI1n/3NQbC2wSPNtiJdrJnpc50XsjuzGYO2eaSs++QKgzMzD8lrFdnrgmT8s5Dj3pbRc8HoQ+RIMQmN9ikMym6ulUbJc81fPZucBRRUjRWCwMjPX881VOiLoKpcXSziJ+eszMCSaCQTLX3Z2b7drxp1k2LdNv1DxRoLuhLymLEYQfIQtFJ1drgPLkzt/SOS6c3TDSqIhdbL59Za+JflQFh/rb3z8F95dxLO1Ia+InmnWCAcQgICkjdaUaeST2zFOhmt5k3bWLUdlJvC0C5so44XQJaNWbZjJwfQPoRa4G04xUD2Z2iDqMjDEniGLIP9Zb++S5cFRgc5ruG61wPeGA/Cuqj5f2xDVMuAQiFs7aMpthgJpbWjAfgxA8hpy+aXO17+BJVvkTgMfM3GrQgZ/gDgbCd4KQDJ/Gn1doKqJJ9vbk7M/GyJS9+X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(186009)(451199024)(1800799009)(2906002)(5660300002)(26005)(316002)(66556008)(41300700001)(66476007)(66946007)(30864003)(31686004)(8936002)(8676002)(478600001)(6506007)(6666004)(6486002)(6512007)(53546011)(36756003)(2616005)(38100700002)(86362001)(31696002)(83380400001)(2004002)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnJaaER3bG1rR2Y5RDg4anREMFZTSlZIQlZsKzNhZFNZaXpmYW1BYldVWGNo?=
 =?utf-8?B?Q0hlYkl4WmNwNFFlY1JRd0IxSnBTWVhjb1BHUzhCV2R5NU4xeGhReUxNQnBk?=
 =?utf-8?B?cjFydm1tRitSVmprTnZqdjQ3QW9zbEVLTkVEa2ovK3hXZWNNelEzNHo3UXky?=
 =?utf-8?B?ZklCSEkrTmxCdUFwK3l6UzhhNTJ5R09oczI0T0lBZVN3RVhYQzhNd0ZkS3BM?=
 =?utf-8?B?K0xlQ25xT1hZeHBkczBBa2JDa0dSaVJZSDIzbEpjdGV1R2lvTlFEOWdEZXVj?=
 =?utf-8?B?SGxZQTRqZ1JQelFwcHE0OVJyamJzVGxQNlFDS2J2SS8vWEZ5cXhheUNqRklG?=
 =?utf-8?B?N29RSU1BTWlKRmZtYVl3WENWN3lmYTVZWlBIcHlaRzdMNHBqdnlPUXNKYWFC?=
 =?utf-8?B?Uy81cWwvRkRyWmY5cDZ1VFpmdyt4dmRVeDg5aEZTMlBYbGduUGZibTNKTkZn?=
 =?utf-8?B?VTI3azcxNFBXNmZBRyt4OUpMd252RXBWZ05HUVpwR3dMdHJUcGphTFJmeDVq?=
 =?utf-8?B?djEyenZvaG92dE9MVXZKbHJEMEs2WjMvMVFvT1BONWJaTTA5WkprQUdMVTR3?=
 =?utf-8?B?T1hCaFZkNU42VzhsNXlORE1Pa1g2dlh2ZzFzbXhZczlINEhaY0lGSmdvZnFw?=
 =?utf-8?B?Q296MkhWRmNyQWRncUdnZXRkQnlxc3QzNFRxbVQ2cmd1NWRRcjc4VFh5M0VV?=
 =?utf-8?B?Y3JJZUJGeXFQYWVyaDZwS2xVTU51UWVycG01dkV5UlFGTlJoeXJvU3ArWDZi?=
 =?utf-8?B?dk5tNGlCRjhlRXF6ekRFYm00ZURzenROWWNXUExLdjlSRGFQNlh0Z2dSMy8w?=
 =?utf-8?B?ZzREOGszNVk1a3l6eGRMTUQ0cTZmdUF4S0Qvd3pzaFVUVjU1VWdrZFc4enZo?=
 =?utf-8?B?K2xXRmJ1SWRVWHkxWkQzNUZsMXNhcWxQMjg1eUc2a2ZxLzdTdGFjK29BeFpl?=
 =?utf-8?B?TlQxSmJSZFdkNHNEQkF4NDU2L0lEakFCUnVyLzRjbjBWakNxNjYxVDlUZU10?=
 =?utf-8?B?ZmVGWjVsNWtVR0hvNWRwcnFlSmpiMncwSWRXYWgxaVpGeHBXMmpySko4T3VL?=
 =?utf-8?B?dXAwRHpWU3BYbHN0Ulh6bjlBU2hIM1R4NElobFc3NkF0TmtmNXNlSjQ3ZEpU?=
 =?utf-8?B?TGgvb1ljcmx2QW9KYjhXUzUwNVF6MGxqRVRGVzBWK0pBVVJRVUtVRXZHNG51?=
 =?utf-8?B?NVB2SXd3Nk1kWUZzR0lLckNjY2NweldvYUxXMStlZWYwbGFNNi9ib0lwaXRI?=
 =?utf-8?B?VTI0dnNUZFFwMGtNRWxHQzhVcklGSkZyUlloL05rOHJsOWRwWXJ0MVRSYWhN?=
 =?utf-8?B?T0xaU3hHa1AyYUdkRUJwMVdmQytGdERBaUxEUFRHbEhtVlJ4Q2N2MnBJSjVO?=
 =?utf-8?B?cDJRVmpuT2N1RVNDeGRqYktiTW9VWS9FdFI1Tk5DTm9yYXBHSjZmSXE0QldU?=
 =?utf-8?B?MkxMOGdaUnZOdGZIYjFhMGg3ajFUYjhBd1hoN0M2K0p6L0ZkWFZURnRpVXdX?=
 =?utf-8?B?ZzFCOG9GVDlGbDZOL2QwQUM3SWF4NDIyanVjTE5kbG0wRWE3NTg2cU5UQzdS?=
 =?utf-8?B?N1hFKzVUSGhNMGhQMWYxNXpQc2x4MUltUWJhWHdJRmM1Z0tERjVwd2orSzRE?=
 =?utf-8?B?MDBpRWJ5T3E0UEd0RnFFY09NcDc1SWFRMlhEck9wRWZlTHZFdzBhdGpXSUtK?=
 =?utf-8?B?QW5uVURpQ0RUVnlJeWJjd3hBT2FYUUNCNWd3QUZ6ZVI2UmpGTmVzaHRNVmdD?=
 =?utf-8?B?ZFFzRWQ5QnhoQm5zbmNTeTNzRVRNUHZyeFNldi8zd2sxY2VoQ2Yvc3Yxb2lo?=
 =?utf-8?B?SWFQSVRvU3FjTVFnQVlnWEFpY09KYWt1dXZXVUhMU0YvQTVsbnJEbXd2L1hM?=
 =?utf-8?B?SUZQTzhiT2lKbTR3NnVhNkh4RDZOeWYrN0t3NzE2VDZ5OHRrNXhlRHdJTG9X?=
 =?utf-8?B?TU5VYTFtRlJSYXNSaHRWR3NKd0J4a1ZmWDZuYVE2NFZ5TVF1NkpVVjdZZXBz?=
 =?utf-8?B?a0llUHpVRTdZK0dxZk1oRHBjVUJuUkIxRndhL0JyV1dkblcyYjZqWUYrMEZ0?=
 =?utf-8?B?YW9GcGV6bTYwOGRyU3Q5S0NGK2FIUVBFQnlHTlhJRzczdEFteG1HQzNHMjND?=
 =?utf-8?Q?ZZ/0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cc6d5a-e0f3-49d9-23aa-08dbba485786
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 02:13:27.3378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VkfHjfn6pJQhTXgjPIdCd8Xb585RgLH9dkioadeH5QK4A5uMEIaUXtR6EOpNjKa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/21 10:23, Anand Jain wrote:
> On 05/09/2023 15:51, Qu Wenruo wrote:
>> As the first step to convert btrfstune into "btrfs tune" subcommand
>> group, this patch would add the following subcommand group:
>>
>>   btrfs tune set <feature> [<device>]
>>
>> For now the following features are supported:
>>
>> - extref
>> - skinny-metadata
>> - no-holes
>>    All those are simple super block flags toggle.
>>
>> - list-all
>>    This acts the same way as "mkfs.btrfs -O list-all", the difference is
>>    it would only list the supported features.
>>    (In the future, there will be "btrfs tune clear" subcommand, which
>>     would support a different set of features).
>>
> 
> With this patchset, the syntax is structured as follows:
> 
> 
>     $ btrfs tune --help
>     usage: btrfs tune <command> <args>
> 
>        btrfs tune set <feature> [<device>]
>            Set/enable specified feature for the unmounted filesystem
>        btrfs tune clear <feature> [<device>]
>            Clear/disable specified feature for the unmounted filesystem
> 
>     change various btrfs features
> 
> 
> 
> However, for consistency, I suggest the following syntax:
> 
>    set:
>     $ btrfs tune <feature> /dev/sda
> 
>    clear:
>     $ btrfs tune <feature> --clear /dev/sda
> 
>    list:
>     $ btrfs tune --list-all

This can be confusing instead.

Remember set and clear have different supported feature set.
E.g. we can not disable no-holes/extref features.

Thus here we want set/clear as subcommands, not the features name itself.

Furthermore, using <feature> as the subcommand wil later conflicts with 
other subcommand like "change-csum" and "change-fsid".

> 
> This syntax aligns with the:
> 
>     $ btrfs device scan --forget

In fact, the current "set/clear" follows the existing behavior, it's 
more clear if you scan a single device:

   btrfs device scan <device_name>

As for btrfs tune it goes:

   btrfs tune set <feature_name> <mnt>

We should put the variable parameter last, not between some fixed 
subcommand.

Thanks,
Qu

> 
> 
> Thanks, Anand
> 
> 
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   Documentation/btrfs-tune.rst |  40 ++++++
>>   Documentation/btrfs.rst      |   5 +
>>   Documentation/conf.py        |   1 +
>>   Documentation/man-index.rst  |   1 +
>>   Makefile                     |   2 +-
>>   btrfs.c                      |   1 +
>>   cmds/commands.h              |   1 +
>>   cmds/tune.c                  | 227 +++++++++++++++++++++++++++++++++++
>>   8 files changed, 277 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/btrfs-tune.rst
>>   create mode 100644 cmds/tune.c
>>
>> diff --git a/Documentation/btrfs-tune.rst b/Documentation/btrfs-tune.rst
>> new file mode 100644
>> index 000000000000..827c92eadb72
>> --- /dev/null
>> +++ b/Documentation/btrfs-tune.rst
>> @@ -0,0 +1,40 @@
>> +btrfs-tune(8)
>> +==================
>> +
>> +SYNOPSIS
>> +--------
>> +
>> +**btrfs tune** <subcommand> [<args>]
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +:command:`btrfs tune` is used to tweak various btrfs features on a
>> +unmounted filesystem.
>> +
>> +SUBCOMMAND
>> +-----------
>> +
>> +set <feature> [<device>]
>> +        Set/enable a feature.
>> +
>> +        If *feature* is `list-all`, all supported features would be 
>> listed, and
>> +    no *device* parameter is needed.
>> +
>> +EXIT STATUS
>> +-----------
>> +
>> +**btrfs tune** returns a zero exit status if it succeeds. A non-zero 
>> value is
>> +returned in case of failure.
>> +
>> +AVAILABILITY
>> +------------
>> +
>> +**btrfs** is part of btrfs-progs.  Please refer to the documentation at
>> +`https://btrfs.readthedocs.io <https://btrfs.readthedocs.io>`_.
>> +
>> +SEE ALSO
>> +--------
>> +
>> +:doc:`mkfs.btrfs`,
>> +``mount(8)``
>> diff --git a/Documentation/btrfs.rst b/Documentation/btrfs.rst
>> index e878f158aaa1..5aea0d1a208c 100644
>> --- a/Documentation/btrfs.rst
>> +++ b/Documentation/btrfs.rst
>> @@ -134,6 +134,10 @@ subvolume
>>       Create/delete/list/manage btrfs subvolume.
>>       See :doc:`btrfs-subvolume` for details.
>> +tune
>> +    Change various btrfs features.
>> +    See :doc:`btrfs-tune` for details.
>> +
>>   .. _man-btrfs8-standalone-tools:
>>   STANDALONE TOOLS
>> @@ -150,6 +154,7 @@ btrfs-convert
>>           in-place conversion from ext2/3/4 filesystems to btrfs
>>   btrfstune
>>           tweak some filesystem properties on a unmounted filesystem
>> +    (will be replaced by `btrfs-tune`)
>>   btrfs-select-super
>>           rescue tool to overwrite primary superblock from a spare copy
>>   btrfs-find-root
>> diff --git a/Documentation/conf.py b/Documentation/conf.py
>> index 1025e10d7206..e0801bca4686 100644
>> --- a/Documentation/conf.py
>> +++ b/Documentation/conf.py
>> @@ -66,6 +66,7 @@ man_pages = [
>>       ('btrfs-check', 'btrfs-check', 'check or repair a btrfs 
>> filesystem', '', 8),
>>       ('btrfs-balance', 'btrfs-balance', 'balance block groups on a 
>> btrfs filesystem', '', 8),
>>       ('btrfs-subvolume', 'btrfs-subvolume', 'manage btrfs 
>> subvolumes', '', 8),
>> +    ('btrfs-tune', 'btrfs-tune', 'tweak btrfs features', '', 8),
>>       ('btrfs-map-logical', 'btrfs-map-logical', 'map btrfs logical 
>> extent to physical extent', '', 8),
>>       ('btrfs', 'btrfs', 'a toolbox to manage btrfs filesystems', '', 8),
>>       ('mkfs.btrfs', 'mkfs.btrfs', 'create a btrfs filesystem', '', 8),
>> diff --git a/Documentation/man-index.rst b/Documentation/man-index.rst
>> index 36d45d2903ea..5fcd4cbc4bee 100644
>> --- a/Documentation/man-index.rst
>> +++ b/Documentation/man-index.rst
>> @@ -28,6 +28,7 @@ Manual pages
>>      btrfs-select-super
>>      btrfs-send
>>      btrfs-subvolume
>> +   btrfs-tune
>>      btrfstune
>>      fsck.btrfs
>>      mkfs.btrfs
>> diff --git a/Makefile b/Makefile
>> index f4feb1fff8e1..9857daaa42ac 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -239,7 +239,7 @@ cmds_objects = cmds/subvolume.o 
>> cmds/subvolume-list.o \
>>              cmds/rescue-super-recover.o \
>>              cmds/property.o cmds/filesystem-usage.o 
>> cmds/inspect-dump-tree.o \
>>              cmds/inspect-dump-super.o cmds/inspect-tree-stats.o 
>> cmds/filesystem-du.o \
>> -           cmds/reflink.o \
>> +           cmds/reflink.o cmds/tune.o \
>>              mkfs/common.o check/mode-common.o check/mode-lowmem.o \
>>              check/clear-cache.o
>> diff --git a/btrfs.c b/btrfs.c
>> index 751f193ee2e0..c2dae0303ffe 100644
>> --- a/btrfs.c
>> +++ b/btrfs.c
>> @@ -389,6 +389,7 @@ static const struct cmd_group btrfs_cmd_group = {
>>           &cmd_struct_scrub,
>>           &cmd_struct_send,
>>           &cmd_struct_subvolume,
>> +        &cmd_struct_tune,
>>           /* Help and version stay last */
>>           &cmd_struct_help,
>> diff --git a/cmds/commands.h b/cmds/commands.h
>> index 5ab7c881f634..aebacd718a7b 100644
>> --- a/cmds/commands.h
>> +++ b/cmds/commands.h
>> @@ -151,5 +151,6 @@ DECLARE_COMMAND(qgroup);
>>   DECLARE_COMMAND(replace);
>>   DECLARE_COMMAND(restore);
>>   DECLARE_COMMAND(rescue);
>> +DECLARE_COMMAND(tune);
>>   #endif
>> diff --git a/cmds/tune.c b/cmds/tune.c
>> new file mode 100644
>> index 000000000000..92c7b9f1502c
>> --- /dev/null
>> +++ b/cmds/tune.c
>> @@ -0,0 +1,227 @@
>> +/*
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public
>> + * License v2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public
>> + * License along with this program; if not, write to the
>> + * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
>> + * Boston, MA 021110-1307, USA.
>> + */
>> +
>> +#include <unistd.h>
>> +#include "kerncompat.h"
>> +#include "cmds/commands.h"
>> +#include "common/help.h"
>> +#include "common/fsfeatures.h"
>> +#include "kernel-shared/messages.h"
>> +#include "kernel-shared/disk-io.h"
>> +#include "kernel-shared/transaction.h"
>> +
>> +static const char * const cmd_tune_set_usage[] = {
>> +    "btrfs tune set <feature> [<device>]",
>> +    "Set/enable specified feature for the unmounted filesystem",
>> +    "",
>> +    HELPINFO_INSERT_GLOBALS,
>> +    HELPINFO_INSERT_VERBOSE,
>> +    NULL,
>> +};
>> +
>> +static const struct btrfs_feature set_features[] = {
>> +    {
>> +        .name        = "extref",
>> +        .incompat_flag    = BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
>> +        .sysfs_name    = "extended_iref",
>> +        VERSION_TO_STRING2(compat, 3,7),
>> +        VERSION_TO_STRING2(safe, 3,12),
>> +        VERSION_TO_STRING2(default, 3,12),
>> +        .desc        = "increased hardlink limit per file to 65536"
>> +    }, {
>> +        .name        = "skinny-metadata",
>> +        .incompat_flag    = BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA,
>> +        .sysfs_name    = "skinny_metadata",
>> +        VERSION_TO_STRING2(compat, 3,10),
>> +        VERSION_TO_STRING2(safe, 3,18),
>> +        VERSION_TO_STRING2(default, 3,18),
>> +        .desc        = "reduced-size metadata extent refs"
>> +    }, {
>> +        .name        = "no-holes",
>> +        .incompat_flag    = BTRFS_FEATURE_INCOMPAT_NO_HOLES,
>> +        .sysfs_name    = "no_holes",
>> +        VERSION_TO_STRING2(compat, 3,14),
>> +        VERSION_TO_STRING2(safe, 4,0),
>> +        VERSION_TO_STRING2(default, 5,15),
>> +        .desc        = "no explicit hole extents for files"
>> +    },
>> +    /* Keep this one last */
>> +    {
>> +        .name        = "list-all",
>> +        .runtime_flag    = BTRFS_FEATURE_RUNTIME_LIST_ALL,
>> +        .sysfs_name    = NULL,
>> +        VERSION_NULL(compat),
>> +        VERSION_NULL(safe),
>> +        VERSION_NULL(default),
>> +        .desc        = NULL
>> +    }
>> +};
>> +
>> +static void list_all_features(const char *prefix,
>> +                  const struct btrfs_feature *features,
>> +                  int nr_features)
>> +{
>> +    /* We should have at least one empty feature. */
>> +    ASSERT(nr_features > 1);
>> +
>> +    printf("features available to %s:\n", prefix);
>> +    for (int i = 0; i < nr_features - 1; i++) {
>> +        const struct btrfs_feature *feat = features + i;
>> +        const char *sep = "";
>> +
>> +        fprintf(stderr, "%-20s- %s (", feat->name, feat->desc);
>> +        if (feat->compat_ver) {
>> +            fprintf(stderr, "compat=%s", feat->compat_str);
>> +            sep = ", ";
>> +        }
>> +        if (feat->safe_ver) {
>> +            fprintf(stderr, "%ssafe=%s", sep, feat->safe_str);
>> +            sep = ", ";
>> +        }
>> +        if (feat->default_ver)
>> +            fprintf(stderr, "%sdefault=%s", sep, feat->default_str);
>> +        fprintf(stderr, ")\n");
>> +    }
>> +}
>> +
>> +static int check_features(const char *name, const struct 
>> btrfs_feature *features,
>> +              int nr_features)
>> +{
>> +    bool found = false;
>> +
>> +    for (int i = 0; i < nr_features; i++) {
>> +        const struct btrfs_feature *feat = features + i;
>> +
>> +        if (!strcmp(feat->name, name)) {
>> +            found = true;
>> +            break;
>> +        }
>> +    }
>> +    if (found)
>> +        return 0;
>> +    return -EINVAL;
>> +}
>> +
>> +static int set_super_incompat_flags(struct btrfs_fs_info *fs_info, 
>> u64 flags)
>> +{
>> +    struct btrfs_root *root = fs_info->tree_root;
>> +    struct btrfs_trans_handle *trans;
>> +    struct btrfs_super_block *disk_super;
>> +    u64 super_flags;
>> +    int ret;
>> +
>> +    disk_super = fs_info->super_copy;
>> +    super_flags = btrfs_super_incompat_flags(disk_super);
>> +    super_flags |= flags;
>> +    trans = btrfs_start_transaction(root, 1);
>> +    BUG_ON(IS_ERR(trans));
>> +    btrfs_set_super_incompat_flags(disk_super, super_flags);
>> +    ret = btrfs_commit_transaction(trans, root);
>> +
>> +    return ret;
>> +}
>> +
>> +static int cmd_tune_set(const struct cmd_struct *cmd, int argc, char 
>> **argv)
>> +{
>> +    struct btrfs_fs_info *fs_info;
>> +    struct open_ctree_args oca = { 0 };
>> +    char *feature;
>> +    char *path;
>> +    int ret = 0;
>> +
>> +    optind = 0;
>> +    while (1) {
>> +        int c = getopt(argc, argv, "");
>> +        if (c < 0)
>> +            break;
>> +
>> +        switch (c) {
>> +        default:
>> +            usage_unknown_option(cmd, argv);
>> +        }
>> +    }
>> +
>> +    if (check_argc_min(argc - optind, 1))
>> +        return 1;
>> +
>> +    feature = argv[optind];
>> +
>> +    if (check_features(feature, set_features, 
>> ARRAY_SIZE(set_features))) {
>> +        error("Unknown feature to set: %s", feature);
>> +        return 1;
>> +    }
>> +    if (!strcmp(feature, "list-all")) {
>> +        list_all_features("set", set_features, 
>> ARRAY_SIZE(set_features));
>> +        return 0;
>> +    }
>> +
>> +    if (check_argc_exact(argc - optind, 2))
>> +        return 1;
>> +
>> +    path = argv[optind + 1];
>> +    oca.flags = OPEN_CTREE_WRITES;
>> +    oca.filename = path;
>> +    fs_info = open_ctree_fs_info(&oca);
>> +    if (!fs_info) {
>> +        error("failed to open btrfs");
>> +        ret = -EIO;
>> +        goto out;
>> +    }
>> +    /*
>> +     * For those 3 features, we only need to update the superblock to 
>> add
>> +     * the new feature flags.
>> +     */
>> +    if (!strcmp(feature, "extref") ||
>> +        !strcmp(feature, "skinny-metadata") ||
>> +        !strcmp(feature, "no-holes")) {
>> +        u64 incompat_flags = 0;
>> +
>> +        if (!strcmp(feature, "extref"))
>> +            incompat_flags |= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF;
>> +        if (!strcmp(feature, "skinny-metadata"))
>> +            incompat_flags |= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
>> +        if (!strcmp(feature, "no-holes"))
>> +            incompat_flags |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
>> +        ret = set_super_incompat_flags(fs_info, incompat_flags);
>> +        if (ret < 0) {
>> +            errno = -ret;
>> +            error("failed to set feature '%s': %m", feature);
>> +        }
>> +        goto out;
>> +    }
>> +
>> +out:
>> +    if (fs_info)
>> +        close_ctree_fs_info(fs_info);
>> +    return !!ret;
>> +}
>> +
>> +static DEFINE_SIMPLE_COMMAND(tune_set, "set");
>> +
>> +static const char * const tune_cmd_group_usage[] = {
>> +    "btrfs tune <command> <args>",
>> +    NULL,
>> +};
>> +
>> +static const char tune_cmd_group_info[] = "change various btrfs 
>> features";
>> +
>> +static const struct cmd_group tune_cmd_group = {
>> +    tune_cmd_group_usage, tune_cmd_group_info, {
>> +        &cmd_struct_tune_set,
>> +        NULL
>> +    }
>> +};
>> +DEFINE_GROUP_COMMAND_TOKEN(tune);
> 
