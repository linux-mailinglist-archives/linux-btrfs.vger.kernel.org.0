Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6032D415D1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 13:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbhIWL5F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 07:57:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14346 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240619AbhIWL5D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 07:57:03 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NBnG5g016788;
        Thu, 23 Sep 2021 11:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0dQ7uHLwv888D0XBJA+pkzkGbsDUU1dQf/oundFhLTo=;
 b=LSVwbyhu8cxqNnoMbCV29KL4SY15geEHJJ0gpl0eU4yhB5UoDpO8LwIY3XLhGolUKlCx
 /ngQjA4UbqiAoNlA1nJ52TPdl0NujEXabQRA60yGBlRjmp6Wk8NiX29b0AKtV5Htlj3h
 J8RLHlQOVzb3YPGtNDZoHy01pj8pCI1sbelZFEsPBZwQSQ436AtTHQMEyNZVc8HGkX0u
 0GMoEjNxVPZrAfMK4rHkwifnoVMpdPkOIaMvPVpwG8RTDq7GHgJcdWHt61eYo1u2iY86
 wtMwFCArizEegv3CnfajTa+korWh+kQctIya9hL8r/r9CGP3yoVr4UqSTBhnKMgdgton NA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8qvugfw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 11:55:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NBo6sv068888;
        Thu, 23 Sep 2021 11:55:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3020.oracle.com with ESMTP id 3b7q5xpvfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 11:55:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYZeYkqKEu8PEusH0MP/k75SGt3d+M51oAN49ivecZgje+6pXtueOTaHjHVwoV2xsUhWObK5PdK76J1Vxw3Tnet+TkZ/Y00m7UXhHrmy3crziLPU9qGnEMRFvVc9xC4PTGv85BNuUenIF4aqC1AM4bpD8M7eoU4+MzQthk0uIiV2xZdIfg//AjlU6zsrfURlHuea7yjSFiecg/mL/w/nBJr1cdTyHznYMyqRbK5hPQ5QLHDtJpWS9TPHW4yoHoev7I3mpqBCX/WY0W4Gxuappc8l+j8M0q2ZHDjooofw/dZYcglg5qixj8YQQPeiqzkIFAM0r4amZYBvL30dXfxDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0dQ7uHLwv888D0XBJA+pkzkGbsDUU1dQf/oundFhLTo=;
 b=ZHGfMU1mrhJdAIXHY1nBfPRx0Cn68Zn9uG62aSGeQXbtQaodiTgydjj+oBpzaY1iTSVBEXBhW92OdUNcWpPxrE1CByfM4i+TGcNlUx9zpkj3uNJRm5Y4lyOd+QTx3FAYhMNBoOWP6/QyyNerhdy9OEIrCyIvJg5CHC4i/L8SVQWbGXxhQBkRW3VtyJj1pvGgtEbOl5F2Vfkfxwd9FMJYelXVVst40THToKRCzoYz9xPhI5ch7uGd3bdN1xzEoBcPV0Zgh419rFyXy+6dSB2Ypsy2y90YqEJfootmv9AA2dE1Wqs4y8VaBTsm8WYxGgn1zOnnTKrkU0RlXGMtmmgEzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dQ7uHLwv888D0XBJA+pkzkGbsDUU1dQf/oundFhLTo=;
 b=yhDUZTPXwMI5w2BnsX/75CGzkw5U8y4+Xv1mNLiBI/7fedbKK3lMDV2mEi+pchDhjHciF5t0EnhW+WnSf+vvC5FlyJDvwl1RhACVKDqIMmK0cZazCygAEAe1J1pREMnSYNZI49DyQ03iSE00ohpZQJjQNUXFeORxfMOe8Afmikg=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4286.namprd10.prod.outlook.com (2603:10b6:208:1d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 11:55:25 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Thu, 23 Sep 2021
 11:55:25 +0000
Subject: Re: [PATCH v6 3/3] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1632179897.git.anand.jain@oracle.com>
 <ec3ecca596bf5d9de5e152942a277ab48915f0cf.1632179897.git.anand.jain@oracle.com>
 <840713c4-48ef-b4e6-91e3-f92158448b7c@suse.com>
 <0ee297d9-84f7-7450-48c4-2703b14ef697@oracle.com>
 <45f5dfee-3cb5-8645-a0b4-3f0dcb14dce5@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <9ea1c8a0-2516-164c-23d7-c57e146c067c@oracle.com>
Date:   Thu, 23 Sep 2021 19:55:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <45f5dfee-3cb5-8645-a0b4-3f0dcb14dce5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR03CA0132.apcprd03.prod.outlook.com (2603:1096:4:91::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend Transport; Thu, 23 Sep 2021 11:55:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f03c8f4a-8c71-43c8-b397-08d97e8907a3
X-MS-TrafficTypeDiagnostic: MN2PR10MB4286:
X-Microsoft-Antispam-PRVS: <MN2PR10MB42865FC46FC529990473C18CE5A39@MN2PR10MB4286.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejXxC/HzS7eV7cLOW9J+DKqz3aLUaOU6LYy3cm39V2vMC+o+tBngO90519bv+9akX6TIQGYH8zZ86FWL35Vc4ZQG41ylG2kw2dNkGl1z0U2uLbGRftKsVZHTFbsodkoPRroWHqx5XQ6yJ7bXkGqlIbH8c5o1Y+fNCDqysBeNdd3YxQr0c3J32LQGy7ndoVpKkhftdOryS7KXAA84/VKJS5YR61Zi3pERLwzJbtnqdLWXvjreyiwHQMG0bl/rY5oD9C1IyjL03cnG7etTDgU4huZ9Y6JxBr/no22A1BSm80y/rd+oYuZ+WszUwoR92lLoYEkcB86L1Bi/FpKGlsQTAFFpybP/Q85VvYKRRziNzbB5/o5HS8ongaXjh7PM1956mI8RcmHmY+Gx9LvNHm7Jh1N/4FW6mCAMcGLCLaFqUdFZvwyBEeHdWUuSNuyyPHijoqoY3635svkcGJQ+1TsWPbgOowNrLEPs5hmVRBAj7cZ1mMsrAIE+G5aEqFVuBQcdAh5RSOPtAfUgi/Oin/scs2hdYK6KYhmr4ib5OCbvsFuC56wZ0q80+OebZjBGmCPaSeNOApxRj6XkrcUWDt9ImJW7O9hgtllzYrxuVX2tMSLpVfxDWWuLDiw/HeM0/b/tBCbSs6mV1S47bmij0aj+iRf10kmaPpmYMvoHMXIv7jqNP3ctHU9f/Yz+UIbyZ/95wpkBJChDAHRCO9d6ctrBOEmG/e2WNis9BP8ZUfOcBws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(83380400001)(86362001)(4326008)(31696002)(186003)(956004)(6486002)(6916009)(66476007)(66556008)(26005)(2906002)(66946007)(53546011)(36756003)(316002)(44832011)(508600001)(16576012)(2616005)(31686004)(5660300002)(8676002)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzZuU3g2Sk9hZlVpRE1IRGVOOSt4TTVremZSWEQrT3grZ3dIdE13ZHRwQUE1?=
 =?utf-8?B?UHBDOWVZZDVWNUUydE9TY3hLWEx6NnNVWUJzdVU5QWxyUVM0bmVUUDZXLzRE?=
 =?utf-8?B?OTc3aXFMMWxreVBWc1h4NGJZV25RMm96Qm5tWGhwTHlyeFJ5Tk90MWtHVFFR?=
 =?utf-8?B?YUJaR0lDK2lxVW9PZmJIREQrL0gvWlNXb1lYQ3lXemY2Q0ZhZmsyQ2RETExJ?=
 =?utf-8?B?V1RpblRCR1VmQlFGZ3owUXE2WGMzc3J5M2J5L3Z1eVhrNWI2aFpxa255VHcx?=
 =?utf-8?B?WnR3YmVNZmJuUmV5VlI3N2IxZW1QY1Q5a2R6TmNISnpSSGRGQjVyZUllQ1Bn?=
 =?utf-8?B?T3ZaNklENDZsUUZYa2I1ek5ITG1Wczc5azlyTkFaTXRpZERkTmZGU0d5Kzl2?=
 =?utf-8?B?RTdpdmkxSStKRVlaQ1dMdTV2aDMyUWoxK0ZHTmFuY3hVYWNkeHc5RG02eFhJ?=
 =?utf-8?B?eFlPUHA5MXRBUGtmQSs2YWZTbkJhOGNlenF1OWJ4ZGR2d1RRYmg3OEp6dDZP?=
 =?utf-8?B?VHN2MWhnc0xJdndqZE5uZENYV2NlYzIvSElTMnhhbndIM2czelMvWWhVSjE0?=
 =?utf-8?B?T2VPekU0OTJDTFoxV1g5d2xLZDQ0YVNDSUxWQ3RwM2RSbjR1MCtGb0Q1OTFm?=
 =?utf-8?B?QVBsNHJmQVVsckpHUzVqQTlDZHcyVmk2Ni83ZnVwVklVUTlGdTNDcHF2eUtk?=
 =?utf-8?B?MG82VzNDYWRmdzlCZVRwRDdhektRbkNyZi9qajhRSmlNWTlnMXNHTUlYNmcx?=
 =?utf-8?B?MFk0ZGd3NFlIMVB0ZFpCeFlzSDg2cExZc1BGWG1qWU5MQ1liYmNLeXV4RExm?=
 =?utf-8?B?eWN3WUNxZldHQ0FUZmo5akcreEFDcTBtanRYQWpuTWtxOXlpbTZLTDJhdWJQ?=
 =?utf-8?B?UE91M2pkSTl2Tkp4UGE0Q09WWDBrOVZqUjBSSThSU3hHc0poOW5uMEhDNHlF?=
 =?utf-8?B?Vlk3aFRJU2E0OUNaREk1Q2tCc2ZPQjJ5a29QRFJNL1d5aEttU0U0TWNyM1Iz?=
 =?utf-8?B?L0tPczhaOWFaZExsd2p5SVNlblhoRlZVYXFOYTd0MWxrVzJYemg2UzlyT05q?=
 =?utf-8?B?ano4a2hma0ZhVWFwMFJBL3ZGWVNjVml6M21hc1ZXYTZIOXBqS2s5a1JZOTJz?=
 =?utf-8?B?Nk5JQWJmMSt3VzhTOEN5S1ZNRVZFSUhZTm4vdm4rb1BFTHZJYWNGTnBvaDdY?=
 =?utf-8?B?ZEZnU2xNL21vak8rZ3I3eXRwN1ExUk40RkZMdDhmd0Q4Z3NxdW04RkpxV0Jx?=
 =?utf-8?B?VEtOeUg1aXBpMis1RkdVN3IvM2RocnR1bmpBSDkyOEZxTEdwMkU4b3hVOFk5?=
 =?utf-8?B?ZDNQZ0JYa3RGTWNKc29xTG1YdEVNRjNsTk84SWlOa3ZxM0dPaEpXbnIxV1lE?=
 =?utf-8?B?enB4M1N4MGJQbWNYSllyVW9mdE9vaGhyZ3pVMGFydVQzbVFoLzk1TkU4ZGZt?=
 =?utf-8?B?cGdwL2xMK04yYnFQQTZOT2d3MEJQRGxzeDdKTytDYThsZ1M2bHNaYmdPTGdJ?=
 =?utf-8?B?RFdyTjRKUHpibktLbFdweGV4UUtrL1BWeUNRZ0tZUm1jR2VrYmYxa2t1aTNW?=
 =?utf-8?B?OWVqSldiMVcvY3p3L0VpY2pqVUdlbzNUdHVZM1BYMUZzdW5sSWdlamlUUFJ3?=
 =?utf-8?B?QjJodldyVmticFJRcEJGTzVpRk5QelArK2tFak95bUVndUpqcUZlSG1lbktx?=
 =?utf-8?B?ZUVxRHZ5K0FhQ0hDNU5wRG4yTDhhdkwwZE5vS0haUFBIS0pGRER1VEgwY3BN?=
 =?utf-8?Q?PAfIG3wdje2cAyQk2SluKT5lpjhm4v6FyghMZyn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03c8f4a-8c71-43c8-b397-08d97e8907a3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 11:55:25.4837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2D1qCAqAuSo+fUqVYefwWi5rINpIDHxmYxWrHBcWLXu3mQJh8+q5EQtwYwpZiAwV4vbzlk/DvF/NT64AZHVnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4286
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109230074
X-Proofpoint-ORIG-GUID: -qrcQurTtXy5EpJMfj-TWIqERvzidchy
X-Proofpoint-GUID: -qrcQurTtXy5EpJMfj-TWIqERvzidchy
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23/09/2021 14:52, Nikolay Borisov wrote:
> 
> 
> On 22.09.21 г. 14:41, Anand Jain wrote:
> 
> <snip>
> 
>>>> @@ -2419,7 +2414,23 @@ static int btrfs_prepare_sprout(struct
>>>> btrfs_fs_info *fs_info)
>>>>        INIT_LIST_HEAD(&seed_devices->devices);
>>>>        INIT_LIST_HEAD(&seed_devices->alloc_list);
>>>>    -    mutex_lock(&fs_devices->device_list_mutex);
>>>> +    *seed_devices_ret = seed_devices;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Splice seed devices into the sprout fs_devices.
>>>> + * Generate a new fsid for the sprouted readwrite btrfs.
>>>> + */
>>>> +static void btrfs_splice_sprout(struct btrfs_fs_info *fs_info,
>>>> +                struct btrfs_fs_devices *seed_devices)
>>>> +{
>>>
>>> This function is missing a lockdep_assert_held annotation and it depends
>>> on the device_list_mutex being held.
>>
>>   You mean
>>      lockdep_assert_held(&device_list_mutex);
>>   and not
>>      lockdep_assert_held(&uuid_mutex);
>>   right?
> 
> I meant that the new function - btrfs_splice_sprout doesn't have any
> lockdep annotation, and based on the old code it depends on
> device_list_mutex being locked. This is based on the following hunk in
> btrfs_init_new_device:
> 
> +	mutex_lock(&fs_devices->device_list_mutex);
> +	if (seeding_dev) {
> +		btrfs_splice_sprout(fs_info, seed_devices);
> 
> The way I understand this is btrfs_splice_sprout indeed requires
> device_list_mutex being locked, no?

  Yes it requires both uuid_mutex and device_list_mutex. I will add.
  With comments.

Thx.


>>> However looking at the resulting code it doesn't look good, because
>>> btrfs_splice_sporut suggests you simply add the seed device to a bunch
>>> of places, yet looking at the function's body it's evident it actually
>>> finishes some parts of the initialization, changes the uuid of the
>>> fs_devices. I'm not convinced it really makes the code better or at the
>>> very least the 'splice_sprout' needs to be changed, because splicing is
>>> a minot part of what this function really does.
>>
>> The purpose of the split of btrfs_prepare_sprout() was to use a common
>> device_list_mutex. So I tend to avoid any other changes, but I think I
>> will do it now based on the comments.
>>
>> Thanks, Anand
>>>
>>>
>>> <snip>
>>>
>>
