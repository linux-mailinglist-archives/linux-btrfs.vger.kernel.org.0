Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166FD2FE73E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 11:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbhAUKNB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 05:13:01 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49494 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbhAUKLn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 05:11:43 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LA8eXb124990;
        Thu, 21 Jan 2021 10:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=sU3Yy1I70qUc++mph9dQG/34nEyPsgRkIHbp5TDTKtg=;
 b=bitA0RussryxCOXX97aMlTNWqYyMKnyNPwTFZ9BWT0O18BDIKocT8hKHGUmQZc3j9p+s
 cEdx0yFO99945DwKkKDjZfKgtNNgefqqJSa7E6tJTlFRltG1Bemg+LowTDhX92a/UcAM
 WtPU8J+wy0HeW1R0b6KY1rCh18rtl+68uSp3S/VnTGeqRola44Ci2izrB0UHwfR9G3Ye
 sZK2RegP2vBUAOUy9vV/1VQ6Q6VXRGXRo+3mp08/NPAGoTCRqVI5S6w8KsB2rBG6cE/p
 ngyyEQGtnjlAkaiyEmKWT5g6cC+S9yKh13r0XiKxttCwbTXk6DNQqovuhx4lklFV7Sv7 Vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 3668qrem9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 10:10:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LA9sZl151400;
        Thu, 21 Jan 2021 10:10:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 3668rfenn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 10:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alYQo8rgU5VPRbljtV2wK5PCG9DJJPp8v/uayp7LMw6Rl4vjNbI2aqNSRrp2o3KTwCo+ZiU5XdUQrrak9SzaR2WM1oTjdAjqkGCIdDK7YcgE6dSeFJ/1Ze/hzkbRhgs246PnjLkpn28DAfZsGZns8n7PnsK4zKzabUD/Nd36A3HrWtg2OVBsLDUppi/1EXdvOwKqlrqDUca3vfgbNzGPTZVDLu07ywzz3kVBWJBxuwWjG4U15ruLzW6KdmhJuWCpWAAUQfiDbQypYrRqHQtO0B/VDfMOcuqfBdeuO93JGfzfP+BsTvf0WrdmF22CmqCXzW669OG4jSuCcwQ4tid3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU3Yy1I70qUc++mph9dQG/34nEyPsgRkIHbp5TDTKtg=;
 b=kw5IwYWhCMkGqETyLOkjpwl7/ncfnEz5NoINh6yurEftw3Ldasr/XOahfrCVYFtJ2/In2x7XmZnRMmp4cCCf3WW+7Ab+eiruYLhOw6/APuQuKC17tAw7yccp2Mla0upmclgblna/MCLstPAA/cdj7pzOAFuEWCpeA6VTnk3Mi2rb7Wn5uCkEOD7gdBWSM6zdXfFS59x6swj4Ka8FXXHRN9qWRhcre8g0ek9vi0A/sCQG8wTlkf1FjiAWQK7Jk3vZ1aBGZUqgdeFRecixJsiwxlCl9dc9knLhkJadWKhDLxCn9yBMdY8MHzYtAfw10ykBTJobDO8AR2SeMgveVobiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU3Yy1I70qUc++mph9dQG/34nEyPsgRkIHbp5TDTKtg=;
 b=P5xEIWe3ecASf16LY/gd8Z7ti9EEwKdUb9CfLQc2wZdCLjgjed7N/VADquyzfI1FWY5s60DTJ+WVQhwnqNYzzvE4Cx50MCQhq5kowwMaKFLl8w+V2sWeYRJ6edJxMjIV0Z4dWAQokgb19C3qpOXSTklUUDXgKXbNGgmKIFRE8OA=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN0PR10MB5336.namprd10.prod.outlook.com (2603:10b6:408:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 10:10:46 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3784.012; Thu, 21 Jan 2021
 10:10:46 +0000
Subject: Re: [PATCH v4 1/3] btrfs: add read_policy latency
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com
References: <cover.1611114341.git.anand.jain@oracle.com>
 <63f6f00e2ecc741efd2200c3c87b5db52c6be2fd.1611114341.git.anand.jain@oracle.com>
 <20210120121416.GX6430@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e46000d9-c2e1-ec7c-d6b1-a3bd16aa05f4@oracle.com>
Date:   Thu, 21 Jan 2021 18:10:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210120121416.GX6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR06CA0085.apcprd06.prod.outlook.com
 (2603:1096:3:14::11) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR06CA0085.apcprd06.prod.outlook.com (2603:1096:3:14::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 10:10:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f41b2ad-cf37-42eb-85dc-08d8bdf4d189
X-MS-TrafficTypeDiagnostic: BN0PR10MB5336:
X-Microsoft-Antispam-PRVS: <BN0PR10MB533613765A18BEA45CA2680CE5A10@BN0PR10MB5336.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ca5i5r6EsWLxQ2Uc3MXo9vLbJgaA0a9MuSTtUolbfG5+p93sHnVAd8Fyjp/NSY9HfNxsvMgEarqNjTCLIcwsXXAm55eZVXSAU/ZmfEAetE4jSUwytO/SBxXGgkJvEDmO4vAZqjJwoPyp/EZyAXGtZ5pVRUkZ7XoG+j4xyHfBrxGhEhRRaH6GwZYenAVMqmtXzTj5fTNlbK35wbpIVd80dxJ4YhrlPWg4msGh0puKtd5oAsG/9tfWLCYg1rZ780izGSEy9+klnGXLC0KYsWg5i7lGijbVkrNLhRGL7DKurJ+bjbLnfWtdErYXRyy3oNsnnjc9zmlo5D+FeC/1bMk8e9tXHvRdlAYjbC0K13SkbqXnV+CHv4XzmbpDpvf//5ZhRHlPNJDRmPFCDfFgu8HiNKYlTipQMcoJ7EEDFzxkxBEoEHEZlTZskHQLPRXJcWrhC85FbF3eA1eQlUT895DF1fBAjFdWJrCbgozaPvgP6Fg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(396003)(366004)(316002)(16526019)(36756003)(31696002)(31686004)(508600001)(6666004)(44832011)(2906002)(83380400001)(186003)(8676002)(86362001)(6486002)(16576012)(5660300002)(956004)(53546011)(2616005)(66556008)(26005)(8936002)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R1ZablVOSDZsZUhnSE9OVGprY3BoT2xUdm9iTzRuekVMd1hYbUtpdFFhL1lz?=
 =?utf-8?B?dFo4bGl3TmhKb0tCaThGL2xQS2VqVVFZMHBhMFc1RGhNUWdUWGZwcWtOcm93?=
 =?utf-8?B?OFBXaTlRNFhKU1lrOFJleHdwbGRXMjFmcWtDYzRrZTY1ODEzK0FOdFMwMXBu?=
 =?utf-8?B?Z25GR1lLTDFINE9nMms1SkZoU2IrdVdQVFh3a0FpbVJnS1pobkQybFcrcCtZ?=
 =?utf-8?B?ZmNxbERHdmUxU2dPeVNyK2g3U1RlbmNwNFpsRmpTTTRLeW1XOCs3MmhLS2Qz?=
 =?utf-8?B?U2xZQ29YOStadHA3RUtnUXlMK3VlbDQxN1c2U1ZJSFlPZVpSU3hOMEV5YkJN?=
 =?utf-8?B?bFpPbWlLSXg1d1g0R3ZUcE1jbTVCOHdZR3REQnFlSVpyb3Q0dnY1eGpTVEZX?=
 =?utf-8?B?QXRnTkppck1hV2VIbWdpZ1Q1bzdmdnZMVmFqMXpabW85TXVmTmNldXJGalZZ?=
 =?utf-8?B?ZmdvZkY4dWRYTEVKUGVMSGVFeWF1UVZoT2p5czYrc0Njd1d2VTlIaGJONlA3?=
 =?utf-8?B?MkRwL1U0aGp1MGQ0SlNaMUdIdGlnWDRDYy81eTRsU2lEaDk0TVh0NjBsTkI3?=
 =?utf-8?B?MTA2YmdvTUxtLzdjWURSUTdEcVNxTXVTSlFnbm4rWmMwSnFYK3dvMlFPT0xD?=
 =?utf-8?B?RVhCZUVSUngwazlTeklhMkxId2hMaUladFpaUHJMdTlSQzJRa1FjNDBSellh?=
 =?utf-8?B?czlNdGJKaElLUlhDdFdVOFJHMkVrTnp3NlJrQnBCRmY0TkZ3R3ZmYW93NHVi?=
 =?utf-8?B?aitvSUhmektYcTVmOE14TXRDVUNraGtOTjRORk5SVnRwNTI1VVZUTGYvdUxz?=
 =?utf-8?B?dFFNbWZCWitCKzhJaktiWDdpdkxEUjFNQ0RyY3d1RGZZWnNuYTJ1RUlRVzdj?=
 =?utf-8?B?cGxpaG5Hamd4dHdzTEpDa2x3VmFWb3RjUHJabzNEV1lCRVRKTEQ4UkhNVjVs?=
 =?utf-8?B?YytrUVNycksyNUxDRmUzVjdUMVBzYWtTeXJJaExaSTJTQUtQQVovTHBzUHN1?=
 =?utf-8?B?dWxtNnBxVGVUUHFhSE54WWVITW9Cci9sczBnWXorbWRsK0w4ajlpdjBvUXhs?=
 =?utf-8?B?SmFPL0J4cTZUemc4OXdPTXhpTUhMUTJZR3IxWXVjSEs1T2phN1Jab2QrZXZL?=
 =?utf-8?B?YTMvdXVaeEs0QlVKazVucUU0bEVWWVFMNy9qNzdvUDI0WnluYjhWVHpuQ2h3?=
 =?utf-8?B?ZE9QbE8vTXlDSVhtL3QxUXpIMUdBdmRqZjhOQ3pPWTNxSUp1QlFLQ25DWSsw?=
 =?utf-8?B?WTVrMUxFbFF6WXE1WEVYeE5hcWw5K3NSYkhrcEkzeWNMNm5ocVlOU3N6eHow?=
 =?utf-8?Q?Dr29eBzm9QrltDiRjHoODxFLFzflzeMe8R?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f41b2ad-cf37-42eb-85dc-08d8bdf4d189
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 10:10:46.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72fjrTf+AVPAQRlgFG9QdbSEVEwXzc+bq5IzMxQeAUQXvEkFXhaJ4XlMFTIrpYN35/uybuKIU5JcVIgnzUPPHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5336
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210053
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20/1/21 8:14 pm, David Sterba wrote:
> On Tue, Jan 19, 2021 at 11:52:05PM -0800, Anand Jain wrote:
>> The read policy type latency routes the read IO based on the historical
>> average wait-time experienced by the read IOs through the individual
>> device. This patch obtains the historical read IO stats from the kernel
>> block layer and calculates its average.
> 
> This does not say how the stripe is selected using the gathered numbers.
> Ie. what is the criteria like minimum average time, "based on" is too
> vague.
> 


Could you please add the following in the change log. Hope this will 
suffice.

----------
This patch adds new read policy Latency. This policy routes the read
I/Os based on the device's average wait time for read requests.
The average is calculated by dividing the total wait time for read
requests by the total read I/Os processed by the device.
This policy uses kernel disk stat to calculate the average, so it needs
the kernel stat to be enabled. If in case the kernel stat is disabled
the policy uses the stripe 0.
This policy can be set through the read_policy sysfs interface as shown
below.

     $ echo latency > /sys/fs/btrfs/<uuid>/read_policy
     $ cat /sys/fs/btrfs/<uuid>/read_policy
          pid [latency] device roundrobin

This policy won't persist across reboot or mount unmount recycle as of
now.

Here below are few performance test results with latency compared with 
pid policy.

raid1 fio read 500m
-----------------------------------------------------
dev types   | nvme+ssd  nvme+ssd   all-nvme  all-nvme
read type   | random    sequential random    sequential
------------+------------------------------------------
pid         | 744MiB/s  809MiB/s  2225MiB/s 2155MiB/s
latency     | 2072MiB/s 2008MiB/s  1999MiB/s 1961MiB/s


raid10 fio read 500m
-----------------------------------------------------
dev types   | nvme+ssd  nvme+ssd   all-nvme  all-nvme
read type   | random    sequential random    sequential
------------+------------------------------------------
pid         | 1282MiB/s 1427MiB/s 2152MiB/s 1969MiB/s
latency     | 2073MiB/s 1871MiB/s 1975MiB/s 1984MiB/s


raid1c3 fio read 500m
-----------------------------------------------------
dev types   | nvme+ssd  nvme+ssd   all-nvme  all-nvme
read type   | random    sequential random    sequential
------------+------------------------------------------
pid         |  973MiB/s  955MiB/s 2144MiB/s 1962MiB/s
latency     | 2005MiB/s 1924MiB/s 2083MiB/s 1980MiB/s


raid1c4 fio read 500m
-----------------------------------------------------
dev types   | nvme+ssd  nvme+ssd   all-nvme  all-nvme
read type   | random    sequential random    sequential
------------+------------------------------------------
pid         | 1204MiB/s 1221MiB/s 2065MiB/s 1878MiB/s
latency     | 1990MiB/s 1920MiB/s 1945MiB/s 1865MiB/s


In the given fio I/O workload above, it is found that there are fewer 
I/O merges in case of latency as compared to pid. So in the case of all 
homogeneous devices pid performance little better.
The latency is a better choice in the case of mixed types of devices. 
Also if any one of the devices is under performing due to intermittent 
I/Os retries, then the latency policy will automatically use the best 
available.
-----------




>> Example usage:
>>   echo "latency" > /sys/fs/btrfs/$uuid/read_policy
> 
> Do you have some sample results? I remember you posted something but it
> would be good to have that in the changelog too.

Thanks for suggesting now I have included it, as above.
Also, I can generate a patch reroll with this change log if needed.
Please, let me know.

Thanks, Anand


> 
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>> v4: For btrfs_debug_rl() use fs_info instead of
>>      device->fs_devices->fs_info.
>>
>> v3: The block layer commit 0d02129e76ed (block: merge struct block_device and
>>      struct hd_struct) has changed the first argument in the function
>>      part_stat_read_all() in 5.11-rc1. So the compilation will fail. This patch
>>      fixes it.
>>      Commit log updated.
>>
>> v2: Use btrfs_debug_rl() instead of btrfs_info_rl()
>>      It is better we have this debug until we test this on at least few
>>      hardwares.
>>      Drop the unrelated changes.
>>      Update change log.
>>
>> rfc->v1: Drop part_stat_read_all instead use part_stat_read
>>      Drop inflight
>>
>>   fs/btrfs/sysfs.c   |  3 ++-
>>   fs/btrfs/volumes.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/volumes.h |  2 ++
>>   3 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 4522a1c4cd08..7c0324fe97b2 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -915,7 +915,8 @@ static bool strmatch(const char *buffer, const char *string)
>>   	return false;
>>   }
>>   
>> -static const char * const btrfs_read_policy_name[] = { "pid" };
>> +/* Must follow the order as in enum btrfs_read_policy */
>> +static const char * const btrfs_read_policy_name[] = { "pid", "latency" };
>>   
>>   static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>>   				      struct kobj_attribute *a, char *buf)
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 62d6a890fc50..f361f1c87eb6 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/semaphore.h>
>>   #include <linux/uuid.h>
>>   #include <linux/list_sort.h>
>> +#include <linux/part_stat.h>
>>   #include "misc.h"
>>   #include "ctree.h"
>>   #include "extent_map.h"
>> @@ -5490,6 +5491,39 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
>>   	return ret;
>>   }
>>   
>> +static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
> 
> The name btrfs_find_best_stripe should be more descriptive about the
> selection criteria.
> 
>> +				  struct map_lookup *map, int first,
>> +				  int num_stripe)
>> +{
>> +	u64 est_wait = 0;
>> +	int best_stripe = 0;
>> +	int index;
>> +
>> +	for (index = first; index < first + num_stripe; index++) {
>> +		u64 read_wait;
>> +		u64 avg_wait = 0;
>> +		unsigned long read_ios;
>> +		struct btrfs_device *device = map->stripes[index].dev;
>> +
>> +		read_wait = part_stat_read(device->bdev, nsecs[READ]);
> 
> This should use STAT_READ as this is supposed to be indexing the stats
> members. READ is some generic constant with the same value.
> 
>> +		read_ios = part_stat_read(device->bdev, ios[READ]);
>> +
>> +		if (read_wait && read_ios && read_wait >= read_ios)
>> +			avg_wait = div_u64(read_wait, read_ios);
>> +		else
>> +			btrfs_debug_rl(fs_info,
>> +			"devid: %llu avg_wait ZERO read_wait %llu read_ios %lu",
>> +				       device->devid, read_wait, read_ios);
>> +
>> +		if (est_wait == 0 || est_wait > avg_wait) {
>> +			est_wait = avg_wait;
>> +			best_stripe = index;
>> +		}
>> +	}
>> +
>> +	return best_stripe;
>> +}
>> +
>>   static int find_live_mirror(struct btrfs_fs_info *fs_info,
>>   			    struct map_lookup *map, int first,
>>   			    int dev_replace_is_ongoing)
>> @@ -5519,6 +5553,10 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>>   	case BTRFS_READ_POLICY_PID:
>>   		preferred_mirror = first + (current->pid % num_stripes);
>>   		break;
>> +	case BTRFS_READ_POLICY_LATENCY:
>> +		preferred_mirror = btrfs_find_best_stripe(fs_info, map, first,
>> +							  num_stripes);
>> +		break;
>>   	}
>>   
>>   	if (dev_replace_is_ongoing &&
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 1997a4649a66..71ba1f0e93f4 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -222,6 +222,8 @@ enum btrfs_chunk_allocation_policy {
>>   enum btrfs_read_policy {
>>   	/* Use process PID to choose the stripe */
>>   	BTRFS_READ_POLICY_PID,
>> +	/* Find and use device with the lowest latency */
>> +	BTRFS_READ_POLICY_LATENCY,
>>   	BTRFS_NR_READ_POLICY,
>>   };
>>   
>> -- 
>> 2.28.0
