Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D1C49ABFF
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 06:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbiAYFun (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 00:50:43 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:25172 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239359AbiAYFrW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 00:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1643089633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJVnx2TvG0tVJS7xXbiVCrsTBr71rxVGl9i40jtiHZE=;
        b=MQzORXk7JtYUKIAjfemVhb1pCaxWcTlnY7ml0oFgotp5kBECksacy/5LLd21TxLSYxJ7Jm
        KuIlYXyu8tBiSihnh4Kbp6K2PGrsuKjGB11tDDH92em6v/ardr1GSucf2xnvJPuTyD3ey5
        BkLlfapXvs7RiAYb2mucr+vUdqCP+8o=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2053.outbound.protection.outlook.com [104.47.2.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-ISr9dARrPSWZRo6-vuYMVw-1; Tue, 25 Jan 2022 06:47:12 +0100
X-MC-Unique: ISr9dARrPSWZRo6-vuYMVw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4Y9qFuSYrpBucNTot6tnoa3ZzVq+jXTj72DGtTgO5hn12+KfxltE4kG5RvXTlICdcjLnMJ5m0PPMETH9vD+s+Hr0vzoKdq8L0CAoREYfV8AzyADaGMErkRpJeaJyh+hx1doJUCD3tD6PWp7fxBjaulmMreJs7xQDnITE2JQD14v/PS9IhY6JOJH89hthM2S6JJlyEIhss+tWeNpxPkwmvSc2Z+4t7YgbAJIdAEoUShgey0+Dm+fx99P3gJOgy8M+furL0Dzr0MTJ0cTDhR2TH/n0N+QV2r+9EoRSTij1oJFag4ZawTvGRkB21HIbGDhFKkzs9+X96sWzAH7LrJ5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJVnx2TvG0tVJS7xXbiVCrsTBr71rxVGl9i40jtiHZE=;
 b=RuuxbAelz+hYROQUS0OwQB60AYW9JD9nN+Y7SaRQrCpAx8cvNmh7rupdW2sEj7Jn3r0uRdQ46a1ty+PqEYi4b9Nei40njD7xrjq1/cH5vv6gEV8ldtdUOFSFHGC5JQ49nAYtUxw5uEz9xvzH9Rq8O7pjrQmy+stFScXM9oErJsHfH4eo6bgyQO8yrbZpNgBxJQ6am6Guz8i1zgRnmYitQEFh/2jHa7WnOl9uVETzgksHsCgo89JSAVdhAm8+t+hAsdmkSEk4y2uINd/X3yxoYdFyZCwwxPO31TAqyF+HzdxfK/XBJj6F6BiddSt30wAbP/+V/j8xJB6wwcZ/wvHr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AM6PR0402MB3718.eurprd04.prod.outlook.com (2603:10a6:209:19::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Tue, 25 Jan
 2022 05:47:11 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e%5]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 05:47:11 +0000
Message-ID: <335ed993-09ed-b7f4-9d42-caa25b496128@suse.com>
Date:   Tue, 25 Jan 2022 13:47:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] btrfs: refactor scrub entrances for each profile
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20220107023430.28288-1-wqu@suse.com>
 <12e31a86-79b6-d806-f232-51e9bb0a7e07@suse.com>
 <20220124202411.GJ14046@twin.jikos.cz>
 <232987f4-b64f-913d-c3f1-fe4e2b3c4750@suse.com>
In-Reply-To: <232987f4-b64f-913d-c3f1-fe4e2b3c4750@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d693a10-e89e-4e9b-934f-08d9dfc6215b
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3718:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3718838A12A4A1E6B564452DD65F9@AM6PR0402MB3718.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TeZYrtyMPYEoBvq8qK0+cQq1ZGkDq5gPjFCpddF3ENjOymI7dD+PSWutV84dvdBG5auNQMZbwYt0Dq5NNCEHnJvaIhXUU7KSaqz07QsIRGCxMepmm+XyMNnFIfC492pgA1rRaW635hJgq9wxZAr0xVR8Y+p1zj/WG9Ip0o+ik04krwU/udu7yL02/fcXZVOP6u6fCLOuoE1zIjRkNzkjztcMMZNe5NcM6IYODUMSbpHPpc9O4G0as8nMfbnkvFhqyTMr32vMfOQpfaWxPvakWmz85h1sH1r0OpNqZrKIj5aQDh9/PzYBHlaIJa3bU9t2Wgw6OqsJsK7J4k/esX1xylCEM/T9ihSlto8TO3fpjutyO0+Xw1lQXDHJlARkcSTbgrfm+T+4UjxRpekvk/Uki4JiFvhE9qVE+KGMQpQghhvJUUuwkXRlRfjkJAM2fenneBxNcYR+IzSwZTcbSl8A+ekFMQgiOKDjkybtq2ICnStAdz4SNyMwJF6EnMCZsbL1cXR8RXDp8Kolyh0YfMLp267hDGNmx+cbGDkWUPX5wXrRq4rkTFW1xD7b1IMN4OANQtQi4R7Ongsas9mHj61tvHF2J1Tpmqktabo3TuPDMM16Pr3+uXOCVbx0EaQ3+VwlGq3u/Ay6VW7HwFOZ2mj+BukfRSB5bZJPahiRafpXmenycjWRVMl3JywnZnN3aDnRq1nDFbpogdh7NstCvXk2Zdh2DwevkYP8JnelxrzBAxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(53546011)(38100700002)(6666004)(26005)(36756003)(2616005)(5660300002)(6486002)(186003)(66946007)(86362001)(31686004)(31696002)(66476007)(66556008)(2906002)(508600001)(83380400001)(8676002)(316002)(8936002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anZjZkJLcFYzcGxkK3Y3ZitudVlIemYrRlAwMWV6TTRweHl1dDRYWnorc05r?=
 =?utf-8?B?UTFhTVlGMW1PYXRFQWU3ZjFYTEVXZDFpbnlLSkIweTlRQkJRclBOMUtxck85?=
 =?utf-8?B?YjlNbVB1bFpoYjlLZFZ6MnExeVJPdi9NbDNkVVc3NGJ0MXE2WnRtdjNXUEJ3?=
 =?utf-8?B?dnRwQ3IyMmJzOFFSMllROW9kdStsSXBpODN5aUl0bE1lYkhBRE12SnBFNGNN?=
 =?utf-8?B?ZjJmcjh6MzEvL2doZ1dMbHlHWUtCK3E5dkpwdzBHSDB5S24zc1dDSSt3dGVJ?=
 =?utf-8?B?KzZoVG5QZFZtK3B6T2hWVGhVYlo5Qkp4NXhsMW1kOWw4MVB4eFhDZzREWmp0?=
 =?utf-8?B?dVl2QlF6NStVUVkrQ1pUUjZKOC9MVTU3TG5McXFHenpRc0hBMEV3NTJDMnVD?=
 =?utf-8?B?a2x2alZTYWRGRTRnYjVFeHk1cFVGV3lHblREQ1NhRUJSZm5MS25PL1ZtaG5Q?=
 =?utf-8?B?dWxyRXV4amdFSlpOekZsM3BtUlM0YXB1MTg3MmxidnJvRkcvbm9JRjBYUld5?=
 =?utf-8?B?dXpjNFg2R0Z3VFp3TDJKQWxsemNLd29ZWHBTWTNZVjNOKzFMQnI0djI1MVZN?=
 =?utf-8?B?eU0vZGFzUzQwN0NEMjlEN0xJY0c3TTB6TmcxQjdndnREWWpic2hnL3JYdk4x?=
 =?utf-8?B?SEtRUjEyVmwzQksyeUphVTliaUZacmxkamZuQ3NDcHdtYlRsb0NuMmhVNUVM?=
 =?utf-8?B?eU82elg0djdTUkx4SGxlRzJCOWNYWnFPcjFRcEdZa1hIQ2dOcWZmd2FVa01L?=
 =?utf-8?B?UjBVektybGYwSUp1dTdZdmRVTklDb3NmdnlFa1lLa3pMamR4TS90d3VQU3o5?=
 =?utf-8?B?NkJyeklsQ0ZmV1NJUXNkaG1zTHNlUFpiMHdET1oxU2plSGc5bHE1UjRqcHNo?=
 =?utf-8?B?SXpMUU8xVXcvUmRiREdyVlVvNjd3QXVLRDNDRHRWeXdocDhxSmg1MWtPdXhp?=
 =?utf-8?B?dFIzeUhHUEsyMDd4ZTRuMUZLemtoUlF0Rkw0RXBaMFpNOEdHUEFFaUpoNlE3?=
 =?utf-8?B?K1Bsak9ZcE1IdFA2SzYxNHNCZ0U1Wmd0THBBa2RRYlJSS0crQUFwejRWNDlX?=
 =?utf-8?B?STY3N0lQOGZPbjdSZmgrQnlKbTFvTDJOVUNOQk1CWjhhR25jRktzQWVNbDhM?=
 =?utf-8?B?RjltUnFLSk16ZHNFYng1bk8zczRiNUdodjZZQnk0dmYvTHlFQmdnbUM2SGxR?=
 =?utf-8?B?Ri9nQWFsMzZ4bmgxb0tRM2p0YUMwRzlWNytlM2xkRlR1VFJaR3Npd2JTNXRu?=
 =?utf-8?B?TWEyVTB3MnFzU1ZpUmcyN3JGNTY4UmJMeXVCd0F5eEJMblBDT1ZkbTVFK1Ji?=
 =?utf-8?B?ZmExYWZuU25jeVpLaFQvOFVtNjB1SVNDc2hCMDhacW9EUDZYWmkyRDJZZi9S?=
 =?utf-8?B?R1JnWWFFQllJMHRUcElmOVc3dUVOK05qdzRxb01DWjN6MVpUdldGNFA0SExz?=
 =?utf-8?B?YzFHNXlpTU8wRExHK24rV0JMZGFuQ3RlcW1ybndVUG01VFAwRlJUaEZqVFN0?=
 =?utf-8?B?YmFNRE41ME1vV1hMS05HYi9jdnM4eGNLNjl1enptNlZjZldaUnVNTHFBUnZh?=
 =?utf-8?B?WEs0c0YxaE16c0s3QlVrMnJyWStWdUxpNUM4RUxUOFpldktSZ2M3SzdsR1dU?=
 =?utf-8?B?SXBMdk16NjRjVDFZUGNHc1BZbUszMXh6ZzNvL0w2c0pwRk9BT0I2dmhqYlAw?=
 =?utf-8?B?TVE5SlNteE95NzFFVjM3OHpuSDdTMXB4Yy8zendCL0dhVWpweWJ4bGZIbVRK?=
 =?utf-8?B?NnNmU1dVakx0QjVlbkxlWjhZajdmNTlPUjdZdkM0cGNiTFpxUFUrNXJabFN2?=
 =?utf-8?B?N3ZxZys5Zm5uZ3FGL0lwZzNkWU1GMVJNQ1NuaTY4bm5LOHdrVFNWL1RzSjU0?=
 =?utf-8?B?YmxiQVd1MVBLUlBCY1c1R29vUkM2bFdlWW04Q1FGMzE1OUxnTGwzZnRDcVNi?=
 =?utf-8?B?blVUSEhmaVpEWkp1NWxyakZjclE1TnlyckRiOXJKRk1vc1JKTUh1ZDNJekwz?=
 =?utf-8?B?eGFPOFhFcHZ4NThtTDZDWGxZMnd4NW5lRElBbWNLZmRGMjhlWHAwQ1NyVHg4?=
 =?utf-8?B?MUt0KzBzK0lEZEdwcWJ2cXJDNG9USmJ0eDJ2UDBPZVlOOXpMZENocU45bk1P?=
 =?utf-8?Q?ktTI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d693a10-e89e-4e9b-934f-08d9dfc6215b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 05:47:10.9396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3Hn/1A0A8ghy4/D7uwQXz25ooFGR9yGKqPnExrcYgvzb4FWlXj1XOHBXosOrDYu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3718
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/25 08:06, Qu Wenruo wrote:
> 
> 
> On 2022/1/25 04:24, David Sterba wrote:
>> On Wed, Jan 19, 2022 at 01:52:25PM +0800, Qu Wenruo wrote:
>>> Hi David,
>>>
>>> Any plan to merge this patchset?
>>>
>>> And if you need, I can merge all these refactors into one branch for you
>>> to fetch.
>>>
>>> I know this sounds terrifying especially after the autodefrag "refactor"
>>> disaster, but unlike autodefrag, scrub/replace has existing test case
>>> coverage and this time it's really refactor, no behavior change (at
>>> least no intentional one).
>>
>> Well, exactly because of the same change pattern that was done in the
>> defrag code I'm hesistant to merge it, even if there is test coverage.
>>
>> Nevertheless, I will put it to for-next.
> 
> Feel free to do more tests.
> 
> And even this may sound like an excuse, the lack of defrag behavior 
> definition and test coverage is contributing a lot to the defrag mess.

Well, Su reports a random crash for "[PATCH 1/2] btrfs: cleanup the 
argument list of scrub_chunk()", which adds a new ASSERT() to make sure 
the chunk_offset matches block_group cache, and gets triggered.

So I guess the series can wait for a while.

Thanks,
Qu
> 
>>
>>> I hope to get a stable base for the incoming scrub_page/scrub_bio
>>> structure cleanup.
>>>
>>> As there is some plan to make scrub to use page::index for those
>>> anonymous pages, so they don't need to rely on bi_private to get their
>>> logical bytenr, and hopefully just one structure, scrub_range, to
>>> replace the scrub_page/scrub_bio things.
>>
>> I don't think there's any other potential use of the page::index member
>> so feel free to use it.
>>
> Thanks to the advice from Nik, I'm going to use page::private instead, 
> which have some unexpected benefits, like allowing us to use just one 
> 64K page if the 64K extent is not page aligned.
> 
> Thanks,
> Qu
> 

