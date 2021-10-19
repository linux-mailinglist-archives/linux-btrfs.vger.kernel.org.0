Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450E3432C5F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 05:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhJSDok (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 23:44:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53514 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhJSDoj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 23:44:39 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19J32gbf004583;
        Tue, 19 Oct 2021 03:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WCpoJ13EeB1LK3dO4yLC/kycN+BH3eoUwHGW/qLJMEs=;
 b=mAElj+qqaiXQxXcXgFsDNMSWFOUB5RGeYOn2q1mtfB89VZyPwaY18ySpDaxehomFWCJE
 sWOvZNqRnGOAuC96yWytDD4xVdZaqOm56W5YjJSdp7LoaSjYfAYcdNebXE4yKQrV2AgE
 n8tF0RHKsn7Aatihop1fx7bhXyd/ZVKB1uU/y4adX/FMpo6vavyOKj0XRGfg0nF9wlSu
 gNiWZbDZqwuNULVWXhAHO8scGLkrJisCTDFCYpt3Hluura68vpTGYTy6JdeA5Biut59t
 47J8baEf1+cwkJErYjw7E+dhUSLutiRk4tvnrr8qYs9MkT8g8/XI9Eil89PeUrm1CixI 4A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3brnnnftrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 03:42:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19J3b6sn184145;
        Tue, 19 Oct 2021 03:42:18 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by aserp3020.oracle.com with ESMTP id 3bqpj4r47w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 03:42:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vsz1ldhlE9BaTYoL47M8xjpsnUDj50Fbw2iF5ybL5rJMNd51n5ohlSy/URihlhk6l3GVM0c5a4z3o2ns+IfDB9dY3Q/f0lY+b8b88Yp1xB7pYPFbcM7Z0FR49aOvR2vqGyMDBg7ulpQYhYAPcf48tWJbA3/pstMYDIn5jMJOVyvLqDF5KVCMVzv++h+uGkGu3CnKu9JFOz0GSKeM6gBk60kEf/cW/xy7ow5++RWKRsq39McaLZcqWYZJ/+msCYAoFP9HOrdI2ohBJAUu2sPgmJquAuWtM5gEUSDNLjijpIel8ONGg6wEc7/mb3sZgCFSMh6sSBVpBUAcB0PLh/d6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCpoJ13EeB1LK3dO4yLC/kycN+BH3eoUwHGW/qLJMEs=;
 b=YdXlG1Gz6MQ6DwYo0h5IyqVhBX1XkUiwYf9F1R+KVvyyIAj3cMOZjC0VBGa66gCgfSJ3fidd71tzxpEulvVWVZiqyFr1kVZR4YilM1qQk7lWFnl4KUFeEWmQfhzOp1LZhl2WRf4p0/t3XerZGLpu5PHbik4Hj1M8T+6DSpUAGRBFU0+C9DRHTgchwugtnalxXIUGH1TW6w13xgRW5WhkwiUKxtM/MjWTelHeAuuwcKi2ULRw2qczAwb//eH/tww2mibgPmrqv/dJ/BOB7DQb2xlVfoChasKd09lNB1Fh0k2es4c2EM2/JgbE5qXA68aYoiRLAUqdCndBSLIbgXvdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCpoJ13EeB1LK3dO4yLC/kycN+BH3eoUwHGW/qLJMEs=;
 b=SuigPppTCsGMd3t61IjYftoBAjQNK7kkn7YRBMUomf7aYG1OsieGmo06T81dQt9Va8udRO3hMcuYU2cFdqzZwm/MKgWD2NOAunsct8WDBWvyrs4xSNm0k3abBKvMWxLTpghEXeOQDjR2fxbl1WNHY8KXAYI/PjyIwSKo018qyeo=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5155.namprd10.prod.outlook.com (2603:10b6:208:320::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 03:42:17 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 03:42:17 +0000
Subject: Re: [PATCH v4 6/6] btrfs: use btrfs_get_dev_args_from_path in dev
 removal ioctls
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1633464631.git.josef@toxicpanda.com>
 <78f4669e469232db2d8675fd7b4fd06028f2eef5.1633464631.git.josef@toxicpanda.com>
 <e81e4690-377d-40f1-8488-21530ee6c57d@oracle.com>
 <338ca6f9-9728-edc9-642c-7893573b1678@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <2a8fd428-e0cc-5bc4-6d18-37e6223f6f06@oracle.com>
Date:   Tue, 19 Oct 2021 11:42:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <338ca6f9-9728-edc9-642c-7893573b1678@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:4:193::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Tue, 19 Oct 2021 03:42:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e863e30-fc32-42d7-7fa5-08d992b2727d
X-MS-TrafficTypeDiagnostic: BLAPR10MB5155:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5155BCD41973BAAF61663112E5BD9@BLAPR10MB5155.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4J6LEYtkLQ2aQqDTN0iMjJSKEQXGXBhD5fUS5775EGbJzMmIpEMXWAL+rnipwon8Iu2ku43zMBOXyO6GSgXp9mpatoCY/b250gl+trWfrKdTFwZgWzhaF5EksWsOvDwKZR77r5qhesK+zm4avpcaieJFleQPS696LEfUZ+5Pf5Fp6fGBMe/QNTDGBP/7r+E7tcEyijaTQ9nC7Y2000qmDMELiM0KSnc7Juid0lz5X2UfHTyz+0KA+BaaEuBO9Ibr4gfQQOONaSqZ/cMa5lgT9AYl0+9P4uYpoNxmsT/7aAJZN70Y2fkyswkwJbRqNrpOVor/SU8cFbP94OYowoiFmx+fxWx9Wc4aC/hv5Z7TLR5NnzVInguGbU+oZJubog96vBd2u3eqjQ9R8kaOqHxwCOVGD+5PXkAU8SNbLf7X2MC3g/ZG4iTo8xFyVXp6xWmNrWUpdotV4gEjtRYAmppSX+UzzezVMZJskSM8WDwdmam82kdvi7IJNYTTXkYvfwlEPfcU1wUOsuXV9oWTJUkOXtiSqeLgpEIRiyS6rp2YHjhwvUmat54ijm6wvD45kNjzuDkZT0jGw/Q1mHFjQ+aaBjfzFzDQmDoVjLyInBuLaGoxYwJ4kx0X3UmbEC0hcx8oiSLZbNz3CjM9nFhmHLDJpZvS03ajYqpz43TiCyYM8nxaODStycchIlCbKbjZ/R7NOiIg/u7EWaRzb9sEX/Sx3k3Y72yw4094RepD7wlFhFyu/JyuxQuvSOab1yXUb2mJoYFSrm8tlgB7PbHSqr5YuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(86362001)(186003)(6486002)(26005)(53546011)(66946007)(66476007)(83380400001)(316002)(36756003)(6666004)(956004)(2616005)(16576012)(2906002)(66556008)(8936002)(38100700002)(5660300002)(4326008)(44832011)(31686004)(508600001)(31696002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNJeUZMWkMzdTc3VDFRN0UxaXUvTEkwV1plcksrK2FNYVFwWjZyWU0xckp0?=
 =?utf-8?B?ZFI2a1lnK3M4R2YxNXYwOGxqRUZLMEZSeHpzc01ZSzJtNDQ2a1pOMUJTLzFo?=
 =?utf-8?B?d1NEN2hGUllkRE9RY1phYjhPUzYrdnlOSlc5UjhzcEdSRStPTHkzUGpvOTl1?=
 =?utf-8?B?QS9GcHYyRVF1YzVYM2lDcnpmaVp1OS8zNFEyM3duRTEzbGpuRlpWREduSkVy?=
 =?utf-8?B?NTFhQkh3T28veS82RnQvTEJqVzNFRGx3dlVkUldmMllNWXNwV1VuMzNQODlH?=
 =?utf-8?B?S1NoM21weVFxejhzUGZZQXJKcVRMeGdkc3Vxc2d2dmlaWjBXM2RJUW51MGcz?=
 =?utf-8?B?enFtMFBUcXpJcTE5aDhqUWlXR1hGMkdZRFNBV0xUZHo4d09GSlYxL1YvWGNt?=
 =?utf-8?B?OFoyNWxwTmM4Q1RVdSt2ejRTOWVIVHc4OU9jcWlnVDErYjQ0MmtKc01RSGJ5?=
 =?utf-8?B?aGUvQU5yU3RyR0o5Y0xOTVFtQW04anhTeVZhWTlUYzRENHNKMmhnOTBlbisw?=
 =?utf-8?B?bm1PMEZMUGFlV05zazd6amt4T3JLczRkNDZ3aEZFaUhSRHlLeThLUjJMNG5u?=
 =?utf-8?B?SEVpaHBQYlYwL0Zndm5VMXZ3bVplWTE5NEZKU2xtQm5jL29ObUFZc2tZK0Jr?=
 =?utf-8?B?UFNYOWwyV01pMk9KWVkrTnFzZ0wzelpLU3ZRclREV0hMaWhOanpYaVRRbVJw?=
 =?utf-8?B?TzFpYTJJOU00aTR4Mm9OVFlWUkRKUGVnYW5TbjhOVDVkZVhZMlJCa1BCSzNw?=
 =?utf-8?B?bHlSMExWZ2h0aVZsaHE5VHJqU0pFbDhkclRzSEdyZDgvYTNrbTNKRkNubjFB?=
 =?utf-8?B?Y2FrVTl4Um9kK29ueDlTb3JSVk1IREp5YlJEdjB2N1NKUUJaUmlWWCtUdUFZ?=
 =?utf-8?B?QXNaMjB2ZHp3WEtycjk0QlBmN1VjZk5nR05aYnV6bjEwMmw1SFE1ZWhhbE1a?=
 =?utf-8?B?bDVZYlh0ZG96b1N4YUhLUC9XMTIwSnREWHE1RTM5L1drWmFicWdzTXAxLzVL?=
 =?utf-8?B?ZCtlQm9oVC9yZUUwWE9BbStGK1ZhREMzM3ZtQVN4UWtFVDFBNjhaYTl0ajZS?=
 =?utf-8?B?L2FkWmxxUVNienloWDJqQ3B6S2RpSGF0RXdIaGlqN3krbDFYeGhVSTdibVNS?=
 =?utf-8?B?cUsyS1l5TDUzQkptMzEwbTU2R3FKRjBQNXhsN21KeEVWdjkyTWdxRG02NmlO?=
 =?utf-8?B?ZFNsbHNvWldzenFBdzVEQlN0aWN0aHEyOVNURTd0L0tqQ0pNYjgySWc2bllL?=
 =?utf-8?B?UkZWREI1SDlIenlxajIvRGU5WHFLdGlpRGpYKyt3bmxPbWppSGNhSG9saFpI?=
 =?utf-8?B?YnNkTXNZY2hQeXQzK2o3VUwyazRTUjFCTUsvbFVjZVJQYkpVRFB6WkV1Vm9W?=
 =?utf-8?B?S0VqN0RDd2RFWm1OakJ6Qk9NUzFva3VPZEcvZGpOVmxxamJaSUVBd3JscXpv?=
 =?utf-8?B?ZUg4U1NKalR0c1RmZ3oxQnFNeldOMXIveHZSak1UTFVnS0kzendEbEVrZTFI?=
 =?utf-8?B?VjBYQlBLV1p4OU93MDd5ZXQ5ZU5ETlVja2RJN1dVWFM1aUllcjMzY2F6amVP?=
 =?utf-8?B?WDFDVXN1eXFTbVJibEtvNndrT0dFN1lFTlhsS0FtTytzWG9oenR1MDIwMENB?=
 =?utf-8?B?TGQxOE51S3VKQklLM3ZjUEF2TTl6cUw2NzlTQ3dCUGMxcFRiSGlLRFVBR01k?=
 =?utf-8?B?YUJ2WDhZZm1OZVFWeFhmdEIyZXBBWlFRNlA3WlVKcEd5RXdTNTByWTVuWHF2?=
 =?utf-8?Q?bAFyZHsUw1654haKDx8q+4QEKrh7ifld1YsTO2c?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e863e30-fc32-42d7-7fa5-08d992b2727d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 03:42:17.3252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /090iVMDAqNMehZ9efVyyLpzaDlUWmM921nQO0a1oyJSPWkGFNJIoKaSgVR0TS9SNwBhHDM/E1UuSZk+eZ0J8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5155
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10141 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190018
X-Proofpoint-ORIG-GUID: qFbnYeEmDzl4_JXc8zyoCjoSdyPZaIei
X-Proofpoint-GUID: qFbnYeEmDzl4_JXc8zyoCjoSdyPZaIei
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 06/10/2021 17:05, Nikolay Borisov wrote:
> 
> 
> On 6.10.21 г. 11:54, Anand Jain wrote:
> <snip>
> 
>>> Suggested-by: Anand Jain <anand.jain@oracle.com>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>    fs/btrfs/ioctl.c   | 67 +++++++++++++++++++++++++++-------------------
>>>    fs/btrfs/volumes.c | 15 +++++------
>>>    fs/btrfs/volumes.h |  2 +-
>>>    3 files changed, 48 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index b8508af4e539..c9d3f375df83 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -3160,6 +3160,7 @@ static long btrfs_ioctl_add_dev(struct
>>> btrfs_fs_info *fs_info, void __user *arg)
>>>      static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user
>>> *arg)
>>>    {
>>> +    BTRFS_DEV_LOOKUP_ARGS(args);
>>>        struct inode *inode = file_inode(file);
>>>        struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>>>        struct btrfs_ioctl_vol_args_v2 *vol_args;
>>> @@ -3171,35 +3172,39 @@ static long btrfs_ioctl_rm_dev_v2(struct file
>>> *file, void __user *arg)
>>>        if (!capable(CAP_SYS_ADMIN))
>>>            return -EPERM;
>>>    -    ret = mnt_want_write_file(file);
>>> -    if (ret)
>>> -        return ret;
>>> -
>>>        vol_args = memdup_user(arg, sizeof(*vol_args));
>>>        if (IS_ERR(vol_args)) {
>>
>>>            ret = PTR_ERR(vol_args);
>>> -        goto err_drop;
>>> +        goto out;
>>
>>       return  PTR_ERR(vol_args);
>>
>> is fine here.
>>
>>>        }
>>>          if (vol_args->flags & ~BTRFS_DEVICE_REMOVE_ARGS_MASK) {
>>>            ret = -EOPNOTSUPP;
>>>            goto out;
>>
>> At the label out, we call, btrfs_put_dev_args_from_path(&args).
>> However, the args.fsid and args.uuid might not have initialized
>> to NULL or a valid kmem address.
> 
> On tha contrary, the fact that args is initialized via a designated
> initializer guarantees that the rest of the members of the struct are
> going to be zero initialized, or more precisley as if they had a "static
> lifetime"
> 
> https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
> 
> <snip>

Sorry for the late reply, I see the patch made it to the misc-next.
I missed both this email and the point that the rest of the members
initialize to zero. Yep. Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
