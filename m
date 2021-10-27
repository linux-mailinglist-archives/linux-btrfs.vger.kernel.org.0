Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CF143C3AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 09:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbhJ0HVw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 03:21:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13074 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230308AbhJ0HVv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 03:21:51 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QN9pW7030681;
        Wed, 27 Oct 2021 00:19:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=o5tdnewnHpmDMkyBMBOmvsKf+1LtYbSZ0D1UnXJRhKo=;
 b=p57Nu5Bnzb0ETDkZ7dIv0lshFUlRvgZ+rrXbOHNzNy3AERrnf5KCaY+7V/HBdE3TF5/X
 7oxcWrqE2x17JWHvgCjrvJWcmcqKoWnjTBH6TJgIHQpSd6qUnjd3CEXF8Vko1290IaWw
 xOnOU7y7BqAM8l/Y4gvsO5LczormZDgEhG0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bxkx5nvy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Oct 2021 00:19:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 27 Oct 2021 00:19:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6JJkaY1qrxpZ+m4fFky2NHcaSj1e2a5DmFPi2xj+HfVYkkSfbu5DK11sCl/xzz1/av7Y31PAAvbWg45vmj0PMrqkE9yX4u57jxHyB6Gws0JqoP2Bbr35TYq7P6Za9o7m9jf4uRk+xXEyP3f0KYDdxQV8prjkjq5dm7awvsSBOz2/jjLLgEtIeEXlJhmkdjTw2j5QCq5VXeALP3yrx1BSOsMmmXySJNiNkE0rVJHwDelCBaN49xwIIn8Oc0bprC4qmBxBPZpwxUDwYsfySQhrw9I1pQ8ussnXEEI4aRPETuf0UOJ91K1qhIiVfyMom63jkz8lTtYOd9tinfyVI9wmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5tdnewnHpmDMkyBMBOmvsKf+1LtYbSZ0D1UnXJRhKo=;
 b=KCCSqDEmt1MXWfflRy8slvLH9G5Uuf9A1whPnQZBCYGL9v8/h/9WlIL3q2PiAKgKEvRW0a4prMRy0sSadydeexkZxyJrXVyCKJG7gTTGTLNLm8p6rzf/1+LMGIqq2baATGFHsUpL9P8oGqBiQiz/hOxF8epCrVSMCxetIjkEVs9NEZR5SR/gTyEcSnGi1zU1DDEKOFWCsSyouFJwgGOnBzXtkF+rLJcZH81pb7eIzxVCdjFvxwBGHjbKOY7+Tq+CQs2xOnmLbAxp0e45VGTiBUIM9t49SFqxZqiuE4CCuwJi8BHVY033p2CXb5wg+/Gti3qLAq6z8s+8694WY6MQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=fb.com;
Received: from PH0PR15MB4413.namprd15.prod.outlook.com (2603:10b6:510:9f::16)
 by PH0PR15MB4927.namprd15.prod.outlook.com (2603:10b6:510:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 07:19:24 +0000
Received: from PH0PR15MB4413.namprd15.prod.outlook.com
 ([fe80::5dd9:c42e:aceb:c3b7]) by PH0PR15MB4413.namprd15.prod.outlook.com
 ([fe80::5dd9:c42e:aceb:c3b7%4]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 07:19:24 +0000
Message-ID: <44bf1de4-53fd-74e8-a204-ce12e33722c5@fb.com>
Date:   Wed, 27 Oct 2021 00:19:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH] btrfs: sysfs: set / query btrfs stripe size
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20211026165915.553834-1-shr@fb.com>
 <PH0PR04MB74165B2A0D395AD9A45310C79B859@PH0PR04MB7416.namprd04.prod.outlook.com>
 <9a0a442c-8409-3401-da85-9032259a7bc5@opensource.wdc.com>
 <285f0f7f-a2df-7f23-2ba3-8ad3c12293ad@fb.com>
 <PH0PR04MB74165DE04219D13232F3D9CE9B859@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <PH0PR04MB74165DE04219D13232F3D9CE9B859@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::7) To PH0PR15MB4413.namprd15.prod.outlook.com
 (2603:10b6:510:9f::16)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c9::149c] (2620:10d:c091:480::1:2e6c) by BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 07:19:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bc8a2a0-870b-48c3-b2c5-08d9991a1aa3
X-MS-TrafficTypeDiagnostic: PH0PR15MB4927:
X-Microsoft-Antispam-PRVS: <PH0PR15MB492798B9451A452AE2CD97CAD8859@PH0PR15MB4927.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6k46Pp0IDZ77FxFddWb3eCBz8DKu1e6t7yCMX4wvYKA2eBc4MDeypimGqA4LWivZUBHiw2MgYtnkjRZOm3nel+ytQ8vPTs1o21jb9xqx3MQS5/SNacD85sUd4pHtnlHkUh4ImSp2HpYl5kpfx4kuFtEcFD62xQ4T8lCOYhSaxg57OD34fVVLfVMTu43El7quqv2UPDDno9ksAWWHwKtwrRn+GVF/kZFPi/+GcfeeFe0CEDtZnRgNvKhXocgeTbvt5HTOxpuM7Lbi7W8IwEXbynnXOIZOM/Uze0ehfZm+yk0hiH7U/3WG3v0HDM8AotOMAPthe322JtxOOMD/anEGwkOzHLn15NILUA1SHc9ZwHyAYu2CS/pmXt/t7RvCDQ/tHConG345Edmp7xoSMEFHo+IuxllXvkS9piWVjoqqyxC6WLNGCzlDnXIuqH8j4m4d95ri5Zt8IYSifNoipRgnvFNU+yN+4tUMkE65j6rzIgwsHvbdF7r+elSYePU6leCwUynDydlz8F9cN2LXVUOJbfqKiC3V5KEnXGtxZgnUalB9BnUaJKtS8e62FOerO49jH/wkQ1GEBBkUenkw0EL0Ba3xqIUayeMp/1v0MW5m4GtsUxHLwsrX4cyG5UedB8uhHZPy48KsYqkp9I5N4ppN8vAdsNXqCzYtR2+FoOYwiS0PLdd7Ma/TrTUVzmnRbd+bEvEuBK0H3PRHfPq+9bVuINq0PoDbPFZ7w3L4oewjb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB4413.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66556008)(66476007)(66946007)(6486002)(53546011)(31686004)(4326008)(36756003)(508600001)(86362001)(38100700002)(31696002)(110136005)(8936002)(6636002)(316002)(2906002)(83380400001)(186003)(5660300002)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODFBVGdoVDc1N0pWOWFXdUIxbGVzZ09WVjRDK242U1pkQ29iVmhnQjdtdC9B?=
 =?utf-8?B?N1JkUEVjdFZuK3AyVVFsWExvakNuVHI2b0R6RU5mUzd5YmR2VC9jZEMrc2xo?=
 =?utf-8?B?ejFqd0d5M0tCR3FiaU1HcTZXZi9zanZSVUZIbUlIQ214bkxSVm5iQitkVndU?=
 =?utf-8?B?YnhLdkRoNEFCN0ptd3pYOW5nU0VLQWt5KzVVR1B5eTVZNVRGc3BBeEJQN3Nt?=
 =?utf-8?B?emgvOUpuQUpsRHkxejAyaWdmbjFYZ3pTeUpsa0JNZUJOSVhqREIwdjdlcnVw?=
 =?utf-8?B?QmRXWFFJTHM1NnR0SUY0Y1dBZVl4T0YyblI0L29qWXloVHBKSUVGdzliVlRu?=
 =?utf-8?B?MXVGZUgyQm8wTGdsRWJQREZiZzlqWnRYRE44c3kzTFpkakpGbEFXU2I3dVhG?=
 =?utf-8?B?dVlDU0ZGYmVjREFqeVVsQ1Zwa00zWmZsa0NkaUIxV2xmQng2azQ2eHJneENj?=
 =?utf-8?B?Mksyc0pvcmlIMnlJU28zVDhYdVlOZTVWcDRIN0pybFlKU0F5MXV0dCtaeFZR?=
 =?utf-8?B?c1FVcTM4QXo5TGNUVGRhVE1yWkJ0ZkpyVDh3NTNrTCtwMExvazN6V0MxNTRm?=
 =?utf-8?B?ajdGU09rSk5NMUVPSW1BM1d6Um5YR0JGNzM0L243cGZLb2FPMXB6Q3JudUt4?=
 =?utf-8?B?cnZnRWZtRVJhUGFLK20wMGxXcWx5YkRUNWZuMG0yNHJFMGtGSXJUWXRoYnhz?=
 =?utf-8?B?SWxhQ0YrK0NLT1VrQXovY3pNYUl2Q3d3dVc3WWt0QlY0SHlHckRCNWwwOG9z?=
 =?utf-8?B?YjV4bXk0dUJiSldiZVFKU3V1dktlSDNtb0ZtK2xVaFl4S1dWUEM3YnU5YUt5?=
 =?utf-8?B?UXhFR3NjVDFmLzUxQWlHR3VubXZUZ3BqcDk5MS9FVyt3aTRHNkI1dUV0ZFBp?=
 =?utf-8?B?MUNES0h4enkwL2hDamRSZEsvSWFiWk5meTZnMTRaOHQrMWRlOVpsc0czTTBv?=
 =?utf-8?B?dGdscjJSTk13Z3p0QWZud1h4Q1gzblBpY2dSazMwRzJSTHVFSmZQNHJhSFJv?=
 =?utf-8?B?dURHaGFjSWRHYWR6ZHZMNURCNE9WSmYvQ3M2dkN0R2U5STg2VjdCY05WSGVp?=
 =?utf-8?B?WkszbmFENVJKR0l6SFBCTnQrRElBYVFxZlZLTEVHNXRtUEVSbjJrVVpBdVhC?=
 =?utf-8?B?M3l0RjhrYzVRNFVZeFd1czRzc1VMTzZCWE1lUFVHdTdHOHBOZHRXMm1paENk?=
 =?utf-8?B?SHBGVkF4MEM0b0Nqd202QkZFY0Zvc0VCaFN5cnkrK2NjN2dJc1JVb0FvaFdq?=
 =?utf-8?B?ZysvTWhCWUtmUHFxOFFpOEsyYUFwZ1h1d1Zabjd4aSs1N2lJY2ZhT2pVdE9W?=
 =?utf-8?B?SksvMEhSaDdTM1BrdHVjTVprVmdRWEdteDlzQU5DeWwwdHYxbENjT1Z0UXNW?=
 =?utf-8?B?aS8yRTJPWVczKzNHY3duaXdxSFBxUGw2NWZsTzNRNkRNZ2V2UUFsNjRkQ2hE?=
 =?utf-8?B?SjZ2eGphU3Uvc3dGTGViSTZ0dGxlTUhoWDNEZ21zSUNpMzlkb2VoY1hUQjJj?=
 =?utf-8?B?WWhyU3ZyeE5HU0F1bi9jNUZoK2NaUDF0Slk2enZpUFdydVMxOEdWMTlKdzk4?=
 =?utf-8?B?eDdOZStKUTdVa1JjRHV6TFFvdVFEOG9ZV3RlVXZHTDB3eTI4WDFtNWM5MXdD?=
 =?utf-8?B?U3luKzAvdzBuWmp2WENmNHB4WER1RVpnOW4raVB5S1FJbWkySndpN1UrdmV5?=
 =?utf-8?B?ZXV3NFFJVEdEOE5yTFkvNTNZam1Ia0lBSCtmbURFUVNCd1laZ2ZtaHFROHo4?=
 =?utf-8?B?WjcrSm9rdGJrWXdiUXlQcHMvTWxPUUQwZU5QTHlyZWpBa1FyZkpxSG5FQzcx?=
 =?utf-8?B?akw2YU9hMXNDaEwvRjdKd1QrMmkrVC9rWncvYWprN2o4TjVOTFhlU2JxRENL?=
 =?utf-8?B?QnAvYVZYREpBTGlmS2pMbHI0Z1pFV1dGbnlqL04wVE1TMzlGUmVOMFpVbTN3?=
 =?utf-8?B?bGsvSVVVVUF0TWJBdkdsRHhhL1dEaWJrQkMzcTMwemRQaVZZdFJ1VnUzMUM1?=
 =?utf-8?B?N2pZNk03VlhHaXBtMWZEeEkyL3BVTkhGMGh0Z1pvT2xYRFMwL2NuVTA0R05t?=
 =?utf-8?B?YUdFV2g2ZFhEZ1JFNisxMmUybUZoQUczSklHb3dSMHZGQTIxUnB5M1prNndK?=
 =?utf-8?Q?RVvEjWbARyiqAqSVg8DdVsE4+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc8a2a0-870b-48c3-b2c5-08d9991a1aa3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB4413.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 07:19:24.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufTXgD4LJJro9Cha7zSZsl9iL6KzHWId9FMGZd50ljCK18jflGTwJSfnvqrjFQBq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4927
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 9yHgMSpx6VaHaYrWSU7YmlIn27ISC6D0
X-Proofpoint-GUID: 9yHgMSpx6VaHaYrWSU7YmlIn27ISC6D0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_02,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270043
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/27/21 12:09 AM, Johannes Thumshirn wrote:
> On 27/10/2021 08:59, Stefan Roesch wrote:
> [...]
>>>> static ssize_t btrfs_stripe_size_show(struct kobject *kobj,
>>>> 				struct kobj_attribute *a, char *buf)
>>>>
>>>> {
>>>> 	struct btrfs_space_info *sinfo = to_space_info(kobj);
>>>> 	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
>>>> 	u64 max_stripe_size;
>>>>
>>>> 	spin_lock(&sinfo->lock);
>>>> 	if (btrfs_is_zoned(fs_info))
>>>> 		max_stripe_size = fs_info->zone_size;
>>>> 	else
>>>> 		max_stripe_size = sinfo->max_stripe_size;
>>>> 	spin_unlock(&sinfo->lock);
>>>
>>> This will not work once we have stripped zoned volume though, won't it ?
>>> Why is not max_stripe_size set to zone size for a simple zoned btrfs volume ?
>>>
>>
>> My intention was to not support zoned volumes with this patch. However I missed 
>> the correct check in the function btrfs_stripe_size_show. The intent was to return
>> -EINVAL for zoned volumes. 
>>
>> Any thoughts?
> 
> Hi Stefan,
> 
> struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
> 
> if (btrfs_is_zoned(fs_info))
> 	return -EINVAL;
> 
> But why not just set the correct values for a zoned dev and show them?
> You can still not allow setting new values.
> 

The code you proposed above is what I already have in my local commit.
I can change the code to initialize the stripe size to use the zone size
for zoned volumes. Then we don't need the above if clause. 

Damien mentioned that this should only be done for simple zoned btrfs volumes.
How do I find out if this is a simple zoned volume?

