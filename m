Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F6E3F6B88
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 00:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbhHXWJL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 18:09:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61128 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235507AbhHXWJK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 18:09:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17OJtEIN001055;
        Tue, 24 Aug 2021 22:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Hd8aPCCthDqNRKqRaHXXkYCBiW8N7CBzX5rpq4KNiyA=;
 b=jn1C/hJkF0FFJ7pQ8W1r31JO9vYYJKte0SAzLffoJQqA6Rgc5dZcnmVWk+Uf9gLfRnc3
 M5MXNspngxFgYOTDmZPUmJr7VZCJFGL4MeXJEZHMJlYQnU/Q1CgvhPcGBIBZZEpXE8wI
 7eiJSJCM6ScHYkM9JqbnJqp7KBsfmPeC41h25Kxfh5sRKCpdZKl7ggZXYEAmGJY6v8du
 Xs5nUM50BsnPFw8Axgj15g/TCNNqg/L/b7qXHxSbIRfNzca4W5xsI+nitvNi8BBUwy7z
 QqYE3H7UqzE100sxj8mURgFs0BkmRcibtTWAgS/yuBm6jTegCmedAGxQlMTdqPj10H2m 0g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Hd8aPCCthDqNRKqRaHXXkYCBiW8N7CBzX5rpq4KNiyA=;
 b=hRh3lD2fHABP1zyw0fNk6hL4uF44q2mHUsbQSiqnRFP1qUEzm+/ZZJjzjdl4nBcxFhWI
 CG5I7YgJylKqLLwl5TyL6O7o3hIC0HpJ8eNqE8uS1tYIHaZbDm9BxmdwkPM2eiqa7+JC
 Xolzvi7IajqwP96MFwAqq2CpJTiyhp0uBuL1zonHj/01Ed636PD3iIDfKb7O0m7puC4E
 OkFETBcgl4qEbnDtfz0zo/48UlAJs6rUfoMOhwKnCEPgKiOwlUYsZfBI7ci2/TBON936
 kZunksWHZhUsIr5yrHXop6SgZIoIPAu4oIf9+UgCkIwT3Wr3+/w07NzHpiTFLVe3oNYP LA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amvtvt37x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 22:08:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17OM5ZV9120081;
        Tue, 24 Aug 2021 22:08:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3030.oracle.com with ESMTP id 3ajpky3du8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 22:08:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSPPpwRhZ1H95hqTCTAJ3g2hRa8+XzUJmcJVnYCUzisvs6cOL+poBfvqVL4dky3cvcCWTXbKcKyDM9bPVKsUnXCuiFYri0nIALm1QWKKSTXrk3caejLB5E6W65uBAD0cxIkttwuUBtlYoovkhgcW2RYAj8P5IMwj938buM3L9AxGg13TjCsfEdm+AzqrozikkXyXM2TqlAgjO9LTaIopjEzIBoH0f1UcGvXHdycyc1Lxt21YHvXTlVGGq1RRluzCycJErc54yges+UUL3A3QEbUsBU/u4s82DfWdLD3AW6lzl24K7dZB0wslajm8x28lP3hB/DeqPTmm07ULt3ETDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hd8aPCCthDqNRKqRaHXXkYCBiW8N7CBzX5rpq4KNiyA=;
 b=bhjQPKcaoSZ6QHPylSf0fYPF1nr5GcTupqDQFp1r+n/Jndhyo9CXaGIlY/ofdHD+SAlrgyK97b9Ko2iKvLsfQ2/0zuhH8pznFWct8QjXYZPdSSqpGodyaNzwsjGADvLsBAH7POYs2pkHDwN105WqwM2U24AgaG2AIiFO2Vy9mu0iwCMvHFnUPUzIieZz7K02JwfscuyAYDhwquBoC9DEFRxX+cu/ZQRyNlC7o3PexmPd+VrZsNrRVmIMDBCDkbBjacZgdFY20Kh/FGVX6JhME0XzvYKQuYMLSuLrkcm7ffS+5g3WM6ugEUjbUjonV2bEvnSK1n3OD5HXBXyQRHu+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hd8aPCCthDqNRKqRaHXXkYCBiW8N7CBzX5rpq4KNiyA=;
 b=KBplI3NvXSCAdrl77/JdqaqoHK0ccCvADDitJXX1q2wJh4qMw5zYk6Ior4ws9+YGm86/yYyAeJHQ4DJVHYnolhXyiLXJaEBdwoIGttLfUMHiQqJdhEivM7DSgXlMgmC5mMYp77SN2rYtIycevbfoioGzMwtCWMcwLMC6xT1/Jjk=
Authentication-Results: damenly.su; dkim=none (message not signed)
 header.d=none;damenly.su; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3853.namprd10.prod.outlook.com (2603:10b6:208:180::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Tue, 24 Aug
 2021 22:08:10 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 22:08:10 +0000
Subject: Re: [PATCH v2 7/7] btrfs: do not take the device_list_mutex in
 clone_fs_devices
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
References: <cover.1627419595.git.josef@toxicpanda.com>
 <c3eb810f0b0505757dd2733531c9338c99b8444a.1627419595.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Su Yue <l@damenly.su>
Message-ID: <f07eb0d0-38db-0d34-7d77-1039e6f53ae7@oracle.com>
Date:   Wed, 25 Aug 2021 06:08:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <c3eb810f0b0505757dd2733531c9338c99b8444a.1627419595.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:3:17::24) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0012.apcprd02.prod.outlook.com (2603:1096:3:17::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 22:08:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 764ee5aa-ae3a-406b-9b91-08d9674ba8e9
X-MS-TrafficTypeDiagnostic: MN2PR10MB3853:
X-Microsoft-Antispam-PRVS: <MN2PR10MB38532D97931F42700AD6F500E5C59@MN2PR10MB3853.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSUYfowxW0jHY57YPmVGiahq8cBMOPt8lHSk0sIsOA9hYi8deH2puz2RG3JAOlYjBUURrYdRwo0VN8YeJkjYz2mlj/OjBwD4ahD8lX5H3SLsniGSE39wRR4w49CXJ6zCL4H+rS1The0ijYk1V6NwCh8G9fq3z0gwUrwBk7Muvil4vGB+XbeKxURyyXag2BVOBs9JHV88Dkiv+zVrJMCCiOngK9WQKtS1WYW8skFkRYOnCac19hP3jD+EsGwoyB7rINBtOUaU7EqTDFF+zdbSUDoqkah3NhsAzTDrZjQIFQTGmtoe3eUnSsP+fjoR9ZDGMPz1FDVP/LnI7RVp7WTLLwhOXXBdQhedoId4Su5rIHYgOCQw0/tCi9+9SlOx/w49DWHHYPJJOKYr4AmsBKj7It8h/Ph0JI1fL5JFI37rBLdeTImLaQAYsnWptUQcFNfzJZoXfUWoHNXvQw1C8APJovu3U8pN6udvE9co+Ue21VMyVRCuGfHG0W6E3Fn7CFhqaGwV8m+ta2V6Isq32bhOeSKCOg+V9/ndXsvW34cDvo3FlyxpOxQlwRU73wjgq3i0CmXn8vyofsi4Y+OMzEQhvIeCPa8YCs2rZXuEK2yQzyxtR0IfRBMBrcE4JPY4eMBOvubgmL92NKCKjFDHN15nf28C5I+PXUsOo3dlcDlA0AWj8VDt+lL6fmKCH1Qd8usBhEznSjh0t+H3SJq/OcLxJ6hLeI67xs6DQTXwlC/HnePjlVmtpt4kmPGYEedP+lZN+S5CwPPsWgJbJPeLVXaPdAIf/z1eITfvPxbR+RHc+hnUJZ3vpdWztI/EXJDvPIbr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(508600001)(66476007)(5660300002)(316002)(16576012)(6486002)(110136005)(38100700002)(44832011)(2616005)(66556008)(956004)(31686004)(4326008)(53546011)(966005)(8676002)(66946007)(2906002)(31696002)(86362001)(8936002)(186003)(26005)(83380400001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1RQRllXNlNPSUsrSkVlRTlKd2VaQUt6NlFhRjd5bTBmd2xUd1paNEE1K2ta?=
 =?utf-8?B?VEJRN3dSWVBMMUUzV01VWE05TjNDZVd3bUdoQndQSloyQmFaNmZRZHZuMENz?=
 =?utf-8?B?QnNxMExBSHhHWC9UZFZjVkJaZnlqWlhVM0s5emxiMmo5SmdIa2pyUkZVclhE?=
 =?utf-8?B?QS9GYkJkNGJmMytsRWdCejZIRGZUU1ZCODdzcHBpMXczclZvQzJYdVVMcWh6?=
 =?utf-8?B?M0d0MDdJUjh4RWVFOTVxd3VBUEJsSVFoMHNRaTZmVThtYWRPTVVweVY0UEJj?=
 =?utf-8?B?elpWdU5CMmVldmU4U3lONDRHSDltOVB4NXAxREF6dk85THdjSTlFWE5NVUpD?=
 =?utf-8?B?ME9iT2ZwcXpVNjNkSDg2cjBtbHNQQWk2TzcycFRwQ2lvMU0zd2Q2a1pFTFlG?=
 =?utf-8?B?MzlsSjZCYXJxWjFDeW1CbTl2bHhDN2ZIeG1XOXhZYVNRV0JWWVlzZTdPY1Zq?=
 =?utf-8?B?NVI1Y1ptSzk5eFp6V0dZOFR6TGhMNFFkdm5Eb09qMWNtbEh2YnM1UElPdzRW?=
 =?utf-8?B?OWhLZTVxejZDVEVoUXBFYm5rWU96VEtmZ3VXUCtFallzUFJvZ0EwQ0pNQ0Iz?=
 =?utf-8?B?L1NZY05iTVZPSjFlL01wTDZPcU1jQ0l0UzZlMGhMQWdwYmhJQlQ2YWhkM2VK?=
 =?utf-8?B?YmlVY0pLd0VVRUNyUzA3bFJ1RGp2b0QydW9XL3pDMHlxcEk5WHFIdExkN0NV?=
 =?utf-8?B?L1JTRTg0b3F3bTg3VElYbHFDa0dqWjlWUTFneFk1aThTR0pmR0s4cVRHaHJr?=
 =?utf-8?B?Z3JQOGZCdEdNYXhCSmRVeGZ2ajN6UThTNm9USGdGTjRrYnVIYjNYKzh0ek9w?=
 =?utf-8?B?M1h6Z0YyZkVqQlh2b2F5bmVyRWliak1YZ1VLMmR4L0dBYVBleVJLUmNHNDd6?=
 =?utf-8?B?MElDUGdEZGhmYlcrb0E2NTY5eEZkcHhpQkJxRko1UGZZZ2tKYzFVejdWVWlC?=
 =?utf-8?B?NGx4NVJ0UUlGcVFQaTRkTjgrSmFObHo4bE9ZMjRmekJuRVlJdWVGa0VISm1s?=
 =?utf-8?B?YldZNzkvKzZnZFVrcjJuQlZNa1RYR3hoOFdxOC9zelEyY1dKRjI0alZQWXg0?=
 =?utf-8?B?WTY2YzJJekdWRm93QXc4TkZFR1MzcTc4TnVJU3VTZm1IeXlXV1VSUlRvUXU2?=
 =?utf-8?B?a21WQmM4dXIyMXJjelpmdzdVUnpSaEMvZkRwTVZzdWdOQ3R1KytGeDE4U2U1?=
 =?utf-8?B?TjdTMXh5OTlxRW04MnM2aFA2bXZuajVjeEUwbUNONktwK0VqeGZMdmljL0M2?=
 =?utf-8?B?Ri8xeWhHK0paandYam44RFFDdVAyRU1GU2FILzFsYXd1bWJBM3NyMDlYUzNZ?=
 =?utf-8?B?MnpOYk42bmlTYUN3UWZ5SldiamxSdHlBNzF5UkI4S3dBcHdGWmhibGNhWDBJ?=
 =?utf-8?B?cThibGgyME9TUjU4MTdidk9COHNWakRmTmlPMHBDM0RkS2dkeDdjYkN2L05i?=
 =?utf-8?B?SHVTSG1TclZPeUdDejlaMlJUYXFKVmNPOXR6VW9aaU1ZOU5PeDBVMjE2WWdY?=
 =?utf-8?B?cDExWU1xWW90WVhyQzZkUmNPVnl5SW9FT3R2TG5SdGlPTEp6cDdmMkx6a0RJ?=
 =?utf-8?B?YmdqRDQxVHFlNzUzMGg4Z1dxVmxoUHA1Qm1PQTUzOXU5Nmg4OHFhVzN0S0N1?=
 =?utf-8?B?OURicmVaUlIvQmo3NDBkYjNLdkFRS0tOVkFLbUxuejRVSC9jSWVwYWJCTXFl?=
 =?utf-8?B?bGp6bGx0TEVlZXdiV0F0Tm9OVENpRFhXNmR2eUJ1QWlub3F1ZlkxWVZuUTBy?=
 =?utf-8?Q?irkzheVaAXFC7/KhRELbzgTebqds4917KYMd/3o?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764ee5aa-ae3a-406b-9b91-08d9674ba8e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 22:08:10.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+qvkDrag2ylbmx2cFiy/cCKsE2qEwYkjWi2v5n1ygxo/KIAY7FIDK4uyrjxW6lUCbVn3LLTU4qye/sViqva5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3853
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240138
X-Proofpoint-ORIG-GUID: fezBJ2h3sHhhR2wPl-aH2NRPOSLac8zT
X-Proofpoint-GUID: fezBJ2h3sHhhR2wPl-aH2NRPOSLac8zT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28/07/2021 05:01, Josef Bacik wrote:
> I got the following lockdep splat while testing seed devices
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.14.0-rc2+ #409 Not tainted
> ------------------------------------------------------
> mount/34004 is trying to acquire lock:
> ffff9eaac48188e0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: clone_fs_devices+0x4d/0x170
> 
> but task is already holding lock:
> ffff9eaac766d438 (btrfs-chunk-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x24/0x100
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (btrfs-chunk-00){++++}-{3:3}:
>         down_read_nested+0x46/0x60
>         __btrfs_tree_read_lock+0x24/0x100
>         btrfs_read_lock_root_node+0x31/0x40
>         btrfs_search_slot+0x480/0x930
>         btrfs_update_device+0x63/0x180
>         btrfs_chunk_alloc_add_chunk_item+0xdc/0x3a0
>         btrfs_chunk_alloc+0x281/0x540
>         find_free_extent+0x10ca/0x1790
>         btrfs_reserve_extent+0xbf/0x1d0
>         btrfs_alloc_tree_block+0xb1/0x320
>         __btrfs_cow_block+0x136/0x5f0
>         btrfs_cow_block+0x107/0x210
>         btrfs_search_slot+0x56a/0x930
>         btrfs_truncate_inode_items+0x187/0xef0
>         btrfs_truncate_free_space_cache+0x11c/0x210
>         delete_block_group_cache+0x6f/0xb0
>         btrfs_relocate_block_group+0xf8/0x350
>         btrfs_relocate_chunk+0x38/0x120
>         btrfs_balance+0x79b/0xf00
>         btrfs_ioctl_balance+0x327/0x400
>         __x64_sys_ioctl+0x80/0xb0
>         do_syscall_64+0x38/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
>         __mutex_lock+0x7d/0x750
>         btrfs_init_new_device+0x6d6/0x1540
>         btrfs_ioctl+0x1b12/0x2d30
>         __x64_sys_ioctl+0x80/0xb0
>         do_syscall_64+0x38/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
>         __lock_acquire+0x10ea/0x1d90
>         lock_acquire+0xb5/0x2b0
>         __mutex_lock+0x7d/0x750
>         clone_fs_devices+0x4d/0x170
>         btrfs_read_chunk_tree+0x32f/0x800
>         open_ctree+0xae3/0x16f0
>         btrfs_mount_root.cold+0x12/0xea
>         legacy_get_tree+0x2d/0x50
>         vfs_get_tree+0x25/0xc0
>         vfs_kern_mount.part.0+0x71/0xb0
>         btrfs_mount+0x10d/0x380
>         legacy_get_tree+0x2d/0x50
>         vfs_get_tree+0x25/0xc0
>         path_mount+0x433/0xb60
>         __x64_sys_mount+0xe3/0x120
>         do_syscall_64+0x38/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    &fs_devs->device_list_mutex --> &fs_info->chunk_mutex --> btrfs-chunk-00
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(btrfs-chunk-00);
>                                 lock(&fs_info->chunk_mutex);
>                                 lock(btrfs-chunk-00);
>    lock(&fs_devs->device_list_mutex);
> 
>   *** DEADLOCK ***
> 
> 3 locks held by mount/34004:
>   #0: ffff9eaad75c00e0 (&type->s_umount_key#47/1){+.+.}-{3:3}, at: alloc_super+0xd5/0x3b0
>   #1: ffffffffbd2dcf08 (uuid_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x59/0x800
>   #2: ffff9eaac766d438 (btrfs-chunk-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x24/0x100
> 
> stack backtrace:
> CPU: 0 PID: 34004 Comm: mount Not tainted 5.14.0-rc2+ #409
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> Call Trace:
>   dump_stack_lvl+0x57/0x72
>   check_noncircular+0xcf/0xf0
>   __lock_acquire+0x10ea/0x1d90
>   lock_acquire+0xb5/0x2b0
>   ? clone_fs_devices+0x4d/0x170
>   ? lock_is_held_type+0xa5/0x120
>   __mutex_lock+0x7d/0x750
>   ? clone_fs_devices+0x4d/0x170
>   ? clone_fs_devices+0x4d/0x170
>   ? lockdep_init_map_type+0x47/0x220
>   ? debug_mutex_init+0x33/0x40
>   clone_fs_devices+0x4d/0x170
>   ? lock_is_held_type+0xa5/0x120
>   btrfs_read_chunk_tree+0x32f/0x800
>   ? find_held_lock+0x2b/0x80
>   open_ctree+0xae3/0x16f0
>   btrfs_mount_root.cold+0x12/0xea
>   ? rcu_read_lock_sched_held+0x3f/0x80
>   ? kfree+0x1f6/0x410
>   legacy_get_tree+0x2d/0x50
>   vfs_get_tree+0x25/0xc0
>   vfs_kern_mount.part.0+0x71/0xb0
>   btrfs_mount+0x10d/0x380
>   ? kfree+0x1f6/0x410
>   legacy_get_tree+0x2d/0x50
>   vfs_get_tree+0x25/0xc0
>   path_mount+0x433/0xb60
>   __x64_sys_mount+0xe3/0x120
>   do_syscall_64+0x38/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f6cbcd9788e
> 
> It is because we take the ->device_list_mutex in this path while holding
> onto the tree locks in the chunk root.  However we do not need the lock
> here, because we're already holding onto the uuid_mutex, and in fact
> have removed all other uses of the ->device_list_mutex in this path
> because of this.  Remove the ->device_list_mutex locking here, add an
> assert for the uuid_mutex and the problem is fixed.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f622e93a6ff1..bdfcc35335c3 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1000,11 +1000,12 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>   	struct btrfs_device *orig_dev;
>   	int ret = 0;
>   
> +	lockdep_assert_held(&uuid_mutex);
> +
>   	fs_devices = alloc_fs_devices(orig->fsid, NULL);
>   	if (IS_ERR(fs_devices))
>   		return fs_devices;
>   
> -	mutex_lock(&orig->device_list_mutex);
>   	fs_devices->total_devices = orig->total_devices;
>   
>   	list_for_each_entry(orig_dev, &orig->devices, dev_list) {
> @@ -1036,10 +1037,8 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>   		device->fs_devices = fs_devices;
>   		fs_devices->num_devices++;
>   	}
> -	mutex_unlock(&orig->device_list_mutex);
>   	return fs_devices;
>   error:
> -	mutex_unlock(&orig->device_list_mutex);
>   	free_fs_devices(fs_devices);
>   	return ERR_PTR(ret);
>   }
> 


  This fix is same as in [1]

  [1]
 
https://patchwork.kernel.org/project/linux-btrfs/patch/23a8830f3be500995e74b45f18862e67c0634c3d.1614793362.git.anand.jain@oracle.com/





