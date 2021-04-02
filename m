Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DE935251E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Apr 2021 03:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhDBB2P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 21:28:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48656 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhDBB2O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Apr 2021 21:28:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1321OuC0023221;
        Fri, 2 Apr 2021 01:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZGfu63O64li9vvzxDllQxpwIq53Pf5+nBYghKIeQMJ0=;
 b=r9ycaNj6soYDSohhUEOPtqVzJGjhG+tTnrh/tdP30JgqWAdOBRWDJase8PAhqrqGBp0K
 sifcFVdVXM83Drfvudvqp9jK3s3iCI3cw3f5+NPKx6WIeRJDKfgrEaAedorSKfGX6hpf
 yFSYMw2DJQwBkNcuWHS3JhHZzEgoqbkh4gi6gNEWgL4HhaEobE6jFpcRXGLGc/ZlHhw9
 BA6dAh2eI0IJOek5zYEM6tLB5cVG1H0Z2CfbrazkmvHSwqyWKLNPKYQaMHSXUxE1+x7I
 p8ORSe19gE4BcGmp//6Csl22o4qAs6Vd/B6a09mWyzUF0lL0fs+eA3TDWyyoQffWDboW iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37n2a03hua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 01:28:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1321PcAJ135615;
        Fri, 2 Apr 2021 01:28:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 37n2athpsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 01:28:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dz6QuIiab2HVGOHgToH6Ay/uEOG8qNiR+Ll1e4ghtZgcaKXTXsPCAKnUAGReAHk7eQ40GVLwGQ3jvoXJWNxt2s9eezXepgW033CWOUriD5xSloF2yomWPKmF/GMzwT+Bexzyq9+alu51OSE1Qx9l1YG+9eRTbiG+0yD0PlaVAW07tYE9psz+sIKhViqDjax7K/wcFBX086v1Seqy51sKxNP77Z3IPL0yV4y7dRShhZCWMcCCfsQBk6A5QrguaO0C0pedMaEg4uEssYUvMhuPq9Lrm6bhOcqU2qxzjtk6afm+5csiUICxAKB0UgUf+X5t9fuYFTLQagoL/kIEa/D6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGfu63O64li9vvzxDllQxpwIq53Pf5+nBYghKIeQMJ0=;
 b=MB/mGC69F1llE8o2A5Oxjp74R3S1ORviE0cPoqaalzsjZWc1J6aMMh3IOaN1kD0Ix6sTzLRCnzBedpPFHcFUO2MYDQA7GCg/5pqG1y+5FR4vIv5ikF/HKxQEukmbBFUnScnjUw1sAPFHfERoAc/pcTZyrI2QnjG+n+TI+b+5Fwqqi71C5YOQAHkqYEbfSU67ZXnXBaweGql97oeCeMfT4nNDQ17vPbeSzJdOTCZpm2d4zOR90nUUtKHjiBxzMfjevsVu+ki8pTxJBHoKsiGsLwaRVVfxZrFJNNxhZDRPVv1hu/qwzvMFk7kuTklVlao1xvlITIiCwj6IkAvqu2Rqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGfu63O64li9vvzxDllQxpwIq53Pf5+nBYghKIeQMJ0=;
 b=fVKauG8SGNMj4XNLshaHemqMuSdHErP1AgpCaGsZUguq7pZcK9lTOHnj3kjR6xSjs1y3YPJTYYq9Isr5zHqSIaw9UMuo84m9l6vFlanzAW0rHE1yuA/l1XpF5C2AuxxKDRRoPCBlmJO6WXV4SOaN3DbmdTAFfiQ42Pc5rW452FU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 01:28:04 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3977.033; Fri, 2 Apr 2021
 01:28:04 +0000
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210329185338.GV7604@twin.jikos.cz>
 <dc64f94d-52ad-9c36-534e-5a84bf449448@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4832f3ad-e48e-ce5d-36f8-5c6e132eaa3f@oracle.com>
Date:   Fri, 2 Apr 2021 09:27:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <dc64f94d-52ad-9c36-534e-5a84bf449448@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2406:3003:2006:2288:d47a:f48:c77a:6201]
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:d47a:f48:c77a:6201] (2406:3003:2006:2288:d47a:f48:c77a:6201) by SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 01:28:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6002b87-afe2-4f04-a9ac-08d8f5768fd8
X-MS-TrafficTypeDiagnostic: BLAPR10MB5171:
X-Microsoft-Antispam-PRVS: <BLAPR10MB517121139FA45D4137E4E85FE57A9@BLAPR10MB5171.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBE7tRN3C1rvNvAQAumSnuLlA5nP94osmAfIC5wp5pUTDvOAXloRmG4jt91ZStSpQcF3bq+bk1eSLSdoyejTICdEVBbbBDo4kXqy9niVO3uVtzO5BGYvsq8tMb285Ls2f3L6N73TFYFgn9h7QN2pPkMSEWGq7gzA5q8qUHVeu4/VPUod2EVCPs3/Jzq4P1a9LBi6vbjF9x9PbuRS0UwPpHkXmGFqk21tbqE3iyJn3jvMUM6izYhj7LyqMlFuQGx49H4NJlm8gxSa2KXWDzpfGKMrh2UUhFjqwWnFkai92lmgGZjxpJ9vcjaE8XYeI5EDjNKTfd05Ko9zkEH1FT8ZXs+qHzrfH7ug8u11xLnZB8/QPD1x1+Vs4gfl/FsErThdsqWOWOAY3Vi2uNRKfgu5oqrkeiQC9kCsIGA4KCVx1a8DSkt9Pv3K2QPb9Lg6WfNRMgyK5ZME2b3ptYm21bm4MSD7BdWpufp7XoZZiePRDMepoZf/VLCmSadJB7wbwpEMopjNa67ZAnGiT5ACjpOwEbxj+TWZictAVCaf74kdXcCV8mCBggUS4Jg+PU7sGbz3Q9TdZeMNZY79a/+3rwhlf1RxRfIgDYtDXS8kGFYco7f2+vgtBZAJo60NCXX0z16ySZL7RYysQR32aPBGrtJXGu/FF6GhHziI+7dXc2wWfdtexJxHraR6VxsultngggAzJLn/6WnAUNTW96vVHnGmHp6I4O4copXp5Up9lndeXns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(346002)(366004)(376002)(186003)(16526019)(5660300002)(2906002)(44832011)(53546011)(66556008)(38100700001)(8936002)(6486002)(316002)(8676002)(478600001)(31696002)(2616005)(36756003)(66476007)(31686004)(110136005)(6666004)(66946007)(83380400001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a3RQdml0aE9Ia0xlcXFmemdXUzBpTzNNa3NHeUJwLzhWVjFIK013VUt1ZDQx?=
 =?utf-8?B?NTBFbkgzOU5LaWswZWkwaUt4SlNHL21JRU9oaDFmUThzc3pmTDNzTHlkVDRV?=
 =?utf-8?B?SUIxZnVMZW94YWovdTZ3L21PK0l6RGZHVUVaU1U5M3dPanY5V1lMY2JCY1hN?=
 =?utf-8?B?bDhaYUV4MlAwRGZ6b1BPSjA5NXhXamJNWGliNUhuRENmRXlEZENZaGl6aEVv?=
 =?utf-8?B?elhUVG92aVBEbm5mMkI2Y2pYL0xiS210RURQa1JTYXRuU1hQSEdOdENWVys1?=
 =?utf-8?B?Tk9JWEtiTDluWkxpWGI5c21vTlAzdW85SjlMZGpkalEwWitMTlpicXFDWVgw?=
 =?utf-8?B?Wmk5K1ZqaFNUdzc0VVBBYkxkTGFQMytiZTM5ckpGWDNtb0x6UUc2OHFHZW9w?=
 =?utf-8?B?YnVsalR3NHFoVUUwRXFnNDR0OHBwNmRBbHovU1dpcThjMlFHSHVJM3dvV2kv?=
 =?utf-8?B?S0hjWjU0amxubVZRRW50UWxlVnd5cTlwYnZSZ2x0emVrNFhXdE9sVHo2Rk1H?=
 =?utf-8?B?ZCtTSThaV08wcndCbnVLRTBSUit0SG45anpRYzAyNlJ3TzB1eVFZcndJQTl4?=
 =?utf-8?B?ZDlheldPelgyRUEzeEhhWjFTUDRYNVY2M1IrOGt4VXZCRE9KTE9kU2JiU1NR?=
 =?utf-8?B?ZXR6WG9TS2RxdFZKK0xSQW5ja2pJSkkxVkNYNTZlbGJwb0RsUHJPRXNtTlVn?=
 =?utf-8?B?enhqekp6R09iaW9oV3RDb0FiRGVld3piSXlwNDlEOFFrWVhpQU94VkpGVFpp?=
 =?utf-8?B?T3p6b2E5ZExEeDAzQ3EvT0dSczlkaVhTeVMwbklEYjUyNUliYmlwN2hzNjFE?=
 =?utf-8?B?aDR5cjFQejlOcmJpZUY0LzBNeUI0Um5NRnZuWHdxYm5ScGxDNG5iL21tTUVP?=
 =?utf-8?B?WEp0SmVnVUZZa2ExSjdveE04RkFvVkYwY3ZRajl1NDIyU3V3a0pRZU1Nb2hn?=
 =?utf-8?B?QzdCRU1pa3daOW1udFVTVm9rWXNQYlJydUVybHU1RnMzTFg5V0VVNW9FeWU5?=
 =?utf-8?B?SjB5dzRTdXcybloyQjROQnkycGRzSUJPbXBqSGdNaWYrdVJaVHZBdnpXell6?=
 =?utf-8?B?dFE1VFdnc29OMnlDOW9FRE9TdWJxa1dpV3RSY2tFZnpTT29ZWXZieHdQVzNq?=
 =?utf-8?B?Y05YbXR1bTJwUlZvS3J2L1IvVG9MNlVsWVhlZE9ZeGM3REJPNllNMmVkMjIx?=
 =?utf-8?B?MHJaQnBadnRsZ2FhZDYzanFhNWdaZnFiQklkRGpZYVNma1BlT2xRMTJYd2Fm?=
 =?utf-8?B?bzRyTzBoNkprS2d4d3BjOU13Y05xWHZweDBMZ09oN1o1RXNjU2pvSUlPcC9D?=
 =?utf-8?B?MEV2dUh1V2JtMHlUdE1pVEtheTZGT29UcEl6dGlYam1tRVVPaC9tREhGbllu?=
 =?utf-8?B?ZGMvRi94ZzlNRlJnYnJ4Q0JjaldEam10TTM3czdnMWJsbm5NVTdMU0NINEtE?=
 =?utf-8?B?dGYrTEJqQnN1WWtSTng4WFlEVXVBbGt3MEFZeFI1alJTZjR2Y3FSd2ZOQW9x?=
 =?utf-8?B?SHJBa1lhcTRybTZIUmJuQzVOQnhaT2ZqQThOWnRVQXpSSU0rZ0VQRVMxb0lj?=
 =?utf-8?B?OFVGY2hYa1VkQ2p6UXp1Zm5UUFI2K1BESm1teHduaDJQT3lFSmx1NzdlNkV5?=
 =?utf-8?B?THNEVVBvbmxZZ0ZPaXUyOWkyOURXZ3o3bWhGT0JTT3JrMXFFQUM3V0hoVkZr?=
 =?utf-8?B?OEZJSE43ME5aNlZCSnVuOGJ1V1FuMnNKVGgyeXlyYU8rSUtrWlBHUmU5M2tV?=
 =?utf-8?B?ZFNaNnZFL3V1bW9oSzhnOWRYZDlzZlo0UTZlSmpYSGZ3cnhibDhoRVdzOFNx?=
 =?utf-8?B?K3VyYjlEY28vMGNNWVRvRUt4VVBzSkNQbGtZQzBzNCtHM1E1b29kSCsyTkVG?=
 =?utf-8?Q?M5YCr/Hh7img9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6002b87-afe2-4f04-a9ac-08d8f5768fd8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 01:28:04.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zju50Evw2zq312V/sh4flzpQmn2Jz03MyJ+enPqA4Hqpn07AnhddYxruZydmnNDqo4fF45R4M71rZnCLOoxABw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020007
X-Proofpoint-GUID: p4oDHylTZEfXvmPQCyrP_cQ-8W8hmiUd
X-Proofpoint-ORIG-GUID: p4oDHylTZEfXvmPQCyrP_cQ-8W8hmiUd
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020007
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/04/2021 13:36, Qu Wenruo wrote:
> 
> 
> On 2021/3/30 上午2:53, David Sterba wrote:
>> On Thu, Mar 25, 2021 at 03:14:32PM +0800, Qu Wenruo wrote:
>>> v3:
>>> - Rename the sysfs to supported_sectorsizes
>>>
>>> - Rebased to latest misc-next branch
>>>    This removes 2 cleanup patches.
>>>
>>> - Add new overview comment for subpage metadata
>>
>> V3 is now in for-next, targeting merge for 5.13. Please post any fixups
>> as replies to the individual patches, I'll fold them in, rather a full
>> series resend. Thanks.
>>
> Is it possible to drop patch "[PATCH v3 04/13] btrfs: refactor how we
> iterate ordered extent in btrfs_invalidatepage()"?
> 


  Oh. Just saw this. You may ignore my questions there.

Thanks, Anand


> Since in the series, there are no other patches touching it, dropping it
> should not involve too much hassle.
> 
> The problem here is, how we handle ordered extent really belongs to the
> data write path.
> 
> Furthermore, after all the data RW related testing, it turns out that
> the ordered extent code has several problems:
> 
> - Separate indicators for ordered extent
>   We use PagePriavte2 to indicate whether we have pending ordered extent
>   io.
>   But it is not properly integrated into ordered extent code, nor really
>   properly documented.
> 
> - Complex call sites requirement
>   For endio we don't care whether we finished the ordered extent, while
>   for invalidatepage, we don't really need to bother if we finished all
>   the ordered extents in the range.
> 
>   Thus we really don't need to bother who finished the ordered extents,
>   but just want to mark the io finished for the range.
> 
> - Lack subpage compatibility
>   That's why I'm here complaining, especially due to the PagePrivate2
>   usage.
>   It needs to be converted to a new bitmap.
> 
> There will be a refactor on the btrfs_dec_test_*_ordered_pending()
> functions soon, and obvious the existing call sites will all be gone.
> 
> Thus that fourth patch makes no sense.
> 
> If needed, I can resend the patchset without that patch.
> 
> Thanks,
> Qu

