Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADA1470817
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 19:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhLJSLs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 13:11:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58140 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230284AbhLJSLs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 13:11:48 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAGHOND004713;
        Fri, 10 Dec 2021 18:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zQdUsEBoOsw5QDT656MFvYZM0Njz9us+0Gr84FXULXg=;
 b=LRb8FuVBvNrhRItdc62EQT7SnK70ps5P+pcSnL4YmkwpBgo1ps2G9kCqBp1yXH454qjQ
 P2g14ZmQTOdQJ5c/X3pbG6JVw1VepRuaLVQGJRWmAQtc3+6R9fKXxSq9dRICQfR99fWh
 G77mhDPWKykJXkXj81cPT84+3mwwwqsCHaCmDjbBCXE7S3g2LcoXdelKUXDLvKG7/bZ/
 rrPdGa6wd9rr7qwj8WxgPCAVjO5g1wyGgjfDLa8IzHjxoViGOBHD5K0x17breunJkA0p
 M2CWxMcHZ9sTlzMpratdV+q7ZDdC94zwbowQz0/l2WAkAXBsxmAutl8dMJH6eOiFyDZA mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cva9m08qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 18:08:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BAI4q0r042127;
        Fri, 10 Dec 2021 18:08:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3020.oracle.com with ESMTP id 3cr1suknv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 18:08:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPip1B1/7Fa2Q92klo9QnXU1UEMhTxkOeYtgXoncVuC5Y/tv5ZQjflNtLxTINOB8uONdKqY0jZZVulr/D1O0yYWAhWEh0l8JpDO073f/pstj+NlBTDaqeFMGoISg+SVyYKDAN/00VyhkoJxr72/rrIyL4kLcUWot7sGbvJTf7nVl4thSxUjD7yd2yJT6DLUeCQUikT9YUa9zfI8k/vaQV2jft1j+jXaxT/SwnaMEX6/cnYvOoijJMiIEKvn8nS0rwDZwci/M2n0h35AJjpCzIIbkM4rBim8+vTnvzjdcJcnpN3fZmoq1B2aYOZUI1oZG4OtqC0FxZR2tBjhNckA5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQdUsEBoOsw5QDT656MFvYZM0Njz9us+0Gr84FXULXg=;
 b=HKyu8k9HCjnsQLIAyVVKEnI1j3UUa6twhDZcQI21UFCNXMpU1nYXYIDLss2kAQaCPKQ5TBN++XZYmd54VCtXPMNLkmmcQU7Z2yoGckJStEf6AaaKTtwhAD9xmn3lNNUD+6rofKUp8/UEcm8RRPPJ4WTznIKrWr4szpk0Xuh4/gbPNao15JimIo7VBZq5vwRqPs73K72Z430TKkJjItKQVVzyoBD3O4FVEhrpJ9du9tXjpJGnoSF5tT0/9kE7dU2yjxlrKFKtt7AN4yCqT+F0wkobGwE5z899I3r1TZ2dJdw+UE7nPkwxwZdZxVybkmMUcYwNoc+ZfHkAPi5ZV0mLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQdUsEBoOsw5QDT656MFvYZM0Njz9us+0Gr84FXULXg=;
 b=rVw/tgVBZDLm9U8URwkP8EhJUVj+wfls0ehtV2mAFIreJw7CErHQZHMsHoauQ2qUYUH/ooCsNxT2RAW7pEDsvqVsmSWfu2Hw7fq+A63zDl5ecny3bNAhNEjChzaq5uzMa2SHAvcXSXXBjCbJnDytD7pNxYEeXsX2Ch1Dg6ye4hc=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4930.namprd10.prod.outlook.com (2603:10b6:208:323::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Fri, 10 Dec
 2021 18:08:08 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.026; Fri, 10 Dec 2021
 18:08:08 +0000
Message-ID: <d8f98f1e-c558-e700-7a83-f1cf8c0d3ae3@oracle.com>
Date:   Sat, 11 Dec 2021 02:07:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] btrfs/254: test cleaning up of the stale device
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <c1c22a67c90f1b0b94ea3f99d6d6fd4a4d5d5473.1638953165.git.anand.jain@oracle.com>
 <YbDGIWHVD4cmdZz0@localhost.localdomain>
 <5864b5a8-7572-1f43-b217-761bb6e4bfce@oracle.com>
 <YbISe4E9/Yr8OGFH@localhost.localdomain>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <YbISe4E9/Yr8OGFH@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0144.apcprd04.prod.outlook.com
 (2603:1096:3:16::28) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR04CA0144.apcprd04.prod.outlook.com (2603:1096:3:16::28) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 18:08:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 976326d8-ec1a-4827-0f1a-08d9bc0804f7
X-MS-TrafficTypeDiagnostic: BLAPR10MB4930:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4930261F8D338394B209132EE5719@BLAPR10MB4930.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbubL1qxLbb9IhEu2AVgqOlD+lUma2QdHiVNXev5fRRFKOJs07y5KN0lNUD4KNw8MMTQI7Bn0XXqe91QVFLpkvfWzEvhUAMkpg5DOtluYF90H8VTlnp8BOi6f2QJA3zHFOku45ZIJfEgChDd0YKXQAHFHZ84Xj+BBX18C2j3FqujkV3/eg6RI2Smd0rNh8FsqGZpJyeX2oDfas2Qd6+Ma5HYnzJ8g8c8qzxjzLO3wi+8v4WTFe6aFrESvEXh0TFxJHAUHh/DFOF44gEl8R4eFy+eYa8k9aAYxkc8AsAmZtOcktWCkDD8l6RJ4/Tv/r7ZaoUKnWAyvR9Te90Njk99xLY0CGhnqKm8GDGVsGaZ8dXUYrMGfKPx6SuT8WqpnHtnLdlV1/4baZU1Vu9Taxpi+h9wfxB1LovYdljQa/AegWKR0y2Vy6yvO86sw4fORCOOYj0RKc+3+CzswRt+ou31pXnbGOloQC7k8cH7x3xgVvoOtosWwPKGqWLGMWvPccoBje9kxqK8N4CTmGL/Mo7UdQIiPweYk8U1GKPDnq7C7w46qIOBYU5GuqAfJWMM0QBSU4a4DCWO6Pe1FPOYsiOyWSPLuoPxD/3Rq1xTQuiKwAjhIcvZTccXhYZaLbRS08xCpa2jiXMv1bFOuQ/+yRxJ34KUrO4mTOXwGtGxWFjihJzyT58+F6ByYbOMZO4Fe0PNo572jSOGKyl2tGBGwV5hiy/96aXP71U/dClim8IPu18l2fcE+n5cBjIit+ehe/cl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(16576012)(316002)(8676002)(956004)(31686004)(8936002)(31696002)(53546011)(2616005)(5660300002)(6486002)(26005)(83380400001)(86362001)(2906002)(4326008)(508600001)(186003)(44832011)(66946007)(66476007)(66556008)(36756003)(6916009)(6666004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0pmekxxd1hLcGtna3ltOTl5VDVoUmVCbTRGWUdZdFJMaGJqYjFtSGpQQ2pK?=
 =?utf-8?B?WmFaVGc4VFpEOGJQKzdjdGU4S1BvWURldElKcFZLTTMrSklHbnl5Z2xiZ3dJ?=
 =?utf-8?B?cmlzZmY2YWcvWVZocHNLSnhac2luWkNtN1oxb2NqZDBDeGV2djBVTVovZWZt?=
 =?utf-8?B?UDFxZ3AwRGtBQ05DSGZwcTdNc3RIVm1JUzNqWUs3Zk55KzBUZTZWVEpnRE9M?=
 =?utf-8?B?dWpRdWxyb1Q2VjdqVm1Ba3EwWmQ3RGRuanF2ejVxdGFjZTg2eFRqcm1JbXpU?=
 =?utf-8?B?MlFsVXlyNWU2UHRRdUJaWmwyRzZ4dUE3aGoweDU4ZlhOMkcxcEMzRXdXUDZq?=
 =?utf-8?B?ZmFaODJEMkZrL1B4NWtTeHkzandiQ2ZUcGVRTTVxVTE5dXRsTGY4UW13TVdt?=
 =?utf-8?B?S3RuWW8xbG1OaFZCTTBaamJESGkzNHB2ODhBc09SL0t0R2ZnenVVSkJoY1NW?=
 =?utf-8?B?bVJFMEJ1Q21yUnF6alhhOG1yRHV1NXZacmgzN3dFNit6MGZYS0ZSQ0tiZnNy?=
 =?utf-8?B?Vlkwby9RaHRjenVwYTZsQkVOQ3cyYzlVQXYrSCtPNzVKNXlSbCt5azRaak9C?=
 =?utf-8?B?a2xYWW8wby9CQklxOXRGV2kvcGdvbTlMNHRIbmZKTDlnQ09nSFFuNWErNHR2?=
 =?utf-8?B?bkZ0V3ZEVDIvcjhmSmZuMys1Rk5temRJOE9SSmhNVXlocnRZeFl3SkJqbDZx?=
 =?utf-8?B?YiszY2ZheEp4VkxYOEEzZzFwMzBlLy9ybUhZQ1BWVmtHQ0lsamYrc0hlTzJ5?=
 =?utf-8?B?cHFxR2NDTnc0dlV3VkhZdWpIdy9PTzBqbTdKYkVKUDNuazZ5UUl3WnJNMnFU?=
 =?utf-8?B?bGpGL1o5aGlHL1A4VWhXcURYbENqMkk4NUhJcDJLV0xHTVpmQUR1UVptMjRR?=
 =?utf-8?B?MlBaNVhidldtVjdCb2JJVWtLbmVtTlVJUElrSWk1eXhJUldtaHpKVDBhVzlK?=
 =?utf-8?B?NFpnby8rWm1pckZRUXZmRHFxQndmYTBUeW1wamIzckdPVndFSGFleC93TmVY?=
 =?utf-8?B?R1dMMW9IdWxoZ2FodkZ3elY4M25RbEczNlRzSnJrVWIydXZOcXVhckVyWVR0?=
 =?utf-8?B?MGsrVHV3YllUSGRYM0FZZVRWZ1kwNmROeW1IZ0F1Qk52bUpVb01saVB5citV?=
 =?utf-8?B?NWo2L0ZmL2x2RktsNVloNVg1RXAxQzhyV0JZa1VPNFViNGswd1U3S25FYk04?=
 =?utf-8?B?SVhSNkk2b0EybTg3NDBlRzkzZ1luYnVXU2RKWnFRaFc4SmF0VVg0OHJSYjM4?=
 =?utf-8?B?bERmTkVnTStPeEI3WWFpczFhRXhKS3dCZGJyV3VGVkxaRk4yS0gzMi9LdmJi?=
 =?utf-8?B?M05BbWlRV2VrYWlVQWJ3b3pELzBQU00xRHN1ZjN1OHUybmtQbTc2QUZhcXly?=
 =?utf-8?B?OVpvY0pmQysyY0g3M1FmNUdpR2pEbkY0OVZyR1N0by9JaXppVkV2emsvL2RJ?=
 =?utf-8?B?MWx6TnlkWmsyUTB6K041TEFlUFUyMTBJWFNUeTYrVlY1bjgwRnllSFZWQ2w0?=
 =?utf-8?B?SGsrcGhCL3YzUEpBMlA5NzJYQXBVdTYzMGxhekhOSXkyeDdTZ29ETUhRbkpn?=
 =?utf-8?B?WW56R0lteDZxYWZVSXNVMEoxaURXM3FpaEZEaStKREhXSFoxdnVUeWhCc3Rs?=
 =?utf-8?B?bGM1OTJXb3VyRE1JbGwrWE1COERXVXlJUEdFYmV5a0hsa1g1WjV0NklpOUoz?=
 =?utf-8?B?UjdzQmJKampRNWNyWGovZDZMN0hzNGJnNHhLbGxuUUhlTlg0U2NBa05DdXJH?=
 =?utf-8?B?aUIyTmRVTVhxUCtEUTFsbm1WUlZOV3htbElRbnRLcWFmenN6aHUvdGl4UzBB?=
 =?utf-8?B?ZkZPRk9ndDBDVVNadFlNajUvVmZKZUpqbkVRUW16R2VrYnlIZDhnYW5EdUJ4?=
 =?utf-8?B?TDJkYkx3ZVRVZjVwRGJmSmxPbTVFK01qMmRlSjRsUllyMEdjVklEZktjK0d4?=
 =?utf-8?B?THU2M1RGZTB2NVp0a1ZJYTErWnM5T05BS1llQk1yYktQRC9HM21FV3FXc1dr?=
 =?utf-8?B?QTVDOU1CYnNQc0oveU1UOTJyeW5ldWpVQ0pOT1ZVV0lzdWs2d0ZjMGdaZTZI?=
 =?utf-8?B?UUdZV2dyNHdxQi9JTG5ienQrc1FVbUkvOVI1QWlZc0M0ODVIMnlLRERyblFK?=
 =?utf-8?B?TU1KUVZYQVUzc0tDL0d0WkRXZ3JKOWltdTRRdThRZ3RGZWMxRmVSUStEeVV1?=
 =?utf-8?Q?nsiyGGOSJCl83n6Mc2ihdZA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976326d8-ec1a-4827-0f1a-08d9bc0804f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 18:08:08.2445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXX/9rtniCLeudNpZa9QEpS0xMpWTPtvmKVAxmDdFYDboEshwdo6bR0UAZhVCU0QgP8E4CH8B261RqswYHetuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4930
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10194 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100102
X-Proofpoint-ORIG-GUID: uqKOCw-tTjJSeb90wiIwbNMa0k84qOYB
X-Proofpoint-GUID: uqKOCw-tTjJSeb90wiIwbNMa0k84qOYB
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/12/2021 22:28, Josef Bacik wrote:
> On Thu, Dec 09, 2021 at 02:41:22PM +0800, Anand Jain wrote:
>> On 08/12/2021 22:50, Josef Bacik wrote:
>>> On Wed, Dec 08, 2021 at 10:07:46PM +0800, Anand Jain wrote:
>>>> Recreating a new filesystem or adding a device to a mounted the filesystem
>>>> should remove the device entries under its previous fsid even when
>>>> confused with different device paths to the same device.
>>>>
>>>> Fixed by the kernel patch (in the ml):
>>>>     btrfs: harden identification of the stale device
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>>    tests/btrfs/254     | 110 ++++++++++++++++++++++++++++++++++++++++++++
>>>>    tests/btrfs/254.out |   6 +++
>>>>    2 files changed, 116 insertions(+)
>>>>    create mode 100755 tests/btrfs/254
>>>>    create mode 100644 tests/btrfs/254.out
>>>>
>>>> diff --git a/tests/btrfs/254 b/tests/btrfs/254
>>>> new file mode 100755
>>>> index 000000000000..6c3414f73d15
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/254
>>>> @@ -0,0 +1,110 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (c) 2021 Anand Jain. All Rights Reserved.
>>>> +# Copyright (c) 2021 Oracle. All Rights Reserved.
>>>> +#
>>>> +# FS QA Test No. 254
>>>> +#
>>>> +# Test if the kernel can free the stale device entries.
>>>> +#
>>>
>>> Can you include the patch name here as well, it makes it easier when I'm
>>> rebasing our staging branch to figure out if I need to disable a new test for
>>> our overnight runs.
>>
>>   Ok. I will include.
>>
>>>> +. ./common/preamble
>>>> +_begin_fstest auto quick
>>>> +
>>>> +# Override the default cleanup function.
>>>> +node=$seq-test
>>>> +cleanup_dmdev()
>>>> +{
>>>> +	_dmsetup_remove $node
>>>> +}
>>>> +
>>>> +_cleanup()
>>>> +{
>>>> +	cd /
>>>> +	rm -f $tmp.*
>>>> +	rm -rf $seq_mnt > /dev/null 2>&1
>>>> +	cleanup_dmdev
>>>> +}
>>>> +
>>>> +# Import common functions.
>>>> +. ./common/filter
>>>> +. ./common/filter.btrfs
>>>> +
>>>> +# real QA test starts here
>>>> +_supported_fs btrfs
>>>> +_require_scratch_dev_pool 3
>>>> +_require_block_device $SCRATCH_DEV
>>>> +_require_dm_target linear
>>>> +_require_btrfs_forget_or_module_loadable
>>>> +_require_scratch_nocheck
>>>> +_require_command "$WIPEFS_PROG" wipefs
>>>> +
>>>> +_scratch_dev_pool_get 3
>>>> +
>>>> +setup_dmdev()
>>>> +{
>>>> +	# Some small size.
>>>> +	size=$((1024 * 1024 * 1024))
>>>> +	size_in_sector=$((size / 512))
>>>> +
>>>> +	table="0 $size_in_sector linear $SCRATCH_DEV 0"
>>>> +	_dmsetup_create $node --table "$table" || \
>>>> +		_fail "setup dm device failed"
>>>> +}
>>>> +
>>>> +# Use a known it is much easier to debug.
>>>> +uuid="--uuid 12345678-1234-1234-1234-123456789abc"
>>>> +lvdev=/dev/mapper/$node
>>>> +
>>>> +seq_mnt=$TEST_DIR/$seq.mnt
>>>> +mkdir -p $seq_mnt
>>>> +
>>>> +test_forget()
>>>> +{
>>>> +	setup_dmdev
>>>> +	dmdev=$(realpath $lvdev)
>>>> +
>>>> +	_mkfs_dev $uuid $dmdev
>>>> +
>>>> +	# Check if we can un-scan using the mapper device path.
>>>> +	$BTRFS_UTIL_PROG device scan --forget $lvdev
>>>> +
>>>> +	# Cleanup
>>>> +	$WIPEFS_PROG -a $lvdev > /dev/null 2>&1
>>>> +	$BTRFS_UTIL_PROG device scan --forget
>>>> +
>>>> +	cleanup_dmdev
>>>> +}
>>>> +
>>>> +test_add_device()
>>>> +{
>>>> +	setup_dmdev
>>>> +	dmdev=$(realpath $lvdev)
>>>> +	scratch_dev2=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
>>>> +	scratch_dev3=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
>>>> +
>>>> +	_mkfs_dev $scratch_dev3
>>>> +	_mount $scratch_dev3 $seq_mnt
>>>> +
>>>> +	_mkfs_dev $uuid -draid1 -mraid1 $dmdev $scratch_dev2
>>>> +
>>>> +	# Add device should free the device under $uuid in the kernel.
>>>> +	$BTRFS_UTIL_PROG device add -f $lvdev $seq_mnt
>>>> +
>>>
>>> You need to redirect this to /dev/null, otherwise we get the TRIM message with
>>> newer btrfs-progs.
>>>
>>
>>    Ok.
>>
>>
>>>> +	_mount -o degraded $scratch_dev2 $SCRATCH_MNT
>>>> +
>>>> +	# Check if the missing device is shown.
>>>> +	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>>>> +					_filter_btrfs_filesystem_show
>>>> +
>>>> +	$UMOUNT_PROG $seq_mnt
>>>> +	_scratch_unmount
>>>> +	cleanup_dmdev
>>>> +}
>>>> +
>>>> +test_forget
>>>> +test_add_device
>>>> +
>>>> +_scratch_dev_pool_put
>>>> +
>>>> +status=0
>>>> +exit
>>>> diff --git a/tests/btrfs/254.out b/tests/btrfs/254.out
>>>> new file mode 100644
>>>> index 000000000000..20819cf5140c
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/254.out
>>>> @@ -0,0 +1,6 @@
>>>> +QA output created by 254
>>>> +Label: none  uuid: <UUID>
>>>> +	Total devices <NUM> FS bytes used <SIZE>
>>>> +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>>>> +	*** Some devices missing
>>>
>>> I ran this on a box without your fix and I got this failure
>>>
>>> [root@xfstests2 xfstests-dev]# cat /xfstests-dev/results//kdave/btrfs/254.out.bad
>>> QA output created by 254
>>
>>> ERROR: cannot unregister device '/dev/mapper/254-test': No such file or directory
>>
>>   Without the fix the error is expected.
>>
>>> Label: none  uuid: <UUID>
>>>           Total devices <NUM> FS bytes used <SIZE>
>>>           devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>>>           *** Some devices missing
>>>
>>> Is this what you're expecting?
>>
>>   Hmm, no. Without the fix, we shouldn't see the missing here.
>>
>>> I was expecting to not see the "*** Some devices
>>> missing" part as well, but I guess that's the racier part?
>>
>>   Right. I am guessing race with udev auto scan?
>>
> 
> Yeah that's what I'm assuming, since the original problem I had was transient, I
> just want to make sure that's what I'm seeing and not that the test isn't quite
> right.  As long as it fails we're good, but it makes me nervous when the
> expectected output matches the failure case so I wanted to double check.
> 
>>> It does fail properly without the patch and pass with your patch, so as long as
>>> this is what you expect to see then I'm good with this part.  Thanks,
>>
>>   Yeah, we shouldn't see missing device _without_ the fix.
>>   Could you please share your xfstests config?
>>
> 
> Yup, its the following, I was using -s btrfs_normal
> 
> [btrfs_normal]
> TEST_DIR=/mnt/test
> TEST_DEV=/dev/mapper/vg0-lv0
> SCRATCH_DEV_POOL="/dev/mapper/vg0-lv9 /dev/mapper/vg0-lv8 /dev/mapper/vg0-lv7 /dev/mapper/vg0-lv6 /dev/mapper/vg0-lv5 /dev/mapper/vg0-lv4 /dev/mapper/vg0-lv3 /dev/mapper/vg0-lv2 /dev/mapper/vg0-lv1 "
> SCRATCH_MNT=/mnt/scratch
> LOGWRITES_DEV=/dev/mapper/vg0-lv10
> PERF_CONFIGNAME=jbacik
> MKFS_OPTIONS="-K -O ^no-holes -R ^free-space-tree"
> MOUNT_OPTIONS="-o discard=async"
> 
> [btrfs_compression]
> MOUNT_OPTIONS="-o compress=zstd,discard=async"
> MKFS_OPTIONS="-K -O ^no-holes -R ^free-space-tree"
> 
> Weirdly compression would pass sometimes without the fix applied, so using -s
> btrfs_compression.  IDK why, clearly this is a weird problem and depends on udev
> timing, but maybe take another look?  Thanks,


Sure.

I guess the udev rule in this file is playing the trick.
--------
$ cat /usr/lib/udev/rules.d/64-btrfs-dm.rules

SUBSYSTEM!="block", GOTO="btrfs_end"
KERNEL!="dm-[0-9]*", GOTO="btrfs_end"
ACTION!="add|change", GOTO="btrfs_end"
ENV{ID_FS_TYPE}!="btrfs", GOTO="btrfs_end"

# Once the device mapper symlink is created, tell btrfs about it
# so we get the friendly name in /proc/mounts (and tools that read it)
ENV{DM_NAME}=="?*", RUN{builtin}+="btrfs ready /dev/mapper/$env{DM_NAME}"

LABEL="btrfs_end"
--------

I tried to find if I could disable the udev scan, can't find a way yet.

However, if we flip the lv path and dm path, then the udev scan will be 
ineffective because we already have that path in the kernel.

I could reproduce the bug without the fix in the kernel patch.

-------------
$ cat <...>254.out.bad

QA output created by 254
ERROR: cannot unregister device '/dev/mapper/254-test': No such file or 
directory
Label: none  uuid: <UUID>
         Total devices <NUM> FS bytes used <SIZE>
         devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/254-test
         devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-------------


I have made this change in v2. Could you please give it a try.

Also, I have accepted the above two review comments.

Thanks, Anand


