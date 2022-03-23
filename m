Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D384E5098
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 11:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiCWKqb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 06:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiCWKq3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 06:46:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC2A6E7A6
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 03:44:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22N7hxh5017279;
        Wed, 23 Mar 2022 10:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zNnvA2tjWbv5ketmCNtop9ieiGjqGeUccpCADsH+S5w=;
 b=kAtAwtKr6G6ucEHEM1a32qUXvC8pDIFJBCukMER1e287tHjso+xl3e1tsNAoS4/Tb7zw
 lUT0P8WLsxqsvtMx8WlfSOY/vhMX7KInP1XBeEL0ncoYdvyv1S1zt/U2BJjZuHnbm7Gj
 KJu1UUnoU39CzNuPjOXVdQky9dlCGTh082+g4tRJBWldA/k9wyPuD91Yz9LniVHpE7Mm
 VYJMYKlJVOPmDzK26GTpp0gqS59TiLhsvuQBzdohJTaod/NebaLAaBYTVPBffAS5/MbX
 OMqIiwG0wUHt+NNXNEi3TX0ZDYzadEUP9Na4VBGiU6gVo4wB54fn+VVwEH7H+Cb3Ij/w eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcrwun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 10:44:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22NAUV3q118051;
        Wed, 23 Mar 2022 10:44:52 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by aserp3020.oracle.com with ESMTP id 3ew701mjuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 10:44:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BExFaFYeoEJPMJMELb3i9tU1BRwh63OFCsUU5JNVXCJJMK2o+CLvmXNdcxli2z7AvOJN9TyiKDH4rXmqWOYW6rMvpXwcbHgM83hKIMBldxv6Xdn1Ola5ay58kL2M9usV077CiTC/4xvqXpTa2Y3JSyfXk8O8rZfHdvae+VC4xJNXBVdJZzcGrzYEs5+WmgB9Z1yPAdJk6cIHpUU0wxSnXqEWJCFICMSAxjw8GPohgx2HNBMn9EJBJprGSStxLhfWoBHnd66GDbLNH8/VbWpTv/EJbo4JBbeNYq0I126XcbE5c3GvXBx4Z7OXtAFrKnV82VO2qCWw8Cknekqoekme/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNnvA2tjWbv5ketmCNtop9ieiGjqGeUccpCADsH+S5w=;
 b=I76tI4OgM4inWycwm5LaKaI3/YFZI8zRi2pUax5xuaPGEFSEsjF/Eag9thfmBo6nOaClSnNVAuCSMFDaFcCKrO/wjskfeY5WMM/s+311Wfpo4JByi0YHdWnPHo3iuOCr3FJX5idB/3lGjhLpwftcWnmo17a866O+Lf+mvMztr0QJpeprcdF7aItAwQzPEtEUm7F+I77D44ktABnTv7ENi1bhcshT7LKB6IJ2QtjCleo6KJk59WJt0jzXyf29aMrXQooTRtAhfIMZgLwAmHqG6hUWswEKHW0uZEzpzsE2h9Nnn4yYi03+MkIoJb6gWM+Dmzi5V8n3HfU9XmDKmUrWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNnvA2tjWbv5ketmCNtop9ieiGjqGeUccpCADsH+S5w=;
 b=K9PTUCUSLUOG7LxMc0j9b9E4T+leAP1H9dKzG3p+zuJcb9zN6wzDwj+tb75L61PMi37XFIuOmJmY9MZGBg79Kx8PrgiTrcuAUmCnUdBW2Sz35FWQuuSFUi+wALmbVNeNVBESu44S9fMawRhmdK83aQ4es2C1W9hIFfTNbAnz3+w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY4PR1001MB2215.namprd10.prod.outlook.com (2603:10b6:910:49::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Wed, 23 Mar
 2022 10:44:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a1:3beb:af48:3867]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a1:3beb:af48:3867%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 10:44:51 +0000
Message-ID: <b4ff2316-fca8-2f04-bf0a-d7747118b768@oracle.com>
Date:   Wed, 23 Mar 2022 18:44:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 928024cc-02fa-4d4e-adeb-08da0cba2851
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2215:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2215EF1D1E66F973695BC812E5189@CY4PR1001MB2215.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lAJ6344Z9b2CFFZGKqKf9jLWi8cd4KyMd5aID/QtNwbV1ZmAoK/wUf7xJneki/24uGJvhcIe6sR5dCkcr0NQB4RChH/tyigXBTTscW6MIE+81bqam+Mh5jku3S/QMesO0LSIPkU5IhhW5GTxvw0H4llyFaVhT4ze4YA9MOeU8oZtQswHiWn5j8Rx95zy8BlnAf2jR6WKgwx/+IFRshHrsrPBY3VI+88Z0Q0Rpd+u64FymWqJoURCVXpa+8gEHbiRidAF0HtKaeZWBZWZk8ZMB+gcQCQSgbHLozgW+gDsdh+85OmbSNU2mNNQnvhHognaSitsS4/tri0CsbXHZgh3nUQoRzaYxyRXrt4YmrFV7JMM2TmIvis8nNk59h/zq+jECJrd/t2IP9hfuPkaO1UOUpJ4YHNkkKKlz/EsXnsc6CkxfqHHQcrUJcr2yhNE6Jm4bI4I9+fTBkTCplJSMB/qZw76CGChe3hVvSEoUlpGTUlo8GDvuPrc5P2WhiecxUOiP21E68r7A1aBMnPTPR16I51BNV5DNAWWnYgzaZ3bGxpsHWlVtnr6bKw/ddZYWA3sSQ244VVsV/uhjLtvRdNcAjM3tpGunN/i3/8hkfkEJIVsmoLFjCqd7OpwhG65nIFrMsuNJX5QuZkUmiyISi1njKFGkRHBvuksn6/nbPXpE2MW9XThr8h6UNX71xLHuyKl5Aug/QY7fcwBPeZjg77cajTiqsLXptZw885irU5AbzFhVe1Hmj0BHlv2HpWDL2rXqPx6ZQuAa3Hq3gOlo2EI4MVzEAy325EX3hQgrGMt7xk5RKBnAZBZ+x2fH8u0e4Np
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(31696002)(86362001)(316002)(966005)(53546011)(66946007)(31686004)(5660300002)(38100700002)(66556008)(36756003)(6666004)(8936002)(8676002)(66476007)(2616005)(26005)(83380400001)(6506007)(2906002)(44832011)(6512007)(508600001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFRaTFhhZmJXYzRLL05jK3JGQkNPaDlVWkJPdjE3bU9QK3drMFdVd1VhVWJl?=
 =?utf-8?B?MjRIK09heHgwQlhqSFU2akJiRjhpNmdvZlN3M2xub3RDTGg0WURENmNVTlho?=
 =?utf-8?B?dHYrN3BpOXdRS3h4V3BmQ3FyQUxZRS84K2JYdkk2dE90Tm8xWEdIZi8rK0xY?=
 =?utf-8?B?VU94dndzeVhXMGoyeTN2SDNqZHg4RzlwaXBVUFh4Y1k5akFGLzNnSVlKZ0ZD?=
 =?utf-8?B?aVFFWHRkcm9WNnRlNnNieVdrTHpJZlRNY1BNNUROSGcwTmg3cEE3cHROZnph?=
 =?utf-8?B?YldUVmRkOG10ZjdDUTNTS0VUYmhkNWhmcWhjVTFxVDJMaTdxU0JwcS9MQVd1?=
 =?utf-8?B?a2ZxY2RwN2JjRzUzYmZHdldjWDdnNzRBM0lEU04yNGNtQlRCOE50dE1TYzNu?=
 =?utf-8?B?WXJVblRyVzRKSmpCbG9wdWpVWFFGMjZ0Vld0QW1tN1dSbnhFbGFxQ1lmM01j?=
 =?utf-8?B?NTRFeG9lS0wzaUxjd3RzWEMzSWY4Z204YkJvekIwRmJNcmgvdUFkYkVqRFhP?=
 =?utf-8?B?NDlIRzd5N3BoZlo0czBQK0p0a2JSWHdyWTg4K01CaStyREdsR0xVazNiRGxp?=
 =?utf-8?B?SEJ4RzJsNGY1MEx0enkwdG51Yzd0QWtxZ1FLK2swVFc5MDBBQ1ZRa0xIVTNH?=
 =?utf-8?B?YVVkUXBrSHdkWWFmUVhuaXplU0t6KzQ3WXdFWk50K1RLdFM3dDdWaXVqbytv?=
 =?utf-8?B?SldpYnMrZllQb2hwYitmYVZtYjNFTGEycTlocVE3N29IYmdKYUhzemVRS1or?=
 =?utf-8?B?K0FPSUVvWUJrQkJGN0JwdDdZZHA4NnlqckQ5bTdBTjVQdG5FaU9aNUtnNDFv?=
 =?utf-8?B?NHV5aXJrRVFpYklRRTFFS2VoZEIyL2dzR0JvYTNSRlUzZWcwWmRsRE5nNkRy?=
 =?utf-8?B?RXUzalpQSG8wakRWbEZKeTBiMXR6TGM0SUp5OWxncE4yM25DZW56L3o5ZHV1?=
 =?utf-8?B?UHN5d01TajBnMGt2UGVQNE9OTWZpQVJmWFBnZVZpSC9RMHV0VndKajUySHpB?=
 =?utf-8?B?cEdFcVZpMFNNbXc3ODBKeDN3Mkk4bm5La2xYbGpIQlVQKzhtUkVnRWo4NEdq?=
 =?utf-8?B?elFZd1hYajJOcUduSWhzT0xucDB0ckMzNDFiWXdPTFp5Y0R0UXNZU1FGSm4x?=
 =?utf-8?B?T1JqN3F6UEwvT3NFM0ZkK0s1cjhqakFyR1dwMlJEMlpXeUQzWm9HbWZ3ajJ3?=
 =?utf-8?B?N3ZWUS9iWHI2VEtrTjNlekZNNHBNdkh4TDBZMVFGYXhqbEdUWWRKUEw4c3hv?=
 =?utf-8?B?eFRXSlE0dXdmTlE2a2pEWnkvaExlNmo0U0R2ZFlHRGp3RXlER0lrekNxdEo4?=
 =?utf-8?B?TVNXUXV6N244cktRL2hVZ1J2aENzSGRHMFNVaDAxZ3M2YkRVb04rV0ZwU3Va?=
 =?utf-8?B?Ujk3ek1EMGZ0RXJTNndMOWpxSmN4eTBYU1hETkh0UksySUFNWmNJN1dIdXBt?=
 =?utf-8?B?MHo3NC8rSlFnK2w1QlhZaTRWdWRJc0ZIZk9DanNpNDI0Umt2citNVWd0RzhX?=
 =?utf-8?B?T01VbEpPT2dLOTFpdzNpSXBhVFNqZEp2TTZjcTExTDJsQnNlNmc4YjgweFIz?=
 =?utf-8?B?cGVZMFZBekkwcmk5TjMvODJhSzNTenVvaGZaVFAwN2NpVFZiL242ZEpWWmI5?=
 =?utf-8?B?LzhSVER1VExscVBQRzVOMVU0YVk1eG56K2tlQVEvKzcvemFwbUhyUWtmV0o5?=
 =?utf-8?B?SENza0p4aFIwRnZIUDl1Nk1XOFFhaFpJWkhVbnQwWFljQXZYTG8ydXNIeVdx?=
 =?utf-8?B?bFp1OXhlNDI3dUlnWnQyaVRtdDYzMnNqak1LMTk2RE9LalF6MkZNcm9qa0M1?=
 =?utf-8?B?b0p3cjFDREMxeVhRM29aOU5Hbkc3UkFJYWI4RmpPYkFQYTI5aFZFWnRZaXp1?=
 =?utf-8?B?bVppN0FIV1ZOOGpUaTJIWmsrK3JwN3RsY3p4ZllHV1plcHNzTlZJcTFWWDdJ?=
 =?utf-8?Q?MhD7OcZ70KkiFzRzzpb9CfDLPKiT5fv2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928024cc-02fa-4d4e-adeb-08da0cba2851
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 10:44:50.9675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GV9s57Nm5FO/13majy6H1I2GXYATW35OjbUeaAazeqjFqsE2AwGSE22W8HCP2+H+Kq+0GLxfIFPULhW/iJ9Oow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2215
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203230061
X-Proofpoint-GUID: 1B1_3km9EuIUjYs5RgKLlTComC2N77TQ
X-Proofpoint-ORIG-GUID: 1B1_3km9EuIUjYs5RgKLlTComC2N77TQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/03/2022 07:56, Boris Burkov wrote:
> If you follow the seed/sprout wiki, it suggests the following workflow:
> 
> btrfstune -S 1 seed_dev
> mount seed_dev mnt
> btrfs device add sprout_dev

> mount -o remount,rw mnt
or
  umount mnt
  mount sprout mnt

> The first mount mounts the FS readonly, which results in not setting
> BTRFS_FS_OPEN, and setting the readonly bit on the sb.

  Why not set the BTRFS_FS_OPEN?

@@ -3904,8 +3904,11 @@ int __cold open_ctree(struct super_block *sb, 
struct btrfs_fs_devices *fs_device
                 goto fail_qgroup;
         }

-       if (sb_rdonly(sb))
+       if (sb_rdonly(sb)) {
+               btrfs_set_sb_rdonly(sb);
+               set_bit(BTRFS_FS_OPEN, &fs_info->flags);
                 goto clear_oneshot;
+       }

         ret = btrfs_start_pre_rw_mount(fs_info);
         if (ret) {

> The device add
> somewhat surprisingly clears the readonly bit on the sb (though the
> mount is still practically readonly, from the users perspective...).
> Finally, the remount checks the readonly bit on the sb against the flag
> and sees no change, so it does not run the code intended to run on
> ro->rw transitions, leaving BTRFS_FS_OPEN unset.

  Originally, the step 'btrfs device add sprout_dev' provided seed
  fs writeable without a remount.

  I think the btrfs_clear_sb_rdonly(sb) in btrfs_init_new_device()
  was part of it.

  Removing it doesn't seem to affect the seed-sprout functionality
  (did I miss anything?) either the -o remount,rw
  or mount recycle will get it writeable.

> As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
> does no work. This results in leaking deleted snapshots until we run out
> of space.


> I propose fixing it at the first departure from what feels reasonable:
> when we clear the readonly bit on the sb during device add. I have a
> reproducer of the issue here:
> https://raw.githubusercontent.com/boryas/scripts/main/sh/seed/mkseed.sh
> and confirm that this patch fixes it, and seems to work OK, otherwise. I
> will admit that I couldn't dig up the original rationale for clearing
> the bit here (it dates back to the original seed/sprout commit without
> explicit explanation) so it's hard to imagine all the ramifications of
> the change.

  We got fstests -g seed to test the seed-sprout stuff. Your test case
  here fits in it. IMO.

Thanks, Anand


> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/volumes.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3fd17e87815a..75d7eeb26fe6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2675,8 +2675,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>   
>   	if (seeding_dev) {
> -		btrfs_clear_sb_rdonly(sb);
> -
>   		/* GFP_KERNEL allocation must not be under device_list_mutex */
>   		seed_devices = btrfs_init_sprout(fs_info);
>   		if (IS_ERR(seed_devices)) {
> @@ -2819,8 +2817,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	mutex_unlock(&fs_info->chunk_mutex);
>   	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>   error_trans:
> -	if (seeding_dev)
> -		btrfs_set_sb_rdonly(sb);
>   	if (trans)
>   		btrfs_end_transaction(trans);
>   error_free_zone:

