Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DA453737A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 04:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiE3CIL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 22:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiE3CIK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 22:08:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC445002C;
        Sun, 29 May 2022 19:08:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U1Rlpa013956;
        Mon, 30 May 2022 02:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=543MzwL2beFhi9O/lDrianvetgOvkMmfYl7SFihaqhU=;
 b=XcIlYJZbv3IWz5U+49rRhrfox1edUI5w+CNDYgEOMgHcb2x9fbOLfZxC6mvH9mVkh/XF
 kv7IHvU4MtMmRkzHAF/tkNQiE34nuFn1HgAWVNUNCJHjz7yZiDXh+EvJ0YjR8Q/g9+lD
 YelpZiMxbePYc+4iEzILt5b7eAI/iNZRKpgL09drLGtQa9/HUu929PJMhIIMxTKtOp40
 GbMAktJpYMCuSs3+Nz2xnMaegET5yPBuJxlSBiyjOQ997kBmwHmqVTTqsyHqEUmPBigq
 q6HSz3Q/evhzMFok7G54CY/A3IxpmOKIfXtgdIelZfozoMdemHZxe7q44/Q4H+0KGRIw Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcauhv2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 02:08:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U25Ugn014337;
        Mon, 30 May 2022 02:08:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kdgwt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 02:08:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2P7reWj0q4UynC9YwFfmXf7o5Tm/nfJPS5lBMF4Nz3GsOLU80/PA2wrdB9NwWal54FR8QW+s1u3oqkmomKq6YeMa3RP0O9o4ym7VnbpTFtcvq2TSrOknbULA2NH5O97SpDr9w8LxKQ9/O5nTDghhqmZxPBRVrEgIUI/HcWVra4AiKs3Ika1c15lRy9Zh8nRyqPOJOKvNraPTr+K7lBolcRtSmGmnTyp5wzbCVcqt+DOBcTH3uCADL19utkM8ETBEuccNiO8PafgQTe/MBPRqkfHbOGSWMlOy4mrzLwTFcGcHxXS0JS0IiqT05QsmvZqkR59+iYejGzFuCLeHLDB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=543MzwL2beFhi9O/lDrianvetgOvkMmfYl7SFihaqhU=;
 b=KFfPqCk4OAnqoG+RInKxmqOUhQIEvyxFymY5qpLq8Powpmn/NLzb3kIlTQ9uazIXqBfrYYqMQRxqELz2XO/8yg5u6ggd4mwKWGZFeylovYVnOMvSMYTjgtV1apjGbEplENlWdCqLQMGqeGijRFslkDxRHyzE2e+Rcs9kG7lgTEVGpDJPfxIRlHxApOvMIR4VtgNoMYlji4GEpmlltpogg/JDyb5vu3W3TdnJTI0GMA8XCuILWMcaTpFGorbFjR2sLor3Gp+5OawGrTCGba8SZu5qysYkabvAoSSDl69Qqrc2TD/zYk6Co9BKsCnOJW319JpO32myrd3vXyJiRDKy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=543MzwL2beFhi9O/lDrianvetgOvkMmfYl7SFihaqhU=;
 b=i3uMO6Uvcb9yig5V2iDnq/xCoeHTGqFMmEmY0jfRf4iHjbEuo9/h/619+pkRbCUhFGIH5Trzm5sf75aAAqRGYh9X6fEUz6Md1ePXZhEPz5dQxMSozG2cLwgnC+4HF0eX33m41Qzmxk4zOGKA16Rmg2DnD1U/z3iu9F5J2ZP22Ms=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN6PR10MB1522.namprd10.prod.outlook.com (2603:10b6:404:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 02:08:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f%3]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 02:08:03 +0000
Message-ID: <46f379f6-6d84-361b-8183-ad08606e8933@oracle.com>
Date:   Mon, 30 May 2022 07:37:54 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: btrfs read repair: new tests and cleanups
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220527081915.2024853-1-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220527081915.2024853-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cbafcee-86ad-4166-6b5b-08da41e13a89
X-MS-TrafficTypeDiagnostic: BN6PR10MB1522:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1522F6555EFC3814B7F837FAE5DD9@BN6PR10MB1522.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1vo3n4aXdKLo2ocTKzRqB3mXXiRMxR+B/BIOMzZg1KT9uy/7+/j//FcNN93keY52wtZL0vXLB3GbDuG6iHpLtLlFPobuVqQouMjrV25UYty6vsbFu8Nk52JV18eaCcS6NGo+kzmugceN5iXUHLS5jQ6L+OY9LGDDNBqm1Jji3Xsu4PiMJPPxXQsyWdNS+0ydhVSDzNilzz2p/7F+YBvs6jKb6Xqv1XI2G8NyW3t592eAb/dWG2W28u6XrLrULNiMdUHzx3gwAm8PM+hLSb+cBhq37E5Q6/f83oBAnbs/J3i1ragraic6VtiNT4fcDwHHN5rNaugFL9ygrLJNyOSVgSGkcUx+yAe9FXm/IbrTk71dEZc5YJ8iW5vxfBiIo1oF2OHznnJcv6FeKlkldFQh5YZxJHqYZk22TQPUYKAtsPXMQPP6mCNHATicegRz2QYxGR6SfFdvZFfzMwaom1NctBvp6cERQxd5jJmJWmR39U6naXGGcbaJqeNv4HH/cwb889WZCx5mmYzEG3C5apwq1zXYHNAEjA6D38Zkfpr0abtqb4+0HqSGMakxwJ9ynZvwkqO5vGOKxds8TlCXCmrJLvxOLMzAszebANO3f5+9ApK4uMjhzINp5Y1NKD0cdZyWK4FVRD+/vbb6K28O7TpwbdUmsh7TOHlXOoVNdAgLp9hIGxuhWYf+AtgkY3ytdUhdN3imaMOhLyK1jgbP7j3qlqd1VHBkm8bH4wP+ZyYay8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(6486002)(6512007)(5660300002)(6506007)(31696002)(2616005)(53546011)(8936002)(2906002)(44832011)(4744005)(31686004)(38100700002)(4326008)(6666004)(8676002)(66946007)(66476007)(66556008)(86362001)(316002)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDJldldiTEdPRHMvRk01eHRIVlh4VC9kNzRuUG5rNXJpMCtWYzZMM2NRMGNn?=
 =?utf-8?B?dGU1dFQrTkQyWEJYY3pDVE5tWTdvc1B3WW1SUElzd1lsVFV1UUpET0xURHVZ?=
 =?utf-8?B?UkwzL2NEZWVkVlgyaEtEWW4vZUdhVWVkUlo2b3RhMlZCd3VackhVV05DdEo5?=
 =?utf-8?B?VCtrQ2p1OFVRVzVPb0ZKdVJyWDZ5dkVBazZpKzhqQVAwci9VT3ZYaWlIaklV?=
 =?utf-8?B?TE9nWHRzV2lLRGl0THU2WGpBckNXNG9JeHgyQTBEaUVTV3NkbXZsdDFTOCtz?=
 =?utf-8?B?ckdMS1JZZ0ovclB5SHMwQUdXZ2tDTndMNVNPdDFEcllGdXRLY3FGUGxtVHdP?=
 =?utf-8?B?MVB2K0E0ZDVJNnpMRS9LUy9VMVBJVTQ1V0JwcFMxQ2hZS0dlcDVwQUNteXBv?=
 =?utf-8?B?RndmWC9jbzU0K2o3clZlUkx3VENrUnMwUG1hdzQxbTdUS3ltVGdBQ1FiSUxq?=
 =?utf-8?B?VTJ1SzVqU1p0eXZLNFF5c1RvSE96UlZVbEgyMTVrenY2TXREajBjY0hSZmcy?=
 =?utf-8?B?bmFTV1lEd3d2Q0tKdEVKbGwvazFxR29iRHYxRlg1ZEdadnBLSXdsNUpxRUlh?=
 =?utf-8?B?eXFOd1M4TGJJaXMvc21weHdvaXlvbU1reGIzZGgxWmJLeGorcmd5MTRIM1Fs?=
 =?utf-8?B?b25zOUNnSFJ6Ri9UWmNIRHRFRFFjZDRsQWlTeUlVYlpUQm8vaThuRnl6anE2?=
 =?utf-8?B?WG96a2xtTlFubHl2UklCRXdSL3ZsR0lVTVFFeGorV0U1MXJiR3c5OVRnQ2Iw?=
 =?utf-8?B?SzROc2hlTElZdWwrbkl2ZzV2ZUhvUmpsb1M1U2VmaFllUjlKWGtlN3k2Tjhs?=
 =?utf-8?B?ZnlKMnE1VXI2YjVGL1BmaUNYOFhXMVFoaXZ4am5Ndy92ZkVGeHRoNXptWHVN?=
 =?utf-8?B?ZjdjVTBXREV6SDdzNHJFYVVWV3ZYTDBNQnU2anlFYUNvN1BDQU1uZ2pianY1?=
 =?utf-8?B?VWU4TUVhSEUzcFAvVFVNcGtscWpmUFkyM1NpNlRSaHFHcy9WKzFnYjBmczRs?=
 =?utf-8?B?RHVEamV3Wll2dFFQYmk0MDhtaXhldklwM21IM2ZFYVE0QngwNzdmM0xIcDdT?=
 =?utf-8?B?T2NzbmhDU1B4dGpCYlFYQW1GdC81Qnh1VWF2OHJLc1B4UkNoTjM5aFZOc1pW?=
 =?utf-8?B?MThqRkVua2tZSEN1ckdtcERJUzVpUDN0VE1MbTJiUUNxM2FCTnBFclJINE5q?=
 =?utf-8?B?Smw4SFpML1pFcVNUMkZWQmVKWlJ4RVFwTVdvSHU2aFRGbU5Xb3JGWjdENVkw?=
 =?utf-8?B?eXFyTDdWV0tBK1lFWlp5RkpUOUJFSExSU1NaUzJqSlZNNzNUaG0zWitPcG1t?=
 =?utf-8?B?Z3RCSG5VQTRpZTZWSnNzVFpCeUFMWXdFRXMwdXQ1UTVIR0l6cytBT2hKOFRM?=
 =?utf-8?B?REM0Q3d6VHlIdytEak5ZUmpQLytCeVhGSHdIcXdranlhd01ueDlHclVtSkdL?=
 =?utf-8?B?Skw1ZUhITEFzeUpkOXp6SU1vQk41NFZBZlRIcnREL3FkTlpVZ0tsNnRWSXJQ?=
 =?utf-8?B?OE1pVHNMUkVGOWdsZForbXNEUTlvc2VyOStJVWphNklWYlBrUUNIdHM0UjFq?=
 =?utf-8?B?dUIxb253R2tsYTFqMVNBdEtLazhvMi81STM0dFhKaFNSWUhVSDB5WUt3UlIv?=
 =?utf-8?B?RXZCTDBaeHJDZU5zNXZkcWFGU0RLTFRibGZpcHJLN1E1U0MyZE15dkRoN2xl?=
 =?utf-8?B?QjAzTnZDeUdaV21xS3R4Z3RCaFlyV3piWDZMQkVPbHp4TzN2N2N6elZham9l?=
 =?utf-8?B?L1NzZnRqQmVpZFBSbExma2sraTVCQ0NhMTJaQXdTejdwbktjS3Fpbm00R1BB?=
 =?utf-8?B?aTlzRXZsRTVYZjlKT2hRYXRYOFRNa2RocEJsc0kzRU81bWZDRm9jWXc0UUVr?=
 =?utf-8?B?Tmxqb2JaVzluNUo0SmhGNWV1aTVqMWFvSlNoOVlFRUQ2N3RkbytXVHV1MTRa?=
 =?utf-8?B?SUJvZlF5QnJOS1FKdGRRZDU5QTErcVVjVTRzUDNXNEk3UmFGWUhzaHkwcEVV?=
 =?utf-8?B?emNmb3NBa3J6VlQxWjJrQ1Z3N09xUWhMeU9vRHJpbXcvbVNIeVUvL2lHZXVI?=
 =?utf-8?B?VHVJY2k4K1pKTG5KZXlSYVdtT1JscFFxTit4eEtQVDZ0eXp6YTVadUVhRnZx?=
 =?utf-8?B?QlY0NVBtaVJBemp0YnhDM1NubHNYRWJrMGl5dnRiZUtLQm5tSVlDK3RzM1JP?=
 =?utf-8?B?RlZOVGtCRHM2ZE1meFB4eXlTWGMyaXlPNGNDTVF3MVpWWWl3cVl3ckk5ZXRk?=
 =?utf-8?B?TDJBczRkRjF4WFUvZitWN3k1MFhMVjJ4MFNzanBYL2RCTmFKVkNkUFkzcHhh?=
 =?utf-8?B?cDZBTEkzTEt5c0dDamNnUTdiU0dKaDhSNnRlSE4wR1gxRmowb3JXRSsyTG1o?=
 =?utf-8?Q?au1xEwS0o8WbpaE2Qud6v+4+VRlZjzujFDEUZIUF6bQjA?=
X-MS-Exchange-AntiSpam-MessageData-1: GJsgOg4pjW+s5W9tqMujrBoHonN2iD1tCyk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbafcee-86ad-4166-6b5b-08da41e13a89
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 02:08:03.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoBDoIMqYOaXCMs+T2gjj4Asti+Rj6sxpVT1IinJSeMiAFGoWbRgxZrfmWzcb/Ie2Z/lNBadXhgM32WlYzhh7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1522
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-29_07:2022-05-27,2022-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205300011
X-Proofpoint-ORIG-GUID: 1TNGwsIDbooEbsvFCBXsfAtOnaKyN1jU
X-Proofpoint-GUID: 1TNGwsIDbooEbsvFCBXsfAtOnaKyN1jU
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/27/22 13:49, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds more tests for the btrfs read-repair code that exercise
> the raid1c3 profile and adds helpers to avoid duplicating too much code
> for read repair testing
> 
> Changes since v2:
>   - use the -b option to btrfs-map-logical-blocks for the $seqres.full
>     output
>   - don't use _btrfs_no_v1_cache_opt for the new tests
>   - add a new test to test interleaved sector corruption repair for
>     direct I/O.
> 
> Changes since v1:
>   - add common helpers for read repair
>   - increase the offsets so thay they should be fine with 64k block size
>     (although I don't have a system to actually verify that)

Verified on pagesize=sectorsize=64K.

For the whole series.

Test-by: Anand Jain <anand.jain@oracle.com>


