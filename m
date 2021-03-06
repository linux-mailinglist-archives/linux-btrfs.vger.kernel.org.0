Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FDA32F8FD
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Mar 2021 09:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhCFIiU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Mar 2021 03:38:20 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44590 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhCFIhs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Mar 2021 03:37:48 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1268a95W053874;
        Sat, 6 Mar 2021 08:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=TwnwWVfbxeXIv9Xit1MdKgFrLIrMJiIs9gvTrIGEpx8=;
 b=PoX+lVf4VU0qNIH3OujnBtepThoKRCqxgRpPyhXpERNAHxXrbehN+nY79Sq1vkWgUj8k
 8IUmYWOruQUZX4ekJLete2llejXPOfF8CJ2EHdSOu3U+5CnXaJ7fA7GjyI3CBlNr+oEG
 d1YV8P0Nl1pCIqMoThLRQdRFvnlkfFD3svYVewekOWcYU5enShzAlcUx3MEtvyXx07bY
 N7XwURQ0uH2Gq23Fy3THDLXqzXP9tNhKL9OQ0xTPWQfFPKnHeWbxt7Al4OsF2CEekvZz
 dxOh0sxhcFdzhJA7VOGDuzxNtBDryzC61bkhLlDWNYp6UqqY4rNT1eVsDfOAJSRDr5HH nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 373y8bgbjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 Mar 2021 08:37:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1268Ylcq164903;
        Sat, 6 Mar 2021 08:37:35 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2057.outbound.protection.outlook.com [104.47.36.57])
        by userp3020.oracle.com with ESMTP id 37412hpatv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 Mar 2021 08:37:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5gY+teDIwrSh+Uhoc0x/w7H9gEMxj7O3ZcuMgdhXcQwpNtW59KbPiRUryHyLYLXOHFwCkNo3gaR7b1tf6JM5BJTdG9jXr005V+cB0e1hTiN/mkI1S4U5Z7ndhfruQy/8qCtyGSC8NI2edzW/lLa1FvIXtvk+qQGOgDfjvbe7TRTZq41mtPrzJP8I60n+rWGhpNObQQc+t2Dz6+3Q3MaZ9QBeC7aPw557FYMtqTGjqPQ8ydETiUo+NOIfIN4EJ5iA8CGN6wejaCyOXKY4aFdisaSoUz0He03NvpkEvECQYETHIdpxFW18Z9tqnsT76qyD2vGhcdwgQdgIG9vQiNzwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwnwWVfbxeXIv9Xit1MdKgFrLIrMJiIs9gvTrIGEpx8=;
 b=PRiLp3vt+IYmWqRc726DGNesHRjDomWQmBAOe/u5cUW3QXkZ/W1/hyTCCTyjaQoYIoPWDoKqRkKdC5g3Ffyl125c+2ViatEjaDikAjuRvkJFRlrH6ISvD+3howzn0ILrnHc8Ys/e8MEDXnSkhAszyfooG2HrjgV88/7x8IaRdaxIxUpnFxR2/FUQ6NP/OkiH4I/JxJgtsLwvezuFOxTq3uAHm4RUDt2ENdhoZzwaz8hLqRTKxs2ZYUnfBnZ/JVV2bl+Y3uNyul/yyAWI58huGKGPzD7lwXauvH9xri09cWFb7RjkX2Cdgz5smNFZm477B792GhZvAeD93/CbWFNv2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwnwWVfbxeXIv9Xit1MdKgFrLIrMJiIs9gvTrIGEpx8=;
 b=LhXKrVbnxYy+Yi0lVj6x/faJQsu5sAv+hrsjEf0BLJXThVw/zYKoqYouUx3KOQpt0+e+0hFSsj5exzX/qzTbuvM1Bq22xg9sl8YOAsiwAUim58fL8sXLdaE0ppfHvFDvPo50opFeo3XXQRNRqUpSiU+Ocvlx4Hexeo2nPxwASvI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3025.namprd10.prod.outlook.com (2603:10b6:208:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Sat, 6 Mar
 2021 08:37:33 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3912.026; Sat, 6 Mar 2021
 08:37:33 +0000
Subject: Re: [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
To:     "dsterba@suse.com" <dsterba@suse.com>
Cc:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
References: <23a8830f3be500995e74b45f18862e67c0634c3d.1614793362.git.anand.jain@oracle.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b0caf058-3bb5-2ceb-d1d4-d352deee636e@oracle.com>
Date:   Sat, 6 Mar 2021 16:37:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <23a8830f3be500995e74b45f18862e67c0634c3d.1614793362.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:a18f:979f:8154:a7a5]
X-ClientProxiedBy: SG2PR02CA0084.apcprd02.prod.outlook.com
 (2603:1096:4:90::24) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:a18f:979f:8154:a7a5] (2406:3003:2006:2288:a18f:979f:8154:a7a5) by SG2PR02CA0084.apcprd02.prod.outlook.com (2603:1096:4:90::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Sat, 6 Mar 2021 08:37:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99c1c0a9-65c0-44d3-b379-08d8e07b1601
X-MS-TrafficTypeDiagnostic: BL0PR10MB3025:
X-Microsoft-Antispam-PRVS: <BL0PR10MB30253F042AD33B8AAC6E5CA1E5959@BL0PR10MB3025.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /n/u2X0lV8hhoU7rv9Boh2vMGEw7MtrIDurl9pxSpZ0hByM4FppbQFqcczD/PA5f2zEj03tKZ6Jhxd3BGurltfdBEpDn/S0xmUAKKY87HEnwhtGuqFjlmEDReURErn+0LBa+qQGsK5Yz2sHhuVOrFHPDDU5Mydkhz1r5ohgcdeb0dSccVBvwGRmL096ycBQJKhuolp6XA+nyp4ikNKk/uJ5vkDJuwLP13bzsyGaGXpnEpcXa0kAjTdM+D9HqIVONjpWKp7qiRaqIFpVXmwKC5R4X4AR2z26zHXcnxMaD0MOs3UGo/LRc5d1tP8GMi/xAKdT7JqUtEM7dPWxseS4IVWekaeV9bugpB9PCFDSePBF2+OGn+0b9hDfNCpz9875xhGak/jKeLATjJ73Sq28x6/LKA9J5Y7Mdb0o0IBZg/og7MablHJG5MkJTiuE78zLcUi2S8NVJVsJ9IPuWKcqK+5rJQidzK11xPd4I2OFO5nbRNsmYsNfyNr+vBhrHUWK7bOA8UBHTdV1PLDLLww/FjGXLQqSddBNNjNBdimVXAUzNQUmG3K4bmffcGJHIZ1zT9pm3yQV8EtRzF6iYOflkAQR1eEkoGV1lldQUIHZcJxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(396003)(376002)(346002)(2616005)(6916009)(6666004)(83380400001)(44832011)(186003)(66556008)(8676002)(16526019)(478600001)(53546011)(66476007)(36756003)(66946007)(31696002)(6486002)(4326008)(31686004)(8936002)(2906002)(5660300002)(86362001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z05MU0hvSTMrd2ZIUktha0VSdjFoeXBzajV5Y3ByakxXQjd2VGZEdmlMK3Jm?=
 =?utf-8?B?bk5KL3RGOEFXbGl0SnUyb3Jvc0MwVFlLdjljRFVUZ3dhMUlzRTNwakhib09C?=
 =?utf-8?B?NEFqZkx4cUFHRDlxdlRmTFQ3QkhiMUhIbk9zVzVtRUFUOEpCZXllTWFQWUdI?=
 =?utf-8?B?YUZ6L1JKY3hJRmhuM0h2RXRISVg2UW16TkRFeXZrc1ozcXJPVDB2V0lPbzBE?=
 =?utf-8?B?SDI4T282bmxHN3FoNmtBYWdOQjQxZFVCajN0aFpaczVMNkhNbVV4cTdhQnlH?=
 =?utf-8?B?QkI0OXFCbVFaRE1JTTF3d2FXYWc1d0NVODdpY1NHZnhzZ2ZqSUhqZ25rYUxy?=
 =?utf-8?B?MFNHQm0vRUx0OFlweVJjdnlCR203ZG54K1pac1dTRHRkTGxDWllhL1d6ZFUx?=
 =?utf-8?B?ajBtb01QMHJBLzQwaWNiWTdua0dIRUhPa1liendkeFF4U0EvdG1zSXBwMXFV?=
 =?utf-8?B?dVNiM0N2Y0lmbDdaUytvVVVDQUdpRjEwYm9CUVl0QURLbkJJMzBJUzdNYkYw?=
 =?utf-8?B?K0dsTjkyelVOaG5CWHRFWnVnazBtbk5KcEdLdVhNdHBGMmZPM1pDbE14aFlv?=
 =?utf-8?B?cHczYUkwM2U5Q2I0aWdLd2M3Wjg4S2hKTXRIMWtHSkVua2FUMDlOcXRUc3NR?=
 =?utf-8?B?ZStLK3NVZmdRMmtlT1V4NjBQMmJWSHFWNUY2dndpeW5HZ1NYd2RPcEEvcFpZ?=
 =?utf-8?B?UzF4ZStmd0RYa0FBSkNVNmdWcy9SbzJGdk9ERWU0dmRWL2tOS1FPT3RhNHJK?=
 =?utf-8?B?THZnSTFPQ3FNbkxOeXQ5MWRod0lmNWlTQmJld0FGVktzTVV6VW04eVBhVVZt?=
 =?utf-8?B?aWhTZWtqNjNJaUJxek9BQ09CU29lUkVVMzFsTC9ITEs4aEtLZzN4YVpycDJm?=
 =?utf-8?B?MzlLaWlHSHUwakFFaDNlbjlNeTl1NDhYTjc1RTdKaXd0LzZwVTQ1QW9mU2E4?=
 =?utf-8?B?aTJCWFQ2YVhFWG41V1ByckJCalJxZTFrQmNmL3pGc29QTzgyRzNHenpWeFJB?=
 =?utf-8?B?Q3dyeXlhNVgwdUJTMHhjVHB0QUdtcXdMYlRlVEZSTDhZUm1mU3MzNTN2UzVH?=
 =?utf-8?B?VDRaa083VE1BSVY5WkFmbStiWUNiQzlmWFhxc0FKMG1IV0l6V0RQaSttM2Fk?=
 =?utf-8?B?SDc2VzRHSGFSajBnR21mT2NoZXJkdXEvQnNNOG9OWHFTbjdxWFpRUzhCSXc0?=
 =?utf-8?B?YnpObGZ3Y1pZTmJLanJ1WHdVQ3k0dUJ6VWdWMU1yeW55QzFPWFQvMEhuTVp4?=
 =?utf-8?B?aGRsNDJ2ejR4Mmt1cFVlbVNUU0xtamhpZ0I3WG94SWhPa2R1U2Y1UEY1Uyto?=
 =?utf-8?B?c29PSUtEODBUcENZOGlpeUx1bHd0MGp1THJpMkN4ek1FaGM4d2hWZ2VXKzZy?=
 =?utf-8?B?T3ZJY0VuUVVSNzNWUGR2NnBGYzNqRmdzSDArNnlGMmo5ZmJoVUREcHdSNlNB?=
 =?utf-8?B?RzF1cFRtcG9vYVE4MWNndXQzbmxMSGpySHdzUGFZK2NJTHBvRENXZXE4ZFd5?=
 =?utf-8?B?ZjRhaENGMDVLalZvY2kzNW81aENqRHJ0emZ1YVY3bktwZjQ1c0pIZHZKcWpE?=
 =?utf-8?B?d2JKTTFXbzVibGRmYm0yUDZvVlZUVjhjcDBIeHdPZjFTWU5PVnpIWWVCNUdC?=
 =?utf-8?B?bjBOSkQveXNBLzlhV0gwRDk2cWIzcTNBZ082T2lKNVRFVTMzNUtISThPemdM?=
 =?utf-8?B?R0txZkZYaDYzVGtsUlR5ZzM1L0o3c2YyVGpGSGFWWU10RGxoTjNibEFMZmN5?=
 =?utf-8?B?cG5iVGl3NTBYM0VBb0xzQVVsTUM5YVFWRWoyVHo3VFpjOFVjMFg5azJOZUF3?=
 =?utf-8?B?YXRxbVM1TVVCWDd5UDB6K25MODlKczFxUVYzcEZ6K2JyUVI4V21MQWZmVExw?=
 =?utf-8?Q?KAMc9VP6NmyAC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c1c0a9-65c0-44d3-b379-08d8e07b1601
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2021 08:37:33.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFAwwdVL3S18glup/QxkoQe2Lpir64Ajwa87JAg8J9xPWyKMpnnUpyJ+7tRuiU1sQW12VZG56XIHRbmZoD6VOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3025
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9914 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103060053
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9914 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103060053
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David,

  Ping?

Thanks, Anand


On 04/03/2021 02:10, Anand Jain wrote:
> Following test case reproduces lockdep warning.
> 
> Test case:
> DEV1=/dev/vdb
> DEV2=/dev/vdc
> umount /btrfs
> run mkfs.btrfs -f $DEV1
> run btrfstune -S 1 $DEV1
> run mount $DEV1 /btrfs
> run btrfs device add $DEV2 /btrfs -f
> run umount /btrfs
> run mount $DEV2 /btrfs
> run umount /btrfs
> 
> The warning claims a possible ABBA deadlock between the threads initiated by
> [#1] btrfs device add and [#0] the mount.
> 
> ======================================================
> [ 540.743122] WARNING: possible circular locking dependency detected
> [ 540.743129] 5.11.0-rc7+ #5 Not tainted
> [ 540.743135] ------------------------------------------------------
> [ 540.743142] mount/2515 is trying to acquire lock:
> [ 540.743149] ffffa0c5544c2ce0 (&fs_devs->device_list_mutex){+.+.}-{4:4}, at: clone_fs_devices+0x6d/0x210 [btrfs]
> [ 540.743458] but task is already holding lock:
> [ 540.743461] ffffa0c54a7932b8 (btrfs-chunk-00){++++}-{4:4}, at: __btrfs_tree_read_lock+0x32/0x200 [btrfs]
> [ 540.743541] which lock already depends on the new lock.
> [ 540.743543] the existing dependency chain (in reverse order) is:
> 
> [ 540.743546] -> #1 (btrfs-chunk-00){++++}-{4:4}:
> [ 540.743566] down_read_nested+0x48/0x2b0
> [ 540.743585] __btrfs_tree_read_lock+0x32/0x200 [btrfs]
> [ 540.743650] btrfs_read_lock_root_node+0x70/0x200 [btrfs]
> [ 540.743733] btrfs_search_slot+0x6c6/0xe00 [btrfs]
> [ 540.743785] btrfs_update_device+0x83/0x260 [btrfs]
> [ 540.743849] btrfs_finish_chunk_alloc+0x13f/0x660 [btrfs] <--- device_list_mutex
> [ 540.743911] btrfs_create_pending_block_groups+0x18d/0x3f0 [btrfs]
> [ 540.743982] btrfs_commit_transaction+0x86/0x1260 [btrfs]
> [ 540.744037] btrfs_init_new_device+0x1600/0x1dd0 [btrfs]
> [ 540.744101] btrfs_ioctl+0x1c77/0x24c0 [btrfs]
> [ 540.744166] __x64_sys_ioctl+0xe4/0x140
> [ 540.744170] do_syscall_64+0x4b/0x80
> [ 540.744174] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> [ 540.744180] -> #0 (&fs_devs->device_list_mutex){+.+.}-{4:4}:
> [ 540.744184] __lock_acquire+0x155f/0x2360
> [ 540.744188] lock_acquire+0x10b/0x5c0
> [ 540.744190] __mutex_lock+0xb1/0xf80
> [ 540.744193] mutex_lock_nested+0x27/0x30
> [ 540.744196] clone_fs_devices+0x6d/0x210 [btrfs]
> [ 540.744270] btrfs_read_chunk_tree+0x3c7/0xbb0 [btrfs]
> [ 540.744336] open_ctree+0xf6e/0x2074 [btrfs]
> [ 540.744406] btrfs_mount_root.cold.72+0x16/0x127 [btrfs]
> [ 540.744472] legacy_get_tree+0x38/0x90
> [ 540.744475] vfs_get_tree+0x30/0x140
> [ 540.744478] fc_mount+0x16/0x60
> [ 540.744482] vfs_kern_mount+0x91/0x100
> [ 540.744484] btrfs_mount+0x1e6/0x670 [btrfs]
> [ 540.744536] legacy_get_tree+0x38/0x90
> [ 540.744537] vfs_get_tree+0x30/0x140
> [ 540.744539] path_mount+0x8d8/0x1070
> [ 540.744541] do_mount+0x8d/0xc0
> [ 540.744543] __x64_sys_mount+0x125/0x160
> [ 540.744545] do_syscall_64+0x4b/0x80
> [ 540.744547] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> [ 540.744551] other info that might help us debug this:
> [ 540.744552] Possible unsafe locking scenario:
> 
> [ 540.744553] CPU0 				CPU1
> [ 540.744554] ---- 				----
> [ 540.744555] lock(btrfs-chunk-00);
> [ 540.744557] 					lock(&fs_devs->device_list_mutex);
> [ 540.744560] 					lock(btrfs-chunk-00);
> [ 540.744562] lock(&fs_devs->device_list_mutex);
> [ 540.744564]
>   *** DEADLOCK ***
> 
> [ 540.744565] 3 locks held by mount/2515:
> [ 540.744567] #0: ffffa0c56bf7a0e0 (&type->s_umount_key#42/1){+.+.}-{4:4}, at: alloc_super.isra.16+0xdf/0x450
> [ 540.744574] #1: ffffffffc05a9628 (uuid_mutex){+.+.}-{4:4}, at: btrfs_read_chunk_tree+0x63/0xbb0 [btrfs]
> [ 540.744640] #2: ffffa0c54a7932b8 (btrfs-chunk-00){++++}-{4:4}, at: __btrfs_tree_read_lock+0x32/0x200 [btrfs]
> [ 540.744708]
>   stack backtrace:
> [ 540.744712] CPU: 2 PID: 2515 Comm: mount Not tainted 5.11.0-rc7+ #5
> 
> 
> But the device_list_mutex in clone_fs_devices() is redundant, as explained
> below.
> Two threads [1]  and [2] (below) could lead to clone_fs_device().
> 
> [1]
> open_ctree <== mount sprout fs
>   btrfs_read_chunk_tree()
>    mutex_lock(&uuid_mutex) <== global lock
>    read_one_dev()
>     open_seed_devices()
>      clone_fs_devices() <== seed fs_devices
>       mutex_lock(&orig->device_list_mutex) <== seed fs_devices
> 
> [2]
> btrfs_init_new_device() <== sprouting
>   mutex_lock(&uuid_mutex); <== global lock
>   btrfs_prepare_sprout()
>     lockdep_assert_held(&uuid_mutex)
>     clone_fs_devices(seed_fs_device) <== seed fs_devices
> 
> Both of these threads hold uuid_mutex which is sufficient to protect
> getting the seed device(s) freed while we are trying to clone it for
> sprouting [2] or mounting a sprout [1] (as above). A mounted seed
> device can not free/write/replace because it is read-only. An unmounted
> seed device can free by btrfs_free_stale_devices(), but it needs uuid_mutex.
> So this patch removes the unnecessary device_list_mutex in clone_fs_devices().
> And adds a lockdep_assert_held(&uuid_mutex) in clone_fs_devices().
> 
> Reported-by: Su Yue <l@damenly.su>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Remove Martin's Reported-by and Tested-by.
>      Add Su's Reported-by.
>      Add lockdep_assert_held check.
>      Update the changelog, make it relevant to the current misc-next
> 
>   fs/btrfs/volumes.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bc3b33efddc5..4188edbad2ef 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -570,6 +570,8 @@ static int btrfs_free_stale_devices(const char *path,
>   	struct btrfs_device *device, *tmp_device;
>   	int ret = 0;
>   
> +	lockdep_assert_held(&uuid_mutex);
> +
>   	if (path)
>   		ret = -ENOENT;
>   
> @@ -1000,11 +1002,12 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
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
> @@ -1036,10 +1039,8 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
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

