Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5778F57AD6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 03:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbiGTB5w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 21:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbiGTB5w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 21:57:52 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F714E628
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 18:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYQVaa1nJAT9FasHGAMBLTfhqzqcGl348ZnpiOIqawtZJphlNVMCgAS1+tO4itGBpag0YcdXe60YBUCj2pC0c0G8MGhumIGRW5HdpHnWzCOyL3eJ8CpzFMAwqtbCrsPCSTW9vvrrgNcbXP93XWnsT354+iKGQvUHKz5v2HWbFIBTUJ96UcztLcbnVyV+Bkmzp6LnrcXURFyyjjTE95X3Ea7MxxdFZ+IJdc7P0dDCDNCYSKrfDl2YHZUFY2SITjvqC4NtCxPGebqIfzE2JnbblU3UDlBzgWmnffBskyS51i1gqWBLAVy/V+u7yiEFl6a/8NcoU+O5Z3eFPX6nsWNR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jWwIscfBrJcBYGpghj20sTt9Xv/4h0lwNlGiSnzjq0=;
 b=EtL6lz/h8a4Igd8LUFGgvtuzO+tVim3ISX0PWddont5ZW/Do0sKjcSK1mwo121QJ4ONwQrQdHX8A8bFmAtAJvi8zMA8YiQIKk99Bo1eci9AMUPoddqSYAbjyZCsX14QmpnoTtxf/bco1TYs/PhYPbg681+sAUAJxN6LFBnLdQZ2pdlogUSUNTNB3FFVecHH7Ss7HpPUmpHDe7Sf5xRkTfRfMHhhY5HG+qC/3GFwp6wjuiUd6UxxYjcqE3LO9TazS2m/7BkaxSYi6tK5HaaLzW9qQGoDgoSvXqxiG/A6mrEgFXg9fMQRNNsmoT058Dsjzz6AnfQZsZdNl/od8fcdx4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jWwIscfBrJcBYGpghj20sTt9Xv/4h0lwNlGiSnzjq0=;
 b=T6m1wVuvmre8qvaGJP5Wb1VT17qRy6pQCWZ0Egpw2HrM85IAUM5/Cn9yTsXQ4bNKwfeUF0YqAPOI3b8uo3b2q42tKv1RCSLiI+QjdsuTVzVTBj6LKIB+5fEIHvvVW1eTUGyZrFigydZ6W8qPMLSbxgY+g6LMCFBdOfFcJKgHx8O15lOpecWcol+k4+5wwPPsZHVrxOJ04bm5RCivPQKH4RVZlHgRE23jH+0ZQ6BcWyVchZ50rawTC+EOroijhxMNFi/LZY8wPLNzHVTcTDMTo2KK4FCmpeJa7zf+04OpqbHkswYPIaRBTDmEXWL9DZF/M0PLcnXtf1DALg1ImWZ99g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS4PR04MB9508.eurprd04.prod.outlook.com (2603:10a6:20b:4cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 01:57:48 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f592:23b0:9094:cd33]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f592:23b0:9094:cd33%9]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 01:57:48 +0000
Message-ID: <6a4c4ce9-b0f0-c25f-47b4-615cec7ef214@suse.com>
Date:   Wed, 20 Jul 2022 09:57:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] btrfs: dump all space infos if we abort
 transaction due to ENOSPC
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <621654191a02dc3cbc5c3b03f6c00963b7e6f382.1658207325.git.wqu@suse.com>
 <4b4b9f52-9c40-2f91-d8a3-a6ed29c379ee@dorminy.me>
 <8d2c653a-eddf-e9b4-7912-d46993705680@gmx.com>
 <e3f6275a-5f4c-f6d6-6a19-a53af8dc12e2@dorminy.me>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <e3f6275a-5f4c-f6d6-6a19-a53af8dc12e2@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::34) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 345dcb07-01c0-4186-e78e-08da69f33ed1
X-MS-TrafficTypeDiagnostic: AS4PR04MB9508:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uM1FlysOKtmRvr3NlQG7+YHoTN/MBQjPjUJMwB2HKEi7oSt4JS4ycEmJYL8e/SpmXjMK3alxhVvHdabWSccklORGexTYirFB6bL1lnYijagJ345DcH6B8FYmF3vyGyjMr6xu+xtwLtrciCAEQpdzzIze99rqTZ3A/BkTnR5dnrOgPtXqtBlHPepnlJSnCueIKbk0hSmzV2xqMK4iEHIEM4OyTPQUj1H1pcy/e4IHrK4W5nEQUriUeHohEeZ27pjf/Ae3BdRdMECgvWkL0gdDokhCj+FOvffSqNWYz1qER89RuDVtmNJco7ZXf2ICsifGtt8HdU6R6t6gllWuzM8tBhLRBYiX+ZDH6etYDmpH9gtaYrQ+041rVIaEb4v1yIaskJTEkPVPi88CwwaBCzms5MzhIcJ73s22vKw2WB/ESDnq/AX0IOl9GK3C5syCgTYcxpRUzKC7J5eoj41AoDc6y3zWCX/0cFGSpXkJm5nMU8UBNTpMdmQ1ah63jRBu01vhqdeSeBQrHoR1bSS5NlUpaCkFx3IRyf8vVpHGUm0C8pjjCZcrbFoeoIFmOICVtvppLBiu9MM9CJQmTDQOie0Sa2myXJIKu392NFcEGgRvMOTofNDEBPHFVzFEEl96qpgl+1tBKq6b5c4hnOYWAdQYjawE15V7rV4q+/1usxTlZrRvHB/UHqVYHPNrwzkJDXH31VFt8b5p0UXSqJ62uaqsVecp8v3rQsuCWEjkHofMAsbmkZmljNpvSzxmCsv1bN8g3KiMyZTg/XirYCQLYlyKhGjryOJZfQhi4KcvAMwepB4MEgFsW4wWbNso27DcgxbaAjAtpqYUCJDH3eor9Xq0xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(376002)(366004)(136003)(346002)(5660300002)(8936002)(66946007)(66556008)(8676002)(66476007)(4326008)(2906002)(36756003)(31696002)(2616005)(38100700002)(478600001)(53546011)(6486002)(6506007)(41300700001)(86362001)(6666004)(6512007)(186003)(110136005)(83380400001)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2E4RWxaWFJ5YXJVZjlpbUNjTjhTTjlkMDliUGNIeGJTcFhjMEFlMG8vRzJh?=
 =?utf-8?B?SitacC9DL014cStodnBQOEpnczNLOC9EeUlxVWhsbFBRMU8wMjJGR3EvcW5w?=
 =?utf-8?B?V1paKy8xVnA0a3A1Y1BrR0taNVNwUjFGcDM5dkFlWmF5TlRjUWJYUDYvbHBl?=
 =?utf-8?B?ZFRrNDNudWtxRys1L3l2dlMzQWtabG56VG1pd1h2eEdyb3liYk42cFhQOUNG?=
 =?utf-8?B?RVVPMm5pVUJ6d3hqUXR6UlhjVURKUE1NL1BVdHJJaFlSMTZwb2NSQnZxeWpZ?=
 =?utf-8?B?TFZ2N1JleWZZdFEya0hHcWFzS2VGZmhOVDVJckdpVnlqbzJ1eTN6OSt6Z3pN?=
 =?utf-8?B?R0FXQXFlckJSb3VkYTAvTkx5Z05nSlN5MUZRT09tVC9ySDJYanBMZnpzL0Jq?=
 =?utf-8?B?RjlFK3pFWDN5T21QK1dzL0FZNGFablpoZDJhTkN6WmZWaXR6bUxXL3pLZmFC?=
 =?utf-8?B?U0FSOC91akd2cXQzcjlZZlo4RmUxSnBFa210eSt0blV1dVFQSDZzS2RxUnha?=
 =?utf-8?B?NlZUdXBDWlYwYkFmM2N2MTZpVGRtS2ZvUnAreWF5YzBTNjVSQU90WDIvWFht?=
 =?utf-8?B?SDYyV0VCTVVFTnE5ejE4eXVuQjVuR1lEVm10ZzFKWTZmT3hUU2w5TFB0YTND?=
 =?utf-8?B?TFlFUlQ1YThHU2o1TjJYcFl3dlBiczFCM1EzbXd6ZUp4bHdrbHJiRW9qNWdC?=
 =?utf-8?B?RE9idkRSWVNJUDdYcmRuNVljYlZ3UlNCVVV6L2FQVDk5Q0QxTWJOYndzTitR?=
 =?utf-8?B?cnRyVDhXL3gwT3JxU3U3SU9TdmVUS3p0UTVNNXpwb3kzVzZtdFZObXBGVnl6?=
 =?utf-8?B?WG5YVEx4aXFnSUZzYWNBUnhGN3FkaFNzU1RuNU8xbEJmZEV0d3B0bitNb0RT?=
 =?utf-8?B?bXRURjNDSE93QXdVN3BKWGR0aTMrRERQMDB3UlE5a3FiK1pIa3JGc293U2kz?=
 =?utf-8?B?NFNCVkg3SWhYTGo5TEU4Zlk2Szk4c3JaQjQxVXdPSklRaUJXZGtkNjVyNEkz?=
 =?utf-8?B?RkFuUEZWTTh1QnNDZHRhZ0RYT1h4MDdKVURhclF0THNGMklTUlN4WWd1VGJw?=
 =?utf-8?B?WHFMVnM3Ym1lQ1Z0ZkJLWkpCVTdDUGkzbURQOWQ3OW10Mi84KzA0cWx1d3JQ?=
 =?utf-8?B?OVQvK0RkS1hKOE1SUmNISmhPTFcxZWRVb1pLMnp3NCtna2xFMkd4cmFEcGp1?=
 =?utf-8?B?WjZwbk5FZmZ2dVFOR2E2c0drM25TQ3pkdXBHMVhUTjhTOHRSTU9pQ2JaNGhk?=
 =?utf-8?B?WXRyM1dZQUNqNTJabjduU0VNZ0NGL2FEa3VRN1VvMUpvVXV2c0ZQWCtRTlM5?=
 =?utf-8?B?QUVWaUdpMnAxMyt4bE03UVBMUHZWL2dNcVlBb0VWeGYvQXFDcHZDYTZvQWZR?=
 =?utf-8?B?YStZc01KRFhPUDFleG1Vam4rNXU1WGV6V2g1ODRPM21WZDI0aDdGdUlqWC9B?=
 =?utf-8?B?OHZSRmZCcjFKalRIZ2xkM0UyMExBdXI0WTVVRHRtWDhwU3diYTNSOGlGYXFP?=
 =?utf-8?B?cGZ2blpUMkJWK285TDFob3BKOGRndmFzZkNrY1gycDNsdTZUTWFxOWhlNjdU?=
 =?utf-8?B?Q09GVXVRNVVOY2FwWjZDQnBqZVNMRm5tZnR6N0dIOGtRdFZ3ZlU4WVRpZEhr?=
 =?utf-8?B?enhLTjd5SFhLd09GUEgwb3BDWDc2NTlMbGRQTzZUYjdFejdTWFRFZ3IvVUMx?=
 =?utf-8?B?UkdqaWxmciszTEpCY3dPdUxyTitTb0JLK2szMmJrbWdOSmJMK1Q1eldRdWZN?=
 =?utf-8?B?TUoydTgvZURnK3Q1QjgvWmZNZmV5MkpsZ3RaRk1wRFFyQVZwajE4c25lZWU5?=
 =?utf-8?B?Sk1SelVvTHZnOENwbzh5REVjNURqSFIwNHI5K1I3Q0UzSXBLOERqN1JqNFNH?=
 =?utf-8?B?NzQ5RTgzUFdZVlArcFhMZXE0V2ZVQkE0eFVYSlBWaXl6YjlVVjNlNG1hak51?=
 =?utf-8?B?SU9rcUt3eEo3RStiUTlleDdMb3Bab1lyR3VwOTdPZVRKaks5SjVpUTVVZXdq?=
 =?utf-8?B?TUQ1YytETTRwekJtL1pjU2pqbml3TTFza0ZDS2h1MzFad1VRUkJmak1HWFZz?=
 =?utf-8?B?eEdoZGVkYjV5UURvM25WVjVNQzZKTis3Qkl3Z1craFZxUUJiNnIvdjQwSkFr?=
 =?utf-8?B?aWdxOGZBVVRGNThRNmtYS2hickFTdkZxVjhxdkJFNjZwMTNzQUlKemptMkZH?=
 =?utf-8?Q?jLcdPoZc8AfnC496NX9598g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345dcb07-01c0-4186-e78e-08da69f33ed1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 01:57:48.1240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+9+2h+IU3v4VXBwB3JHHIZ7LbZe0WJ7PfDDxZAJkdAOhkJhjtn4hIEkIC7uI7Zf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9508
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/20 09:43, Sweet Tea Dorminy wrote:
> 
>>>> +}
>>> This function looks similar to btrfs_dump_space_info(), and the name and
>>> callsite doesn't help distinguish it very much to me. It seems
>>> potentially useful to print all the space_infos when one space_info
>>> encounters a problem,
>>
>> This is fine for trans abort dump, but may not be a good idea for
>> enospc_debug output.
>>
>> enospc_debug can be triggered way more frequent than trans abort, and
>> the extra info of unrelated space info may just be noise.
>>> and it seems potentially useful to print the block
>>> group infos when we're dumping all the space infos already, so maybe the
>>> two functions could be combined.
>>
>> You mean block group infos? That can be very large for large fses.
>> Thus it's avoided for most call sites other than btrfs_reserve_extent().
> 
> I appreciate the explanation, I now agree it makes sense to keep the 
> dump-all function separate.

Although I'm considering extra dumping, not the level of each block 
groups, but each device (including used, unallocated, and the max hole 
size).

That info can be important for metadata over-reserve cases, but that can 
be done later.

> Maybe you could move the new dump-all function up beside the dump-one 
> function, and name it btrfs_dump_all_space_infos()?

That indeed looks like a much better name, would go that solution, after 
determining if the split lines are to stay or not.

Thanks,
Qu

> I still find the 
> name btrfs_dump_fs_space_info() a little hard to distinguish from the 
> others, and prefer 'all' being in the function name, but it's only a 
> mild preference.
