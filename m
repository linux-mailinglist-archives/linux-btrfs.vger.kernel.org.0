Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E254692319
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 17:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjBJQRE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 11:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjBJQRD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 11:17:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B053977B86
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 08:16:57 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFMU1p030373
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 16:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2022-7-12;
 bh=Y2uDz0mVr2wQo3DHhUmC4AA1WIupJFHIDIBFKhpCUy4=;
 b=bQtBjMxoiZo0PkSMlF7vc8/ojiGCH3S4c22n8LbYyDYqbVy7Qp9zIm2uqdz6250IhJt3
 6VjJ0NFOdvFeShhxcBRL4Bie7mfErYsblgmNq1Ik/Q6/DWp1auQtJliX/GmzagPTL2br
 lqS2aEhTeIjYsp8eugJl6QhyYf0V/79e0iVmK7fiVNG1072Y8nwWsYSa9luNzCyEwSOl
 tYh8coZIxyj0sYEsMcclek5Cs2FrLwRdlZFBgJvZg7gOqp2M4L9EUzgaJTL3UnjqIWFC
 xD5S/etta+S4Fg3VHGVXHREL1MrdreYvIYix1K8QG9QWHlvQkkzoj3jPXCGkkoc6UQVL +g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe53nmjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 16:16:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AG4jVK025717
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 16:16:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdthhd89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 16:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUWHLf6BGMRfAMlVtJKrHM4Q91gs6B1vkoa6awt467LcJusjllVXLF04w5gA/olnys2wXl1miaAQavJP5GBWjSroXiEUXHbfK2AmCBeItiAtJJ95mU5TL3QupLJVbHnuB0+eQa9Py1QhVoKPBMepO5LLzmKVFuYfJZRem1EE32KMKYJzWS50eRLcbuPu+TPfe9A/RAcf45bkFEMchNdNnLexJ5FXsw3AtoPF3gUFLL1v9WJ5bZaMbxtW3ZAtQrmTqMUz6uG7NIYi2v1ImRNIVqWz1gXwhf6XqKbTIpckPEX0l9LHDf7+p+RPezLVeUR9ynCP0CzDFVoxy1MdUblKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2uDz0mVr2wQo3DHhUmC4AA1WIupJFHIDIBFKhpCUy4=;
 b=NvJAY1BzKy4/ofosK9TLCduok23dgvY4gNyqcQDlgyRjbgvLdI0vP6pTNhRgXFNJ/6xabVC8aLGyHToJBM53dZhnngYF0b3SzdJmQPRtasYu6Y8ZoPTuTTUlR2mO8eacMpRxT8Hq3KiD5TupARX6lGsEKhYZ7QzMHbpZTBZxaMGDKNxrX5D1c1KpTJkwLC02HK9RmqIErvLEAcUY8RG11gwypG+cI/+RYnwkx2K7Q7WsXZ1rV7Mw3hZvHLY/LlZ4CM6QykFujt9lxgi6aXDnWlCnH4eWMsojOO0H0hYx7A/TweKJoKBQgopKG53VEOCeuVBFgvPv3KUIh18xP1qMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2uDz0mVr2wQo3DHhUmC4AA1WIupJFHIDIBFKhpCUy4=;
 b=xOKOK4CPqif7T4Ke1wV0eZPJGbRpYjTx2hDr+FNqqRnEaCASqsTqETODG0PWqZv4hL7RpIRWCBaU3gccPHJgJumz3kuEKlwSYwHDWUWhhWSo/Q5rY5n2LJVSduVIVGSUwYH2V8GJtgyxQBusVc2zptfwJPwcl1CszwQBq8P9P1c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.6; Fri, 10 Feb 2023 16:16:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Fri, 10 Feb 2023
 16:16:53 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: avoid reusing variable names in nested blocks
Date:   Sat, 11 Feb 2023 00:15:54 +0800
Message-Id: <8c49c7599f9ab47d93ccc1635bc68e541997d766.1676041962.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676041962.git.anand.jain@oracle.com>
References: <cover.1676041962.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0229.apcprd06.prod.outlook.com
 (2603:1096:4:ac::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f9addb-c6f4-424e-2949-08db0b823943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ce31qG3IoKErAee+U77O4cvI9ruXLpJJgy3IsrridjJiS7HLl8+2kL+lyTaVHhNVi9FIS7wUSXkCc97CU79DNcwO8YAQsHyfyad6+jYbikMiWdQBs8OKNsHSdtcMISpS3G/3Bs2mf4V75+ZorMyHXUCZpz+p0YKaxnQITj7LwOHQE+BnIjPVGIsva8ByxRG+3ealaxzKImruzF5X/T8EwpQAXHCct1gLcy6xSjG53EPbZKpzB12EWWhLQpUNI4ZWqNKA04yUyTehDPy/bku94ZkPu/ECBX1knY07fJ2H0PrGLd7ZxDbWXY2H+Ft7wY4N0ongkBQfsrEqRUuCnReg+djgnFbqnpNFNxBQFXIa/AsqOopgNXiKtAemnuBtI83GY1a7YMpb0bFZ6AFlTn1sWcCV04ncfX8BBZhCwMpo0xL1BhZY4kJ7BFqxJsMTeb4IpCv1piqirZ9MXfddgA+YorDlfO8PmOqk4jHeLiWDcV2c4JJS1GA04oEOEHTZm0wXiZWuH7WgNoUPlwdQ9Xj+3gXlEAq6o3z3Z4bolDcNwrogOmftO+gtKPR1E2VXe7OBQxupDCKWqxNBAC09z8LkPz5MiZVxMyjjIgbC9vINvhJauhPoFf4aNksmQkGA0aB7QZBnqaEjD+MSP9Am9IqorA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(478600001)(316002)(6486002)(6512007)(26005)(186003)(5660300002)(8936002)(6506007)(44832011)(2616005)(2906002)(83380400001)(38100700002)(36756003)(8676002)(66946007)(66556008)(6916009)(66476007)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NECp7a7aR84ELnyJ8E2G8kvVH/4bw4OKTmEb/6XKpUxd+/FK8z4Q8+WrfNuM?=
 =?us-ascii?Q?6midrJZDysnbQ+1i/9WjhWgdxzNJ6l5aBy8BjEf1nr2GlM+77smKBLn9ogg7?=
 =?us-ascii?Q?Hbu0aKfreqDwliaubVd+OuCLAz6BRSTgu9oH7boK8Tibp1p/P2N85uJXTPiK?=
 =?us-ascii?Q?/W5ALvv8Y5LRXrWHhv+y+tw6pUXYPGp7lzU64Ft7OwZPLoRnafOLmfPdVjdp?=
 =?us-ascii?Q?hPAYN2kEtcvmD9IDDgTreiqioH0z6Vh69IdJatVg8ZCas2F7OX24mO7PADwQ?=
 =?us-ascii?Q?BsIkIuzqh/5m5EWIkMBrEtE5z1aiuZtXcBSxYAR0RaS0sKI75MaD1g5/iXHW?=
 =?us-ascii?Q?E6uGh41ND+mw7lMq5pmANsENxSV6MtdG7c9r7d7TjYVcVPAg1GbdDTaMRDSj?=
 =?us-ascii?Q?6aMeq1akzb2x4xU5XAQKvYKFbVHPQBwO6t1YKSo+CU4nRAEKD17kT3/fF9X1?=
 =?us-ascii?Q?bDBW2KhUE5tuStMNpJ4cIrn0BIJgJo7ExVqa/UGk3FWSO9q7UElyeY9/GR8d?=
 =?us-ascii?Q?qkQ1iUt4FZWQcyjNH5nualKDQwr6Dvu0hGq31c9usWoB3yu4ZqLeoifAESw/?=
 =?us-ascii?Q?jQBg0UeBDyd5epTBAebCyKI56Z3e9TEB7VM5Fld5gG6vCs7FbWfVfzYrVrwM?=
 =?us-ascii?Q?Q3HEWcVvsPtUFIajSCplQLrHSp7xB/IN3XrcIBChDC+hdr6C356h7L1TrDom?=
 =?us-ascii?Q?7RHOTrokECeu56vTSE7b4n2sWhN6SF7wIkne1Nq47b+uncpf3Z2LSN+krJNS?=
 =?us-ascii?Q?15crfih5HStJU+30qOCgym/GykvQr48U+HBNBXOF4KgzRq6QI5ElIl88/kRc?=
 =?us-ascii?Q?XhAQ0XzB3Z9ReAbUyRA+wbgcKccBBkDLz0WgUuofCBAYIhfbhgpoH6WKKLqU?=
 =?us-ascii?Q?VYBvDHFw4GEZ1p51OqrL6T59sdPW+j3NfS+kDn2t2D0RpHWEVtrOBkmOzaCf?=
 =?us-ascii?Q?AQzwdByXgMb2wwhLDtXCEZVftJkNSb1vHOAbV4BBjumPkqKps9hxNoVcyx3Q?=
 =?us-ascii?Q?r3P5P+3FpJem0IC/C15+8wvy3U9JNz6uR6DFhmIQSMrp0T8dou/K3hcTYrOn?=
 =?us-ascii?Q?MvI5GZL0sft6NBfVFsLYDq5RjHwxmkegkW4636lNUsrZPjSihuzjlfjfHnNl?=
 =?us-ascii?Q?xJ4r12RsirFq54QDOidvcORm3eZOnhvx++3T+4jh17KlCg0ZkbU9ucKvw5fl?=
 =?us-ascii?Q?89y+xNe7JpXKtcgPzWJUItOpE6WUenBazcAHknLf2o/taLXj83LKpNhqQD2z?=
 =?us-ascii?Q?lTmAQxFsyDVgMIugILg4rKGt7K3uEJ4C5TwVS5TvYTcHKMauItqsQaAwc5tE?=
 =?us-ascii?Q?+nh9syaKLDtvFclH7nbm1sXKARpPEC/8f6R8hyFdFV71AuVq3UK7JlbFThNw?=
 =?us-ascii?Q?UnQX739XubHErbcwSzXqL+rzomvcOWLrC0qwe8VoJFxhv0hFreTbytujOGGq?=
 =?us-ascii?Q?SexDCbRCF5z/pi0rndk52/bsX6HgKacF6v9bWSLbtfGdqMdlW6GGcKkqbYTY?=
 =?us-ascii?Q?M3f+AdxRwY8QO9sey7C9ho7UhW9UXIwmpp7vwLa4pqFxm2OnYdNSQNb8XQRU?=
 =?us-ascii?Q?s2zfvocl946Cryjgznm3HIBL5jiw+hdSDOB5MO0ccZlTbiZLy+BzWElX1M47?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HZXXelc+7c4/b1ezg6QjjV2lgsOfWJL6W+R0FjHZ4HqDBLuA6UPsbeT/B/C3NYqz1ym1nTb4SkH04uKdHkIGrT/7IMpwEczYlT/CRdd9aVWgCrOpj8bDHNxZ7Y0hs0/PB3RNKDn0/O+bgZDTkjh0VHLgD8Ky4B8I7CbqnHTo03lQ40ZMFkv6G1RNjBiNlKT6gOGi7ct6nD533Oqh1atNrHwHIq3l73MNj32FONdpnNE3cqiBC4Gr++yNalnHXUaKkbPHXk5LxIst0uICmw0CgSQoLMi7RjrPBSEsVN6CFz9tLbjptCR5bZLDbAqFsxs3IX00xnXDtoq0WMLOG+VZvr9jXdlFBea3QUFI1UaGURFYMsGt+Dhqdz6ZNj4s8OQD0Fq7mmVOpMIhHYuXe59euxEvl0IC2nZ2DiKV2kkqNPQNZPDKh2ccwWBHOPkb7JgmKuLh/2Jr+98cCudXfv5oM+jqYLx5JfgQqkueoouE9mBGrCN3ktWQuQbg5CeW/mGSkUYQRqIlA+dJuFsJ8LeFMK8726tcyFOvc73labHzbxxP+tekvoc6lsyRc9eyWtMaoF/nOI/35NLnru0BIkevZ20e46VsTetv33DApU50P885+NGlPAQaHIXDhPXBVsj2sM8bjF0ZQC6VNgPy+9pQDgirq/cyqCxnzTBXRnwHI66vclns3PlGSy7ukIN8i5fqvik0myf7Xn0cNpRf74uZUIjxtt98vdDJL+ErR3JWqloE7x7HmD0FeQIIO2YoW7sK3PWWVacntIcfv1Iy5G3exQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f9addb-c6f4-424e-2949-08db0b823943
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 16:16:53.8976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3mSFgS4Ug/rXXmjJK3FGLsRfzXyFdRV2HAOVVBs+d49xyMGJ63Clpe77Yxj7nSP2cYDvEqheH6HPsYUi6fpFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_11,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100136
X-Proofpoint-ORIG-GUID: XDCkAr2pizfXdBaPotGRqaFexVUEuEVN
X-Proofpoint-GUID: XDCkAr2pizfXdBaPotGRqaFexVUEuEVN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_lookup_bio_sums() and a contained if statement declares
%ret respectively as blk_status_t and int.

There is no need to store the return value of search_file_offset_in_bio()
into %ret in the if statement block, remove it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/file-item.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 41c77a100853..89e9415b8f06 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -494,12 +494,11 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 			if (inode->root->root_key.objectid ==
 			    BTRFS_DATA_RELOC_TREE_OBJECTID) {
 				u64 file_offset;
-				int ret;
 
-				ret = search_file_offset_in_bio(bio,
-						&inode->vfs_inode,
-						cur_disk_bytenr, &file_offset);
-				if (ret)
+				if (search_file_offset_in_bio(bio,
+							      &inode->vfs_inode,
+							      cur_disk_bytenr,
+							      &file_offset))
 					set_extent_bits(io_tree, file_offset,
 						file_offset + sectorsize - 1,
 						EXTENT_NODATASUM);
-- 
2.31.1

