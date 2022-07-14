Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84855740CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 03:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiGNBIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 21:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiGNBIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 21:08:34 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF84C1EACB
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 18:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSE6zmHKlIWDOZAM8HnHWUyj/Ek1RjG8p+D6Cn9bk3UpnsVRwksU9JMunIK4QxsWWB3ZTXbROdhhwee54xAXEIFG+YWWHc0n/fMU9FbpoA62oyBPv1k/joLJzrANU6UUOeVoEsjQMv4zeqgGdHwQgkIpxY2w6mRRGm8G+G2uq0j20WppP7B8puNKZRaXru06/dKnhp8JOxPGnrthE/d2GNn/xQARc802AgP2wWLszfbQOfCZPMuvT/KCRHwYVGu91Hvid1OXwY5fdLob1Fo5o9mOtoV+Zoy1dLkG4SEKvRdvMWqMZH3kZyXqtJERlYWxcFb1qgLT8ImECLh3DVum3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeZNjhwlXkYoLv0VWzBTbKtPPvBi9h9bBy16rspq85g=;
 b=a4FyUd2FpkUaE2ya25RzKsZFltUfsix239eQVRK22hgljhiOYZwtBQyD94kfWwIes3Zf//rSQ6BTXcc6RxaOjOZP9Ocdh/wqDe7MbfkHWWnHZ0n0zVuQxR6RI17DMTJ1oO+kD/hBhMwyxcDmtHkBgsT+qc1kfCH5sTkK1nL0Ru46YUIPMznypc8jIlzpW5KDvPN2OMdEpbdGmEyrElsTLN8o97itrsk3nSV6oGngd+FmalDMPXAFap61OUQ6bOL8WwKtmMBAQh8ROlsu9wcQ89StVRL13yofFNblw/5TEGmUjK4oKBc+/5YJ4Fv/YujUgj3ROTLUrxi+0JyMd3nhiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeZNjhwlXkYoLv0VWzBTbKtPPvBi9h9bBy16rspq85g=;
 b=PeoJ51pf/MZHNkJgKcnm51pGkmCLuPCEO1oJVK8MGGU/+4WR5ZAsv3nRHsvH+NLIcwRiB5byMSqRs4Hrabfh8/Jra7ou+U6Uk/IwEEQXdVjkePYCbTiq6GfWD6QWDu7wdsMDQFQAc0pwZNSd6TnVoQtF0ZFxRz8k8qw8YdWZ/qcG9DrTtKcSYwegShCOQ7Com0hIRk77eb3BswLC2u+vjKG/PW+f+nAIo0t6jBydGCZRUaaqqHWGUp2AvDJTw4eaNsn5ZfYjsSNYYdii1KhzMci4Hv9GBOuWYq/fK8IebNQGYH0lzV7epQgF2J/i4pCNYuuLtXIzEjwuxcs4Ujtvmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM5PR04MB3074.eurprd04.prod.outlook.com (2603:10a6:206:4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 01:08:27 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c48:27de:73e5:ea97]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c48:27de:73e5:ea97%9]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 01:08:27 +0000
Message-ID: <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
Date:   Thu, 14 Jul 2022 09:08:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
In-Reply-To: <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12620800-4b2f-4035-948c-08da65355b92
X-MS-TrafficTypeDiagnostic: AM5PR04MB3074:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeGb1gV2/hURE9Pa6s4a3J4LTfQnULy12CwfnHv8sEyvqbnFpIM+kJldC1+BlN15b/QFsP677mMhmqQwjuC1Db0nzgggTmzNNxzdYK0dl84NH4VjrGbxCNK7KMIkNbARRnT3Jp9Ha15HHgWq3Kj+3Zuz3bA7xvS6JF+I0/3NuUdihP4vjo/PbQcUYaE2AB0d88z19NAndwCslNTqwBD2zLPJTKQthEhZjHpF+tu8wTViITkR8H9w1UDDEiPyUIDiux1uIYZ81+V19hb8+Af6gIHzNCqDygapxwNwypebuMsnxdnv0tp1V6EJQFsftIR6UIBbLqfUJhgB7z4f0ceGur6H/EGw8DlVuI61Np4AX15YmVXtfLCyGSwjUOITbYRDl83BTXcAHHcR9C+bkS4SDzmQpgVfxqV65AG6hQparcJSOkj82cxTmQ5hzfmPykgWFikHrXtSwoN3tQNUg1pAn9ssz/ZVwVTPFZukkXdnuTD2HuXtlF3PHgUtDcEerc45TWXrDJHHqNxXIcCGEHax/gBPxP2t65oF15UBmUk7Bbmn1oDFGoa5nOc/DzsHystQ7nD8ElAWgMt2pkcS+URbOoeQoCx4IcWpO3uL6awpL147OJn1yn1BGY5V5sH9FTLXqKa0y3yvVlYUDjmwV+ysEpEMzuDSKg2GTBBujLVWF/fASFtzRZAVOkK1LerFbytI15BYsGsjl4xvJy0Zh+OrobU+yIMa+g52+l9+gzKRWl/CVgIMlIhr9/AWfZGbXSFcC4+H5miojpI97cHTAM0BbQGx5Pv4nihKqge6sTk/0xOmpKgConpAU6+BjUuu+zzVd4i721iSz4o+gdmv2qvxBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(366004)(376002)(396003)(31686004)(316002)(36756003)(53546011)(66946007)(66556008)(66476007)(83380400001)(8676002)(6506007)(110136005)(6486002)(38100700002)(2906002)(41300700001)(478600001)(186003)(6512007)(31696002)(6666004)(8936002)(5660300002)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cncrQ0ZtdjBvUFJYMFZ4Q091cGJIcnhsdndvQld6NGdUL3dZUyttTlZBdmlG?=
 =?utf-8?B?eGNCL2NFQ2pZTFF6cEpCWFpGOFhvbTV0bjdKcWNKNXZrRmw4d0JLUzNlZHFR?=
 =?utf-8?B?NzMzemk2VFhubmdvVUJtQWd3NWFIdDVrZnFsaWJNMlRrMTRsVU5TaDhyYXNn?=
 =?utf-8?B?MGVmalZPZURkMjhHMVJqUlQrWm15UHArWGJPS3JqOExWSURKdUR3Z1dsSGIx?=
 =?utf-8?B?aU5velQxTlFMRXpHL2hqSmZGNFh6RW9MUFoyZFpnSEZ0aU9JdVY0UWpGRTg0?=
 =?utf-8?B?SW16R2NlWEVZdktHZzM0MEpNT25qaFJmQTZuK1JrWVBNbldKTEVHY1lTNjRC?=
 =?utf-8?B?a1FTMVhiemcxZkFUWkhhYURyQW5jd09Ic3liTEFDRmNpMHVYZGlSUXhoUll2?=
 =?utf-8?B?YXBQUk5YZ3JkbnZCL2tQMmxTcGtRK1NXb1lBaDJncmV4VmYrQis2N2pPZWd2?=
 =?utf-8?B?YnZvRlJGTE1VQlZ3ZmZ6K1VSaHhWOU5PelZqREdxUjRLTlRSaFRJN0owcUNU?=
 =?utf-8?B?SzZEMS9ncldBNCtNRngxaG9WaXoxaGlOaE5sNE5CeU16NzUwQVZJcmRLRDBk?=
 =?utf-8?B?ekU2Yi9kdGxzTHdxd1dMdUQyRkZJR05CK1dYTG1sSExjVDE0eXJ2YUhxWU9X?=
 =?utf-8?B?QkF0QnRaTDNWU3hCTVlFa0hkTllQazI3SnlVdWlPVWFwYkZnYVVBalAyUlFI?=
 =?utf-8?B?eUU5akFsTnViM2R5R09EdFJPR2hud0RkNTFtUHMyenc1SmZGcFo0anQyZHlH?=
 =?utf-8?B?eEFTL0Q4MG1GZkk0b2ZDOWgwb0FZMmpSS01TaG92UXowTFljeTZvZnNUTzR0?=
 =?utf-8?B?QUdhWmp2K0FZKzU5c0NXSEI1NUZ1ZnI4WkVOVHVGeXR6NEc3RktxWGpDTm1O?=
 =?utf-8?B?NjVjOVVDVjQrQ2lLVHR1Q1VYRjN6TlllQnZ1NWxzTkVxQ2lkdmhNdURBUDh2?=
 =?utf-8?B?T1FlUFVNZG50cUVaYkFXczJUYkFpeWVWcXpyKzNVRG1aOWg0bEIvaGd6YmVF?=
 =?utf-8?B?TUl1Q0pMUVpoZHNpQ3hMOWpMeFNwanZxNEhDQi9kRkF6Y0x3cmVoSEgycUpG?=
 =?utf-8?B?c2ZMTjhCQVNFellzVllnVlJJc2V0SkJOUmFHS2gxdkRmTlhJeHJZb2ptSmg5?=
 =?utf-8?B?cU9nbzFzZmIvd2Z3OEhkelhtWk15RFpzeC92U1ZXZ0JFODlWL0gyRGpMalRr?=
 =?utf-8?B?M0FpQ0p4ZWQ2QXhZVDUxTkVwanBJWWJ0M0VoVVZ0S2NiL0kwdEY1Wm9Nbi9Y?=
 =?utf-8?B?QXZTSXFzZmRNMm4wbmovUmxOSWF1VTRkTGxnbGVGTUYzZkRwQVF2d0pSSjJU?=
 =?utf-8?B?Zlh5K2xKSGhMSkxOQ1F1czVYbnJsUEhIYWVMZmUrMmM1Tzc2SlM1bG9tWVpu?=
 =?utf-8?B?K1BRYnVuaUtMejlYMTRabFdkOEJNK0dXdVBVdkY1c20yQlA1WjlvT2NqRmZy?=
 =?utf-8?B?Q3BZemYzRFh4b0psa0ZIeGJ2UzJPekMrSXJHR1BzcEtYeTZlNWRRRWZYVG00?=
 =?utf-8?B?MFZhR0JLOXh2YTBHZEFGOWFxTzk0Wm9lTU93TjR1MXVUajhTQ2ttTWhORjBF?=
 =?utf-8?B?MENuYkw2ZWdTbkZFTkd3WlNlZ2h4dmkvdDFkSWs1eWl6S0RhVStxM0xZdUtp?=
 =?utf-8?B?NFh6RDZqL2FIb1hFTVBEdHRiaURwclhlc0dLUUVzWjFwcS9vVi9CanB3QktO?=
 =?utf-8?B?N2F1b2lMaG12M3JTZUF3VElUaVp6eXB2NldSYVJ4VWxTTk11QW9uNE43Kzdu?=
 =?utf-8?B?ZjdkUkgxdFA0VktVVExYbGppMWJKU2JRbml2YS9SVFFXL0hyNHVwN1dOTDk3?=
 =?utf-8?B?cjUyRDZkZUlzSjJFNDMzSStadlFwbXBuWXBKQk5GRGtsalM0TDk3OTNZOWJs?=
 =?utf-8?B?cmtWUWlqNlFjcWtVSjVuV1NDSi83SlFadlFWK2lSemNnR2U0bWtxaGxvaDA3?=
 =?utf-8?B?WmE0NGJkLzlxZFlueXVhQW1rWHBYcXpqNVNVTy92VmE0azVEU1lrN3pRQ2ds?=
 =?utf-8?B?Ym5FOEZLazVGWllOby9aUG5LRFgwa1I2OFQxWWhUd0tsT3lGekwwZzRvRkNJ?=
 =?utf-8?B?WFJqVy9MbVFMdVhTc2lLcm9qTmVrRXJueFZLN2dmZ1Nmb1UvUE5rMTNTdmRZ?=
 =?utf-8?B?QW9KcnEvM0dMejlDaWF5Q29MaUNJeWh4TTllVXhKQ05rcXd1VmEzNm9lOERD?=
 =?utf-8?Q?8LIdTLD2jd5t7C2FbIVINIo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12620800-4b2f-4035-948c-08da65355b92
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 01:08:27.1601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPVWAqYx24VwJueC9lle97Xuws3tZ4IWiYG+PU2wQbKL/3S6rdHal5Mk5Q+Wv05f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/13 22:01, Johannes Thumshirn wrote:
> On 13.07.22 15:47, Qu Wenruo wrote:
> 
> 
> Ah ok, my apologies. For sub-stripe size writes My idea was to 0-pad up to
> stripe size. Then we can do full CoW of stripes. If we have an older generation
> of a stripe, we can just override it on regular btrfs. On zoned btrfs this
> just accounts for more zone_unusable bytes and waits for the GC to kick in.
> 

Sorry, I guess you still didn't get my point here.

What I'm talking about is, how many bytes you can really write into a 
full stripe when CoWing P/Q stripes.

[TL;DR]

If we CoW P/Q, for the worst cases (always 4K write and sync), the space 
efficiency is no better than RAID1.

For a lot of write order, we can only write 64K (STRIPE_LEN) no matter what.


!NOTE!
All following examples are using 8KiB sector size, to make the graph 
shorter.

[CASE 1 CURRENT WRITE ORDER, NO PADDING]
        0                               64K
Disk 1 | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | (Data stripe)
Disk 2 | 8 | 9 | a | b | c | d | e | f | (Data stripe)
Disk 3 | P | P | P | P | P | P | P | P | (Parity stripe).

For zoned RST, we can only write 8 sectors, then Disk 3 exhaust its 
zone. As every time we write a sector in data stripe, we have to write a P.

Total written bytes: 64K
Expected written bytes: 128K (nr_data * 64K)
Efficiency:	1 / nr_data.

The worst.

[CASE 2 CURRENT WRITE ORDER, PADDING]
No difference than case 1, just when we have finished sector 7, all 
zones are exhausted.

Total written bytes: 64K
Expected written bytes: 128K (nr_data * 64K)
Efficiency:	1 / nr_data.

[CASE 3 FULLY UNORDERED, NO PADDING]
This should have the best efficiency, but no better than RAID1.

        0                               64K
Disk 1 | 0 | P | 3 | P | 6 | P | 9 | P |
Disk 2 | P | 2 | P | 5 | P | 8 | P | b |
Disk 3 | 1 | P | 4 | P | 7 | P | a | P |

Total written bytes: 96K
Expected written bytes: 128K (nr_data * 64K)
Efficiency:	1 / 2

This can not even beat RAID1/RAID10, but cause way more metadata just 
for the RST.


Whatever the case, we can no longer ensure we can write (nr_data * 64K) 
bytes of data into a full stripe.
And for worst cases, it can be way bad than RAID1, I don't really think 
it's any good to our extent allocator or the space efficiency (that's 
exactly why users choose to go RAID56).

[ROOT CAUSE]
If we just check how many write we really need submit to each device, it 
should be obvious:

When data stripe in disk1 is filled:
        0                               64K
Disk 1 | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 64K written
Disk 2 |   |   |   |   |   |   |   |   | 0 written
Disk 3 | P | P | P | P | P | P | P | P | 64K written

When data stripe in disk2 is filled:

        0                               64K
Disk 1 | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 64K written
Disk 2 | 8 | 9 | a | b | c | d | e | f | 64K written
Disk 3 | P'| P'| P'| P'| P'| P'| P'| P'| 128K written

For RAID56 partial write, the total write is always 2 * data written.
Thus for zoned device, since they can not do any overwrite, their worst 
case space efficiency can never exceed RAID1.

Thus I have repeated times and times, against this problem for RST.

Thanks,
Qu
