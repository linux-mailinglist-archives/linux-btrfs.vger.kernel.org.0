Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AE333859B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 06:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhCLF55 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 00:57:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40984 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCLF5r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 00:57:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C5sLpq155630;
        Fri, 12 Mar 2021 05:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XkbGaTjD1HYVqfsLsrz+6v3/U6KGPFw5YqEOdREh7Ic=;
 b=bPPDcVJjXVBWDphOFE4u+mCYwubz1iH9DxVndL7xuGVFnXqeiLq6usv/P9YcK9v0ADdn
 I1ibSOPbqXFXyfsHAhDNBITHPImDaQHRaiLW5/MXLKxLK6gMadGG+LE7p8erY/j8NYNd
 h6aq0Bl6jKU9+dVnRPSqu2Uh2VzQF6Og0vacoT56S0Xm0d7627G2sFT3L8DqGqMGE4NK
 QxdS2I/jveV3tXX1xu3UW1xiv8NtS0yZ1YsKVwE1RZEQrr/1gbyVrGq+cIgZoC7fhJfR
 oZomZLkhGRfvkhUSxqntsO+NuqE1aKfsZKzDOBhfKfiUmjZ/voDGe8xMxYw7N8zO0LqV eA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37415rgvv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 05:57:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C5tY7R103904;
        Fri, 12 Mar 2021 05:57:42 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2058.outbound.protection.outlook.com [104.47.46.58])
        by aserp3030.oracle.com with ESMTP id 374kastygm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 05:57:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=My+zPf+Ea2PSrTDY6MleV6omQNWlddoLeR72Bg5i8T9pcAARyG2OKLD3cHYhfFgNxHhEeueewIRi4qUzaQW2GA3N8YrXL7WE9RyM7vnokJBnVKsWfQUF/igPWWJtRP4P632ZNn5kg99eTTo6fCmpHg8qYB1thrGDkAZXSzwbwyciCyn9r0zmjSjYef7udUeQkv2Rgymr1ZdT3uki0quhouxC49apkOrxGkYP2zTD5tvVDYNMQj0zp1rKmDtM2cBThGSnCKPoQiijRpDWQH/BeyYvsP1Kvd4iTo3FM3jrrqScXmcTiSclHacAqi7JR361LJ92FlYB3vfuCSBTIuGAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkbGaTjD1HYVqfsLsrz+6v3/U6KGPFw5YqEOdREh7Ic=;
 b=ZeaBAprBAqhYzIdAFycZ9s4uEmzUFG26FSpuVx0af33JTX+FMcsIfisB3+Fm2gk5KHArUo3Wb8IS16XILENRoL3L3rqWarwmX+N4zuYwBh37z55C6hqFubi7xdtGrwKsO5nVhSOELHL16/Q69rG5VAfdBQ3h+DXAzDLQ0Uv0JWnU2rqZNSaSVgZLSl8imbxv78DmZZm9a3M/1oHLKn6qJMnmJ4jo53K4kWTsoPrB1W2I+DLbHDgoIAp5So6xCt4vcfA0sAvGoD0rm6W76ttow0FLReTFPErj+KZgYqv1sh6wDw7BI2hALruuOsSvWNtU9uzPOsFDXI4iqKLVPN5PmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkbGaTjD1HYVqfsLsrz+6v3/U6KGPFw5YqEOdREh7Ic=;
 b=juMp3DMDhS1DMaLSHOATtZojEZMxiyTkXcI8SNAeBpQnaGc8kB294pdT7y5YCTEczdniVxq5RX6UTzKC+gWSoFAs5SmbUpUNYiXkYmpzi3wnVqTprexFfWqJqVptXyeF43DRT+rzfPwiYATinKNxwD+fGq7tvpEuzEO28ii6t6E=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3058.namprd10.prod.outlook.com (2603:10b6:208:31::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Fri, 12 Mar
 2021 05:57:40 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 05:57:40 +0000
Subject: Re: [PATCH 1/3] btrfs: init devices always
From:   Anand Jain <anand.jain@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Neal Gompa <ngompa13@gmail.com>
References: <cover.1615479658.git.josef@toxicpanda.com>
 <e5abaf864da01a3ee1cb8ef341ef1024c9e886f6.1615479658.git.josef@toxicpanda.com>
 <73ec19a3-5be5-fdd1-fce3-dfdce7318adf@oracle.com>
Message-ID: <dc687f1a-4b5c-ea69-2f36-96191f2d1ef3@oracle.com>
Date:   Fri, 12 Mar 2021 13:57:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <73ec19a3-5be5-fdd1-fce3-dfdce7318adf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR0601CA0015.apcprd06.prod.outlook.com (2603:1096:3::25)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR0601CA0015.apcprd06.prod.outlook.com (2603:1096:3::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 05:57:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46cba7be-a9c5-4795-0455-08d8e51bbef6
X-MS-TrafficTypeDiagnostic: BL0PR10MB3058:
X-Microsoft-Antispam-PRVS: <BL0PR10MB305864709B3D451C5981614CE56F9@BL0PR10MB3058.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxvICr3t3AZp64y6dvc/fA03lio+s8kLLoy+7Ev4mZdgCY52SLuG6+A9MUVboVh83TVelKA1xYKKKGXiRqKMmmbc9/Y2OTMzTRoPr4kyWBCm4wQ2PfikZFboRZETSp1kRrkWWpkQUG5FHFB+7y++jgedaK/1L0ispn2C2qPwoelgRV5+UMmMdxNlfTSh34A2fRSJ3QV2Vdxs+4jCx1rphI/hp3MFLQg5xuJ2UbsnfFOgcklvUgB2uW5/cWUSg8HvGzcZJicIpoC7BUAlvMaXoCE5OZxIqptb0swo3EPpUjH2ZlLU+HvDUZtI3RGKs/fs8XwAQ1D7gxgyOHTb+GQ4tkSlnB9l22VGn+rS7dH2Snz4jKJlmQnKlw+Zdz2iP4CBnoGORTxZjFuhCmZWaHOz2TSQosj9phHsv1shvE1GnJ/8orHF8RZVEsFRxfGOCD4qi/jgz66ScqQUSm7TX70umR1uvWvHOXsp0qyC+Ek5sf1n0hhtFP2MKVr87JQEoJNhABLbJhommJVkjocGSsSlef84NQ834Da536D3gpw1zapsGFbBDSTCxzVY6g/5RTWg91/5sdXFJ7aqRsR+s9DBVQLr3RCjvlJ97YSdJxocMxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(39860400002)(366004)(376002)(316002)(16576012)(2906002)(956004)(8676002)(53546011)(31686004)(6666004)(36756003)(83380400001)(6486002)(44832011)(2616005)(8936002)(4326008)(31696002)(478600001)(26005)(66476007)(86362001)(5660300002)(186003)(16526019)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TDFyaEV5MkpKcGNwazlPM2dQZHB4OHBlcVhtODhJUGVLSWhxc212TWxGeTVl?=
 =?utf-8?B?cE9VeE1kcStkUmZvQTBuTHFpRWllakpXWGdsOXVNVmNUSVlpb0JIbzhaeDcx?=
 =?utf-8?B?UkIzZlRFK3ROS2xtdjV0QWFnTllTdHBYYzJrc1pHeWtFek4yQ3JZVEVOdGpQ?=
 =?utf-8?B?NzZQK1Zjb2c1WTNHck0rQ0x4bGlmeml3aXMwQ3hNK2hBclZuNnU0THU2VmpX?=
 =?utf-8?B?VDZ4SnlTc1h4ZjVNbkp5YXhVeFozclh4cGFMaFJyMWozVlBTTlRCN2tRS0xT?=
 =?utf-8?B?Uk9ReE9lVjB5bFJDbFJNTE5JVXM4alBmYU9mYmhreUY3K2lJbm50Yi94NDFM?=
 =?utf-8?B?ckhUUXd0STNXaEZ2OGhoYSt1S2hHUUtROStpSlh1UnJwT1dDNmRrM01PalAw?=
 =?utf-8?B?SXROQU5kaS9XUFY0TFlPS0VBOThiQ3U3VFJrZjRPbFk3b2hWY1BrRDVJdG1n?=
 =?utf-8?B?UzN2RnBwNUtEUlV4d1NOUUR5Tk5FcmxNT2RXNnBYRUVrbVpUWTZIQ2w1SDBK?=
 =?utf-8?B?WHJyNUhLTDBPanB5Z3dDVlVZT2VSK1FUeVZZMDRYREhYOHR5ajd3ODhTQXFU?=
 =?utf-8?B?SnlEb1hYSDl6V1lncndwd1BEUkg4OUswVkxycDMwMElWWlhwRWlGbUsxcHFN?=
 =?utf-8?B?YXFrdExNSEdFTWwzL1FhQ1EwMnJockZGTXoxTTlidmlSOFZpQ1ZuRTQxNWtC?=
 =?utf-8?B?UU5oc1ZjZ20wWEk0eXQ4Vk16U1pWZkUrSFN5NUtBL3BWZG9Lem5MZEhQcG5T?=
 =?utf-8?B?RUdFU2JVaW5qeVNvNTJzNGpuYWZPN1NPZmxYaElWTnpUbFdCOWM3cVRyYVBR?=
 =?utf-8?B?UXpOV0tXTE5VZ0l0Y3Z0NHJjbUEzMkRWTUpOU2FkelZUWHhEbURVZUFFazdT?=
 =?utf-8?B?UElwWEZ3ZTJSRGZDVTA0elliRjVNTno3Z2ppSy84d1BSVTJxSW05VVEzR0pO?=
 =?utf-8?B?YWxFYVFwRmtaMjdZMXU5ci9JQSszZHBCTXoyUGxDc1MvTzV1MWMvWEF1RnVZ?=
 =?utf-8?B?OTFnVTNEWGxOb21NTTJjaXBOcmhUWXNFc3NpTWJ3UmV5R25BbEl3UUtIMURt?=
 =?utf-8?B?Y0d3UmJ0RVlueEg2Z09hTHNQUkhRWmZRanVHOUVJdVFiQjREY05kUlRKSm84?=
 =?utf-8?B?WnFham94ZGVKRmUrSUU2VUx6Nis0b3Q2ZURTMW93eTAzYTFlZENrdFZSL2pZ?=
 =?utf-8?B?M0RrM3pvWW91ZVdwQnd4RDROZUZCUHkxRThXM0pxTG9ydmNHeDdoSjZ1dWdh?=
 =?utf-8?B?QnFRQXV3V3FIT2dVMFBkQmYvdzV1ODFaUVdzSVN2ajhsV1MxNXcwVzI3a3A0?=
 =?utf-8?B?dGREQ2E0eE9GMkt3eS9kMHRjWVNaYlRSYko4RFpPakQveTNMem1NejBrODYx?=
 =?utf-8?B?K1NKbEZySmdJRmFKd0s3UlB3bnEvUEkrb0FDenZpUnZnbjZ4Wk1rUUhIOFpE?=
 =?utf-8?B?bEVtK1RVK2Rjd2FpNk8wTTlyT2xaNlBqWTROQ1VzM3pqNjJPbHpjQzkyejNX?=
 =?utf-8?B?NVFwanJJWjhXZmM1UXduRXpTSjlJM29OODYyRngzUEZrMkwzMjlzZVQxZlBO?=
 =?utf-8?B?UC9nbUxCcWVTSlUyQWUvN0lrOXBnRFFOenVDdGlONjNQVUhrZ1FCb2Jrc0Y3?=
 =?utf-8?B?OW9wMlViQUhhc2pMek83Zkc4c3Q1V2FUK1RiNmJEWUNRcDZEVEFqS2NBWk1j?=
 =?utf-8?B?NGpDZHhQWjdPK2ZwaUdwWE1HOEJnQ00rTkR3R1ZwL1NiTEFLVmczRWtZQnJK?=
 =?utf-8?Q?gpBgyVrNCH0VrEYm1X2THSbgwYTI+rS5Ai1AL3x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cba7be-a9c5-4795-0455-08d8e51bbef6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 05:57:40.4975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NowLyiEZpw/VkEOiye/04Sa5tzanKFlPJVa2tCVwE/z3jqlktI/UPEZtHhHMTPofqSeBSAAHkMY+jbgn7LRtDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3058
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120041
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120041
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/3/21 1:52 pm, Anand Jain wrote:
> On 12/3/21 12:23 am, Josef Bacik wrote:
>> Neal reported a panic trying to use -o rescue=all
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000030
>> PGD 0 P4D 0
>> Oops: 0000 [#1] SMP NOPTI
>> CPU: 0 PID: 696 Comm: mount Tainted: G        W         5.12.0-rc2+ #296
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 
>> 04/01/2014
>> RIP: 0010:btrfs_device_init_dev_stats+0x1d/0x200
>> RSP: 0018:ffffafaec1483bb8 EFLAGS: 00010286
>> RAX: 0000000000000000 RBX: ffff9a5715bcb298 RCX: 0000000000000070
>> RDX: ffff9a5703248000 RSI: ffff9a57052ea150 RDI: ffff9a5715bca400
>> RBP: ffff9a57052ea150 R08: 0000000000000070 R09: ffff9a57052ea150
>> R10: 000130faf0741c10 R11: 0000000000000000 R12: ffff9a5703700000
>> R13: 0000000000000000 R14: ffff9a5715bcb278 R15: ffff9a57052ea150
>> FS:  00007f600d122c40(0000) GS:ffff9a577bc00000(0000) 
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000030 CR3: 0000000112a46005 CR4: 0000000000370ef0
>> Call Trace:
>>   ? btrfs_init_dev_stats+0x1f/0xf0
>>   ? kmem_cache_alloc+0xef/0x1f0
>>   btrfs_init_dev_stats+0x5f/0xf0
>>   open_ctree+0x10cb/0x1720
>>   btrfs_mount_root.cold+0x12/0xea
>>   legacy_get_tree+0x27/0x40
>>   vfs_get_tree+0x25/0xb0
>>   vfs_kern_mount.part.0+0x71/0xb0
>>   btrfs_mount+0x10d/0x380
>>   legacy_get_tree+0x27/0x40
>>   vfs_get_tree+0x25/0xb0
>>   path_mount+0x433/0xa00
>>   __x64_sys_mount+0xe3/0x120
>>   do_syscall_64+0x33/0x40
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> This happens because when we call btrfs_init_dev_stats we do
>> device->fs_info->dev_root.  However device->fs_info isn't init'ed
>> because we were only calling btrfs_init_devices_late() if we properly
>> read the device root. 
> 
> 
>> However we don't actually need the device root to
>> init the devices, this function simply assigns the devices their
>> ->fs_info pointer properly, so this needs to be done unconditionally
>> always so that we can properly deref device->fs_info in rescue cases.


>   btrfs_device_init_dev_stats() calls btrfs_search_slot() leading
>   to btrfs_search_slot_get_root(), and does de-reference root (dev_root)
>   to get fs_info.

  Never mind. patch 2/3 handles it. Spoke too early.
  Maybe can reorder the patches during integration.
-Anand


> -------------
>   static int btrfs_device_init_dev_stats(struct btrfs_device *device,
>                                         struct btrfs_path *path)
> ::
>          ret = btrfs_search_slot(NULL, device->fs_info->dev_root, &key, 
> path, 0, 0);
> 
> 
> int btrfs_search_slot(struct btrfs_trans_handle *trans, struct 
> btrfs_root *root, ...)
> ::
>          b = btrfs_search_slot_get_root(root, p, write_lock_level);
> 
> 
> static struct extent_buffer *btrfs_search_slot_get_root(struct 
> btrfs_root *root, ...)
> {
>          struct btrfs_fs_info *fs_info = root->fs_info;
> --------------
> 
>   Can we allocate a dummy dev_root and set its dev_root::fs_info?



> Thanks, Anand
> 
> 
>> Reported-by: Neal Gompa <ngompa13@gmail.com>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/disk-io.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 41b718cfea40..63656bf23ff2 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2387,8 +2387,8 @@ static int btrfs_read_roots(struct btrfs_fs_info 
>> *fs_info)
>>       } else {
>>           set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>>           fs_info->dev_root = root;
>> -        btrfs_init_devices_late(fs_info);
>>       }
>> +    btrfs_init_devices_late(fs_info);
>>       /* If IGNOREDATACSUMS is set don't bother reading the csum root. */
>>       if (!btrfs_test_opt(fs_info, IGNOREDATACSUMS)) {
>>
> 
