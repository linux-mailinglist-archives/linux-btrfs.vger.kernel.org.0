Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC703F9467
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 08:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbhH0GZK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 02:25:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39822 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244235AbhH0GZK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 02:25:10 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17R6In4n000885;
        Fri, 27 Aug 2021 06:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AGkgYQQUGSPdrdMBSFk849Fe6XL0tQbrb9wzoqHgZE4=;
 b=hw8k4KmrF3/AkFk0WPrT71sCf8D42xhey2XfWdLx2l1QRnOoaPOoeDFxFxgbzTOjgoD4
 ARcGamvgkCoJVrhFFK+atExGX4EABZzbg+FWxv9TrszVsaKsgRXuieD8VEEVYRLZtpPu
 UrQ6gW7W+4ltYnbGsCJgbHd3KdDbi8OtJOecSK+yxFFAy2l+rfcA38UYSnYLXh2+c8xJ
 CrCsF01yQYytrA5YozEd/oO7AatMrg6s4f1casrdjbbVQqVBt791gEO4xA/9+VfDt4LT
 nMrQ954ggRCAE6Vwc2uLD+dqzWnPiZqTHXB4C9l27S+fYvUdvXetVYfIQ1yuQ12CL0kz yA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AGkgYQQUGSPdrdMBSFk849Fe6XL0tQbrb9wzoqHgZE4=;
 b=dpY3VHhez6BDljyKjY8FgSEfD9AYHBeE9UxyzG/nvVevkfE1THqg0WwROBgTjES8LlzD
 K8pxIg0n0CWBl6yZy2mww9SpXLez3qe6OkmyFL6HL7w8ehUFw5TK4JmEhqsvAC3K1Xqx
 gJJHu4gtBAlkmpWSXrBxan28bb9/BqA7hCmCaxwWePzMXcjICFin3/QISCYJ5/SwYfhC
 DRBuxJ2fMDfvz4gBUcxvI5u6/Kvi0oA6zLT51Dfk4tcoYQuOR6yKweRtg0XQG1ohwHtS
 qr8HFlOowgi7mVLHOwMd4Tzbd6z2VsoUA4boM/LufWjmQxP7AVj4Ja5mwkTxjZaSzG6b Og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap552aqpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 06:24:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17R6LaJr142426;
        Fri, 27 Aug 2021 06:24:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3030.oracle.com with ESMTP id 3ajqhm19sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 06:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RN1OwbeM0QJAQabCFBs2hhtLeFNwB14pk3goFG2lfAPpm5iltHkeICtAknecNfH4bcFkfkQaUxMXpWLjwh8d9Hl9zR1mu+E4o29xJTnDYWMGiRkfNBFunteMMa1CgWi/QpXEV4mfb6eLAy2gQ5XWJHY+1PXk3bwsP/CtGDDGyqt1VYvuVaPzCTX5lyW1te/IosqK8epsI7y7NeUV5zDERYLhpB/IsFhlZj73KDEvr+X3t/Q75HtgPMgKSYNir2+NMYE7UIb/Nxhad8ldRzqnA2ne3LU6sxPzKEymuRWCE39NJAnqHxz5DfkocyQxZINTxCNReRUJJNiwXOMhNYNBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGkgYQQUGSPdrdMBSFk849Fe6XL0tQbrb9wzoqHgZE4=;
 b=bwdrlVLWl/4zU1yK4ekynUbp2F9rb8ybg0A4rb1Wla6VDGECvDicthSkvEEjmi2JZHnAkNeZ71TrFlvUG3dTU/j/BOkko7XPa2fBOCAgddjTmN7itVliA+GAktQKDQbxUHedhZep+FaNA41gDdvnc5fed2CP/ausu9EQNPUxPFQ/8jfHbsrBOxaNwOeeUs5j4K2ooZTbK5ZWR0mfR9BQyltj81kb4Kak3iwmODiSYz1vSRy+lQDgDVE8McEfXXgI9Br5xLp0cCuiCrEczqFfbncz7QEaoC3aa+HlHCX+DeiPZ33H/SoeekbT0DUsSKTEQqYK0Yv3Azxdc8fO4F+zpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGkgYQQUGSPdrdMBSFk849Fe6XL0tQbrb9wzoqHgZE4=;
 b=najVyK2mddQFtGePXw3M9TsFnNJu6K3KZW4aZzS9v7eJ14iiQpER1Psb/yYQA0BiyrD0WDQ2bGhOeGHYwXLeKvr+2YByXtS/DdZNzFMHsE3n+ziWLchD7VNnt4iWCmCZD5KhdVy5DTBdGAAU8YNgWyJhhM0htDxOdERxQncSAno=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5281.namprd10.prod.outlook.com (2603:10b6:208:30f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 06:24:11 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Fri, 27 Aug 2021
 06:24:11 +0000
Subject: Re: [PATCH] btrfs: fix max max_inline for pagesize=64K
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org,
        Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
References: <bfb8ebd29d6890022ddf74cea37d85798292f6d4.1628346277.git.anand.jain@oracle.com>
 <20210816151026.GE5047@twin.jikos.cz>
 <d418c51c-abc5-d08a-aa20-7781cfe1741c@oracle.com>
 <20210826175314.GO3379@twin.jikos.cz>
 <14e03a46-6ba3-9b7f-30c0-0be0dee5b4c8@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <fa092236-9bad-89a2-539f-bc332ac0a3f1@oracle.com>
Date:   Fri, 27 Aug 2021 14:24:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <14e03a46-6ba3-9b7f-30c0-0be0dee5b4c8@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.65.145] (203.116.164.13) by SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 06:24:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52136e54-a141-49c6-85f3-08d9692348d5
X-MS-TrafficTypeDiagnostic: BLAPR10MB5281:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR10MB5281046FF0E626E71F71DDE6E5C89@BLAPR10MB5281.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUQvdxtTn3ka0kFWdRqpCBNKrYNbuELw72PkTalPNm9D7Jylrl5sRV7vvypRkLNENZkKsb/hf7dgVCowMBoadDNiTXaK/cIFF3rW6k7uaZlCyTnaefdO6h2mVM8e24nkd0yslIwScFhDty17+WOKhgBEFAzG+9Huf0a03jDWNOOsXwr+tdgeYQZ+k7SBUfUjWuRtt+UnVlqDYZ5DXjAEsvRxkuHqtSDXwBCz7xpQBvq4nO88Yq6IhP7ZRqNiYRuVQTVkARa617UKlTxM+MjJewZMRmDzujpps3cFAVudOG5vxRGqu31zGOpZQs5Zbdb9B0ZGB7W2/k/lwOCJ6iXPmttoO8MzRvzAwvVE0REUwZY5ezFhoCam+nvWTm1ZqMdMYdXJt2Bxdfv+I5Ec7As9BQj1WEaz4EWzQ9zIIRnT1hypeyTdZuF9XjGDrxXdb0uw1/wVLSCKsjIe3yACHmS+2SeYn6FRRmg7qelqBJz/6otTSgp4ndE7L04gG4LSCMTe8CWtciiF+O0arY3YON+jA1Dv7wM6KQdWRp5YPmxInBhmHjqhdpRb0T0Z9YQN7p2k2+/BMUAWdahpValAvogDnHGtqGzo/99OZvpK41ItwU654PUKag5XkHmH7C33Y/OxekzEdjL+FkiFN4MxZCFGNbu8VT5vOW9oV/55DXj54+vt7OogIU4VZE5DZoV/NZzWgtVSJPT0InACO1fzh6n7ZNpss3jro9J4pJsdWqISFbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(956004)(2906002)(66476007)(8676002)(110136005)(8936002)(5660300002)(44832011)(16576012)(31696002)(38100700002)(186003)(31686004)(86362001)(2616005)(26005)(6666004)(6486002)(36756003)(83380400001)(316002)(6636002)(66556008)(478600001)(66946007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzI3S0o2Tzd2YnJqajlDam14M0Jic2xpNDdDR3RZeHlMVlpIUWVKM2FyTFhx?=
 =?utf-8?B?bnZCUXc0TENDV1BaWFR1TnNWZUN6ODFwb1dwcVQ3VFpoc1pITEtUNll6WS9x?=
 =?utf-8?B?ZEZvdlUzTmpURVkxemJaTE1tQSt2aUdMaVZpUFlIbThrK3YwRjB2ZkRTNkps?=
 =?utf-8?B?RVp2cExrVEx0aktCd1NKVXYzbDBPSGhHTkZrR1pvclFrVTdQcXdzaWwxbTdw?=
 =?utf-8?B?d1hWY25OZGRmNTVKejMxcDFqbEdTSXZaY0E4eFUrNU9xUDBmeUR3b1dDK3Fi?=
 =?utf-8?B?NmNZQlZHdlM1Q1dPeW5KMGNEdDVVOWp0ZVIzR2VVeHBTWEQzUDJHenZmelB3?=
 =?utf-8?B?ZDUvTmVjWkV6MG5QTkYyVjBTV0lTcWV0RFp1NEZ3dDlLVGp0NjMxdGJYYm1S?=
 =?utf-8?B?V1FpaUxuTC9nbzIyT0JiRk9RVjFERXkra0dBdDJQaXlvVXRNRHZVS1JubytG?=
 =?utf-8?B?RnZNcUNxNmxYNTJrbU02NlAxQmRER1ZvOGpZNVd0M0N3ME1uZGZvbWtiRnBF?=
 =?utf-8?B?amtHcFg0TTlVUncvUEcrQk96ZUh4elNubWg0UTBxc2dXQlNaUEhlN3JYWmth?=
 =?utf-8?B?SnRMa1A2MTNIZDNFTnFmRUFyL3NkdEpqTUxZNHNBUjhMTU1wdGlCcFJxSHNh?=
 =?utf-8?B?VTBxY05taHd0cmNKeXJnVFVUZDJ6VXM0eFVndEhjTUpDUUxxYzdUWXZPWTJH?=
 =?utf-8?B?TU4rMFY1dXRDZ04za0o1SjB5NW9kcGtROW5Uc0RGTUxHalBQUlJ4djlPekJW?=
 =?utf-8?B?amdlK1ZiOE1BaXJld2tGNUJUQlZvczVGK01rcU80TGxLU2xObWw1eDEvbDg0?=
 =?utf-8?B?UFZMaTJ0eVBqWVpzZXJlK1EyVnNOc205OWRVNVBpK1ZWeW9TUW9FMnpVVHJV?=
 =?utf-8?B?Z2xCaUErelhFU2dYTDVETHZYMkFRQzc3MEZDVVd0Y0R6SFJHMWhDTjhlVUha?=
 =?utf-8?B?K3c5L05INnJNNGN4YmY4Qk5wNE1Eb0RobXdkemV1K3VybjZXYU12dlhoeGh1?=
 =?utf-8?B?c0xHN0p1ZndZL3NvbncvZTRmSy9UUmJydURJSzBOV2pFc0pHQXhnWHV6REJO?=
 =?utf-8?B?Sm5aamZ6Q0ppUFlnRUdqZkxsRkhKTjlJOEtpbS92YmhnYUw1cmJRYXExdytm?=
 =?utf-8?B?SE1TK2M3V0FLUGpMa0tyKzAzTHdySmpyM2xUdUFNaVJpaXliUVBRQmFMdzRw?=
 =?utf-8?B?VU02MlBZd0VnS1VWNE95ZTNORzRYdDFSZFJsUkxSRlMvQ3l0QlNzWWtDeDB2?=
 =?utf-8?B?SG4wU0pQRW42MHNlenJQY1RmbVh6ajFxU3diQWxrOGhWQ29JR0dYalJ0QzZy?=
 =?utf-8?B?UGtzVWlOZXNlNkliMUJPK2NnZGpyK1JMUHpCZjdURlUydFdvNjNWaUpNdklY?=
 =?utf-8?B?WXovTlVVbDlkeGJnQk44QkxQaEZXOWJSZTdUQnhFSFNZUWhhTGdicGdiOEJI?=
 =?utf-8?B?ZHd5WDI4clJYcmJMN3dxRGtKc1dFZUNqY05sSHROb0ROZ3RMYStDUkNNWkpn?=
 =?utf-8?B?dVdQL0d0c1cvQ292eC9uWmJ6bFVnRkdiS3Z2MXBremNoMXcwT0UxSHhlOTJ1?=
 =?utf-8?B?dVU1TFp0azlyVGpPeENtNkFzUCtCYWk4SzhDU2JTR2x1VnhtK1lqYyt3RHFj?=
 =?utf-8?B?VXFNR0xUZEc2UmY3ZEZmaUlLOVRiM1ZNL3F5Tk9uNzZteW53WUxOMXYrTE1P?=
 =?utf-8?B?YzBOSVlVQlE2RFk5ckRGeklac3lZdC9xa3BlNHBPYVkrUW5YZFFlOVcweFhM?=
 =?utf-8?Q?HLLUneNjbxQe3cWW1Uy8NjMV77+anXSr2xm53K+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52136e54-a141-49c6-85f3-08d9692348d5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 06:24:11.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QACVq84DZXcSV1vKo7kmw+neb2wKeXaoh/kRPSqPOJ7lU/Xbmg+QlnePJpTZMxtIWEDSc98BwK5ceTBW7+StfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5281
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270040
X-Proofpoint-GUID: OplWvEotXWHNw4qdug5DcTYUDoVNLZeW
X-Proofpoint-ORIG-GUID: OplWvEotXWHNw4qdug5DcTYUDoVNLZeW
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27/08/2021 08:38, Qu Wenruo wrote:
> 
> 
> On 2021/8/27 上午1:53, David Sterba wrote:
>> On Tue, Aug 24, 2021 at 01:54:21PM +0800, Anand Jain wrote:
>>> On 16/08/2021 23:10, David Sterba wrote:
>>>> On Tue, Aug 10, 2021 at 11:23:44PM +0800, Anand Jain wrote:
>>>>> The mount option max_inline ranges from 0 to the sectorsize (which is
>>>>> equal to pagesize). But we parse the mount options too early and 
>>>>> before
>>>>> the sectorsize is a cache from the superblock. So the upper limit of
>>>>> max_inline is unaware of the actual sectorsize. And is limited by the
>>>>> temporary sectorsize 4096 (as below), even on a system where the 
>>>>> default
>>>>> sectorsize is 64K.
>>>>
>>>
>>>> So the question is what's a sensible value for >4K sectors, which is 
>>>> 64K
>>>> in this case.
>>>>
>>>> Generally we allow setting values that may make sense only for some
>>>> limited usecase and leave it up to the user to decide.
>>>>
>>>> The inline files reduce the slack space and on 64K sectors it could be
>>>> more noticeable than on 4K sectors. It's a trade off as the inline data
>>>> are stored in metadata blocks that are considered more precious.
>>>>
>>>> Do you have any analysis of file size distribution on 64K systems for
>>>> some normal use case like roo partition?
>>>>
>>>> I think this is worth fixing so to be in line with constraints we have
>>>> for 4K sectors but some numbers would be good too.
>>>
>>> Default max_inline for sectorsize=64K is an interesting topic and
>>> probably long. If time permits, I will look into it.
>>> Furthermore, we need test cases and a repo that can hold it (and
>>> also add  read_policy test cases there).
>>>
>>> IMO there is no need to hold this patch in search of optimum default
>>> max_inline for 64K systems.
>>
>> Yeah, I'm more interested in some reasonable value, now the default is
>> 2048 but probably it should be sectorsize/2 in general.
> 
> Half of sectorsize is pretty solid to me.
> 
> But I'm afraid this is a little too late, especially considering we're
> moving to 4K sectorsize as default for all page sizes.

I am writing a patch to autotune it to sectorsize/2 by default.

To test this, we need to have a filesystem with file sizes of various
sizes (so that we have both inline and regular extents) and run rw. It
looks like no regular workload (fio/sysbench) can do that and, I am
stuck on that. Any inputs?

>>>> Please fix/reformat/improve any comments that are in moved code.
>>>
>>>    I think you are pointing to s/f/F and 80 chars long? Will fix.
>>
>> Yes, already fixed in the committed version in misc-next, thanks.

  Thanks.

- Anand
