Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DC049DCF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 09:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiA0Iw4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 03:52:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54108 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233625AbiA0Iwz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 03:52:55 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20R6ps2x016830;
        Thu, 27 Jan 2022 08:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ZaY5d+H44E3mN9BwLbTI4HJ72RrvM8racdwU7VpzG3o=;
 b=fnkR+3sL1DyunEcdIMrBa4Z6DKqdGS8U6cDuheY7HpP+06RgDTOKD6n9eXK6VMtWK9Kf
 LUHg1PoWDKIYrXO7KN9MZkGv4TT+OJwtYU6xpewQqA5t7925bslDZlpR4ChmyBi5azaP
 1rPQVD4o+OxO0XW0ZUKuz6a3vy3QUwntd0x26AH788xWjw+E7jScywBFq6tQQOhQMeDf
 7l/N/biShYMBR/0myEcZBCqB9kYEt8pIhljdjlMrjNRkzFn6hrkpptP3XvfRfbTCyZPr
 au8IFC9sf3cirRcDwebcJnkqnAFxgTTt/G8+nkf/GU5eIqld0PgwWVOavaMHzfTUZgxl 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s8fs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 08:52:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20R8oXEd101028;
        Thu, 27 Jan 2022 08:52:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3020.oracle.com with ESMTP id 3drbcsv9fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 08:52:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ec/gDUbbag8EVIqXk8KQHvJcTuj4aT95kXzCju9ngu5GGWqP7g2wKWS/xPrVxH4a3KPMbg0ak9sZPZgrNDhe/N49xcNlRfz9Y58U2+qt7lrK69SYV5FUNOCgkXKMcFsfiPmngiceJocfD9S3XuTp1zXFQ5yW96D43PwG3gAuMC7sjL90YtC6yUWyKIXUKbYWsPiw7femz5YOkcDX8AbRv1Lv9XideDKDiGIZjgmfGxsb8mO202hTg89kF79g6gJLPHqyYqHjmuVxAp6uHYdo36lz8MCk1cjy8f1gB792kyPZ9UAXOfLjrY/pwTHjvJ3uxJ3Vr9zQu4LYk70r9DRY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaY5d+H44E3mN9BwLbTI4HJ72RrvM8racdwU7VpzG3o=;
 b=MurQunku/QFqRa3v7D9Q5pti8WyXY/g5cpBSrTMr551POQuBslUwjyhzwjB6sOcJA9Q7ya6Re3DNLyV6Bx+aVQ+QrUqsbsd22pmWvQck56iy0kYemcSiGyDaNtBVxywXPxq3DTuGqHWeaoEGVkDD2QsPDumJBStEreG1VhHOB7XOWsD47ysLeQUj49x584YxPp+SNMk3eseqzPU7/rvmbmllJodM+U79QtbS0dpeeiR9p9iQ+AykW5mV5NJcvY2Ay+bsqmq/ZQ7Rx79MOwnDWp5iQf3biopGjYDh1OQ6fwfqawOSbKgkArWwQqxzoRP1dR5UNjDI+DlA17sOxkmWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaY5d+H44E3mN9BwLbTI4HJ72RrvM8racdwU7VpzG3o=;
 b=MiqIvMqFV7LyLO0d1o3sf5yKauV77Ak3nGX1PDjqcR0ndZerClu0UGx16FjTy6dM4nrHItVuzohhmix7qVD6VM9XQ4dh/Nxzfub9VSFRlHHrQPYuNQ8NJJuez5D7WZkdEslejB6HGRcsr5d9/NNh9shMEEkkv41gwXsEWvZBULs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3889.namprd10.prod.outlook.com
 (2603:10b6:a03:1b1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Thu, 27 Jan
 2022 08:52:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Thu, 27 Jan 2022
 08:52:48 +0000
Date:   Thu, 27 Jan 2022 11:52:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     wqu@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: introduce dedicated helper to scrub
 simple-mirror based range
Message-ID: <20220127085231.GA25851@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: JNAP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee4e645b-06d9-43af-733c-08d9e172650f
X-MS-TrafficTypeDiagnostic: BY5PR10MB3889:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3889AC2013E71A63FB1CF6B08E219@BY5PR10MB3889.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WfvAqQY4ulzb9pKOoJkqzI6GTa5A/x4Zj7o81eeLgYRQgSji2QCsj2vCYiGcYM9PAcS26a3WktR4J3YEhbFjfAb+Br1UgYLtu2Fej0MUQn2hvT8dp8iSL+LEQl/72eUARO40axWu4L0BpQRC9VLEIA8SFXPyp0EiWt9UkoPbUL2Bk5pp+eXtRyxEHR4aKdU9tGPzqwLdJi8HCUiANyqFSl/c0ysRdMtN7wuoMtFY627/KKOEmxLrPZloPKRC1JRrnDfsDmQbjiU7eFzdeR/VQV+hC2t122AFYQ+irKkrxyJIqIKmF+O70DLCyeBNFdCE9qtBXZHNzWckEncgAUGxnzZiYEoh9+NMPYWk5wlb94GeTCH7e9lo1rFtuZes4R6wd75ySHbP2E5gCqSgIt3LO8CFYmF52BKj+LfJGzmRwVa679tCWTPhtDsQLgm33frronC/c1CN6GPWcXpz2IOa62kw5VQQ/ywTwvx++R8s3bwh2Ghkjy6Mw6RJpKXZgbZasqt865ySJmN9n1cIWGDPFt/Z2Ud9ppTvh9sDqtpZTAhTfv+3GdNte9SWx2Cc6pBJNCZpVYUqhfZ5SRBZowVNqaxWde0C1dCuZiZAskKR1FSe0kLbseogr8xXnW94XHwqvzGzpB9TDfuVaXwHvOKAh1ngUGUOw19RZJ1CUI7QWO3/pr7l77EQpW5Ev7ThQczQ6armRpcUU9OQRG/StwzdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(4326008)(6666004)(38350700002)(8676002)(52116002)(44832011)(508600001)(6486002)(6916009)(5660300002)(66946007)(38100700002)(186003)(33716001)(2906002)(316002)(6506007)(33656002)(8936002)(86362001)(1076003)(6512007)(66476007)(9686003)(66556008)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYQOTglTVAJ7QeooD/L8NU4OIcngv/w1HnerhZbzyLRWGE1pPlQwM3ORtp5r?=
 =?us-ascii?Q?ckH4vIYWNJr/xX3VY9VLv52ANknWYBOHhXhBt76SeEtt2uzKi7GzTmhkj6pC?=
 =?us-ascii?Q?W8bxgG0MdcE3txiL2DrFAqHxvClEbINh713jglkrVpEIjZwxmWVQa3OU2dDA?=
 =?us-ascii?Q?Ln3gJkVTMG00ceybsTvhaAfJlFgMvJLxUw66he3AikQ93ucNegxIq+SWOH8Q?=
 =?us-ascii?Q?xbyKsKhh23WmyGis0soPs++9ZfkCmxb7DMzw37BYjjWwEGCbIB77lA+FN2y0?=
 =?us-ascii?Q?spgvZNjwAYW1cdR+bRj3t3Roqf+bttOIf3B24vv7svj2ehHbJkXTSU0VVJRt?=
 =?us-ascii?Q?QEVjcJfpOueLi7SSuqav1G1SyIByG8Eens2vloCaQXBPwvnYtrptWf6qhLyL?=
 =?us-ascii?Q?2p8SE8hk+BZ/ghZAOwOsXTxAv05Z//sJVxRu3QlQYqMoOtrgWiNiL+LJhYfL?=
 =?us-ascii?Q?2CAOaBkt4oYeJ/BJgPdzh2HF1umzp4LyP8O8JEoxJ8EZYwS15Ov+kZh8h6rx?=
 =?us-ascii?Q?FY1X84rdiNvfktc7ndRwflCXiWZpOJuIusaTvq/66hv+vL+2cMEigh7JlBId?=
 =?us-ascii?Q?bmloRPsAm1Zt6D7iwYiNQ6ps4frHU+8Nzwc2DmPc+VxpRby2tMlOa/A0am4E?=
 =?us-ascii?Q?qmA3cbOBwmL2xYPn9+miQuigItZfNirQMOlGiBhIoggorao/KTNSaU5DAwqb?=
 =?us-ascii?Q?ywjUMypNBvZkOJHYiMt+7nIFADA0DMv6Eqeq2mZ3OtU7P4GdNSt0IVZExCkx?=
 =?us-ascii?Q?BAiTzXKwzBodPD1Zg95JiYeg8IyqS7X+6kC5vq6gm6l4mnK4F27mD89hWchC?=
 =?us-ascii?Q?YqRxGQnc21Ta7FMaL+/HjA61ESWeGjKvJHBzivX0PhfYUM7xMeRWo88ekGy+?=
 =?us-ascii?Q?O/0SJ2nbRumpjJK0Nv3DOAlNfHctdcgyFfSxqARRK+58mfsZosofqD0UzBO+?=
 =?us-ascii?Q?U5u2C2G9y2ng90uU2gg/NpqF5Stk0VZxTYCr55Lcz0SIzoirb8i+P61b3ZJg?=
 =?us-ascii?Q?V7Niv/Pg7EAbYS2hCnr4Cj01ZtkDBEY96S6znCKtvCLSaAOCzSxIL3E3iZPY?=
 =?us-ascii?Q?P7Rx9sjl3JeOYW63P22/eCV17PURtoRNE7+oStq6q81ijcsO+SzL7WSCN2ht?=
 =?us-ascii?Q?2EVsrmJck9jeODXnQJ8hbipEkERf8YxUiP3DXCJw6zukFmvywn2NdusfsU77?=
 =?us-ascii?Q?dZ/kCig6SFhaLPLG7ZHOJysBJ/ZxX59BfxkAXJP/vgzSPt+tKnnS0t+lZNf+?=
 =?us-ascii?Q?6IU1a28oyjvyOn/AKVBcL1GdjOupbLST/xMvmRpbRjZldnqKTwK2+ViY3HZN?=
 =?us-ascii?Q?hiXuKDaA6/p3zQxU1VazrGdhKalIU0B8Cr+jqPjFHhdFI/RvxtJiT2b9x8xw?=
 =?us-ascii?Q?Fny/K7ewUp5FOqLKzK7FmDi8NsRmkj/73w6Awu2HUjVdkRC/iVDlNcYVHLvi?=
 =?us-ascii?Q?gbOBIDcNoArwv0KF6kxOkNmSHJldHdCXxiKRrNXZ6mildkwtzLWTbPSzAZ2B?=
 =?us-ascii?Q?BYKKFmuaAeontoLHi0zAhOw+lv3tiy0tJhJXvsSvrkunACB4TO1eowMMXkZt?=
 =?us-ascii?Q?BnkKSsq10KDhRwt5nBaRgvT2sXVu6NoeBxCLM7HHyBL0w31EGC6dFFpsj99g?=
 =?us-ascii?Q?pVZpYeoKXzpbfd0kN+fMhylD6M3FUBg4MkomMI9IKU/FikU4icd8rocoWAFr?=
 =?us-ascii?Q?KiksgI+ShrOmoxdbpLP5ox1VpYg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4e645b-06d9-43af-733c-08d9e172650f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 08:52:48.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cD+21tqvcbmrm0DhbOyoHNnJPyEegsY8CH3jaVYkDNioEaFDdzaB1pMoyXbvRr6+/qYaXvVLMy18z2oUOrUo3muhwooMlpcWREVeIxDpSpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3889
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270052
X-Proofpoint-GUID: cn62Z6BS9GrxkauYHXmwn4XNsgZ3wd3e
X-Proofpoint-ORIG-GUID: cn62Z6BS9GrxkauYHXmwn4XNsgZ3wd3e
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu Wenruo,

The patch b5b99b1e0296: "btrfs: introduce dedicated helper to scrub
simple-mirror based range" from Jan 7, 2022, leads to the following
Smatch static checker warning:

	fs/btrfs/scrub.c:3678 scrub_stripe()
	error: uninitialized symbol 'offset'.

fs/btrfs/scrub.c
    3513 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
    3514                                            struct btrfs_block_group *bg,
    3515                                            struct map_lookup *map,
    3516                                            struct btrfs_device *scrub_dev,
    3517                                            int stripe_index, u64 dev_extent_len)
    3518 {
    3519         struct btrfs_path *path;
    3520         struct btrfs_fs_info *fs_info = sctx->fs_info;
    3521         struct btrfs_root *root;
    3522         struct btrfs_root *csum_root;
    3523         struct blk_plug plug;
    3524         const u64 profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
    3525         const u64 chunk_logical = bg->start;
    3526         int ret;
    3527         u64 nstripes;
    3528         u64 physical;
    3529         u64 logical;
    3530         u64 logic_end;
    3531         u64 physical_end;
    3532         u64 increment;        /* The logical increment after finishing one stripe */
    3533         u64 offset;        /* Offset inside the chunk */
                 ^^^^^^^^^^

    3534         u64 stripe_logical;
    3535         u64 stripe_end;
    3536         int stop_loop = 0;
    3537 
    3538         path = btrfs_alloc_path();
    3539         if (!path)
    3540                 return -ENOMEM;
    3541 
    3542         /*
    3543          * Work on commit root. The related disk blocks are static as
    3544          * long as COW is applied. This means, it is save to rewrite
    3545          * them to repair disk errors without any race conditions
    3546          */
    3547         path->search_commit_root = 1;
    3548         path->skip_locking = 1;
    3549         path->reada = READA_FORWARD;
    3550 
    3551         wait_event(sctx->list_wait,
    3552                    atomic_read(&sctx->bios_in_flight) == 0);
    3553         scrub_blocked_if_needed(fs_info);
    3554 
    3555         root = btrfs_extent_root(fs_info, bg->start);
    3556         csum_root = btrfs_csum_root(fs_info, bg->start);
    3557 
    3558         /*
    3559          * Collect all data csums for the stripe to avoid seeking during
    3560          * the scrub. This might currently (crc32) end up to be about 1MB
    3561          */
    3562         blk_start_plug(&plug);
    3563 
    3564         if (sctx->is_dev_replace &&
    3565             btrfs_dev_is_sequential(sctx->wr_tgtdev,
    3566                                     map->stripes[stripe_index].physical)) {
    3567                 mutex_lock(&sctx->wr_lock);
    3568                 sctx->write_pointer = map->stripes[stripe_index].physical;
    3569                 mutex_unlock(&sctx->wr_lock);
    3570                 sctx->flush_all_writes = true;
    3571         }
    3572 
    3573         /*
    3574          * There used to be a big double loop to handle all profiles using the
    3575          * same routine, which grows larger and more gross over time.
    3576          *
    3577          * So here we handle each profile differently, so simpler profiles
    3578          * have simpler scrubing function.
    3579          */
    3580         if (!(profile & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID10 |
    3581                          BTRFS_BLOCK_GROUP_RAID56_MASK))) {
    3582                 /*
    3583                  * Above check rules out all complex profile, the remaining
    3584                  * profiles are SINGLE|DUP|RAID1|RAID1C*, which is simple
    3585                  * mirrored duplication without stripe.
    3586                  *
    3587                  * Only @phsyical and @mirror_num needs to calculated using
    3588                  * @stripe_index.
    3589                  */
    3590                 ret = scrub_simple_mirror(sctx, root, csum_root, bg, map,
    3591                                 bg->start, bg->length, scrub_dev,
    3592                                 map->stripes[stripe_index].physical,
    3593                                 stripe_index + 1);
    3594                 goto out;
                         ^^^^^^^^^
    3595         }
    3596         if (profile & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID10)) {
    3597                 ret = scrub_simple_stripe(sctx, root, csum_root, bg, map,
    3598                                           scrub_dev, stripe_index);
    3599                 goto out;
                         ^^^^^^^^^
These two gotos before offset has been set to zero.

    3600         }
    3601 
    3602         /* Only RAID56 goes through the old code */
    3603         ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);
    3604 
    3605         physical = map->stripes[stripe_index].physical;
    3606         offset = 0;
    3607         nstripes = div64_u64(dev_extent_len, map->stripe_len);
    3608         get_raid56_logic_offset(physical, stripe_index, map, &offset, NULL);
    3609         increment = map->stripe_len * nr_data_stripes(map);
    3610 
    3611         logical = chunk_logical + offset;
    3612         physical_end = physical + nstripes * map->stripe_len;
    3613         get_raid56_logic_offset(physical_end, stripe_index, map, &logic_end,
    3614                                 NULL);
    3615         logic_end += chunk_logical;
    3616 
    3617         ret = 0;
    3618         /*
    3619          * Due to the rotation, for RAID56 it's better to iterate each stripe
    3620          * using their physical offset.
    3621          */
    3622         while (physical < physical_end) {
    3623                 ret = get_raid56_logic_offset(physical, stripe_index, map,
    3624                                               &logical, &stripe_logical);
    3625                 logical += chunk_logical;
    3626                 if (ret) {
    3627                         /* It is parity strip */
    3628                         stripe_logical += chunk_logical;
    3629                         stripe_end = stripe_logical + increment;
    3630                         ret = scrub_raid56_parity(sctx, map, scrub_dev,
    3631                                                   stripe_logical,
    3632                                                   stripe_end);
    3633                         if (ret)
    3634                                 goto out;
    3635                         goto next;
    3636                 }
    3637 
    3638                 /*
    3639                  * Now we're at data stripes, scrub each extents in the range.
    3640                  *
    3641                  * At this stage, if we ignore the repair part, each data stripe
    3642                  * is no different than SINGLE profile.
    3643                  * We can reuse scrub_simple_mirror() here, as the repair part
    3644                  * is still based on @mirror_num.
    3645                  */
    3646                 ret = scrub_simple_mirror(sctx, root, csum_root, bg, map,
    3647                                           logical, map->stripe_len,
    3648                                           scrub_dev, physical, 1);
    3649                 if (ret < 0)
    3650                         goto out;
    3651 next:
    3652                 logical += increment;
    3653                 physical += map->stripe_len;
    3654                 spin_lock(&sctx->stat_lock);
    3655                 if (stop_loop)
    3656                         sctx->stat.last_physical = map->stripes[stripe_index].physical +
    3657                                                    dev_extent_len;
    3658                 else
    3659                         sctx->stat.last_physical = physical;
    3660                 spin_unlock(&sctx->stat_lock);
    3661                 if (stop_loop)
    3662                         break;
    3663         }
    3664 out:
    3665         /* push queued extents */
    3666         scrub_submit(sctx);
    3667         mutex_lock(&sctx->wr_lock);
    3668         scrub_wr_submit(sctx);
    3669         mutex_unlock(&sctx->wr_lock);
    3670 
    3671         blk_finish_plug(&plug);
    3672         btrfs_free_path(path);
    3673 
    3674         if (sctx->is_dev_replace && ret >= 0) {
    3675                 int ret2;
    3676 
    3677                 ret2 = sync_write_pointer_for_zoned(sctx,
--> 3678                                 chunk_logical + offset,
    3679                                 map->stripes[stripe_index].physical,
    3680                                 physical_end);
    3681                 if (ret2)
    3682                         ret = ret2;
    3683         }
    3684 
    3685         return ret < 0 ? ret : 0;
    3686 }

regards,
dan carpenter
