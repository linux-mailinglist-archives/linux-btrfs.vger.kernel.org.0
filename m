Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E736969BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 17:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjBNQfQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 11:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBNQfO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 11:35:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A732C667;
        Tue, 14 Feb 2023 08:34:29 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EGXpvY024874;
        Tue, 14 Feb 2023 16:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BxrFnp8wXSDSxQuYsBrskFZ6CN6m68YtxgYBtvpFlQY=;
 b=2JN4tSHAS91bQdALEbG6FxfJ8XKFnKuOYaVKJxOYHhDFdtvZi7ysQXqfObSTShLQFhXw
 2V8rpBNetNwJcA3VxgPJnCEyZzJKBnKa6KvdUkbEh7CDI+OocLeDYHkDOG6O0wimBnyR
 qbJdHDUV0pnNDw4wPlhjEiweuadaXKDYHa+1bKF355KHZIYK1o/0N3RSstXKzyq1EYxl
 p/IXRT7OhRJV93igurgqxR+7Jklzr6c1MJSdtcclneUtMdN/bOcOcw0iYsWalqypwuDN
 VEmnHldytd0wun93cWqUP+4SsO3w+PahIB5I8WfqMaUmdk5oxvwRsJD7EQQ7i/hCqDC/ 1w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1edduwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 16:34:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31EFOJGr001158;
        Tue, 14 Feb 2023 16:34:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f5hdqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 16:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9/TmTdr2e1JCiZ2InBkIpe7Av7IhxzDXGaKh2b9/vtks3iCIi0VzRpFdQ4sf6Xzkyw3v6tXzp6sWo/mTbR/7ZtWteA+dpFoKRFu/LII7lJwYhNnyzRPWx0FcZdi6jpZds7bx/PdvnfQfJMIbFW9IjlTv2rColn2kREVha7pEwbol19uFnkNUkxgEUYas9NiEZOMg5ei02FlIpRE2o1Bd0nsZlmj0v1ldHVfggg5Q1g+OZA0ZzwOyBFSg1xTEZNcjPEc4M8ZWqKN6UGUJsW55oquyeMAtsxheassMNYOC6ZyvCBvzS+BtGnv62tkJrvhLaninwRar19R4qA7t1vHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxrFnp8wXSDSxQuYsBrskFZ6CN6m68YtxgYBtvpFlQY=;
 b=Pn6LDROGRPGmt0yrD9fkvuzYWKEcrTs0QbMlOeeRHTrkqjyyVCNVIaKpJgRQkZu1h/EecFdUMR+25cA2rvosNxoBW/7qMut5Ej3x6r+SkFzExlkiAz89TFRDgqLfljV4xeeD3imnZRNW/FeZnOWk3srz5u1fCUkT4ES8A2HbNcSSZmHnnv1EWWhxkwy4jG1PEN51ti5sCXOjspsW+QUz5Wxu2gFZMdx74tW9qLwBVeGNRoykeHCZFOpGxon4GC2UrjG+qjjSQpk46dcpftN9Q6LnahIADHL44Z8+I/tb1mf+T+dghZN01MRoDYV22l9WWFDVPVIwg8H7YPdEi7Xjig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxrFnp8wXSDSxQuYsBrskFZ6CN6m68YtxgYBtvpFlQY=;
 b=ZJCvCBuH/qkKxJ6EEU4rqetPp26u8R3gjxWrCgatkHfn/yvT8hjC5A5qOxbjoo8V6KCP5XcIZuyeCyTRTaJRGrGJlTNIDBqakyey/Qy/dZ6lwk5Uj5/YSNwmNxkqShnDHs1IftfAGLlrPqgqxSnkPP9o/LMmT0qTisFAYpvSNAM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN0PR10MB5935.namprd10.prod.outlook.com (2603:10b6:208:3cd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Tue, 14 Feb
 2023 16:34:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 16:34:23 +0000
Message-ID: <a197f440-1c3d-5898-800c-6712484ea073@oracle.com>
Date:   Wed, 15 Feb 2023 00:34:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] fstests: btrfs/249, add _wants_kernel_commit
To:     Zorro Lang <zlang@redhat.com>, Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
 <20230214061748.z4to5y6dr4byw3y7@zlang-mailbox>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230214061748.z4to5y6dr4byw3y7@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN0PR10MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: df98dad4-d908-442e-71fc-08db0ea95426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LDHvUvtsQlt7T5mcm8qMjx2v0kNBV/Zzj83YniXpETJPXO4ry7pkzLVwD+9unvgml5hv20rRMLrb+iabpKgZkolJDk90KgasvkfxfQmgdGiQYbPZBiqXBHOgMPiGo3w02OIMitNdtceip0WIbDkreLdibgV8mlJT6qywve2+S+338MF8KUxwSXoH6d7F4zJyuz0Flj/4oKzFmOO+HgOjDvqd9EZDaaPQ7anlnl1n9uJwYclaOkEHG0SfA9ehVqbSlArPJSZcTq4p8yWKrP1/+sknjk/ivth1aAfC+BH+NhA4Ma+batl1wmj5H0ngQ8fYFAq6wKZj/5Tt+jcy81wIQtLnuTR+L45wik6t9gG/5m7YzmxLzrI4//XCKxZw61RwRX/PLwSjD/i5mMFiKoPB3bS+PgHsULT6ykaaA1vLnuPqv2qrhKfYuFhPsAQbuX6T7ZE/XiKXiyHbiUgIYaEcDrr+tUXdWBUFbLk3+g9oF3uCga72NGdWVGGWBlJ15Kfr72ujvS57hlkQD4lClqI+IkLXOHAOdzSWB+SCL5C3NxG1EWjuLQ65LpCbdSim8NY8N78ItZE1SWG++5XbipHO/SKpZ07Xl7GPBYo6kk9Hexdx/JtVd6p9hL0OFzEpmR/pPr4l0qlgBpIMJSfIEFyOYcEGbUdUTBr0Y9V+XU5b00Dv27U46W0v5eI/Z4M3c7AsXg1vRC7+kVROIZ94jErTj5q2iMD30ZiX5IdqhHxuBqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199018)(31686004)(110136005)(6486002)(6666004)(36756003)(2906002)(8936002)(316002)(41300700001)(31696002)(6506007)(53546011)(86362001)(6512007)(478600001)(26005)(2616005)(38100700002)(5660300002)(4326008)(186003)(44832011)(8676002)(66476007)(83380400001)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZCNDVqaFlFcXVoRGNqVTBBWExnUW50M2FodElNd1p1Ni81cCtZOEVXU2Iz?=
 =?utf-8?B?SlBJSU9TY29DUTFpVDU2V0pUblJqdlVRVVZiK1dvRStvRXJGbUdpd1YwN1ho?=
 =?utf-8?B?YzNucWFlSjNHUXczVTF4U3hEYm44alVrM29TY2N3OGdOd0VvTmxleHh0eDVt?=
 =?utf-8?B?Ly9mRFM2NUJIRWpsQmMxeXlDdXZJazhUaDlTSVM2cXAxTWo4QXB4VHJka3Er?=
 =?utf-8?B?c0RlbG9wc3hnM2plMW05UzhqdEJ2Snc1Zy9xQWMwdHdrenBvcFN3bkFzeldx?=
 =?utf-8?B?TnlqQzVOV0JzR01ReGlMSTVackJHQ3dvVkxLZTd1TlROWFBxR24vTTcxbzNU?=
 =?utf-8?B?RHlvd3c2Tm5DY3hGKzJYVkY1T3dPcWcyTWhIQmREaFJIODUzOUtET3hEeFhl?=
 =?utf-8?B?VmZ0ZndqWGdXQlc1Z0I0RXpFQkV5Y05rdDA1UGpRTWQyL3VhWjF6WnZ3Nm1H?=
 =?utf-8?B?SDJScldTSkpoRFpjVUtpdy9jUy9MM04zOUdEL3RybHQrVHBIYzJsMHlCNUJH?=
 =?utf-8?B?bnJaT3JsNjhaU3hhVm9PbmU4bjVZSjZmU2MydUNXbExuUTFvNkRoRTdKa3oy?=
 =?utf-8?B?WTg2Sk9yTXZWdGFWeWNFVU5QQ09PVVkyeGJJbXQ3VVdJR1BqNDkvYVdvZE5D?=
 =?utf-8?B?ZE1abDl3bHJmSk95aEVqL2pUSUVIMVhaMkxXQ3B2dDdwTTNtRkoyUHdkbFNJ?=
 =?utf-8?B?Z3pCUWNZUW9pbHpuTHBMYmlkK1J2am9MNXdueDE4aVY2N21iemtjbTRMT25z?=
 =?utf-8?B?MWNKRWUreEk4enJzVGI3eVQxOVI5R0FNWTBGVHFsYkpHVWdwNytnRWFIcVZS?=
 =?utf-8?B?dlA0YnVnZmlKdTFzQ2ZJZkRuUC9ZTmlpSWhoWW1HRVN6djY4dUhqakNkQWdj?=
 =?utf-8?B?cEJsQXNmWUJrcjVtbFFyRzE2eVFVa2hxNzYxUnV5aGxlQW83RUNOdUhTaitH?=
 =?utf-8?B?N0ZETkdVL2dVSmVmMmh5TDJRVElIVUtlaW9YVmhvY0Q1YUNWRjVHWEdTVHlx?=
 =?utf-8?B?aFN4ZFVIbVRqYUI3Z0N5L3ZmTUlxMXpNcVpReGJpZ3BOenNEWVpCc2toQXBP?=
 =?utf-8?B?ajdheW1xRXNSM1QzcUNQZFc2WXJVcW9TYnlGZ05sdDZvbWlIb3Fzc1RjRmhI?=
 =?utf-8?B?THJkcmhzd3ZiR2xSNHhLRlJheTZhUGNQVnpBclRoWGkwdDRjRFVDMk1ldUZ5?=
 =?utf-8?B?NExoVEVLZERmejBkYWFQamdsaVl3UFdiWFFBZmJMR3A2a3ZRYTRVcFUrSXA4?=
 =?utf-8?B?Q1diM0hQOGxTdnI4SXUxK0s0Z09CN2JaS2hNaTNCQi9wdHJJWWN2TklxYWFv?=
 =?utf-8?B?WUFMcEVKbnVHZXNISm8wWktEck5kZWVWK2JIWUN0Q05pOXJRRTVkblVWd2hk?=
 =?utf-8?B?QTErbjZyT3gxdEJwcmFJYzlMQU0zZ0dKSFgvZlZ2aFVwWms0U0kzM1F4b0Jy?=
 =?utf-8?B?T3RXakJkWHUvSUNVTjRBMm1WYzVmL1hkUUgzSlUvL0xQRVE1M0JQUlJkWDhO?=
 =?utf-8?B?aHVGbVdsRlJ4L0FuTDk1eUFCUVpVMG84cE9YVEVyeUhIUk8veWJOWnJhdU5u?=
 =?utf-8?B?ZkRYUDhtWFRIYlpGVnByaUdmc2NEcEpDMmtQclY3QjU3RjVOenQ1WE1tTWxv?=
 =?utf-8?B?OFE5OExzYUdkU1psdDJRR0pLZVg2QThpM2tYdDZoamZNUlBEeDVramhzNFUr?=
 =?utf-8?B?SzdDNWQzYXR5N3ppVEh5dVdzeVFlUnNtbWU2Rm92akhhOHVxZ25GUExFMkxP?=
 =?utf-8?B?ODdKRXhHd0ZKRkpWSDl4WEtvWjkwYWNUdUl4SjI5akl5aXdseVBwOWw1Ny9h?=
 =?utf-8?B?NVZkRnVsSnV4VWR0dTc5b01NTTNpQlJzVlZvYWZJT1BIamJGR1RSMEl3eXQ2?=
 =?utf-8?B?dUh0ZEp6SFlrcFdOQTJCcjA5SUdUcXJrbFB4cVVsaHBIUDFPOC9FNXZ2VkpV?=
 =?utf-8?B?TFNnOWR6bjA1OG1oLzQxMlQzeHJSZ3g3djdPb21NMXAwRk9jZE1lOHVtM2U5?=
 =?utf-8?B?UUV5QXVza09TL3pOUFFxaDg0cmdCQm03MHg1UTkwNVRuSFlaYTIxUUNnbktT?=
 =?utf-8?B?MFRBcXRRZTBFa25VNDJHQ3ZicUx2T0pNUlFCYkpmN0RhZ24wNnBMZXFsbTZP?=
 =?utf-8?B?QTduSWpva1NlQmJsUk0xTzBSaDdldzd1czJ5KzBwNW9UMEhwSHFDVFlnbXAz?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tCxQURt+lnqZN9/GQg88P7iBXrLeNtT9QmPcQeP2z4tE6LZbLGosNeWkPf2xweimxo/2o74zZjKDRqrs1tRVp3qhySgJNYHgHbieflIEEEnVyhPElgH6CrlnjBzWRJSk0Gx2Uo+R6d0rv8i8WoV/T+LW1uDUmwzEuXwEnU9MEjKXETJBpXpxTyO5CXtsyFPGcTBOQ4ce7q+v5ORr1MUK3XOxTnYhd+ZXME2s4zovS7GJWcp5dbfX33MFy9HGYY1yKIfvwEqjVGQzD1mla7a+oFQjQ+z7RwIsRg4DwhWFuSYQubnfwcDE4AQ9UHEn/8kqBL5M7RBuLeAOKBSEouLby1ZJy1qm31Ifj15aCH1HY243/Y44rYXlARVd1pLAHc0+aVHF2qXWjzUxpYOIZ8JaGBjQYw4yO2HbBTBF0EIQPpZmz3NRguNtU+LtygH5rZEdh1ENejuqAoxgdzthSBUWZhvI4ZKCHweZfrANDIUpYuVmDJljBH5s2kK9SvgdgPGpAfffJNiX4Q8TvcvhF4xIA+Tjge6FXqVq38b3JMXTAjZWsgnh8g8iokhFUwYqPAasbPeBDB80qWDNA4/+7eESPtsuh/gSMHVW/EclRQNvMb3Aj33hyzEFyaCh0mD+rK4l33DTik4FXH8TOU9vyBGaDk2SQSVc8qrSsW45g1i8ucNOEydYqegAgui4QVxIHcceKdtgLHOZ4jdDxnw1Ub4CkWh+0nokQnAFOkNFpeH0AywXKCT3TUzJgaFvAgEdqd8DQPUe3UOJCFNrtACewBXIdm66DK8PQyPt2IREjnwu8eI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df98dad4-d908-442e-71fc-08db0ea95426
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:34:23.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHYWiPo14cmd0ujAFuPUVX7711qFFGDRqHtXY/Gzk81u2LX+6PGvyFYrpA4sK1IEbmKdylvVzjQqeBFh5O6qLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5935
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140141
X-Proofpoint-GUID: 7p96_piw46epg_TBoPfqeVjwlL5AjQmW
X-Proofpoint-ORIG-GUID: 7p96_piw46epg_TBoPfqeVjwlL5AjQmW
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/14/23 14:17, Zorro Lang wrote:
> On Mon, Feb 13, 2023 at 05:45:09PM +0800, Anand Jain wrote:
>> Add the _wants_kernel_commit tag for the benifit of testing on the older
>> kernels.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
> 
> Besides this patch, you just sent another patchset:
>    [PATCH 0/3] fstests: btrfs- add _fixed_by for new tests in the auto group
> which try to add _fixed_by for some btrfs cases.
> 

  Recently, these were added to the auto group.

> I think we don't need to "fix" these things one by one, by lots of small patch
> pieces. 

  ok.

> If there's not special reason (e.g. someone case need more fix besides
> adding _fixed_by), how about combine them into one patch which "clarify the
> _fixed_by or _wants commits for btrfs cases (or only for someone group)"
> 

  Hmm.
  btrfs/249 needs _wants_kernel_commit; btrfs/198, btrfs/185, and
  btrfs/219 need _fixed_by_kernel_commit. Merge the latter and
  send as one patch?

Thanks, Anand


> Thanks,
> Zorro
> 
>>   tests/btrfs/249 | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/249 b/tests/btrfs/249
>> index 7cc4996e387b..1b79e52dbe05 100755
>> --- a/tests/btrfs/249
>> +++ b/tests/btrfs/249
>> @@ -13,7 +13,7 @@
>>   #  Dump 'btrfs filesystem usage', check it didn't fail
>>   #
>>   # Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
>> -#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
>> +#   btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device
>>   #   btrfs-progs: read fsid from the sysfs in device_is_seed
>>   
>>   . ./common/preamble
>> @@ -29,6 +29,8 @@ _supported_fs btrfs
>>   _require_scratch_dev_pool 3
>>   _require_command "$WIPEFS_PROG" wipefs
>>   _require_btrfs_forget_or_module_loadable
>> +_wants_kernel_commit a26d60dedf9a \
>> +	"btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device"
>>   
>>   _scratch_dev_pool_get 2
>>   # use the scratch devices as seed devices
>> -- 
>> 2.31.1
>>
> 

