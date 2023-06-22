Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE2D739454
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 03:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjFVBO1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 21:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjFVBOX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 21:14:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C15B10D;
        Wed, 21 Jun 2023 18:14:10 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LJvcur010110;
        Thu, 22 Jun 2023 01:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ELhKPgT2OZwhPBqHMWKHrFm5nPKNY2hJHH1bzNCkIy0=;
 b=XFTaLtid5MqwwVhDIgwufDSRUOvQjdkF5YoaukejocxA84Ctt7ZlxxqsG/+in+L7KxQC
 MlCca2FQjzvmU2BX5nOy2mXGziy1NP6jtPcjbNY8QpVrb35VME2guRzLxKTUzWBDr1km
 lOYd460xKqNpPWRVo1ilNbGiEZ3KiU/2hzv6A3k1epMaCZtPEUT3Fw9a/cgKknOG5N1P
 qu5FZ7Paynv51Io/X9orSJRBbV9yjC0/exgJDq5Nla0J17nAAyI3P8hnKYTqp9KmKmMO
 Nqm4busnAN4sT5qtxFkqDXk37MPrSpsStZNDJEvfhk/TpalWo2wKpGZCcOS4r4T+QtSi Pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcrwvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:14:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LMgY8q007762;
        Thu, 22 Jun 2023 01:13:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w175t3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAuv+P7j0CKonzYU+yY+9n5RMjytCZRykQTDSDNj7jsm+QDJWnhBvdSzdbL3xF1UpihiHr+ZXDtO/yvHajC6gKXW3+T1kohhF7Rnl91r6DAcKYhAv3JdqIPF1B6dwZIvy0jeJkIl9BSuQPO+yEHyPWhoNfcJSd4NXLcwl6AtmU0Bb1sthpnxaBuuYMKdDi4DHxRdY/ZHJJESYpeMMS0584dKh7TuYi0ItG8eW4gw/iwQH6GLCaRwKn3yh2FYvS5FFAdE95ERpwZ628PFA508DYLIH6SfN62aH3Zky1GCM6K14kzlUA5fhkTjINX2EwwsyjhFUERER5KNPLvPFE8L+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELhKPgT2OZwhPBqHMWKHrFm5nPKNY2hJHH1bzNCkIy0=;
 b=YjxeT3lqEEg3BOTfu+XIDNNNPWbq0Dj5Polby2nmjNACM1KzmWMnn7sYshUP5WXE9YFcAmwQKov4A/6fcXqKwuvqKZDJHyFfOHJzI4JHusjPvDfjBjMQHwjR0KnBbe7nvnpJAAxkY9fNaFbB2EwQh/o3EBDLfSTwxKyzTNVewUNlKSZ/2JhISwxLAps4kyM/OQW+8VLpj/8omGKSyqS6emg2njhzrdC7ZxdElLKb5f/PQwzDPNaQJDh4BQDYeLeqfcwJPuaKFKq9+JpTJvN1ygLHDuV8wgWrGzX5FP5rTOdsxZoYF/9QvBIYpbj6jUzLdXOw3dsMnwCPateKwVX1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELhKPgT2OZwhPBqHMWKHrFm5nPKNY2hJHH1bzNCkIy0=;
 b=D3CAzVjCLf0JZLEdV/tx7B4ZmCROpIY93Z3egXd4ertHb+BTKi+aI4qXmaPzY5OSHyL4O4akLbEDN/ybRKovybn3+hnmkBpHFiFmf/iU5EPBmNbz3WBQAX0ziYZx9zCTiMk6byKaKfKnJeNBxb6yJznexXVrPynwAzteCIuGGL4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN4PR10MB5576.namprd10.prod.outlook.com (2603:10b6:806:207::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 22 Jun
 2023 01:13:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 01:13:52 +0000
Message-ID: <52b6e3cf-01e6-d7bf-e5a0-fe4d4e772f9e@oracle.com>
Date:   Thu, 22 Jun 2023 09:13:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] btrfs: add test case to verify the behavior with large
 RAID0 data chunks
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230621084031.209727-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230621084031.209727-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN4PR10MB5576:EE_
X-MS-Office365-Filtering-Correlation-Id: d431fa90-bb94-4cae-4f66-08db72bdf0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0604VuVtSsI5AZR36gqIDCIkAV7wLh9liJ0w06632mYn/wsIu1WakxADtjo33tncs8jqKE/uU2nZTzZDG3Dg5WVC0Yv6+4wZ+Rd5evJC4w3BIqbXuHU8IH+cQADW333PNIGyWVXeeIcDc1aQtVODzxf7IowiO2H/WvEBfcIw+QYwXDzSQh1fSSz5V6BWyj0zM9zvuEBBO3mIN9i+Ua5U3s8uQxW7BlOVZsp+13geVsL8YZEeuiySiAxVZytmATsCiKsQVMvGD4BnaNj4/bfFI9sRZWg9uqbrhDXQ31F8Un8G4BmNC28L74KoEtj2VOuZHj/hXK3D/aWotm6/lqn4jWwp3Fa/YxEAvvyhc6TyujzzhLpnsL8BF4167rIZjatFfsL0pg3Qb1XP9DKHT+7im1VwImG/lbbjWNYt6BZruLEQI1DlaoBR98T0mk2/Ea9BL3htQxMTTHHlOY1c0bcbUr2jYJJxdUbEk8bYCmhLwDlxOxj38u3OTXH63Z3uqdrXo5s+OBCG8u3+Nzdqf7uk8fiISTm3qesXB7hE+P+1FknsKjxFZJcMJMHmzrLUgwQJp1HV12fLwnBQljEF4pduPqaNeSuDUy5i6okPG9zBU8P+k3PIw/ZTsIwaS3jPC1KAdkngCSCo3YnExBVSrD8RgdjtWvzQi28xo8TOM3Ee5MvGCZVU0EkfaR260ipah+DXnB10wATgC3PpodL9sGNtoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(31696002)(4270600006)(31686004)(6486002)(6666004)(316002)(38100700002)(8936002)(2616005)(86362001)(8676002)(558084003)(6512007)(36756003)(26005)(6506007)(186003)(66476007)(41300700001)(66946007)(5660300002)(66556008)(44832011)(19618925003)(478600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2tOUkhkN0xKL0hudlVqYzhDU2tOUVZ2RCtaS0NTeFFIMUVpOFNKS25PSnJ3?=
 =?utf-8?B?bk1NWmVCRlhHZ1crM1M4dWJ3T1RhMmFBZzdMeElZNHFHRHRzaURialVsalNS?=
 =?utf-8?B?VzBMZ0tPRHhsS2FoWlYyVnF5UVBIQ1BJbUxOZTVRSmd5R01Ia0s4QldPYU1J?=
 =?utf-8?B?TXBqY1cvZ1JaZ3NkUjlDRnJ5NHgwN3lDYUhlVUZMTm1wQmFFYkx6NzBwei9y?=
 =?utf-8?B?WUx5MEVIMHVwemZGUVJkQ3ptMlBGY3FhSldqNjB4THVWRG5mQldydWpxUmVU?=
 =?utf-8?B?OVhIZk1LN3QvMjlmQ1FHMkQ1Y1B1UVUrNEJGaDRVNDd3L29pYW5NLzhrcTBE?=
 =?utf-8?B?WGo1YklpNnlTV2dXYTNnNTFOczhmcGtFWkZSQUNmaEU1aWR1ZUhISTdhSUN5?=
 =?utf-8?B?THFSYldWWDM4ODRrT1U0R2QxVWJUWS9aRmIwUzV2R1pkQzhLc05ZRXIyT2dv?=
 =?utf-8?B?L0w2RnZ4Q0xZUUtIb0V0eWVaM0o4dUpia1hhanFqakVLWG1tZ3VGU29TdktE?=
 =?utf-8?B?RnRJRjZZbUhIN0VqNWt5UDdPQ01SRitFbm1LWTNwc3dDbVBRVC9RS2VtdTMr?=
 =?utf-8?B?RmRrbHUzRHhUVTVpV21VQlFjQXFOSnEvbWR5Y1A3R1pHblBRaW1odkMrYkt4?=
 =?utf-8?B?V25UVzU5OGFXalVSVk5yWTRUOTFNMlY0TXJYZXZwYWpsQ3daVDQyS3FvYjZo?=
 =?utf-8?B?NHRFc3VWaysxdnZTMS9pVkdVc0taT2RKSnBWVmlEemRBTkI5RDN2T1V6TEcx?=
 =?utf-8?B?c2U1UG9xQW1CbWxLczN0dUc2a1dPWTFNNHZvYnEwWEJnK0d4dlJpMVAwUGti?=
 =?utf-8?B?WmJEckNsbzlHRWJtVzJlT2s2QUlOaS96Q2d5enI1bkxQTHBzZkQ0RHdzbU5L?=
 =?utf-8?B?bUtGRUVQRThmeFVDMWFTWVRCTEc1S3dWZFc1eHY0VlQxd3BnSytWRU0vL0hI?=
 =?utf-8?B?aXdHcXQxMlc2UGZ4dS81dmIzNTVERjZWVGhxOEZ3WldTZWI0K09PVGZURC95?=
 =?utf-8?B?d0tFSEE1eVhkMTE1S0hwMnhEOWtDcm1nTXVwTGkyRHIxdnQrZ2NkTnJxYTBu?=
 =?utf-8?B?aTlidmxHWjRybXFick9tT2ZyRnZ6USszUHdDdUNSSi9XNXpOMjgrWDBkbThJ?=
 =?utf-8?B?VmNCdWJRQVVuR2s3Uy90cFBZdGl5eTYwMXQ4SHMrRTgwNXJZbmxPc1NvaDUz?=
 =?utf-8?B?djR5cHNwQmo5MFJ5U1BFK0FXb0JJaVRZNHVPcnM1NFhpeDMxRzFyUForSUo4?=
 =?utf-8?B?NFRVKzYrYWpJNEpqaFpCR1dDSzdKNXhENi93a0RobGtNVnY5eHNZa29CWlQ0?=
 =?utf-8?B?c2JzOEJ0ZDZ1Q0hkeGoySUJYa3J3bzZuTGJvQStRRlduRmUyWHh2Szk1SXZE?=
 =?utf-8?B?VFp6WC9RWk9hMFVqTTlrVTZNamw0Tm9PT1QvTTA4Y0pZYUxHd05md2NBZnM0?=
 =?utf-8?B?NWhNVEVta01WeitpTHhuVkJjbnhZMnllejFpZlF3Z0dka01mcWgzN0l2ZG5R?=
 =?utf-8?B?czFLcXNHWDNHSUpFeUc3QWFXQStJaEhUdjZ3SUZlT0FocE5Fakh0blpFUkJr?=
 =?utf-8?B?TThHTWZyVXI1cTRjSnVUVEFoalZJdFdIRmZIbUhzU2FyaDJ5Q1V1RHEzeGY0?=
 =?utf-8?B?ZjkzcmZIczM3R2VsK25yQ1RsaURhNHBMV21sR3ljVHlST2FQRDN3MEl4SDNS?=
 =?utf-8?B?VnZwdlpYcnJ4U2M4eVNlSHJiV1ZKbWFnUkF6Q0ZPQXlwN09hSFhwckdtT2w4?=
 =?utf-8?B?eFJkRVBzREtWaEhMQm9vVTAycFlsOHplbDRILzluaStuNFQ3NTVMS1BNL2F0?=
 =?utf-8?B?WjBmMThUVTZYVTFkeXRGN0w3WHdNeGhCU1BxSGFwTHFEeG5Vd3EwcXFQV1V5?=
 =?utf-8?B?K2MydG03cERBcTR1Mll6SVNhWENpOVdrWVJOdVl1UnRHSHZ0cUJNRi9ETnd3?=
 =?utf-8?B?RnpKL2YyZmR2cWUwZnlaNDFuRzlVT0p4N0NmemZZbGdDdHFiZXpna0xHNXo0?=
 =?utf-8?B?YTlBTnhEaGpsVFhwZS9mVHcyTmJEUG5ESVRXdUpxNEN3OFBiYzFHN2NMeXk4?=
 =?utf-8?B?RmI2U0IzamcrRTdOTG1ETFloWVRUT2VaWElYRFQrNHJWUnF6bUdmUXg3UkpC?=
 =?utf-8?Q?RhZ0LaQvdwyo1yl5PA0VEXNy2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xL6bmpWO/VMStG//LCuJI6RHufajbWRBbNFY2gcAj4fu29nzlXk23BGfhN6QHOrK1RXIicQ2hrxlGIUHR9yrjrQBZ8jd4Wmmof4NKQNCYkwKA3+sCkstJfZRxdAe8BcIzbtLNvb1ASn1HF5XV+x9Yx4H4siaqclt81WG4Nr8Yi9UQgBsDUCfh/EjbAYrhLIhldZ9jQWJjzpZbaIQI2BoTX87CVUWOWplSFekF6POfhc+XJnrpB5zkzxnlMMAkOF72kdVzSRFtq9BRCmMAnDEnev5KsDXP/5V68jQ8lSOFaJ6Fm72Hee0ZOZEbyo+rY8C//wtQ7rgo5S/fOS+mTsYgEiLTxMiLgaMsJj9XXu+XuuVdDeXxTwKXng7XvzlwqIv1vBqV+6I9YOroHgPYL7fBduwbiziGBHXW4PGJVfCKQ6H31nVsslUlRN4x+LFjtFjfFPqTJ8GicA0c23XRq1w4JhZe3WVwNNmCxHkE/UfxkydUGDWShTEGDpJNPqqy6f7OL0fbSVLtkyEpFfHpFbEBY2QcxXCKaXtLl5GuhrD7kh2RpJeecAvdusH24f6aiI4tSsMY/1fd1rixpCYNH+HJgReI1KL4RwosLqYEYtnqXKBU/uTZZbcTPfH148vSLhPJMdYnSa0IMu4eJ9qG/LnAZ+jyjVkzNK6XnmFYPxyaes//2enFObF6p4wK7wd/YTxjJ57w8LcjDyqjvvghD+ly10yQxEg1vAtYk/WQfFopd0QV7KIttYa0L3SmY6DqohIoYNi/IYv45AqFhW2fcW380s1+X/HyDp3k0vHD0XYG7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d431fa90-bb94-4cae-4f66-08db72bdf0d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 01:13:52.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guUk8WOz4FYHleZt2jxq5tL/NNNiXFJfxxhAC0ZDQbgmlVFYJwLlpz5TN1Hn2pTavH5CL1QMAjydv3Eyr2LTjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220007
X-Proofpoint-GUID: RbhWx95EVO4uNQMG3wfFj4Qdi1rZoNI4
X-Proofpoint-ORIG-GUID: RbhWx95EVO4uNQMG3wfFj4Qdi1rZoNI4
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

