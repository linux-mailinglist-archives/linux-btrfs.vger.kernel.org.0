Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE4139DBC8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 13:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGL5E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 07:57:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60344 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhFGL5E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 07:57:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157BsLea046822;
        Mon, 7 Jun 2021 11:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=aeVbIjd1cZ6hiQhouyrUZkMAryPHicliwNl5WhBoWJk=;
 b=h9OBq5AZMUhYCsM6KFpDJr5yamvaS3aHngEJxAbhGi6pKALW2K6HIO88GMXl4E/MQPk7
 B8e1hAPvLX+fbCXB9MjIP1fQ3eFEtWrvNg3v/f+eAUbZI4xVpWFloNRax73IY1l/oT0R
 zIuDUKUYN9QH5OpVet3lEe8aHeNxNFjfV3dJZb9u0y8t+8pdidFBjg8omOFMCrl8MN+O
 cG2uDRemijuVI2HJHSJs5wmDmBF9lmxXDAscPv6BM9DJV122H1LcRHLFLbzD6g49b1kx
 A2biKNjpVVXg243YIxgiIo9F7ZeoldW5wV9PsnI20lCKwBmNh4E0iHjWm0E0p2xvOLxV iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 39017narg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 11:54:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157BswvZ176428;
        Mon, 7 Jun 2021 11:54:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3020.oracle.com with ESMTP id 390k1q01xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 11:54:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVfNWzq0HlODeLlRAb1WjXzbCAhLe+gCNLmN3IeNGuFK73c9wNk8bVme1Fo/03KWyV+39XK6OllXNCuSrSQnXEHhqsHZ5yHfpEOqFco9h0Khf0NcfFfXrKT9nTYrTr3EifazVm3BL5odbwGCZWyJyl3wsHII3i1v1WsHum/XydtnMfD4AdteuEhReDdcnG3S29BYdsdxMgdVqgq0yk4otskiPocguTph3Fo0ggT6rdq2wgskBE744OYZnfx6Q0Tf0Yh+4PxKVeRBwyHKj0Z05zdr9u0fh10EewaCb3C840sfAuHLPYIDvYSoM7a+xvruzVtyPafxPdVq4RDWvgsCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeVbIjd1cZ6hiQhouyrUZkMAryPHicliwNl5WhBoWJk=;
 b=hBGxUqlKIDTKwLACGn7YpdUFpk0NVmg6eQTYVMt9cjDlVKajJZOaeBAx24t6pmGJCogwlTlrU6CsC+NadWhCy7cUqcAJ64FPb1R+X8lTydRAukEeIPeSKX+RbLPsPlMsc8JC6KGvtV10cZYEQKzcAKvAWMmrEFU1GYTr1nm834znBlri3wlqXc36o8YvKtU5oeBIi5lARYn0hzMiuARWKcMEMgKUzRjesc5Dr7ksc5vTTvw6R/ORK6L8k59KeYqMnlTNWPHqmFvg3LHT5uCJUeAblSgYTWjqB016/2X91Z41g8RX8p6Jk7WU4ApOxtEDW5SVGPOOQ/paNIbAcifXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeVbIjd1cZ6hiQhouyrUZkMAryPHicliwNl5WhBoWJk=;
 b=CIflfyx/447U/bfBtmYydkpf6VZ4xfsAU+GmRB6MJq/nLUh0g7eVgl/hxBfVM3yKr97uNh5DlfqN5JXyLHlXQCYz31ptvZrc1ZChYMQO7e1ZWMuGouZtTaWGbyWDTwmqqdPZI+/XCVwpMEbkSjpJh8csDnCBX6a+k8cGapcez/Y=
Authentication-Results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5075.namprd10.prod.outlook.com (2603:10b6:208:322::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 11:54:49 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 11:54:49 +0000
Subject: Re: [PATCH] btrfs: support other sectorsizes in
 _scratch_mkfs_blocksized
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        g.btrfs@cobb.uk.net, quwenruo.btrfs@gmx.com
References: <d27e3a324f986b5b52d11df7c7bdcde6744fad4b.1622807821.git.anand.jain@oracle.com>
 <YLzUph/ehN12cMCC@desktop>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <93bfaeff-d47f-4eab-73a7-ca478a3508e2@oracle.com>
Date:   Mon, 7 Jun 2021 19:54:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YLzUph/ehN12cMCC@desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR03CA0150.apcprd03.prod.outlook.com
 (2603:1096:4:c8::23) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR03CA0150.apcprd03.prod.outlook.com (2603:1096:4:c8::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend Transport; Mon, 7 Jun 2021 11:54:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19707825-42b2-4411-7700-08d929ab0d57
X-MS-TrafficTypeDiagnostic: BLAPR10MB5075:
X-Microsoft-Antispam-PRVS: <BLAPR10MB507513B5CA936E1F72ABA1A1E5389@BLAPR10MB5075.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gdr0425BaSxqGRXib2t6kkDpj9nam6px/wB+PjWsPRNCoiG8h0KCZEKO2m89ipIO/3n/Q9HMIzOZKFB/XJDiFyZnIY70EmliYR6e+/nmCEOO7c1KvVkD64oPS1fsSnzIm2yIQjCIjLQEDpsto9XU1D0MDaut5AFOiW4AKB+4eMI/kmhFqSK3U1+quztj/aZsmQcG6bo1kHb6zj2xKTma8xgWCavPHNX6gQdn6TX94dx8tv08GUbAYPb6RZeBGy2MIbbhEjHVslLJuQyuNXLsG0cKp6wA5PMWHW1jCcbj1GIpyqT3D98WpdArZ4tf2+bkNAd0ma84x7pVK0BuG4PKgHWHQyEiAh3BqyhCKKeCszdzSoxPKPuq4TCMoZ7X2Z8YU/frfcqfrz4RySYAYqAEZAP7AxIQA2lcz4gn+UrRifIOmGcRmuyG3kubNmGiHu4pihSQYahCM/GA6d+bEQAvlX6Lt3auYJSFQudXlcW8T2fOAaTk+e4sO7WCwWUDB8GuLkyhDn7Op6L4g1rdjQFvhCzOuzTSdf7+z+7AWaYb0ZY5J9fWQvlGdPHC29sVagAnNkVRRIph7VFsIdDlLLbQTsNb1jMZcTKHhYLWjH5jG4JSwDvWP1l3SwFCDQRwNoPPakzaAhu4lreKYW3jZgpQi6mH0mVsmyWVIwKtH4cOEo5OE5o6Des2T7n1wZIlSgvQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(366004)(136003)(39860400002)(6486002)(83380400001)(31686004)(5660300002)(86362001)(31696002)(36756003)(186003)(6666004)(38100700002)(66556008)(66946007)(66476007)(6916009)(2616005)(956004)(316002)(44832011)(26005)(16576012)(8936002)(8676002)(16526019)(2906002)(478600001)(4326008)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c3JPZHJvSXZRUlRzN3Y3OVVob3BXWTgyb0dia1luVnFPRmo5ejJ2Uy9vNm9R?=
 =?utf-8?B?YkJLWUJTVmN1UnV4MmFjQkIwL3lhcExwK0lyRFQ1VEhSS1ZGSkE1Ukd3WWZt?=
 =?utf-8?B?QUljZUdiS1Q5Y1ZpTWpVYisvYWJlUUdUdnNXK0JnTm5CMnFLOWpYQWJxUWhC?=
 =?utf-8?B?SnNWUXJEZXBseENIK0R4YnlycklPTjRiS2VXMVo5TmhaamJ4Nm9kMlE1K2dK?=
 =?utf-8?B?UFFIZ1JsQWd4V2lIZlMyZi93azNUL2o2ZlpsV0pHRUE5SzNFc29OWHRwbERT?=
 =?utf-8?B?OXBQaFAxM0JwQmFoUW1lOU9DUTJjQ0g1anlQYVJUMy9Hc0poUGV6YzJjVkxL?=
 =?utf-8?B?VEwxVnNqdDdGY1ZOT211cUc4M2o2N3d5YThBenJhM3RZdldNcWN5QkNHeWRI?=
 =?utf-8?B?VTk4ZU16eDk0TVIvSEh4Vkp4dXlBeTdLVlgxdE5RVXMyaElZb0djSkJLbWM4?=
 =?utf-8?B?ekdRd2dlTW5CQmFzeldRdjhyckVDRFZ6R3RKbGI5U3VjR0hROEMwQnlRTDFL?=
 =?utf-8?B?RGZuSHBoWVJTSmNkbDdpeUovT0ZScitQcm1hNHlYa2JDWi9VMU5wVldxTTYy?=
 =?utf-8?B?RU8raEk0d3NMeTd6KzZ5aEhXVFZqSTZTQnJtQ3lJZ3ZrUnpMR0lmTmFGeTJi?=
 =?utf-8?B?U0UvVWJNNm9PcDN2QUtINHY2RmtYOGt5d2EzbzRNcktsL0p2MUc5OHBXUDRG?=
 =?utf-8?B?bjlaTW94NU15c3ZJZVo2MlhFTnM1UkZNamJOUHZIdVhQWmY4K3R1SDBDNVpi?=
 =?utf-8?B?T2V2djFZd25rN1p6TDM5WmxjTXI4NkhnSHdXaUI4bE5NTVhZd29QMWlhRmxD?=
 =?utf-8?B?WGo0K1ozSzZSdm5TbER6bUIxUTdDWi9rRWZVVC9GVDlhazZvRU9RQ2dLMXpt?=
 =?utf-8?B?bThvMktFaEFEdG1GNkkwY3ZLRXg1eEJMTkF2UHF2UFRPM0pSbjVDRGppSjJs?=
 =?utf-8?B?eTgxTklFazFRdXNUeDlUM2JZVjl4WXZMWG9wK1c5TGJadGN4bm5yNG95N2s4?=
 =?utf-8?B?bEFCRmJ0L0NYVW1ZWndsNmNHVm00Z0F6V2U5TkhzK1ZiRWEzc1hZRWVIYTI2?=
 =?utf-8?B?dUhXVUYwekU1aTNTdzRWNmtEdlpYZ0VaaWxuNVFZSFROZVVDSi9HUjZRVElO?=
 =?utf-8?B?aHh0Um9iQWIzNENjRnhPTklCTm9mZlhMR0FDOTV2SU1YQmJsYXYwSzVYOVVK?=
 =?utf-8?B?cjhrNEtqYk50V1Z1QlN1d0VjMG9TdEFIT25tZTFKR21NQmNXNHIrZHUzejZn?=
 =?utf-8?B?Nm1XTk5HWGFMYk83cktZcEd3YW4yclQ4Z1QvczVCbC9nRjF4K1F2SzlIRmc5?=
 =?utf-8?B?T05IcGlOK3lzamgrcXhQS2lSRG43WkU5Q3RZRzhOSDlXZUpWeUVlaytHQ0Jy?=
 =?utf-8?B?dzFoTTFzK2FNYlhRUU1TRThiUVhyQ3M4Z3g5VXg4NVhSd0hPMktXay9VMFNJ?=
 =?utf-8?B?SmV0RmtpeEJsMU1ZaXJtamhIbittaWpnb0ZlVHJZTzd4a0l5VVRwbm4yZzlJ?=
 =?utf-8?B?MmJsbXVrTXl6VkZxeWd5QjEvY0FZZXJpbXJwc2p4L3l0eTliazVrRy9xWDIx?=
 =?utf-8?B?cTdLVXNMeWJFWXl0bWR5b3RxWXZaa3oyUDdoRXdqc0NuNWtEUytXSk5jNlRM?=
 =?utf-8?B?QksveVFvUzJMZG5kbkxpQVY3bHBkc0lvWEI2NTJMbW9YbzdKK0pWcWthbW1r?=
 =?utf-8?B?M0x2anhHMDk5SXVSMXM5UVdVK2VXck95Vkw3bENTaThNUHNuTTZyaXVVR2pY?=
 =?utf-8?Q?52Qt89wXQEXeiGTdbH5X/+m8OYSVJZUN+u5Xi6/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19707825-42b2-4411-7700-08d929ab0d57
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 11:54:49.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UFCG9YLVZnHiJ11ww8k5gy/eHXNHtJc0EuQezeCz7X0IHU4OjFLJVlB1o1XMovib2blx2yPAVfqBhNT35JdSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5075
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10007 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070091
X-Proofpoint-GUID: zUT-LADo6Dh3YRMP9oK4dJf4pO9Redwc
X-Proofpoint-ORIG-GUID: zUT-LADo6Dh3YRMP9oK4dJf4pO9Redwc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10007 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070091
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/6/21 9:59 pm, Eryu Guan wrote:
> On Fri, Jun 04, 2021 at 08:26:44PM +0800, Anand Jain wrote:
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
>> RFC->v1:
>>    Fix path to the supported_sectorsizes path check if the file exists.
>>    Grep the word.
>>
>>   common/rc | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 919028eff41c..baa994e33553 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1121,6 +1121,15 @@ _scratch_mkfs_blocksized()
>>       fi
>>   
>>       case $FSTYP in
>> +    btrfs)
>> +	test -f /sys/fs/btrfs/features/supported_sectorsizes || \
>> +		_notrun "Subpage sectorsize support is not found in $FSTYP"
> 
> As we're updating _scratch_mkf_blocksized, would you please unify the
> indention for the whole function to use tab instead of spaces? They're
> old code, this way we're slowly migrating old/space indention to tab.

Sure. I am sending a patch separately as the diff will too confusing to 
know what fixed.

> 
>> +
>> +	grep -q \\b$blocksize\\b /sys/fs/btrfs/features/supported_sectorsizes || \
> 
> I think grep -qw should be fine.

  Ok. I will fix this.

> 
>> +		_notrun "$FSTYP does not support sectorsize=$blocksize yet"
>> +
>> +	_scratch_mkfs $MKFS_OPTIONS --sectorsize=$blocksize
> 
> No need to specify $MKFS_OPTIONS here, _scratch_mkfs will append
> $MKFS_OPTIONS anyway.

  Thanks will update.

> 
>> +	;;
>>       xfs)
>>   	_scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize
> 
> So this $MKFS_OPTIONS isn't needed either, but that belongs to another
> patch.

  There are other FSs as well.

Thanks, Anand

> 
> Thanks,
> Eryu
> 
>>   	;;
>> -- 
>> 2.18.4

