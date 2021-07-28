Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74233D8723
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 07:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhG1F0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 01:26:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11110 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229752AbhG1FZ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 01:25:59 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16S5CYFV007988;
        Wed, 28 Jul 2021 05:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nyKpJzJ9DyN/NGWjVgqgdvSk67we4P31c+a3Gqw8d2s=;
 b=WKNTBQ9outMREgjmunlxPgrDKBxoa5INQYR4ftmqbLIF5LTu6Z9QkWiv6wjPPjIo4U79
 J4BwtYHCzBEDhk/MLPpQR2miIm996Yfw9cbKwpCyflztXDsn2JVGKGILpiUbU1S4rIud
 JAzLy6W5cGWGYv24/AvT/jVTlh0yQZstrTmiNpfvWIi8+1XG19E0s1LE4Gb047z6eGgc
 YGBH11vokS1ubw0Y2CLViJhj3bJ+U0rxbxrHLSSvih9lLivY1FXgGztGsMgMry2+IcEQ
 cg1PW4+aJOh/ejcUttDO7DIGhIfponodYFObCEO6ZZnDFSvyx76QNevepfgep5fmxxAb 5Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nyKpJzJ9DyN/NGWjVgqgdvSk67we4P31c+a3Gqw8d2s=;
 b=IC+tHnv71JKuzpdT4Ppcn3bpwLA4MxhBiUIMj+l3WBB3b0TIWUR4KbU01tNeSkjgX7YO
 +48Q4wtaR/13fXCMgrTwf/bz9a+upsw2jp9DV0faGNSCiamkwBT7/Caao+MXs1ioDiXl
 TZU80I3SPBLsH3Fk6JTZ4kIAZi6Q5o+DVWYsBi5wpJR7KHu0fBjtNFY/LBGBSXprCLr1
 H5W7zNoKK64LE0JqN3YlEeaZFJeI/OJ+8Z1jo6pqQuIGirgAp3I5KGQ+R8ng+p1i+nkw
 EDEJ59qFZafsukCCferIzlj/mUsWGF11IRqKvNuEXYxQ2fNyTatdt/9ahqCGSzNboSQ9 Yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2353bffx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 05:25:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16S5PXBa146504;
        Wed, 28 Jul 2021 05:25:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3020.oracle.com with ESMTP id 3a2349fgrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 05:25:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Io9O0iGsP8gaIiMrPWoMqlJbGOUbLs2Fd+YFrD8aPr3A6GYcsRjrKHJr8RICRGMtXVKbYP9lsSr1q9Dwdqe+T3qAjBNGQC4NYHCOIOiqY7ariEAD+f1n4BR1e/e6B5Zzwwgk4S2Rqf5bEcTS420BJI4xIpwbv5QCfovlVbg6Mi45RPI9Jiel49ic+5tScGlYk4qXHRXRWfw2XswnKrVgmI8GeqO8i9fCOuaYpi4Fc8daGrvcSjVueKY7m+9hN+TABwUUbY1CsLpMt2JNvifCkRzstjdm3achsZRrR+W/UCamA9OGr+wlFVhzDB+Nv1miigAKo5y3n7QuJes341H1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyKpJzJ9DyN/NGWjVgqgdvSk67we4P31c+a3Gqw8d2s=;
 b=SsEwYkDewMZXMZVGGib6LXLg2EFFmTK+rFGWSF62GxJag8VjPYpfRTa+1RN9neaMphUhzc0Tgf1cEHlKiIaGeiWVb0a2qWhiQGix5bO9AQlNXoocIhvVoF23w7FrYcSCf0aLbnOQD9Nz9cht/UnqiXcHpbNDLmOyXZ9i0XFlRMh8KBnx52sg7Z3bge4yJqYR8pS/84ETTnsg1s1x2sp+seqX5/fbGasVZ7IOQku8bX+DIXwnXp9kqu5hZSdvgaW/qyrOBMBwPhlMwGCrR5DKZun5ZO9c47Jue+Rgl45yZ2gWteCgCXYVH1PxCco8iPTBffnkWMdQmi7YvhBBLdUOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyKpJzJ9DyN/NGWjVgqgdvSk67we4P31c+a3Gqw8d2s=;
 b=lFssFRMfRhXbVHbvU50Pf4JJLU767e3O9vaLROHKuiiw0zsIfl1N+brsjFzL6ChuCn1X+6y+3FxuyvCUIJOB10JFBfew+VVn4g8zSHkABJm4o/WGscEV6xHK8FyqeWt6YWUkq8mh66TbD2lp5pnHj19/h0Le59ZplKG7fg2nl/g=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2770.namprd10.prod.outlook.com (2603:10b6:208:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Wed, 28 Jul
 2021 05:25:42 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 05:25:41 +0000
Subject: Re: [PATCH 1/7] btrfs: Allocate walk_control on stack
From:   Anand Jain <anand.jain@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1627418762.git.rgoldwyn@suse.com>
 <381dc8c84c07b4eecc8b5de6686d79ad5c60ae58.1627418762.git.rgoldwyn@suse.com>
 <1700290b-4735-67aa-c98d-3427689e8774@oracle.com>
Message-ID: <5e900ce5-c5b2-d7b6-e22f-b1606e7e1b2c@oracle.com>
Date:   Wed, 28 Jul 2021 13:25:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <1700290b-4735-67aa-c98d-3427689e8774@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.4 via Frontend Transport; Wed, 28 Jul 2021 05:25:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f511e30-29b3-4496-6b00-08d95188246b
X-MS-TrafficTypeDiagnostic: BL0PR10MB2770:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2770140D7D9D677EBD1BE1C1E5EA9@BL0PR10MB2770.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nb88jk8OKW5tSEbceG03VCHT17jS4PyZ9U05O3MORGD6gzUHU4lymvhvN42rZcMKqSIMQVYEUjZrk4G5NkZ3BsiUBglzdsywJOUchB1QVH2NqjR8HxAX8g13NSyIc9AjaHDJyay5og5cUDV3WUG79gE8IVjEEj9yNusKRInTtC++abaa0FVKCFF7E2Eep5mFBhLcMDMOJPuNAh2sBW87ghybMLSj5ect1My3svnWpWbVd+7NQjFjoeAjpsLhdC7LJh54F4ZDy/wQuaGMAnImXdE2aEkVDmydCVAeCqq4G2bZw9mM2vkbfIepjehdNp3nCSmZxhoUSpCSOVtRJKBtcitDYlC5MqqxoPocw5iWV77REd4Odk6YFudLlVuphmdFuDqoyo41Ot5T2RFtllgSHYasHjMsrafbbQoCmUBmxmwo4mUqw9a/mlnidQPlzSHACGpNd+LxuKgjFzwcF8qe7oDDtjXAssVlUQZDsE2SVkDintWyC0zw7tLvNeRnkrZ80aMEatxmCFNd8k7Bg+CWTmWqyOFdqQLZeZJ2+tFTQEzDfKwHP9nPFULhqqkvQMWqS0B4VMnqmy76hBlYIUSKQ5G8+ZeZqd4qGIL5tTh4y/b+qOolP/mlIg+u/piBWP/fo9H1yR7DkkDyyuOeLyuXaVnh7hAaQeuZWT3OhMGij7Z/IAqn4Zx6wvgyAtf4uNIBvht7BsD3v2+NEBoV1+B5ZAtSeloWX5jhK80O+wTLJN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(136003)(346002)(396003)(86362001)(5660300002)(38100700002)(6666004)(83380400001)(44832011)(26005)(66946007)(2906002)(8676002)(4326008)(36756003)(186003)(66556008)(4744005)(66476007)(6486002)(31686004)(478600001)(956004)(316002)(8936002)(2616005)(16576012)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUVHT09uUnpLeUJrbGJ2Z2Qxc0NHV3pyUFdWQi9TNWpERkRWR1hwMXMrOUdI?=
 =?utf-8?B?WXJiVms2cUtscHRGSnhIaEMveGhvQXREMzJVUUJ1eDRJdlBibkltaVFYVTNB?=
 =?utf-8?B?NWJhQ0FDa0QyYXRuSjlFNWUzZHdpWDU1MEpYNjc1YzlUWHFEdjJ6blplaHBx?=
 =?utf-8?B?L3hybVV2RTJMdDM5elRobkJVbVBTTE9sZXY4NXptOXc4VVhCQXo2c1ZYcVVw?=
 =?utf-8?B?OFp0SzFEQ1BJc2lQY2J6eEhoOFc1d0kxRW42MXFiQTRaQ3FBWjZiVXREMG5Q?=
 =?utf-8?B?Ymd6RXJCTjFvNUNKNWZrcWdvRmJtWERhcThYUDlsUGt5b0pFQ1hnZENZZ1lk?=
 =?utf-8?B?UEQ1Yk45dUFKZ3c2ZE5HOW5QbElxQTVEL2x6T2w2YUdvRW9nZ2FwcTQxbXZq?=
 =?utf-8?B?Y3JTdG1FcExCNkhkeERXR3RLM0ZvYm1vT0t6Q1dTS3FyVHVXU2M1NjVIUDlO?=
 =?utf-8?B?RnpzaWRmRWZITDVBMGlHNE92cjc0OHF0MUFLK25BMzRtWC92TExIY1liNlBQ?=
 =?utf-8?B?REFEYUdyY3NpT1E0cWwwdVdsUUQxZ2pweDBBSmNIYU5Jc0FiNUZURmF1c3Jv?=
 =?utf-8?B?b3ZZdldWeHdac2grdytSRk9DY09aa2FHNTJvekpENFdzbUtmWUVmT1g4WTNE?=
 =?utf-8?B?ZHpYRUViYkJoUWJaTWRqYURFcmV5dVBva2pJMlUzZGpIZThyYUpqd1c4czl6?=
 =?utf-8?B?Q0FjcDJQQUpxTXJCN1lQbDJVU01QOGQyVHNyaWs5dTlscGdhYUxNMm5NSGJJ?=
 =?utf-8?B?eVdSSkh4SUJqRUdjUWg3V2lhYUpQT25MRFNFdEExRW9xWTROMXdqTU8xQ3Vl?=
 =?utf-8?B?OFU3NncwdytqdkU1enErNzljZ3h5N0hjeTVFeVJLTW1hVFlIRjBQcVBhY2xa?=
 =?utf-8?B?QXJ6MkdFeHZtN051V3BTV2IvOFM0VkxZUzRhVTl1MXBCUXVsZmplNDNadlZi?=
 =?utf-8?B?bmU0cmVGRVd5MFJtZnZYL1o0ajllMkRkMzVIaWx1UjdGbm9yN0w5ekdNYlE0?=
 =?utf-8?B?S3NaVlBHZ0dnbURWVytyQndPNGo4bGlNQTQrdnVIenk5L1IxNVdMR3dETWxS?=
 =?utf-8?B?VjhLcEYySHlHMTBoN3BGMjl4M1orbHlzRGNqQktyb3QwYWJ0a0hzTWlwZXRl?=
 =?utf-8?B?K2NpOWJEZVNpTytBakxRS2d4TXdqRE9nVFlOQmdQVXpVZ2ZVemdnbUM5cGF5?=
 =?utf-8?B?VisrOXpNRlErTDlUdDVuMHRvOE5NSUlXUFdSUWRpM2FRSWM5TVdkLzJMVlhI?=
 =?utf-8?B?ZDhYdlBaSVRlYzFXTm5YdHB6TkhKbUZ2R1dCQTQ4MGVrSkJHY3h5cmIxeVBk?=
 =?utf-8?B?ci91VVI4Zi9xME0vNXlzV2ozM3p6U2FHbmpIMmgycGlBUFF1WG5JNUZOZEhX?=
 =?utf-8?B?QzlXRitsMmIxc2JuNGN4MzI4QzNjUjJ6VXdoSEMwOXFSbUo4a0JOZnNJMnN5?=
 =?utf-8?B?V3pLNTVMVi82ek1iZHdQL1JVeUxoRVVzQmNvQ0J4ekRSZU44T09yMjVWNGMy?=
 =?utf-8?B?eHFKTHE3MWY2OWd1VHlJRnd6c0txNUtzSmN3blhnRkJSTWU2VnpRcUNUSWpu?=
 =?utf-8?B?ZjBwSGloZlRlV0JKWHNmSGJzam5Hd3g0YUNKbGVsdkdEbHFCZCtpNzJHdFBJ?=
 =?utf-8?B?L3FXZC83QjNwU092VGkxS01qcENKcTdSYkxzTTRzRDJqSkVQWWQzSTNNa3Qw?=
 =?utf-8?B?ajZpalZXMXBiNWIxdXVTYmsvZ2QvclorWDlwTVV2TW9BbGhrYzZXSkJIcjQ5?=
 =?utf-8?Q?jQK/ip11ruZhmX6klsw5PcVAXrFZEQV482IOHgV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f511e30-29b3-4496-6b00-08d95188246b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 05:25:41.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrjB7+pUqRZl/g5ZHPETflCf+ReAGPgrqz9i7FU6mLDSrlUZRAuLUs6B8XKEIH60ORUduoOvdjMo0ZKtDTebug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2770
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280030
X-Proofpoint-GUID: dqS9x_LkkN-BcCZBAPlD0TCxG8qL_jS_
X-Proofpoint-ORIG-GUID: dqS9x_LkkN-BcCZBAPlD0TCxG8qL_jS_
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Nit:

>> @@ -5537,12 +5530,10 @@ int btrfs_drop_snapshot(struct btrfs_root 
>> *root, int update_ref, int for_reloc)
>>           path->nodes[level] = btrfs_lock_root_node(root);
>>           path->slots[level] = 0;
>>           path->locks[level] = BTRFS_WRITE_LOCK;
>> -        memset(&wc->update_progress, 0,
>> -               sizeof(wc->update_progress));
>>       } else {
>>           btrfs_disk_key_to_cpu(&key, &root_item->drop_progress);
>> -        memcpy(&wc->update_progress, &key,
>> -               sizeof(wc->update_progress));


>> +        memcpy(&wc.update_progress, &key,
>> +               sizeof(wc.update_progress));


  Now, this can fit in one line.
  No need to resend. David may fix it.
