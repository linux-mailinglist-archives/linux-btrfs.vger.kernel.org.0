Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DED6EF382
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 13:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbjDZLkt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 07:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbjDZLks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 07:40:48 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D4D46A6
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 04:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyPEVi1Hh6JDLY5k/3Y4jpdxZad/znZjmGTGMZhjJPmHwMhDE2+mJMMwTkqrq8oBY2Jd/r0BiAOS/QTm13XSNR44rvXRVdCgBGgHx+kntym8DA2NuKxxUmtW8O4sYk4trpspOb2hzrHdQIIpNzHCO/JspPlTAkUqQ6CfXMezBBXVviPmohKoAgHiioBkebWo5aL7WhbIm3Syvwc6TNsceMpL8HTJXMcSGQWm1d0s+pa+jvIrY2HW5Kxaa4jPIvVwMWLp1cVE3Gf3hTkze8Wbsg8oTZx6/rSuHaVbLHu1w1ZYSfOiiBIjFTaxJUFyZQlvrDNzgVBj4Mt6/FTZBZjxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uOV3R8SKfevxHBItxwAqKozYhk5ZLMYWl/s7NSlqAc=;
 b=XRVRXpI8VUqoFxkRbY6O755ai18Cus9dOOq0jp6Z8KWsm5YOxxW6F2eQnXxwjc1V07AS/c1557+/CCLneCBzivU9ous978uuvqxxQrDw2DJTOGAK/DBB5a872CbGFaIf+7yRyedXUdLIWRAKRG+Vc6pB78CiZUOUD71ul1ZGr6vb7TUkeJQZP4WJNUnMZKBQxrMKPAnO4LTdHONWymtqQOrH1lGSgYX3CqN64Dp+uJmwrofWKzXmOlfVpDw5M1n1ket+DvscLSxWHOg9lCf5yiuimFoaPMqCqryJlm4bDcO0PcNzHDFp3nznpEfS6qk+Fh3ePj1FgOOlQbaqGgT8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uOV3R8SKfevxHBItxwAqKozYhk5ZLMYWl/s7NSlqAc=;
 b=LhbLoqqSC4EYXvlIk1lz9va8ZFGXEsqrcrJCZitRnCnVQnHCLOjFH2WrjTAxVS02UPZyejQf7il+hpFhNBgYkD3ky/RZam3ZHFtIkRxIyYxWtFEq23heYC4wKSsqJE981aNK/H49MJ7ODD2c+nXTnZS0PNTbBiFUl0064w2kFNQoXBTN2FHm9BgckINdKiRNpWGFIj9vsWxVc3NwAUGQ20nXN7yqzVmm6ZvWINRtzgE/DaXHvgQPyIAYbwLNz9HbE/HfI07FEDDvQ4WfnBSLr0/hnyUCukLIlnnXjgoeTxaKyRGvRs78wWaVVSwkIEZf6KQFbobakrKAaLQ9laU4ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU0PR04MB9321.eurprd04.prod.outlook.com (2603:10a6:10:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 11:40:43 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 11:40:43 +0000
Message-ID: <6377fb9d-fec9-6c2a-1f38-6ffd775eb773@suse.com>
Date:   Wed, 26 Apr 2023 19:40:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] btrfs: print extent buffers when sibling keys check
 fails
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1682505780.git.fdmanana@suse.com>
 <14f4089a9d26606c7a15e398536ca75f9c484c9c.1682505780.git.fdmanana@suse.com>
 <84ed9592-ac1e-8344-c0f6-4e114b2835ec@gmx.com>
 <CAL3q7H7B3Cyn9RXzT24u+x2hjgmWjNCrMBJ-WHjGP5Cs-kUFjQ@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAL3q7H7B3Cyn9RXzT24u+x2hjgmWjNCrMBJ-WHjGP5Cs-kUFjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::24) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU0PR04MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 096f6c8b-8b06-466e-5235-08db464b1192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHHJ4/NkjOxK+hlWqdy90OM7N7jaW56PFRAvI/yj3ModB34B71DNpY9MyhTZhxsqTJ0qYVs/ZifDCTBbfIMsbOgQG67imwHSkF+eea9Q/5+V9S42G8Q6GIop3ApRqCNGhFnWjGavMeDwvOFPmeHENvSU8H31BPl3Z3O/2yVMEG//bcfqqU3SaZIh0fWljpIMehNfQQ2j1L6mqZvttsDvH52TzHR/ybKIArQM6GlRTzJLq0QOnxcU707it3LabRAJ+SZxHhTgYAWt/rNMlfqzi/JF/OHEWVY9y93igmne7iIs86TCqGTClCafgMyh5GQR1uLAmzANxlr6xiaQpdNGIOyovLavG+43DTPyyvr4xP0NGs/hwB6VyG0p5beRy5m4S39k4jzarpaGqdJY5Dty/HVu4/U8N3T7+McPemeXH6jodu4bg2J3IHvoBVUaq7k/BAbRmsjB9VAwd0hQ130BjCPZYjgSb0FUd3DwF78M0hUuxPccRKyeGoBCKQ7nkP0R4igW8Wg+LTXN8exQKpiQi75UPgd3ds/PPJ/9wyRBVEgQSa/FF3BsjwVNkK59urCpOSkg5jtGKQvCH8MUZ7bNlse3KZHmKvlLVL80R+xPpJbkS9SRaNZZ26BbBAIcPpq85YFnA7sPPd0Lx+ALA8+H50yl25m/TNbnBQyfxcnhsro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(36756003)(110136005)(478600001)(316002)(66476007)(66946007)(4326008)(66556008)(2906002)(8936002)(41300700001)(8676002)(5660300002)(38100700002)(186003)(966005)(86362001)(6512007)(31686004)(6506007)(53546011)(31696002)(2616005)(6666004)(6486002)(83380400001)(66574015)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHorMVJ1LzVnYU5OYitTb1ZoVzJhS1pCSTdiU01JVDVSNjNTZm1mWDYyalh6?=
 =?utf-8?B?bjFVa3dJQ0tLSzR1VnFoMWltS2hQdllmV3UwQlg5aFFmeUpSSEkva1l6cmF6?=
 =?utf-8?B?OFRYdVVITzY5L2FKOUtPS1FPUWVBcitxWkUwZFlhL0dVSEVoMWhBN1dKTVFm?=
 =?utf-8?B?bFMzS1hNbVltM2tJWnMxWjNkdXk4RytxNGRBb1djc3hsYmdtWkMzNmtUQmhR?=
 =?utf-8?B?alFZT0VVSEVjWTVNNm1ZU1BYUHI1N1ZSdk9FSVkwejRkUkpSdzJ0YVh0NCta?=
 =?utf-8?B?S3I2eDhKQ2U5b2RxY2wrRjlrVWdzSFFQMUJFQ1AzWENYMkdBQzBJQ1JrUDVR?=
 =?utf-8?B?ZXQ5czhEa3d3VE1uRzVpSTliNVNodFdRNEZRaExqUU9CS2xPcUpuUlpLd3Nm?=
 =?utf-8?B?UDZQYTFGUEFBdkRVUWpFRjRsUkRWaUJINGNZczgvV1JGaStmZXBWUVV0SG5s?=
 =?utf-8?B?bUhQK3FQekxNWVR4QlY4OUpMWEVaRjFvZ2Q5MzlmRmdXbEVsMHZtQitjWk9H?=
 =?utf-8?B?a0Y1ZnMzdExqY3ZMMXgyY3IxcnVDbDlSUEg0M1Z6Y2JqT05uTUU0bGVBWXpW?=
 =?utf-8?B?VmgwZmUyczEvRitvS0pwK0R6ZzFadW0wMVlac2k2d0dWVHlMZ1IxQ1BPNElp?=
 =?utf-8?B?bm8rS1pNMStJRjNyNHNTaUdsSU83MkQvTVl1Tko4U3htTlExTytOb3NpUkhS?=
 =?utf-8?B?TWNnRnBpcnNYQUtlMXpDQ1VtMDRyT1F2NDVsRW9Ua1dXTnJaRmMzOGd3enND?=
 =?utf-8?B?NStycndCblgyMGxWQ2gyRUluVE41M3c0ZGpXS3ZzUUtMSzR2MlRzbzhHNDhJ?=
 =?utf-8?B?VUdMa3d5REpXT09sNmJFekxtTXp4L2lBVS9yOGJVSlovN21ralRsdk5BM3Fw?=
 =?utf-8?B?VnMwemNpRUt1TTgyaWJnNlArakgvRlpaZjVUUEoxMDRLeFF0aDZzVTEzWEhz?=
 =?utf-8?B?VVV0WnBKRXRzM3NTRjh2Ny9CU0FWNDdSNnp1cjdhUUljcEpWVXNQUEEzZEFi?=
 =?utf-8?B?N082QjdVRitHNGtqek5GQnNjM0JSUlNGS2RNK0phTFF3Mmc3UnhvSnVEVzlR?=
 =?utf-8?B?SHpVOWZHa2ZqYm8vQzhwTlRPZ0dUWm1YTUFsdGdqOThnWUpROEZEeWFtc2pm?=
 =?utf-8?B?dUY2N2Q0L09CTXpMTHBFM2tvYi9ZRVpSZUtuVlJNcHJSY25xbWNQYnBIRU9y?=
 =?utf-8?B?S25QaVNKd1Znemo0VXd2VUh6R3pSMmd1N25rdmM2VkpTT2NXUVhVY09zYmdl?=
 =?utf-8?B?cVd0YTdyQnpsbDFFYllqMk9QSUdDTTNGT1MzRUx4VC9xSklHMHJYeG5QODJV?=
 =?utf-8?B?Vll2K0dxSkZETmp0TjJlcEV1SWNDdittRlFFeTBVbFF3eVZDZzg0czhyQUNj?=
 =?utf-8?B?T0tEOXRUVklxa3l5MVllMGFEclJsTVozaGE2MWZzUFZHdnF3T1JIVDBPbm1D?=
 =?utf-8?B?L1Nab0lISUlydm1Qck5odm1pSWJ1bEEwNVRjM203eHpYa05XTXZBYUhWc0VZ?=
 =?utf-8?B?aTJEUTFzNHRPWWsvZU9BU0VUT1haRmRyNXZIeWZadCtwMWlpTitJTlJ4L3FJ?=
 =?utf-8?B?Vm1ON3lvME5xTExyNXVWQzY4RWFGQml2UU9RVFFod3VwSElydlhUcnFwMVJW?=
 =?utf-8?B?MFhxdDQ4aE14K0ZoY1ZyRG9jNW1tTkJYTVdOUFlkTG1OQ2FFbmV1TUUzSXZ0?=
 =?utf-8?B?TEJtMGZxMWxlQWJFc0Z3L0FwRjhtZ1dtcmhqNTl1UElqcjZRKzhoOEpaYk1V?=
 =?utf-8?B?cGdMN3h3UTU4aGJEb25HYkNDQVlrN29lL0o1SzFiSkF1a1o4Q2s2UjlLYWhh?=
 =?utf-8?B?dFF5d0lXTDBrQkZ6K2lLUENTVHB2L0tvdlc2NzF1Y290dzV0ekl3YUMwUmJC?=
 =?utf-8?B?dVlFeGIzOURNV2tOTC9sem8xWFBpKzJxVkFQU0xRbFF1VnRYRFRJaWZMWENL?=
 =?utf-8?B?TkVwdHc2OTFSN1NWVkJpNWMvNmcxUExJQUtadVM0bkVBT3kwZFhIcUNHRFJi?=
 =?utf-8?B?eUVUaXk1c3hPcTZ2TTJUZmVmOURITjlzbUFOamRvbC85OFlITzZQakI3RnBh?=
 =?utf-8?B?Y0tkVGNGMkduOVdiNzZlZmp1U2R2Q2N4bjZCRHN5am9mNzlGKzdHclg3bXly?=
 =?utf-8?B?Tk82cjFtcWdvZ0E0VHlvaGd4c2FaVE5CK0VVQVJwOTBQWnVDdWI4ZWJUTnVu?=
 =?utf-8?Q?n3gfy7ndHSNyOYHtkGSnkyc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096f6c8b-8b06-466e-5235-08db464b1192
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 11:40:43.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zam4Uh2aqj8CaBhz7CUIpCxUn1Xo46p6iRr9b9QB5K/eye8TxJT1ArYAIIYJvcTB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9321
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/26 19:31, Filipe Manana wrote:
> On Wed, Apr 26, 2023 at 12:21 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2023/4/26 18:51, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> When trying to move keys from one node/leaf to another sibling node/leaf,
>>> if the sibling keys check fails we just print an error message with the
>>> last key of the left sibling and the first key of the right sibling.
>>> However it's also useful to print all the keys of each sibling, as it
>>> may provide some clues to what went wrong, which code path may be
>>> inserting keys in an incorrect order. So just do that, print the siblings
>>> with btrfs_print_tree(), as it works for both leaves and nodes.
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> However my concern is, printing two tree blocks may be a little too large.
>> Definitely not something can be capture by one screen.
> 
> What?
> If I check syslog/dmesg, I can certainly access hundreds, thousands of lines...
> 
> I suppose by "capture by one screen" you mean a screenshot?

Yep, mostly a phone shot of a physical monitor, which a lot of end users 
choose to use to report their initial trans abort.

E.g. 
https://lore.kernel.org/linux-btrfs/f057bdd1-bdd9-459f-b25f-6a2faa652499@betaapp.fastmail.com/

I guess the reason is, if the trans abort happens on the root fs, there 
will be no persistent log files anyway.
(Although it's still possible to pass the dmesg to another machine or go 
netconsole, but not everyone has such setup ready).

Thanks,
Qu
> 
>>
>> Although dumping single tree block is already too large for a single
>> screen, I don't have any better way...
>>
>> Thanks,
>> Qu
>>> ---
>>>    fs/btrfs/ctree.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>>> index a0b97a6d075a..a061d7092369 100644
>>> --- a/fs/btrfs/ctree.c
>>> +++ b/fs/btrfs/ctree.c
>>> @@ -2708,6 +2708,10 @@ static bool check_sibling_keys(struct extent_buffer *left,
>>>        }
>>>
>>>        if (btrfs_comp_cpu_keys(&left_last, &right_first) >= 0) {
>>> +             btrfs_crit(left->fs_info, "left extent buffer:");
>>> +             btrfs_print_tree(left, false);
>>> +             btrfs_crit(left->fs_info, "right extent buffer:");
>>> +             btrfs_print_tree(right, false);
>>>                btrfs_crit(left->fs_info,
>>>    "bad key order, sibling blocks, left last (%llu %u %llu) right first (%llu %u %llu)",
>>>                           left_last.objectid, left_last.type,
