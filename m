Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66A7613D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjGYLOa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 07:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjGYLOL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 07:14:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE72F30E2;
        Tue, 25 Jul 2023 04:13:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7oael019518;
        Tue, 25 Jul 2023 11:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vhOrUaee16ik9B/O7TP1zJ7F4KZk3P+IiFlnn32pt5E=;
 b=1CdmmC9VUPS17dwWxvqPdOh3jyaE3SweyE4lxY32O3mp9NU8eCWcYsSE9Q80MiZKZufv
 kOsrzHXsCXexvng7q8uXRL2kC75YttHjX+hbrdYuN8JJXefQk6fwb11iGuE0W0wBkR+B
 sB8qBlGx7uYzYb7xoZUItqUdOhGuC1zfPPBykyOF2XXunnqDCdBxQ6SKri9gXVhEeVl4
 Drq2MsndxK0YtqIMzemAUVFLKvGzEiUjErhf1+LzxGQz5fV09hhBuwVSXlmXLtAm80NM
 nN3nn5GG+o2SJc9g8z/plt5+VyXxFsPtCvzpbUGWd8mMyCPUp24G6099zP53nZAat+0s 1Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1vuac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 11:13:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PA8raA037240;
        Tue, 25 Jul 2023 11:13:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j4krsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 11:13:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW3KSUlETyaGfqndxjIBQMJ+270WmV11QudLuWqNyYZg3SAugViEn2Jl4sVwWuSMMLlZZZcvwd5HpVm13isBmnQIHcboJJyJ831k+yZ0PG1yay6SuVRYBH4rlRlpOOz1ebQCO/VeehxmBSNkZwjG2qmS4hd7SXXPRciPK1vd6mSdWVKQOc278Z2sRXZxVqyOsb0lzvhaBEzduiBZBT977KFpOe8Vp+xNZHfZtqhhxAgkwx+tf0XvcV3CIeBdrPt8ULKVCz60U9dROvTCIE/tNq2arkqUH15XhRjRPUU91yF1ZQznJvGqXdNQwKelqLb8Mszk/IeLsRXK7agM80zDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhOrUaee16ik9B/O7TP1zJ7F4KZk3P+IiFlnn32pt5E=;
 b=EFV9pDjCr4G9iz57ig5ka1HefYdooeP7Np34zQKy3oHzdl9Q3zpisg44ZUx6IwKlkegZwf1bUa9HDMaWLxn/dtcu8I3ywwtre/F6sUwbUXBjtj83fk397nKXEYjywTM5MEv/+B1cKEM9HeMSGI5ZFDHPgspGhg9Z71+Tsi4L6o6cDdwzzsEhQHONGxQWtPnf3wIqaPqBfrqFSo1QB+TGuPC0GvhNw4mFQb+oWiZGje8b3xCzZ4n16Pr4KlWQ14gA47f2QDdr55utD1dHZgTBtuDftWMBOsbJaUf3xT02jclWcAsriI6pdckW5Q4TqJ1lC7nf3wjGBqodQuDvUZagRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhOrUaee16ik9B/O7TP1zJ7F4KZk3P+IiFlnn32pt5E=;
 b=hq/JPoJi4Wsm/JgJt4rrp3Emfz4iSdEisGo6gi3GX8HlUxGxVRbnGb5RbZUIG4XDAbpDX0l6ibDNGRDfxtCzq0EbpyeyF3Lx3iHDXqYMXzE6KuzLL25Y84KAkIz1whQEgUYGkBwu32ywJXb/Kx7vkTDZNUgT+UY8DRrmQcdBHic=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 11:13:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 11:13:10 +0000
Message-ID: <8fe3ada0-60e7-ea69-d64b-1245a1af3d60@oracle.com>
Date:   Tue, 25 Jul 2023 19:13:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] btrfs: add a test case to make sure scrub can repair
 parity corruption
To:     Zorro Lang <zlang@redhat.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230724023606.91107-1-wqu@suse.com>
 <334de8f1-5f7f-5817-9c33-f7fac7b2a24b@oracle.com>
 <20230725103628.bd7sxyjgyit7t7t5@zlang-mailbox>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230725103628.bd7sxyjgyit7t7t5@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eeef703-a9b4-41d4-52bc-08db8d00213d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jwfZ5WTod8piu519ejOgdxgrAaU3tsdo+FCAM5H9a7oTT4f880VVQVwFhh91D6rQMhqhRXzTpXpbPwQJrxaKXsPUQAV7os5uy4t1SV/7ZUv+kWHwoMOGrMIl13toTmoz3j2pg/Zbfd7PekSt7wBuM0IZcJ+Ycnr/Gt7xNH9HQondDw9aD33aXpVaqkzbcisojsR77nFmLD64+SR4itIH/rfVsC9TX2LTGU/0ahZiNGY+SQOtKT/V1jqsrrf6lWkcu1rpG5cOWrxgb5kruCnuaHJ4caBfW13ErYyJvxVVluQT/L2CvFHrzOPZKIv5PcuMCkQdFzBKChiXxYuGpGz+iNTH7lkOJyoyWFzmO1lBroadPO9Rr0qpyKUFaBx3QqnMytICUoOph26/rV4Wjq4ROqY2c0tGIP//xdq0HU58RxTo73j8w9SmxkW5L/WVTIiUm2xwpbou6n3kndlubP/6IZg1x6u+QBcCN9zErj6kIcNGDqwAIGTjUTB2u4DZNivie4WFWyecISp7vjJntf6UB2hu79TzMSz0/ubwRkPoHlWtGMuIhA8s39u6ixrmBlAzPsyWZi4MvbNDS8wRroeOB1pqYOQKSEyaKngyJLNAZmoeinBc9qDvVf5cYEdo+qsJt/arCh+4w4lGsOlyhEJkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(38100700002)(66946007)(66476007)(66556008)(83380400001)(36756003)(53546011)(2616005)(6512007)(8676002)(8936002)(44832011)(5660300002)(478600001)(4326008)(41300700001)(6916009)(316002)(26005)(6506007)(186003)(6666004)(6486002)(2906002)(31686004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a01rRUxaR1ZpMjlxZnRPV2lENDZvZk0vNHB3RHBnT3Q0ZGZLOHZzM0hxdzkv?=
 =?utf-8?B?VExMR2gzM1VPN1NBS2FndzRmUndFN2RJaGpkZXJ3cVhuT25BZFZUOUZaSFdp?=
 =?utf-8?B?M3lHR0Z3VFBkV2NjTWUrVDdnTC9kS2tlaTlsVVFuUnhFTW15cHFRcXhVc3Nz?=
 =?utf-8?B?UU1sMEJIQ3ltMjFSZk1KZ2M1ME5jaWJEVW1PSzdNNExhc3YycEczam93MHFB?=
 =?utf-8?B?Rlh4ZnMvdlY3bGM4emc0clQyTEU0R1RjUjBVYk96Mzc3U3MyNTEzU2tqVzNG?=
 =?utf-8?B?KytuYkhtbUR5Y3JDT1FncGMzQy94TGRlRVYrSTIxVXVmRFVGLzN4V0RHWHRx?=
 =?utf-8?B?YWZ4aklKdS9ibG10ZkJnZ3Nvc01XOWVaWXFoS3VsM0xseGQxYlRnT3o3dTJQ?=
 =?utf-8?B?QkpmQmhWa1ZqdEx4K0F3SE96cENySXNVRnhQSW1TZjNpVjF3Ym1iUGhPM096?=
 =?utf-8?B?UGlyRkJVdFlweGZKMXhpeW82QSs1eFU2MlV4dXo0MDE3L09XbFVNa2E5czVB?=
 =?utf-8?B?UE5ra01ZNWxtYmJ5Y29sMWRCL29SSkw0aEhqdUMycVIrUlNDc20rQ2VoNTQv?=
 =?utf-8?B?VnFZQ0tNRTNFLzVZeG80bTcyNlN6YzQ3OHlEdmtxblU0YmQyRVVrVzJBWThK?=
 =?utf-8?B?QzRuQkdreGRIWElSMXBtRHJZM0ZLdW5mYlo4WXV4MUttdUQ5ZWk2WnlhRnBN?=
 =?utf-8?B?VTdqS1VJK1VHaUhVLzEzaVJ0NmUyRjlyb2JFNGYzNW1IMi9hSlV1eGk4RGFB?=
 =?utf-8?B?TDc2UnhXcEZwSEd5Y2k2dzhOS3B1VWltMG0wSER2Si8vWDcvMVBoYnlhUXd5?=
 =?utf-8?B?MlQ4Z3pHZk9ubG51QkVqZXRzOTZ2cXdVWktEQ0JVLzZKMTdrbnljUHFxYUhp?=
 =?utf-8?B?cHZBV1NMT2hmYW95YTBTK0Z3TlNkOWFUVENKU2Y3LzNNOWpGbE5ibFVGZkZy?=
 =?utf-8?B?dU9VaXRQVHp1YjcxZGh0aEsxNDVtT0t3MEttRXlNaHB2UW96RmtVQk5Ud00r?=
 =?utf-8?B?MVZncEZSYlRGU0kxWVdXNjl6KytwamZpVFJXODNkbU13dTJmQ29zVmZpV293?=
 =?utf-8?B?a3dwZmJDakNoZUoxaDJIdlZjempGWGc5T3dTeStNaTVSSFhOUGhqUGErbDZk?=
 =?utf-8?B?eVdSUlQxSFlYSENPTjNWbjUyMHU3bkNHWXhBRytCN3hqOVV4WTQyMGtSTytH?=
 =?utf-8?B?dUtocG9ZWGRldG1MakxJVFFvR0V6d25pcHc2d0xLSWdvb3grdFlhK3ZTYkps?=
 =?utf-8?B?QlRSNXJmMU80eGRheGp5c1BqOFZoV29xVXY0S2hWUTNmTVBSZXJ3dml6UFVP?=
 =?utf-8?B?ZUd5V2hsY29FamxvWHBmaExsSWZQcVFlLy9uaWM3L2Yyby9SeWVFNjVlWnRU?=
 =?utf-8?B?SG5xeUxEclU4NVNiZWt1VWdPOGxKcDFueG5jblVWZTQ0L0VxdVV5NUV4Y2o1?=
 =?utf-8?B?R2k1dTVZcVFIWGJhT24yWUJhdUVXMU1HZm1sbDlMbkpNL1RaNFFHaXJtaFpC?=
 =?utf-8?B?ZnZlTTk4bE9FSlpxWVlWaUhVcXR3c2ZoUUpkaTZ0Q0oxcC8vQmlWTlI5c3l4?=
 =?utf-8?B?Nk5YQnRNNW1iQ1lIK0dYUmE0R0syeUxpMStIajdFZG1hcHVMQzNJS0U2cTAr?=
 =?utf-8?B?Smh4bzVjSEMzZkZ4RUZIZWxCbDY5c0t3TTk2QkhkbElVUDNjaDQzS2JwL283?=
 =?utf-8?B?NVlmdkhLbGxndjlvdmJvbUhwNldNSTFKZ092ZTlhSDc3TEtJSmxLVWhVMWZx?=
 =?utf-8?B?VmNVWjVNQloxbEJVcXNVZCtVWFJ4N2pVVEhOeU5MTW8wYVJ5Ym5iYThhWkJ5?=
 =?utf-8?B?QTFQVjdaUmdoK0VtazhvdkFPdWV3OHQ3d2thVy9FMDFZYlgwd0l3ay8zdGtO?=
 =?utf-8?B?K0szblBHeldIRS9haThzSkxNb3VJZzNqYTV3dTFEaGxnRmphdXpYTk13OUFt?=
 =?utf-8?B?em9iSCtuSDVmZTNnTWlrSm5VaXVWaCtsRDlycCtkSG1pcXZhbmowTG4xN3Jv?=
 =?utf-8?B?LzFtdDdYY3JEU1dvNFlCUW1GWW4zWkRsUmdvSUdEZGYyWmhQZHdUbDFjYmQ0?=
 =?utf-8?B?SC9IZmcxanYyWXJ3djRKbDhmWUoyK0c4bXBDcXFtd1BIb2w3clRhQ1lWNC9X?=
 =?utf-8?Q?SEayV38LG37ico5y5EwJqaphO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w4l6v11FK7cK7e0uuTJn/eyco1Y20QcoOhB68/ZjI+VKAO48Oc7ijT5xLlfmSBCZ+C/6mtTpSNPm7DOlaDo02WO5JW+b/X3tnNo2KZ1xc/GiseudEerYjQe3RsAgx2i93EqkAR7AIPNjmDsmYbgvqq/jqBZ891V7cXZNCF4lIvEG8WiEwnUNiZwzS8mJ9yGeSILiUzneY9BGZFEF9ctUYMzZRrGqZjzyvxcUGVFBgbOgf//5wkD14CJHuYM1OGqLTko8rQyHUOTyJN9iG4cfjbaYw433oEvEzfSAzRWceB7J2vhKQfoJ2Wq3jiurfcB3YEk011sOiQLkl9ky6+Dhu3l7YOawmsdM5Fih5Ej9JxKNkTFdhAGpPYWXjzHHWnvkLSDqNefmXhBlDoHgV3E2mbr0WUm1S3kypuGOjM0tyiaNiG3G+OciLI8y9lyfeYApe1LJgUcoge//8Srv8mZaHKn3dE3N1bNbY01LprBFtCT3ZVwh9XwPHeStcxvMqlZu7zlMMmSnwHdztJEdPxIXmdopWooSrKOu1+nfoRcXYDUJ4oNBIL5n0o4mtQXkW9LsA5NGNMqzaKLb8EUD7jsldUQJfzagNxC/fW13B4Zy2KoSqNWIS3nm0atWlvwlDaI9ZQwvx3MCwGa2zOhv27gZp3cFii3XWdL5bcMpDABwzbwEgSWlp/eEfkNyGcr/ccOyUUbpnlXcSxhGF6sUaPeseACYbn7K5C3okr2MPawJRrA4ilHi/R6WK3y975j9GVJEuDSah0/A8okosCKpBC35fsWQ/OvYj7eeHR83fdeCfXjLs8sX7ID/GXUkSOq8plKH
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eeef703-a9b4-41d4-52bc-08db8d00213d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 11:13:10.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qw6a6EN7EkpaRFbCutIiAY4c0ZijoHxfmdi/mmBk4y4L/bmLtXm74ATHtVjJWd9Hs0BRRxKT3j6jC45lxq01Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_06,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250097
X-Proofpoint-GUID: iIWmC_YBPj0c2KQQ6EFuDfwLmHN9YKMn
X-Proofpoint-ORIG-GUID: iIWmC_YBPj0c2KQQ6EFuDfwLmHN9YKMn
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25/07/2023 18:36, Zorro Lang wrote:
> On Mon, Jul 24, 2023 at 03:48:52PM +0800, Anand Jain wrote:
>> On 24/7/23 10:36, Qu Wenruo wrote:
>>> There is a kernel regression caused by commit 75b470332965 ("btrfs:
>>> raid56: migrate recovery and scrub recovery path to use error_bitmap"),
>>> which leads to scrub not repairing corrupted parity stripes.
>>>
>>> So here we add a test case to verify the P/Q stripe scrub behavior by:
>>>
>>> - Create a RAID5 or RAID6 btrfs with minimal amount of devices
>>>     This means 2 devices for RAID5, and 3 devices for RAID6.
>>>     This would result the parity stripe to be a mirror of the only data
>>>     stripe.
>>>
>>>     And since we have control of the content of data stripes, the content
>>>     of the P stripe is also fixed.
>>>
>>> - Create an 64K file
>>>     The file would cover one data stripe.
>>>
>>> - Corrupt the P stripe
>>>
>>> - Scrub the fs
>>>     If scrub is working, the P stripe would be repaired.
>>>
>>>     Unfortunately scrub can not report any P/Q corruption, limited by its
>>>     reporting structure.
>>>     So we can not use the return value of scrub to determine if we
>>>     repaired anything.
>>>
>>> - Verify the content of the P stripe
>>>
>>> - Use "btrfs check --check-data-csum" to double check
>>>
>>> By above steps, we can verify if the P stripe is properly fixed.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Rebase to the latest misc-next
>>> - Use space_cache=v2 mount option instead of nospace_cache
>>>     New features like block group tree and extent tree v2 requires v2
>>>     cache
>>> - Fix a white space error
>>> ---
>>>    tests/btrfs/297     | 85 +++++++++++++++++++++++++++++++++++++++++++++
>>>    tests/btrfs/297.out |  2 ++
>>>    2 files changed, 87 insertions(+)
>>>    create mode 100755 tests/btrfs/297
>>>    create mode 100644 tests/btrfs/297.out
>>>
>>> diff --git a/tests/btrfs/297 b/tests/btrfs/297
>>> new file mode 100755
>>> index 00000000..852c3ace
>>> --- /dev/null
>>> +++ b/tests/btrfs/297
>>> @@ -0,0 +1,85 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>
>>> +# Copyright (c) 2023 YOUR NAME HERE.  All Rights Reserved.
>>
>> NIT: Actual name is required here.
>>
>> Rest of the code looks good.
> 
> If there's not more review points, I can help to
>     s/YOUR NAME HERE/SUSE Linux Products GmbH
> when I merge it.
> 
> BTW, do you mean there's a RVB from you?

   Qu has sent v3 for this patch and there is my RVB as well.
Thanks.

> 
> Thanks,
> Zorro
> 
>>
>> Thanks.
>>
>>> +#
>>> +# FS QA Test 297
>>> +#
>>> +# Make sure btrfs scrub can fix parity stripe corruption
>>> +#
>>> +. ./common/preamble
>>> +_begin_fstest auto quick raid scrub
>>> +
>>> +. ./common/filter
>>> +
>>> +_supported_fs btrfs
>>> +_require_odirect
>>> +_require_non_zoned_device "${SCRATCH_DEV}"
>>> +_require_scratch_dev_pool 3
>>> +_fixed_by_kernel_commit 486c737f7fdc \
>>> +	"btrfs: raid56: always verify the P/Q contents for scrub"
>>> +
>>> +workload()
>>> +{
>>> +	local profile=$1
>>> +	local nr_devs=$2
>>> +
>>> +	echo "=== Testing $nr_devs devices $profile ===" >> $seqres.full
>>> +	_scratch_dev_pool_get $nr_devs
>>> +
>>> +	_scratch_pool_mkfs -d $profile -m single >> $seqres.full 2>&1
>>> +	# Use v2 space cache to prevent v1 space cache affecting
>>> +	# the result.
>>> +	_scratch_mount -o space_cache=v2
>>> +
>>> +	# Create one 64K extent which would cover one data stripe.
>>> +	$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 64K 0 64K" \
>>> +		"$SCRATCH_MNT/foobar" > /dev/null
>>> +	sync
>>> +
>>> +	# Corrupt the P/Q stripe
>>> +	local logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>>> +
>>> +	# The 2nd copy is pointed to P stripe directly.
>>> +	physical_p=$(_btrfs_get_physical ${logical} 2)
>>> +	devpath_p=$(_btrfs_get_device_path ${logical} 2)
>>> +
>>> +	_scratch_unmount
>>> +
>>> +	echo "Corrupt stripe P at devpath $devpath_p physical $physical_p" \
>>> +		>> $seqres.full
>>> +	$XFS_IO_PROG -d -c "pwrite -S 0xff -b 64K $physical_p 64K" $devpath_p \
>>> +		> /dev/null
>>> +
>>> +	# Do a scrub to try repair the P stripe.
>>> +	_scratch_mount -o space_cache=v2
>>> +	$BTRFS_UTIL_PROG scrub start -BdR $SCRATCH_MNT >> $seqres.full 2>&1
>>> +	_scratch_unmount
>>> +
>>> +	# Verify the repaired content directly
>>> +	local output=$($XFS_IO_PROG -c "pread -qv $physical_p 16" $devpath_p | _filter_xfs_io_offset)
>>> +	local expect="XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................"
>>> +
>>> +	echo "The first 16 bytes of parity stripe after scrub:" >> $seqres.full
>>> +	echo $output >> $seqres.full
>>> +	if [ "$output" != "$expect" ]; then
>>> +		echo "Unexpected parity content"
>>> +		echo "has:"
>>> +		echo "$output"
>>> +		echo "expect"
>>> +		echo "$expect"
>>> +	fi
>>> +
>>> +	# Last safenet, let btrfs check --check-data-csum to do an offline scrub.
>>> +	$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
>>> +	if [ $? -ne 0 ]; then
>>> +		echo "Error detected after the scrub"
>>> +	fi
>>> +	_scratch_dev_pool_put
>>> +}
>>> +
>>> +workload raid5 2
>>> +workload raid6 3
>>> +
>>> +echo "Silence is golden"
>>> +status=0
>>> +exit
>>> diff --git a/tests/btrfs/297.out b/tests/btrfs/297.out
>>> new file mode 100644
>>> index 00000000..41c373c4
>>> --- /dev/null
>>> +++ b/tests/btrfs/297.out
>>> @@ -0,0 +1,2 @@
>>> +QA output created by 297
>>> +Silence is golden
>>
> 
