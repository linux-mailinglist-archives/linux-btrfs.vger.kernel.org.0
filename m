Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5294A3085
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jan 2022 17:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352429AbiA2QYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Jan 2022 11:24:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20082 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352390AbiA2QYe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Jan 2022 11:24:34 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20TCHdZi004155;
        Sat, 29 Jan 2022 16:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BZKDGF6TWWA1v8LhF1bKSGuj+Cclk4fLVb0D1iNnGAg=;
 b=xUFFBkpFyUyN/EzXYWznwepgcndBZy6foR6Te7h+e4WBzcVACvwIUjclSaXYuszDiR4m
 chNqgZNtXFJLsVUSEULlptp9ugwRqrMTaHFg3Cx0jiC6nNB8hXFNYjV0RNPjyZVc6RSj
 2yZGAyFoaeiXRxiV1ZIrhHok/BMfExZ7DFLer3OmQtpfnu6ljJpV8E6sHOIMgeam8YdE
 RyX35UmRQZE6SIvk8e+HTi154PKBO93eiO9M5gdO6PJVmsLletUp95qhrmo+cuvuxRZD
 j6X/Eh70mu+/mem/1PoSc2KFlIgscp9PATGH/nJJse1WAomwTc/zpSA6a+dZaRxEKECx /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dvw6ugtqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jan 2022 16:24:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20TGA1Ok067569;
        Sat, 29 Jan 2022 16:24:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3020.oracle.com with ESMTP id 3dvy1hdrru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jan 2022 16:24:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU1Jal7DmSwLzOxa1rfMfr58xOZ5TlGm3BCYFhyIaqM8P3aV5l/MXeBHDO0XEZiPCx0hCD9m6B8BYXhKy/3ZywVSbk1SUcrsqhpttEG2KflaFDf0t3+O7ZZP/ij47d1TiiMxlM8Jmpwu+ZVKskORtiRWY3B+468yzYm81TJZLtOlQ/H1viP696PN37oDud1ybW61BnEzLWzUYAKs0y53aT5iaLmV3dnyMp4kCRQiFW9dlVbQuNucKt8UGPaChNiPt/C1sa/vJtoh8+kETKoVubVmW47KKu+kudsYgf+/yFN8X6M48nHrE/H/AmrbLumUyAycKp8o7iwHiisILpxR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZKDGF6TWWA1v8LhF1bKSGuj+Cclk4fLVb0D1iNnGAg=;
 b=dNABUPwu8WNQRInUbFQNWNhWbBEbY5/xTQ+IPxaCFCwBCqtdYK0typSDHbHg5lnzI/eBJFnPgC49hL2ovXK4I117Kkp+ftTxhfZvqj1rkHhTtG3+wPCeJW+ggPyQiiTQ6pA3t+szXxA287hbnYYWii8D0MPYJUewEGJUlPkhybJuhaRtTVIh0jNsAbHNhnetUAsKOt9G7GunzFljPNhKBGum6+iLviF2+f9+PsRpi+SHq0iXkqRUZ8ZO/J0YOgxvorNqveC/vAmX8pFeM85OIM1IVGk3h/AeY2FqRa5VEYSUXrjbPkANkxYKJ8gAqs2nJFCJ0osLpsKDfHs3i+QQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZKDGF6TWWA1v8LhF1bKSGuj+Cclk4fLVb0D1iNnGAg=;
 b=Z2Rqr/CHJb+j792F9a8RFl502lXJQD0zm6ROouhzdBjDhL4bjMZj64WixwesucU4XWmrj6VITJqOiYF/SXRUXOD6CHonub9mWIDtPRQj4tNvpMpZ3qeKKvl4dgK+1P+7+lhx6GZVBOk85mZEiiF9rqgZ6A5qQGRpf6Nv2DYPP0s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MWHPR10MB2031.namprd10.prod.outlook.com (2603:10b6:300:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 16:24:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fd17:db7:2d3b:6ec6]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fd17:db7:2d3b:6ec6%7]) with mapi id 15.20.4930.018; Sat, 29 Jan 2022
 16:24:26 +0000
Message-ID: <e412efb6-7ea2-cfd2-5c5e-cbe4fdde5c53@oracle.com>
Date:   Sun, 30 Jan 2022 00:24:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 1/2] btrfs: keep device type in the struct btrfs_device
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <cover.1642518245.git.anand.jain@oracle.com>
 <c815946b0b05990230e9342cc50da3d146268b65.1642518245.git.anand.jain@oracle.com>
 <20220126165302.GC14046@twin.jikos.cz>
Content-Language: en-US
In-Reply-To: <20220126165302.GC14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0147.apcprd04.prod.outlook.com
 (2603:1096:3:16::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74f2e899-144f-451b-8bc9-08d9e343d0d3
X-MS-TrafficTypeDiagnostic: MWHPR10MB2031:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB2031C76F0FE74C415AB009CEE5239@MWHPR10MB2031.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmK0WfxaFWk8R5BEthSM8qz+DWExQgBCX2VTvnh/8BqgEqOq/ECZ6eNrSndQUsxVQIvFoKLC4evOnB+9vPRz5unOxKX41hNHG037XrS16DGE8u98CXPgcmMOFhSN2qyHWav6m3bdHAYrp9hU87O5CGRY6X+AOAlOKqMkTPQce5F1GrOUm40iJrkn+JzEKzGmW7YDdr0uUy3LJGEXlG7LG89RB/2gDQXR/V5jsb4/dtAJrd5dgkMtJgnxYGCMAlEtWD11v6aq5Kx3ca5/9OY9SG1ST6vWEUykjFdWRHsQ5QqprIElTjYA6X400fR9sv1csH8u4Jni34mLOIfCw69d4efxfFJ5rif5SbNBpLKwGNxdf1P8gctJsAC9YHm+2Tq1wSihXSSj1V1RVQQI/CVlghXdAZaFuo7/F1BWrmad0w5rxJBBN5gvKdEvycxF42GKCRUX97MYN/+AKCGtGGPH5MbJHdkiaecvhgnKw5a6QLNV8vXIo53wM1EESRcfArPudI4gk1U/eCZlijO9jqWbAJnotM8INwJaYC0Ym5c4NqxTAY1xhPbOH54le4diH8kgUX5HXgtsyas5Lw+IVziEhUblugHm1nBQA82UVpwd28U+xJ3J3//+Z+kgE8jEbnQS1Y0K31JJNYb9flw9AY2moQh9M5bfCaiAz4RE3MyUSYtwpRXMiwl5EkuZb1J2vUnihQ8poeUiXaHrARBI7gKxynhqHRBFrHtKTwogzH86opk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(5660300002)(66476007)(31696002)(8676002)(44832011)(2906002)(8936002)(316002)(38100700002)(36756003)(26005)(6512007)(186003)(86362001)(508600001)(2616005)(31686004)(53546011)(6666004)(83380400001)(6506007)(6486002)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW9tT2pwU3pBOHJhZ3BDejBkYS84YVhjcndjaTlyVHFwaUsvRFRvc1NtaHVp?=
 =?utf-8?B?aWdsaWhLczZFZExtRk1OUk9OZVpmRE40YzJOa2lMSmg5eTVaRTBNQmM4dTZh?=
 =?utf-8?B?ZzYzVDRSY1FIT3AvRXRURXpIc1RPMkhxRTBFbDBFdnpycWFTcjV0bjZpeEp5?=
 =?utf-8?B?N0x5Q0lsZ2Z0SU9qTGlwWk4zR2d3aEpSY21PVTlkbnVxZFAyRk9lUWpVUWZS?=
 =?utf-8?B?STB1WmF1UVplSWl1amtYL3h4RUFCZkQwMitlODRtQ1dETytPL2FuRElWWGNX?=
 =?utf-8?B?L0dCa3RCN0VnYVphYWw3cjlKVmdDQmFldTlyQ1BMeU5ESmR4UFVVazkvUmlT?=
 =?utf-8?B?dVZFb1NGNG9rN3dwazdxZWswZk0rTVhLVy9GbU1WZXNNTU9mVkUySm1OWC9u?=
 =?utf-8?B?V0FGZTd0K2h0K2p3NE04bDd4eEFUU0t3MHpHK3IxY3Q0cktuekhXSjNMcEM3?=
 =?utf-8?B?WXBuZFg3bU43UnFGd2Q5TkRpVzRYcHhYVzYvMmEwUlB3WlBJckl5dWpPRzVi?=
 =?utf-8?B?RnMrb2lFc09lSGZsdUtEWDErNCtodWd4RWh2R2IyRWVkN2JZcm1CRlVrZ2Rr?=
 =?utf-8?B?Umo3d2wyN1RSRkFwMHZjcnBwYk9kckE5OGtwdjUzWVdvTmhSNTRMYVdUTSsz?=
 =?utf-8?B?Nk43a2xIZ0ZzUnBrdXk3OFJuVmt5L3QrSVd5cnZTZEtnNWVPMUxaTW9Rc012?=
 =?utf-8?B?VWZ0eVF1LzlvZDF5QjNPaE5ZUGZHZGwyRGlMWDJCdlNQOExTenpwVURzVmZy?=
 =?utf-8?B?Z2MwVnpoQ1Z4cVBHYkFQbXNTTVM2MHZiNXpMeUpzem1raE5OOUl3YzhHSlRz?=
 =?utf-8?B?WEt5S296RE50U0RFTFNoWXV5MURxUEYyRWtScFdhQlpNOWZKa0JWTVlNT2dF?=
 =?utf-8?B?alg0ZHhrVmloaGVFUUpjQVhIeGw4VEJLSnF2ekk3NVJZQStVTCtKRk11Y3pu?=
 =?utf-8?B?UWhxQW5wakpaT0V1NGhaT1k3Vm1tYTdMR3p2T1VDaG1ML3JjTnBmWmZ5dS95?=
 =?utf-8?B?dnhqVmdyQTZEK0IwK2VWQWZZMEovdHZrZEJyNDUyLzZrQW45a1RNUitHZnM3?=
 =?utf-8?B?eVFwU0xSVzBYQkNvbjJpa2xsZ0ltQ1luT283U1hIc0o3UFRJQm93L2dwb1Nz?=
 =?utf-8?B?bWYxTG1ZajdTZTQ2Mis0YzQrVERFREZCZ3N6VHJHUkFYaU51Ym85T3JwVmJU?=
 =?utf-8?B?dldnaEZRTldBMkZOWG9RUnNaZExreU9LSTRHdGhCUjZmTTR2Wm9IUUxBR2ho?=
 =?utf-8?B?c014YTF5a3NodUhvVE9wY2hreDZkYW05REFtZXNEZW9rMk9KQjdmb0NQTGRH?=
 =?utf-8?B?TFAwdG5zNUdvNUMzeVBTZ0dZOGZYRHR4M0Fabm0yRlEvaHExZ1gvcjJFTmk5?=
 =?utf-8?B?M0xVVlVFZ2kybDdDK2F0NHpkZHI3SElTRGJSYU0yaUsweDdhVkpERDhTQ3F1?=
 =?utf-8?B?N3F1S1dibVZuYy82cGovWGFUMmFldVBaeDdZYTI2cWxrdjdER0l6NEk2T3pp?=
 =?utf-8?B?ekgyRmw0SVg1b0hDZ0w1WWVuSXFyQzg3UzZ0UmV0VlJwbFZqNlJEbkhiWEJC?=
 =?utf-8?B?ZWR6cVQ5L1JZbUlIRFJhbTV4V3ovQVhyVWFKaXNGYmFMdEt6bGR3eDVobitx?=
 =?utf-8?B?cDF6b3lSSTlzejFWMU4rUXhnT2JES0FnMlRCeVZIaW40Y1BNMzN2MUc0OHdE?=
 =?utf-8?B?c05NMG45aVVjLy9LNzd4blpicHVJSDFYSGM0OU4ydW5KcUwvUW1rb0V0TnZJ?=
 =?utf-8?B?RjhrUUp6Z0o4RVhxWTB5UTQrZ3dBZEtnUGZIbzFsRzMwRHhKZUt2YWJZVUQ3?=
 =?utf-8?B?R3RMRCtDdHpuYVRCSzZXKzR1TkRvTXpIUEtMUzdva2h5YzlGdE1qNnF0aGFF?=
 =?utf-8?B?SW16VjVZdnU4WnFBbnJhclgremFpSEhtQWdabkw1NDFBYWFEMGRLd3hzZHZF?=
 =?utf-8?B?aTRWMngxVWJjR0pOdlc5TFFSc2Zjb0hER0ljMWk3Z0c0SDNxMndzQkZQUWlH?=
 =?utf-8?B?S2pGcTJpR2NDSm1EVnFKUldEMFVhR3lndW9vOHg3WUtjbzlXeklCUFpHYmxJ?=
 =?utf-8?B?ek0vQ1VmdmdTVSszbXE3RWkyMmprb3E4d2ZhY3BybEFaRWt3aTdYRXRKSW9K?=
 =?utf-8?B?b2ZUWnJVUWgxNDAxMzlHU3I2KzI1czFiaEZsMUlEUzBoNjJ6cXhsZUsrTWti?=
 =?utf-8?Q?oSJGf0/jSdcmemUvsB4mrBM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f2e899-144f-451b-8bc9-08d9e343d0d3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 16:24:25.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKdjiNEVON90M34VjJeJTFR9CifBNwbDFo0OySCyiaBWEiBJcdFuzhEDfZIi9V6SKjYfK09u3vGeXiqa/U93Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2031
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10242 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201290105
X-Proofpoint-ORIG-GUID: Ql5xmbB47sT9yJ30dMslgxquEhf0y71N
X-Proofpoint-GUID: Ql5xmbB47sT9yJ30dMslgxquEhf0y71N
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27/01/2022 00:53, David Sterba wrote:
> On Tue, Jan 18, 2022 at 11:18:01PM +0800, Anand Jain wrote:
>> Preparation to make data/metadata chunks allocations based on the device
>> types- keep the identified device type in the struct btrfs_device.
>>
>> This patch adds a member 'dev_type' to hold the defined device types in
>> the struct btrfs_devices.
>>
>> Also, add a helper function and a struct btrfs_fs_devices member
>> 'mixed_dev_type' to know if the filesystem contains the mixed device
>> types.
>>
>> Struct btrfs_device has an existing member 'type' that stages and writes
>> back to the on-disk format. This patch does not use it. As just an
>> in-memory only data will suffice the requirement here.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/dev-replace.c |  2 ++
>>   fs/btrfs/volumes.c     | 45 ++++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/volumes.h     | 26 +++++++++++++++++++++++-
>>   3 files changed, 72 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
>> index 71fd99b48283..3731c7d1c6b7 100644
>> --- a/fs/btrfs/dev-replace.c
>> +++ b/fs/btrfs/dev-replace.c
>> @@ -325,6 +325,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>>   	device->dev_stats_valid = 1;
>>   	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>>   	device->fs_devices = fs_devices;
>> +	device->dev_type = btrfs_get_device_type(device);
>>   
>>   	ret = btrfs_get_dev_zone_info(device, false);
>>   	if (ret)
>> @@ -334,6 +335,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>>   	list_add(&device->dev_list, &fs_devices->devices);
>>   	fs_devices->num_devices++;
>>   	fs_devices->open_devices++;
>> +	fs_devices->mixed_dev_types = btrfs_has_mixed_dev_types(fs_devices);
>>   	mutex_unlock(&fs_devices->device_list_mutex);
>>   
>>   	*device_out = device;
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 9d50e035e61d..da3d6d0f5bc3 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1041,6 +1041,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>>   			     device->generation > (*latest_dev)->generation)) {
>>   				*latest_dev = device;
>>   			}
>> +			device->dev_type = btrfs_get_device_type(device);
>>   			continue;
>>   		}
>>   
>> @@ -1084,6 +1085,7 @@ void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices)
>>   		__btrfs_free_extra_devids(seed_dev, &latest_dev);
>>   
>>   	fs_devices->latest_dev = latest_dev;
>> +	fs_devices->mixed_dev_types = btrfs_has_mixed_dev_types(fs_devices);
>>   
>>   	mutex_unlock(&uuid_mutex);
>>   }
>> @@ -2183,6 +2185,9 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>>   
>>   	num_devices = btrfs_super_num_devices(fs_info->super_copy) - 1;
>>   	btrfs_set_super_num_devices(fs_info->super_copy, num_devices);
>> +
>> +	cur_devices->mixed_dev_types = btrfs_has_mixed_dev_types(cur_devices);
>> +
>>   	mutex_unlock(&fs_devices->device_list_mutex);
>>   
>>   	/*
>> @@ -2584,6 +2589,44 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
>>   	return ret;
>>   }
>>   
>> +bool btrfs_has_mixed_dev_types(struct btrfs_fs_devices *fs_devices)
>> +{
>> +	struct btrfs_device *device;
>> +	int type_rot = 0;
>> +	int type_nonrot = 0;
>> +
>> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
>> +
>> +		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>> +			continue;
>> +
>> +		switch (device->dev_type) {
>> +		case BTRFS_DEV_TYPE_ROT:
>> +			type_rot++;
>> +			break;
>> +		case BTRFS_DEV_TYPE_NONROT:
>> +		default:
>> +			type_nonrot++;
>> +		}
>> +	}
>> +
>> +	if (type_rot && type_nonrot)
>> +		return true;
>> +	else
>> +		return false;
>> +}
>> +
>> +enum btrfs_dev_types btrfs_get_device_type(struct btrfs_device *device)
>> +{
>> +	if (bdev_is_zoned(device->bdev))
>> +		return BTRFS_DEV_TYPE_ZONED;
>> +
>> +	if (blk_queue_nonrot(bdev_get_queue(device->bdev)))
>> +		return BTRFS_DEV_TYPE_NONROT;
>> +
>> +	return BTRFS_DEV_TYPE_ROT;
>> +}
>> +
>>   int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
>>   {
>>   	struct btrfs_root *root = fs_info->dev_root;
>> @@ -2675,6 +2718,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
>>   	device->mode = FMODE_EXCL;
>>   	device->dev_stats_valid = 1;
>> +	device->dev_type = btrfs_get_device_type(device);
>>   	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>>   
>>   	if (seeding_dev) {
>> @@ -2710,6 +2754,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
>>   
>>   	fs_devices->rotating = !blk_queue_nonrot(bdev_get_queue(bdev));
>> +	fs_devices->mixed_dev_types = btrfs_has_mixed_dev_types(fs_devices);
>>   
>>   	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
>>   	btrfs_set_super_total_bytes(fs_info->super_copy,
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 6a790b85edd8..5be31161601d 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -52,6 +52,16 @@ struct btrfs_io_geometry {
>>   #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
>>   #define BTRFS_DEV_STATE_NO_READA	(5)
>>   
>> +/*
>> + * Device class types arranged by their IO latency from low to high.
>> + */
>> +enum btrfs_dev_types {
>> +	BTRFS_DEV_TYPE_MEM = 1,
>> +	BTRFS_DEV_TYPE_NONROT,
>> +	BTRFS_DEV_TYPE_ROT,
>> +	BTRFS_DEV_TYPE_ZONED,
> 
> I think this should be separate, in one list define all sensible device
> types and then add arrays sorted by latency, or other factors.
>
> The zoned devices are mostly HDD but ther are also SSD-like using ZNS,
> so that can't be both under BTRFS_DEV_TYPE_ZONED and behind
> BTRFS_DEV_TYPE_ROT as if it had worse latency.

I still do not have a complete idea of its implantation using an array. 
Do you mean something like as below,

enum btrfs_dev_types {
	::
};

struct btrfs_dev_type {
	enum btrfs_dev_types dev_type;
	int priority_latency;
};


I think we can identify a ZNS and set its relative latency to a value 
lower (better) than rotational.


> I'm not sure how much we should try to guess the device types, the ones
> you have so far are almost all we can get without peeking too much into
> the devices/queues internals.

Agree.

> Also here's the terminology question if we should still consider
> rotational device status as the main criteria, because then SSD, NVMe,
> RAM-backed are all non-rotational but with different latency
> characteristics.

Right. The expected performance also depends on the interconnect type
which is undetectable.

IMO we shouldn't worry about the non-rational's interconnect types
(M2/PCIe/NVMe/SATA/SAS) even though they have different performances.

Because some of these interconnects are compatible with each-other 
medium might change its interconnect during the lifecycle of the data.

Then left with are the types of mediums- rotational, non-rotational and
zoned which, we can identify safely.

Use-cases plan to mix these types of mediums to achieve the 
cost-per-byte advantage. As of now, I think our target can be to help these
kind of planned mixing.

>> +};
>> +
>>   struct btrfs_zoned_device_info;
>>   
>>   struct btrfs_device {
>> @@ -101,9 +111,16 @@ struct btrfs_device {
>>   
>>   	/* optimal io width for this device */
>>   	u32 io_width;
>> -	/* type and info about this device */
>> +
>> +	/* Type and info about this device, on-disk (currently unused) */
>>   	u64 type;
>>   
>> +	/*
>> +	 * Device type (in memory only) at some point, merge to the on-disk
>> +	 * member 'type' above.
>> +	 */
>> +	enum btrfs_dev_types dev_type;
> 
> So at some point this is planned to be user configurable? We should be
> always able to detect the device type at mount type so I wonder if this
> needs to be stored on disk.

I didn't find any planned configs (white papers) discussing the
advantages of mixing non-rotational drives with different interconnect
types. If any then, we may have to provide the manual configuration.
(If the mixing is across the medium types like non-rotational with
either zoned or HDD, then the users don't have to configure as we can
optimize the allocation automatically for performance.)

Also, hot cache device or device grouping (when implemented) need the
user to configure.

And so maybe part of in-memory 'dev_type' would be in-sync with on-disk
'type' at some point. IMO.

Thanks, Anand

