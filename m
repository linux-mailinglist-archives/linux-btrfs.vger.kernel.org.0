Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595EB63EB9F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Dec 2022 09:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiLAIx0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Dec 2022 03:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLAIxZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Dec 2022 03:53:25 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2080.outbound.protection.outlook.com [40.107.247.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC7137205
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Dec 2022 00:53:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwJQq4mb52IcHpQMTO9rB/nfsSjamJH8hGbgPbHOdf7q69VckrRsrZt6yizpyGLPvSNW02hbOO7gh+8/E7nX2vSq9eBkWkQlLxDRuIk3ODlM75h76S6t7I+tAGCdKMMxfh01uS3/y71HlrT8vHDyZDsA1RoIZuLSiHdFBU4DC7mf2LxI4QNeRUd+EcyJmgwqvTTXYFAkcE9Gp3+rMUM86PLTaPHD7egGrgjC4gNvz3aRwIIwR2WIOdNHQ/GsH4jWi/8p+CvoYfhdt/zNpO1lC+d4BLQQFBQVXEsjlyTEt26VzRkqbQU84oC0Rv0U4y3JTOJ1O55j28wuHrCIMtnptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+zldI7Y35W+mtNH6eIgA/sCiSbn9lw47Dp//OlF18g=;
 b=dRqq6b0EmTc6tBjzkgxK4g+rNm8hE7cYIK6xSO51BMVKlcj84TJkJXNPdrHgEx+OkjDfUdWWxW6urC/L9Vh592/ZgIe4+aJK4wslYW65gHF+B8WNDgFGYDFGxBUJj3H2yb95Q/5r2AOuApQFaQioaZdnk6heV0TWhhO2LJ9+XftOHxzFSA8TBzk4A7gwpbmFTXYPRoyEieQ5tBLtFbd28TUMgC1Tmw7ePLRplMh3/tdEm9TlZUCTUJmjgfw8DJXjmNlQ1FZWHJzSHh4zJtxCthUX1Ye7ynCI8j7FjXhKOWPnipWaWpKbNkzrxIxmrYZbKURKJNfCnUt3AvGvFsmgNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+zldI7Y35W+mtNH6eIgA/sCiSbn9lw47Dp//OlF18g=;
 b=a/sZHbj225SiFFvAY5L6lm4zGYTENwAMMWU6gfVae78ponisfiMdj4qFbKBEGvXhXP8PuLb830uzzR759eass6ZLE+rfnwwRF0Jr/Ig1lhVfSNijNA7NdNEB33Nw8bubBZV8DJ5sB1j3Q5pmUNESVyqYG7JpwjTf+QAYXRboQo+enu69S/DMzKd45umIqw+ioQaLNh5O/ftTQGrjilkb3moZNLMbrMtGOqjXof1Ne4krVVvn8eDDPlF8IDGZsyKHICe1TB93lxvKiahjkZKJP1vO9qklvmkyOnGUeIDJYBTKabCMgXdoeFFHWooVc8I4/VHvFwfpHlHVCRY3tlWosw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB9427.eurprd04.prod.outlook.com (2603:10a6:10:369::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 08:53:19 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::b69e:7eea:21cc:54ab]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::b69e:7eea:21cc:54ab%9]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 08:53:19 +0000
Message-ID: <70178c80-0428-f902-5b96-6253b6678b8d@suse.com>
Date:   Thu, 1 Dec 2022 16:53:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: btrfs-transacti hanging (was: Re[6]: block group x has wrong
 amount of free space)
To:     Hendrik Friedel <hendrik@friedels.name>,
        Paul Jones <paul@pauljones.id.au>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <em9da2c7f3-31bb-426b-89a3-51fd1dea8968@7b52163e.com>
 <ff2940de-babf-d83c-b9d0-1fe8d18909a9@gmx.com>
 <emca736322-38d8-49ca-9c93-083a5bbe946f@7b52163e.com>
 <bcb7a3f2-fa48-1846-e983-2e1ed771275e@gmx.com>
 <em62944e8a-0e4b-4028-ae00-383aac0608ab@7b52163e.com>
 <d7cc9778-9e97-f749-e110-d93a7045e341@gmx.com>
 <em7ed36627-a727-470e-872c-a2af32cdb18d@7b52163e.com>
 <em8aefb52c-4cdc-4cfb-ad52-1c807d8f7756@7b52163e.com>
 <emcca5c139-84cb-403b-af68-e288e31878e3@7b52163e.com>
 <c91c89b4-58e6-526a-bfb8-fb332e792cc3@gmx.com>
 <em6eb00339-18ce-4f15-8b9d-da8058301e72@7b52163e.com>
 <5fcf68ec-836a-3517-289d-bb77527468f7@gmx.com>
 <ema0c172ea-7620-4949-8f89-1504aaf516ca@7b52163e.com>
 <SYCPR01MB4685F00E2D2EB81E014D33159E099@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <em53860311-b978-4908-abfd-24b5acca9c5a@7b52163e.com>
 <SYCPR01MB468562139D0709239BB2CCC39E0A9@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <emf26a8e4d-f646-490c-8ef3-84f1989da042@7b52163e.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <emf26a8e4d-f646-490c-8ef3-84f1989da042@7b52163e.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::9) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: 9803aa4c-8711-4c2c-fb28-08dad3797d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRj0Er6WX2fSR/Q5Nyf0G5vgDKT44zxzcTLJisBo55nMXbL2Fn8jCvcAtB+Aur98bhYulTHnoK9uU8APzLjpSAWJvlt1xRBUyQBrMUxminvmxJC4oJkJgQQonggBTEMxZ67Y2tWYd+ugUR1np4FX9GTbS/W/fzeLQVvQmAQBR/XZellvFneg7ZRGNwkhI9oyloniQzCOWYIEjJGvhLxMRqd/YY7B6Epgx0ry6JzOuyEZds+kLWh57vaoPtb/rFv1hdtytNvz/6Cx2i1wXXj7jLAlajhpUBjkOWzh3O+YpOp51Elt5SZAfZJsJySfrnOOvaSuvYZO31UtQ4y+fE5biPPmFpE5q93K2NEST1US7qdApvv/qHnkTJro8xgoJ2/r6dQNXdbHoRRIDLtgN9w8BB2pMeSQgGL6ZHwOY0l5TpcvhfIpCfe5X5OcasssmiQH7rj+iszzeZYPbGT4my1FbgXQlbKqTz4r2QvDML2F371tGjtPEoeg++p2dSCiR2iZhy/r6Zg1A2dxiGFG6bT25EPL+zZTPVUvXM59BtqtUQLNV5OarRcNv7/175eFsnYyLfBNmchVLEY7+ZbH5apNeuBFkb6U/FRU1m9eKnJVIOJZaN6kU8P48A/VpE4KjxkNJkxW3t73JYoXazfa02kfiM0t7PneQECzB0vXESV64xDA1YQueSap6EZMOFGC3mOi91ScCD+QKKBZz/xEngNp3rMVEv3S9ky38faWPWicr6mrdanANbipL8vM73sQrfOoXFXUEwWx/bQ0VZAh1x30f9RP6uV8sVBh7+VtOudoiR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199015)(86362001)(66574015)(83380400001)(31696002)(66556008)(41300700001)(5660300002)(45954011)(478600001)(8936002)(53546011)(6512007)(6666004)(186003)(8676002)(6506007)(966005)(6486002)(19627235002)(316002)(110136005)(36756003)(38100700002)(66946007)(2906002)(66476007)(2616005)(31686004)(5930299009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzMxeFp6ZjV6LzVxSTBkUUFJMnV0M2hqcG5GWWg2TVhqRGh0NjNQUkdOZW9F?=
 =?utf-8?B?YXdWVXRnY3RyaUw2SGRORXg5SHVxcVFRald1Mk9SaDhXUXFWWGtHWmttS05B?=
 =?utf-8?B?Ui9CK2RKc0paZWM4WlNOTktheDExRDhVRFhUWXhiekcrSkdTd0ZUUzdJNmFn?=
 =?utf-8?B?eFE0QmwrcEpZbW44L1hiVHpYVGNsL0VNNnZxcGFMM0ZTclpuWnlNeE9Tcy81?=
 =?utf-8?B?anhHcHlmZWtpT1Fzb1V0NGVQWHRDeENZRXNrY1lNcUcvRE0yMkNFZTJuOW1C?=
 =?utf-8?B?RTlYNG1TM1hvWk5GdUxQNllnWUNiWTJoeWtjSjBqV0Z1NHZ1d3lYVURmUXFN?=
 =?utf-8?B?U1NCeklWMlBONllET2RPOTF2aDAzeXRJSkp0Y0VtdEF0Zy9DcVRzTkRuS0NX?=
 =?utf-8?B?OSs1UUJWa3JqUG81TVpUeXlxMlZ4MWFBejZaYzMycklCajk5UG1yV3lSR3Ni?=
 =?utf-8?B?eWRSKzBxcDhuLysvV0NPVFBnbjR0YVNTVVNKSi9Sd2VVNDJEQVJYQ2QvM0NT?=
 =?utf-8?B?NFZYcXJFZytaV2hlNVNrbVQwMXhGQ0E1TWVpNFFMWlEweWlQTEpqVjhsd2NZ?=
 =?utf-8?B?dGFGYlh5R2tlWVVwN2Q5bHdUcDRBUkNiblZETDk4QXpYSE9RVmZjd3RnSHcw?=
 =?utf-8?B?My8xL3lGRUs5blBINVcrandzUTZ6MEVzTTE4dFMxbDJ3d21YUkFjOUgvQVF2?=
 =?utf-8?B?SnJVd21UL0JBazJpVjhheFVWd2xnOW5qMnQ1YXc3L2RtbWxPSDFnN3o3QWI1?=
 =?utf-8?B?MERVZVdDTnA4bEg0WExkK3ROa2toOXR3NURIQVVsYXdVNTV6VEo0VEtTQThT?=
 =?utf-8?B?S2pjVTdqdTRCTHZtRm1sWk9lcUZ2RTlSbys1VmZLbzJrUU5rVndNVno1eTdF?=
 =?utf-8?B?blRRZFZjVlRBQnRoK1dDZzBzb0xXMFdrbCs0eEx6WVo3QnVIby9pYU5mQ2ZE?=
 =?utf-8?B?Tk1KcnJpMFBJRXBZQXB5UkdDaU9WNVM5RW03cnlqRHdYazU5a0RrdnpaMXdm?=
 =?utf-8?B?NUU3aUhZT2FGTDA5OWxJS1BLU3Ria0xRZ2NwcGtydnBob3l4SHdkTENEb1ZD?=
 =?utf-8?B?UVh0SmF2UUdZU2J6K1JvUEczOEF1VUM5bXlXNVE1eWNoSUVxV3NEOWMzTkZ6?=
 =?utf-8?B?US9Ha0xtV2VocFBQWXRydXFUazR0TGpYV25Hbldyd3JPajQ4RFpkRjdUQzZa?=
 =?utf-8?B?Tkcxb3BmUGFwRVJkTnk5QUxYNUNIMk5PeFo2cmJGd1RxNmphRzd4MEo3bHVw?=
 =?utf-8?B?bzlIQjhQWVpCZWxWczM4ZTYwb0k2SDk2cDlEam5rb2RvRTltRzlLQjZBSHZT?=
 =?utf-8?B?Zk03b2pyKy9seWYvTmIwVDZrU0dkOGpOSC9STU1GbXVnczlIVDBFbVY1WXhh?=
 =?utf-8?B?MWhnODRTT05SNDVpM3B3eHJxaFJ5NDdndG9LYnI3RTJnRjZLTzZjSmNJNFJY?=
 =?utf-8?B?T3RlM25ZYktKRC9ybk9BdFliQWtjMG1LMUV2QWpTaTl2VWViZXd4WjhBK2Uw?=
 =?utf-8?B?N3ZqaUxsb0g2SUgyYi9LRjdZMFJBeGx3NjJrQzdTSjc3T1lFNUJPaFNaODlC?=
 =?utf-8?B?U3p5NEE4QXFjM25hYk80cU5XV1p0b1BmbUp4bFFiZjFNeWJyUkIza2R4bC9C?=
 =?utf-8?B?MGhmWDJaWHpmNjJ5N1ZpN3BTZkpKNEwxMGorR3NJNnlaN2htWDFaQWtoVVow?=
 =?utf-8?B?SXQwNTJMNWNtOXpEWmVXdm9jWGRveFF3amdtRkRKTU5vRnZSbjl4bXFmTThE?=
 =?utf-8?B?VDZQaE5zcjZUN0hyemZJVjBUbElMTlJXeFVOOUJLczU4dlhFTTRjU2QrN1R6?=
 =?utf-8?B?THNzNTVGMENLZmlMZ2lnSFpZdU0zMGlLTC9TMHZzdStPREE2MWhkbXhRTmVL?=
 =?utf-8?B?ZE83Zm9xM1I5Q1pHQW5aMlBTUnlFSWRqLzBTaWdNOGEyRi9LQXd5MU5GMlZx?=
 =?utf-8?B?V1lQci95TldHZUpERHFIVUZnQ21DSTN5aEthQllaeEZ1bHM2YUNlandpcmsw?=
 =?utf-8?B?YVM5bTU4azBLRmIxTjBjZ1kyTGhITkVZZStSalNBVWRnRXl4Tk50UWtSZXRr?=
 =?utf-8?B?c3VKTG5XM25xejBGVndxaWZBWHVvTlZGMDlOMVFiOFZZY1NTYkpGVWxreXYr?=
 =?utf-8?B?REZMQ29BcWhUZFBQVzhTdDY2SnJFa0lYNG5CMGVrenl4Y1lrekkvanlVcXoy?=
 =?utf-8?Q?JJ4uqOXFRHLSecRkpDLCmJc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9803aa4c-8711-4c2c-fb28-08dad3797d44
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 08:53:19.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UR4+C/TYKy48D7gLxg6Ea/YVgi0ThD4aFBFm/YWjUGuAed2/G5+VHgvwhqi1I/eM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9427
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,BITCOIN_SPAM_02,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        PDS_BTC_ID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/1 14:52, Hendrik Friedel wrote:
> Hello Paul, hello Qu,
> 
>>> >This indicates you have a physical problem with your disk - I would try
>>> swapping the cables. Try and fix this before you do anything else.
>>> >
>>> Yes, I think so, too and I will work on this.
>>> What I do not understand:
>>> Why does BTRFS not cope with this without filesystem errors? I mean: 
>>> I have
>>> two drives. BTRFS should mark this one bad and continue with the other.
>>>
>>> Is this expected behaviour?
>>
>> It looked like only the free space cache was corrupted, and that can 
>> be rebuilt without losing any data. I believe there were a few 
>> problems with the v1 cache that would cause that occasionally. I've 
>> personally had no problems with the v2 cache when I accidently unplug 
>> the wrong drive or bump cables.
> I have now set the SATA Link Power Management to max_performance. This 
> has fixed the stated
>        homeserver kernel: ata3: SError: { PHYRdyChg CommWake LinkSeq }
> errors, except for during boot, where this error still occurs.
> (replacing cables did not help).
> 
> I would think, that this error occuring during boot once is acceptable, 
> especially as this is a server and does not boot often.
> However, even though the last boot was ~24h before and the system was 
> behaving normally since, I have had a very slow system yesterday 
> evening. Load was >7. Clients accessing by Smb were hanging.
> I have had this issue intermittendly for some week or two now. You can 
> see the load vs time on three graphs here:
> https://drive.google.com/drive/folders/1MvLaRsgn7tFu55UMVTZfUT1PwXeDTXLo?usp=share_link
> 
> When having this high load, I see that btrfs-transacti is 
> blocked/waiting when running
> ps -eo s,user,cmd | grep ^[RD]

If btrfs-transaction is taking up a log of CPU (btw, scrub and read 
won't cause new transaction at all, thus your read perf is not 
affected), it can be that qgroup is enabled AND there is some large 
snapshot being dropped.

The only situation qgroup can hang for a while is when there is a large 
snapshot get dropped.
This behavior should be addressed in the next kernel release (although 
need extra tool to modify a new sysfs interface).

If that's the case, you can disable qgroup (which removes the ability to 
know exactly how much space one subvolume uses) as a workaround.

Thanks,
Qu

> 
> I have checked the filesystems (btrfs check) without errors. Also a 
> scrub was fine.
> 
> Scrub started:    Mon Nov 28 23:49:33 2022
> Status:           finished
> Duration:         21:16:17
> Total to scrub:   20.10TiB
> Rate:             270.53MiB/s
> 
> You can see, that the Rate is rather high; so at least the read 
> performance of the drive is fine.
> 
> I tested the read-performance:
> dd if=/dev/zero of=/srv/dev-disk-by-label-DataPool1/test.d bs=100M count=50
> 50+0 Datensätze ein
> 50+0 Datensätze aus
> 5242880000 Bytes (5,2 GB, 4,9 GiB) kopiert, 43,5399 s, 120 MB/s
> 
> This also seems ok.
> 
> during that, these processes are blocked:
>        1 R root     ps -eo s,user,cmd
>        1 R root     [kworker/2:0-mm_percpu_wq]
>        1 D root     [kworker/u8:8+btrfs-endio-write]
>        1 D root     [kworker/u8:7+blkcg_punt_bio]
>        1 D root     [kworker/u8:5+blkcg_punt_bio]
>        1 D root     [kworker/u8:2+btrfs-endio-write]
>        1 D root     [kworker/u8:1+btrfs-endio-write]
>        1 D root     [kworker/u8:11+btrfs-endio-write]
>        1 D root     [kworker/u8:10+btrfs-endio-write]
>        1 D root     [kworker/u8:0+btrfs-endio-write]
> 
> But I suppose this is normal.
> Smart values also seem nominal/good (I can post them, if you suspect a 
> drive issue here).
> 
> So, what could be the reason for these "hangs"?
> 
> Best regards,
> Hendrik
> 
>>
> 
