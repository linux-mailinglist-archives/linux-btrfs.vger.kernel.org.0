Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5292230F308
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 13:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhBDMSN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 07:18:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37230 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbhBDMSM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Feb 2021 07:18:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114C9AiK017561;
        Thu, 4 Feb 2021 12:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yIjcelfUL97DOqMJxw4EIyTBdjwrG3iyl+I77PdOGDY=;
 b=WeLOUJxwxHSV3qyq9JD152dhbmZtskymmovj6DpbR3Dl40nQxcoBHgqOQegVNlZjT3pN
 qHpjzkHP8JKPU5gy4w2gtdlBzvJWcEJtmv2I+X6QsGSvsWbTsUCaakl/u5YknTr0Gj/0
 SjCijfz5sNWfKblRsKrZod+rXq1bu1pRXd1oQqTcTcmFwitd/WIWSqvBvXy4Z0s9fIIb
 LIb5RQSJfPyz5lJySYe5Dj7UFFidEmMiXbJ0HuCAC7oYpV/zDc/PxzHK3YUuHzCE0dOG
 8Ht6QNSLlmnKCqwzbPOvgiZrLAQXi9UqVfmFwf9vyuZG7RRa6ScEigeKRruHWOBuXFUA 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36cydm4vek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 12:17:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114CFaO8039336;
        Thu, 4 Feb 2021 12:17:27 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2057.outbound.protection.outlook.com [104.47.38.57])
        by aserp3030.oracle.com with ESMTP id 36dh1sdbgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 12:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JePbRpRQqarmH2hcpzNqFPb6ZcEqRTdQVUgqxrSX3zgHbuDxlVzoRCrUh07yg6LYmcb+Xbc1wRj4NlvHwhkw3qs7ZIPLdriZnAub4XdaF1Tce+ZpTbdB6dJC/gDYEfPZHPVC5hFnRK6t7jJAC1zemBgDgdbI0EuzO17+xTvjSG4ubzf83RJnZVHZ2y9aFbmeeAGaJpAIZZ/Tbqfww1E4w/WIstWlQAcEjkT5S8KKXhUY92KEmmSUOh3vIa2TuuMMVXQftBmyteB5QQej1IgZIOBKDq5jXqImgWc4tSKY7UyqU0RoJ8JoS5WL4XiJQrQjhVHdgQnhw0dSLtE1bLJgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIjcelfUL97DOqMJxw4EIyTBdjwrG3iyl+I77PdOGDY=;
 b=Svlgc68HJyk/b6QEs0TSMBWPlVX6oIHsnuLpY4jSmjRmmxOGzE6AEp+u6R3zBtitpgeaLRQHXg+6m0zcIPjaRfwWptUdhVClIRZkCtXQ3HlbEiNjWR5JKazaNg1rm6n3BOchWj+Jg/91Or2mLVArPUy3j6T0iXJ5OW+STnYImW5cJu2s9H/4r5jbhG4+IJV8mypkFgcVuCBiAIknk3gzxTeFOaPb3IM7/t3fteR71VWOssUz6HEfCDullu22f4gsl98FlbXfYsYgqLu9cRRUOqyn2WpYndDCeNAmJ8+wRcZJmHqJjhkkHt7LwqNoepor5ziOQDvFIm088EFbcKzyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIjcelfUL97DOqMJxw4EIyTBdjwrG3iyl+I77PdOGDY=;
 b=r1xnSIq5cKpYoImWlE+DPvZzLMrY0Y+YaLU1WvMvp6Fs3bs1F+mrqL5oeVPvmOe6/Faks6eSIg3vNsGSDO8CS8E9pKySK+Bia4bw4LQauBISqRCfCr8Q0B+/VJAfeOK49/nPRhYAqLpO8hLTh8qZanqYqkbBoVJoqKy6OpVmT7Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN7PR10MB2657.namprd10.prod.outlook.com (2603:10b6:406:c6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 12:17:25 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.028; Thu, 4 Feb 2021
 12:17:25 +0000
Subject: Re: [PATCH 0/2] btrfs: add proper subpage compress read support
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210204070324.45703-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <87318176-f5f5-c20a-ce63-290f9f84065c@oracle.com>
Date:   Thu, 4 Feb 2021 20:17:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210204070324.45703-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:e4f7:64fa:960b:70be]
X-ClientProxiedBy: SG2PR04CA0133.apcprd04.prod.outlook.com
 (2603:1096:3:16::17) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:e4f7:64fa:960b:70be] (2406:3003:2006:2288:e4f7:64fa:960b:70be) by SG2PR04CA0133.apcprd04.prod.outlook.com (2603:1096:3:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 12:17:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67b1df9e-74d1-4296-5a71-08d8c906d4e0
X-MS-TrafficTypeDiagnostic: BN7PR10MB2657:
X-Microsoft-Antispam-PRVS: <BN7PR10MB2657689423EB6055373BE775E5B39@BN7PR10MB2657.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PrNSfXzER5DXhEzo8XiF2W5vhq6cqI2anVFzoAc7Ydwy1eRPDpO5iXb5V1qcacOJPjYCfOOTbIvT1EjFLS2x6xuIPxWmmiaDBBcJm29JX2iyQuqe7bL/Fmot/pjtAWHF2Eqn2zpJMylDyh6wY9qA9VVAn4Zx5Gd5Jir57emyvBBs8sywlCDFcB9I07gv1mBYIo758UOUdHip5F/BTA/mV6tvolJj/ab0BZrU1KRQRjqzIltqZc5yKOTMd5SNhoFesB+dWophSjzyjVjfVPERvbidMLFke5dVeFuy9HWhaskEhIvD9niWQvoCqbhwAboAj1+kQqkG9Ab61a60IECDvRKEo/O3RWEwR/aPdTILjD/I1qKwSFnVTaNbMVSnFxGPsRg/jgyjDqBKxoG2pdE5UCgMuEcn2hwPn1UA1496wFh6qCPpgHvyhgZTHJj90otwP//h9vRGChJXft/gSiAEj2ptk237tOsiU0ylArdmk30qGSJDxwvPGMRLWF+PT+5ad+jNenzwUnZCWAMd6uke0V0fxkYIm45cZKyRFUYpEFoSNW5J27twZVtmvbIK73L0UFp5Q1si+ThvOal+hrdb6cQLLU2UYLhsEci/XMt4FCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(396003)(366004)(31696002)(66556008)(5660300002)(8936002)(83380400001)(86362001)(2906002)(6486002)(31686004)(186003)(16526019)(36756003)(44832011)(66476007)(66946007)(8676002)(6666004)(4744005)(478600001)(316002)(2616005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eS9nZVVGUHo1SUFKeEo1dUtkM2w4WTRZY1RuZlBMOURhYy93ZFdqMDRwRFhi?=
 =?utf-8?B?Qys1dVJjc3BaKy93bkZ3UmJUaGVLYmZqalk2VG5BckFBUEsxOEtzaXpGcG1R?=
 =?utf-8?B?bzhlTncybGZzVFc4dW1kT2o1ZFdaZVkyMnNUbU5SMmpweklQYXJPWHZpZWtD?=
 =?utf-8?B?c0pxK3hON010bUNTbzJZQ3BsNXdNNFpxLzRHLzkzOFkrM1Ava1AyWXFBU2xi?=
 =?utf-8?B?eVlySGdBUUs3QzFQeXhJVUtndkRXZGNYWmNXQzQxWFRFYnE4a2Q1dDhnVm1U?=
 =?utf-8?B?aTN0cWVqWlFDUDVpN09seW92OE4xUEN2elQxWUVrcG1JUzVZbFFtRCtvb0Uz?=
 =?utf-8?B?ZitOLzVpUU9sbmhZd3pkTi9nNlFBZERoUU9hcTNMcGlsMG92Nm95QVMyeWE4?=
 =?utf-8?B?WjREZjlhSGNsNHh4Z0tjVk5ydVlNbWtMUmZ0VmlXWjhDc1YrV0RvNHZUVHBC?=
 =?utf-8?B?QkNyaTlnd3VRTmRrSVFYdHY3Q3FiNFRaTlAwcGZVc1p4THZ5YmViSTdYdUky?=
 =?utf-8?B?SW5GdEQxZ015eE1OM3VIVmFCWmg2OS9aM00vZWhEVWJoQXZLVStoM1crSmsr?=
 =?utf-8?B?Z1dCZGZlbGpjaitpYjVXZjFYK1ErVEFlSWFwTWljUEVSaVFHczg3ZE4yK05x?=
 =?utf-8?B?OXdZbjRlWW9GMXdwd3RlRC9vRUlhWkFjWEJVRkZJQnAxdTNEbVZsc0Vkamo4?=
 =?utf-8?B?UE1aeTh3T0phY0dGdzR6Nzdidzd5c3VxeVk4SUMxbjhhUGJqdmVxdEpjUnVq?=
 =?utf-8?B?Q0pKSndRVzBFSmhTVjN6NHBxOVJreUFjejRVczJTNFRKUGw4NGhzbUNERUNK?=
 =?utf-8?B?TzJhMzRUbG12WlQzVTFhMmxLUGpsckRZZEF1RXpiU3UzbnhLR3hybld1aUN5?=
 =?utf-8?B?UWxBbTdnelFqcFBGUmVQZXhWc0ZiNUwyVU5jMkZ1cjIvNytQNnV4cWxYV3Q2?=
 =?utf-8?B?Y25RUkJzeU5LNFRSL0toZGJBdmNPcHI0bll2dDFsU2VQdzJMVW9NUTBJZEhM?=
 =?utf-8?B?MkJyZWhWYUF4MTJqSmoxMEFDRG5RbW8rRGxCaXNsM296bTNYd1BVK0FxRG1s?=
 =?utf-8?B?UTc4c3RwaVd6WEQzclJYSWNFOXJvcG8rcUorTWVjU0hMYUJGZzhxeEJZR2Fh?=
 =?utf-8?B?cUROZzZQZnR2WlpYcm16NE1zZ2paZnRCTER5VmE4Y2VmejREeHFqVzhzMURQ?=
 =?utf-8?B?Ukt4Um5ZMzJwOFgxcGRiZVpvOEg3WWZqb0hGdy9xeHpHZm1NOGxZOEtGQk1s?=
 =?utf-8?B?RlNQa0t2Q1ZMZUdHNEVnNmZzTmtLS25zdEtqQjBCN3VkVDk2RVdSK0NJa1hv?=
 =?utf-8?B?ckhmSlQyOTVQMGlGS05iQlNpZlZQSHhydWg0bVEzajdHSzkzbDByTUU0Nkk4?=
 =?utf-8?B?ek5yNERiQy9FYUR0Q0JXY1hORCtHTTNtVFdEVjBwNkNiY0lmRWJ0NWgwMXdZ?=
 =?utf-8?B?LzNNcWVPZjJxOHFZV2FsWGY5eDZUckdFYzdra1FQSzdHaEovVmJtdG16Tzcz?=
 =?utf-8?B?UTMxS3A1UVFVcTQyNVNMZEVLekJaam9uOHNjYjFJaDBuUjQ5ZFN6NWtQN3JF?=
 =?utf-8?B?L1I4WCtzWGhGS0MyZDNQL2NvSGJHdWl1SDNaV3I5bnQ1UWFxRGFsTkhmbUxm?=
 =?utf-8?B?OGZ1aHVKUG8vd1YzRGxYenE5RTd1SS9aWTlJQkg3VVU4MlN0ZFdMY0tZeFlr?=
 =?utf-8?B?ejBPK1M4SkhRMm5SZXR4WnRFdlZWL1N0RENLQzZlKzk3a0hKcDdsQUY0R3M4?=
 =?utf-8?B?czRvc3FqS21yUTc2TVlMUkJNeWJZNURnSWx5d3RsUzY4RzcrSmpZSldNY0l5?=
 =?utf-8?B?K2M1QmVSaGxKRCszMFQxWXZUcFgybC9wWDZuM1NBT3Bjb25OamtlY1MxYStD?=
 =?utf-8?Q?gScc5OrAAupFg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b1df9e-74d1-4296-5a71-08d8c906d4e0
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 12:17:25.5493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30WhUQ9fu4FERm3k3onyPw0w1lupxCx0izcyx5+5QaXJSpPrCYmPYhaYdWKKJC6jJLL8RsDHRNHfxT0jN0RaSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2657
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040079
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040078
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


  Nice. Works well.

Thanks, Anand


On 2/4/2021 3:03 PM, Qu Wenruo wrote:
> During the long time subpage development, I forgot to properly check
> compression code after just one compression read success during early
> development.
> 
> It turns out that, with current RO support, the compression read needs
> more modification to make it work.
> 
> Thankfully, the patchset is small, and should not cause problems for
> regular sectorsize == PAGE_SIZE case.
> 
> Thanks Anand for exposing the problems.
> 
> Qu Wenruo (2):
>    btrfs: make btrfs_submit_compressed_read() to be subpage compatible
>    btrfs: make check_compressed_csum() to be subpage compatible
> 
>   fs/btrfs/compression.c | 67 ++++++++++++++++++++++++++++++------------
>   1 file changed, 48 insertions(+), 19 deletions(-)
> 

