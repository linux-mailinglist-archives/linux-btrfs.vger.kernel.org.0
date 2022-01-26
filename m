Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFD649CC3E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 15:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbiAZOXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 09:23:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58678 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241653AbiAZOXx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 09:23:53 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q9npuH001973;
        Wed, 26 Jan 2022 14:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ZC/jPeEuOzgiARPARISM8kgRvfB0YZVIc7BIvamgynk=;
 b=JDynb/C5ThxgGyJ+SzjtNcH0wkStKeFbtLTZlXpu2Mvq11psxCMYJjWb+DlGGEgypS1h
 rkiS8UKIMxp92VQzbKOsx19bQo4PUmiwupbPSaoLxMmlN4J5gCEl3dSrsgM3p7QPligS
 4+mfVpS1GRc/3qQmIoojZ0Icl4Tsv2f5KnK+Y749lFwqutOTptp6h/jpmqHbi7znoYZh
 eA7Kw4q574HjB4Rx00VyUWoUuYkSZNQ8XOsTvV8culVNMO1ikossat+TKqsy1hQW3w5k
 kTMVg4qaj2rFqgVs8Kgcps6jJa/MLeLol0X8f1WDfRYvDI35I6RiOAw7U3LANOzj2n8E Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dswh9pg1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 14:23:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QEFKXh191989;
        Wed, 26 Jan 2022 14:23:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3030.oracle.com with ESMTP id 3dr7yhu163-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 14:23:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGxfmSJJob14uoxOjjCdtQkwzIlcOvdI5uU5UCZVfzV7S1gpqnP/1ZhJ6Vdf8tvQ4uZdzxYUZqUCia6OL41+CO2j3iqfGWM6a1ehkJpPXMZL3PnK6JNFCX4/rfZcbzJCx1ocVSVfd/eAkTH5KErA0+WhfMfR8EI760oJg/MiXUjO1akDcZ10ulBrAoZ2dnDaODCQmtBUXYcrreKmRIZCr58pYcRRqkTjlR+jjLJvfVafbA+F2fRdxwBVL/iu46+vx13UchKhFHr94mX/KEI2Z55pT88IJ+Q8pGHAWYOMtwZZe04NgywQKWBkZoD1iCxWdpCchPZo/3AL76qGhEQsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC/jPeEuOzgiARPARISM8kgRvfB0YZVIc7BIvamgynk=;
 b=d+s4Wqs7kS4v87ZY+FejuXnRlKNj5v2hFRQztnMve44PQDoYyYwyooAXHVXuzJDb+xP59vO6G9CYOBI0E8nX1LvLWG2kpwk0HL/vVZE89xgRQNQyvhDCKfMjRI0MgwLWrgcDB2h08lKTth7wNi1wRGbNBtP2eWTewHy1zKz71kSKgiPEl7ELeZrwXTTMqUkD3vIqqOmiFGXh9nDd9ceg7BCxa2efNXGwIGPunn2/6gZO/XtCIqNzFU9KyqyZdF7U7FgfUys7ea/e21leinxY3oTgQdgZRBzR5VwKiUUaRvvCnYKq3pQKenT2UMg5HvvbU0U2CD++6EKg49qPykT1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC/jPeEuOzgiARPARISM8kgRvfB0YZVIc7BIvamgynk=;
 b=OFz0GPXwoFVzhIKRps+wg07mauNX1sJkuLR2s8BpUQxH9UHCCDm/48nln9HD6AklMyKfFAcYy9zv2d7JB9rpwfis2qOXn06pv4vjMcLp7zqYMqdITyS4JU2Uc0IiEXcJrxSH06v4pZJ6aFHZQ3duNVQKT2ciVFTVz9pOjzDtxg8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3575.namprd10.prod.outlook.com
 (2603:10b6:a03:11f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Wed, 26 Jan
 2022 14:23:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 14:23:46 +0000
Date:   Wed, 26 Jan 2022 17:23:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     wqu@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: introduce dedicated helper to scrub
 simple-mirror based range
Message-ID: <20220126142328.GA7357@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: JNXP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f5fc8b7-5c2f-4ef7-73af-08d9e0d7768d
X-MS-TrafficTypeDiagnostic: BYAPR10MB3575:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB357585DC634381A400189DB18E209@BYAPR10MB3575.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhX0pJfWR4IKCcqVZIms0bagmXYY/IP5M50DBncxXoIlALH0XBmNZ+io47xluwNgfoINtSTijq861ylD+5ZiISuZ9INRedzD0k+rC6klqE231bnmTa1jxmdevT8ktXPRujb6kJnKD9Pipo+07MJOeAVp1nmHrv6zzL7E4iiFSimYwzq5up3y2YAf2uLC/cHvvuSube1aNCcK5AIrH72vPz1SBwP0Y1310iow2L0dvGkYWsTw78Vak4WsXc8EfU4Efe55zRKeLPFZnmlWHHUYjcWym6ICVueiZAR83LaIRlhAAg3A11sATcbAkQx1zGMfLgI4jXzlmylvuQVmFpoRYaSznRarG68Ebp9zT/cuyWJyCfaBp1OrPCU/dCRJKvxiPjrsOQFafnpKjyFrK9912VGb/FBMfWapOGd6wVmtEjLyCswh8JSVGQjZ1nmoM+9YqR5XxINk6dSoVLP10PgJbEKnkmanVhEP3/OrXsqo4ZIJwiNEABW1oSvedMuBeX1t7j13XgBe10jz7X2V5A3lOPt3oSGyCq+/D55+I0g9Tn4DFufba3cJwmYfsN95f1Qq9UyO6ukDTe8GbuaqrTGZlWHMDG0vrRuCVYwP4iYJ9GbwFykNJPGdBTOavalXjs13AWO8gwBlGcS26g1VbvfiUhIlvsCgOj4nMUcLE4bqbvmsAGao5CtI/wPIiQCS9VbjgqNcV4FpQK+TNCRyFHx65A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(44832011)(2906002)(1076003)(6666004)(5660300002)(508600001)(6486002)(8936002)(38350700002)(38100700002)(8676002)(6916009)(33716001)(4326008)(66946007)(33656002)(66556008)(86362001)(66476007)(186003)(26005)(6506007)(6512007)(316002)(9686003)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hD/oMrnRgwmAfZIbbhU4fMfO8cSUVpEW2Uvh4FvRvq+5nPRH7ltF0oCzucpx?=
 =?us-ascii?Q?8PzMQCO3julAfM0CAwTIF5JwsOvbF4fQciaQCUGLwj2ncBcQL0nC0Y0TsKms?=
 =?us-ascii?Q?RkuIF0/2vXepQV8+msCHQz3uaQdnT11Wd8CSJwQoju+n6UzHM6tC9L6KdWEq?=
 =?us-ascii?Q?KmJR5Y/x5a2gluaavArI0pCDkBNfAPfyTSubuL1fXQsJqg8DSOKFDfKRHA3K?=
 =?us-ascii?Q?fmZPbpgWt4nBabC/Z4ef/FJvWuVKiY/UC8ZACFDZ9F8wqd/NuDiA3YoaELBW?=
 =?us-ascii?Q?oEcXUBS1G56WwVoe6MTViHBql8xRCnEbAiO/jD5wQBr2KNtj4jkDV072/lVG?=
 =?us-ascii?Q?01JX1MYzOz8odiEbA6UdQANDAkcptrl629etQs7XIP7+cmnvEjev54HNVKBp?=
 =?us-ascii?Q?/p1v+j1lE2YPlGV2H7OTVVK/5QW8Ac9TJLnm1YdE2nx5Ud6JrBJeBhYPPmEu?=
 =?us-ascii?Q?ll6yYgCf78sysFVPy/GhSkFvTG/TVL106VoIcOCMzyE1gdJlVFV+xkcnT2p6?=
 =?us-ascii?Q?lcc9YQ5tsaBz7VtOlQ4TKE3gqGpaJR5OYNFzRKf/ui8W9rrIygXuev0PjEQH?=
 =?us-ascii?Q?stPQGGkVyfPdBtJxxrVN/UCLeNKeCWv1sjTReQtfJlZSlz+86CGzN1vCfn7S?=
 =?us-ascii?Q?7Hxj76/0lwNwAAYMjXEVCid1R8mPpD0k4/Xoy6KvNd+xWuwu07Einf3qfDr8?=
 =?us-ascii?Q?cyZPQiv5v9GdIFkxPc1cz3+Ri3Y8YNTujP9/pSfdk8V/WDZS0U7N9BarfcuJ?=
 =?us-ascii?Q?78JlbNEDOumgtP2zCJ9h6eAv/x4Bd+iTXQujMg5UvE5QR4gv3qwE/CXWo0Ud?=
 =?us-ascii?Q?oFShBVtvDhFfSnQUlXFncXSOWcLopJ+q+YZv1XaBq+5v9eAnavKFXi/dkaq3?=
 =?us-ascii?Q?FyJityHL4sjjxVPZrnQjwxeHnTGDCspxOgIXqHMeqcrIGksCl1rOYUnVPb8w?=
 =?us-ascii?Q?o7oK5Bo2E61r3t7kfyfD8d9oRBcyNOE1OcPonjmA7RrREWRkiRAoRUk2Ni1v?=
 =?us-ascii?Q?5NNi5qJu4bSUV1xscx2TFHbMrSQkcXpFI0wqjNSO8RlV2B2rRrHZOYDjTan9?=
 =?us-ascii?Q?9DbHiOJ12w9tYau4PMmOQxYdS6P/uL7vTQtpvsUWnWnX5hKhnkvBtzdmcBmE?=
 =?us-ascii?Q?ULiJK/dh0JZUav2qQwRV0tIT7acOjl+Mnv+ui6HvNnE45XwRvnN95MHZATaB?=
 =?us-ascii?Q?Y6P9fn2BDFZCRxrwm7nzd18AOiRzGrRThn1q0Rygn/2bFJkjXYRmNpgJERn0?=
 =?us-ascii?Q?PLbupqCGD9l4P91OW8vl8AtE+B2WKMM1mnhmjzluF1JNYWO3PeKqfyL+Utmt?=
 =?us-ascii?Q?m7BJgdl0HrEOfunWUzjBf0v2gZ/s8G1doaG09Tvz+4DZyszLpgdRV0K7vOYS?=
 =?us-ascii?Q?hyuI6WJc1PhAHQGg9XBEhywQ8jjZDkH0zUtFoac1FSZE8n1GmmyvDD+YxTuM?=
 =?us-ascii?Q?SMgtp3E01ZM9Ow0v8iSm5JvUTrykb1oyFXPqHEH7LozUpTVHj8q8VXKJQGWD?=
 =?us-ascii?Q?2izOpW1KhhBozOENSyTx2m/vuZW6XjUViOtp5cfTox1ZChxJ84AMCEpXKU34?=
 =?us-ascii?Q?Q3O2EBI545FvMIFVtGRuIYzeHETx3n3G8FTsYIS5KdvNJkOdfZV83GaiEqvs?=
 =?us-ascii?Q?SA4EcjmyW2SrcAPyd7u1wb0NSL13yiX8lRo0wR1I/tjsVLrsNBb8SjArZMtW?=
 =?us-ascii?Q?Ugb3i0CMlSDQ3hGAYvfQIE6IQaM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5fc8b7-5c2f-4ef7-73af-08d9e0d7768d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 14:23:46.3395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UM/XDlNI2PdMcNrDoXOYSZORc+xmQJT22dGVffFKas4ru0FV6uhijapj8gz1CDHy5Q2DzMdm12Ze8HTY0F+ZotdnJp8s2TFVAPmIDW6tBuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3575
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260087
X-Proofpoint-ORIG-GUID: 2ymQMZ6eD5bJzTcoVSSpDxlBbvw6zDms
X-Proofpoint-GUID: 2ymQMZ6eD5bJzTcoVSSpDxlBbvw6zDms
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu Wenruo,

The patch b5b99b1e0296: "btrfs: introduce dedicated helper to scrub
simple-mirror based range" from Jan 7, 2022, leads to the following
Smatch static checker warning:

fs/btrfs/scrub.c:3678 scrub_stripe() error: uninitialized symbol 'offset'.
fs/btrfs/scrub.c:3680 scrub_stripe() error: uninitialized symbol 'physical_end'.

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
At this point "offset" and "physical_end" are not intialized.

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
                                                         ^^^^^^
    3679                                 map->stripes[stripe_index].physical,
    3680                                 physical_end);
                                         ^^^^^^^^^^^^
    3681                 if (ret2)
    3682                         ret = ret2;
    3683         }
    3684 
    3685         return ret < 0 ? ret : 0;
    3686 }

regards,
dan carpenter
