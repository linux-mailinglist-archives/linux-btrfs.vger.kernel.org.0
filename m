Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6474071555A
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 08:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjE3GJM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 02:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjE3GIt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 02:08:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F7126
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 23:08:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U5kmvn022371;
        Tue, 30 May 2023 06:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=eBGkZ+R0G6TyoRRpeNsGQGYCyh/aVGyeuS2PEDsCmxo=;
 b=jMwHCu+1KdeptgCQjr0D81YNjwfO14/PD/brMVvad1Eq5TLvclrq05okX+iZ72CrCajN
 StWTOPT7PHmBIfkYzgblW2GimYweX258zGhuCGZYHxJm8ejwO5HwIgSPJb6AUVIjsisY
 SZIgQHHw/z5pOBZXurceuDpFnD2dIsOb3AngMPcPYJ3BY3tuQanT71e0Of794DBmgqTv
 60HwMghQS3w8ahNJGXisX2hhG0T4YnoG90mo2uTjP3bO80AkqX4xotXI80ewNh+azQca
 CZh1hDd4zVroTF1pOJuTVU3g6Sd41p//VnU2nyT5kYLutO1gCd2cvpClukqQ6sWp63ms Ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj4svfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 06:07:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34U45HVD003684;
        Tue, 30 May 2023 06:07:06 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4yavwjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 06:07:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fafm3fivTXachNt+QczG7jOGavJ0EYluPgxRS5EjoiYxuBf6mk7Y0fQhwLk+RlshYN5Hnc1dHsh+RciLGDUyTBY6kDfcqWavt6KsdvRfT0BLoXlRzNsl+fBQcv0Vc7wxShTUlgdA7VbdkWwqGZhUQNDzgx7rIZYyYWAKtBUPzm7pB6t3FFgRPvlvXT5tqrUll64RaY7b/pKyL3T9JU2XPFYRBveQFLi2IISKHLoDiahSikcaXIfI4SHxJ+y6FSElpta2eTZ6JNasesX8c65EKwWpVB06SwNrQHEdLtPtb+gpOZDN/qu2wuOijgYeJi0NYhfK3/jN3dZyYEsmM2kWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBGkZ+R0G6TyoRRpeNsGQGYCyh/aVGyeuS2PEDsCmxo=;
 b=TYnuySnLwWVBTMXppPWMMPYdNv9rjux5dKzpqGNtdUC7sauPm5Ftmo/Cn/yuGtJ5Xm5T6rIaZ9oDCRxnyYLYiwE95n7nZQV/WMQpSHyhg1aXKVFCwd7+n5TAiDgdAA6g5sY40jdoV32SifQ7meFoQjAYqvPIEM1AAzC4FL19DN0d0ixr796FkKrXuk9SM4ZjaDP9HcsZem70GLCIQfmpjD5pXZRKLg/V5Msvfs8rM41zyo8OU3b71Mv+7vSjgNrEdzWNLNAnUYP7nLoSV3sbCVo/n8BAh7RynaYRnQIK9cJtqif9V69o3Q5T0qqK8yunqJgM3UCsfWUIxmOgb0FGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBGkZ+R0G6TyoRRpeNsGQGYCyh/aVGyeuS2PEDsCmxo=;
 b=tcisk+oO+DGnZl8Qgi/70W4+rXskysCl5dFlt+3dJArw2vZgzsvz56f9Acbx6eyu7q65Z/TbswHqGWkKYG8pJirn096E0gq8xWehaF3hOXWaRqMPXPBZpReg4T2JIaLZr/IGrn85SoAbYz0D7n7fw/aDHMQQkkRrkKL8Ps+msOo=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SA2PR10MB4409.namprd10.prod.outlook.com (2603:10b6:806:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 06:07:04 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::cc8e:8130:ef15:a31d]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::cc8e:8130:ef15:a31d%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 06:07:04 +0000
Message-ID: <e857e672-3181-443b-4866-bc0bb000bc88@oracle.com>
Date:   Tue, 30 May 2023 14:06:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/3] btrfs: use the same @uptodate variable for
 end_bio_extent_readpage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1685411033.git.wqu@suse.com>
 <65fed3703d077362b9a7b3ec393452c40b6895db.1685411033.git.wqu@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <65fed3703d077362b9a7b3ec393452c40b6895db.1685411033.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SA2PR10MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2fb988-79eb-4205-63bd-08db60d41728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDnQsBTvx8YNROotUqq9+aw4am+HppnqMivUD+zQgXcKN5wzvShVfVli2rdkdCCafpynHXNnG5ablpa3qmgNmdC7l3JcCaeiPF0bysN2vZzyfOddZdoaGYXaTpWOvd+n4xE/3S42Xfme6Mr17wuqb7XD9wOJEbcUemXDcfBmhlH8BX83+FB9SoqUR/qh/uCIDfrfsVbKbX3FQmWDftxrtaRWpN8f3zHIKBrO3i3bdiHTu1gxQ+M2RrcWdXUT0m/C5nv3qcpXXxldSyU0nWZZTKNBXfeQndj70I1N6SIus9iKr+qhixnjFHyNq5dp0W6HClGgxx/bW9u02TNeQQ2NazS2oCNdIJV7o0elg1SErK5qHq1dfwruu4tOa07HXTniGb8sjIHdIxPlI9kwF6dnRtWEUdKBR65Dojq0Qeiep13K3A0tDLFsMMtVx5XKIOEbij2zKx/B9aTNdkIfoujw2gHvugnaztKREOF8loU0ViIbneqN2/6PqBLmaJ+zkpNo1xK22/2VR6dygVwPcPMtouJv4Zz44ByZ22Gm1QKmksHVe7n3V1vDj7PA8xpBnM5I06h28A3ZMpfGCHiM5di02974mDLyg2rGt1F8lWvg5WAfzuMaTnVVfybjvViSNyIdHPHhvNrzF+ZBrtr2tr+ltA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(66899021)(478600001)(8676002)(8936002)(44832011)(5660300002)(36756003)(2906002)(86362001)(31696002)(66556008)(66476007)(66946007)(316002)(38100700002)(41300700001)(2616005)(186003)(6506007)(6512007)(53546011)(26005)(6486002)(6666004)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1dWMEdVVXp3TFpXeDNXSi83LzQ3dFArT0xiZ091UnhiMEZYYkxGbjFxZUR2?=
 =?utf-8?B?VTFWVWhGSXV2MDc3ZHl5TGd0T3FhdC9zTHlNUFFvc1Z6cUpjQlRYbFh1SzBj?=
 =?utf-8?B?ZkR5VEJDSmkzQXFDUjNzeUdNOVJ5TzEyK2tEUng4VTVXNFdjQTcyREpqcmcz?=
 =?utf-8?B?ekRiOE5lWlc0WGJtR21Zb0d5M3J1WjBQdndPcjFhVjRiZncrYis5SHkyam1V?=
 =?utf-8?B?V0d1ZmJsb1FhL05kNVNOTXlkOUZueUJHMDlGWmhCODB2VmlaNi9oZElwa3ZN?=
 =?utf-8?B?WTVKQXp2UG1SWUl1ZmQyY2FUTWxHNGFtZVZaV3FBNXdYUkVXTFNxVlZQaXZr?=
 =?utf-8?B?WUZHTlRoZ0p2K2VsbEJLUEN4Ri9Uem55eDhHRmt3Mm9sRUdyb1lqMEwxUXVZ?=
 =?utf-8?B?Y1NFM0JBaHQ3bkxiSS92Qy9ObGJ2aTRIZUpqNk1XYlBScjFVd0dFeGVNVFRI?=
 =?utf-8?B?dm40Ym5CNEtScU9veGUrQWdjbGVkdmVQcDdWMnI4T0pON2JUeHlqd28xejNG?=
 =?utf-8?B?ZGhNZnlhQmFFS0xWYm5Db0ZnNllNRGtmNUdFWkpvYWZFYVNWdlQ5YlhEaWlh?=
 =?utf-8?B?Rjd2T3YweHI5Rm50a1pLZGdNdzJPNlV4anZuc1ozTm5KdE9Mb2E4c3k0TnlY?=
 =?utf-8?B?SzR0cDNpTXpIVVJ1dTN2czlJWk9KTVpOY0xMRWEyckRTZU9RcnlkZ2oxYUNV?=
 =?utf-8?B?RXBjbExEd1VhOEVXNVhueW1BSmRpdHgzZWZHWGw2L2FBVEtKSzZjTmNvN2ph?=
 =?utf-8?B?b0lkNHc0RlluQ2RjU3RidW1Ec2l1eXFlcjlqbGJPTm5ESUkzNnRqVTdDRHNE?=
 =?utf-8?B?amVVYzNtWG9pY3QxbzB4QkRZeU1lWUpTNEthQ1VkbVBVT0tzWFlhQnExMHQ4?=
 =?utf-8?B?N0xtT0NTZVMrcXBlaGpHY296b0VmM2hMV3pmQTE2cGsrUE5LZUpOZGNtek9p?=
 =?utf-8?B?SHplVTBCSkF1NkY5MjRCRyt1SThBcThNVFkyYU1yL3VLcldWMUVteXJQd2NX?=
 =?utf-8?B?TUkrZFRnazZZYkxzY3F5KzkwM0Nkak9zaFBsa3hLOElMTEpIS2l3WHBjYVdz?=
 =?utf-8?B?Q0UzcFoyT2tDcFdBcXJsbU5ac3JtK014MEhhMElSakxIYnRrc0JNNHRQd2JX?=
 =?utf-8?B?b09vbzI2TUtId1I0Szk3L0FUV3RBWnB4SC9JemgwQkk2cjd6M2FZa2VxMGJs?=
 =?utf-8?B?ZjNrR3Z3SE5xaXU1ZUxCbWZVeDVuU255d3VVUlQxUmp3ejU1dks4b1dJTmc3?=
 =?utf-8?B?Y0YvZ21HWkdYZjg4bzN4TEY3Yk13QzVnR0JoNjZ2dXV6bjNHTG0yd3RLMmVm?=
 =?utf-8?B?VWV1aGFmSE9UWDRldjhtYjJ0WUN2aXRGTm11M1ErTzZNaVBxY1gwcFRXUlNn?=
 =?utf-8?B?dWt3MjZvTFFwNSt1NnhMS3RrbkhYd25pVFdLUjcwb1dZcEU5TkU0aUhmOGdM?=
 =?utf-8?B?R0xLRTFKRG5sckZQSG1IcVFhVVN0cXBBSzl1eERVNEpacXMxZUVpbWdDeVcv?=
 =?utf-8?B?UzVsaDVWcEQwSmJ0MklPbEhucFIxMmZmNFByS21sK0F6MExEbzBRNFhTSmIx?=
 =?utf-8?B?NWl5aU1lelpaNEtaWWJZRCtJTWt0OTI5dkM2UFQ5bHowTVQ2WVB5WVdPQmx3?=
 =?utf-8?B?U1hIMzNvem1jMUpCTW1tcXpCVWJUQUUvcHczRkZlaTBpVXp0cmFrOUhrZDlK?=
 =?utf-8?B?YjhtaEgrSUNnTW5hV1dBN04vNWVLYmNuUUhuVmZ5OVBMd0Z3OTdGZG9MOFJL?=
 =?utf-8?B?c2w2YXJIUUxSbGZiZmpwc3BYMHVlNDVIb1M4SnNBYjcxeU1MSG5jMjdGSFR4?=
 =?utf-8?B?NkVLemhjeURFUEphOTNRYlV0TTdESFp6ZHdJbWdrTFdtMjQvYlJVZHdmUnlV?=
 =?utf-8?B?dzQ4MTJkaS8rRVRVR1pMVnFPWUZFTnpxcFZXNnVKcE1RbGFFVVZKOEd5azU1?=
 =?utf-8?B?MzNkVmI5c1EwTzVTUjJTYWIvQWgrQkZhTjhLdjBIc3kvdmRsc1pxbjdzajNC?=
 =?utf-8?B?d1RSSEVSbWpKUkUrVzZ2dVR0anRtam9CRE1naGJTdmc0YWhNSlQzcy9xam9l?=
 =?utf-8?B?Y1cwMUdVazBaSFRaUVB2c3phdWVhclIvYVdCQStFR21DRGxXNjFtVTd5d2Nu?=
 =?utf-8?Q?A6M0mPjeUk9/n9ojB438pwfwH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hDtNL1rAqpdk1EpHJ1F7C+0jxVx5OmMg3CgQ2tw7lfPLSAaMxetnRbBzxA9RuIEKvwgKgS4SZhxlIrPGVAKQuiQZhDCSZxhgiOmqrjRVF4dEsq+RVvdYzM7m8ZAeOHi0Tid9mG1lW0uXA0JGXxkOl3ox/YDAfyFUR52WOkaqpbIXcTGnj2NCBLuU6FxvbusfufIQaMTeNTs/kgjGGQxYaCFR7s3vesbVAqjsyv0OBBPU/SqNJhz0AiPIWSrtNc/BbLxGTRobssszAJo+xDQIPyk2wbm2Hqn697H5PmDTvgqaUT9lpwLSsFRGZYZmmXo/1dn3NbBo9R5kIF/pgV3VlIrulKV/tSSUprIKe0bvN2G9iX45n0BN1a+VZ67vWd0kUnEC8xXz5Jgy7S0xx02mJSFOeBTJbeoGEvuqcOcb/yjFhrLTCmClKeFIFzzFZTFAfsGOrYngcdNPukP2Fs+1eVgEwu3+Hl3YRKrkcudza+E8/exK8Xj1LLKbQHy9xMlpi7FBYwxrmVp+hw9P21Mwll2nCBb2JlBDI4B78gI5ZleCEub9l5KzlSzH38T7NEMZfeE1iI05m3daSERTQCP9sQk3dcVHiuRtbHJUvjbGOOqY7OeJzCFc5HLFr3+xGUghBBLbkWZ3+qjJIQyFYfpFrdxQciUCORPtYfuFTpTCDzduwmRvm+Q5osXtqjn/vovUgEphkUS4NZ5/OJkI9H0dV9lOLfUEJ5w4jTB4CD01t5vsMFlOHhon3sA2CoJy09DrCbZXjZwhUSvZvEwXzrMfQD4biZ6pPvE8uMU3nWRvr20=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2fb988-79eb-4205-63bd-08db60d41728
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 06:07:04.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tu5RBThrQ+LHwle7L3I/k59bAbPvY63CUA315nZlWpoepCexnkg5swEehx7Zvl38XA5OaeBWhlnnnsOwIh76cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4409
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_03,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300049
X-Proofpoint-GUID: 0dpm0EYCz9EzK3vSyJu1q1bpkKmHVd_k
X-Proofpoint-ORIG-GUID: 0dpm0EYCz9EzK3vSyJu1q1bpkKmHVd_k
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/5/23 09:45, Qu Wenruo wrote:
> In function end_bio_extent_readpage() we call
> endio_readpage_release_extent() to unlock the extent io tree.
> 
> However we pass PageUptodate(page) as @uptodate parameter for it, while
> for previous end_page_read() call, we use a dedicated @uptodate local
> variable.
> 
> This is not a big deal, as even for subpage cases, either the bio only
> covers part of the page, then the @uptodate is always false, and the
> subpage ranges can still be merged.
> 
> But for the sake of consistency, always use @uptodate variable when
> possible.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

LGTM
Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/extent_io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9afdcf0c70dd..2d228cc8b401 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -745,7 +745,7 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
>   		/* Update page status and unlock. */
>   		end_page_read(page, uptodate, start, len);
>   		endio_readpage_release_extent(&processed, BTRFS_I(inode),
> -					      start, end, PageUptodate(page));
> +					      start, end, uptodate);
>   
>   		ASSERT(bio_offset + len > bio_offset);
>   		bio_offset += len;

