Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DCB415750
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 06:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhIWERq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 00:17:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26042 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhIWERp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 00:17:45 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18N3QDh0028630;
        Thu, 23 Sep 2021 04:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=n1EnMoRUORhK5HJNlRK0WcR6TNaZiGZKOZDFMaTwhVw=;
 b=n1PgWjJGziJ+zHY7MZr4DyxLno2fvMSiXKEZOxbbmtioalZ5Z1X+A3/RH+gL/hCxCAf9
 3QDyLJ5AizwR/xvG40ZySx0BelfYHOFdFz50gNPQkv41cWqGP04K2BrLjDqImBgAiJkz
 +V9zYSnWnri+0Ua7YA8QmEGEttoF9aPD1CfGclNIV5BGxT63/jjKZJpWmbMNUlttyHc1
 FU9zgX4QjOT7TD2ialOIE8Q65FrPT58nss69BmarBqwJIbQJZSLx+tkS/PqX3HupWQHs
 FSAcAs5Nwi6rpxdid1RfaiQfBROyhTgoXOz//aBGeKiTqlWtiZjb5OCCrfbh4K1ap+8p Xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4pfqga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 04:16:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18N4G6tu165264;
        Thu, 23 Sep 2021 04:16:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3020.oracle.com with ESMTP id 3b7q5x6vxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 04:16:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGz8/575phyFNxJRSxNFGvo9qDQSbqeBn4DLBph7huqjfFjHi6NnIJTnQHUx2w9HQgukkMlFvInq/KS5FZW60009uFK2n5WoStSfp5uJWx+C/rYuz7atgzQ9URu060WzF+oH718BJmaHpCsJWU/GE5t8eBwntZOhZufVmpQmjEVNIjXLsTb0Wmt5+KjHvZQD60xC/dyj2mOH80udmag8bQ+ymyvepMSRAMJMSnPrj0NDGDVDgP2SJ9ENSReaaZIDrcO90ZtFI/tmem2KDWeXp8t2V/LXt9ojbnklkbmVM37gfBeVtX8t/jh4jixmZ7+sXz2mMw33FLr4lU0FGrMi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=n1EnMoRUORhK5HJNlRK0WcR6TNaZiGZKOZDFMaTwhVw=;
 b=XgPVjqp99cfoyjOBbf1OT8j85oTdyIqfJZOeoXUhVa++DAGDfjh1QA7czoRNxHYxgmJ0q2wHFeDb4zN0YHmqcvR7J4RVA/hVY/qXvfzMJ0G7Tr8c5gG0FIRPurznvxzvQJLLMgjYYC50KK35+kgW+A5aGyEStRdHCqUlv+ApRmgrIFy6gWH0bPZhUkfSpdDK9v7nz/HGDubX2u1kQXiwOjoDOav4D8JTPSaa6yjnqPJV7SCGUsFYoqEWEyeuORko9FQDadQ+ffQv/UCpSv0izN14kKQNUlRK6jJ5qA6FtD0tWZIaptTr0sVpdda6auAAgkBvU8l/xupEFLEU33buew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1EnMoRUORhK5HJNlRK0WcR6TNaZiGZKOZDFMaTwhVw=;
 b=wQkPCPwqRGB8o+Zi+0ymFlaVfdn5tbVQFYq9YcE3jr0cGmF1jNqruMX1L0HrkccycPlwzC74DFq6rV4i7ETvuSc3AFgL7YKE1911vQTE22xZkByDvSjvGARDwlEaiD+t04SuW4AcZJkd87M1DWeyi5E9qRae8K0tiXo0odikgBM=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4852.namprd10.prod.outlook.com (2603:10b6:208:30f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 04:16:08 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Thu, 23 Sep 2021
 04:16:07 +0000
Subject: Re: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in
 btrfs_rm_device
To:     fdmanana@gmail.com, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
 <CAL3q7H6KdA+ay4y=wTMjXBiXNPw8n0rhyfKS7WNqh3uOm2XuZw@mail.gmail.com>
 <CAL3q7H7Ohy+vHmVu2s4nJa9Kj4U4aRgUZ2U7kSxOGC0kqJdYjw@mail.gmail.com>
 <CAL3q7H6r-d_m5UbvOyU=tt_EJ400O0V9zvoBx5Op+fTMAciErQ@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ff6014a3-42b9-351f-c7c8-6779a3407e66@oracle.com>
Date:   Thu, 23 Sep 2021 12:15:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAL3q7H6r-d_m5UbvOyU=tt_EJ400O0V9zvoBx5Op+fTMAciErQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR01CA0177.apcprd01.prod.exchangelabs.com (2603:1096:4:28::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 04:16:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cdf2cb7-da11-487c-2d0c-08d97e48ddf9
X-MS-TrafficTypeDiagnostic: BLAPR10MB4852:
X-Microsoft-Antispam-PRVS: <BLAPR10MB48522DC195B1B7A4771662D6E5A39@BLAPR10MB4852.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nId4s5p28g94LCrk6qicuUWHtQClNdOi+feiA28GzG4w+NMact9aQfpAT1NQIlHUoR7bCSXEqLw/3Vd7op6059yg6qltYW7rF7nHh5vrEihZue1JAP1xwfFWSYd40L/jQkkmJXMapQRn206ycF6sM3VODVQUIMrNBcIz5vb2MQ7qx0zquBAwCQwaa7tgLLRh1F2qsh7h1f7ZufAxacyNXxOmF/yA4J8aFLDMpFpYFJqWD82kgb3Y3HzGwDJ0wDu5F9jSjCpO0de3muyjB/8sZeFi9cfYk9ViHqnlPyYE/tsDU09SwuFdbALb8frIHbIvn2VAHlq3d9Ypie3uXf+BzrwI/zTNKkmL45MHQobnmWZM4bkdpz6W9Yw9ENUy9hxrMPX0qYGEW1z28c9N6DmRcb3ygN+5KgbNpvJAU7OFwyM62B/ySqtic2ix0G+xkiC5/qcfpp0K+FRexB0vXArN0DMcVl9PJpOd3S8Ne1cKYrBW5j3QxixG0nZUBgZWWdlW4YDB0Ya4ygwKOg18iS+z76aoCcQo+bIGmeVT9iv+kA+VZ+5nFrJj8Zehw3ibidcTn2JpL2oYLdbuqPzEN8KkBkELVzbNtJYpKjc0DlxIlyiDP19SnZNuG+cV6HTTpEUslQq6uwdZwESNgQ3MXH1b/T+av/nfmGIQwKX8kgghi5sWI0bF2K1o0lS4U8Q2LOZjd3Fgn+7dbHjSon/uDrmTTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(86362001)(66946007)(31686004)(83380400001)(6916009)(956004)(4326008)(66476007)(66556008)(6486002)(26005)(2616005)(31696002)(16576012)(2906002)(38100700002)(8936002)(508600001)(5660300002)(6666004)(186003)(316002)(8676002)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTllc2NaMlZZWFJ6SC9iS2l0TS9QZVN3a21xMHlIc29oMmJaTnV3a2FHdW4z?=
 =?utf-8?B?SmxqNnNlQTVLbTJVaEYzb25DZEt0SE5TU2ZtQzUwUHBzMnA5TjJEK3lBekgr?=
 =?utf-8?B?V3NVTStNYXAyOVVlY3VDMzJIMWZEcE9aOGkvNExPdEJRaFpYN0NrVTFyNGdW?=
 =?utf-8?B?VE84dkZES3NRUEcxSlZoT3NiOW5QUUIwejVJWnhPTmRIM1NiYk1aZUR3TDZN?=
 =?utf-8?B?N3FzOEl6R211UzVaVnlOd3dtelBUMHU4VFBBZDBST0JWTjBBUzBrMDhqY0k0?=
 =?utf-8?B?ak1PdVdRQ255OVg3UXYwSHFFWUdkell1cVBOcTYxQ1NnQXJlUTZlSDNMamx6?=
 =?utf-8?B?dTVNaGhsWURnVE9GWHVBWk84Y2pjS2xSYmVCZGJvY1gzelRJK2VIS0Z3WjRG?=
 =?utf-8?B?M2Y3WVYrdWh0bWZja1lTT0hyWDdyUFpnc3dBdmhhV2ZtYXlvQjZZMlpXRW5N?=
 =?utf-8?B?cEtKMjdjd3l1aVlMb3RJdWszWTNtNFZDc3c3cEc5TnhxaWtudkEzZXhsbThw?=
 =?utf-8?B?ZGlKSmhvTi83bzNQSmJYR1NzYzNUL0NOSUJGSVRGUG51OVJCRFUxRCtuVWw2?=
 =?utf-8?B?ZS9KZnRiNEk2aEZtV3VIa2REcVdJODlIRGkzUjJkSTRJNTA3dzBabGE3TkZW?=
 =?utf-8?B?ck9aWlVQbU9LZUdNaEl2VEVHSXpmS3BDUHdoQnJsSm02ZjFLOWV5ekpUdjJp?=
 =?utf-8?B?MjlOdGQ5OFhwc1V3VWpqTm0xdHhpZ1pwOTFGTVlXclFBcVQ0UjU0UVI0ZWJ2?=
 =?utf-8?B?eHFUUzVNL2k5cXc3SDBqNkJFVWF4dzVROVo2R3F3Z3lkK3ErMi8wdmRwd3B3?=
 =?utf-8?B?NE1PclgySjVkWm5wcVA1Q3VaUU5oaHZUYjhGTTRBUkdOdC8rMG5FQkVuc01r?=
 =?utf-8?B?dWIvWUVLaC9MZ2F6YWk4bG50RG9Zc3ZoUEpHU3RFUEcwZjU0cm94R2pEUTFw?=
 =?utf-8?B?SnRrZkFwRzh1dWh4NElFbDRBaGpQeWFtOE1JZ2d4TkpIVGtMZ0JhVEMvamV1?=
 =?utf-8?B?STJuWXRqekdCbjE2c3JiMVhlMkNOM0oyL3lGbjlQVXJMZGsycWpjMGdzaWFi?=
 =?utf-8?B?cHpyNmdJU3F6aE1JQlhQOVlCdHZ3cGRleUt6eGhpQW1LN0pldTNnaVJBNlpL?=
 =?utf-8?B?L3VpTm1kYVM4ckMxSG5rWGtDbnRaWmtLcHlPN1VtTlVUbEdhTE1EOUZSc1Ny?=
 =?utf-8?B?QVI4U1llM2pDdkNpSzVmUzl2UWk5ZFlFZTgyOFhtM1M5RDdZNktYRE9mTVFq?=
 =?utf-8?B?MmZvN05iczlCb2hzZ3dzWnFJQkVZUGxJSHg4UlJKM2I2Q2ZhUEhYaEV1UE9R?=
 =?utf-8?B?azRabkZiaHR1SExKcGhCM0d6WGdGQjJDeWpuRlJ6UmYxWWFrc0ROMEtCblFU?=
 =?utf-8?B?TFl3S3oyN0lwSzlaeHh4VzJYU2FVL3M4dlFXZ3g3eDhGL1FTU0RIVEU3RW1h?=
 =?utf-8?B?L2FNamMyRjQ4ODVZNjYxS05TMlBoblEzRDJiTDlURkNYNGNvRHJOK28yZW5Z?=
 =?utf-8?B?YnRGR1pzNjNJVVFtTlU0RHdzaHZrSTIrL0ZiZUY0VGJTVjhmUDNmbzN2UG9q?=
 =?utf-8?B?cVY0MDZFdk1VRTZUMXl0SVNVcStKWWRZQUxPRkhoWmpTWjZ4TUdQeVZCRW1v?=
 =?utf-8?B?bEtXWkQ3aDhYZ1VMWk1qWjdvbTRwMy8rQVNBUlZ5eGxsNHFsY3BMSzBHTm1x?=
 =?utf-8?B?NzU0YzQybUFFZjk0NUFVYWlxbFROS1FjTGx6Q2k0Wk1JeXRNR3BZcGwxYzBp?=
 =?utf-8?Q?pSGtVuXqqcXEEErhDnq+g+ac4VXg9N8shoj+/Th?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdf2cb7-da11-487c-2d0c-08d97e48ddf9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 04:16:07.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wz7WYQ55TFOzmnW0M8ebiIT0pcoHuVjQicr+hOJTuKeLYAH/A0plqTNoU8hsXY95iN1hDe6JrSTb80JOzchvqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4852
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109230024
X-Proofpoint-ORIG-GUID: qMTiEGs584sbBEuvi2h981L1mSC7Tk08
X-Proofpoint-GUID: qMTiEGs584sbBEuvi2h981L1mSC7Tk08
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




> generic/648, on latest misc-next (that has this patch integrated),
> also triggers the same type of lockdep warning involving the same two
> locks:


  This lockdep warning is fixed by the yet to merge patch:

   [PATCH v2 3/7] btrfs: do not read super look for a device path


Thanks, Anand


> 
> [19738.081729] ======================================================
> [19738.082620] WARNING: possible circular locking dependency detected
> [19738.083511] 5.15.0-rc2-btrfs-next-99 #1 Not tainted
> [19738.084234] ------------------------------------------------------
> [19738.085149] umount/508378 is trying to acquire lock:
> [19738.085884] ffff97a34c161d48 ((wq_completion)loop0){+.+.}-{0:0},
> at: flush_workqueue+0x8b/0x5b0
> [19738.087180]
>                 but task is already holding lock:
> [19738.088048] ffff97a31f64d4a0 (&lo->lo_mutex){+.+.}-{3:3}, at:
> __loop_clr_fd+0x5a/0x680 [loop]
> [19738.089274]
>                 which lock already depends on the new lock.
> 
> [19738.090287]
>                 the existing dependency chain (in reverse order) is:
> [19738.091216]
>                 -> #8 (&lo->lo_mutex){+.+.}-{3:3}:
> [19738.091959]        __mutex_lock+0x92/0x900
> [19738.092473]        lo_open+0x28/0x60 [loop]
> [19738.093018]        blkdev_get_whole+0x28/0x90
> [19738.093650]        blkdev_get_by_dev.part.0+0x142/0x320
> [19738.094298]        blkdev_open+0x5e/0xa0
> [19738.094790]        do_dentry_open+0x163/0x390
> [19738.095425]        path_openat+0x3f0/0xa80
> [19738.096041]        do_filp_open+0xa9/0x150
> [19738.096657]        do_sys_openat2+0x97/0x160
> [19738.097299]        __x64_sys_openat+0x54/0x90
> [19738.097914]        do_syscall_64+0x3b/0xc0
> [19738.098433]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [19738.099243]
>                 -> #7 (&disk->open_mutex){+.+.}-{3:3}:
> [19738.100259]        __mutex_lock+0x92/0x900
> [19738.100865]        blkdev_get_by_dev.part.0+0x56/0x320
> [19738.101530]        swsusp_check+0x19/0x150
> [19738.102046]        software_resume.part.0+0xb8/0x150
> [19738.102678]        resume_store+0xaf/0xd0
> [19738.103181]        kernfs_fop_write_iter+0x140/0x1e0
> [19738.103799]        new_sync_write+0x122/0x1b0
> [19738.104341]        vfs_write+0x29e/0x3d0
> [19738.104831]        ksys_write+0x68/0xe0
> [19738.105309]        do_syscall_64+0x3b/0xc0
> [19738.105823]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [19738.106524]
>                 -> #6 (system_transition_mutex/1){+.+.}-{3:3}:
> [19738.107393]        __mutex_lock+0x92/0x900
> [19738.107911]        software_resume.part.0+0x18/0x150
> [19738.108537]        resume_store+0xaf/0xd0
> [19738.109057]        kernfs_fop_write_iter+0x140/0x1e0
> [19738.109675]        new_sync_write+0x122/0x1b0
> [19738.110218]        vfs_write+0x29e/0x3d0
> [19738.110711]        ksys_write+0x68/0xe0
> [19738.111190]        do_syscall_64+0x3b/0xc0
> [19738.111699]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [19738.112388]
>                 -> #5 (&of->mutex){+.+.}-{3:3}:
> [19738.113089]        __mutex_lock+0x92/0x900
> [19738.113600]        kernfs_seq_start+0x2a/0xb0
> [19738.114141]        seq_read_iter+0x101/0x4d0
> [19738.114679]        new_sync_read+0x11b/0x1a0
> [19738.115212]        vfs_read+0x128/0x1c0
> [19738.115691]        ksys_read+0x68/0xe0
> [19738.116159]        do_syscall_64+0x3b/0xc0
> [19738.116670]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [19738.117382]
>                 -> #4 (&p->lock){+.+.}-{3:3}:
> [19738.118062]        __mutex_lock+0x92/0x900
> [19738.118580]        seq_read_iter+0x51/0x4d0
> [19738.119102]        proc_reg_read_iter+0x48/0x80
> [19738.119651]        generic_file_splice_read+0x102/0x1b0
> [19738.120301]        splice_file_to_pipe+0xbc/0xd0
> [19738.120879]        do_sendfile+0x14e/0x5a0
> [19738.121389]        do_syscall_64+0x3b/0xc0
> [19738.121901]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [19738.122597]
>                 -> #3 (&pipe->mutex/1){+.+.}-{3:3}:
> [19738.123339]        __mutex_lock+0x92/0x900
> [19738.123850]        iter_file_splice_write+0x98/0x440
> [19738.124475]        do_splice+0x36b/0x880
> [19738.124981]        __do_splice+0xde/0x160
> [19738.125483]        __x64_sys_splice+0x92/0x110
> [19738.126037]        do_syscall_64+0x3b/0xc0
> [19738.126553]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [19738.127245]
>                 -> #2 (sb_writers#14){.+.+}-{0:0}:
> [19738.127978]        lo_write_bvec+0xea/0x2a0 [loop]
> [19738.128576]        loop_process_work+0x257/0xdb0 [loop]
> [19738.129224]        process_one_work+0x24c/0x5b0
> [19738.129789]        worker_thread+0x55/0x3c0
> [19738.130311]        kthread+0x155/0x180
> [19738.130783]        ret_from_fork+0x22/0x30
> [19738.131296]
>                 -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
> [19738.132262]        process_one_work+0x223/0x5b0
> [19738.132827]        worker_thread+0x55/0x3c0
> [19738.133365]        kthread+0x155/0x180
> [19738.133834]        ret_from_fork+0x22/0x30
> [19738.134350]
>                 -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
> [19738.135153]        __lock_acquire+0x130e/0x2210
> [19738.135715]        lock_acquire+0xd7/0x310
> [19738.136224]        flush_workqueue+0xb5/0x5b0
> [19738.136766]        drain_workqueue+0xa0/0x110
> [19738.137308]        destroy_workqueue+0x36/0x280
> [19738.137870]        __loop_clr_fd+0xb4/0x680 [loop]
> [19738.138473]        blkdev_put+0xc7/0x220
> [19738.138964]        close_fs_devices+0x95/0x220 [btrfs]
> [19738.139685]        btrfs_close_devices+0x48/0x160 [btrfs]
> [19738.140379]        generic_shutdown_super+0x74/0x110
> [19738.141011]        kill_anon_super+0x14/0x30
> [19738.141542]        btrfs_kill_super+0x12/0x20 [btrfs]
> [19738.142189]        deactivate_locked_super+0x31/0xa0
> [19738.142812]        cleanup_mnt+0x147/0x1c0
> [19738.143322]        task_work_run+0x5c/0xa0
> [19738.143831]        exit_to_user_mode_prepare+0x20c/0x210
> [19738.144487]        syscall_exit_to_user_mode+0x27/0x60
> [19738.145125]        do_syscall_64+0x48/0xc0
> [19738.145636]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [19738.146466]
>                 other info that might help us debug this:
> 
> [19738.147602] Chain exists of:
>                   (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex
> 
> [19738.149221]  Possible unsafe locking scenario:
> 
> [19738.149952]        CPU0                    CPU1
> [19738.150520]        ----                    ----
> [19738.151082]   lock(&lo->lo_mutex);
> [19738.151508]                                lock(&disk->open_mutex);
> [19738.152276]                                lock(&lo->lo_mutex);
> [19738.153010]   lock((wq_completion)loop0);
> [19738.153510]
>                  *** DEADLOCK ***
> 
> [19738.154241] 4 locks held by umount/508378:
> [19738.154756]  #0: ffff97a30dd9c0e8
> (&type->s_umount_key#62){++++}-{3:3}, at: deactivate_super+0x2c/0x40
> [19738.155900]  #1: ffffffffc0ac5f10 (uuid_mutex){+.+.}-{3:3}, at:
> btrfs_close_devices+0x40/0x160 [btrfs]
> [19738.157094]  #2: ffff97a31bc6d928 (&disk->open_mutex){+.+.}-{3:3},
> at: blkdev_put+0x3a/0x220
> [19738.158137]  #3: ffff97a31f64d4a0 (&lo->lo_mutex){+.+.}-{3:3}, at:
> __loop_clr_fd+0x5a/0x680 [loop]
> [19738.159244]
>                 stack backtrace:
> [19738.159784] CPU: 2 PID: 508378 Comm: umount Not tainted
> 5.15.0-rc2-btrfs-next-99 #1
> [19738.160723] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [19738.162132] Call Trace:
> [19738.162448]  dump_stack_lvl+0x57/0x72
> [19738.162908]  check_noncircular+0xf3/0x110
> [19738.163411]  __lock_acquire+0x130e/0x2210
> [19738.163912]  lock_acquire+0xd7/0x310
> [19738.164358]  ? flush_workqueue+0x8b/0x5b0
> [19738.164859]  ? lockdep_init_map_type+0x51/0x260
> [19738.165437]  ? lockdep_init_map_type+0x51/0x260
> [19738.165999]  flush_workqueue+0xb5/0x5b0
> [19738.166481]  ? flush_workqueue+0x8b/0x5b0
> [19738.166990]  ? __mutex_unlock_slowpath+0x45/0x280
> [19738.167574]  drain_workqueue+0xa0/0x110
> [19738.168052]  destroy_workqueue+0x36/0x280
> [19738.168551]  __loop_clr_fd+0xb4/0x680 [loop]
> [19738.169084]  blkdev_put+0xc7/0x220
> [19738.169510]  close_fs_devices+0x95/0x220 [btrfs]
> [19738.170109]  btrfs_close_devices+0x48/0x160 [btrfs]
> [19738.170745]  generic_shutdown_super+0x74/0x110
> [19738.171300]  kill_anon_super+0x14/0x30
> [19738.171760]  btrfs_kill_super+0x12/0x20 [btrfs]
> [19738.172342]  deactivate_locked_super+0x31/0xa0
> [19738.172880]  cleanup_mnt+0x147/0x1c0
> [19738.173343]  task_work_run+0x5c/0xa0
> [19738.173781]  exit_to_user_mode_prepare+0x20c/0x210
> [19738.174381]  syscall_exit_to_user_mode+0x27/0x60
> [19738.174957]  do_syscall_64+0x48/0xc0
> [19738.175407]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [19738.176037] RIP: 0033:0x7f4d7104fee7
> [19738.176487] Code: ff 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f
> 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 79 ff 0b 00 f7 d8 64 89
> 01 48
> [19738.178787] RSP: 002b:00007ffeca2fd758 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a6
> [19738.179722] RAX: 0000000000000000 RBX: 00007f4d71175264 RCX: 00007f4d7104fee7
> [19738.180601] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005615eb38bdd0
> [19738.181496] RBP: 00005615eb38bba0 R08: 0000000000000000 R09: 00007ffeca2fc4d0
> [19738.182376] R10: 00005615eb38bdf0 R11: 0000000000000246 R12: 0000000000000000
> [19738.183249] R13: 00005615eb38bdd0 R14: 00005615eb38bcb0 R15: 0000000000000000
