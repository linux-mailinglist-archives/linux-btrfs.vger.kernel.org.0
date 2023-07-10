Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D256C74CC67
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jul 2023 07:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjGJFwj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jul 2023 01:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGJFwi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jul 2023 01:52:38 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF2DF9
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Jul 2023 22:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCOEnuqLWM8thWJy8iWxyiF2ufgWOmsqwMdkIBeu505Kxa0/BM2dajltmkslKlkzLOfl0GrLSOwrEQ97lnX3JBgfwd+cmTrVZsJSzrUPBNxWalz+2oVLHCzqRDpmR+9ZzvFwemqNKE1RntnPuz4kwPSwxaUKxmIPx6FH/WL/GD1TnChJU/tWQWsq/iqqAO3UUT+ra+X1CZk/dKZMci5nrDETHeeVKqDNEm0eil4oXd0qcTmtpXrluKIIFShei2AbykdbngYgTYdBi2yB4Nw4RRyaKMrIcBA/Kd3AtxrSuAbjJFgaAg6art5Pj88ykjtj2V7ielSBwtCvDk0v5UwNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lf+c13mspbslsBlGrQaR+1zXU1hxQQKqKA+nZa2PQsc=;
 b=HRRJLAelO4unJHeoET0nKleEI7L7+srfowqNpbrstkqPp9oQ6ExV75BzQJyTAc7DKVKGJp4TnM8i9jy8QB3lvgJDcburGXdb8amIM6hn43vOCF0uK0woanJ8hasj491fGw++w5gG1IPvLiR5F5sfqGBlcsM10B7foWcWZ0SSYmNoEZyhawLe4QM/7VIoXJUnTKNy+u7zA3CxqKFGqFq/JrSbaR28EbvmBMt76Sduk+cp3KfzIelFDsE4Sx9dGL8IFkUzjp3oo4vr5YwUS60ZZMJb8IX2ABT9RPO+rh/KA7eT8bHRNhUZWeZo8zUZSy9QVuzf+IPiFd2tdX18kEdN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf+c13mspbslsBlGrQaR+1zXU1hxQQKqKA+nZa2PQsc=;
 b=FkoOnBM0YP9LRuhya7yzpw9tLouLoSEw0SY8Bk6y+dfGvE2qdEpGROlUHjmxosHNx2SC/dIbATKaJs6C88Nkx95VSNvtlYLBLzzzLWzBk+OQOoEToSlWtLY835gK0bxQzOgA+dLToghMsdhocENBy9JA5Eycjlzjb9InMMBawpaV06YXBhcG3LyVsiyqAmis1scFYgBH566jZBSyrm1PgqqEVr9OyLom3akEKL3qOQcUljw1vEiZGAJe5PjuAxeLbAYr+HieOmg14OnM1RnPAKtCat8uUJ5B7mwVxz5qrD3G6BuT44uP8d0r3yDN0Vsd9+lfRwZZoEERmE6V4iie+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DUZPR04MB9946.eurprd04.prod.outlook.com (2603:10a6:10:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 05:52:32 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 05:52:32 +0000
Message-ID: <49fa58bb-79bc-ce01-bab3-32ba4d97b8c7@suse.com>
Date:   Mon, 10 Jul 2023 13:52:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: add a debug accounting for eb pages contiguousness
To:     Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230707084027.91022-1-wqu@suse.com>
 <ZKf5dDGx0S1YAT6/@infradead.org>
 <6ce97a6a-7068-311e-a63e-c6171321101a@gmx.com>
 <ZKf8Lf0iz2gDSZXg@infradead.org>
 <11964cc8-3415-74d6-a099-23ac80e34932@gmx.com>
 <ZKuXGdWdMlgrmgE4@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <ZKuXGdWdMlgrmgE4@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DUZPR04MB9946:EE_
X-MS-Office365-Filtering-Correlation-Id: 0682cd58-fed4-443d-56cb-08db8109da6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8YeX4tabNaXa0E7gav2a0IBAfV3r2gexvqlELmeyomVCYmEjOjRpbKj3PhfA3xPcV2/G2hJnUltLpxya72n86EOZLwJUN8BnMuote4Z14iUghWS8d09QT/PpBNjO94waL2Qhoq+QPF0InglZZ+VOCh+EqTt46Qou/6nTosvH56qUqs547Zu/eDroAiRyaE5cWZHKc+sm5JEnJTwi688HeU8Lw2svqcxfBH/RrDD/LQsRBP6Ju/iz4Z35k4tor3mCK0n2NlwBYCb11w+OS0PR+mBPRcgBq/LRx8/KUVbUXEU690EkJ+bqWkFNri4mrQ61evaCZ96EpwH6aRPvANLYEAvpESDq4N08VZKbvv6kyotwxh7gpOBiWO9vZWz2Y4mFoikUvmbZWPRzRI2WsbNv948flt7aemEYrWx19Q4yleCGdugx2CzuoYtzYATsOktF0LewXKmZAj1f8DPeQCtXMXLbSWfQKV3U3F9z02iIQTT+MuJX/YKHfAwEEfq5LEiAp1j4EKo5mu3Fiyy6mGIGOnReseb/eXjB+Iq21LUN9+tFQTZgKA885+3ORm4TkCLvBnmw03WEIIpFsD6ZSXGp2hssXlcrymafReaGcIXMJcbjV1489WDxn5VEILhMzprBoPPcZzgSUxE6txPPoaCiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39850400004)(346002)(136003)(396003)(366004)(451199021)(186003)(6506007)(53546011)(2616005)(6512007)(83380400001)(4744005)(41300700001)(4326008)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(66476007)(478600001)(66946007)(6486002)(6666004)(110136005)(36756003)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3NCK0VoMkNQQTV3S1gydGNSQTZOdzh2bmkzaTA5MDhOejR6SXBENVlRZHNa?=
 =?utf-8?B?TlFsTnl0dmhxMGU4bWlXeG4rYklGV2pweWtIaHdSMXlzMFVTaW9jTGt6SkZx?=
 =?utf-8?B?cmh3R1VRaTBqdGRiWEtPSDdtK1hBaUdmeWp0YmRHNFlHTVlCOU0xWFB1eDdI?=
 =?utf-8?B?Tk45Z0JPRWd0ZThVQkRYaW8velpzUFphR0RDSXdNWFF6cGtBdjQ3bUoybUtJ?=
 =?utf-8?B?SEpUM09aR2VNZ3lacEJMOGNiV3kvUkJMbXB2S3Nuc3lBTEJSdHF4dnl2dFR4?=
 =?utf-8?B?bnV4R1VBaFdKbzJ0TERXTXBiSTNrZ3dPTkRXdUtzNE5wSWRqVTM1WHZiN1oy?=
 =?utf-8?B?QjZqc0ZlZ3FXS0ZySmZLMk9XQjE4K3p2cFVkSW03NmFqMFZuTEVGTTFIKzF4?=
 =?utf-8?B?QWhQZ2EvN0haVGJYaHB4bE1TMzVpOEVraUJvMVdNbHhkSFl6TDZ1eVZsLzA1?=
 =?utf-8?B?SUFVblZKZmxxdU93UXBzeHVXUVJyZnFKOVZvbVk1QlJlRTVyUE1wUjFqRlQw?=
 =?utf-8?B?dzFLZmRyKzRtMStIclBGNDhPSHdIRk53c1Z1UDNXSVpjRWFweGJnaVoxRkFN?=
 =?utf-8?B?RXpGT0RaVm9kcjR3eFl6L1B2OUpqSGg4WG42VHdGbXdkb2JGRlIzMnRFUFc3?=
 =?utf-8?B?dStXS3VDVFIwN216Zmtoc0lkYVA5RmgzSFBLbUNFUHp6YXBsTmxCNG14TE5W?=
 =?utf-8?B?UUtjSmpnQmZZdTJCYUM3MHUzaEsvTWJ4TVV3VHQ0ZVBwWFJEUWtZZWt5Nkdo?=
 =?utf-8?B?ZTE5eHhmV0kzRDFIWFVFSGcxdytCSFFvSytLM1hvRlc4Q2RDSmswL1M4aVJ4?=
 =?utf-8?B?OVk1OTVlSThWY1V4RWltbERDR2NJVGNxeDJHMWM1azl2ajNIRThxQXhnNHF2?=
 =?utf-8?B?cDJYS2xFWjNTMDlTZ0t5TVlKd1BnQ2MvSnlBdXNNU21xTFdJZ2JuaGtDSzBI?=
 =?utf-8?B?Yk82d0MyRVpzRWw5UWpYTUtqbE0yeEhXZ3NGdXFDc2tVKzFUNWxGTHIrYTQw?=
 =?utf-8?B?RWdLWGNqY2c1WWJ1NXRZa25IZUswVDN4MHNOVTJFRXNtc2t5d1BRRlRXVHNF?=
 =?utf-8?B?M3FndG1WeVVkTmZHNlpDeDhPRXRtWmtYbmExaWpuNFFOelZxWmFFYU9vS2pO?=
 =?utf-8?B?cVl1empVQm9Kd2hzTkFjNG5SeTFiallZaXpnS0hMUFIyUC8vZ3RIUHpLU1BU?=
 =?utf-8?B?VWVSdUZGNFN2b1d3ekNtSjE4SkRQN2kzUExNMWxOMUJEdnoyS0JCNGFBREF1?=
 =?utf-8?B?ZGxYTHJLeUpjcmdCd2V0dWJGMldYNkFLbTJidFg5ajQzb05henQ4VGR0UUxV?=
 =?utf-8?B?cnpJRk5iV3BoMVBUTzQ1MldLdnUvTHZGeE55UWlHdzJ4d2xxSVIrajhnQUhw?=
 =?utf-8?B?a2tldHk0ekhIM1lrVC9pUzFqRkVOWGpoSDZEckR4S1NLV1VNTWxPd3JWMEYz?=
 =?utf-8?B?WjBMV1VJRm5MaHpiNWdCYkZGT0xkOW93T2paYlM5N1VIcEg1UnBnZFAzaCtB?=
 =?utf-8?B?T3lFZ3hGbFE1N0FyU2Fob2Mxb1QvdHExRU1VSHFpRUZuWEEwL3NqcEplOU5R?=
 =?utf-8?B?eGtlN3Rrajd5MkkwZ3lpMDR6NUVKYUoveEhpNTF4QjdOTXlNZWNtcUhRTjE0?=
 =?utf-8?B?bnJrNURoWlNMazNmN1h6ZzZEZEk2WVV2cTBHZUdjSzdidUJnSWhXUVRtaFc1?=
 =?utf-8?B?cVJJL2p6Qk9BOXFhbjJ4alNPYTF4a1F6d0JyZ242RlhNdERYU2Z6eXN3aERJ?=
 =?utf-8?B?SjltdUFTSUtGWWl4SjlsVXlNTWgva0c3cUhZbHZ4RUdYUnpLNE0rUEVzNFY0?=
 =?utf-8?B?Y2pMajZlYlF4dWZtS1JQblhTaGkwODNGTkE5YU5oeitNV1NKekI5VzI1d1Ir?=
 =?utf-8?B?aXVtL0lObU8zMmNUMVFQc2Jzc3lYYndyMlpyL2lYZ2ZxSXpRN2RkeStJMGo5?=
 =?utf-8?B?aEcxQzQyclZhR24wNEVHUmp2UVI5djlwTzMwS3F2UDBnOVdmNkJ4S3I1Mlp3?=
 =?utf-8?B?TUlpOXM5WS9JbWVpVUM3dTEwWUd5VDlHbDJQRWllOW8xRjg0TlNqMkMwYTU2?=
 =?utf-8?B?ZkhkM3JzRkJtWlBJeFhwVGFuVW54S0JKZTQvRjdRVVJVbWtIbnpTSE5oVWRh?=
 =?utf-8?Q?ThOKZETrAt2sWNHVA1gJqQyNR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0682cd58-fed4-443d-56cb-08db8109da6b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 05:52:32.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X1TzjVzsdrkxzGbdyyVfeQbckpgSKEGHYmnRAcu1chjJS4d5ccMe+FSHyQmcNXK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9946
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/10 13:28, Christoph Hellwig wrote:
> On Sun, Jul 09, 2023 at 12:44:33PM +0800, Qu Wenruo wrote:
>> Unfortunately __filemap_get_folio() is still only creating folios using
>> order 0, under the no_page tag:
>>
>> 	folio = filemap_alloc_folio(gfp, 0);
>>
>> So in that case, it's really no difference than find_or_create_page()
>> for new pages/folios.
> 
> You're right, willys patches to pass the order haven't actually
> made it to mainline yet, and I assumed they did.  So you'll have
> to wait another merge window.

I'm considering another solution like this:

	folio = filemap_alloc_folio();
	do_something_with_folio();
	ret = filemap_add_folio();

Which is not that complex and pretty much used everywhere in mm code.

Although I still need the old per-page allocation as a fallback, which 
may make it more complex than expected.

Thanks,
Qu
