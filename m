Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFF45B595B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 13:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiILLcO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 07:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiILLcN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 07:32:13 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10063.outbound.protection.outlook.com [40.107.1.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ED7615F
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 04:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cddxdniQUT8jfwoSUd/edTb5msdCC9zHwzjVk79uwzn27JRL5fuE5nRtQtlbZJIhUNNBIeAlVsJTFFj7UqkujC0ljEL7OQnRnKUEOUjhLezDfepXeivT0eB+tgpQts8T0FYQiS0QLL9tNN7vHuhD0RkLJIINb+XmZs68v/6WjPLQQ0ZpJngsq/r4owrwU8dzX9MWW7PhpJPMC7xeuCMV5hpXMKO8mlUPI6u7/5ri5qvHx3UV81izAHqTE8xNX4zE3fS8421Dzs6SyjGCRO+287QVwZUDcsremHnEP88LG3X2Ptbc3UCy8wIDQ+TdySipNmc1fkbdQ/fIDxL+S+engw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EXB2RMEcnuaUVgdhA9wfHM4vIdrdhy8e/r5W8lQ0vY=;
 b=N9QRG8oSijNdo7yzlZQjpYzWkpEjrMadjx4uq3ovsgjt4Y1Z4ZV5n8wTACNXI+VmikuRzzsGe95PLl1IFhbEVSZG3GX4w/Rjn+6vrngsUmUPuwCejzpqDC1tHOGwSOCl1l3hjYhph5qeAe9MJntq84irzZHWQBYHo82Reoj8ig9Q2AvTjp3Jv3qeChiV1BPeUzIus3o3hRAnG+zl/V+MjFn0LuFJcwaFW3k3HFUNLjythCz4DEQJ5M7d6cIl6XlNvQ89oV2YibplcPAoJ6WrwnbaNijrw5Sl8VNUvocIBLVbPi/FEBRVcfs6aHhmMtGxwnA3+Uo17Hxpdle+nPi1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EXB2RMEcnuaUVgdhA9wfHM4vIdrdhy8e/r5W8lQ0vY=;
 b=b/LjxEiD3jvvGtR1ZT7Z+6bVPosL7IaNTuIDKmUCljn64b8A/IMRmYTTEooOZeYaP93pubZwm7N4c4CCn+jnOZg+aV29Fw15HZwkoZvoMpQx6pGAhnggSEtt65Tlt1nqaPJmh8tg/5cpxnYb7tAh+VbaxRXaGfKqTcDVR9zLH4Ntb9RVwd0dMyat/8J83MB4SKZZD9zpqcHLCB1MlOFdc/Ly3e/Yb3hpk9KBP9eRhbi2eIZEH0iCPzuFl1YJD68GppRH+DgVTUcrrxF7O/gvChmrzl5Jq/TcERCQw+P7KhpqDZ6jOpyR8feRiNZrxe0O5Sotq+ethcwF7OEnTvp3EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 11:32:08 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f9af:f33a:99ad:e10a]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f9af:f33a:99ad:e10a%4]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 11:32:08 +0000
Message-ID: <794bed84-f665-2509-b655-4f6dac05237e@suse.com>
Date:   Mon, 12 Sep 2022 19:31:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] btrfs: introduce BTRFS_RESERVE_FLUSH_EMERGENCY
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <d1da73f6ed291d53d4cc7dcab142ebfb0541f06e.1662730491.git.josef@toxicpanda.com>
 <20220912095907.GA269395@falcondesktop>
 <0a2ffcd7-148b-e64b-5c9c-dc901c968e10@gmx.com>
 <CAL3q7H4kq28Y5TK+jJ-OE7L3vSQej5iBgSfS62Xk=gySg-BXmg@mail.gmail.com>
 <c2a2b438-531f-5e56-24e4-f383eb9f53ac@gmx.com>
 <CAL3q7H79PnrhgWQDgozcJ0p0eqPT5EMd54KBO+XGZ9nD_mZ6zw@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAL3q7H79PnrhgWQDgozcJ0p0eqPT5EMd54KBO+XGZ9nD_mZ6zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0101.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::42) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 6deffab7-5acb-48c8-63e1-08da94b26cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qK78xL6EsarMRc265holSzCS9e2VRzYadEHXdNAy0+RNiEwNkC2e69O8FFVuCcW18ozD7Q1K+2q8uaKB8zdncOX5KSWUGil7fhVBMZ4+fx+rkcrJvZxLHY29f0B0n6GCZ28B38alQz0Zuq4pG1FE9IxFgH8XHt4CTpyvaafd06nWEEml08eJdAP1ioMzuVfahuutZyti5zkemHGxIt5UWgQ04tC6j2gSmbIRB2b2U7O7wEDO9cpo1lCCNQhInHTpPrzZjSO4YTp1P7/rZVQe1dMm+jsqAjJMsLTd+oOKAQXkImcJ/8e7SSHvxnA1sKo8qfc89qBmrxqpW9QZG/nw9ZjCfQ1LSnBJctr855IN48n9RtFmKx5j6zrtv9AqVuIuSbzbjwbmb+0Q5Tubd7mCO8Fl1WBGVVp3JZ/Xbfu1JuqGrEkXqW2hykfywBLaC/rV7Rle0ZRN8CVdOACp21q9hP7AkQSMRoEYOHgCb5Q0EWggB00BhQ3JP1f3iQTjcMJUsHgH5MXyEPpwfCKcriRT2kgg9MdOPtTajUvNFEoxGfFc2y9MlxxIt/eO2IRvQzObbXdaEu75TsU/MsT6WOeEBvWtByL5XPjFk/aMSvWXZAeFE8Nl0EIkt5/G+rw/ouqRiuG0CO+wxaS4o9TnyytddbehP6HN6qndmR9poJlCEsT7NjJs0eDXYWYxrgd4Yv4+jK8pg0B7ELORRmVxLskmoOze3S7JfOeF9r4NWIahpATbbUqaVoFSOdBUxmsGcUHN/+tFrnTUARY13sDOUIdue598KC1KRUNavMPYorP7DVr1A8yPSG9p6F1s7zsDqCqX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(376002)(366004)(136003)(6486002)(478600001)(41300700001)(6666004)(86362001)(110136005)(31696002)(316002)(6512007)(6506007)(53546011)(186003)(36756003)(2616005)(83380400001)(38100700002)(30864003)(5660300002)(31686004)(8936002)(8676002)(4326008)(66946007)(66476007)(66556008)(2906002)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjZubjlvMjdTUzZIRkxDWkxhak54NEhMblBnWlhKRUE4WEw0Z05KdUdrUXpV?=
 =?utf-8?B?VzIwdVBscmxMellVUCtycnpSNTJzTTJMSzYwL1RReEFsZXQ0MWpxa3p6ckFM?=
 =?utf-8?B?RXp1TWI2N1o0L25hT0RtcDdOZW9LUXN6OHlGcHhuQ3hpSkN3RGtzWmt6K2x2?=
 =?utf-8?B?SGI3Y0tqR1RNOHJtb1NtT0oySEx1ZWZSL2VUczdTZDBPMFhZbExzdC94cktG?=
 =?utf-8?B?WmhYOGJpU2lyN0lOelJ0RWZLZzN3ZVF4VjVPdFNZSmRMV3l0VXdOejRnZU1G?=
 =?utf-8?B?ZStXTEFiUWljK0h1UTVicTdmTmhsTk4wUldLeU5nZW94cWJVTldrWi9mZDRv?=
 =?utf-8?B?akZnalFEbzZJWGxCb096R0diRzlLci9LYUJCK1RLSXBMYksyRGhmWmtvaytC?=
 =?utf-8?B?bitiUVl0THpvbFJzODkwenZCRDJhTURuQnBUK0ZyUFZlRW5nWk15V3dHS2lo?=
 =?utf-8?B?eUUweUlJdWhNY3hERUswdEg5ZFMzODNIVWo5WjF4RFlzZHlRQlJvMnp1NEor?=
 =?utf-8?B?TW9ieFpoajIrT0NETXlxSXowYTgySHRac3B6c0grYy9LQ0RNdGNLT05aa2lD?=
 =?utf-8?B?bFEzMktKdUZabkk4L3FqSEVGb0lnaHM5WW1peERqbGREbHdCeTF3Z0JJNktw?=
 =?utf-8?B?UCs1Rkk3bTBHcy9TWlA4UzhycFY1MkV2WWE1RFkzZmF6ZkV5WEJ5QkJsaElQ?=
 =?utf-8?B?TmFMS05qZ1YrTUpZdWMvczVDTEgzQitwWXBCSitsS3VTZnlKbG0wRjl3Sjh1?=
 =?utf-8?B?UXlMOGZFY0VuOWlmRTlPU3dxZ3lMem9uQm5TTHA2YU5xWVI3Y3VYN0hUQVcz?=
 =?utf-8?B?S0h3K00wMWJNdEIwQ2c3QWJvUExVYUhjbHBGcEhaZzJLUklaQW9RYzF0SDl3?=
 =?utf-8?B?eEdITE5YSHBqWStjRnVSZTBWSTVhV2FjSzVld2hWV0M5RndObTdVN0hrcmRw?=
 =?utf-8?B?NnI5NHpDa1lhVGVreW0vWTNCbnd2L3ZkNE5uSGQ3aHd5OWIyMW1aakg3N1Z5?=
 =?utf-8?B?QW9uYjUzQ2dYVWVWS2xiVGJWVDNoZkZINkw3OGhSdTBtV1ZkcVdNMU1LT3Qz?=
 =?utf-8?B?aFkvTWFtbDZsV3R1UWJuSE1Vb1BmNnBseXVUdk9tWk5sUE05M1ZoY3hQWUkr?=
 =?utf-8?B?N3ZlMURmOXkwZE5nRXc0d2NIakhmcUR3Ui96MDF2MkRnN2FKQmNpaG96RU1y?=
 =?utf-8?B?SHlXR1NLR1ozbVlxeTRhTjNHM3R0cnh2LzB3d0tMUHJhVmdKMmtFZjFuRzBR?=
 =?utf-8?B?Y3ZNU1A2eEgwTW9PSkkyZGdNMXlQUlQ0VEJ4ZkpCMGZCOFVYTmpQT0M2Rmcy?=
 =?utf-8?B?L0Y1cUJ6dE9MMXBlV1hsNzJONEpHeFZrOG04ZjJ0STB5bDM0ZXc5UjFlOVBP?=
 =?utf-8?B?dWhnaDJUQldnWEhtd0pIY0l5SUkwMCttQzgyTU4wNitGQ1dOTFMrSnFNOURR?=
 =?utf-8?B?d1BweWUzUjBLU3Y0aUs3ZTd1UGoyMGdHWHF6ZmY5QWtMaUg0bkkrWjQxR04x?=
 =?utf-8?B?YS9ZdUpWeUJwTWFaczRTODc4QWNoajA2RGFFaElQMFQ4OEs2L05mYUZpZGRY?=
 =?utf-8?B?a0hRc0MwQWJNWExHY1o1NDVORUFjeTZTMnEreHdPc3lyZHErU0tSSlYxMFRT?=
 =?utf-8?B?OTcrWmFVc3JHY0g3SHkySlVROVBvSXh3bm5UYnVOcUpZY3dWTU8zcEVlWTdk?=
 =?utf-8?B?TGs1MjhNSU9kWGJFcFNvMGJuZFhQaEFIZzhvYmE4b2oreTNkcDIvd3pQZDgy?=
 =?utf-8?B?VTNSQUpBYjRpL012S2dTb2c0R3BBUTBveWlhNDJwM0FheU4vcnZmdHdOYS9U?=
 =?utf-8?B?K3ptTU1MMmFUT2hHMDd1TGNxTjFCUCt0VGx2VXNkMUtkUnQ4Sml1aHFDQ0ZR?=
 =?utf-8?B?ZTBXL0hPOUxTRW5kSEg4TEtDRGxmbHZiREQ3YXlXM3RpS2IyMkpTVjhUUHFJ?=
 =?utf-8?B?U0hOMndmaTdnLzBQWFFsdU9RemN1RWpUOEpaWEtKanNvMDNvb0plOEd0ZFYr?=
 =?utf-8?B?ckp1bnRJYXN3NlRFMEZSdHRTSGEyK1Q2V1hPNDFjRzJFdHMrZGsydUVWaG50?=
 =?utf-8?B?QzhaS1JjRExpbUJOTGY4QWk2VUtzRWhCb282REUyR0lpQ3NBQWZxS01XWU12?=
 =?utf-8?B?aEtoTjNOUDlMZVNNOGNsUnJlYldrc1FZdDZLQzNsdWEvMWlpK2ZISHpoRXBs?=
 =?utf-8?Q?BKEwnKiMZzfPp4B/Bel6aZM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deffab7-5acb-48c8-63e1-08da94b26cc3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 11:32:08.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzcBf04DPedFWd8abwdjCWefBJK6qkpaVgUWQb2lRo7FVfiQt2fC8erzuTZGf/GR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/12 19:21, Filipe Manana wrote:
> On Mon, Sep 12, 2022 at 12:02 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2022/9/12 18:42, Filipe Manana wrote:
>>> On Mon, Sep 12, 2022 at 11:26 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2022/9/12 17:59, Filipe Manana wrote:
>>>>> On Fri, Sep 09, 2022 at 09:35:01AM -0400, Josef Bacik wrote:
>>>>>> Inside of FB, as well as some user reports, we've had a consistent
>>>>>> problem of occasional ENOSPC transaction aborts.  Inside FB we were
>>>>>> seeing ~100-200 ENOSPC aborts per day in the fleet, which is a really
>>>>>> low occurrence rate given the size of our fleet, but it's not nothing.
>>>>>>
>>>>>> There are two causes of this particular problem.
>>>>>>
>>>>>> First is delayed allocation.  The reservation system for delalloc
>>>>>> assumes that contiguous dirty ranges will result in 1 file extent item.
>>>>>> However if there is memory pressure that results in fragmented writeout,
>>>>>> or there is fragmentation in the block groups, this won't necessarily be
>>>>>> true.  Consider the case where we do a single 256MiB write to a file and
>>>>>> then close it.  We will have 1 reservation for the inode update, the
>>>>>> reservations for the checksum updates, and 1 reservation for the file
>>>>>> extent item.  At some point later we decide to write this entire range
>>>>>> out, but we're so fragmented that we break this into 100 different file
>>>>>> extents.  Since we've already closed the file and are no longer writing
>>>>>> to it there's nothing to trigger a refill of the delalloc block rsv to
>>>>>> satisfy the 99 new file extent reservations we need.  At this point we
>>>>>> exhaust our delalloc reservation, and we begin to steal from the global
>>>>>> reserve.  If you have enough of these cases going in parallel you can
>>>>>> easily exhaust the global reserve, get an ENOSPC at
>>>>>> btrfs_alloc_tree_block() time, and then abort the transaction.
>>>>>
>>>>> There's also another problem I pointed out in the past regarding delalloc
>>>>> reservations. The thing is that we assume for each ordered extent, the new
>>>>> file extent item will require changing only 1 leaf in the subvolume tree.
>>>>>
>>>>> If our new extent has a size of 128M and currently for that range we
>>>>> have 32768 extents each with a size of 4K, then we need to touch 157
>>>>> leaves in order to drop those file extent items before inserting the new
>>>>> one at ordered extent completion. And our reservation that happened at
>>>>> buffered write time only accounted for 1 leaf/path for file extent items
>>>>> (plus 1 for the inode item). This is assuming the default leaf size of 16K,
>>>>> where we can have at most 208 file extent items per leaf.
>>>>>
>>>>> If we have just a single ordered extent triggering this case we probably
>>>>> won't reach -ENOSPC and a transaction abort, as we end up consuming from
>>>>> the global reserve and that may be able to satisfy our space needs.
>>>>> However with multiple ordered extents hitting such cases of insufficient
>>>>> reserved space, and other tasks doing other things and consuming from the
>>>>> global reserve, then the chances of hitting -ENOSPC at btrfs_finish_ordered_io()
>>>>> become very high, leading to a transaction abort there.
>>>>
>>>> In fact, I'm also considering these problems, and for the highly
>>>> fragmented free space case (and other cases like delayed refs generated
>>>> delayed refs case), can we let btrfs itself to learn from last (several)
>>>> delalloc (delayed refs) runs to generate an overall idea on how
>>>> fragmented the free space is.
>>>
>>> That won't help for the case I described, because it has nothing to do with
>>> fragmentation.
>>
>> Isn't it?
> 
> It isn't.
> 
>>
>> We have a 128MiB range dirtied, and we only reserve enough metadata for
>> one ordered extent since at write/dirty time they are continous.
>>
>> But then we only have a bunch of 4K fragmented free extents, every time
>> btrfs_reserve_extent() can only return a 4K extent for data.
>>
>> Aren't the two cases the same?
> 
> Nop. That's the case Josef mentioned.
> 
> In what I mentioned we have 1 ordered extent, say 128M for example.
> So there were no issues with free space fragmentation.
> 
> What I was saying, and I believe it was explicit enough, is that for that file
> range we have 32K 4K file extent items, so at finish ordered io, we have to
> drop all those file extent items before inserting the new one (the 128M one).
> And 32K spans much more than 1 leaf (path) - 157/158 leaves in case of
> a 16K leaf/node size.

OK, I see the problem now, it's in the drop time, not the reserve time, 
which I completely ignored previously...

Thanks,
Qu

> 
> See the problem?
> At dealloc time we assume that to insert/replace the new extent item,
> we will touch
> only 1 leaf - only one path.
> 
> This of course is not a problem if we are writing into a previously
> unallocated file
> range.
> 
>>
>> Thanks,
>> Qu
>>
>>>
>>> There's also other case where more than 1 ordered extent is created, but
>>> at reservation time we think it's only 1 ordered extent - compression,
>>> it will split
>>> into many 128K ordered extents. Again, this one has nothing do with
>>> fragmentation.
>>>
>>>>
>>>> Then round (down) that value for write/dirty time delalloc reservation?
>>>>
>>>> The same can go to delayed refs reservation too.
>>>>
>>>> If by somehow, the delayed refs are generating more than expected
>>>> delayed refs, we increase the pre-reserved space accordingly.
>>>>
>>>>
>>>>
>>>> Another less dynamic method (but still the same idea) is to introduce a
>>>> doomsday mode.
>>>>
>>>> In that mode, every time we need to reserve space for delalloc, we
>>>> consider the extent can only be at most 4K, double the pre-reserve for
>>>> delayed refs etc.
>>>>
>>>> But I'm afraid this can only reduce, but not really eliminate the ENOSPC
>>>> at critical path.
>>>>
>>>>>
>>>>>>
>>>>>> The other case is the delayed refs reserve.  The delayed refs reserve
>>>>>> updates its size based on outstanding delayed refs and dirty block
>>>>>> groups.  However we only refill this block reserve when returning
>>>>>> excess reservations and when we call btrfs_start_transaction(root, X).
>>>>>> We will reserve 2*X credits at transaction start time, and fill in X
>>>>>> into the delayed refs reserve to make sure it stays topped off.
>>>>>> Generally this works well, but clearly has downsides.  If we do a
>>>>>> particularly delayed ref heavy operation we may never catch up in our
>>>>>> reservations.  Additionally running delayed refs generates more delayed
>>>>>> refs, and at that point we may be committing the transaction and have no
>>>>>> way to trigger a refill of our delayed refs rsv.  Then a similar thing
>>>>>> occurs with the delalloc reserve.
>>>>>>
>>>>>> Generally speaking we well over-reserve in all of our block rsvs.  If we
>>>>>> reserve 1 credit we're usually reserving around 264k of space, but we'll
>>>>>> often not use any of that reservation, or use a few blocks of that
>>>>>> reservation.  We can be reasonably sure that as long as you were able to
>>>>>> reserve space up front for your operation you'll be able to find space
>>>>>> on disk for that reservation.
>>>>>
>>>>> That's another elephant in the room. We assume that if a task reserves
>>>>> space, it will be able to allocate that space later.
>>>>>
>>>>> There are several things that can happen which will result in not being
>>>>> able to allocate space we reserved before:
>>>>>
>>>>> 1) Discard/fitrim - it removes a free space entry, does the discard, and
>>>>>       after that it adds back the free space entry. If all the available space
>>>>>       is in such an entry being discarded, the task fails to allocate space;
>>>>>
>>>>> 2) fsync - it joins a transaction, doesn't reserve space and starts allocating
>>>>>       space for tree blocks, without ever reserving space (because we want it
>>>>>       to be fast and for most cases we don't know in advance, or can estimate,
>>>>>       how many tree blocks we will need to allocate). So it can steal space that
>>>>>       was reserved by some other task;
>>>>>
>>>>> 3) Scrub - scrub temporarily turns a block group into RO mode - if all the
>>>>>       available space was in that block group, than when the task tries to
>>>>>       allocate it will fail because the block group is now RO;
>>>>
>>>> Yes, that's one concern of the existing per-dev scrub.
>>>> If we have 10 devices, all single profiles, then we may mark 10 block
>>>> groups RO at once, hugely increase the chance of ENOSPC.
>>>>
>>>>>
>>>>> 4) During space reservation we only check if free space counters. There
>>>>>       may be block groups with plenty of free space but their profile is not
>>>>>       compatible, so when trying to allocate an extent we are forced to allocate
>>>>>       a new block group with the necessary profile, which will fail if there's
>>>>>       not enough unallocated space.
>>>>>       This mostly affects degraded mode only (hopefully).
>>>>
>>>> This is still pretty common, for RAID1 usage especially one device is
>>>> just slightly (like 10MiB) larger than the other.
>>>>
>>>> The metadata over-reserve still believe we can allocate new metadata bg,
>>>> but nope, and hit a ENOSPC at critical path.
>>>>
>>>> IIRC I had some very old patches for the problem, but haven't updated
>>>> for a long time.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> I documented these at btrfs_chunk_alloc() sometime ago, but there are a few
>>>>> more similar cases.
>>>>>
>>>>>>
>>>>>> So introduce a new flushing state, BTRFS_RESERVE_FLUSH_EMERGENCY.  This
>>>>>> gets used in the case that we've exhausted our reserve and the global
>>>>>> reserve.  It simply forces a reservation if we have enough actual space
>>>>>> on disk to make the reservation, which is almost always the case.  This
>>>>>> keeps us from hitting ENOSPC aborts in these odd occurrences where we've
>>>>>> not kept up with the delayed work.
>>>>>>
>>>>>> Fixing this in a complete way is going to be relatively complicated and
>>>>>> time consuming.  This patch is what I discussed with Filipe earlier this
>>>>>> year, and what I put into our kernels inside FB.  With this patch we're
>>>>>> down to 1-2 ENOSPC aborts per week, which is a significant reduction.
>>>>>> This is a decent stop gap until we can work out a more wholistic
>>>>>> solution to these two corner cases.
>>>>>
>>>>> Well, it's a lot more than 2 corner cases :)
>>>>>
>>>>> The change looks fine to me, it's simple and it should help reduce the
>>>>> frequency of several ENOSPC cases. So,
>>>>>
>>>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>>>>
>>>>> Thanks.
>>>>>
>>>>>>
>>>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>>>> ---
>>>>>>     fs/btrfs/block-rsv.c  | 12 ++++++++++++
>>>>>>     fs/btrfs/ctree.h      | 18 ++++++++++++++++++
>>>>>>     fs/btrfs/space-info.c | 27 ++++++++++++++++++++++++++-
>>>>>>     3 files changed, 56 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
>>>>>> index ec96285357e0..89e3e7d1bff6 100644
>>>>>> --- a/fs/btrfs/block-rsv.c
>>>>>> +++ b/fs/btrfs/block-rsv.c
>>>>>> @@ -552,5 +552,17 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
>>>>>>                if (!ret)
>>>>>>                        return global_rsv;
>>>>>>        }
>>>>>> +
>>>>>> +    /*
>>>>>> +     * All hope is lost, but of course our reservations are overly
>>>>>> +     * pessimistic, so instead of possibly having an ENOSPC abort here, try
>>>>>> +     * one last time to force a reservation if there's enough actual space
>>>>>> +     * on disk to make the reservation.
>>>>>> +     */
>>>>>> +    ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, blocksize,
>>>>>> +                                       BTRFS_RESERVE_FLUSH_EMERGENCY);
>>>>>> +    if (!ret)
>>>>>> +            return block_rsv;
>>>>>> +
>>>>>>        return ERR_PTR(ret);
>>>>>>     }
>>>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>>>>> index 0108585d838d..f221b3cb718d 100644
>>>>>> --- a/fs/btrfs/ctree.h
>>>>>> +++ b/fs/btrfs/ctree.h
>>>>>> @@ -2986,6 +2986,24 @@ enum btrfs_reserve_flush_enum {
>>>>>>         * Can be interrupted by a fatal signal.
>>>>>>         */
>>>>>>        BTRFS_RESERVE_FLUSH_ALL_STEAL,
>>>>>> +
>>>>>> +    /*
>>>>>> +     * This is for btrfs_use_block_rsv only.  We have exhausted our block
>>>>>> +     * rsv and our global block rsv.  This can happen for things like
>>>>>> +     * delalloc where we are overwriting a lot of extents with a single
>>>>>> +     * extent and didn't reserve enough space.  Alternatively it can happen
>>>>>> +     * with delalloc where we reserve 1 extents worth for a large extent but
>>>>>> +     * fragmentation leads to multiple extents being created.  This will
>>>>>> +     * give us the reservation in the case of
>>>>>> +     *
>>>>>> +     * if (num_bytes < (space_info->total_bytes -
>>>>>> +     *                  btrfs_space_info_used(space_info, false))
>>>>>> +     *
>>>>>> +     * Which ignores bytes_may_use.  This is potentially dangerous, but our
>>>>>> +     * reservation system is generally pessimistic so is able to absorb this
>>>>>> +     * style of mistake.
>>>>>> +     */
>>>>>> +    BTRFS_RESERVE_FLUSH_EMERGENCY,
>>>>>>     };
>>>>>>
>>>>>>     enum btrfs_flush_state {
>>>>>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>>>>>> index 2e06b7c422c7..a0abc6dd01c2 100644
>>>>>> --- a/fs/btrfs/space-info.c
>>>>>> +++ b/fs/btrfs/space-info.c
>>>>>> @@ -1583,6 +1583,16 @@ static inline bool can_steal(enum btrfs_reserve_flush_enum flush)
>>>>>>                flush == BTRFS_RESERVE_FLUSH_EVICT);
>>>>>>     }
>>>>>>
>>>>>> +/*
>>>>>> + * NO_FLUSH and FLUSH_EMERGENCY don't want to create a ticket, they just want to
>>>>>> + * fail as quickly as possible.
>>>>>> + */
>>>>>> +static inline bool can_ticket(enum btrfs_reserve_flush_enum flush)
>>>>>> +{
>>>>>> +    return (flush != BTRFS_RESERVE_NO_FLUSH &&
>>>>>> +            flush != BTRFS_RESERVE_FLUSH_EMERGENCY);
>>>>>> +}
>>>>>> +
>>>>>>     /**
>>>>>>      * Try to reserve bytes from the block_rsv's space
>>>>>>      *
>>>>>> @@ -1644,6 +1654,21 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
>>>>>>                ret = 0;
>>>>>>        }
>>>>>>
>>>>>> +    /*
>>>>>> +     * Things are dire, we need to make a reservation so we don't abort.  We
>>>>>> +     * will let this reservation go through as long as we have actual space
>>>>>> +     * left to allocate for the block.
>>>>>> +     */
>>>>>> +    if (ret && unlikely(flush == BTRFS_RESERVE_FLUSH_EMERGENCY)) {
>>>>>
>>>>> Does the unlikely() really makes any difference in this context?
>>>>>
>>>>>> +            used = btrfs_space_info_used(space_info, false);
>>>>>> +            if (used + orig_bytes <=
>>>>>> +                writable_total_bytes(fs_info, space_info)) {
>>>>>> +                    btrfs_space_info_update_bytes_may_use(fs_info, space_info,
>>>>>> +                                                          orig_bytes);
>>>>>> +                    ret = 0;
>>>>>> +            }
>>>>>> +    }
>>>>>> +
>>>>>>        /*
>>>>>>         * If we couldn't make a reservation then setup our reservation ticket
>>>>>>         * and kick the async worker if it's not already running.
>>>>>> @@ -1651,7 +1676,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
>>>>>>         * If we are a priority flusher then we just need to add our ticket to
>>>>>>         * the list and we will do our own flushing further down.
>>>>>>         */
>>>>>> -    if (ret && flush != BTRFS_RESERVE_NO_FLUSH) {
>>>>>> +    if (ret && can_ticket(flush)) {
>>>>>>                ticket.bytes = orig_bytes;
>>>>>>                ticket.error = 0;
>>>>>>                space_info->reclaim_size += ticket.bytes;
>>>>>> --
>>>>>> 2.26.3
>>>>>>
