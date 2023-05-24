Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ACF70F4D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 13:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjEXLHd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 07:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjEXLH0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 07:07:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C1AA3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 04:07:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OAsK6R020224;
        Wed, 24 May 2023 11:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fy5xp6H5Ed3t9SrddIdPNY5+0qzjxlX58FjQkHSHwhM=;
 b=UcBAwhcCrlB4v2QwPZmA3CuQMd5B4+9sLGRXCkq6/1ARYE31qTAWJgpB5sn++egBRFuS
 qEkBlZMlvUNborSPHDE2J+/2MeiCYsy7/YclgyVsL9I9tFVnAIu40Xxof0ClvElXOjl/
 WudnuvHUeP9vSq28u/yH4IHF9v30YOF4OY0WFTEZDVlvW9yfnCXHlm+qgyE/c+oMI21l
 Id1ToGFQViwIciPpZ1dZjGFsvmBeFX85nI4Mp8aVn+u5rgHEw0WpyiYMXPhIJeGxVM6u
 yCJhSzvTYku4kBhBTPTeKB+iwhsH7KAFmKsLBMdSQlsHJPvxQY2Ij3USw5Co0JjPWYz4 hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsh7yg18e-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 11:07:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OAivjJ027104;
        Wed, 24 May 2023 11:01:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2etn7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 11:01:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYHwJmG+LfNPsSrIVpy/pJ0uUTdbbqQQh3fNkMy+L6uEC/FaKfPckgHSllBxCwVCYZVoKJGNDqDHWJ6QqZAo890RxYWk6KpqAIVUlDWSAMhh9Ps+WY5noIIdLKsnDs53Y9sXLgAsYVRSwmjgrPv1QAqXv31AugNdqoK2B1k902osdb4Mn9W+Yu+zEmePmMU6Q2wPw4dWbqrjaAonJ5CztELqCyDcTarxJ+g5WOU9qi/JCSyIDotoIKK9lVOvJDj3uvSKYGRCaklFs98bOAtDF9OO+26KwK8iMH7U54pSInTxSAhSZAZlydx76dL/TB1oKkYGl9YlDB9aLaOUFwaWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy5xp6H5Ed3t9SrddIdPNY5+0qzjxlX58FjQkHSHwhM=;
 b=OfJ9DXp9FPzuFS92ptvuitk0deeVf2Z1RUHfknTgZgR1CCpYF+JlR7kSiVF+wdNcpXRE2VNdwHoAGLLGteMnFWeF9S4dUbuEI3LieSzCJ9eaFH6H9UCDHk2yhQkwX9Prp3XnmOJGC1OwfqSAIdOZ+Bl//DLz8S+n9c5kHzXiJyKJtN4kk7rB/vTah2d9mSLU3e1CVQhIBOJiAzQ16EEnWyLhQ4JTLAhr92msNwg56iYuhnGw9xku0/xE7Bvc2qxjJBIgFdQ+sDrWzqgq57xmVSPnL5NI0KQU7vLwPzxFeE4HVDxNbKhBeou3QTXrag7sD2zDsgaEv66xVAH8TIVQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy5xp6H5Ed3t9SrddIdPNY5+0qzjxlX58FjQkHSHwhM=;
 b=gnu7PoYI4nKr9tlVm9vavCTSLgpFc46DvhDS0ipdrC/y73m+vgePH5MxpPttFGvuwVmdlIHgX8Jg6hokCoGtJMc34okzTwrXM8+AYC2hLorCikZx2lG7KEeDsID6zpGdFyVkWXjtwCKjbVNsGOl2+FxBTELNkj7GI/Kbxhf4EQo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7600.namprd10.prod.outlook.com (2603:10b6:a03:543::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 11:01:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 11:01:01 +0000
Message-ID: <f1b3e990-1348-402e-ccb5-e0ae14dd0421@oracle.com>
Date:   Wed, 24 May 2023 19:00:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/9] btrfs: reduce struct btrfs_fs_devices size relocate
 fsid_change
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1684826246.git.anand.jain@oracle.com>
 <844fa765ab173b8dd24549f145534f41d412d3ea.1684826247.git.anand.jain@oracle.com>
 <ZGzpgG8o5pv5+hNL@infradead.org> <20230523205917.GC32559@twin.jikos.cz>
 <ZG2nEuHvkGJ+qNhD@infradead.org>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ZG2nEuHvkGJ+qNhD@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 656693d9-ae02-4ec8-97dd-08db5c46296a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7nh72IjNoEXw9yjsQHlsxnLKVff5RgWnbkzC9nfsevGY4EJBX2UaKthJOCdL6s3vhOD+NFSoZpeKa04bJwyEHOm8OB/7Dey+7vxY++dniUt3lSgr54LOE2AJJVr74sOHYwwnIb1cv2ZQRhfXQsGwUnwK5XmS1wHLAQaqkIb5k8q2Ycs2P0wavEUw8BExQUqdCqtS/PK2gWxaXjvUSubZUHO1y7EQIyihMeOMsJ2PNdHWFB1xSRkIxM2UTFgsrI4GhvWUZy+H8M41fqZv/I0JvmPUZHShggDBnSv0rhGRXyxco6aSHF58fl0YG4s6eIx0ohNLQWw+mGuoT20rGMmHGL0Yy+ULZLsATD51DukQ8aSfCBtPsqIIYOuaiF5ag7lmY43r5Y2dYVNbraac6k8wazigYpdkD4RTOs+xxJFI5pdT7/i4KqbfsnmIFlRnGZZ4UBZOyqlW1YYPlyK3nlMdDaa3D1kwgTXBDaoqHGZlvUk+4DzRaEX8dWfadjOijkOMDfRkLwe5/FEJGCIsnaNQOKT2nQJOyfvH6R2iJFuiXYCvbQjQsHBHvjs23+dGP/Sjh7qZJhTGWYY1GwmJq3lT1c1CyTEHqtGNVDlD9mEQzDi7ek39sepT+URgABCQTR2OqiYGVsRpaS48Pvfhpt5yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(110136005)(4326008)(31686004)(66556008)(66476007)(66946007)(478600001)(86362001)(31696002)(6486002)(6666004)(41300700001)(316002)(8936002)(5660300002)(8676002)(83380400001)(44832011)(6506007)(38100700002)(26005)(186003)(53546011)(6512007)(2906002)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkdyb0t1S3RnVERsRWlSNHVRMlA0YjRhS0s0a0dtSkcxYUltRjBUUXlYT29R?=
 =?utf-8?B?Z2s0djJnVGZwSWFDZ1hYRVVTUmNFRm4yT1dUUnlaeitHdGRjTmpxMWhXbzlU?=
 =?utf-8?B?THZ4VFhXSmsvZXNtUG1HbWJpZkpqTUlzS1BLNm9tMUhna1RwTlRFQURSZEFP?=
 =?utf-8?B?UEZPNkZrR2FPQUNVUUpLTDFSaGVOU0hncGJyMWR1Skx2d3oyVW8yamZsUXdF?=
 =?utf-8?B?NzlMS01mYkhmcnVMR21oTnVwU05Yb0FUcE91bzZWdWJnelJKclUvaW9aVWx0?=
 =?utf-8?B?RUlDeFVPUk51UFhmNk5EcmRCTzV3dUp0NkVjLytsWmpqSTJFMVdMbVNPeEQx?=
 =?utf-8?B?ZVhmRDVuZ0x0QlFOK1luVDhkcmwzdTIwRyt1U3Q1T1MvQ08vRVNDZWtONHIv?=
 =?utf-8?B?YnBLVk5TbTFxTVBGMjR6WTUvMU1tS2dkZTRCZEU0UWFrbmt6QlZRa0pZZWx0?=
 =?utf-8?B?b3NSVXdWbHB6U2ZaOWUxbzBGRklOL29BaFIrb0ozSHJlbHdVRlRrdkZ0THJy?=
 =?utf-8?B?S0ZPQjdSeHhsSk1SdHNXbG5KWWtQNEkvbCtwT3kxUURJN3BpSmg5KzZpOVQv?=
 =?utf-8?B?c2NoV0ZHLzhIS1VVbEZzS0FKS1hCT0lCdmJjdEMvK2ZOV1hsTERNTVA3eU8r?=
 =?utf-8?B?NmtmSnpPaHEzajluWkVhVEVLQnNsZzdGUzNkelFXTTVVZzhkMUJCOEYvSjJs?=
 =?utf-8?B?a1IvOHdjbU9zaE1saWhNUFl0WVlEUTlDUjJKdzVhdGkzMXBoRnJuWUN4N2tl?=
 =?utf-8?B?c3dtbGQ2cUVjQVFuYzFyMWZKQ0IzeUFPMFVsMTE5bG4xdktrVlViWGNQaGFy?=
 =?utf-8?B?UTlmenY3U3FIZmpsZHh1OUtwaXd3eGVnUXNHNnhXSktadFdKekxTZ2hTbDJw?=
 =?utf-8?B?Y1ljTWRCTVgxY3VwN0x4R096cWN3d2VzMEZseGt1ZXVxMGY3alpmLzlaanQw?=
 =?utf-8?B?L1V3RHR3eVhXNUgvQWEvY0JxakJIRG42aHBsdVJBS3gxTTBtWmtGRFhYcW95?=
 =?utf-8?B?cDl3WGZuNWdnYmNtcWdHQzBQU21xU2w1QmsrMkFPRFdRNDBWa0NuR3lhU3Vh?=
 =?utf-8?B?bThrNm5hZU5ydDU3VVlFbzhrclowSnN6SU9VMHBlNTlOMUxMZWU0ZnZ6eXhE?=
 =?utf-8?B?SXJ3T0lKbDZxbnN0SE1oSzdvNmhLTVhZdWlYMFpjYzQ5b1k1cHViaTNaQk9K?=
 =?utf-8?B?NnRvVDRMMHhyUVk1RCttdTI3cjhBalcxcy8vZzFqYTlySXNOVk02Y3Z5cVp6?=
 =?utf-8?B?TmdKY0J6SXlnTnlYVFA3K3lodWl6cEQzbG1HTmRGcWg5cGtTM2h5N0dMTVhn?=
 =?utf-8?B?L1drZU9qOExsUW1Ld2JWZ0IvWEx2OE5LMDhWbU8yaUw2TFVvZnM2ZlJYODNU?=
 =?utf-8?B?bXRKTkV6amhlNVdPOHBkN3JNN3ZjckhmN21QVVp3T1JKMmZ1dHcvQnRFYkpo?=
 =?utf-8?B?UUJmbHMvejBYMloyNk54VlFLSTRadXg2c2xzZ3d2WHBSU1BSNldvbGpMTlpQ?=
 =?utf-8?B?dTRHcW5abVpVR252czZSYUdaUmxLOFN3VjJPSDZYeGxaSGVFNk4wSkxqU3Qy?=
 =?utf-8?B?Y295Z3pFT1Jrdkt2Z0Y3V3FnbE5tdm83Vzk5aC9ScFlCdnpYTHV1eFJvQ24z?=
 =?utf-8?B?b2l6ZTZFSjhLV1NiYVFreVVlWWtpck5mVVlmVHRyTWRZaHRuaWNzSHNzSHhH?=
 =?utf-8?B?Q2xEaGFLc012cXJRMXhUMHNJb3hKSUhhZDhZdHVSeG9VVkhxWHo3Zm16Z1ps?=
 =?utf-8?B?amNrcW81aHRrRWp3LzJIaUJVdW5rNGREVTAzOEVGZVNBZFUrQjNFUGFvRkEr?=
 =?utf-8?B?YzlLTEx0akhGbGF4dEIrK3JjbDh4eC81ZGJkRHRiUHAxZnhtb2o4bXJFYUR3?=
 =?utf-8?B?ZWE3eVlDdzBmeU1aMmUyV2l5SFU4V3RFWk81MjZYeHYzNzhlRS9yQldtd2d1?=
 =?utf-8?B?ekVXMmhJd2krYTdxRGszOFpFZUxMWkhYQUlyZUFKS0tWSzlwbW5CZUpqazZh?=
 =?utf-8?B?L2xzNE96TVJuTGYzVTFvdnlqRFpRbTNtVTVWTTlWa0pJb2w0V3Jua2YzZTBr?=
 =?utf-8?B?em5YQ1ZtdnQ1WW5BVmhnTWRyRklCakcxM0JFRVFWek9oUDI3R2tCakJhWFpj?=
 =?utf-8?Q?p6q2G+0exJtiTqM9ELvmwebvN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AeCdxha9/zuShA5mTHdfnIyqDOr9Omd91rNni3mSaIolNiV5+A8JFzdkoLe4LllGEz8eM/R0XPZYkcq8CGYOMrfgrdBk+T7JJ/L84+hiwPWoLXkjvt3azXAVrYYQMH87PN7dQDEei/8ihRJp7eW5wccaMvKs59qozvHVaB14/4Gx/AEVgkhjEjuoVOpeIKZMrv0UZz04+RYKRbogP93F0VVhgHSPhp4UvMmy3m1iJe50lnaBb9KpyMFd3WnmHeH6To7IgXdGumUJDKMB5BzfYjcJiiRL9z5pNFU9Jwxm+L5+RcsmqeY0z0ovwB6mWN4Px0A/3kSG0cacjPpj/PTSqhXfVrvpp7ZJ7q85aikmwaxj5gXkQyk3TOJJN7HneF+tF7aGdfOWiLbcurxv6hOqmrqOHr94z/sKs946BYtAsAE/LO4ZEUy8r4cLUVVFYWi/vRQIbH++QHWDvJEVCTb+huAuojn9viRseUBolYnSBgjRKwWM7Jzm1O7mYjsUcl8MfTixRkECbMDGBASn+tltBMhzDxWFH6PCSSL3EpJcDKcyoqO0WnAfP8MFbYSABb8iO8SQ1RBhVOUA3OC/Bs+3kL4q+5py+b5LoXS5DNC/wVi6JddBvF0JAr2//fadzZe9vbbgIFZgO1VUD1VU/aLaEpCHi10o3igyi7xY+PK51kkJZUhxP0J5uITmgxJA4+IGPcp1XtbepPkZJk+vUE6uSz8Pb1mGHQ9jrUO6V2FZsbfpiysQhWXaOgUSarb+VumsCcLQP5MGamWJZsNYVwyG3OuP0gJ/HX++BVDJEK76nt4V5XWj1jfDJXHTIFT+tgZq
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656693d9-ae02-4ec8-97dd-08db5c46296a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 11:01:01.8908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsCFDD8cpOjtKl8aY3mAZ2acKpOWXcNf6GoHAKK0kwuuChcQl7m4iGUA3ZTjdqxAOsFZO0qdMrcgXdt6F2s62g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_07,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=975 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240093
X-Proofpoint-GUID: BhuMsX_bCR-dSA-J0UXLPvy8hJn6enaf
X-Proofpoint-ORIG-GUID: BhuMsX_bCR-dSA-J0UXLPvy8hJn6enaf
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/05/2023 13:56, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 10:59:17PM +0200, David Sterba wrote:
>> On Tue, May 23, 2023 at 09:27:44AM -0700, Christoph Hellwig wrote:
>>> On Tue, May 23, 2023 at 06:03:15PM +0800, Anand Jain wrote:
>>>> By relocating the bool fsid_change near other bool declarations in the
>>>> struct btrfs_fs_devices, approximately 6 bytes is saved.
>>>>
>>>>     before: 512 bytes
>>>>     after: 496 bytes
>>>>
>>>> Furthermore, adding comments.
>>>
>>> I like the better backing.  But what looks access to fsid_change
>>> and the other bools?  For sub-word members atomicy guarantees are
>>> very limited, so they'd better all use the same lock.
>>
>> Do you have an example where the reordered structure would become
>> problematic? The fs_devices locking is non-standard, the structures are
>> accessed from module context or from filesystem context. There's the
>> uuid_mutex as a big lock for fs_devices, and for access of the
>> individual devices is device_list_mutex.
> 
> No, I'm mostly asking for Anand to document the rationale why this
> is fine.  If there is an issue, it's probably pre-existing.

Expanding on David's comment, these bool variables are not modified
after the fs is mounted. However, here is a known bug - %discardable
and %rotating aren't updated after device replace/add/remove.

