Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B684DAC8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 09:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354478AbiCPIi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 04:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiCPIi0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 04:38:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6E463BE5
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 01:37:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22G82Bhj003496;
        Wed, 16 Mar 2022 08:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9kdmnAOgRVyOlb+qw4WyeebpKm4pp2gPwadlZvQz4/w=;
 b=AXxElZ54HOalPtPVTfmELNKFWmdYxCcCzWiJUaqzexX/0lSan54C8cBvmJK0KLmR+8N4
 F8JGIDC/CmAs//z+wHBpjUlBzuBVxLNAB8jIVliRdCPJIYL4ErSZpALWXSFUrw9dyUZD
 oKv4wul2b9c0NWMvEPZsp/OAp18WuUGJzebBxTN4DwZXGDwhuEnRT/JfEvn8ugln/iyt
 unl8Xi4Ewgji23e1wzb7V4/rS/ycxImBkox7TGeTbwWSM69l4mqyLOc/D0qWMT0PaCaV
 xiWRskGWaYpAzfR8WZvDV6o/EV88Bj4XVmIp20NnIzM+vyabc0TcmrAKCKa4UWDqml47 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et52pwg2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 08:37:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22G8W3KY123122;
        Wed, 16 Mar 2022 08:37:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3020.oracle.com with ESMTP id 3et64kheq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 08:37:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U83/8x/cvg4LaNpRfbmLWNrwwkhae+qUnQD6kkWuWxrI6jR0rhk6EvLnm1RkzJbTMbKY9qLSMSwXC3oa8hN+/gdNZK8lE/RvAZTpwHlY4jpEmi+OwgUNjTgZlFEQnWUNHfMpkCGTLZ/wOmssH9591Ur9WEkFl/WZEzOQYEe71m+/I8UTVJIQyAETaZCTt9P5Uo604DtF+fflhL3tV0MWkOS8MxeG1nufQ/3ENWa9Xng4zAkQVQRYRKHZO9GPHg1uZtKrvZGn9uT3aBwxVPtokcRD9WhILluiJ/nPmjeI/lhoEZKJgJjR3AtkcWRltEyXpb8Vdy1oSikE4qQJ2YbM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kdmnAOgRVyOlb+qw4WyeebpKm4pp2gPwadlZvQz4/w=;
 b=Ekds8q2kGzt724FWOkR4DB9xGTxsJ4vd26s5d3mu9kSYGBHKxZROH8+Zpea7VWuC1vpHW3hTg4lgqeyIGBtQ5fZB0OiOMqmyjiv2Guvy/ow62B9Na8pyKMVG35qwBbUfISYFgrjAnXectdXCFG4ER/WS0UK7Mf65eHrX8xGasxUJ0zHdpIM4EQLG7G3szoERhfPfO8tY8/1gmDr1436I22gSThzUMk5rxncIEo4Ca9AoFm3JyYoTli+Gp/VCuJ+IFUUzW5WcYZgEAQF/aFPq3djRtJnQMmnpL6O1gPu/pFb1MixcwwR141BTvGJKOma+hi9goS1LOLZ620GIE06aIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kdmnAOgRVyOlb+qw4WyeebpKm4pp2gPwadlZvQz4/w=;
 b=TYI4Cv+nANzznQZFm/F3bTpzJxE0L6ZrvCfOu75qvtxVO86Tuynyv44ZRY9vgfN6NlesgAbPvT5WyRZcNS3VtSTqPQ9ErwrD1zt7TiJcgscC+4daEegba2KtYJhVElODapth9Dt3RnmI48F5b2132/j1AnlJaQ5Yj/WvL9/gJME=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM5PR1001MB2185.namprd10.prod.outlook.com (2603:10b6:4:2f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Wed, 16 Mar
 2022 08:36:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 08:36:59 +0000
Message-ID: <4af521e5-82e3-f21d-ede2-9da3fd990fe9@oracle.com>
Date:   Wed, 16 Mar 2022 16:36:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: zoned: use alloc_list instead of rcu locked
 device_list
Content-Language: en-US
To:     dsterba@suse.cz, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
References: <f7108349f3a7d690166c88691c5dc1932cab3610.1647267391.git.johannes.thumshirn@wdc.com>
 <20220315200330.GW12643@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20220315200330.GW12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24de3648-a0a8-4578-dfbd-08da072822da
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2185:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB218522823B2F0BC160F35BD4E5119@DM5PR1001MB2185.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPPYBrUFdpKDK+mHMfLw8dAw5r2BvmVJUNUkN4hHkRuDrzNdtgRXBEmGFp/6EQX2Yxd1w8HWUxFUM0HnCG3mrjX1mwE0kbRnwYwVIh5VGwKurNQSnxqK9k2+h0E6vDkVP1dT/2Ewa/Y4i/RRV+oSNaxmotLUGO7empWrDwOiJQyxa43K9oSlH8BvLYxvF31Vz2m4PeBXbRzPRaHfl8icF8N+iFsSk6tIY/qqHBxr2WN0x+DobHVWb2sjYTPUtM3/gmZIynBY8fdzFg1qK6V4n8TvQMupfx7OuGhfpHQTtKS7sgQ1Fef1ACDmhOldBDBkjB9tF/LeJrZhAvoIpOUIGvWrS8yF0mS4K8dbsrepHTKn9kwQ59W+becaOL7Szdst697rmYUOfrGm/Rdw5zszWgxyc3hG73ckZbGkICuj/7v/TcZTWhxRM8SzMMS9xgV7grI1o9DB0xRL57H8Q7cj56jarA8Mtncwx+s4f/kZty5NBSGwFrUxVOnLVWcObBLFTeq2lJ8qd4CC8Grx1LLdFNYwli8jhatkKk0Who/igXYo4rbxtUCq00KQZ3f1OztIaKrGexfRqMS9QGCtH4V3stwdjlL3K1SUS+3Uj5w/vppZT0C2e7qlDBocAQ/qY7HY8FM/kBEIYNTlpETOIhYtoPXkSgs0Wb87RpxwmeRGJCd/37bAzWhk60HRalDgnby6pVtUUz6xLTyj3u5MjCuJdehl2Tmf7ieIFhoDsgY/0R8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(38100700002)(6512007)(6666004)(6506007)(186003)(86362001)(26005)(83380400001)(2616005)(2906002)(508600001)(53546011)(4326008)(6486002)(44832011)(66476007)(66556008)(5660300002)(31696002)(316002)(36756003)(8936002)(66946007)(8676002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVA3NGpLK0dSd2xrK3pjZm94Ni9DSFVKTElrbTI2UTFQQk9yMjNUVkRVdldY?=
 =?utf-8?B?Z21DN2psckVHYzJudG5xSFlnVUh6eWoyd3FIeWRTYmJlUXlWRE4ra2R6Q2tO?=
 =?utf-8?B?bjJxNHUvUDJkVlpDSXE0aW1uNXRna1YzK092bm5jS1dtR0QxL1kxQnV5ZFY4?=
 =?utf-8?B?UXAzdEdFNnBtTlpHa3ZUYm1Bd0ViWjNBUTJWb2tINkhnOXNGQUxEei9icjAx?=
 =?utf-8?B?MWlVTVdMOWFyVEVUcFJHUmt0akF6cE9FSVp0cFM2aHZFMm8xODFxNGpRWDBH?=
 =?utf-8?B?dFI0K1gwb09aOFp6ckdjMDJTcXFNSEJWWHV3d3UrQXN0dlloSUpOT2U3THgv?=
 =?utf-8?B?RjBEb3NwT2lJUVZYUXhFWlFKcEhiZkIvWWh4Q2tlZGNlZGhSdEZlN3JLSjh0?=
 =?utf-8?B?OThIT0EwTEQ2NWtBNUNVaWFmeUZMRnRMdVJZckJqOTJlVTMyaituTmVxZEdQ?=
 =?utf-8?B?cGFJVkhNSFcyZkh6b1FrQ2xWRGZCRmlSQXBqUlpvcXpIWEVPaWsrVjNpYS8w?=
 =?utf-8?B?akdTcW1UbFJOMlZETUk5ekxSWXhkL0djSndvRmNHL3RsRFR5eGkzSm0rN3Fq?=
 =?utf-8?B?dGJuemJoRjRwUFZyQzlMNG9UbE8zQnltSzRxMk5GZjFzRjJWV2s3WC8rcDVl?=
 =?utf-8?B?dE1YOVp1bkhPR2JRM2lFOVIvdVVQU0dYc0RQaVZDSEFFa1BHa3BvWGpLTmJp?=
 =?utf-8?B?dzMwWEZBZngyWHVjRGlrYjArRmRjMzhCenlmUTk0RG5UZXhzYjJ6c2ZoWmpE?=
 =?utf-8?B?cThqTEZuRzJvU08wS3k4RVI0UmUrbmZ2SFNHZlU2TjFmYlNzUDREMDlrZFZD?=
 =?utf-8?B?UGdVWXgyK3N0NkdSS2VnY0JmZlZ3NE50U292WDYwQlFNbFNUdUd1aWQ3aDZp?=
 =?utf-8?B?RzZtYzVLL1NwdGJTbklsNHVVZHJOR0gvTjA3UDN4SUtqNTlJUkx0bUl5aXZY?=
 =?utf-8?B?cXVvK3ZJZnYwUjY2a2FwT0VzbVhDMGJmRlJnMWtiNS9mWUZnaEJvNHRyOWY3?=
 =?utf-8?B?UGpiS0FuT1VWUFNMMTVKMEs2MlU1eEN1Q3lsZWdHOTE3dWtTeGxhV2x2dzJC?=
 =?utf-8?B?MmpiemNMc3V0cE9vc2gzQlJkNGFDY1lRU1JZeW1ZVmNwNXFVemc1NEFJUXMy?=
 =?utf-8?B?TVQwcnNZVlBCZE5TbHpwdjlyY1N5M2JLMDRURUx4TTZHcEhKa0M5dHQ1dkxx?=
 =?utf-8?B?a29HOG1zZjZpVVN1V3JpUElVK3pjU1hTNmNaekREZGdWRHFFa1IxbHM3LzJR?=
 =?utf-8?B?MHR3TWlLM092cHRpTmt3U2E5NjQrSFhJTHZUR2lKemQwbFl6K0FWL3N4aTRX?=
 =?utf-8?B?cU1sVCtmTzJCNXVubEpMNnB6dFhDNW5OQU5MQnUzWURpMXdLNXRiVUdxaGty?=
 =?utf-8?B?eFBQNjZDbHZDTG0xUjJ4QllIZWtzTnc3enlkakZlWExPWXh4akRqRXBrMytM?=
 =?utf-8?B?Y2RYdHRnTmQ0dmRoaElsOTkyK005ZmhmSFNJbjA1TFhENXRCU3hJUlg2K1BI?=
 =?utf-8?B?aElFamxzSnF1OHR0eWVnWjEvTm5FMFJaNVBKK3NIUDYyY082aWpZUkIxdE5R?=
 =?utf-8?B?dU9yNTkrcWllcWovR1Nidll1SEx6QXo0SzBNeStzQkcwbjA2c0RtbkVZaEov?=
 =?utf-8?B?RnlxbGU3S24rN0RQbHpNRHZIa2NoN1R1bDdNZmxIbnFBZm1hY0NaejduSzNs?=
 =?utf-8?B?SFEyNi9iN3JYTFFNVEp6bFROdE5SMnJvOGx0YWJ6NFJtSFExY1pHRkdTL0Zq?=
 =?utf-8?B?d1J2bVI1TVgraG5iYmNvSkNtQnNUSkVTTWZzRVZQSlkxQldlbWpwdmxFbWps?=
 =?utf-8?B?YittZDhJMUdzTzRrQi9SU3psNkdSdktudkhWdFFHY0RLR0ZkZmIwNVZzcU00?=
 =?utf-8?B?SVl6WjZvVW13aUZVMWkzYjBuWFE4UWF3WjZ2NUkycm1QRS9xS1dVSG5WRUpm?=
 =?utf-8?Q?6w7LcjozkqgMqbOg6ErLSbMUWISeJdQr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24de3648-a0a8-4578-dfbd-08da072822da
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 08:36:59.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2h9TB7eNWO3sQ237DQbFhTsQdxX0+WPeFKbTjSbit8DjlHIIgnpC2LbO2Vxo5zvspOmrZSvlFVOUYn85VxeMZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2185
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160052
X-Proofpoint-GUID: Fsfq4LY-e0bfmpf_arbq59zq1BnNTMnX
X-Proofpoint-ORIG-GUID: Fsfq4LY-e0bfmpf_arbq59zq1BnNTMnX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/03/2022 04:03, David Sterba wrote:
> On Mon, Mar 14, 2022 at 07:16:47AM -0700, Johannes Thumshirn wrote:
>> Anand pointed out, that instead of using the rcu locked version of
>> fs_devices->device_list we cab use fs_devices->alloc_list, prrotected by
>> the chunk_mutex to traverse the list of active deviices in
>> btrfs_can_activate_zone().
>>
>> Suggested-by: Anand Jain <anand.jain@oracle.com>
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> With updated changelog added to misc-next, thanks.


Misc-next hit an NPD for new chunk alloc.

---------------------
[  552.785854] BUG: kernel NULL pointer dereference, address: 
0000000000000013
::
[  552.785872] RIP: 0010:btrfs_can_activate_zone.cold+0x5b/0x71 [btrfs]
::
[  552.785932] Call Trace:
[  552.785933]  <TASK>
[  552.785934]  find_free_extent+0x1233/0x1430 [btrfs]
[  552.785960]  btrfs_reserve_extent+0x147/0x290 [btrfs]
[  552.785986]  cow_file_range+0x173/0x4b0 [btrfs]
[  552.786014]  run_delalloc_zoned+0x25/0x90 [btrfs]
[  552.786041]  btrfs_run_delalloc_range+0x174/0x5c0 [btrfs]
[  552.786066]  ? find_lock_delalloc_range+0x25c/0x280 [btrfs]
[  552.786096]  writepage_delalloc+0xc1/0x180 [btrfs]
[  552.786126]  __extent_writepage+0x156/0x3b0 [btrfs]
[  552.786155]  extent_write_cache_pages+0x260/0x450 [btrfs]
[  552.786185]  extent_writepages+0x76/0x130 [btrfs]
[  552.786214]  do_writepages+0xbe/0x1a0
[  552.786218]  ? lock_is_held_type+0xd7/0x130
[  552.786221]  __writeback_single_inode+0x58/0x5e0
[  552.786223]  writeback_sb_inodes+0x218/0x5b0
[  552.786226]  __writeback_inodes_wb+0x4c/0xe0
[  552.786228]  wb_writeback+0x298/0x450
[  552.786231]  wb_workfn+0x38d/0x660
[  552.786232]  ? lock_acquire+0xca/0x2f0
[  552.786235]  ? lock_acquire+0xda/0x2f0
[  552.786238]  process_one_work+0x271/0x5a0
[  552.786241]  worker_thread+0x4f/0x3d0
[  552.786243]  ? process_one_work+0x5a0/0x5a0
[  552.786244]  kthread+0xf0/0x120
[  552.786246]  ? kthread_complete_and_exit+0x20/0x20
[  552.786248]  ret_from_fork+0x1f/0x30
[  552.786251]  </TASK>
-----------------------------


We should use fs_devices->alloc_list with dev_alloc_list as below.
Also, missing devices aren't part of dev_alloc_list, so we don't have
to check for if (!device->bdev).

--------------
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7da630ff5708..c29e67c621be 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1984,12 +1984,9 @@ bool btrfs_can_activate_zone(struct 
btrfs_fs_devices *fs_devices, u64 flags)

         /* Check if there is a device with active zones left */
         mutex_lock(&fs_info->chunk_mutex);
-       list_for_each_entry(device, &fs_devices->alloc_list, dev_list) {
+       list_for_each_entry(device, &fs_devices->alloc_list, 
dev_alloc_list) {
                 struct btrfs_zoned_device_info *zinfo = device->zone_info;

-               if (!device->bdev)
-                       continue;
-
                 if (!zinfo->max_active_zones ||
                     atomic_read(&zinfo->active_zones_left)) {
                         ret = true;
-------------

With this fixed you may add

Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thanks, Anand

