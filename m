Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8330F44A010
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 01:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbhKIBAD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 20:00:03 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:27883 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236348AbhKIA77 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Nov 2021 19:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1636419434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eW5HjdJlUplkX17miPSbF4qVSD5s7I17VeRo5pBvdho=;
        b=NmZALRWU6coa6zHzd6kDTiUetz61trs0PewbjD8QYqUnw4p3+1LWmB4HBnanN2xvXZAq5m
        GiN6zMz55hZQ6xeIeOHmYqbYasJnGnEAwLuj6fyKe6GYd7vUeUMCzcZIAs06uTIpwEcZPc
        K4ltOzQv8roua/mp9KlrOfo72zQ9588=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-YNmUWTJkMi6Re-8FNiMUbQ-1; Tue, 09 Nov 2021 01:57:12 +0100
X-MC-Unique: YNmUWTJkMi6Re-8FNiMUbQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDb4yajSayNUEQgWOlHeeragCgSLpX6bOnxOoPJfifdL8VcQD+dtFCr7CQLCLukC36FyoEmNQIJvEtA6TN5vzbGfQ7JybMUdBwRK2psFXtSTn4IAn5gpWgI/nj19ts7T1r3WJBMnfxIFC1ayMYx4OKKOhruZrjlHh2YzWBSeEOWttXIR9oWztLKCNYvJkl5ZBTJ/ecIfXZcS+3124yBOH5YqnPoN/W47V0k5EDCi0h6uxRYhwSpqWIE8e0pd+lFKKSIW22ABSILdtld9jUPp9I7o4bKXKp5ydULAoailp3piLy0dqSvIGyFnt/+cRvHes8UyOL4QIqxs/fky3lWQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eW5HjdJlUplkX17miPSbF4qVSD5s7I17VeRo5pBvdho=;
 b=Wt/M1RFJfSXPYtVJO8fT5MC53sGBNwcqcrHhXclrDknG4lHUyftpIjwpjmCqCacwWb6IJHK90D4P/04ojxnt/xiuY+DRwFKHhzXkpI3fzWpZTnGhyxp/awogI9QfB4QAbAigiRVFDqeqh60YxVG8VV3FuAWTcogtMdBzm9K1hCMcFVUgjgXBHbSSo2aoYC2qCPfAMbMn92Ti81q8DxzLLhT8uh2L4NyCubBfMjJJp1goqL1QeQfiyr1viMsZIQYBPGCczVArxFi7uWYMPGo4cgiPSsvQsVLOpXm2py3IUnJVx4koBS1JlQ7ESH1PYgE1atSkrhc6C2MgNx28c90ANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DB9PR04MB9283.eurprd04.prod.outlook.com (2603:10a6:10:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 00:57:12 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286%9]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 00:57:12 +0000
Message-ID: <84af2938-9a94-8611-1d34-c8ec3b7683c1@suse.com>
Date:   Tue, 9 Nov 2021 08:57:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 12/20] btrfs-progs: mark reloc roots as used
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <1da6c61af04c10b8a7e682676121e1031753fe69.1636143924.git.josef@toxicpanda.com>
 <1e61296d-58ba-b45f-a38b-b1da9e9962a8@gmx.com>
 <YYl2/prrZaLZPu1w@localhost.localdomain>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <YYl2/prrZaLZPu1w@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BY5PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:1d0::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 00:57:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f563f4-e018-4a48-6403-08d9a31bdd04
X-MS-TrafficTypeDiagnostic: DB9PR04MB9283:
X-Microsoft-Antispam-PRVS: <DB9PR04MB928365F1A6ADBB5BDF379547D6929@DB9PR04MB9283.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kif+jyhk24F3cTTriUAd8CUc/bEUB9dO9dOfh6pAoqWNEgnbPKYZAGZkOzt8mZ1sVoLJ6W3kr6Du/df8QFR8IUA+frC4PCtOkbIoW0vEiIyBwC3cj67zSKSN8FP6aCjMVd1n6xOUDoygcaqpHQ46C0Sj/ojBHh9K5dwDeiAjbkzSXU+/sHU87Z0i0zRsrWtYrquldb64ymobTNasDOq5IcdPSBQvkNvVcuSuZCZF3eDfTDMoavV7phajVDVfPdmIwAQkWeB09Zx8i5lvYsmtoUfzgMk4YnD3umGBR+wNo01mJiucAqdpwmwCqR4eZxbXeHOEmCrTYNyH6egi1vDaRNlc3ZapPmbnWUaBEbH2NMm6PFXYvRi+yfwzlxsvYJnEQbSHDmNIUheTdTKaE/L3HQ9PP8USPHFyLencdPEZi715BDTJgzdYoiNQ40/q8vf5uc3XaPYv0+EHaueE0jNc214v02+S62UY+xc7irIVREiPgdzxYD2DexpYX5w9WUM2cG5KbBYQ244Cd0JUnKbNVq2qMcx19KexHDoxZ4fEZTYqKZvWTclQSjb/JhoT61fGj+jRlAM8UBoaXUvXEgAW99AANY2Q+/l657n4r6W/xWbsxlNj55sOFgoqAQVqiLDnoaUggPj/c/KT7N5DcgitSDrPiugg54Qrr4nEhZVY/X6ZSRnChbkArB4yJlgyBj3FodmpiTz1j3UJw24WHvGqjuZE+USighMx+ivod8e0mC/bWBUdQ1N3pprq9ItVwffl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(66556008)(8936002)(6666004)(66476007)(508600001)(956004)(26005)(4326008)(53546011)(6486002)(8676002)(66946007)(6706004)(2906002)(4744005)(36756003)(316002)(38100700002)(16576012)(5660300002)(86362001)(31686004)(110136005)(31696002)(186003)(2616005)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWl5cmdYd3c1M2NvbkpMOWZ5SVZkQlFGRU5vUmJzVGo4NGEvYzBGL2ZrYWRF?=
 =?utf-8?B?R0VCODVlUjhsYmIya3RvZUhGZlEzeC9SS1ovbE5qY20zRWJxV2JZamZSNGI2?=
 =?utf-8?B?dHNBbEttQnZwOTNIcVRMVWY4Y0RWRm1aSXBUbFlPemVCV3NrKzdCTlVmZ1Ny?=
 =?utf-8?B?ZW1qeXB3SUdBZFZxKy9KdEQ5MWRzbXhKMThFUzVDV0VoM1RCK1QzRFdQQ0pY?=
 =?utf-8?B?MGFUbk5IN2RjSkZudnU4b3lCbksvRXNoVFBXNDdVWGdNbTVpL2E3YW41MTRD?=
 =?utf-8?B?S3ZGck4wazQxYlpPZ2grQU11V05QcXFOVWdQY1hTMGJ5WEFoSTFlQ2hXbHRo?=
 =?utf-8?B?NkNTdnpZbThjdUFjMzdLaTRVVmpWUzc5MDczdjMzd1p4U2NoT1JRTDdMNFJl?=
 =?utf-8?B?SXFOSStGZDBId1JDSlhMQXJCSXErRGdYTTJrSG1Yai9Rc010SmNpS2NQelFO?=
 =?utf-8?B?RmM4MlBzcnZ0emE2S2tXenBEdFpocTBIdjV1ZnI3b3hFTjVSQkFGVUJNbHZG?=
 =?utf-8?B?cHBGZkJKZ3ZHd0VMTGJMVjZiZzd5dlZQTXkrTkhUVUNINkx1eVhDbm8rSUc4?=
 =?utf-8?B?RVd1SSsyZ2FycUxpUUxhOUdzc1FjVWxUYjk3bTFzNHU3OUVzVTFPTTRvQ245?=
 =?utf-8?B?cEw5eGgyS3NBOWdWTEtUVHJQYldLTXVvQTczeEV6S0FGMjBwRElLZm00Tm9x?=
 =?utf-8?B?MXRjU2h1ZVdOWkhRL2QxYng1a1NDakpXVy9SZFB1Y3ZqMHIyVGUzMjc4dUZB?=
 =?utf-8?B?WXhuRnA3RnVrbEc3SzFTSld4R3hUdTVtYjcvaElsb1YzTDI5amFxcXdtQ0tn?=
 =?utf-8?B?elVjdUVDaTZvQktBdnp0cDZNZ1ppOUZoSEljZUJsMDVUSTlHdlhSUTREM0dj?=
 =?utf-8?B?MmdLNG5DcTRPZHRWSUpRSnZXSUVIcTJxck04eS9lUzFTZzBIRDl3RExhY2pU?=
 =?utf-8?B?ZzA0aHMydmVoN044cHJYTWplenR0dDZLMkc2MmJDNVI2K29sOW91NUVRWG52?=
 =?utf-8?B?SUVOTktnMGVsMGN2U0JHOTRoNERQeGJJZXF6R29PSHBKNmcvWE9Va1NJekRs?=
 =?utf-8?B?VnIvQVJwMkY0WHErZHpJQ1pCWk16dllPa1BIU2R2U3F3ZlU1ZzBHa0xXRHdj?=
 =?utf-8?B?QXhHcWxtcE1oeUZ3UW13aDU4Q0FDV2llOTJXYUp2Vk1pYUMxRlFqeUFaZURS?=
 =?utf-8?B?RTI0UkttVzAya0RJZDQvOTA0VFlRUE5jNDlvQ3JINWorUHZJNURONS93eXlE?=
 =?utf-8?B?d0srZ0FQc0hETnRhTXRCekFiYWxxMDYvSmNocHZUQVJGSytZaEdLbkdOWC82?=
 =?utf-8?B?WU9LMTJGOWE2L3ZuUERoQ2NRZ3dUeVBuQmxGM2gzL2RGMjRma3MxUnhoVVRu?=
 =?utf-8?B?NVB5eDRKNG9PM25hRm04SDhkL0hGZzFZQk1rUjVGZ3BYMlJ0NGliZUlBWm0z?=
 =?utf-8?B?eDRVUlpuTjRxdlpqVTNuNi9aR3BEdjUzaVpIc1IxSUVxbW5NWk95Mnlrdks4?=
 =?utf-8?B?OUhlOGczY1VzbExWUVE5KzZxWkk3Yld6My9TR3RCTlZIUFBJUno4UlBhMHdM?=
 =?utf-8?B?NG5JeDFMRU1yeTNoaWkyTzNHeVlFNjNvOEdkWFl6NUZycllJTGRlRGQ5NGJC?=
 =?utf-8?B?SzF0Q0wyby9YWkgwa0RlUzV5dVQwNXNwbEhBcU1qZ0lhbG9XaTR2YjFpMitz?=
 =?utf-8?B?d2M4eHFmd1FOUUZYVmozc3RTVjlWZ0Z5amJ2S1ZiQWdFbzVjcWxlN2dneDcx?=
 =?utf-8?B?WmVlWUlIVGZzZ09KT1NzK3VHY0lpOHpuUitIZWROOHllbWVXelVPRGJoRHc4?=
 =?utf-8?B?YkFoeDY0c0k1anV3aEw1emZlc2FGdzJMSW5XYTJDSnJOWnczZXlGZXRGVXNY?=
 =?utf-8?B?dU51M1kyN3RIWnFhS2dCYmY5ZzhiT056Yi9nZlFkenF5aUZ0Wm9pZEtiNCsw?=
 =?utf-8?B?TUQwTGg5U3FvMEhTWm1qQWt3QWgxbUlkaDhIUW5nZk1CdnhIYUN4V1h0ZUNw?=
 =?utf-8?B?WkZoNFNlRnhnNUlkVEJmSDZMdW01N0t3UFZQR3g1blN4cHFoVUw2Ykk2TW1a?=
 =?utf-8?B?dmJLWmNTTm1qcnFGaUJDWTQ0ODh2VktwTHhiU0U0c2NYcEVCSmpHVFQ3QkVN?=
 =?utf-8?Q?mZd8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f563f4-e018-4a48-6403-08d9a31bdd04
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 00:57:11.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzixVsP2R0E8zmMf7uWBbrrDTu8zYjo1zLd84qjWgScYZw7RkacWRQ36gi9L1Fxi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9283
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/9 03:14, Josef Bacik wrote:
> On Sat, Nov 06, 2021 at 08:39:23AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/11/6 04:28, Josef Bacik wrote:
>>> btrfs_mark_used_tree_blocks skips the reloc roots for some reason, which
>>> causes problems because these blocks are in use, and we use this helper
>>> to determine if the block accounting is correct with extent tree v2.
>>
>> Any idea on why it's skipped in the first place?
>>
> 
> Yeah I added it apparently in
> 
> 439ce45e ("Btrfs-progs: add --init-extent-tree to btrfsck")
> 
> because at the time we didn't deal with the reloc tree properly and I was trying
> to unfuck a users file system.  I'm going to say that isn't the case anymore.
> Thanks,
> 
> Josef
> 
Then the patch looks fine to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

