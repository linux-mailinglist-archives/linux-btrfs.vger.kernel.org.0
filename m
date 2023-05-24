Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF58670F5E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 14:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjEXMEP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 08:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjEXMEN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 08:04:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEC3139
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 05:04:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OBxUUR029336
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=VKyUa4+RO5HozZeKCJR5f0vBGxykm8kHD0vrh3GfwW0=;
 b=K2y4rEBAAYrHzCg6MVcD5HYM9jrAqG053iqyjV6/2aw60z9oFRVR1HD0i7PEpD7NhK9Y
 3ajTxvxr2aX4ewoUMu17ij2XTeVKok78FaKYC9xJNT73OtzU1pFVoEZIvjuGWhMrH6rh
 moQNelj/lRKM+g5SMgg7WXke5VsyAcLZ5GfF/ocZUVMCyQODBMrhzCrABOcyhhJvFDTD
 XMFZFYgxi/Qru1baRa+O6QGRgxYcsi5sPtw/YNomC+X4CbFDSLm+3gNZ2ijxBZ0flcKj
 WbcO4Hbh/wE6sb0RdFP3a52ag/m42YYirN/AZ6SCrHFwfkzAQm8omyMPKZZwAkpuDV1m +w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsj27r0tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:04:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OC2Jsh028536
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:04:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2sd1bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcS06BbdjX7myee9oz8texbGnY1OvR03T83MEJHeu7LRWHYwSm8OyZGbhJlVUWDzCEV7RGvt2G6KE880Y9I3OpErQlXYSl/gSUlX9g59SReij1mnDlmJQ4Ul3i+cJN5QgB3qV1sqX7bLIGvJXRjce4E+1a5L9P/ghswoKLLrBsf/1i0fK6NdaA07Z7sHqs2qk5y53BM7b9J5/+ITkFUJ/AtLHXuY3jQYUndcBsJdCcK8YSgloEpRoR1kEzcJk37o+okoCx2/I0ABn7EUyam60oMifwBwF7qf/uQixe1gWhlsE71ss9TyEDXv3UNGJ6x1ehvAQUtAq9sFGCzKt/h4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKyUa4+RO5HozZeKCJR5f0vBGxykm8kHD0vrh3GfwW0=;
 b=Ebb8lLZ0d2d38dOBTADpL1H+Y4JyOIvkpvg08ROQwtQqSK/hliGO0fIR5ES5v1pn6kjxQ0dsQnxoMVRvbn3pLNhQD3qb6s7SzRdjydM11sSjD3/dlu5KOsgOpdt5FKp21WE6R0w996ZBBLKCh8HiW3Vtp+eKFpRLQ6zBLZ5dj/+quw7KkYUph+PLmhxLRcG56nd5mALXBW2sfhXwVDUPhL28gtXmbikYcac/yPZ38Pae2Hzg+WFjomsqsYj326rum7j4VLRcK8MgDvomIGTJUnYi0Ow/zRAwN0mcQ+8kBbPq1NQAoEWEKh7842ZXNH+WQIURiCRN0ipcHhHP2kTcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKyUa4+RO5HozZeKCJR5f0vBGxykm8kHD0vrh3GfwW0=;
 b=bedqvDCCv6cPrgZ1DMnuA2H6uoGh6ioICJJxgKvbbKRUbElOKHJ/QtN+JFJjE3eqR880mc5/v2JyGudeq6X8zstFj3GN6CuqTaDDIGKwY/1qKN0saZDHu3wuoEktOuxEHGc1DzlfpXqAsXVcH5G01X2uZvV/971ZGvYwMEO3B1w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6338.namprd10.prod.outlook.com (2603:10b6:510:1cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 24 May
 2023 12:04:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 12:04:08 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 9/9] btrfs: add and fix comments in btrfs_fs_devices
Date:   Wed, 24 May 2023 20:02:43 +0800
Message-Id: <54c6ec15f994a563cbe33ea75666bccf82ad3683.1684928629.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1684928629.git.anand.jain@oracle.com>
References: <cover.1684928629.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: e9af6292-8eff-437c-98e9-08db5c4efa4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjCyb+lnsWAeiLD+8gK6rKeEi2bQQBfbysgz39xibVHHPwJ04MRc3RSUBigbJnipXv2i9XyGaA/mTP1x6duxoebfvi64cLLTpRNWkRbFQpHNlPnGYC2UMAgI1B1Ex0o69jTwqK12Qb7B89qcFuDEfFSRCTiTZAWATQutd6jlquGfhYc0lqi1dHXLL4WwsWC0zaBBSPtxdo0DmlrhD3MO35nVzEwkaibANFrFr80N92rikyZf9MQSf037H1SHEqlEYgVlrWUT3JfollO5hEPk7nPjjxZGJIQPMJBmoJhjERQp0jRs1M+/ZVhWl0tTjSq1LDBzi1DEVWnz5esq/xIVImG5YYVcjBW4f9ie6EPtTLMfibHV9S6xFeSHBCTvThqkzwYjmN0yIDoBFpAeGsHBNDLunWHoK1xEnHwTvI/Nv3+Wlmrxk0zJbAi72t9WPRxPdbbdSWzf9Gpulrvr22SuUS3IMjNaCuxe5ez0J/VA6+2aAMLXgrtM8Fqhg4AO9IP9JQQwJwVo0J+kPsgOg8dzzjFWDRO8GuVJOze65+zs/lKAlOPHLqRYmY2YIXU7fz5h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(83380400001)(86362001)(478600001)(38100700002)(2616005)(186003)(66476007)(66946007)(6916009)(4326008)(66556008)(2906002)(26005)(316002)(6666004)(6512007)(6506007)(6486002)(44832011)(107886003)(41300700001)(8936002)(5660300002)(8676002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9b2v6Geulb6cJ7XBfHqNLVsMe+a2Ufj11DIpL9hSTVioUVwZAyGQBkZqAqHN?=
 =?us-ascii?Q?cXETGnLTN2GgP9a2IpWnVnchsbrXxkO+M33v1BF9LaIEGIVX6t7kqx92TVz1?=
 =?us-ascii?Q?1gO44XBzCMmAvuS3jz2S5byTPSbG/9zlQn9SMOfWYuTp2qgRuMo6uYF7ivEF?=
 =?us-ascii?Q?acBpQUDqnYbI2GgVyZ3V1grR+IUv/DhiqDfzLOmCpxBd62ET7ScMCT2QStVm?=
 =?us-ascii?Q?NkvJU9+tbSv0ATtbHuFzhhc8EXgjXKME//K5WU9ENN0WnXGy0Y4jJ6ySV5XV?=
 =?us-ascii?Q?uqQthUgMBiVAwMDfKqbvJmxjmNQbAYqcJ43PVNpcY0qV6rlIAyIL1oWosfmD?=
 =?us-ascii?Q?ePw7zTVp8AU086xvkU86AJ+n2udpbqgxxasDCysc7UxtPufu+Zc75+Ug7gJh?=
 =?us-ascii?Q?j7DY0iMZlR6qzTgGisBdjYrp9gARspP9HQsLGGfJ845Skqokv/I5zhDh6fDw?=
 =?us-ascii?Q?7gDqlu5JSUBGMp3p8iDyU/kNijvdWFNWWNnYSssvu8chojqOwxjUQGqAjTVV?=
 =?us-ascii?Q?sFg4dRxusbuWpRX4u0Ono5dVQGUAAHbukCaK2FgXCO3GX8Zfrw9dYndgpjI+?=
 =?us-ascii?Q?mbGDhELnzPUuUYxXJx2gvBs1swRvMS3bvOaMUenbCxyA9M3TN3xZoNHvOVjU?=
 =?us-ascii?Q?fjoRRZ0R6Mi108oUDmtWJ7bwp5DZmTVlOg7nem0mI+6hWU2pFvJjwz3Af0En?=
 =?us-ascii?Q?q2Owqy+NO4vqe0056uFb64lJ1Gef0IFom1fhbMUYaF+jQ55jO+fvj4EOB8Ml?=
 =?us-ascii?Q?eP8d1/WUJhEvb9qITuKh45nUQ5azAUlftJWoGyB99jL1KfQ84cftpXoop3IU?=
 =?us-ascii?Q?l++BOPn0ylRuf/ZkDzg6I2PKiLAwGGpyYbwAglOJrBFUwEO0o1MTYwW8lmhS?=
 =?us-ascii?Q?IWs+J4GG1E5PV51sNgYCdElR/vxXAeUqQ10JVoPA+gci0EN3d4CIPfm7Gk8O?=
 =?us-ascii?Q?ppPmZfk5xJhCq8wWr0T2PnMluBh+VrGRvwgnpA34YxqP5+0StPV3mnWXoWtY?=
 =?us-ascii?Q?ASCkVxAdWo9YDScU9M2AyTh3Ns51BizKVfZyFvFBA4TP7RCnBQVcZ8nBAXdN?=
 =?us-ascii?Q?txc144VRpj0D5X0E/6Ak/4p/gJz3errlJxDduReig7Ws6lh8bP2Pue+4KRSP?=
 =?us-ascii?Q?MUZyUAiFHlXnZ+/X9nqaB7TC0xojMgU+LdZKv8XxuPTyHcBADcs0jRVLFLRU?=
 =?us-ascii?Q?nsE1crVlczDsrh8L1SAnlY0Qs/P+FRntaumkb2BWw0nJrRQp6mKHb3OR1nL9?=
 =?us-ascii?Q?F5Zo/02QdsDttbhl5T9gkw7gCRcpb3TIf17FN8hSH5hpLbAALf0kmq+RhxF6?=
 =?us-ascii?Q?7bME2L9WBLsV7f9ioHCA8kAtGT4K6Cq1iXMZpJ+vYmYGGKEYvvLKBqPsGhYV?=
 =?us-ascii?Q?FzNlb+N5Jswiq0W0IPZ7wrsFgreQZVM/CYiBIiZTaZhy786jxf1hXXFZFmNJ?=
 =?us-ascii?Q?oNM8mpPvsA4LC69MwUKnF/ORRLFtovJYfekG6MVg3gVCzDuhbWjWg378TIKv?=
 =?us-ascii?Q?VdJ0+qS+B5jwneRCl4M7oJyvnmuQHx4O40p1IhFCpDO34FZzQvSCnp24PEKp?=
 =?us-ascii?Q?F501+9mK3NUhfXuvXy5H6iVnEM9nTIOpg/Y7TDSGkwbR+JDWODrUnfhxIaXD?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LspN7qrDkXPwqqo+4gccCzDNK2nTHBPW/7qymLRdRsVYnLniQVvviGccYhJbMpXkKkuy9PbggMzvSH0kyY79Fos3SrQAP1ucOX0mPhX/Oig+F1SthpZxG05pFwg/zQKvbq2pu82QyyaQStAynFZZgk3eBsfBu5ww7feVetLP3q7qo1HKo417ktRO5Ac0SPXEljb1BzI+xQOn65iPVhc3HENDpPN0tnpjGbwluYqkcf8DZMJtYEKf7f5drdFlcDnu7KvXN2e6iBWHrzUw1fQhdBLDpwRfTVd5C1qrljlDQD+xbNp5qhX9jPzZ+Av7g9K3/g3z4uf+Sc40RO+E5IUt8rm/QyDXNM7pLf1JgxN4c6fmqT/dxyyETv5P6zXiTGmG8TvhLFax+QqnE/Q9g79YQ/TKLkMR42HNXkB1GZynjibEXaZQwmVmMPGN4wLiuXo9i8Nv9O0gqib2u2t4Jcs4n0mtgOTtJcNIOhKJwTWZfyTl+qVaaMq96d9alVuF48F1ciceww9ZWWtrP9xPn72XZXB2tjFCG1XbC0D+NSnhDFWCvBsaRNUU3ho/G7SCT91ovrHIzUm7KCPagnZgHA6AcEs+Yn35kXHYUCtI+PXiwIwsFA/dLqWY0tIbn0pobrZgBc6StM3vpGwYA6/XpZ52xYWa1yGCxc7Z7fioju/uH5B9DeSs3lhPNrNWFGxcJzQryRG4AOQeaqbt3cffNII9Sykp+iOkcNGQsEIFnYOr5KDg+/waY+fusorGJIj0hVfl5KwbTpWqttxtsS52e9IpWw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9af6292-8eff-437c-98e9-08db5c4efa4f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:04:08.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YFG5OQNzkTETj/VV8qlyuCgbGJwehbH1lXQz9Qv0in5R1lL3oXffjEZ+sa4wviN/M5heyCdM6PEqE1Px/piKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_07,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240101
X-Proofpoint-GUID: 6yABuLDhr3bLQ5CdrQxOsykgpjfkUIM3
X-Proofpoint-ORIG-GUID: 6yABuLDhr3bLQ5CdrQxOsykgpjfkUIM3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(No functional changes.)

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: New patch. Part of this is from v1:patch1.

 fs/btrfs/volumes.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 56633d4f9b31..f64d480aed0f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -328,11 +328,11 @@ struct btrfs_fs_devices {
 	 */
 	struct btrfs_device *latest_dev;
 
-	/* all of the devices in the FS, protected by a mutex
-	 * so we can safely walk it to write out the supers without
-	 * worrying about add/remove by the multi-device code.
-	 * Scrubbing super can kick off supers writing by holding
-	 * this mutex lock.
+	/*
+	 * All of the devices in the FS, protected by a mutex so we can safely
+	 * walk it to write out the supers without worrying about add/remove by
+	 * the multi-device code. Scrubbing super can kick off supers writing by
+	 * holding this mutex lock.
 	 */
 	struct mutex device_list_mutex;
 
@@ -341,21 +341,24 @@ struct btrfs_fs_devices {
 
 	/*
 	 * Devices which can satisfy space allocation. Protected by
-	 * chunk_mutex
+	 * chunk_mutex.
 	 */
 	struct list_head alloc_list;
 
 	struct list_head seed_list;
 
+	/* Count fs-devices opened. */
 	int opened;
 
-	/* set when we find or add a device that doesn't have the
-	 * nonrot flag set
+	/*
+	 * Set when we find or add a device that doesn't have the nonrot flag
+	 * set.
 	 */
 	bool rotating;
-	/* Devices support TRIM/discard commands */
+	/* Devices support TRIM/discard commands. */
 	bool discardable;
 	bool fsid_change;
+	/* fsid is a seed filesystem. */
 	bool seeding;
 
 	struct btrfs_fs_info *fs_info;
@@ -367,7 +370,7 @@ struct btrfs_fs_devices {
 
 	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
 
-	/* Policy used to read the mirrored stripes */
+	/* Policy used to read the mirrored stripes. */
 	enum btrfs_read_policy read_policy;
 };
 
-- 
2.38.1

