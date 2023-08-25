Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEADB788BF1
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343862AbjHYOtV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343860AbjHYOtD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 10:49:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DBB2119
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 07:49:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDO0xY009064;
        Fri, 25 Aug 2023 14:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=EoYcCiqUlV3ZLzN20nFr1aKGslr41ghOuf8WpdwJv8A=;
 b=x9ZCPKEyxVRatsRHIuO1V1nBGKbnZ9u7J16cFKISQKXrM4CIad5mf17P8CKCFbIkCaFR
 DmE8b97dwqSVqB5DH0/biVEFVSO1+nx3ZyVv6yl6hJO23aEFyv7ybuNEaFZVVv3xUsLK
 pn90SK/F9fR8/HOdIRszbogMarXpIAPEYBgAe/1rCvkpB8yptjJLywty0+PP6lNFs1jp
 6bC1oQ8OEGTMfPW/ci2R3ALu4/J6x6cs5ltm3pbT5cqhfnu2o2n5BA67vzh9TjgzQ+nh
 x1z/GApIHtclXx93bxhnc96g99RHWSmXo++LbeSjEFEssqjacbykPzomRpnBTygBYT2Z 5Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1ytxgsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:48:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PElcgV035966;
        Fri, 25 Aug 2023 14:48:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yqx189-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:48:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxMBIDKmehkX3ODY4I0tfVY7hqCoDBOKvMvqpdOnzLcOKz31R1B/KR6GRocK0aS4t8i8EQrkFBkg+JUflw2P1WFfXCpIfMH89KEY80JLeCO35LBvJvwBZZ5tiNkmjG9GRQcpjMp6pHeXEamqRdIaRLaE3gAf2/8P/9wlzgyztozzmVnnqMV8uxIzeLJxuvw1f6qIM6DCWt9ZymgilvqJmy62S9EoX4Y/bL/Ue4ErQTJhQrLjc1SsTQgpjOiQxao+Z0PMCPxOzKisV2I5e7pq3/0t59x3h10pct22FL3XGCEL92ZF6jGaAf3TVHU19HTgBg3I2XMqEPhl7VVnOeSn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoYcCiqUlV3ZLzN20nFr1aKGslr41ghOuf8WpdwJv8A=;
 b=NVTSaG3fy8RBZTFYdYxlCUdbLlh6w91NQwwtBRiJK0dyxcKd76Jfo5MZ0L0Zv4OW0QbfOMkzAeuxHfE00FUkoNu3Xm0+2HTXlQ5EhAH/9BWLQ0Dc2Pz4ZA0Ir3PNPEpAwjbpkT9ylx13JsCpR+1zR1SXo0FgLc47fMFF7Rk5E41Bj9l2kLRUSRwFolbtZ6JUHfzxV7G6sQbvB3QsMStaWlkwCwgwHjvLy8MvySw19AH89fO+V1gq6E+oZABSBNT2NnL7a4mmQvdyBcqfDbj7duqGLaTAWOK0XeXm5tnASpGx+5Uchvnf9UFxUQq3pI64UjpmVu9ff04TxcXthbHquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoYcCiqUlV3ZLzN20nFr1aKGslr41ghOuf8WpdwJv8A=;
 b=a+hNtLZDhjMZZsjnvP29jt0N+Opifc1Rxaf9bLacZM4mUdwLWPeW9WBaZGIgQjOZfn9M0KOPKi4yAXrqxnr37BnTp8Htd3Lo5TBO+HxFNp+TOfu8rso1TGw3Md/gDNbnnW3j6Okg2hiJ7NoCV694G8AXQFzgVLtBfFwID6vRgqE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6326.namprd10.prod.outlook.com (2603:10b6:a03:44c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 14:48:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 14:48:30 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 4/5] btrfs-progs: recover from the failed btrfstune -m|M
Date:   Fri, 25 Aug 2023 22:47:50 +0800
Message-Id: <2f5d995aeab0df884b2f8fb3dd57d7011bb5b50c.1692963810.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1692963810.git.anand.jain@oracle.com>
References: <cover.1692963810.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb02892-875d-4538-2188-08dba57a5946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRlw5O3CQSHF2imEp3QPZUOCJ+RmidQAzKTUoeKpcSdnJxW0gxpS5MyLAjFCO+0VZjwgWgTXETlbMN0UG3oWsioTde5l3esPRInP5glgdePvq9B8dJH6z5iEEDK+y3qcuu0lSNWfYSy+bHThw1lNrv0zaz+8siCKcmIekUrRo7pfuoFRoF3Y7fja12Akevc9KMllTZlK/PG4QnQ2UljW8fN3jyMYLhz0Ex93wmgE40braOFEXbX9F1uyW2eB03510zoPTS6w5doAfs6D+qnd2BlqNN5MKCNhy/Z7zVcibeeZxmyTI3q7HiQdpBXMkwIpUDvvva6t6/T5ItUc6Ul7aoN9bcwiWrh5iqeSvPZFEmyJsCy+DmLImSAJve62CtIdDRXAcRCwIluTTK3gyJ7Ls6AdCl9JIHcRx6XrC26uODk7xCJ3S/OEod7KBPbuQ3sSO8xCWcrRycVDOrIbMTILNiZpDP5odEM6IQzPBKbrH4Xxr7DlvhNWT+xhENxDXA/bXj1VAAMyyHLc6cZokx0Vq9151FrBSOWbzM1QI+dJfGZNxULOVyIroZiWQtcA7KuK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(346002)(136003)(1800799009)(186009)(451199024)(6486002)(6506007)(6666004)(44832011)(36756003)(38100700002)(86362001)(2616005)(83380400001)(2906002)(26005)(6512007)(66556008)(8676002)(66476007)(66946007)(5660300002)(4326008)(8936002)(316002)(41300700001)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ILE3IsaQXjlEdTJrU2KlM/rLuYt1G6dFvWUMxOXih4esd8RSPAcUAiST0j81?=
 =?us-ascii?Q?rDQOQ3RMWn9OiC3spuGgug0DjQlfD4IWqGZcdlv0X+5lEhHbVDZU0ZBp7Y2x?=
 =?us-ascii?Q?/jNxg/6AwgTgwLxPgJIRtYEFQb1YybiuCJfwQqzsFGpTYjyFVayxpSOyiV/5?=
 =?us-ascii?Q?BxsVenQNpZWPjNFN8Nd4pzTXX/UkKE86t05nZkhhkYO5vshJUwYTydK8Swzg?=
 =?us-ascii?Q?NuZmhY5tAwmgm6u08PwRFhswadiquIxWXs11hAkWA61Cqe5ftcL8RjitkM+s?=
 =?us-ascii?Q?PUp/G5i2xU3E4a6AD2mlzwjOP8wvCB5Smvv4+sjgUYzE/GoNRoTv6FNsLzma?=
 =?us-ascii?Q?bRT2ml9YD30IjLmlADsE3OsKv5WCPVu3pn1P+AsZVpt4cb1f3dKeqHWtEYlq?=
 =?us-ascii?Q?QQ8LmAIjwSNJMzakmeLZNkccWco62DpfbGpr4fjqVa8k25FniiAcCXT0Jmmr?=
 =?us-ascii?Q?/UlIULB2BuYQXD/5dwIUML2XFAA4/83jg/Rem/vEFXTPjZF3FEQPdSoahIEq?=
 =?us-ascii?Q?xbtAAZT0jmhTdevZ/ZADitYPBo3Nj2OspB8OOuAvupoXEvL2doQkHCchyp4J?=
 =?us-ascii?Q?syt0SNazvK7IHUA8MGStLdAIyHQThrVzqQUfYFTuR2AXoiNv1i1Vm4A9NfNV?=
 =?us-ascii?Q?6maRpMIIBa/V/S3d5PQZ5PWQz0uqJWluB1zl2zudRSK4FGosPIHM7GyQTfho?=
 =?us-ascii?Q?HNK2BoYkR7nx9padHgDqMEoaf9ZjSSHwaj+G6EXd5AeKVNApWIom/De57o/s?=
 =?us-ascii?Q?Dv23hapR/U9LuliLSN03h7bIKJnjqIaSw4sbevLZ63LpBvQ0+x51vw2RyP80?=
 =?us-ascii?Q?8skpocW9rkSaBinLBPxbEY36wMIG9XrVN6y9HRuTXUjDhmjLqx2ZNrS1KD1z?=
 =?us-ascii?Q?Ty8HSM83jJ/OLW0xY1bvuZykLxdXACZa1Igr5PDJVFhhuhmoRPlr/wJIk17C?=
 =?us-ascii?Q?u/+F8JR2ktQfSoZfltq+YB9gGvqZ8qKykSQLolsagTe7YvY/6NUhw5U/ik1r?=
 =?us-ascii?Q?4iofWo/Cew6z3x2b11vBoyYG3pu2o5D6OBhZxA957BBukhh8Gb51lVizMkzp?=
 =?us-ascii?Q?Nk0Cm8RgAAAmXX79gwmZ5Co9B0w1xH/DIX7U65DWbP5G0DQiF3+9yCyxWfuy?=
 =?us-ascii?Q?7rqp4DKKaIbO3H4/Iv5ml7pG6GsmvVJByxmLQM8sNN4eD4SCcFH584y40osc?=
 =?us-ascii?Q?n823ZGs4oocuUMPqy8nJvmbZyI4xn3IfuL5oyfBtDHXdepb51bqNZJLX/1KC?=
 =?us-ascii?Q?t6/dTsbXVsBAIY4d4fYzhHLvdDk1JbSvGPxlSiOvyznPL1p16SS+n01l+O7T?=
 =?us-ascii?Q?WrKc//E5k4IqXdfOsBfxw4zExp1NNsDupLw5CnkmHld7xH3j1BolTSexWGPn?=
 =?us-ascii?Q?7EIO2WxaURaCh2PfT0gvp9nqba69vnsUpNKufpIZhQ2Hn5JfWCRcR5BvKbDF?=
 =?us-ascii?Q?zmEKjvGpv5JqFrN+sWiiBCEIzjMYkNcip9T9QIUd6kDHZ2w7tSQgJ2eFoUfP?=
 =?us-ascii?Q?csQ2+CiT4HZA7xJAF0U54CGnqAoJkmC0YTSe0azZBKP+jckb4KIuar2JZu0W?=
 =?us-ascii?Q?7fyAiT6UV1mNakmbSpo84HCXnt3hxIVDt6OgYjADAIDot9P2EKbRlpkdeU/u?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uPmd0XeS9Lf6tPP6k7L/k1RcsI6v30u3pceOrwHJKdns67cNK6sm5xyQf2SgeZXsWUjwY8ZW6HWD/zi6cQNteOIx7Acci1BnZva2006czuJRnomEixz2uk3CH4x11ln0jcyx0DwWsYeSfeBOZ/UCPB122a+uNdgGZ4JXOsSMyKX8rsj5MGPnm8Fu8Szfe5LqXbKecrveKrKndiFwCaWBRWp2/huK8XEhnPQPACkP1CAy6jK33oeN/7FYZxfUCOT+w0BNMOxjDNdmPJ5s4ABFO3eeIE9T7Y+ftu23OAzCAYzT67PmmluTsLYBVS/VwSVB11JqbSkChqJWLTpa8ODoR6EdP5RXrgOWZzzBIhB4hEM0tcVFQCmZyvPkcrfbCtTl6qvPWF8QfsOsXUpN9jJJWHq6YULylgJs9MjIbwYQar1Kd9klSPloT4Jd2pzXYP20Y+EDPue0Mv63Pi05YFuspGOqgtygKry1VSlhO24110oCSgcDjlynyBZMCIoFSH7VBRLl9CgaKP2JJEkdlJ/BT2+1i3YEqRzeUrQNxc8DeUZLwzY4VJy19AAeGtyksDktBVkjgycHK52ym/408wWufl1u+LFuYyEZzhh0KZzg2p8QS34nRj3Gial6GvZfDhvH1tXivtt58yXqI68zUKpA7jLL1z30zLBn+YguIqzlCcbyv2gi1tR2sjLQVyOgtibXYtHTCFBIs8kGSnk1mOnKAnwra6MkyGAaGj6+XTDPFssHXVDqi5LM3XO2mGus/3GvRk0YhauIvew4S+A7PxhFjKgW8gY4LBqkvAy8tGyI/18=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb02892-875d-4538-2188-08dba57a5946
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 14:48:30.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMqccq/AJIWVzUxIF/R4bSEuw6Pg6J3pI9rQvpvgU50wvpMH/051yaJae3oetk4ZFR9wCZmtIh2Kcv6vKE9Ejw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250132
X-Proofpoint-ORIG-GUID: C-_DP35YL-Rd1dacW7AXfAbYBWysIAZQ
X-Proofpoint-GUID: C-_DP35YL-Rd1dacW7AXfAbYBWysIAZQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, to fix device following the write failure of one or more devices
during btrfstune -m|M, we rely on the kernel's ability to reassemble devices,
even when they possess distinct fsids.

Kernel hinges combinations of metadata_uuid and generation number, with
additional cues taken from the fsid and the BTRFS_SUPER_FLAG_CHANGING_FSID_V2
flag. This patch adds this logic to btrfs-progs.

In complex scenarios (such as multiple fsids with the same metadata_uuid and
matching generation), user intervention becomes necessary to resolve the
situations which btrfs-prog can do better.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/change-metadata-uuid.c | 48 ++++++++++++++++++++++++++++++-------
 tune/change-uuid.c          |  4 ++--
 tune/tune.h                 |  2 --
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
index ada3149ad549..642977c3747b 100644
--- a/tune/change-metadata-uuid.c
+++ b/tune/change-metadata-uuid.c
@@ -21,9 +21,31 @@
 #include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/volumes.h"
 #include "common/messages.h"
 #include "tune/tune.h"
 
+/*
+ * Return 0 for no unfinished metadata_uuid change.
+ * Return >0 for unfinished metadata_uuid change, and restore unfinished
+ * fsid/metadata_uuid into fsid_ret/metadata_uuid_ret.
+ */
+static int check_unfinished_metadata_uuid(struct btrfs_fs_info *fs_info,
+					  uuid_t fsid_ret,
+					  uuid_t metadata_uuid_ret)
+{
+	struct btrfs_root *tree_root = fs_info->tree_root;
+
+	if (fs_info->fs_devices->inconsistent_super) {
+		memcpy(fsid_ret, fs_info->super_copy->fsid, BTRFS_FSID_SIZE);
+		read_extent_buffer(tree_root->node, metadata_uuid_ret,
+				btrfs_header_chunk_tree_uuid(tree_root->node),
+				BTRFS_UUID_SIZE);
+		return 1;
+	}
+	return 0;
+}
+
 int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 {
 	struct btrfs_super_block *disk_super;
@@ -45,15 +67,25 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 		return 1;
 	}
 
-	if (check_unfinished_fsid_change(root->fs_info, fsid, metadata_uuid)) {
-		error("UUID rewrite in progress, cannot change metadata_uuid");
-		return 1;
-	}
+	if (check_unfinished_metadata_uuid(root->fs_info, fsid,
+					   metadata_uuid)) {
+		if (new_fsid_string) {
+			uuid_t tmp;
 
-	if (new_fsid_string)
-		uuid_parse(new_fsid_string, fsid);
-	else
-		uuid_generate(fsid);
+			uuid_parse(new_fsid_string, tmp);
+			if (memcmp(tmp, fsid, BTRFS_FSID_SIZE)) {
+				error(
+		"new fsid %s is not the same with unfinished fsid change",
+				      new_fsid_string);
+				return -EINVAL;
+			}
+		}
+	} else {
+		if (new_fsid_string)
+			uuid_parse(new_fsid_string, fsid);
+		else
+			uuid_generate(fsid);
+	}
 
 	new_fsid = (memcmp(fsid, disk_super->fsid, BTRFS_FSID_SIZE) != 0);
 
diff --git a/tune/change-uuid.c b/tune/change-uuid.c
index 30cfb145459f..e81b7980bb69 100644
--- a/tune/change-uuid.c
+++ b/tune/change-uuid.c
@@ -210,8 +210,8 @@ static int change_fsid_done(struct btrfs_fs_info *fs_info)
  * Return >0 for unfinished fsid change, and restore unfinished fsid/
  * chunk_tree_id into fsid_ret/chunk_id_ret.
  */
-int check_unfinished_fsid_change(struct btrfs_fs_info *fs_info,
-				 uuid_t fsid_ret, uuid_t chunk_id_ret)
+static int check_unfinished_fsid_change(struct btrfs_fs_info *fs_info,
+					uuid_t fsid_ret, uuid_t chunk_id_ret)
 {
 	struct btrfs_root *tree_root = fs_info->tree_root;
 
diff --git a/tune/tune.h b/tune/tune.h
index 0ef249d89eee..e84cc336846c 100644
--- a/tune/tune.h
+++ b/tune/tune.h
@@ -24,8 +24,6 @@ struct btrfs_fs_info;
 
 int update_seeding_flag(struct btrfs_root *root, const char *device, int set_flag, int force);
 
-int check_unfinished_fsid_change(struct btrfs_fs_info *fs_info,
-				 uuid_t fsid_ret, uuid_t chunk_id_ret);
 int change_uuid(struct btrfs_fs_info *fs_info, const char *new_fsid_str);
 int set_metadata_uuid(struct btrfs_root *root, const char *uuid_string);
 
-- 
2.31.1

