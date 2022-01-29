Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5C04A30CE
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jan 2022 17:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352772AbiA2Qqd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Jan 2022 11:46:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60436 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233791AbiA2Qqc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Jan 2022 11:46:32 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20TCJ7J7003801;
        Sat, 29 Jan 2022 16:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MM2JyWEi3IHPkmOAThBenhVxW9TZsPw/9Y5x176887k=;
 b=DpUWKqk5cGq5e8F+vVEVInmV6JJzdxzNzJQgRHAH+cRRs8mKyLuDIw+uiNQklNkhcXpy
 QqcJGv6Vw+iN7AKIWlfJ+hpalOaGFULDnKt39U+1kM8JaBaGoS9ZOZrIlvorxr4x5a0d
 fm7Hzk9ZArE9J3g2syeSavaJ7+u45GMzRNLNjqEoidJmM5C1RjjxVrHREwb4Jm1GlQzF
 +k0rxdyJ0BsPxo0/S4ZhdUCzL6HPnyD8FBZDCzroTJNdnlY3d/tQlCTUzPlfmIHGg8Ml
 ieSYq2gIVaVswSZl+AYcvWEC8iXczICH/IZ1oYX6DfElFbbCU0Kid9KJNiuCCiqHh9k8 Ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dvw6ugue6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jan 2022 16:46:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20TGjDvh120857;
        Sat, 29 Jan 2022 16:46:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3030.oracle.com with ESMTP id 3dvtptrbs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jan 2022 16:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrgPV+A2OCagZUWaYEvmR4YBJeHFyXQNXxfudI20JitsvN4E+SdwYD6JX6c0TPMMJISbi/dW6wye0UNA9O4XccJGWhVwRB54iQRYLU8Brk36wM2wL6dPJBCNG8uURuVysOSD1Xd9cxnt0DOR/8T96+j3OidpZ8SvdPIA69uCPf1P21LkJnEb93KLqsuL2/VCnq9K2KO57zbRXWfnq3RqZX5csygPkF7ph7tyiXkaJSvoyB/ZqZgNuHcb4v3jJYsD++SS+/6b4fVP8AXcD/Zm2iGV1sotBMfXrOx+4DTFh02K+81FPvvU9o1EO9UsjfmT8dpxUt29Ka/FtH6lv56+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MM2JyWEi3IHPkmOAThBenhVxW9TZsPw/9Y5x176887k=;
 b=kWXhg9/IBI4WPZKJAjNwbTxGF35JFZT1K9f2fljZs3XtXEpDKcL/24al10DvkbvFJWFyscGa00xf53XkXXheedWu6c2CbdB6m5FQZ3avSUwPR3xgr73AY/UejaUqRrBVpefU7eXjKJlPihG4FQ/WsZFXlCvsN9vO756ECd0y/RujGNxo/PmdrMz5zAAPzRpT5DfRcjhYV7IOGnwBgypK6BundEr5kVY1R13oOHNFo1pYWu6nEE7VE5e7M5DOGLWlBaZmbOP1CVu54GrKUx9XDBdaEQEGMa1PMFXQ3RWWqmbV736SggiNcElcbN0DobY73IhHb732G2pfGHpA5d9Z0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MM2JyWEi3IHPkmOAThBenhVxW9TZsPw/9Y5x176887k=;
 b=mAO3YiMiDaSIo0CXCdoLQt6dZ+ALZR9yYuxTB9O1c5Y46bu9v7rO8x5LdVu8eqLAtnrXTgR0IQxPkRxbZ5YHkNYMznD/hs050wt6PQFcIlzWU7WEcHDz4PXC4agoihcVf0SGE6kd0XFibVKVC47j8+xDR6aVtECImYAlI2KXX8w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5150.namprd10.prod.outlook.com (2603:10b6:5:3a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 16:46:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fd17:db7:2d3b:6ec6]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fd17:db7:2d3b:6ec6%7]) with mapi id 15.20.4930.018; Sat, 29 Jan 2022
 16:46:25 +0000
Message-ID: <08748658-b139-5b41-9008-cbadea76ce5e@oracle.com>
Date:   Sun, 30 Jan 2022 00:46:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] btrfs: create chunk device type aware
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <cover.1642518245.git.anand.jain@oracle.com>
 <4ac12d6661470b18e1145f98c355bc1a93ebf214.1642518245.git.anand.jain@oracle.com>
 <20220126173838.GE14046@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220126173838.GE14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f69d692-30e8-4d26-2590-08d9e346e368
X-MS-TrafficTypeDiagnostic: DS7PR10MB5150:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB515015DC5217248D29161FA9E5239@DS7PR10MB5150.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+TuBtjpJanZfqJzXMbGd252vjUPR7kY0dgypQp4v6WfEdcd6kCNJXcYirCO8Y2O8ncqf05dA6iiYTkC7vx7cVh1vbECfu2Cx2CXdnT+tQvN3LwuNbJMB6f/W/zb1DNYaalFVDJ0Va+cV6Gl9IpmLgUwlLneE6ZWdqGZiSGKMhTpiMBNL7diLEFaM+sGtdUvsbRfmLIhexiq870potzke+hSVluwb8m0/Z9BRjsz/1RZYea645EbTyUGxXi+qfIjGTYkN5YA/nC06GsI++zMG3nOTw0Gn0a+UI7jO7pWMWjFeVrlLxvImJbb37cK70Unx20JbhnD3wVXR8EIIN5hF93Sy7mdGrc3vbVnOmmjX2WiKlqS8T52NUuR2SsLBP120dyKsDIJBDi4WOwk6kILzFxYs4EiCNEMCpXkr+58hI6wWiT9AEqLEz8ccSJE7powuI3eN2K0hLUVpK0VRkGBCy+7Zm0VUfffBXWHNj2yASFsTY6792L/+TkI1SKZQH47ZjLhzbmFA/a1Pg3bPuM8EIwLGoOa+vpuo8d/Z8PdaUN/K/bXXl6KJ6eUzdu6DbEZv7UlJQZdSbACRPirf6LyoKRwtR4ufWltaagbbmCo0I1bsFq5AZC9vN5oQofz4xDULQp7xarnVz6jk9xJMIL91KfL2CV/CJqN/gvRwwnt9MVDLeUnrmhee7KlSJogMEgYlMlkmXzhM4iMj+erCvQK97qLKKHHkXgP0r4chk9vU8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(53546011)(6666004)(6512007)(6506007)(2906002)(83380400001)(8936002)(508600001)(66946007)(66556008)(66476007)(36756003)(86362001)(5660300002)(2616005)(44832011)(6486002)(31696002)(316002)(186003)(26005)(38100700002)(8676002)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmpQOHdyUmlyWkQvaXhzZUdWSkpDM0trOFdNMHlheUhKbjcva2dLaGdjc2ZB?=
 =?utf-8?B?dEdLTzF2eEtyN3BBUVR1M29pRm42dG8wYmhoMXcxOEhjbm5ocmxkd2thbnhl?=
 =?utf-8?B?NFh3bWZCOXhQRWE5Ukk0WDVCYW9Gb3U4YzJYQTlJL3F6bHByMlZQYTUzc0dH?=
 =?utf-8?B?TC9kUkhkMkhVYUthODk5VEFLd0dqbkdkRG9mc0NhZlJQVXJrUm9WWUVBSDMy?=
 =?utf-8?B?bzdrYkdpR3AzOUpmQXgraDBKUG5ueVJNTW84RHZFTEphbFBwNjZnRWlsYzl2?=
 =?utf-8?B?aGdyZTVRNEluSisxak5BZkxUZmdtaDRpMXFwNjdodmpvejJSRjFNeWV6dUl6?=
 =?utf-8?B?cytNdHQxRTEwanh6dnNTY3ZkN2ExTFR0cWNrRG5vUTdDU0N5UXBvbGJqZU9V?=
 =?utf-8?B?SkQxcTZCZnhKZ3NOWGgyVWJvWUNrZkt0T3hteVQySDBBcGpDRERSL3YrbnJz?=
 =?utf-8?B?L3N4WVk3Q1Bsb1ZIOVV4YURNYS9XS2c4ZUVhSTdMelJjeUpveUFaQ1djNkl3?=
 =?utf-8?B?QVhVMHJhNm1OM3BWVWRoNkh2V0RvakFQemI3Ri9LNWw1clIyNGJacVFQWW9u?=
 =?utf-8?B?SWhia3lTWmdLdjhMUGorcVk3b0pNbS9nK24rbEtERjBtR1NxUUtrWjJmcTJM?=
 =?utf-8?B?TGNIUTBQQ053TzVpSXBEaU0rQ3hBc2pybUJyam9aUnZwa1BUY3NTVmtVMmJX?=
 =?utf-8?B?ekNkZTB1MTFzZ093SWJ5bWE1bm1JWnVGcnJYKzA0RnJNYUpWU0VkRWZTdkc5?=
 =?utf-8?B?MW1wSTFkQk1OeE9ZMlBMSzRnbXQ3UU9PdlNNNHpnZ1hZUWd3eTkvc05KOW00?=
 =?utf-8?B?b2FSQ291M2tCdWFvOXBVcktVZGZZcTdwbVNMMG9aeXpSQXhDR0NmYzV4NFlO?=
 =?utf-8?B?c2d1NmtNZnFtU0prUis3RDFVUjlJbFA4UUxPclNaeDVsZ1RCMnZQTGpmbFRM?=
 =?utf-8?B?K3BpOXhzZ1dnaE1zTEdEczVXMEJZc05GUDR3aDY5a2xkdEIxVGs1d01pVVNM?=
 =?utf-8?B?OGZPb0lYUEFGdkViclFpbkVwVnRHVmdxUEtGVWEzSzJ0UXM0dG9LYlZHdU9O?=
 =?utf-8?B?L2I1Q093UGdTZW44VDdaK2hSaGo4MEpsNzhENE4wUjYwS08vOUJpN1lFWTlP?=
 =?utf-8?B?Y2tJbjk5Mm9oRFpGdGNBQWJGOVRpbWhwTlF5RHNudXIxUmNsVDNtL0tpREtz?=
 =?utf-8?B?eDZob3pTaGRPYzZrcDBjaGxLa01uMGh3Mk1kSE1TRGw4cFRZdU9BZDRXNENp?=
 =?utf-8?B?THFrTkc2QzVtVllVN1dqcFlOTkF1dmorZ0lIeEk3SGRhRks4UzUwUGkyb3hl?=
 =?utf-8?B?cC9hYnhkOFoyUldES01QcU9FQS9tUTlHNW5KWVlRUS9EVlVvR1RMS0NDVXpB?=
 =?utf-8?B?cys4aXloazZDZjlsK0l5bjcyS2tvR1JVZ3NRUHEzS3VNdTdOS2xjY2ZPMEhU?=
 =?utf-8?B?c1hvMzFkdGk5UUsxRC8wUDRsNncwZW8vZjB0VlVXbjVuTmRBaWdPaVR6WU8z?=
 =?utf-8?B?OG96Rkh2SFp3NlF0MG5kNVJybEFlREJObzZ6UnVYQ2NjeWZsS3FCdGQyMEZN?=
 =?utf-8?B?WjVJTCtBL29EcUtFb3ZNMFpOZXpFTmwxcHk4RkROMnhJbk84blB3QVVKWWRY?=
 =?utf-8?B?QnVrNzJpTEJBTzM4bnVJYUdvN2drRmNDY2cwaVBvM1lXMEc5b3Z2cFZISi9j?=
 =?utf-8?B?aTNMc25abkVnMFhyYVdUUE15UnY0M2U1L0g1bHVMY1BKQkk4VHlVcXVIUDFu?=
 =?utf-8?B?VjBMU29yMU5FL1NqOC82bEFBcjZmYnBKREJBMXJaazMrelh5S2tySjFkaUNE?=
 =?utf-8?B?TmxQN3VuY2JuRUZYUkZHTVhmUTE0cG96R0Z2VnAzTEw4VzdXMktXdHJoZldM?=
 =?utf-8?B?b2I3aHl6OGZDYlVLWVJaRGJ5VUFLMm5BVVQ3bFlKZmV6UnFlMnBIZHNJcGt5?=
 =?utf-8?B?TytlYlZjMU9pU2RQbHpYajhKQVk4YVBUTWMyaHhiUzBvVGRNakxTT1FHYzVq?=
 =?utf-8?B?Vk9mQUdnTWFWWHRCNE5KT0I2bzdzME9DaHpIR05CcUFyK2dHL1NIMStEalBw?=
 =?utf-8?B?NGVBaXBIQ2JHWW9BdVBnR1hZTm5NYmI0Z2V4RzNBUGVXT0ZkeUFqbERlVW9h?=
 =?utf-8?B?eWh6MUJ3UGdFTDlZWmtvd3VaS0FKNWtIb3EvZWE1QmNaMkRLQ3NiTEZETEdQ?=
 =?utf-8?Q?0rZbMO/zjo9MEDBQRqqihAg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f69d692-30e8-4d26-2590-08d9e346e368
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 16:46:25.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUJtkI6ZXQmCZl0fHRqHu6PjE8JIYdB8brGqmoceyN/cv0SZ04t1UfdiMzPHOSy7Syp+D2dE0Xv7W6ohfjXejg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5150
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10242 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201290108
X-Proofpoint-ORIG-GUID: 4R0OrkSGaDp4yLsANX_CFu1gqD907aC6
X-Proofpoint-GUID: 4R0OrkSGaDp4yLsANX_CFu1gqD907aC6
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27/01/2022 01:38, David Sterba wrote:
> On Tue, Jan 18, 2022 at 11:18:02PM +0800, Anand Jain wrote:
>> Mixed device types configuration exist. Most commonly, HDD mixed with
>> SSD/NVME device types. This use case prefers that the data chunk
>> allocates on HDD and the metadata chunk allocates on the SSD/NVME.
>>
>> As of now, in the function gather_device_info() called from
>> btrfs_create_chunk(), we sort the devices based on unallocated space
>> only.
> 

> Yes, and this guarantees maximizing the used space for the raid
> profiles.

  Oops. Thanks for reminding me of that. More below.

>> After this patch, this function will check for mixed device types. And
>> will sort the devices based on enum btrfs_device_types. That is, sort if
>> the allocation type is metadata and reverse-sort if the allocation type
>> is data.
> 
> And this changes the above, because a small fast device can be depleted
> first.


Both sort by size or latency do _not_ help if
  given_raid.devs_max == 0 (raid0, raid5, raid6) OR given_raid.devs_max 
== num_devices.

It helps only when given_raid.devs_max != 0 and given_raid.devs_max < 
num_devices.

Sort by size does not help Single and Dup profiles.

So, if (given_raid.devs_max != 0 && given_raid.devs_max < num_devices) {

Mixed devs types with different sizes if sorted by free size:
  is pro for  raid1, raid1c3, raid1c4, raid10
  doesn't matter for single, dup

Mixed devs types with different sizes if sorted by latency:
  is pro for single and dup
  is con for raid1, raid1c3, raid1c4, raid10 (depends)
}


So,

If given_raid.devs_max == num_devices we don't need any type of sorting.

If given_raid.devs_max = 0 (raid0, raid5, raid6) we don't need any type 
of sorting.

And sort devs by latency for Single and Dup profiles only.

For rest of profiles sort devs by size only if given_raid.devs_max < 
num_devices.


>> The advantage of this method is that data/metadata allocation distribution
>> based on the device type happens automatically without any manual
>> configuration.
> 
> Yeah, but the default behaviour may not be suitable for all users so
> some policy will have to be done anyway.

  Right. If nothing is configured even when provided then also it should
  fallback to the default behaviour.

> I vaguely remember some comments regarding mixed setups, along lines
> that "if there's a fast flash device I'd rather see ENOSPC and either
> delete files or add more devices than to let everything work but with
> the risk of storing metadata on the slow devices."

  It entirely depends on the use-case. An option like following will
  solve it better:
    mount -o metadata_nospc_on_faster_devs=<use-slower-devs>|<error>

  If metadata_nospc_on_faster_devs=error is preferred then it also
  implies that data_nospc_on_slower_devs=error.

  Also, the use cases which prefer to use the error option should
  remember it is difficult to estimate the data/metadata ratio
  beforehand.

>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index da3d6d0f5bc3..77fba78555d7 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5060,6 +5060,37 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Sort the devices in its ascending order of latency value.
>> + */
>> +static int btrfs_cmp_device_latency(const void *a, const void *b)
>> +{
>> +	const struct btrfs_device_info *di_a = a;
>> +	const struct btrfs_device_info *di_b = b;
>> +	struct btrfs_device *dev_a = di_a->dev;
>> +	struct btrfs_device *dev_b = di_b->dev;
>> +
>> +	if (dev_a->dev_type > dev_b->dev_type)
>> +		return 1;
>> +	if (dev_a->dev_type < dev_b->dev_type)
>> +		return -1;
>> +	return 0;
>> +}
>> +
>> +static int btrfs_cmp_device_rev_latency(const void *a, const void *b)
>> +{
>> +	const struct btrfs_device_info *di_a = a;
>> +	const struct btrfs_device_info *di_b = b;
>> +	struct btrfs_device *dev_a = di_a->dev;
>> +	struct btrfs_device *dev_b = di_b->dev;
>> +
>> +	if (dev_a->dev_type > dev_b->dev_type)
>> +		return -1;
>> +	if (dev_a->dev_type < dev_b->dev_type)
>> +		return 1;
>> +	return 0;
>> +}
>> +
>>   /*
>>    * sort the devices in descending order by max_avail, total_avail
>>    */
>> @@ -5292,6 +5323,20 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>>   	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>>   	     btrfs_cmp_device_info, NULL);
>>   
>> +	/*
>> +	 * Sort devices by their latency. Ascending order of latency for
>> +	 * metadata and descending order of latency for the data chunks for
>> +	 * mixed device types.
>> +	 */
>> +	if (fs_devices->mixed_dev_types) {
>> +		if (ctl->type & BTRFS_BLOCK_GROUP_DATA)
>> +			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>> +			     btrfs_cmp_device_rev_latency, NULL);
>> +		else
>> +			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>> +			     btrfs_cmp_device_latency, NULL);
> 
> In case there are mixed devices the sort happens twice and because as
> implemented in kernel sort() is not stable so even if device have same
> amount of data they can get reorderd wildly. The remaingin space is
> still a factor we need to take into account to avoid ENOSPC on the chunk
> level.


I didn't get this part. How about if it is this way:

    if (mixed && metadata && (single || dup)) {
      ndevs=0
      pick all non-rotational ndevs++ with free space >= required space
      if (ndevs == 0) {
        if (user_option->metadata_nospc_on_faster_devs == error)
             return -ENOSPC;
        pick all rotational
      }
      sort-by-size-select-top
    }

    if (mixed && data && (single || dup)) {
      ndevs=0
      pick all rotational ndevs++ with free space >= required space
      if (ndevs == 0) {
        if (user_option->data_nospc_on_faster_devs == error)
             return -ENOSPC;
        pick all non-rotational
      }
      sort-by-size-select-top
    }

Thanks, Anand
