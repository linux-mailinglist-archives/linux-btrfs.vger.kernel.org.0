Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4533EFD17
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 08:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbhHRGt0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 02:49:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63262 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238080AbhHRGtW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 02:49:22 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I6fruE026229;
        Wed, 18 Aug 2021 06:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tkS59PbA5SGUid6JinUwM+KotRDqSPPhHKQhq7sHcF4=;
 b=tYMTKX2wVhlNBl2qLPzrPGtJjWcWdXAcui6J9xBrLeJ1f4GNJ6KwazqoG34hrKAKNi6K
 JSWV57vpoPaxkREKywK21cYFbEXNVY22C8EJM0kHGRrqOzy5jxbWu6SICscyoc6otcdW
 bikmh9ESRx7RhPoIlKgu6FzSmEXhvpWZa3c4BT05wcqNaNaBWNqjVeyVxTKa71VZ0IeE
 uKwwUjtHgpFcBojpOta2/LAaetBuvZgQagvnlWndmxX3PljXfgv+el6HHGzPwvsBrrm2
 SDYAXknFCEOd+gibE3zBgozkOPesH0P5Dz6AFYKAf7iVUP11DKdsERI43cMN0FmR/wfG sg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=tkS59PbA5SGUid6JinUwM+KotRDqSPPhHKQhq7sHcF4=;
 b=dTifnxEhK+gHSzeQJu7SEg6WAhm3yymwYV+5CVH95xh8A56e02kX45FGIXDFX9689tGE
 GUhOSO0F2xoQoE5dzOz9dbFgpTVOpLhIKVp47AaHCCbgQsnufTlwqUZCsWOHZJv3aKKI
 /fErA3bNn3IG29zFqqIuYKxpxua87rC66Pr5dHL1XxUNf7J8pU42NAcA/IeuUNA36IOH
 H6WaH7naQgvcb0KiHmtqnPy1RWkpt9EcLZOsNmarY6j4HgLjInLc5jHUe/+iUWiHDYAT
 5vP58SoaWckoKNB4AOZLkF5MSVsaN3PJt6AoFsY+FxelSzZ/xVxVgLdre6+L9BRRYg5C rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7d9unh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 06:48:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17I6f3v9097440;
        Wed, 18 Aug 2021 06:48:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3020.oracle.com with ESMTP id 3aeqkvn36d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 06:48:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ep3P9xL4mlgORExuYHrrV8avZgC3P2q6RnCQGSmgeTrlrTA04hhHO+uGhn5Lw+1gwQcAiFu4KSKqU/X+n+D0s4uIsaJqOfznbO7Mu7T/lzayqzDVILnvXTN24NjE5DUp7iFyYO/9/aKsw7SucDBHyFAfxqwxj5+ECof5zh6LXPMk9N+6FlCgzwKM9yqE4Al/g63DTRylv8r1ZuABT/XmiTCVxHmHI2s/QoTfWcaPxoBwrcIO8jsLw846p+ngwLhZTL8idTwBhE/ZVMqPMMr1NyIimg3jyYCnQy8wcpWNai+Ho3GSz83Oxl8V2e6cmRfTb0XJWXNH/+XowDk980ZGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkS59PbA5SGUid6JinUwM+KotRDqSPPhHKQhq7sHcF4=;
 b=Lb2ynb8gEd4SM2+zlXCDWBi/oJcpNMSDsqhyOpA0MM8C58I3I3PX+XSSCsJsBhIg5g628MUwOqpEoC5MKpKTniIP4VT4uOprouD1IZWPXQvQ34pttw4rUJ9gBUxxvDsEGdH8fEIL5A0oQNFCISruQPTL2ZxR68QYPAVasl/c5KP6wjGJqiIqrrWKa9uoOHqwM0H3rhUiZHi9WeEEDp2I7+9bVflWg4gJTQgWjZcUvJQs5xRq7pJSFZDn6iyZBm6aPlcbkIB4AhOks6lPJaaTzCF/fbzXef+rPUy8eJSFwrBfvYWA8W5lDi5t6l43KWmgVvA63h6M00oOAhSMRDBz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkS59PbA5SGUid6JinUwM+KotRDqSPPhHKQhq7sHcF4=;
 b=qIr9PGCo6k6CVDK9GB3DAkTa2DJ4KiMwjvVE04qFKx/1HuDUI/y+V0B2lF6TkdZEU/3pO/FrrIIaaNkAchIBVSQqYCp9Fp7Yt5VUplR63xW9MGoTrgEaJgQxnyylD+x0OydymF/frAq9Csbb0DEEEJrHvXbEMnlXHjS4qTXI1Ao=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4820.namprd10.prod.outlook.com (2603:10b6:208:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 06:48:38 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Wed, 18 Aug 2021
 06:48:38 +0000
Subject: Re: [PATCH V2] btrfs: traverse seed devices if fs_devices::devices is
 empty in show_devname
To:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
References: <20210818041944.5793-1-l@damenly.su>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1b42b3aa-0363-36ad-df5c-4d9d86b8cc97@oracle.com>
Date:   Wed, 18 Aug 2021 14:48:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210818041944.5793-1-l@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 06:48:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26ddb294-be41-4b5b-b350-08d962143562
X-MS-TrafficTypeDiagnostic: BLAPR10MB4820:
X-Microsoft-Antispam-PRVS: <BLAPR10MB482033282F2003147B44E4F2E5FF9@BLAPR10MB4820.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLdWmVZn3EyDE2thcd5SWxv5QTAqjpFWgt/+IcOh1TQTn1mwTFd+3BZKIFs6Vu4ppaYut5LkDliuxnCbFK8469tAcD/Ywc7MxQHJiqPnrR+X629XAeWkPvP3VatgtTOf4rgWynZi7Pzp9fY/Pg4nXQuZXcCA5VQPFCXNHL6QjNDKk3itcOZiUdqL7hnr7JQ5S0yrZviN1BuIQcoowxslR0qDkI/cBRKirev09JK68BVsg4DFmu3z/6zkjFXBNqJlLIWVjuUAW84gXJiTc9jaWriMtQh3Er9UtlAfpDh8+3/aBB/BgsvmsLJRLLckAoJY3LqggYNrohC4bdW5EAYUsXXIJLwjTjcw2dwmBbCCZeA4B89oZpixCHL2okt5ob8EizGCfzgitgYdV7Bd4NeiWyv3wYH1SONYU3m32JFEnZFjtb2sa6aVynHhThNjZ1zRssh3e8J864Cu9Xt1QescwHxuRg7A+uabbVi6WaBfrfEjnsN/KVUvEO1o7vK/agx/X3qwwJo++E4GBGrt3tBfdrNyKUOJ13rsqhrmds1yFFVJj4WdrceSBEsDxzQOT14xJ8Ri2P+/brikfYxnNM/Jnoja98DmSzX9h/Giq8eZbuOpsosp6M8FXY3qiByjraXnssw5EK45x10Auk5jirmw9X9mU2P2Ih7F2NdUcuEpksgZ3/95GUJwEj3J875ybKBmaTLYiI7zx3WCs48OD6+EHjw2xSDFFjVk1xrYjoUewfoMiSZuECh3Q3HGG2VA0PTDB7hCZ7KSizdkKTFj0OQqGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(346002)(39860400002)(478600001)(53546011)(31686004)(66946007)(66556008)(83380400001)(2906002)(66476007)(8936002)(16576012)(5660300002)(316002)(86362001)(186003)(6666004)(2616005)(38100700002)(6486002)(26005)(8676002)(31696002)(956004)(36756003)(44832011)(781001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGZWbTU2K3lyWWJweWRzTmhDVDdSdm5oWHFDL2NDbllpYTRrbUMxdC9DTUNm?=
 =?utf-8?B?cEpjK1FwWkIyTXR2OWRiM2dsUUE4RnNkTEMvcGt2SlBmU0ZBRitBWWhHcTlt?=
 =?utf-8?B?NjVVd1hjTFVZSXpGN1VkSG1sdWlJaW9ScGZsYjR2c21xSGNzZitpNlZ3WElF?=
 =?utf-8?B?bm5TbW52K09nb2VLNzRISW42dXN1T1l4ZlpIQkdYaVZTVEdWaUxOdkRpT09m?=
 =?utf-8?B?VGZYU0FldTdjd2lCMFNEUWxVcG1pYVNxbWd6MGtOcXJlcXBvSDhwNGQxTWZL?=
 =?utf-8?B?QVA3ajRzWlN5MGNVZmZYNHl4ZVlWc3FrMUxsOXZZYi9EWFNBOXhYSWNwTWd1?=
 =?utf-8?B?OTlQYlJwNkNtSVpmOXI0MjN2ZHAzT2Jlc2N2Vi85QWJQU3dDMWV4Y0FiU01H?=
 =?utf-8?B?SGtRbUYrb2JKdjVxSzJKZjc4NHVtZDBpVDJWNmE1bUwwTEttYlN3d1lTWnV0?=
 =?utf-8?B?eVZFNXRrUjlRRVlSQnFDWnlENEF2cURmTWVBT1lpYmJ1cFQ2MWVCOE8xd003?=
 =?utf-8?B?ZVU4aXBIZ2VnT2U4a1luSVlTWjN5K0laa0dpeXNIbHRPZDY1aEVlaXdJS1FY?=
 =?utf-8?B?UUpLd3dzYmVySTlGazhNTjFXTHB1UTluYVhmTVJzS0F6L25tNFZjSytmblVw?=
 =?utf-8?B?c004Zk9FZHhHbUZDTW1oTHJoVUJXeFJmU3h5VW43TFlkcVZvYUw1RDNaSjZ2?=
 =?utf-8?B?Z0VCaVRFU1BublJEckhZbWhtbXpTUVhJRGN1VVJlejE4VjJxelphK0R0WFZC?=
 =?utf-8?B?UFJhL1gwZTNVZzQrMzRWMWozTzhML0pIaTdiRmlwakJTd1NvdFBZdVZpSzFH?=
 =?utf-8?B?OXhzeTB5Wis4OFNJaDJCU2xDallYTlBTZXVhTWNxR3RaL2xZV1lkcVAraFVM?=
 =?utf-8?B?b0k4anJta0ExamJOR1piaitXUzVzRG13SDZQZXFnaEhUMTcwNUxFWjJzcGRj?=
 =?utf-8?B?ZmIwMzdBd0NMekJPMUVmTCtYWlJ2S1NpNDhCZ1pCSlFPelJLOXBldnMvUjcw?=
 =?utf-8?B?K0hyc21FOVMzellOOVFNc3ZyTlNlWWpQTDNRR0o3cHhWZXA2Z1JQTUs3clV3?=
 =?utf-8?B?Z0tDOExRcGF6UGwyOVZDSDltMFIxTTRWNXF3NEVQbDZ4bWQ2RjdYdHg5bFRU?=
 =?utf-8?B?YXBPY2NXT05ScWdvTmpDRVNTWU5qNHJ0YjljZkhoTFJ6b1FJMUtmWGx4YW5q?=
 =?utf-8?B?NzhETDk4UDRGWFNHdjVaMzJ1anhTTGlCeW1mMWQ4M2EvWW1naXVRYThYclBa?=
 =?utf-8?B?QW5ITTVYVng4cW4xVTdLY1FJWVNDTSt6ajRmZlEyUGd0anR4Q2FuWm1DejR0?=
 =?utf-8?B?Q0lTNlJDdDQrSGhpOGlVVWx1cHk4Q3N6emZVRVZYUTc2NTZoOElyMkRKV3lq?=
 =?utf-8?B?Z1BEa01VVDdnYk5YWWFtdFplUTFYUUdvZW41NFZJUGsyT2ZmWFJxNkEyWlJu?=
 =?utf-8?B?V2JUc0RHTTZ1Z2ZhY1F1N0svZXhrdVBucEpQdHRuZ2t6Zms5ck9jMkEvSmdx?=
 =?utf-8?B?MzEyM1lkVGpyVU1rRFFPUll2am13UGpLNENDZEJnTVNMRVlMZWtCUEpWb1Vn?=
 =?utf-8?B?cDQwMExjT0themhJWFI5V2k3SEtJK3BHa3BaTWdKcThBYUtSS0dmYy9yTzAx?=
 =?utf-8?B?Rm44TXpDMkZxQ1piRS9DZXRWMkdpWkhTYzFkSmt0Z1Q5TnRmd3Z1ZTdkdTkw?=
 =?utf-8?B?cnBiQ05zL2tZVytlNkI5OWgxTml3WHZpRTJVclJaeDZycVRJVUdjQ0xFdXkz?=
 =?utf-8?Q?r66rtExKdt3HV3jbJjEp7KqcLa//rhjCu5DKwQl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ddb294-be41-4b5b-b350-08d962143562
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 06:48:38.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UETYYVge6eQGjPQGlRlzfuw6LndQLS89c5ZBxhqwsis2ORAx3B2yRbGT2bdm6RT/qwrEnWfkemQiwE/yQP2fVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4820
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180042
X-Proofpoint-GUID: JYvoHTR4TwFi6B9Lljiqjuue2Q33wjRJ
X-Proofpoint-ORIG-GUID: JYvoHTR4TwFi6B9Lljiqjuue2Q33wjRJ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 18/08/2021 12:19, Su Yue wrote:
> while running btrfs/238 in my test box, the following warning occurs
> in high chance:
> 
> ------------[ cut here  ]------------
> WARNING: CPU: 3 PID: 481 at fs/btrfs/super.c:2509 btrfs_show_devname+0x104/0x1e8 [btrfs]
> CPU: 2 PID: 1 Comm: systemd Tainted: G        W  O 5.14.0-rc1-custom #72
> Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> Call trace:
>    btrfs_show_devname+0x108/0x1b4 [btrfs]
>    show_mountinfo+0x234/0x2c4
>    m_show+0x28/0x34
>    seq_read_iter+0x12c/0x3c4
>    vfs_read+0x29c/0x2c8
>    ksys_read+0x80/0xec
>    __arm64_sys_read+0x28/0x34
>    invoke_syscall+0x50/0xf8
>    do_el0_svc+0x88/0x138
>    el0_svc+0x2c/0x8c
>    el0t_64_sync_handler+0x84/0xe4
>    el0t_64_sync+0x198/0x19c
> ---[ end trace 3efd7e5950b8af05  ]---
> 

> It's also reproducible by creating a sprout filesystem and reading
> /proc/self/mounts in parallel.

  ok. This explains.

> 
> The warning is produced if btrfs_show_devname() can't find any available
> device in fs_info->fs_devices->devices which is protected by RCU.


> The warning is desirable to exercise there is at least one device in the
> mounted filesystem. However, it's not always true for a sprouting fs.


Right. When the code is running from line 2596 (including) until line 
2607, there are chances that the fs_info->fs_devices->devices list is 
empty. Or those devices are moving to fs_info->fs_devices->seed_list.


2596                 ret = btrfs_prepare_sprout(fs_info);
2597                 if (ret) {
2598                         btrfs_abort_transaction(trans, ret);
2599                         goto error_trans;
2600                 }
2601         }
2602
2603         device->fs_devices = fs_devices;
2604
2605         mutex_lock(&fs_devices->device_list_mutex);
2606         mutex_lock(&fs_info->chunk_mutex);
2607         list_add_rcu(&device->dev_list, &fs_devices->devices);


> 
> While a new device is being added into fs to be sprouted, call stack is:
>   btrfs_ioctl_add_dev
>    btrfs_init_new_device
>      btrfs_prepare_sprout
>        list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
>        synchronize_rcu);
>      list_add_rcu(&device->dev_list, &fs_devices->devices);
> 
> Looking at btrfs_prepare_sprout(), every new RCU reader will read a
> empty fs_devices->devices once synchronize_rcu() is called.
> After commit 4faf55b03823 ("btrfs: don't traverse into the seed devices
> in show_devname"), btrfs_show_devname() won't looking into
> fs_devices->seed_list even there is no device in fs_devices->devices.
> 
> And since commit 88c14590cdd6 ("btrfs: use RCU in btrfs_show_devname for
> device list traversal"), btrfs_show_devname() only uses RCU without mutex
> lock taken for device list traversal. The function read an empty
> fs_devices->devices and found no device in the list then triggers the
> warning. The commit just enlarged the window that the fs device list
> could be empty. Even btrfs_show_devname() uses mutex_lock(), there is a
> tiny chance to read an empty devices list between mutex_unlock() in
> btrfs_prepare_sprout() and next mutex_lock() in btrfs_init_new_device().
> 
> So take device_list_mutex then traverse fs_devices->seed_list to seek
> for a seed device if no device was found in fs_devices->devices.
> Since a normal fs always has devices in fs_device->devices and the
> window is small enough, the mutex lock is not too heavy.
> 
> Signed-off-by: Su Yue <l@damenly.su>
> 
> ---
> Changelog:
> v2:
>      Try to traverse fs_devices->seed_list instead of removing the
>        WARN_ON().
>      Change the subject.
>      Add description of fix.
> ---
>   fs/btrfs/super.c | 41 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index d07b18b2b250..31e723eb2ccf 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2482,7 +2482,9 @@ static int btrfs_unfreeze(struct super_block *sb)
>   static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
>   {
>   	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>   	struct btrfs_device *dev, *first_dev = NULL;
> +	struct btrfs_fs_devices *seed_devices;
>   
>   	/*
>   	 * Lightweight locking of the devices. We should not need
> @@ -2492,7 +2494,7 @@ static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
>   	 * least until the rcu_read_unlock.
>   	 */
>   	rcu_read_lock();
> -	list_for_each_entry_rcu(dev, &fs_info->fs_devices->devices, dev_list) {
> +	list_for_each_entry_rcu(dev, &fs_devices->devices, dev_list) {
>   		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
>   			continue;
>   		if (!dev->name)
> @@ -2503,9 +2505,42 @@ static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
>   
>   	if (first_dev)
>   		seq_escape(m, rcu_str_deref(first_dev->name), " \t\n\\");
> -	else
> -		WARN_ON(1);
>   	rcu_read_unlock();
> +
> +	if (first_dev)
> +		return 0;
> +
> +	/*
> +	 * While the fs is sprouting, above fs_devices->devices could be empty
> +	 * if the RCU read happened in the window between when
> +	 * fs_devices->devices was spliced into seed_devices->devices in
> +	 * btrfs_prepare_sprout() and new device is not added to
> +	 * fs_devices->devices in btrfs_init_new_device().
> +	 *
> +	 * Take device_list_mutex to make sure seed_devices has been added into
> +	 * fs_devices->seed_list then we can traverse it.
> +	 */
> +	mutex_lock(&fs_devices->device_list_mutex);


possible fix:
  As the problem is from line 2596 to 2607 (above) can we move
     list_add_rcu(&device->dev_list, &fs_devices->devices);
  into btrfs_prepare_sprout() so that it shall reduce the racing window.

And,
  We have learned that taking device_list_mutex in this thread will end
  up with a lockdep warning. We might need a new fs_info state to
  indicate that FS is sprouting.

Thanks, Anand

> +	list_for_each_entry(seed_devices, &fs_devices->seed_list, seed_list) {
> +		list_for_each_entry(dev, &seed_devices->devices, dev_list) {
> +			if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
> +				continue;
> +			if (!dev->name)
> +				continue;
> +			if (!first_dev || dev->devid < first_dev->devid)
> +				first_dev = dev;
> +		}
> +	}
> +
> +	if (first_dev) {
> +		rcu_read_lock();
> +		seq_escape(m, rcu_str_deref(first_dev->name), " \t\n\\");
> +		rcu_read_unlock();
> +	} else {
> +		WARN_ON(1);
> +	}
> +	mutex_unlock(&fs_devices->device_list_mutex);
> +
>   	return 0;
>   }
>   
> 
