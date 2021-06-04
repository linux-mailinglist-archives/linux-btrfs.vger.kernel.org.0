Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3121739B8B3
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhFDMHa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 08:07:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50874 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhFDMH3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 08:07:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154C5CkB057346;
        Fri, 4 Jun 2021 12:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BrzjBg3HxIXeTAYc160IhRdnNgDX0/ydhnCd7+wvCsA=;
 b=y23q3zyCnZ1mgF6yZJbcw+WHWtwJEQ2uU+d7xEv9npvfeoR4/udnY0B4qJ35c2aURaIL
 jO6iVs3/DK+3ee3156dUHjvjlxF2PijvrHNuqwOAXMU2QBFYOWu/ZUqzj65wynglDQYN
 eUo0A7wcWGLXIIvu4ldYFP12gfDHoPsjL33L5IRsGNLFVwqKaGnYsTMPe3yrHF4QlJma
 ltngs49+ZoXzi+JngfxXV/UCREiZBNmo0EKJbk//vsdi0Evtun1fU34zVsXk24/5O90/
 VO/2aAEzBUBwjf58VbVbvFBV/0FGPyPNmuGE05WWRU7NlE3A91YoDRvx8yCdjrS+Tcv0 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 38ub4cwuh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 12:05:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154BsfKj145682;
        Fri, 4 Jun 2021 12:05:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 38ubnfntf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 12:05:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYfM/467TtLr7Jsf5kUCER+MNVhbFac7K776u3wlB6DJoY3aLtSwlNP9u/tkVGbXzlceMBcqaqtRLqyw9r8Fv2Sccf07gQAZjlXeBzJ1tAz0SJRevswxaAd2CjI3eSvP7k705tCRp9RhC/ibOxIm1yzvoify1FsOhmKQLrT5aOg1KYmCsjky5mDrcas7Zo0j7rJB4Wmw91KUyAHirxJuNiK5ZCVRk2FSjQpfgsJ4UFw+HR50GkJgZK4Pkt2VhoHnS+3UYMDEsApHGDvgl7lFU1IbCKHk5oerQCMkLKLnqkwSz+d1ygAfLA+WZ2oW/fjm3J8UUa0+jMNZcqNjMlDM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrzjBg3HxIXeTAYc160IhRdnNgDX0/ydhnCd7+wvCsA=;
 b=VrzLJdXkEqcM59t1/CeCSUSoVeNf6J9gv45GAxbIZqPmZx+XfETw+O52ulxYLuE81NHnI63273ZbsrCMTWxRAneklz3J/hH3Phx96NjTxiQ921HepgRhOZOkbodIPhdPVQqclY7ozvCmT8wb+U54onyDOzFEVoW9JnUbNiLdr/bBVnERjk+hE2/lrIp0vk2LZyEhnX9Z4XFQJU1ND7BC5zfbM9oGi98kLmotUl5ayKJeDohDxBvBCwDD//WaKjSbqutI2YZJjsC5OIibsBCtY4jv1DHimPl1rFX9q7NXdFmnupC1K8C6TJx5jWLUkuHrCpX94nsrVDGb39GFXSLmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrzjBg3HxIXeTAYc160IhRdnNgDX0/ydhnCd7+wvCsA=;
 b=aQEzATeEBOqEARNHnk6cQli3gJ/cfsxoCyyViQLC2Wu7ppY5bilL2h1ZCHbKWXuOqD4hqOyS72jFwxG9Lk7wzPLyhbHBoMUV12Y/gGg478mQVNTMiFokPH6djrJQp3orIBF30RPb+I4HF+6nGMpx6tA+l5upl7stszxl+poRbbc=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4317.namprd10.prod.outlook.com (2603:10b6:208:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 12:05:36 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4195.025; Fri, 4 Jun 2021
 12:05:36 +0000
Subject: Re: [PATCH RFC] btrfs: support other sectorsizes in
 _scratch_mkfs_blocksized
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, dsterba@suse.com
References: <2c3054e5b93f023cabd003ab4006d5f18ef3d484.1622717162.git.anand.jain@oracle.com>
 <35c6ff63-ccbc-9efe-37f5-fa0da0ed2924@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <63c81a92-d545-e246-b1d5-3cb2674e41ce@oracle.com>
Date:   Fri, 4 Jun 2021 20:05:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <35c6ff63-ccbc-9efe-37f5-fa0da0ed2924@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::28) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR01CA0124.apcprd01.prod.exchangelabs.com (2603:1096:4:40::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Fri, 4 Jun 2021 12:05:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdf6edd4-2953-444c-6a79-08d927510fb7
X-MS-TrafficTypeDiagnostic: MN2PR10MB4317:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4317C3158A9B357F5AB399C9E53B9@MN2PR10MB4317.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uq982Dl7KMhZQPepPVM/rct1oeguIDXjp/+J1CgO3UuR8K83J+xXcjEi2AdK4/4uno8/KHL+c9QtHV/OGNypdVzMo1CSt2AoTtOxQqLQbNJY7ptVfhetjhJxBvciVJkrjYxsRiTMajab4Has/1PfDYjYTH9SEKXx52OAKo+lU95NCvBXeWfLgtoLS2tnovGVO9O7SiIE1kx7EoJR6foS3s7Knb3q8Owb/UeKt/6nzsc8GZj3Q63cUHCIiVjQjslQsFQSSBTOtxoXn8GVpDbi9mtL8n1UQTe+zd2B/HtD17qHHExity6H+x5xQfKyUbLAHweuSOkZN19dth2Cyo/EGjM+AXS5+94MNHZceNdO5EjCdddWeUkZP/Hmp1ArKdRAO9AVlTU8F15BZ9aWcgCTsoHYAO+EIaK/TZAaMFGEwsrnMAqaeMEfuzBDZl7rC7UaSSoavkknYG7KvQcHJfqo4zGrXbNgedFAbdAc+LOKzst/Uep6Gpi0aDcnBbcEVR0u76voh5s38z23XQKifRi7NnnwJv6Qf9LoMjqUeRLASyK+vRbghtgT06WgKo9qaV5Wl+oEhmydsuJ2jk6yaVEOhVJsltciycnDIT8n9LFqH5s/uHq6Q9MoKDEfettSQKAAwE69UCy9lRG5culYoxHIuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(396003)(376002)(66946007)(16576012)(478600001)(66476007)(316002)(31696002)(38100700002)(66556008)(186003)(8676002)(83380400001)(6666004)(4326008)(53546011)(956004)(2616005)(26005)(44832011)(6486002)(8936002)(36756003)(86362001)(5660300002)(16526019)(2906002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VXVGbFdaQjBVdXdkWUhjNENkMmNrOWw4RzB2QkU5dkVQVzNweTZqNWFIdXdS?=
 =?utf-8?B?MS8zQmVuM2VjSUtCU1k3alhQSnp5TXBuOXNxTjYrcTk0N2l3a3c4SFBUaHFC?=
 =?utf-8?B?aThERXNUbExpU3lxc3h3QktTRG1HQ2JiWlA2YXQ4cmxYK09lUXk4MXJ5dzZ1?=
 =?utf-8?B?SzNKcmZDT0QzZ1hMekRCenRDLzloK1U5NUlmVlRsZ250cC9EZG1MZklqYTVa?=
 =?utf-8?B?MnM1cU8rajNTNmJQOXhHdU1yRnFtdU1uRTZlNjJTY0dqK3gzZzN5N1JLNFlK?=
 =?utf-8?B?Q1pZYTdIanNWQ0NvNzJvell0V0owd1kzU1BDMFlKL2lJRXRRd3BnQUM5THVS?=
 =?utf-8?B?NjloNHNVMVllaUhUQ1BKQy90Z1FMcHJyMWVtWUJzT0w3Q1pUTFJZbUJBTncw?=
 =?utf-8?B?UkdiNHdDZ0R3VlpYaUgyWlFvY1hHWXlHa2ROTHNuRGV4bDFyeGczNUl3ZzV1?=
 =?utf-8?B?RjdweUExcHQ3U3VXeDZncUh1TzF3dXVnZFFqQ0dVL05USFpSSEFFNURaT1FN?=
 =?utf-8?B?RU4rOHI5ZnpUU01UdlRJM2J4aFN6dTUzZ01vTmlGRjY1djE0WllBTm5vQlI4?=
 =?utf-8?B?aGlmZUpSWGc4ZXRsMkoxVU1KbmZ1U1pKbHBKbThIVk85ZTJUbTVEWnNaOGFS?=
 =?utf-8?B?MTlwaUMzTFNkV05jVXcxYkl3TGY1Mm1yNWc1TjZDQzIrTW1vMVMvcEpxN0tv?=
 =?utf-8?B?Tld6b2phTGQvVGN3bnQ4ZW01b3hhN0hiYjNyU3J6VHIrYnhwUVdrUk12ZXdB?=
 =?utf-8?B?aFhFSlVRL3JITDZyWTNVd1ZPTTZnN0hJWXZTWHNXa2ZSYnJkaERMVXJ0cDRy?=
 =?utf-8?B?RUpVeTFmZWo1TENNQjd4SGhYS2RMWEM1Zzdsd3N2UUJ2RzVDR3RVeFYvTjU4?=
 =?utf-8?B?elhMTW1nQndsbFJFekJWaHFKS0lmUnRhT2xCaENOV2Q5QUdqNmZGckhvUE1Z?=
 =?utf-8?B?NlpYV3JhTEJSS25CellFODNRZFp3cVNuM2VZenhac1ZyWWdETm9sWjl5VW9a?=
 =?utf-8?B?Q0wvY05DU3cybERBS01QMVNxdElKbXNKSlBTeXZWTWYzajdYd3ZaTi9kSFo2?=
 =?utf-8?B?L05nWEU5VGtYbi9PckNNTWtBOTdLMmpmbEtlSE5odjREM0FwWlJucEVKVkdS?=
 =?utf-8?B?TFAzNXk0Wkk5cWtnNVBoTlVvaENxaWdkOGI2bFhHMUNENXNnNzFDTmhBTWpS?=
 =?utf-8?B?SW5oMzJwV0w2d0UxUFh6YXBVYmdHSXFLT0o0eExrd0FUU1FKRkhlWGRQejBS?=
 =?utf-8?B?Z2ZRamZ2eVFhaFNOWHZYdjMxdDJ0bTAzb1RGNHdEZm1nVXB0NU5NSWozWjY0?=
 =?utf-8?B?Y2taZW1vL2RlbDJPN01IcnFpN1hLaFlzdzRqZUFmb2xvM2VCR1p6UkdKV1Vz?=
 =?utf-8?B?M1dqdHlHSnNKNGtmQzVldnRvbDJWODRFZ3FXZWtQenhQR3dqRkxybGUxZHlt?=
 =?utf-8?B?TTNNNFo1OG9KTkxSQkZ0WVpsZW85NVFxUThHZmgxVFNqV2loSGN5T2h2eThN?=
 =?utf-8?B?RlpUelFYVWoydDdsSUVVKzE5QXFXdG9nQ1pWVzRINEU4VVgwaytobGJlRTJW?=
 =?utf-8?B?UFV6bmt1akhtRWV4a1I4a2dZUEUxUFdUdnFhS2FwRldPZk9nVGkzTUdSb1JF?=
 =?utf-8?B?eFpUcE1iT1RYNUhLRmJTR3hzR1VzT3V1eDMvL1BlVWpLNi9MNEpnYUVxN3lt?=
 =?utf-8?B?UU9zUUNxZklLNktxRjlha2tQQ3BLL2RvRXdwVEtIaFBEOHdjUTBoT24veEgx?=
 =?utf-8?Q?tcGxQT2wBejSn9X351rItKUzgVDfDUhsynxvSnI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf6edd4-2953-444c-6a79-08d927510fb7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 12:05:36.0871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aO885hmuHntNhJZpLb+2bDGRyZiv/y9NePi61tI1m9Rxkm5Z6cPOq0dhTaWNRY2ct2PlFvKyNvLVESovdfLc8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4317
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040094
X-Proofpoint-GUID: fJhJMC4x6_h5Kee9swHVJbrWowOTELwt
X-Proofpoint-ORIG-GUID: fJhJMC4x6_h5Kee9swHVJbrWowOTELwt
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040095
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4/6/21 5:53 pm, Qu Wenruo wrote:
> 
> 
> On 2021/6/4 下午5:36, Anand Jain wrote:
>> When btrfs supports sectorsize != pagesize it can run these test cases
>> now,
>> generic/205 generic/206 generic/216 generic/217 generic/218 generic/220
>> generic/222 generic/227 generic/229 generic/238
>>
>> This change is backward compatible for kernels without non pagesize
>> sectorsize support.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> RFC: Are we ok with this patch?
> 
> Awesome! I forgot those tests.
> 
> But unfortunately, those tests are still skipped due to the fixed
> supported sectorsize.
> 
> Those tests uses PAGE_SIZE / 4, but we only support PAGE_SIZE / 16 yet
> for 64K page size.
> 
> But I still believe this fix is appreciated for the future subpage
> support. (Yep, we will support other sector size, along with different
> PAGE_SIZE in not so far future).
> 
> 
>>       fstests completed on first 19 patches of subpage support (results I
>>       need to review yet) on arch64, with pagesize=64k.
>>       Subpage RW support tests are still pending.
>>
>>   common/rc | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 919028eff41c..b4c1d5f285f7 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1121,6 +1121,13 @@ _scratch_mkfs_blocksized()
>>       fi
>>
>>       case $FSTYP in
>> +    btrfs)
>> +    grep -q $blocksize /sys/fs/btrfs/supported_sectorsizes
>> +    if [ $? ]; then
>> +        _notrun "$FSTYP does not support sectorsize=$blocksize yet"
>> +    fi
> 
> Can't we merge the the if with grep by:
>      if grep -q $blocksize /sys/fs/btrfs/supported_sectorsizes; then

  Will improve this and resend.

Thanks, Anand

> 
> Thanks,
> Qu
>> +    _scratch_mkfs $MKFS_OPTIONS --sectorsize=$blocksize
>> +    ;;
>>       xfs)
>>       _scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize
>>       ;;
>>
