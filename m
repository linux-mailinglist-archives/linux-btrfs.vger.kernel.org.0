Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F08788BEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 16:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343858AbjHYOss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343848AbjHYOsb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 10:48:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8152123
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 07:48:29 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDOHIJ030481;
        Fri, 25 Aug 2023 14:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=4wUIV4mEMnhH2Mye/ZvprXSdUUpvU5ZgPKBakei0dOo=;
 b=jRl27paGkobnXLUBSFQxCYJB4hChN+E2x42zz2o+fjHEIN9h2pUV0mFtufI3hOORD4/a
 144Pdx9yyBL09PSXUXF3ZHAJnm94s9u0XRBDEbygPeGZbfVMcTmZ6GJKM01hNkI/jN7f
 WhOSRk0/wJqxHo+xcUTSJVjxyjMYrx6b45BncIbthb3HLcsqEwwz/chh3vMINSYKPZp5
 9+qZi1LK6VmR/du7GnvA0KlCM4Hb79pxVqmKXYfs9nWrcFZH/z/RyUE5GtiREhfkxNA3
 qPaaX10g13dVhgb161CMcpbkiCM1NqmpgJBjH9lB+FfR3OvzWgOZqJ2HCFEz4jvJkASP nA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20defvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:48:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PEP5gv000914;
        Fri, 25 Aug 2023 14:48:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yux3n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYUJpWI/izz+xLvHWpGW6Y9Uke0JZTkU78BfVbK0gwvExK9jUalRVadzTpBT+DYDC9WwV4lqJ6EDN17yaYgZqhODJUr00dUbjbHhSu2GAh04xLZMk/pEImQQ9T9D4vsqgYkwXHh5q7ZkVrIuPMWnlz3kh1ai/J7Q62U9TLAdl45jmFddDvuLm098UM/L0EPdQrRA6O6wjfGh69innVyKPO8JvP8DBH0kkDI/6X8oKQz8OfQ3idTv5yuFfVVxhLDLyDXdD/O3VYSOX8ZJ9fSPpqBKQQr3woZ4JF1ozWR9S3QlobCKbmVIODWXI/WY0iDw1z+bMJoODOxUi8Hv/OjYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wUIV4mEMnhH2Mye/ZvprXSdUUpvU5ZgPKBakei0dOo=;
 b=T3yLlz6EeCHjyuk70QMbeh3NCKeJ2K1P9i6MrEWtxUxbGu1lXGPYUaDSJrOTbMDI8gILRaLju6y6hNacHBZ0k+bhucAPU3vsy6AgUvnw5Iq3dkkPHrRc7nhkpRDOhRDX6cOr5eMXD+UrItiQks+vhLxXZ+d7OjEYF6ge4zZ/Gp1ox3XmjTV4S1QP6LgQIo4U2vafunvVVZ33RAYvHyu0W4SsuuiDMbPgPiclwcVRpC/PnaKs+QWPtzP92JhAo4C8AU9J2ThFMo2QZ93U2nIQO9KdoDUSdbZ1pf0q0xSJuFb3hg50CoZl6Fb0tj3eTIVQBSMfVYeJnwNTM6ozRoUBNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wUIV4mEMnhH2Mye/ZvprXSdUUpvU5ZgPKBakei0dOo=;
 b=Bs0H3YKNcnJQ8VPLx7ULDHVI8i35+0OJxvGP9mtX68xsxh/vpPy7irMJg+IwSINwxo/rusDV9RPnb/exQV8UFjOSWJJ1KUM7lTixNo1RWR3PvaK9RcQdRkzMvfgEhc4+cc58FwDs1O4LMk3xjSIT59tfvpQ2I1uripzue0qdqMs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 14:48:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 14:48:22 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 3/5] btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
Date:   Fri, 25 Aug 2023 22:47:49 +0800
Message-Id: <0032cada2f51721640cc98dc91aeeb3d1e0646fd.1692963810.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1692963810.git.anand.jain@oracle.com>
References: <cover.1692963810.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 510128ca-17c0-447a-8706-08dba57a545b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQxep0a7mwuivK/TNnDnB6vD+E+2ezKzWzDUtlHFYHigpKcKcx2RUTeE53ZIlcN1wLnRekIUYQQAZJZZPVddUxUYWgH9ZvM6iBp4jiHwI+AaZdHQrSZ6X+fQW9RCtxR+GWk4S2uREh9cKLZZj/xhauD9TiffSTUm2tyXAfuIphD0mn0uxHDOM7S60y3NLBydQMeUW1F0TyeeaZwTvKPeQlv1iLq+qB4ZLdZhiDwEuJrQPpU3SG/U3NB8vVaclJOep9KAKIyYnpHghX6OMVucn/hV2UMAUqcPNFYBCucf3L5wq0CYf3inoK7i8z5ke0MLygWfAVvlLM1/FQ2Pom4JqdfzB/TLs+GpGXZnpmLLohHEJi81msEDtEzFtOulVDUIsWSZP4S1C8lo+K5+/rvLj3ySMviSf4Zmo54X9H5FOsBD7kXgvRYs7yiVLaaupnGQpE0zifah5GkMzB1VFtz7F3uOwEtraXiyl4iLAcYqEzi1LoCLn5zisjypqBI+5G7tfrHkWbgmCoeY10ORO/spj9ROs7LkjS8aQNtrswAtJY2yETNx2beV3hKbL7CAKKgG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39860400002)(376002)(1800799009)(451199024)(186009)(44832011)(83380400001)(6512007)(478600001)(26005)(2616005)(5660300002)(2906002)(8676002)(8936002)(4326008)(38100700002)(66556008)(66946007)(66476007)(6916009)(86362001)(41300700001)(6486002)(36756003)(6666004)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MJQCCxnM2tED3pVp9Oyi/Zy628paLzWmW7aTy9Oaj7CyzhmaLMJlRUpB4nmi?=
 =?us-ascii?Q?MxPQp4UxnXWBgkrj1sRtOGFl9UeqmUM0GcRB46oOh/FpY4m2jkRA6QNi2OkM?=
 =?us-ascii?Q?jVlnlvOgNzyVZ7xTtpGzjoB76UQcnecv6bRFpPZVC0YFr7GIMC7BKkLkvuOL?=
 =?us-ascii?Q?Zrjma0Ujfh3P6HOQySgF/1kLGa8tEWEk4xptgd3/N+mvOmGL2YEK/CY12Rzc?=
 =?us-ascii?Q?bk/0sa2tG1JbL3AFUBrs/FAp1M3ryCGPC0Qulz6tZbKyWUJeC/2B/DiWvXxk?=
 =?us-ascii?Q?1bXihLMmTXcqPXAQxkKlDxS5V/V1vHPZVDBAR+DZpUA2e/UzKyr7FiWGSvpL?=
 =?us-ascii?Q?KQ1auPVsD+vUO7SUcbSHNlpTvQEXeTxkbfIRMlB9KTT8bTDg47YS6BQIAsk5?=
 =?us-ascii?Q?IDQ5McOaeI8y+HcTyAkhvPz26AcQpIiFxzx3cpxvhsbq2kq9xcWtiC4x8ym6?=
 =?us-ascii?Q?eyysVDLb7qMNbbMaf5E/1jgDsXsD5rmdBGHi8QF7rEC9t1lvE4syFKwWsi0x?=
 =?us-ascii?Q?3ZPsiGFPyuvgS5FB4WQ9xQ1lEldhBHbnehc4rPP5ZCkVwGGuJMvZ385vanQF?=
 =?us-ascii?Q?BnLV1aeTy5l/u2niWFK3xQOQ1dexgWn4L58Sbnjhfhx+jb1nru/iGEboQw95?=
 =?us-ascii?Q?6baLVEfzcYSrB0f02vBcrgidH0G5lrwMXKr5nEDtOBTW0rSg+axGi+lwiBbE?=
 =?us-ascii?Q?ng34HRqLas9ieQ8QwqaErhVCIv+NOpNmgSiMmUi/gv+tnQqZGhkpVPsogAjJ?=
 =?us-ascii?Q?qGMPwlf18x5aXxdbU9rcaPR7zrzyYG8YYFq1rghRaVG9H/trRVJQpOgwRr7D?=
 =?us-ascii?Q?08XevimXikTAlG9myF+84oqcgelHue301oPHtvsmeRRmXVcSr0Dz3m5gcDk2?=
 =?us-ascii?Q?Jot+zvQxxLBXPfWO6/av1OR9mkXfQQBnITbmYXK8eYxK2JGcz8rED/PRoVzK?=
 =?us-ascii?Q?6Z5WrtLcoklpdjlQAr/dBYRlCpQYEUvNgbrgIb8IIIhGi6bh0vIg5Ksu64/H?=
 =?us-ascii?Q?N6o8gjquu3vrjJwtD8S11s9r6uhRpXqNU7a+C/hC/CesuLxX1DQp0psjh61e?=
 =?us-ascii?Q?oC6bbMpz1eTR5K2zT01eTMW2CN8P9G3/c3MtXSqJ74z4rW9n+KiBS0KpXcgy?=
 =?us-ascii?Q?sBncRrcz+GxU5grBdhQEHlS4U5oe6dU6u72U7J9EgM7/rS385vWXndbNMjZu?=
 =?us-ascii?Q?0qR8MkxSm78z4kWF/vybQH/x7Zyan7AxViYHhOf2aDVsbylsMkzbbHtil+rf?=
 =?us-ascii?Q?9upWB2NSXfEliGEqhgOq0UUMGGeaBCXTATFYLwJSj7ZrSvf77IFMYNCBNHEh?=
 =?us-ascii?Q?r0tX1Jqztv5dnVm+KqQkXnFgMAcX18Lt6OmGAmne0c8qalRupTug2luh3D0H?=
 =?us-ascii?Q?8AnWqhmNngG9BY+Q+2KEs6utckzLPbhJ2hxEiS3gb5W0P01REdfiwn4W1eNb?=
 =?us-ascii?Q?+rDXNjY1/Aq/m2rvR9GjFKoyhEbmPttVeh0B66w+/jlqov/2innnBG5Ss+sr?=
 =?us-ascii?Q?4XKDwI0aJvWUEbFALQZOllM83+956YDHW/iL0U/hs4DcbAkywjD6c9qKLpfZ?=
 =?us-ascii?Q?Aa6Cqn1q/KCvGOkIrKhh4rIJ2nEohqpTdjvuulP7IPH+88L6SNjWSuO6E/v6?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7IJIUOlJ0HtsTge8IU8h/Gpiy3wbe7cjVYKHvcm/VGHr19K+sF+gOHTiRaJA6LdYoCU2/h9UP3jI5ACZii2rVlQ6Ga4+Q2bhpefwN8u2O7KOjCKoKhj4u5jO5MrUlQOBl2thFOsevJthdJTfXHVpuf15LrPXFxwQr//fWFdmEaj98aGq4ExQlpt9fZQkyCbjbUVodR8ehBVq6WE2njphq84lnzSJzNZjk/MD4tGAI0hlwHnuMmBrxBMnPeeLhm56OSDth2JJCOOcZKW/C3VW1eEGKmNWxxdA5nZtGVcM22YoI9C8NVQro0//V0zcG2r9T5JaoLK5F62N6Enyaj9uCumfS4RMF0mRxdwz687UGE3b5jRcd8Rweez54KWIqP5rXDh1lfL/MVyaouVh9RDRtZAQAVp11gCxn0SN4y17wDrzFIhj0jOoTIekbC4Teiydr07qdnxBRTj6epDx0T5OyAjEEDqHZB8EiUAJpsuUkouK/WlbnCYSiVa+lEPGII0wULtbWgARU8irXkIl0psBVcR54WcvTm7D7uAxU4A8ItggOP+WJiYMbulb/jgcfhYtF/Jprn+ymhmUqDusnnyIpRVKDLBHl5ptm1m4/TAGjTQf4zOdzWhjyT8q1mkcJX3u+OOVVnhEwzbIZ6qMeXwcQatgbesKPgsni12bkMFc1VEGZFnczR2vRj+xVnxBqLR7XOKxzY1pErpsm6ItaM6MM9+nqoctYy6Z0zmKM7rO/5RGGwfr5xmndGo6lDg6G0sskxs9/uAIWnMUDvD+9gRftuxEgwinG4mv+kQ9gs0KfPo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510128ca-17c0-447a-8706-08dba57a545b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 14:48:22.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBtnuIN+jGJzU+jljTl1ERWtFPJG1DgExvpuIC9nugsiG4p2MkHoDDJ/YUgw1RZU/9eTCXDucf2rnGQfBeWIKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250131
X-Proofpoint-GUID: Y7uE_3iBbpk9USlG6e7wLpeu6fKT8BPh
X-Proofpoint-ORIG-GUID: Y7uE_3iBbpk9USlG6e7wLpeu6fKT8BPh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Most of the code and functions in this patch is copied from the kernel.
Now, with this patch applied, there is no need to mount the device to
complete the incomplete 'btrfstune -m|M' command (CHANING_FSID_V2 flag).
Instead, the same command could be run, which will successfully complete
the operation.

Currently, the 'tests/misc-tests/034-metadata-uuid' tests the kernel using
four sets of disk images with CHANING_FSID_V2. Now, this test case has been
updated (as in the next patch) to test the the progs part.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 193 +++++++++++++++++++++++++++++++++++++---
 kernel-shared/volumes.h |   1 +
 2 files changed, 182 insertions(+), 12 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index ad006b9de315..e1426a526f6b 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -332,6 +332,159 @@ static struct btrfs_fs_devices *find_fsid(u8 *fsid, u8 *metadata_uuid)
 	return NULL;
 }
 
+static u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
+{
+	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
+				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+
+	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
+}
+
+static bool match_fsid_fs_devices(const struct btrfs_fs_devices *fs_devices,
+				  const u8 *fsid, const u8 *metadata_fsid)
+{
+	if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) != 0)
+		return false;
+
+	if (!metadata_fsid)
+		return true;
+
+	if (memcmp(metadata_fsid, fs_devices->metadata_uuid, BTRFS_FSID_SIZE) != 0)
+		return false;
+
+	return true;
+}
+
+/*
+ * First check if the metadata_uuid is different from the fsid in the given
+ * fs_devices. Then check if the given fsid is the same as the metadata_uuid
+ * in the fs_devices. If it is, return true; otherwise, return false.
+ */
+static inline bool check_fsid_changed(const struct btrfs_fs_devices *fs_devices,
+				      const u8 *fsid)
+{
+	return memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
+		      BTRFS_FSID_SIZE) != 0 &&
+	       memcmp(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE) == 0;
+}
+
+static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
+				struct btrfs_super_block *disk_super)
+{
+
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handle scanned device having completed its fsid change but
+	 * belonging to a fs_devices that was created by first scanning
+	 * a device which didn't have its fsid/metadata_uuid changed
+	 * at all and the CHANGING_FSID_V2 flag set.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (!fs_devices->changing_fsid)
+			continue;
+
+		if (match_fsid_fs_devices(fs_devices, disk_super->metadata_uuid,
+					  fs_devices->fsid))
+			return fs_devices;
+	}
+
+	/*
+	 * Handle scanned device having completed its fsid change but
+	 * belonging to a fs_devices that was created by a device that
+	 * has an outdated pair of fsid/metadata_uuid and
+	 * CHANGING_FSID_V2 flag set.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (!fs_devices->changing_fsid)
+			continue;
+
+		if (check_fsid_changed(fs_devices, disk_super->metadata_uuid))
+			return fs_devices;
+	}
+
+	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
+}
+
+/*
+ * Handle scanned device having its CHANGING_FSID_V2 flag set and the fs_devices
+ * being created with a disk that has already completed its fsid change. Such
+ * disk can belong to an fs which has its FSID changed or to one which doesn't.
+ * Handle both cases here.
+ */
+static struct btrfs_fs_devices *find_fsid_inprogress(
+					struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (fs_devices->changing_fsid)
+			continue;
+
+		if (check_fsid_changed(fs_devices,  disk_super->fsid))
+			return fs_devices;
+	}
+
+	return find_fsid(disk_super->fsid, NULL);
+}
+
+static struct btrfs_fs_devices *find_fsid_changed(
+					struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handles the case where scanned device is part of an fs that had
+	 * multiple successful changes of FSID but currently device didn't
+	 * observe it. Meaning our fsid will be different than theirs. We need
+	 * to handle two subcases :
+	 *  1 - The fs still continues to have different METADATA/FSID uuids.
+	 *  2 - The fs is switched back to its original FSID (METADATA/FSID
+	 *  are equal).
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		/* Changed UUIDs */
+		if (check_fsid_changed(fs_devices, disk_super->metadata_uuid) &&
+		    memcmp(fs_devices->fsid, disk_super->fsid,
+			   BTRFS_FSID_SIZE) != 0)
+			return fs_devices;
+
+		/* Unchanged UUIDs */
+		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
+			   BTRFS_FSID_SIZE) == 0 &&
+		    memcmp(fs_devices->fsid, disk_super->metadata_uuid,
+			   BTRFS_FSID_SIZE) == 0)
+			return fs_devices;
+	}
+
+	return NULL;
+}
+
+static struct btrfs_fs_devices *find_fsid_reverted_metadata(
+				struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handle the case where the scanned device is part of an fs whose last
+	 * metadata UUID change reverted it to the original FSID. At the same
+	 * time fs_devices was first created by another constituent device
+	 * which didn't fully observe the operation. This results in an
+	 * btrfs_fs_devices created with metadata/fsid different AND
+	 * btrfs_fs_devices::fsid_change set AND the metadata_uuid of the
+	 * fs_devices equal to the FSID of the disk.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (!fs_devices->changing_fsid)
+			continue;
+
+		if (check_fsid_changed(fs_devices, disk_super->fsid))
+			return fs_devices;
+	}
+
+	return NULL;
+}
+
 static int device_list_add(const char *path,
 			   struct btrfs_super_block *disk_super,
 			   struct btrfs_fs_devices **fs_devices_ret)
@@ -346,11 +499,18 @@ static int device_list_add(const char *path,
 			      (BTRFS_SUPER_FLAG_CHANGING_FSID |
 			       BTRFS_SUPER_FLAG_CHANGING_FSID_V2));
 
-	if (metadata_uuid)
-		fs_devices = find_fsid(disk_super->fsid,
-				       disk_super->metadata_uuid);
-	else
-		fs_devices = find_fsid(disk_super->fsid, NULL);
+	if (changing_fsid) {
+		if (!metadata_uuid)
+			fs_devices = find_fsid_inprogress(disk_super);
+		else
+			fs_devices = find_fsid_changed(disk_super);
+	} else if (metadata_uuid) {
+		fs_devices = find_fsid_with_metadata_uuid(disk_super);
+	} else {
+		fs_devices = find_fsid_reverted_metadata(disk_super);
+		if (!fs_devices)
+			fs_devices = find_fsid(disk_super->fsid, NULL);
+	}
 
 	if (!fs_devices) {
 		fs_devices = kzalloc(sizeof(*fs_devices), GFP_NOFS);
@@ -375,7 +535,20 @@ static int device_list_add(const char *path,
 	} else {
 		device = find_device(fs_devices, devid,
 				       disk_super->dev_item.uuid);
+		/*
+		 * If this disk has been pulled into an fs devices created by
+		 * a device which had the CHANGING_FSID_V2 flag then replace the
+		 * metadata_uuid/fsid values of the fs_devices.
+		 */
+		if (fs_devices->changing_fsid &&
+		    found_transid > fs_devices->latest_generation) {
+			memcpy(fs_devices->fsid, disk_super->fsid,
+			       BTRFS_FSID_SIZE);
+			memcpy(fs_devices->metadata_uuid,
+			       btrfs_sb_fsid_ptr(disk_super), BTRFS_FSID_SIZE);
+		}
 	}
+
 	if (!device) {
 		device = kzalloc(sizeof(*device), GFP_NOFS);
 		if (!device) {
@@ -429,19 +602,15 @@ static int device_list_add(const char *path,
                 device->name = name;
         }
 
-	/*
-	 * If changing_fsid the fs_devices will still hold the status from
-	 * the other devices.
-	 */
 	if (changing_fsid)
-		fs_devices->changing_fsid = true;
-	if (metadata_uuid)
-		fs_devices->active_metadata_uuid = true;
+		fs_devices->inconsistent_super = changing_fsid;
 
 	if (found_transid > fs_devices->latest_generation) {
 		fs_devices->latest_devid = devid;
 		fs_devices->latest_generation = found_transid;
 		fs_devices->total_devices = device->total_devs;
+		fs_devices->active_metadata_uuid = metadata_uuid;
+		fs_devices->changing_fsid = changing_fsid;
 	}
 	if (fs_devices->lowest_devid > devid) {
 		fs_devices->lowest_devid = devid;
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 7f571bddee87..593fe75ed087 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -104,6 +104,7 @@ struct btrfs_fs_devices {
 
 	bool changing_fsid;
 	bool active_metadata_uuid;
+	bool inconsistent_super;
 };
 
 struct btrfs_bio_stripe {
-- 
2.31.1

