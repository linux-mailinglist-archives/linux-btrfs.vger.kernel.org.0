Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A63527F26
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 10:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbiEPIFB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 04:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241431AbiEPIE7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 04:04:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF643121C
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 01:04:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G4DQlL020883;
        Mon, 16 May 2022 08:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=OY56IHTJhe2ZVEYYeMd8Y21LPgEVAEyqv9tuvoEooKs=;
 b=fEFQ5N71C3qpVUBdOwTwtVPp8esw/n8mqpnGzEyjXFRyEhZ4yR/U9/GVoGrZWLb7+r+3
 M/oAWy3WZNAUBadqMQhbHIOmzHJvTxUIUgQTfcQHmuAcqce0crwwi+inCuxa4iX8fhw9
 UPqjsWhTqHVoijoNa5vjkcpHyi3ZPky++fBukaMeMMq6VARcsZPnZhXn05q1GNCrHNou
 kl76A1RhyaGs1YUMyoJtxf6dXh/3fb2CT+U4RYOh/5DWsFG4+CZUSsPGsHjgMUlD84jJ
 MzKyn6KGFHDFMJmrhliyP3MeGYxwXiZZ9e4B0CJsgTjpFVAiLf5lx2tBL2XJafJs20xl +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310jj77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 08:04:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24G81b1B011201;
        Mon, 16 May 2022 08:04:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37cnn128-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 08:04:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE+6rX/+Np/AKNox+JmX5wQHqTvqIbhxpENh0zOGmEtpM5iiRYOZuQAshiScUqyM/ywrzfKmU6umNC2Z0EJXW+EnF5CdLFg9H1rvYmIaP6GFLn0yTtZE78sE00WuOZPtsorFyGxCWe+xusNazTnEGW7xjgM+ZX6LgCh8lz0kDxbKHHIg74wjuBpG4stiaqjauGTWL1D5Am8at1SD4dcxDMc0V7oM+x53i3KZa1p3D7CKtVDHczHeTQYok4eb7+PlntVVcA+1bOtJJYwc2F0iE0dUA+cBNphLENQcaA2o7Ni6oOhDE8mPY9tzRkIfELaDAycJ0Y3LNv8JoQWnAts8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY56IHTJhe2ZVEYYeMd8Y21LPgEVAEyqv9tuvoEooKs=;
 b=hlre5LsKgalL2L3S+ZoU3kWqly+SrU9ZB6yEm47yqbYvzE/eXNC1Cu3y5P4yYlwBqLNI8fqibSXTHJ7pXa/nXcOg5sf+/EyrZELROtpp2Mx8+ODmWgIs9Me88Dr96p4QD5tFDEeCVZG110ZZt0x8QZanpu1svBjznck/sWEoTBjoBuK/dCOR5phVLS7c2klBaXm82Z8rY37c6iVEvjvONVTNJrQZyP57Aougut8opZ6bB4NsW5qHGjZhZGnGWKzlFcdWmKmCnu8RS19ANpE/yh+/2yboLnr2Ctn5WBJcLd/rTmgJJr9qbXW4JWSRN4jC0AbKbkgd6LSuETy58F5BLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY56IHTJhe2ZVEYYeMd8Y21LPgEVAEyqv9tuvoEooKs=;
 b=x9Eb4bKUPY09+gSBZhc1/ZBjQPM/lcODaIPWpXe9ERRKoeP/Vxhx57tSoShah5aIEdTaRugj+Hr0EBkzcqZ8NDcpVQX2RLaXvgZxehc6edVbTRlwdGchEx1oFsPevVlnsqYuR9vNy2GdlzoDX+C0YofMEQB2r6V8OojytOrm100=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3066.namprd10.prod.outlook.com
 (2603:10b6:5:68::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 08:04:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 08:04:50 +0000
Date:   Mon, 16 May 2022 11:04:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     gniebler@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: turn fs_roots_radix in btrfs_fs_info into an
 XArray
Message-ID: <YoIFmTMuHork+zC2@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94aad527-6e4c-46fe-e76e-08da3712c005
X-MS-TrafficTypeDiagnostic: DM6PR10MB3066:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB306668B496BC57F9CD274C9F8ECF9@DM6PR10MB3066.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SasrH/hIgMQs7JhY3AmTWOCZlj0thl+LNJDLRUnxAd0V/KRSC1bpo5coIDh5xch6OdN2Zf0wl7MAtWXIkyDDIXLeOqGKYwe1tSJVC9ebiRuM8tpqo3b4cEpSU0gwUMZHg1XKifg7wnghsRSA4iVHsZPWQuaChkWnPy0uRVgTDquggjpDc4Je4+yz4kTqsRzFgSzwwa6jYj06Eut1zQgrLJVjmAxVmp0dhKJda6gaczO5nXzAWPz62uA+KhhSJj5XbiBjb69jaye/pxCzSKN7PtvPCTTvXtv5xMbgL2jOaJA7k2ozVwc5ntYiYSH7tacChjcsvZ0+AbPcXtwTQG2KOuiE/VRKn0il438QWVUuCQFBsfUUI9ENzRue3TjfDAqQQb31Lru5UVgPowek0y0ktnZ6ViGipn35mXHpjh1fmnC9Z2+ObXlDWIXqxkttIt5zom0BFDhLhTDjKbbOEjGnmElKXXkPpGaZQP6oMwAjeR0tWOJSQIowKEqRftL2u75QWeN3wDJ0B723dCcxIvZjPSPbLWEhFqheKRt0TTcLKydelV/4eA8xcZaTOnvKRCmPw/zmMaBeaXTiwtCkPDlx44Y9wQgkhFs58pG7X8HW2sAfjFJk5rkRyKq/O7atNaHy3swCEhdqsO17rNl4AFB5vFFjtNOTbTGy2jWWR0T/YOT0ILkbKm3qLXOBG+9BpOA7YcJi0I0Uo1O1VL6dXV6fYNIsMouBXX1lIP69IsvbrW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(66946007)(86362001)(4326008)(66556008)(38350700002)(38100700002)(33716001)(6916009)(83380400001)(6512007)(9686003)(26005)(6666004)(186003)(52116002)(508600001)(8936002)(2906002)(8676002)(316002)(66476007)(44832011)(6486002)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?krJt9E6TGvWGI3V5eVAm5crMlsICW2hkz3iCcL1eAfSzDmhPcFi4vx4uZmx0?=
 =?us-ascii?Q?Y3ZQwExK2eCQPCQooK08wUAIaT0z3+VJBkSI4tZ+UJ3KyHS3qLgynvtGcTn5?=
 =?us-ascii?Q?1tx/YvF6CPsJP4XRKWk164WZL6dpudaNJ5IT+kg+RKxba+WNPuy8bg7Z3jnf?=
 =?us-ascii?Q?lt0dak2htHiC82WWHIbfbJtQ5tdn5TlWhos1X/Byv+iawQb3lXCZ2lZ23xOr?=
 =?us-ascii?Q?KNgGM2rCJeqQqUHse7P1UB1NXJFyIjDO//8/Snrt9SGzkNfFsvleDNbwxC3l?=
 =?us-ascii?Q?Nfp8oOQIff0if2Fu+WRZc3GdrXGCZMCZ3m3n66CH1ZKasEbvuEYqcGFM8Lyg?=
 =?us-ascii?Q?Z+I+4Yi+HOeAepjvr6fPcr0gH6aONo9hzEy+tC7H7ME9PJC30sLtd13Fc1xs?=
 =?us-ascii?Q?LepbN53FmBBRisnsXViqU/WUGCeCBZeKzoJ6KYBa2X+PwExqKcWNroYrTpr7?=
 =?us-ascii?Q?jKYy3j0+cQCccIpusNCTVqCLd2IuUf5BqANVuvUdhO95tClzRRyrKMBHLV8g?=
 =?us-ascii?Q?BfM/3TxqluaIjIerFJibozKVnwOW0mPQFNJp6uwPF+p9q+8IeYU8a0j/dkDV?=
 =?us-ascii?Q?CvfcH0EbRWmJveYXDYdCWzfEm0JKgwBkxmXst8S0zF/gCnusoJaLxucfLG+X?=
 =?us-ascii?Q?RvaTm0WYeS18tNtiFegu82DYVlPG//QMKOclbVQdJ36iDavHo8l9QzaRY/XH?=
 =?us-ascii?Q?dhRuEXZBNfOxctMa9zDBQ8Fd6Wg53/Kwg4OOt2Em4YNQVCjuuWu2On0mt8CM?=
 =?us-ascii?Q?s4RViSuDo5xR9dHWGoYDEzN969FjvDRKyXx7zfn2otSsR1XawIfMopA7lzea?=
 =?us-ascii?Q?taaKbzGmYCwo0GZUuD6xaK0LqIUPqrEqPETAXyKquLUKDYns9ahrQhv7EzQ8?=
 =?us-ascii?Q?JiV7bUgSL5DRmety5uJyVbWMoK7ksZGzBnIHlOukbWfJYYak0oO9jVqnCamj?=
 =?us-ascii?Q?h04a1Ne/ykrluzJ5evNA0gMUeg8yx3IbxbZ7pDHob5xyUCZQN9WKtdqNvXBi?=
 =?us-ascii?Q?BfdGnN0CkCAA7n73GJO0d58FwfPi9tVnp/CAr7AYVF2swT3uXYA9QDpxHHXK?=
 =?us-ascii?Q?SxXL9OaCa5vcoKwIIuEsCCLt3B+rJZJoR5O5JwCICgQhVlyb81hy7XiYu9Wt?=
 =?us-ascii?Q?hHJk7X6ZN7rMHsSoq+YcKtyuL54yhx06BLYUb8SD7hs5HDmKV1Zd+gmAMYdu?=
 =?us-ascii?Q?Q0+98uu4atp/0usIKAJ7ojiv625dagT+yd/pulQYsQxs5isGLSxY9IThhfay?=
 =?us-ascii?Q?RoHswX4OoIp8gwCYLjufxn3zDtZV65Q8KnS751YmkU11CTUXSU/d0OEvP8hm?=
 =?us-ascii?Q?ExW2PxRbIA0+3tn/ARAYBZEGWUsCRPDsWERsQt+NFPv47cGf30myTvBKG1Bp?=
 =?us-ascii?Q?i7uTf2KUIlReysSOULTd8cqq6Plt2nu0JBK4xAGhhXwvkRgmGFi5IlQ9PKmJ?=
 =?us-ascii?Q?zKm1wgPaYgtUmYCNMkJzIeDA3aA9VDbfYew/xj1MIDWlLCOSp+IXjh5xzsoA?=
 =?us-ascii?Q?gOUPa7tndS8p+gWgqbUecs/q+ClJqpMOJVno6X112yvUfElaRJZL1M3f+tl5?=
 =?us-ascii?Q?rnxGfxRmqdRHOaHqFm6slEf1W4FErDifA0jnRqEdhaLZNI7c8KoUzoXHrSBU?=
 =?us-ascii?Q?0OwoV5uegO6LFQ1hDsuyYYG/KFZZsV8GIY5R0umdAHN+DKn8TyMp/0xqvkXF?=
 =?us-ascii?Q?RP8/hpiAn/PJbs3SpHyI+3DMMbAhmszHve6qmZJkWLdk+dQcMTCGyRuoWnvI?=
 =?us-ascii?Q?lYYubAce741VdBznImyycFG6PqKBQzY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aad527-6e4c-46fe-e76e-08da3712c005
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 08:04:50.1741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4t9XQiKrhoIF66BMi9ZhGy8yVYi6sKVcfIZW3AO549aYz7h5h3aJWzJyNJEg6jciIp9/7Q67AniQWdmH70fwutuX6xxDGxxqU+ltqIstLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3066
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_03:2022-05-13,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=540 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160045
X-Proofpoint-ORIG-GUID: YWDUtUz4NZ3IFyXGU7kdBCl4ZyUHQKmZ
X-Proofpoint-GUID: YWDUtUz4NZ3IFyXGU7kdBCl4ZyUHQKmZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Gabriel Niebler,

The patch 06a79e50ff00: "btrfs: turn fs_roots_radix in btrfs_fs_info
into an XArray" from May 3, 2022, leads to the following Smatch
static checker warning:

	fs/btrfs/disk-io.c:4560 btrfs_cleanup_fs_roots()
	warn: ignoring unreachable code.

fs/btrfs/disk-io.c
    4520 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
    4521 {
    4522         struct btrfs_root *roots[8];
    4523         unsigned long index = 0;
    4524         int i;
    4525         int err = 0;
    4526         int grabbed;
    4527 
    4528         while (1) {
    4529                 struct btrfs_root *root;
    4530 
    4531                 spin_lock(&fs_info->fs_roots_lock);
    4532                 if (!xa_find(&fs_info->fs_roots, &index, ULONG_MAX, XA_PRESENT)) {
    4533                         spin_unlock(&fs_info->fs_roots_lock);
    4534                         return err;
    4535                 }
    4536 
    4537                 grabbed = 0;
    4538                 xa_for_each_start(&fs_info->fs_roots, index, root, index) {
    4539                         /* Avoid grabbing roots in dead_roots */
    4540                         if (btrfs_root_refs(&root->root_item) > 0)
    4541                                 roots[grabbed++] = btrfs_grab_root(root);
    4542                         if (grabbed >= ARRAY_SIZE(roots))
    4543                                 break;
    4544                 }
    4545                 spin_unlock(&fs_info->fs_roots_lock);
    4546 
    4547                 for (i = 0; i < grabbed; i++) {
    4548                         if (!roots[i])
    4549                                 continue;
    4550                         index = roots[i]->root_key.objectid;
    4551                         err = btrfs_orphan_cleanup(roots[i]);
    4552                         if (err)
    4553                                 break;
    4554                         btrfs_put_root(roots[i]);
    4555                 }
    4556                 index++;
    4557         }
    4558 
    4559         /* Release the roots that remain uncleaned due to error */
--> 4560         for (; i < grabbed; i++) {

This code is unreachable now.

    4561                 if (roots[i])
    4562                         btrfs_put_root(roots[i]);
    4563         }
    4564         return err;
    4565 }

regards,
dan carpenter
