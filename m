Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA7B4D94FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 08:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbiCOHEP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 03:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbiCOHEN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 03:04:13 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C7D64D2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1647327778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6QpRSX+ACjcEr3NK1YMHV2fUTI65TDGBTomu0lemrRE=;
        b=KHKc2EaKBdGVYMFtMtZtgX3OGuVRbk/GipaSm1fTiddGPdFgQuRYucBbUTkjSqU0V0A7nO
        ZZGoPfrVHd/8Qkle2z51ULJ+FMhOM9Uu7+tjDRSy2MG3w8UQfBEuZcPBVCTXQ87KUxLquL
        8x/JREAr9essKyeFdpnTtFK7nWpyAWg=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-xlp-cW0YMwamJjaKkMltjg-1; Tue, 15 Mar 2022 08:02:55 +0100
X-MC-Unique: xlp-cW0YMwamJjaKkMltjg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=armYzduxQ1BJDIh4PjR4S1M5BPOsZSJvMkrlj9KIiEeW2sdMWtGyf5cphita7ShEp8/hoOsHLswPTuqIiru6NdHTScfh/qAkJN9IwUQ7lv6MyYAtiOUFI8TNZxCdNiv6Wzm1q6z2noYp+AqkNOwbeht/NB79yncZZY9ChHXAB/M0K7Lzrd606wWgG7sgshwf2b56ANuIyHayPoHwGyUl91FWphcRZQ6X+LL+07bsV5jOXfH9AXtjVcZ4lu10STzLUo4fXxn1qOI6aiON/+bHhE/rk7hAj7SxJyZpicv+DGkFKLwbudL4TndEtzgHISnNRDkr3VCtt40BSoxqjPGu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QpRSX+ACjcEr3NK1YMHV2fUTI65TDGBTomu0lemrRE=;
 b=XTA7BWdIytriuC1sVY1y9u0yXAgUIHc0alKoi9PcvRknIOp/1L4cBP6pRwTqg/JlJT9thGExcPLu+2+EL1P5cHPzylPD4ZFGAC9yVKb5P/QuBOoXv6DOVUpqxR5wyXlb1A/V1iJcApTelh227o9dPDQ1CpI5Y5+8U2oAR++IKzDmrTUFTNBvB+TRBwBB5NSQvoTfrN/cRSH/oRG44D/I0D6bpwUmD5BQvtZwgUF50f91fT7a9w8YhaR05w+36Ok7ZnJsEi0NJ+lwgGYlOzT3gk88OnRtLXnqZJ6f6H8vg52NfAZpFFxr7gAPPO5/RbdCb6i8xHymTx+wMbKg4ACNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by VI1PR0401MB2397.eurprd04.prod.outlook.com (2603:10a6:800:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.29; Tue, 15 Mar
 2022 07:02:53 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::39f2:9041:54c:eecc]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::39f2:9041:54c:eecc%7]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 07:02:53 +0000
Message-ID: <260f924b-e434-c49b-0c39-a09dbf61ac19@suse.com>
Date:   Tue, 15 Mar 2022 15:02:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/9] btrfs: refactor scrub entrances for each profile
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1646984153.git.wqu@suse.com>
In-Reply-To: <cover.1646984153.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca1f963-de2f-4d38-b729-08da0651d31c
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2397:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23976EA776834F909EC70010D6109@VI1PR0401MB2397.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvBpCY7t6gZ6ok0nLdjKxPdvW5NnVIspm6pizq7UkYuMgk6Vr+8J6lKaeycDl4n84qX8aT6GgSZrRGWyr6tFfpeNm6q/hPdb2pjpt+kIZVztbxmvCEBWjXHZO3+Wk43OEXC/+voOZcTR4mm21I4DLrFwafSOfRdB0lmXCVXKT1BhZIOtSlKhgHN7N12LrTkGu9IPxGfjKm2Mu8Zc24I+4ngRrXTSqPJ5BDMAq2fu+Y0dZKkMIcADMJ0d5QYrsawb4kOyV8B9AfterXl4drayEuJnQ7PrzbH555leV0o5E0A0bBQCR40fx/kHyHo2ZE+fySYeygtt4rzuE72DYbQtTQufRa66z1R1cx025uESOES1sfxXXOfufPx+j5hzVaOCJ3MioJaJkmIhRyO9y38OCwPXyw6NjLfsL3VVitzNyh/C3dtg5QspIua9K+YmPc8Ya+71PHWqrCsHqrJXBjLOenLi0EHX8Vcg1mgz6GaPOE1IZA+V3PzBUVwVAhY/3lhs7ntMlJmAw4adlHS19Si3CkaJxyEuHsQCOfDNY67SjVrhFTsjKNN0HCS1SD9GCMzX60+WlBCBtw5DN2ldJWx2ZL/6FXeplTnP3v0P5sJc65y9qVxYjMkj7KnS5slFWjZSZp/YozjeZlVK40NhXTWSfi4w1D4t6mz0zbxnDLJq7XQ0m8qXd+XuOjpUFbOqoaLvLkOFAhrlbSGf6vOeUSXfCx1eCmdHAxroQG8nevqdE9/awTQ42eZLFjUlzbhsyT9tZQEAMW8/ZImP8aSue0E5Y1vHUE09r+av5b+Wsh/EmC+qj4vOWx2PM+GAS2I+0IZT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(6666004)(508600001)(6486002)(966005)(38100700002)(53546011)(66556008)(66946007)(8676002)(66476007)(2906002)(5660300002)(86362001)(2616005)(186003)(31696002)(316002)(6916009)(26005)(8936002)(83380400001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkVIYjhkbjEva25iMllRTmtWL0pXanNMWHZqZFdLUWtHUGNsQU9SM05Cemk2?=
 =?utf-8?B?QTJ6RUo3UlJ5dDVHYXdPdGEreDJhd2greTZzNkVWVFdqcFA4ZHh4ZzdmZkZN?=
 =?utf-8?B?aWNTQ1dnQWF4OHMydGdzbDVvLzcwTFlqZDRuN0Z4UFlPTzdPZFFkcWxycXNm?=
 =?utf-8?B?VFNDRHdFc0dlcm43cGZmU2NwYjQrY05JZm5kb2Q2VTkwTjJ0V2NER2dEMDVw?=
 =?utf-8?B?WWU4OTZ6THlaVm80Mm53OEUremtaeDNyc1hHaTdDK2p2VkNlZWlJczFMaTFs?=
 =?utf-8?B?djlYRWdlNXA1M0pDMG9lVWZMc01xVDV4Y1Fxd3VoYVpEeXpmRGZzMkFId0pM?=
 =?utf-8?B?ZVJLWVgySHdSMFh4ZVZ6L0F2NGRPVCttWE1tRG5oTlBWNzdzRERyOG8xSjN0?=
 =?utf-8?B?NzZ1N3lRejRGU3hhcVJ5UkR5Y0ZBNU44cldKYUppT2VPTGlCK3U1UzkyT01T?=
 =?utf-8?B?T1BoV0dhT3ZZeExLN1lPbVRmdFhVMGdtdzdJY2MweUdXNEkyamlRU2lTbXlO?=
 =?utf-8?B?Qlc2SmhkbStZc3ZvcitpL0MybTU2bmlmbTZQYlVoTlJzU3N4c0ltQTQ3bzBy?=
 =?utf-8?B?RWszTE1pcGRKbWsxNmxhbUdPV21GNXlpMzBzQ3g3aXlLb3hHZDFNelJpM0tw?=
 =?utf-8?B?MTRNVHo4UTdNcXBtUzQ4U3YzVUxlU0VVZG8xYXY1VzhpZUxnMmhHbmd2d1JT?=
 =?utf-8?B?a3A1dDdRZ3FEaW92ZW1XNlh3cVV1RTdRUWVlT0d3Rm1KY0hWNUdHbm44dHFL?=
 =?utf-8?B?eXBqQU5hWUNUYVpzcjN0TGxDNVhueTk2WE9oRmJRUXBEYk1QUzQwdFJ1ek8y?=
 =?utf-8?B?SUEyWmtYRkJpbS9qNXlFR3JZekhoUnVwYUd1b21rdmVFNC9jNkN0Mm9qK2dD?=
 =?utf-8?B?dU9HaHJUS1BkNHNTNFZpOHM4YXJSVHpTT3lLZ2hzZHBIZmRCUCtmYUZ6ZE94?=
 =?utf-8?B?Ti80MnRjODcwV05lMFR5emRWdkR1RzFWN0dFZ3J4TlM1ZTVEcDFUZnhZSEov?=
 =?utf-8?B?VXpTcmlQOVFob1pZSmRuUHphdnpBN014R21sc0cwTmEvMktlNFp3dEpaaUw3?=
 =?utf-8?B?SDArelUyYytXSTUwT1d3YlF6T0Y5SjV6cTVOby82NFZXWWcyQzdxdFpkeVdk?=
 =?utf-8?B?TkVXSURnZHJuMVVSVTZERjdnR2dYQXNhYUNlRHBveFN3SS8xRm5WZVYvUGht?=
 =?utf-8?B?em85VjNtUk9xRE5ib2ZlY3VSZ0VQMEI3N0tod3NBNG9WdkNzNFc3eGl0VFJP?=
 =?utf-8?B?K2JEUlNsaGZCNmdYdExZQ2h6MVQ4Smd5Z05wNnRPbDlzVjRIaDVkcWJMbjVI?=
 =?utf-8?B?dG1MNTdMNGdVOFhuVG10cnNVa1lJUnpPWnhVcU55WWJDeFk0MVN4NS80MnBo?=
 =?utf-8?B?VWJ6amU1QnVqT3dPY3hsRE5GNTZYTjgzRWVkeHQzZzlGUlIxQkNoQklOU0J2?=
 =?utf-8?B?Z2ZtWmZrdXZlN0picEdPbjZ3bC9EZGJLOVVldWJDZlhMSWNPb2ZKZEtVbndn?=
 =?utf-8?B?TjYvMGkrWlNGcUFMVmFsVjg5WjdKd2xDdzVsMXA3Sk9nNzJDOHlFWXdwSUVH?=
 =?utf-8?B?NU83RmNLb1F1ZW40dHgzZTBWQTJkcGxGeDl4REozWG02cVVrYk5FNkJPZDlx?=
 =?utf-8?B?amV2RFlJUU92UXhWSTdNRTJzTWllc3RtVGVyQ3dYcnAvNE94SklPQXhWQzNo?=
 =?utf-8?B?a3NFL21EcDdJWnc4V1I1dG9KN1RTbk5FVTAyeVBFOFlOYVFhaHM0L3RMd3h5?=
 =?utf-8?B?WnpOUGZkUzBXVDJFeUFtakROZzIzZjAvYnpPdStNangweUJqcGx0OVZiK2JH?=
 =?utf-8?B?eVdZVjgra1k5ZkNGdGh2T1V4MTh6S0s0TzJrUmswLzJQZFVQZGZBclRVRnBt?=
 =?utf-8?B?bUwxNkY4emZaWjVWTnpFaVVDcXA3K29SL0NIbGQ0eWljRlVSbWRXcUVONlVt?=
 =?utf-8?Q?C6tg1uJHLho=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca1f963-de2f-4d38-b729-08da0651d31c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 07:02:53.2525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZvHkGmgeGau+e0Fdrnz8DGdhlWLub3R3+uuRqcY+CfA+L2su6KZIcf9bYVvZfO0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2397
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/11 15:38, Qu Wenruo wrote:
> This patchset is cherry-picked from my github repo:
> https://github.com/adam900710/linux/tree/refactor_scrub

Just to mention, the branch get an update as misc-next now merged the 
renaming part.

The good news is, this entrance refactor can be applied without 
conflicts. So no update on this patchset.

Thanks,
Qu
> 
> [Changelog]
> v2:
> - Rebased to latest misc-next
> 
> - Fix several uninitialized variables in the 2nd and 3rd patch
>    This is because @physical, @physical_end and @offset are also used for
>    zoned device sync.
> 
>    Initial those values early to fix the problem.
> 
> v3:
> - Add two patches to better split cleanups from refactors
>    One to change the timing of initialization of @physical and
>    @physical_end
> 
>    One to remove dead non-RAID56 branches after making scrub_stripe() to
>    work on RAID56 only.
> 
> - Fix an unfinished comment in scrub_simple_mirror()
> 
> v4:
> - Rebased after scrub renaming patchset
>    Only minor conflicts.
> 
> - Fix uninitialized variable in patch 6 and 7
>    Now there should be no uninitialized even only patches 1~6 are
>    applied.
> 
> [CRAP-BUT-IT-WORKS(TM)]
> 
> Scrub is one of the area we seldom touch because:
> 
> - It's a mess
>    Just check scrub_stripe() function.
>    It's a function scrubbing a stripe for *all* profiles.
> 
>    It's near 400 lines for a single complex function, with double while()
>    loop and several different jumps inside the loop.
> 
>    Not to mention the lack of comments for various structures.
> 
>    This should and will never happen under our current code standard.
> 
> - It just works
>    I have hit more than 10 bugs during development, and I just want to
>    give up the refactor, as even the code is crap, it works, passing the
>    existing scrub/replace group.
>    While no matter how small code change I'm doing, it always fails to pass
>    the same tests.
> 
> [REFACTOR-IDEA]
> 
> The core idea here, is to get rid of one-fit-all solution for
> scrub_stripe().
> 
> Instead, we explicitly separate the scrub into 3 groups (the idea is
> from my btrfs-fuse project):
> 
> - Simple-mirror based profiles
>    This includes SINGLE/DUP/RAID1/RAID1C* profiles.
>    They have no stripe, and their repair is purely mirror based.
> 
> - Simple-stripe based profiles
>    This includes RAID0/RAID10 profiles.
>    They are just simple stripe (without P/Q nor rotation), with extra
>    mirrors to support their repair.
> 
> - RAID56
>    The most complex profiles, they have extra P/Q, and have rotation.
> 
> [REFACTOR-IMPLEMENTATION]
> 
> So we have 3 entrances for all those supported profiles:
> 
> - scrub_simple_mirror()
>    For SINGLE/DUP/RAID1/RAID1C* profiles.
>    Just go through each extent and scrub the extent.
> 
> - scrub_simple_stripe()
>    For RAID0/RAID10 profiles.
>    Instead we go each data stripe first, then inside each data stripe, we
>    can call scrub_simple_mirror(), since after stripe split, RAID0 is
>    just SINGLE and RAID10 is just RAID1.
> 
> - scrub_stripe() untouched for RAID56
>    RAID56 still has all the complex things to do, but they can still be
>    split into two types (already done by the original code)
> 
>    * data stripes
>      They are no different in the verification part, RAID56 is just
>      SINGLE if we ignore the repair path.
>      It's only in repair path that our path divides.
> 
>      So we can reuse scrub_simple_mirror() again.
> 
>    * P/Q stripes
>      They already have a dedicated function handling the case.
> 
> With all these refactors, although we have several more functions, we
> get rid of:
> 
> - A double while () loop
> - Several jumps inside the double loop
> - Complex calculation to try to fit all profiles
> 
> And we get:
> 
> - Better comments
> - More dedicated functions
> - A better basis for further refactors
> 
> [FUTURE CLEANUPS]
> - Refactor scrub_pages/scrub_parity/... structures
> - Further cleanup RAID56 codes
> 
> Changelog:
> v2:
> - Rebased to latest misc-next
> 
> - Fix several uninitialized variables in the 2nd and 3rd patch
>    This is because @physical, @physical_end and @offset are also used for
>    zoned device sync.
> 
>    Initial those values early to fix the problem.
> 
> v3:
> - Add two patches to better split cleanups from refactors
>    One to change the timing of initialization of @physical and
>    @physical_end
> 
>    One to remove dead non-RAID56 branches after making scrub_stripe() to
>    work on RAID56 only.
> 
> - Fix an unfinished comment in scrub_simple_mirror()
> 
> Qu Wenruo (9):
>    btrfs: calculate @physical_end using @dev_extent_len directly in
>      scrub_stripe()
>    btrfs: introduce a helper to locate an extent item
>    btrfs: introduce dedicated helper to scrub simple-mirror based range
>    btrfs: introduce dedicated helper to scrub simple-stripe based range
>    btrfs: scrub: cleanup the non-RAID56 branches in scrub_stripe()
>    btrfs: use scrub_simple_mirror() to handle RAID56 data stripe scrub
>    btrfs: refactor scrub_raid56_parity()
>    btrfs: use find_first_extent_item() to replace the open-coded extent
>      item search
>    btrfs: move scrub_remap_extent() call into scrub_extent() with more
>      comments
> 
>   fs/btrfs/scrub.c | 1037 +++++++++++++++++++++++++---------------------
>   1 file changed, 559 insertions(+), 478 deletions(-)
> 

