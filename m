Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEAC3D848A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 02:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhG1APr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 20:15:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43614 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232840AbhG1APr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 20:15:47 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16S01rVt000546;
        Wed, 28 Jul 2021 00:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oHBSq/ty189EFmaX6ucjA7Ifi6NJBDoqL67m5HpL9gA=;
 b=tLN0pomTopbq/wnIaTXiohyUpufw8R41+e7qPcBI2Xbia2f78870JHEpVblVRu/w/aVr
 lIPU4TjjNIG+TGbYSov6ebyhzD3vXjP/brGGvA8D8ojWtuAjGKCRvjREZZ2Z3jitVioJ
 ku3OEeHxA1vlXA9BIRK8enPdvTiwzAHauCHUcMo4zmp3v40x4Bhk6kGybSu6tOb8BN/0
 0pq2aApGv0OqW6ownYYIP/RU64POHoL/scin+FJis1aqKHJI4ZRPzAurX0EjlIj0Q4x2
 vvyJbMib01NsOIG1D7wYRZVsHGYH0mIxeHN5V7DVZU5ydOf5VTl3cBtJ/4h86OOygJYN wQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oHBSq/ty189EFmaX6ucjA7Ifi6NJBDoqL67m5HpL9gA=;
 b=C6zCME2i/uqPBzBnq//N4vs3JsrvkUCL+TI2IuhrbiRRycl7mo9hJgolmokWdUR5otFd
 cQVhg/bFeAcCloT3dASvPQhj9w44OJErISHA6yofx3qnJAJPFcIGVZWIuNKRxsC7XJ23
 IfAjqE5LUvAUpYg+9sqAr/lDCjJQXfQYwgk9UU/rwXljQFRI5iZVRrgyABosfavcA4FR
 cLnxZWvvoyV0m/pUfrd/SxWIVyAQBSaJYUu0cLMjjM+3SqxS+VnfotcJ5L5ZsQnmhbs5
 kMbN3AlW8csfyb8BlrUPpStUDKV9aNtpp8ViXV+zlC+cQtMQr60D6vGI7FytydRUMZ6c 1g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2356k3db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 00:15:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16S01i1u152709;
        Wed, 28 Jul 2021 00:15:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 3a234bbfrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 00:15:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lv56kwsTJa1e7T7YH9JgaK3dsIIaz43EhDuEvz87pXSIPXohOhd1UezkDymlySE9yA5v16y+crUq5Lk+L6qcMKJqYcKxkRbA4Qi080ge3tDfKI/HLrF/Toniixn594zdhtej6bKRAJFycbfJH37McvK2di0ucN9kWHN1gXuFCTBC6LTOv4I8YGIdIQ6TNuccmh2b3zQBFmJcE3kG3445gSqisG0QNin8wfnj385CZ4JkXTYVHzuUJsYsP2SC7LBH4sifL1Us5b5QoxPS9fRbmrGO2lh4FJw1BxS5LXUzjbylXTjBSbQ2IhRJ8lf8n5lYJ88khIZjNirpd+6BTTnZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHBSq/ty189EFmaX6ucjA7Ifi6NJBDoqL67m5HpL9gA=;
 b=BaBYHb62TWHDalYshPgwOKeqlZyOebS6cElDzvNhIqrj3tSINnT3QHS3TDe/AgMzb3R3xmMDdSBsnY4zgLqoQF8Sy+I25Xpvuk3VTuPpvZk42npr/YqPW352asup+ThR2p0P+Zgrki1CNhVy6JrygU+FZ3dQ77iiR3PfRoYiRYQdrTmVAchZQXhmq7hXQchTLA7i6LofbEra4/LIdppxpIgcdSfibVfVR3wQQ1O7ullolNzxhBfElewLSACMqBc+QrKzry1nnaSlVUnmEZdM91uWUl5/e3QnwUB2gQrTZw3MA4+rIg/JTWZKzKiP9tcXKZpX9SMMgCfIU7SRCHHDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHBSq/ty189EFmaX6ucjA7Ifi6NJBDoqL67m5HpL9gA=;
 b=pdbLSYii97nZEKzhmlsl32JST4Nj+CjhqNQcXo/OOzmdC+LmQ4CNLcz4vi0K2ZXpdcGE4yuOBW5DlQGEudwo3jmfrNCgAImVhzmnn55acG71HcLnR1iRAXFIM7eCBuPMhHd6K81mWkImjmE8kpwIZgOoqnneSDN+hlip5PO7BIg=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2771.namprd10.prod.outlook.com (2603:10b6:208:7b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Wed, 28 Jul
 2021 00:15:39 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4373.018; Wed, 28 Jul 2021
 00:15:39 +0000
Subject: Re: [PATCH 2/6] btrfs: do not take the uuid_mutex in btrfs_rm_device
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1627414703.git.josef@toxicpanda.com>
 <bb8ebd37d7ca60bc78fab5368274c99a03004fe5.1627414703.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8b170a9d-b810-ade5-db74-acb618eb9419@oracle.com>
Date:   Wed, 28 Jul 2021 08:15:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <bb8ebd37d7ca60bc78fab5368274c99a03004fe5.1627414703.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0107.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR01CA0107.apcprd01.prod.exchangelabs.com (2603:1096:3:15::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 00:15:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecd94ebc-d52b-43df-4125-08d9515cd498
X-MS-TrafficTypeDiagnostic: BL0PR10MB2771:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2771A3571D04ECFD2EA26A59E5EA9@BL0PR10MB2771.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjCh+C7lWQed8f52QFKNC32MVZh7WJWL8ppDTIDA3+I4Zt2AB5b+8kjvpNMyTtHOtgpIs2eGEFGfLPdq1mN7kTPcMC+ZFBTOnnXqXLjYzwguwRrmaLr9V6i8m45+j8lxLhB6P4T6OfuckGWYR/fvgCs+2SjDKUwMOZR2qXmnCS0JWw+4qvzYTwTvI7DW3FH26orOgSe/r8lC6K3mRo6o0SKQFoEyCfA6VrC5xeMAcK2VE745m5OXvnBr1yzf2TrfQeHg03D9iLVXchjjtK+B9elVUnf4rH9J37edMYl8Ob50iYBk3Rd3+lDBphkmDBA1YDu3gCvsCTLwGupGYy5hXBx0p4shxS+W/EREWyr5igNpPU7A00aFQ++qE9vVjgA6JWWL8DxUfTtbMa3qpAnM8mSn9ieONyodrJAlY3sOQU8IqM52s2CmpP2jHPWZAcTVgxGyeDeoyGV1m2BHnqD6BuMEJBmmlqGdrsrOpFGRpbClBD3Gyxe0mUTXL3iTU4GLNyvIVO9k0fF2i1YeNT7e34PWgIOAqaqapJd3wUPbbHnWrao3b+n/cgfZd2wkk9h/fDlFzn5+Ph4S/Q4W7HLCDwOG76PNAKEuU2jQ9sL50jeE/7rvDNHp99W1QYilHGyT26Xg+6ZlZu7IYsXIBlZ3v8RJ73vMDu2bev3FCt3yfyF6DGBZIDL/duo5YTRahqlliOjVDalNe3tfqoqgP2N1KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(53546011)(2906002)(478600001)(31686004)(36756003)(2616005)(66556008)(66476007)(38100700002)(66946007)(8936002)(956004)(26005)(83380400001)(186003)(44832011)(6666004)(5660300002)(16576012)(86362001)(6486002)(8676002)(316002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NENwQUFUUnBUdGM1RWlvN3VTMXdVR2pJYkg5VHZWdThhMk1CMWQ5ZnplZUJ4?=
 =?utf-8?B?aEoyb2RxN25iUHBFSXFBeFU5QThya2VTaFVqMi9SVEgyQ2VObGtVUE0vNldT?=
 =?utf-8?B?WGwrb0RBVXRyYmQ2NjlwSk1hdnRrT1N0T082V0RJSEx1NWdBYXFGODFZakJa?=
 =?utf-8?B?a2FOZXpQMXBUWmJHMUJBM0J5SHhrV1VkZE14aUx6MWI2WjNoTThJdU5XNDRS?=
 =?utf-8?B?NDRqUzlpeVZFMjZ2UGJCQjUxODViK0hvZk4vaEVpT1FHYjc0MFl6bGJwNnI5?=
 =?utf-8?B?cUx1UzhFNHpUVDM1WE96MEc1dCt6Q05hUFBIbXVkQnJPRkxWcjk3dmxKOFMx?=
 =?utf-8?B?YVdwc2phdG5uZGxNSUR5TXJDTnBLM1FGWVllRitpQ3JQdSs3TWRwVkJZNVIy?=
 =?utf-8?B?cGs4WDB3NU9kZ2V2VHRBbmtHRmhNQ2hoSmVWT1RRT1Y1NFdWYU82NXgrdkZx?=
 =?utf-8?B?YXI3cnFkMEFUTThkN2tNNFBEQkRLYVNwMzl4OWhvamwrZ0VucWdEMGd4M3RU?=
 =?utf-8?B?d1Q0QkxmNDVjK0NIVzZ3SDVJOW5kalBybVBmVk01QTdKRGtqa2UrK2FBZ2hr?=
 =?utf-8?B?b0R0bmxxU05FcjdGVEpOZW9XbDhPdmpIUTRPdFVwZFFha2c2OWN2enkzTWE4?=
 =?utf-8?B?NEdXL2xMS0JlaDZVaTZ6bE11WC9POFV4Zjl0Ym56eXFody9EZ0tvYVFqK1kv?=
 =?utf-8?B?NUtCYW5PdjdEYy9mWm9MU0dDdUpqdUdiRDh6WlpNdjFtbVRGclB1eC9CTHdI?=
 =?utf-8?B?eWtNaWN4Zzg1MnRjYVdJRThtOFM2enFoQjlOMDhJOGFRbmpnTytYT0pRcUdj?=
 =?utf-8?B?WnQ5L2x2SENpVTFHeExBMGVVR2VuOUhSdjc2QmhWN1VURXhGbk9yUGxoZit6?=
 =?utf-8?B?Z2FWR0tDMUk3TzBrK1VFRU1QSUQwajhwc1M2azNqdE1yUzlsNWxYL1dJV0RL?=
 =?utf-8?B?akhDMTlLMElyN21HcE5HdWJDeG9nZzBNQ1V0alBNWjJkOGhQMXQvaWhMRkMz?=
 =?utf-8?B?ODhHaHYxM0tEaDU5VC9tNWMrQWdnenB1ekxadXYrTWtyOS96aGxaQ1M0Mzk3?=
 =?utf-8?B?VGFmWm8yS2RqeXpSM1hDR3F4bkVyU0hjQnU2VVVOdU1yNjlZaXJiT29Sak0z?=
 =?utf-8?B?NTdFYllHZHFmT1NNdUQ2VTRqWGgrenRFMGZyVlVubkdQdURXaTE2SFRXWGZs?=
 =?utf-8?B?TGovZXJaSWFzTGJCTnI5UHRxcktMcWtoR2lGcXA2SVdKSlpMdXpMOHE5M1Mz?=
 =?utf-8?B?QlMwRFMyVWxaMWVUWjZNaGhLOXB0cFRTSmI3ang1SVlPQVhFRTliL3NqaDNK?=
 =?utf-8?B?US8yN1gzRHZudUpzSjdlclFWOTY4QUk0KzEvRTBpVlZGazEwNmJRODNnbVpv?=
 =?utf-8?B?bHNHZlQvM2xtV3gyWTl3SlJqNWpKQ0c5STY1d2VsYjZ2UmxvQ3dKdHNNczJB?=
 =?utf-8?B?dUtTT1h4cWVsa1pVZ0JMTmJVY2Q0UDAzam1vcE1WRVVXVkF5bmZ4QnEwSzFs?=
 =?utf-8?B?eGlJQllBMXQ2V08ybkROVElsQWRTalhqMVd0a1hPeVNvQzBSWE1jUno3N3hN?=
 =?utf-8?B?MURUSzhvUnNOQWRIeHovamdlNXBpOFlKVEY4QmlDd2g4K0JLeGxNSHhMcmNO?=
 =?utf-8?B?NHJmaWhXSG1wNG5TYWVCZTl4YXZmcjRBTW43S1FGSEp6eDhVWU9WVDVFMWNW?=
 =?utf-8?B?ajdJTkFBWmtiTk5lMFI2ZlM5VEVCLzdTa0UwOTdoMWswQjVZZE9lTG9ydnMy?=
 =?utf-8?Q?hRS8hH0ycM4/wVYWHC47tCeF44k+AQ0Cwr+hCcl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd94ebc-d52b-43df-4125-08d9515cd498
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 00:15:39.6678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaAQDFe+zosxXUT3vQcPjfy0F2ivehqv1i6iqO083xaXiNIdfCiy+oy7ujTUxeGrp8krhCNVwUs8CRlq2HsCow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2771
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270137
X-Proofpoint-ORIG-GUID: -RQCuMrfQB3-0JoqtQ6RmhSMTZyBwtaE
X-Proofpoint-GUID: -RQCuMrfQB3-0JoqtQ6RmhSMTZyBwtaE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 03:47, Josef Bacik wrote:
> We got the following lockdep splat while running xfstests (specifically
> btrfs/003 and btrfs/020 in a row) with the new rc.  This was uncovered
> by 87579e9b7d8d ("loop: use worker per cgroup instead of kworker") which
> converted loop to using workqueues, which comes with lockdep
> annotations that don't exist with kworkers.  The lockdep splat is as
> follows
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.14.0-rc2-custom+ #34 Not tainted
> ------------------------------------------------------
> losetup/156417 is trying to acquire lock:
> ffff9c7645b02d38 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x84/0x600
> 
> but task is already holding lock:
> ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x650 [loop]
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #5 (&lo->lo_mutex){+.+.}-{3:3}:
>         __mutex_lock+0xba/0x7c0
>         lo_open+0x28/0x60 [loop]
>         blkdev_get_whole+0x28/0xf0
>         blkdev_get_by_dev.part.0+0x168/0x3c0
>         blkdev_open+0xd2/0xe0
>         do_dentry_open+0x163/0x3a0
>         path_openat+0x74d/0xa40
>         do_filp_open+0x9c/0x140
>         do_sys_openat2+0xb1/0x170
>         __x64_sys_openat+0x54/0x90
>         do_syscall_64+0x3b/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #4 (&disk->open_mutex){+.+.}-{3:3}:
>         __mutex_lock+0xba/0x7c0
>         blkdev_get_by_dev.part.0+0xd1/0x3c0
>         blkdev_get_by_path+0xc0/0xd0
>         btrfs_scan_one_device+0x52/0x1f0 [btrfs]
>         btrfs_control_ioctl+0xac/0x170 [btrfs]
>         __x64_sys_ioctl+0x83/0xb0
>         do_syscall_64+0x3b/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #3 (uuid_mutex){+.+.}-{3:3}:
>         __mutex_lock+0xba/0x7c0
>         btrfs_rm_device+0x48/0x6a0 [btrfs]
>         btrfs_ioctl+0x2d1c/0x3110 [btrfs]
>         __x64_sys_ioctl+0x83/0xb0
>         do_syscall_64+0x3b/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #2 (sb_writers#11){.+.+}-{0:0}:
>         lo_write_bvec+0x112/0x290 [loop]
>         loop_process_work+0x25f/0xcb0 [loop]
>         process_one_work+0x28f/0x5d0
>         worker_thread+0x55/0x3c0
>         kthread+0x140/0x170
>         ret_from_fork+0x22/0x30
> 
> -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
>         process_one_work+0x266/0x5d0
>         worker_thread+0x55/0x3c0
>         kthread+0x140/0x170
>         ret_from_fork+0x22/0x30
> 
> -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
>         __lock_acquire+0x1130/0x1dc0
>         lock_acquire+0xf5/0x320
>         flush_workqueue+0xae/0x600
>         drain_workqueue+0xa0/0x110
>         destroy_workqueue+0x36/0x250
>         __loop_clr_fd+0x9a/0x650 [loop]
>         lo_ioctl+0x29d/0x780 [loop]
>         block_ioctl+0x3f/0x50
>         __x64_sys_ioctl+0x83/0xb0
>         do_syscall_64+0x3b/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> other info that might help us debug this:
> Chain exists of:
>    (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex
>   Possible unsafe locking scenario:
>         CPU0                    CPU1
>         ----                    ----
>    lock(&lo->lo_mutex);
>                                 lock(&disk->open_mutex);
>                                 lock(&lo->lo_mutex);
>    lock((wq_completion)loop0);
> 
>   *** DEADLOCK ***
> 1 lock held by losetup/156417:
>   #0: ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x650 [loop]
> 
> stack backtrace:
> CPU: 8 PID: 156417 Comm: losetup Not tainted 5.14.0-rc2-custom+ #34
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> Call Trace:
>   dump_stack_lvl+0x57/0x72
>   check_noncircular+0x10a/0x120
>   __lock_acquire+0x1130/0x1dc0
>   lock_acquire+0xf5/0x320
>   ? flush_workqueue+0x84/0x600
>   flush_workqueue+0xae/0x600
>   ? flush_workqueue+0x84/0x600
>   drain_workqueue+0xa0/0x110
>   destroy_workqueue+0x36/0x250
>   __loop_clr_fd+0x9a/0x650 [loop]
>   lo_ioctl+0x29d/0x780 [loop]
>   ? __lock_acquire+0x3a0/0x1dc0
>   ? update_dl_rq_load_avg+0x152/0x360
>   ? lock_is_held_type+0xa5/0x120
>   ? find_held_lock.constprop.0+0x2b/0x80
>   block_ioctl+0x3f/0x50
>   __x64_sys_ioctl+0x83/0xb0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f645884de6b
> 
> Usually the uuid_mutex exists to protect the fs_devices that map
> together all of the devices that match a specific uuid.  In rm_device
> we're messing with the uuid of a device, so it makes sense to protect
> that here.
> 
> However in doing that it pulls in a whole host of lockdep dependencies,
> as we call mnt_may_write() on the sb before we grab the uuid_mutex, thus
> we end up with the dependency chain under the uuid_mutex being added
> under the normal sb write dependency chain, which causes problems with
> loop devices.
> 
> We don't need the uuid mutex here however.  If we call
> btrfs_scan_one_device() before we scratch the super block we will find
> the fs_devices and not find the device itself and return EBUSY because
> the fs_devices is open.  If we call it after the scratch happens it will
> not appear to be a valid btrfs file system.
> 
> We do not need to worry about other fs_devices modifying operations here
> because we're protected by the exclusive operations locking.
> 
> So drop the uuid_mutex here in order to fix the lockdep splat.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 373be4e54f28..62cb7d39435c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2082,8 +2082,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   	u64 num_devices;
>   	int ret = 0;
>   
> -	mutex_lock(&uuid_mutex);
> -
>   	num_devices = btrfs_num_devices(fs_info);
>   
>   	ret = btrfs_check_raid_min_devices(fs_info, num_devices - 1);
> @@ -2127,11 +2125,9 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   		mutex_unlock(&fs_info->chunk_mutex);
>   	}
>   
> -	mutex_unlock(&uuid_mutex);
>   	ret = btrfs_shrink_device(device, 0);
>   	if (!ret)
>   		btrfs_reada_remove_dev(device);
> -	mutex_lock(&uuid_mutex);
>   	if (ret)
>   		goto error_undo;
>   
> @@ -2200,7 +2196,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   	synchronize_rcu();
>   	btrfs_free_device(device);
>   out:
> -	mutex_unlock(&uuid_mutex);
>   	return ret;
>   
>   error_undo:
> 

  btrfs_rm_device happens on a mounted device, so device scan --forget
  will skip this device. For the rest of the ioctl based device maneuver,
  we have ...exclop_start(). Yeah, I see no reason to keep uuid_mutex
  here.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
