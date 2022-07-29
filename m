Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE4584F49
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 12:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiG2K6W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 06:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiG2K6V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 06:58:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4E04BD05
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 03:58:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T8ZcrQ004834;
        Fri, 29 Jul 2022 10:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Dqw765mW2c8OMcTVdbFqBu9uOQ31Ojg1ZfF+nRjqyGM=;
 b=wlFo1i7D3btkSaRynkhmfZM9ZFnHMsJg2vXiFsk0cqO7iA8E0KzRUKOJl+j/MtHc79Il
 v+X1PRN4TpMcb6l+fQh1WaSz+iBGJX2uZeohA/X5ui+miX9+iRZ6hmM3y8G/ZfU2pJE2
 b9T4IYbwAk5+FskyupA0zTftDNCjNXQMnFzX4feGNavORLgh44sYoMaPvXHSGyRPQS8Y
 Sc489dVUbIzdYgeGUq5gPCjR67WDB09gEvrM5kQB4R1T4usAFsx2BVACC6ZQEQ6w9TeG
 CTFZGxrhfnnnqznc0t/B83IKnBBZEAqoAwD8wFUuQ4zC+7qG7tDjsSmedW1Sg+7T81y6 LQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940xkgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 10:58:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26T7aMkF020385;
        Fri, 29 Jul 2022 10:58:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh63bg5wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 10:58:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcQ2BjbVF7X7VZl9cyq3dvI04h3NBXR3W4QICiMfykh5i8NcFU14WAYobnSwMQPdW5NVT7IZRk7LqjCgW8XuKyBQV0uKMu8XyejBpS/S6w6A2hywHq4Et/F8VOy6roXGr4oNb5I6tvyHJuId74tfpPas+zH5pYLfeZ6gGy2njhpjdQgiW1dJeDGkWoayH14oSTt7v5aiteHRs2wCMUdp+isldl7vJ88ThkKYIUdYhkWybRA6cOR2zdQoA+gaQJcncsglNa+8cPSr/t+X9UH/PVaowoVmkIADp3JS8DfxVdxBtk4F0zQWt5yhS5WDfJ1vR7hIku7hvuzmtXwaCemJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dqw765mW2c8OMcTVdbFqBu9uOQ31Ojg1ZfF+nRjqyGM=;
 b=IImWh4BtOXnUju5JGYS2+xCU6/H8BqS/DpJAn3rP/Lqrfykf5w84wIWwvmRcn90n4fvtSmC8IFk+dM6ZJVQibeC/D2SHofWitt/78E4WKHt0NxtDrHr/5591Yez9DF4BgNYDtwJHPgqMwrULJujdxwdo2RAw99m4jUW8YydfWJyq9O9n9Mu2NdWNtBmoGh93NVo83My7q1SPF5627NlVps70CkOn6UYzi+MEcKKH/Tpk7iHCcVxazbibNw5qL9pKjtYmvdz6VwCMWoAwxmmCq3nUGCy2/ri5qUvSzN4fjYo4J4pu87WCXSQ7iPntomJa8Hk7XBNRMr60izN78tOpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dqw765mW2c8OMcTVdbFqBu9uOQ31Ojg1ZfF+nRjqyGM=;
 b=iH+cX2VGffmfDC1HDo/ROpUifz2wORKitNEmrTHGBrbN14ItS1RPqwjb/5SRVOE7Gjd3rolq3OBEvIdz5ZCdUonzo4fiX4HQZUcdtAcTNjZfO78b3Mm41m7eotYaRolveWJDrWy2nUzQGx1RfBnWf8hI7QkOMmQSi5LB1yN4CV0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5562.namprd10.prod.outlook.com (2603:10b6:510:f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 10:58:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5458.025; Fri, 29 Jul 2022
 10:58:15 +0000
Message-ID: <3eb6511b-1000-8ac8-41b7-096568900f8a@oracle.com>
Date:   Fri, 29 Jul 2022 18:58:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] btrfs: sysfs: show discard stats and tunables in
 non-debug build
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220727175659.16661-1-dsterba@suse.com>
 <20220728113141.15545-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220728113141.15545-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 637b154f-12f7-4c1b-708c-08da71513c69
X-MS-TrafficTypeDiagnostic: PH0PR10MB5562:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jKGmJ7qHXaSfsLr7CYJFp9WHIJcmKXxjEpOulkb1RuRWKs7CAZswdBITfwL++OaiO4Cw0BaywJx6XikWdId8q71jYtHj7nYR9CIEx62pUBMTKeCuZjM/n8iSuFEPD+J8sBMeqwDuz8hR0U4IXEuw3luSCAL39f1tczvEQejHCQtMh7iDI8StFCmdo51XzJ4ofqSWsEvDn75Z8iT55YnEeZeDfah3J1QuQhQSgwU0q4X8VKo0cGL4tCQr11gnkQmh5XnnU1F6fFZz8Kr4PynHtw03ZzYwjjziOSY3kEZ9KpDSs3qmphJkG++rZ+Dbhl8MDwkBJc1Bfn6gItoq13lIJLojgPauYVggoMe0+gerS+SmRvqtOZWBCAo5sqsIpcnq2ASFJvB2ppP9MyrUkBmnTnTXckVE0UO1GrXNxIAQh7ZpFZRXI+raD4glfv5wqpltRTMOBmiWz9x8nXApU0mMA4FsOymH5uvA2ugAGSn5uM2PF/wQEId6qXLUv/POOEVie3MSDub41DKNCy6JUZ8VMdvmslEfeqZXL3RyC+s0FeZX7DKeVMQGjnHYrSWsxp4a8SouqxKzghaHGtiiVR1OL0225hZ/5tXcqcz8vVWz0CB1QAdLcAuR/79u6eVqcSUPYVeRXX7qcPYQcaWUOLhcb3g0aRYJcuwFlx2Nw1mDznmcu3BaCodM9GnCLfNvs7OTTlr161Laitxr7SQKOeOMXnWWBeEPFrlTGlWkfrJcQs/Yy3mTzVe4U5Q8NEnGeV4+O+o0qZdY+3d/ktsiiCmft2pjUaXcYEv5/2ct503xumqYQrnLnXLDZyJfmzdQHQ+qo22PNaxHRxsHTWqqxX/wUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(396003)(366004)(136003)(2906002)(38100700002)(41300700001)(6666004)(316002)(53546011)(6506007)(66476007)(66556008)(66946007)(8676002)(8936002)(478600001)(31696002)(6486002)(86362001)(5660300002)(44832011)(186003)(36756003)(31686004)(26005)(6512007)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1VNdU4xdG5YZmdmVkpaWXVYR0lSRmE2UWJCL3RRb2RSSWRYMzRXRzlpc0J3?=
 =?utf-8?B?QXpaY0d3RGFreVVnWW1wczY1YkJGaXVkQ3NXbGhNcWk5SXl1QmtuS0FnUW84?=
 =?utf-8?B?MFV3eWpXMEhhN2JmanExdWErNFQxQXF4TTdReGIvSDYwcld1ZGtaUTNzYmh2?=
 =?utf-8?B?bW5QaUgrVmpWZkgxSjViTmd3R1VHTlVnUFc4Z0NwclNsa05PZXJ5N0Y0NzBJ?=
 =?utf-8?B?K1VMOHRKcDNLMGJpbmNZSzV2V0YrNFZFRmJCMWpDRmdJREMrMVU3dm9kTTcy?=
 =?utf-8?B?em9FWENUTisxTUJhSEJWVE1xS3BDSytsaHpsZUozSXdQeW04T0NUYVI4WnBq?=
 =?utf-8?B?NEQrYXFFbW5vdUt1R0FBYzZwVmZoWEhMK1FwSnlXbmswQkpVbXBHVlV3WkxQ?=
 =?utf-8?B?KzE1bHV2cmNEeGJQcFoxUGtjQzhjMm1iRXZ6M3FCcXIzTGdCano3QmZodVEz?=
 =?utf-8?B?Zlo3RTJpV0kvZFluOGpiR0E1WExHaEg2RkMrWDMzdXhwNGZ2aU12c0dpSmZp?=
 =?utf-8?B?MkdKcXdBSm1SVTJhT3Ntd1QzVWRrUldHaklxNkJVdGdaSkJ2eVE4SHpTQzhC?=
 =?utf-8?B?c0pTSkZJYTB6V2xXRGxrMEFhZjNlN3lBRHQ1aklHbjYyUDdmaDJDcHhOM05u?=
 =?utf-8?B?QUZxU09MTW4ySzRUa0lYZHF4dlhJeHFvN2tsRmNmSXptWmJRT3dza1hxMTMr?=
 =?utf-8?B?T1NMNVRGMTdndTdwS3VSYy9veUNDK2NRNSt2TGhYMUZqTlY5YVloQjMyMGZK?=
 =?utf-8?B?YWV3Mm5FaEhsUFZZbnlocVA5MW5QbGdHMHRTdlA0RkFDb3RyUjZBMnR5VnVC?=
 =?utf-8?B?bktaTWVEaDI0U1dNeTNxNkZxdUFjczJPREc3VE9FSFZQeGFvTE9CT0V1aUJh?=
 =?utf-8?B?eFhoVDYwVHVybVpTV1gydG1DcjlXOG5xN0R0QXdBMDZBL0FUcG8yL1E3bDJv?=
 =?utf-8?B?OTZJOVkwbWFWazkyZWNZQjRLTThORGFCMHhsSTYrQ1dLTG1SWmNoSHl3TzRh?=
 =?utf-8?B?WEJkWEdiR2ZmN0pQRWhGM240L0JRKzZ3dDNGYXI4VDg5VVhpdU83VUNySXJM?=
 =?utf-8?B?TTVtem5FOGpUem9PQTZBMGtVRlBkVlRQQ0dQMHFiNXpXTzMyb0UrNjhYTGh4?=
 =?utf-8?B?Mk5Tcmt2RUhjZlZRdHVsU0kzWHZVc05OWDh0Z1JKZFRVZmpUSllXS2pRbHpj?=
 =?utf-8?B?N3V6Zi9kWDhlQ1A5a1YzZG5Nc2hJRE9qWDhsa3V5ekZielJlZUhRYlk4cU00?=
 =?utf-8?B?a3ppVHIybHN2WEt1dzErY09iUU5XZVFyZTFlMVRYbkxaSjlpeUp4SlVZNkNG?=
 =?utf-8?B?bEc4bm50dGViVkRXN291LzM4anVGdE44cDFxWHhBcGxQcUFFby9xMlU1a0tj?=
 =?utf-8?B?OGFPOWFoUUxSdnBaOFJRc0tSb1lnWUxENUFpcURRTFovSmIxQUx2SUhPOXh1?=
 =?utf-8?B?UUZFU1BROGpoTGVVVTBzU0Vxc2FFNmFYQi8xYWpVcUl4cUNMcDFxTXVLTFFr?=
 =?utf-8?B?ZThRMUR5WDhMSExYNm5oSlZ1a0ZlOHc5VWZGZThsT0xKUDhTY2x2ZEYzbVd5?=
 =?utf-8?B?cWFkZGh4RzV5WlFlbDVuRWYvNk81SElJQnB0QmkyMXV3VnVXVkhvRStsaWVv?=
 =?utf-8?B?cklscXRHRitLVDFkM01hYlRGMFNtZGhHNk9VWG9ZUXg0WlRFbnlPQkhPckJR?=
 =?utf-8?B?cFkrVURFc1dIbDI0K2tKcjMyT09tQnp0UU9WQThOOWltbExDYitoWXBiWG1l?=
 =?utf-8?B?VFQ4QmJsak9xUTRrOUo3M1pLSjBXendWUDJGZ0I4QlBZejlid0haQkpGSDRp?=
 =?utf-8?B?SmtaRUt2V2tkdTFUT0I3cjJ5cFg1Q2lvZ1J1YlN2akoxc0pWY1RobU5lb0lM?=
 =?utf-8?B?VzVqK0hwdXB3TXdGSWoxNC9FT0t0bjNIU29MdXJKSnBuL2tRY0MvQTltLytX?=
 =?utf-8?B?TDM2bUNzUXVkMnlvV3orOFFraVdMbkk1Q09rbVVxZ2dtQXNIcVVNMzRlRkNW?=
 =?utf-8?B?c3lOeTVydVA2M1J5RXB6bEVIS1l5V3NQYnFvZlhoMzV2S3hlY2NKWWIyamla?=
 =?utf-8?B?dlNBVjhNUzFlUm4yeWprcm9ncjFna0x5THUvb09tZ0N3OEoydHM4eXMzUjNT?=
 =?utf-8?Q?wNMWdzzb7YaE/Voiyj5KSuiS5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637b154f-12f7-4c1b-708c-08da71513c69
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 10:58:14.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nS97O1+jTd9UPfUMlu4TwJuRoEipSLIWATj5wI+8/Q0KSCzTUKLU8R+5IDKuq6fm9QgY0wd/pnV1ruY/0X5n0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290047
X-Proofpoint-GUID: hoO13z530RYJZlkEJ2J9P7EWqViqKgVX
X-Proofpoint-ORIG-GUID: hoO13z530RYJZlkEJ2J9P7EWqViqKgVX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2022 19:31, David Sterba wrote:
> When discard=async was introduced there were also sysfs knobs and stats
> for debugging and tuning, hidden under CONFIG_BTRFS_DEBUG. The defaults
> have been set and so far seem to satisfy all users on a range of
> workloads. As there are not only tunables (like iops or kbps) but also
> stats tracking amount of discardable bytes, that should be available
> when the async discard is on (otherwise it's not).
> 
> The stats are moved from the per-fs debug directory, so it's under
>    /sys/fs/btrfs/FSID/discard
> 
> - discard_bitmap_bytes - amount of discarded bytes from data tracked as
>                           bitmaps
> - discard_extent_bytes - dtto but as extents
> - discard_bytes_saved -
> - discardable_bytes - amount of bytes that can be discarded
> - discardable_extents - number of extents to be discarded
> - iops_limit - tunable limit of number of discard IOs to be issued
> - kbps_limit - tunable limit of kilobytes per second issued as discard IO
> - max_discard_size - tunable limit for size of one IO discard request
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>




> ---
> 
> v2:
> - add CONFIG_BTRFS_DEBUG back to btrfs_sysfs_remove_mounted when
>    debug_kobj is removed
> 
>   fs/btrfs/ctree.h |  2 +-
>   fs/btrfs/sysfs.c | 35 ++++++++++++++++-------------------
>   2 files changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4db85b9dc7ed..9631059d2733 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -891,6 +891,7 @@ struct btrfs_fs_info {
>   
>   	struct kobject *space_info_kobj;
>   	struct kobject *qgroups_kobj;
> +	struct kobject *discard_kobj;
>   
>   	/* used to keep from writing metadata until there is a nice batch */
>   	struct percpu_counter dirty_metadata_bytes;
> @@ -1102,7 +1103,6 @@ struct btrfs_fs_info {
>   
>   #ifdef CONFIG_BTRFS_DEBUG
>   	struct kobject *debug_kobj;
> -	struct kobject *discard_debug_kobj;
>   	struct list_head allocated_roots;
>   
>   	spinlock_t eb_leak_lock;
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index d5d0717fd09a..32714ef8e22b 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -35,12 +35,12 @@
>    * qgroup_attrs				/sys/fs/btrfs/<uuid>/qgroups/<level>_<qgroupid>
>    * space_info_attrs			/sys/fs/btrfs/<uuid>/allocation/<bg-type>
>    * raid_attrs				/sys/fs/btrfs/<uuid>/allocation/<bg-type>/<bg-profile>
> + * discard_attrs			/sys/fs/btrfs/<uuid>/discard
>    *
>    * When built with BTRFS_CONFIG_DEBUG:
>    *
>    * btrfs_debug_feature_attrs		/sys/fs/btrfs/debug
>    * btrfs_debug_mount_attrs		/sys/fs/btrfs/<uuid>/debug
> - * discard_debug_attrs			/sys/fs/btrfs/<uuid>/debug/discard
>    */
>   
>   struct btrfs_feature_attr {
> @@ -429,12 +429,10 @@ static const struct attribute_group btrfs_static_feature_attr_group = {
>   	.attrs = btrfs_supported_static_feature_attrs,
>   };
>   
> -#ifdef CONFIG_BTRFS_DEBUG
> -
>   /*
>    * Discard statistics and tunables
>    */
> -#define discard_to_fs_info(_kobj)	to_fs_info((_kobj)->parent->parent)
> +#define discard_to_fs_info(_kobj)	to_fs_info(get_btrfs_kobj(_kobj))
>   
>   static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
>   					    struct kobj_attribute *a,
> @@ -583,11 +581,11 @@ BTRFS_ATTR_RW(discard, max_discard_size, btrfs_discard_max_discard_size_show,
>   	      btrfs_discard_max_discard_size_store);
>   
>   /*
> - * Per-filesystem debugging of discard (when mounted with discard=async).
> + * Per-filesystem stats for discard (when mounted with discard=async).
>    *
> - * Path: /sys/fs/btrfs/<uuid>/debug/discard/
> + * Path: /sys/fs/btrfs/<uuid>/discard/
>    */
> -static const struct attribute *discard_debug_attrs[] = {
> +static const struct attribute *discard_attrs[] = {
>   	BTRFS_ATTR_PTR(discard, discardable_bytes),
>   	BTRFS_ATTR_PTR(discard, discardable_extents),
>   	BTRFS_ATTR_PTR(discard, discard_bitmap_bytes),
> @@ -599,6 +597,8 @@ static const struct attribute *discard_debug_attrs[] = {
>   	NULL,
>   };
>   
> +#ifdef CONFIG_BTRFS_DEBUG
> +
>   /*
>    * Per-filesystem runtime debugging exported via sysfs.
>    *
> @@ -1427,13 +1427,12 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
>   		kobject_del(fs_info->space_info_kobj);
>   		kobject_put(fs_info->space_info_kobj);
>   	}
> -#ifdef CONFIG_BTRFS_DEBUG
> -	if (fs_info->discard_debug_kobj) {
> -		sysfs_remove_files(fs_info->discard_debug_kobj,
> -				   discard_debug_attrs);
> -		kobject_del(fs_info->discard_debug_kobj);
> -		kobject_put(fs_info->discard_debug_kobj);
> +	if (fs_info->discard_kobj) {
> +		sysfs_remove_files(fs_info->discard_kobj, discard_attrs);
> +		kobject_del(fs_info->discard_kobj);
> +		kobject_put(fs_info->discard_kobj);
>   	}
> +#ifdef CONFIG_BTRFS_DEBUG
>   	if (fs_info->debug_kobj) {
>   		sysfs_remove_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
>   		kobject_del(fs_info->debug_kobj);
> @@ -2001,20 +2000,18 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
>   	error = sysfs_create_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
>   	if (error)
>   		goto failure;
> +#endif
>   
>   	/* Discard directory */
> -	fs_info->discard_debug_kobj = kobject_create_and_add("discard",
> -						     fs_info->debug_kobj);
> -	if (!fs_info->discard_debug_kobj) {
> +	fs_info->discard_kobj = kobject_create_and_add("discard", fsid_kobj);
> +	if (!fs_info->discard_kobj) {
>   		error = -ENOMEM;
>   		goto failure;
>   	}
>   
> -	error = sysfs_create_files(fs_info->discard_debug_kobj,
> -				   discard_debug_attrs);
> +	error = sysfs_create_files(fs_info->discard_kobj, discard_attrs);
>   	if (error)
>   		goto failure;
> -#endif
>   
>   	error = addrm_unknown_feature_attrs(fs_info, true);
>   	if (error)

