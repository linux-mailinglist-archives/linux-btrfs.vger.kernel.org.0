Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3373DFF41
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 12:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhHDKQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 06:16:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2562 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235527AbhHDKQH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Aug 2021 06:16:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174ADZc5006630;
        Wed, 4 Aug 2021 10:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=OQGIOrbrc0WN+i0oLYWpkFaPnkpclsX8Dob62oWdpVo=;
 b=r7Pw+lyiCPCR7DBzcHZk9KrxhcEAYkO6OuOwhWu3UleD01yGHxDY9A2XwX3yt39B1els
 uNGDkTSgsmQQziGLUehYz+ax8+GVEuBpOOtEyQ9/g0q78/wUQPlCz8H0AgGeveKWhJNJ
 EKrWmY93eR9yg0KLOSLmfjyibzoyRViz5qGNWH9Sj638GG4MfSdiecsMfx4wmT/QALR1
 PX8+LLk8w9TG0hp+6jitwlWaBvneiZa+LiwE9cVYr/cDMrM+DTtart62+3pzgUoAd+jv
 +0oQhQGA+72ju8nyM8uF6P+SigDhchISYpfYySqqyyrP6NEHGHdNdk20QqeNGz1XI/+m mA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=OQGIOrbrc0WN+i0oLYWpkFaPnkpclsX8Dob62oWdpVo=;
 b=nle7Sxd3aelxsCSiHq1Tmc7suYTNZX/dNersvRVEAxuMKZ/b1VSc+K8JbO8vsZIfWThM
 /KPSCSBZh1KVStRuFEGOZNGsgQD5QjR+LCgmURpfM47p9Ub5YU69M/0FiWpJ7X6v+Xx/
 r5Adm1xj1NNDMbBwgnmPeHu9jy4HiwTx0/wdhKtdRateGNNS9TJ7SOtO+y3xE8KR5jFM
 ApFn7B9epQFrAtr56bxFOfj5KBw2VS3v+pmw/wd3UgoELcQkjcjR+ti+Bax6Osw1XtN5
 lTwAkGwZ4mMvbWN4Uqxd4rJAhniNiKDncR+MRQzF+YQeKaLEsj0XQc9ln2ZSnPh2Vutw uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7aq09kbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 10:15:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 174A69Ll179571;
        Wed, 4 Aug 2021 10:15:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3030.oracle.com with ESMTP id 3a78d6ewsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 10:15:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUzh5jWID+WNVOW6Z2OODn891lxGzz2D0E+O/IeoZoXgJTP7VQSu3KyT5pqLAiFCitPrUye8OrBnmIl4kQs3PQCtYF7drwi06bhSMyQvit8FHXbBS7n5a24nb7sacGCYDnC0HhyOw87PpCdK7r6VBpnJQvS9TjwcQfpbIWW5APos2Ehc57i5rbpj7cFRLU9rnnId71QPFdX47J4SxjAHn5FQhlv6dpH5f/gm6O+lVIVc/LOw7cxRkWMGMrirmwu3JHT2SBg7qaOQmJwxdn/Sl1eExdcOsQ/6afBlLFNxL0i4tHv1DX62yD8HT8eX8kBLp5o+T9IIiG1DC9fd8gRwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQGIOrbrc0WN+i0oLYWpkFaPnkpclsX8Dob62oWdpVo=;
 b=OQ+ENd0jySDFMDyMKx1qbQ5K+/QzEyZFLkKZ4y8SwcflAIOmOVicugnw3DXTi2+ee5mKA9sVh1cUFbDp0kHoImUHYZAzT9CVSL1X/SsGzB8/gxR/Wn6JgrvfoM84ruz2SxtXUQos1mdbIqmLKqWfacFq+CG60jDWWiu8NXMb/N+hkhemp5YaActR3LXTpL4yo7QcGCeKh1G+RIg1pEqjwvNl/vv5Uk4hHWH4LHle9LoQPu2xi/Lyt3WhZQ8lilVRX/p2UX92aiXwfLn/nQwoTStw89rKOCeiSKXerZNTebKyxpX2/PaEIdJRalGeIwqtPoIzoVLJfe84jSrE6PVilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQGIOrbrc0WN+i0oLYWpkFaPnkpclsX8Dob62oWdpVo=;
 b=Y8d4dlFTvTzKq9svtj16ICbL4W27zlfEadgzNz1Dy/ZSH5+RzYQIHAd8GTKNifFkEskYVReacLSl6uLaiZl+/KcYYUGUQqft8KQ9EB8e87J1xMl5abtQ0CzMo03czfjmWlEaoFa7bhO8XFWIIlXhhtqJcrycz3lv+EyyJBCePBU=
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5553.namprd10.prod.outlook.com
 (2603:10b6:303:140::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 4 Aug
 2021 10:15:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 10:15:52 +0000
Date:   Wed, 4 Aug 2021 13:15:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     naohiro.aota@wdc.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: zoned: enable relocation on a zoned filesystem
Message-ID: <20210804101541.GA12165@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 10:15:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c28fd744-5b94-4c8f-632b-08d95730d69e
X-MS-TrafficTypeDiagnostic: CO6PR10MB5553:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5553C8B86D9D37795C0FEA778EF19@CO6PR10MB5553.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhLqulefBlDwTNmfaw2K/XDw7tMC0jzMM/tMSRb14knZOhrVB7+xCvNpy4zqmw49vfoq6fYQx8fw8OwJ4J37F2FpqrH598ZykcuYDPqJUkf7sWCYIRwnYeoG62ccBl2yxN+gbrItBV7szQwdrWWDBzvGpf4meAYBvrq3QBaDELhbtbXE1Vo8+FUmgNns3RIuroNIk9SEA2AHn1vbeUKrDscl3s1Uatc7ZamVZJF9zTej4C+dEux/FJtjFtS54clT6YA3IEwpPOVCe2O9/UkE9h+wxNFjqWQoVIaG4RXP9nY21YL9mT7mKkIuVPCaglSOHtvuU7dzUzX+TtbSUmOLtjxpO/U5QI2SLQZNNeSPbmJNGH3/y/kV54lmdkue0aPaZoi0pDGnqzRpRZxbKmq2Ne4Jd2+yYB+HkkBu7jSzMyPK1FvOT4cl7/drtdhd5uJhcKRhrul+BGbEiGMjynk/Mwuymzun4nsz8/xgsgZ4dNSSXEj96lL78bt6y6uGYls1MqDBfSzFC6goJA9Dl6nYKK14bXqegclBo8Scq8ygTlhtRyLYs3dptlQrm5dahXRhURZuFhTUnOHTO/vjouRmotMpxMFruiofvcvxtzt7la0jyQ9LD7kGqCbiyve8pa9LfuI6sUa8Ri5GSRO5TcXL1z31mzeolcfSXA3SCHo0QPRYS9W7tR6WfMUUjkc/fXhINtQMPuBUdLiO5T2IbIcFqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(5660300002)(55016002)(6916009)(83380400001)(4326008)(33656002)(956004)(66556008)(33716001)(66946007)(316002)(86362001)(8676002)(44832011)(6496006)(9686003)(38350700002)(478600001)(2906002)(8936002)(26005)(6666004)(9576002)(1076003)(38100700002)(186003)(66476007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OPO5UxRGq5p32ZlG321kAopkAeFxisdA0YzeS60N9D6KVOZ8DkMm1GdD4I60?=
 =?us-ascii?Q?uo+gZnX/1V0bYYb/NRpI4mcCTvteoZiNnLOujXdt+LfPeK5THcyEhSqkGdn9?=
 =?us-ascii?Q?u9PF7LprB47s/sctHPtcZT7aCtvJVHdbVvVFikY/ejwHTbj0ok04CIeyQRXY?=
 =?us-ascii?Q?VpAIRwqNCVTAoUeNxVDaxxK257QybQu0axHps7zCQ1S0UErBawDwKcOb/4ms?=
 =?us-ascii?Q?REQ+jSA3ypthZQQF9ozMrkhzA9I7BgICGBicZEI8e9nJBtko90e2VmTs3t2y?=
 =?us-ascii?Q?Ul39fCsTyq3kAfvRctQWOZIl8QN++WoCfFhGKoAqjfkjjsAkhYf0yYRNQ+wV?=
 =?us-ascii?Q?H9OQFiJ3/DtUWn5lrZMxQ8rOBuStV43GDTrvvtmOh1V3Hm5FozW7/fCDOLJ4?=
 =?us-ascii?Q?4QCk1rasUcz9dFz36/mRwk5pw6cnPAPwYRZMQk0CnO3AK+sRsQ5MBM6+KZEc?=
 =?us-ascii?Q?URDaP+FTf2uy1NcJiZPra5niBh5BUgrysO7Nly/cDwA1ST3Xl+BUoWbxjRYD?=
 =?us-ascii?Q?Z8Jq3rUOlVUVjbA+EkPAFnK6JFrJS7Ast7+xI/cluEbs9zSmMai1NwEf9fWq?=
 =?us-ascii?Q?/tpxs/xXVufsjvIy//7EpoRjTJ4pct3zXO2/c63dJAWgkTZgOeZen7N1veH/?=
 =?us-ascii?Q?ckZs8BssfQqun7oooMNK++Ib9rWesiSY/mLfpl5T1fFaX0xCiXEV+rLAWRhf?=
 =?us-ascii?Q?OJUagvm+d3C4GF3QDlqCd2h6sUL/XLu8D/NTs827s2fl4LGKzjFGGNzXacee?=
 =?us-ascii?Q?km6LzzBayDdByf7uTtDxW6dSdl9+TODOPDRaHzie8dOSi3kYTeAtFc2AiuHz?=
 =?us-ascii?Q?SAEVt3OvT8GSBQNakNd2nInpg3tW7VqXrMnyOwB7DyCT14+LPs3CM1Vvl7+j?=
 =?us-ascii?Q?qLonoEaFwxKkckGUtWJambN1oXsdB038b/eBkXXYcPkb/paghTPsM4Q7nxvI?=
 =?us-ascii?Q?btaji14b6vD3jBLmgM4EG+2refGZe3yJFDSlhb3VOgSdxwESW75HUhAnqZcH?=
 =?us-ascii?Q?6kZ+/UmcoS3tq0L7ffO2/kHxXdrHwr3DFN5Ov7Vsu95Aw/E08/lp5NPTLn/s?=
 =?us-ascii?Q?u8r+jrM5XROyHpl5gaYcM/dM+OvVGnHIzeKsdDgqe71pezdRT+iFclKpJ4hE?=
 =?us-ascii?Q?ir/36m98/5xruIvlnWzkaBJjUWujyE6rew3BbbgFv96ASgjgM68MwvtB5sk2?=
 =?us-ascii?Q?L5131rQ/tGh/TwHhViJMOiJ6bDSWh0EQ6uinpAqibJpag6iyN0yVGVcmCVTg?=
 =?us-ascii?Q?PrQa5y2ljQjUtZqkSi7++MmF/O4abfJXx6nKdKR+XEVhGZHnpC22tJlwpgxf?=
 =?us-ascii?Q?UrbuOqiDos+777EVPtKjXxVM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28fd744-5b94-4c8f-632b-08d95730d69e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 10:15:52.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pz/XkjutdY8c5jpRLbbCK4zBDs5oQiUkZCi3XaQvvbSF+5Fg9qzRGYR7G6pGOUa1T52/5n19ou/EK77sf56AfucqwHORRxyyiYTxeTVPETM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5553
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=606 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040051
X-Proofpoint-ORIG-GUID: VtbK2H6kdBY_sxgUtCUuKURFFquP4IOd
X-Proofpoint-GUID: VtbK2H6kdBY_sxgUtCUuKURFFquP4IOd
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Naohiro Aota,

The patch 32430c614844: "btrfs: zoned: enable relocation on a zoned
filesystem" from Feb 4, 2021, leads to the following static checker
warning:

	fs/btrfs/relocation.c:3777 __insert_orphan_inode()
	warn: was expecting a 64 bit value instead of '(1 << 4)'

fs/btrfs/relocation.c
    3767 static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
    3768 				 struct btrfs_root *root, u64 objectid)
    3769 {
    3770 	struct btrfs_path *path;
    3771 	struct btrfs_inode_item *item;
    3772 	struct extent_buffer *leaf;
    3773 	u64 flags = BTRFS_INODE_NOCOMPRESS | BTRFS_INODE_PREALLOC;
    3774 	int ret;
    3775 
    3776 	if (btrfs_is_zoned(trans->fs_info))
--> 3777 		flags &= ~BTRFS_INODE_PREALLOC;

This code is supposed to clear out bit BTRFS_INODE_PREALLOC but it
actually clears out the top 32bits as well.  The works in the current
code because even though "flags" is declared as a u64, only the lower
u32 bits are used.

For correctness and future proofing then probably we should declare
BTRFS_INODE_PREALLOC and friends as "1ULL << 4".

    3778 
    3779 	path = btrfs_alloc_path();
    3780 	if (!path)
    3781 		return -ENOMEM;
    3782 
    3783 	ret = btrfs_insert_empty_inode(trans, root, path, objectid);
    3784 	if (ret)
    3785 		goto out;
    3786 
    3787 	leaf = path->nodes[0];
    3788 	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_inode_item);
    3789 	memzero_extent_buffer(leaf, (unsigned long)item, sizeof(*item));
    3790 	btrfs_set_inode_generation(leaf, item, 1);
    3791 	btrfs_set_inode_size(leaf, item, 0);
    3792 	btrfs_set_inode_mode(leaf, item, S_IFREG | 0600);
    3793 	btrfs_set_inode_flags(leaf, item, flags);
                                                  ^^^^^
The btrfs_set_inode_flags() function takes a u64.

    3794 	btrfs_mark_buffer_dirty(leaf);
    3795 out:
    3796 	btrfs_free_path(path);
    3797 	return ret;
    3798 }

regards,
dan carpenter
