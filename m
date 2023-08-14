Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEB577BD03
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjHNP3g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjHNP3H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:29:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2591D130
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:29:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiSPN016420
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=XMGhUPS/Kjp/jHJ45L+q6oG9UqNwc2h1IrLK1gUN4CI=;
 b=bVvAfkLOZSGi0t50Ob2wJRayiBPu+oMFNNchpA4HpqUdN1l0o7CsqKLyNZOlVGgH/xZf
 kfIs+NuN/ypfBa1YigHtIjGYafCvvRDdAlGdNJbTzu2jQ0CumNahOWR19yZ1CxBeASiZ
 pWt3Eelve3Mx2FT7Ku7jGShYQ8f+wmD8f06t47zsJrj2UI5OcPGusfS/IeE9ESmOPymu
 uVOx45/FmrkdQxN1YK/G+mpZAOC/pf3zMUfj5PdkKHw10ySOCYEoSul4FjNFlUI7tNMI
 SFbyEYojPjexfECSbZxc6MxQvojfy3G2MHcvwEOPZ9V+U49516/CuFqD35cKwqKr7wFe 1Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5turs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EF5agS005477
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2c1sj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/CuSqNXyFQgY8y2ueWI/3iYJWcDuT4Ptd9X1+W2OdWZuYANGAMZbEh0Tnw4p3jCJTLZrqfR9DideKsrc1kAjjvpUgS6phyCxx4LwEwdpp+dT7xfAOi8to9IGcOu2idtE+B/kNVHISe4G8O5kgxYPenp0cgf4ofraIjKWU4nWCG4E1zg8+TO3NyMWjDyjL4pOYWwEudcKKmHHOFry4+bnHV/51HupvotADAnUhSHO7jwDNp9uktjwYSIjnS4QgvE4nYq4cVwgPT1/wqbkd8VHEB1EA9Yeh3I+Ve/QqWhRSQticxKC+BswWelykcUlwyIl7/nOVNxvlnqmE9ZCyQiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMGhUPS/Kjp/jHJ45L+q6oG9UqNwc2h1IrLK1gUN4CI=;
 b=aUzFjSwQmNEPn1i4SQ9lYHQoQRJDQ8GAx6XK/HohFx6oIJIKlovUaMDEHzEPl9mKygQ2OWi+0nPWyfe0WeSoTBQ6hB0+NVV0FBDhL8gJGNlISqXuNw2CAXLz7xD0uWxkFsvEjtFPbSsR/jfHUS6+qDCJaoOPI2APb6H7JQEQSEaJi17Q+CPwqj1ShIzHOIpjlTs5dhLI3ib7jTcpGkBt6H28bWnwZoqQodgu9M4Z3bXZnWSNOiE11w1JyrM9GxfAPW65UMJ9JteUaAbffBlgb3/MPnP8uttxKosFkodJEePfgnzr1gfhS58n59psbC9paRDaubU/90Tlp5LyODRFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMGhUPS/Kjp/jHJ45L+q6oG9UqNwc2h1IrLK1gUN4CI=;
 b=CzyGmuovT9s2krzsmO56M4YjBZ7yNLYlVBCp6aIxcTZZfH0HnllozbHkPdJd6Luma6S5bt08wP8hfRzqZNGtCMJM7CTPFq9/5lHfiwT8WKrU95zkSfHsYRvSmhoO+WiNJBg6zI4UtcpBc6kEfpI4PsiLs+b15yUo6oB7P0RAJDs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:29:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:29:03 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/16] btrfs-progs: rename set_metadata_uuid uuid_changed to fsid_changed
Date:   Mon, 14 Aug 2023 23:28:02 +0800
Message-Id: <231421d7bc2101448fe34e1661ff348b090d08ba.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: b07dfff9-0339-4b04-8aea-08db9cdb30c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfkUXfIR+YYLaMmoYmlqrLoJHIXOtcDm3StSNlpKqK1fcVKYxRV3DQJiBmfFBCw+T87QSk5923WqJNoeLT/PDu3hoF2q0Riy7tT5Ocyysc1EBMfYpto6qWeN/9lvS87lw3Uiee49CFtM6AoaofTA4nA+mYUrT+lOCquUq0r3nAMI5v/tiZyGnsdAeeAi/sNi662sQaKgBF8naF9/ZNKE4TehxeygXqLcEdZveebvZU+MuWokMPnQGb7A5wH8vfBaUdQmDvWWHiJ1pbta+JMSKc4xDsKYzcbDa8A8BKNaBnTRrzPK3/n74w0hhpC7CLLOn6xz4S3dFCpFezd1Mw/ye/RLmPSSqB1AyHFPqRAOjIwiToLVp45cAVmsJneV10EK46LZxNDDGwixAkKUozQTtYpQfjltZA4a2jS6Ga7C4wi8BGmcQWX0zdyXeVovqEvEjerez8RwHkqf9ppcdfwye0ZsxewCegI6keYSC1iEhOEnlUYLaF/7hzyx0CTkSQujTzooSpVVSnic7I9z0ioL1FS7kttfyT1WxYkO0haMGPZeekx9aRDWMl4A4lRltvUA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(478600001)(5660300002)(2906002)(36756003)(86362001)(44832011)(6916009)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(26005)(83380400001)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T2G6YbUkx/57CQpMm7mxxsqi9cmWmYM7QlnMIITPUhCpQlsr5gb2adm1qqE7?=
 =?us-ascii?Q?pao59cW4jIBJtLx/z9QP1UA87B58HzW0ZFtpwpPcrNwILnwd2j8Z1ojt+NY1?=
 =?us-ascii?Q?iWWl91JE3IMd1sMZSCCAcptp+GwRz2z7hfJEi8VEODnNIC5hQ266OedWcmXc?=
 =?us-ascii?Q?W4xyd6TxZPKwH0gFKnGahYl/4UIUxSa0m2N/5nsLrQPuYrkqa8tRblY49F02?=
 =?us-ascii?Q?tnd3HJqpe+fK2dIB44/AaPMKXkG0mT3fcw6IFljf0+8Yt1a0mLfrAi7IDZ1+?=
 =?us-ascii?Q?0r/2hZ9Zlhp0fLvyDl4YkpLtF4FayVWEubJWbRWUfjp22XemsCetx8iWzH9s?=
 =?us-ascii?Q?IUkigCPoiw4C80nFLLS3dbAOLMKSEScTvhYb/83/vKWsuktiMD7MZLkWt2OB?=
 =?us-ascii?Q?0zRFIp+E9rWiF2iDs1IvBhYSw/E7beyI3jHYJ54rAwNxDvyBbleNsmcqSni2?=
 =?us-ascii?Q?0sUaFWhicYeQJXuyCpG43rqA6Niquct/95oY+OFQ1U+Wjf0h12x7FTj6Kid2?=
 =?us-ascii?Q?xHhi3W2zvdMydXINHpzwEgwmd7Mmf7nGvKRci0E6C8UcIlpRZ+MX4B85vAOT?=
 =?us-ascii?Q?bHqB0p8ZQGgGO/iF3251xG8mgO+bb6lS6T6zTDZKTjahQ6nHIhWyrXdz/Z47?=
 =?us-ascii?Q?yz+nr9rvRyaNeV5pealz8Pzjevt3Irfvz9NYcJ1i6+nX88+DLqIcsM+22xkt?=
 =?us-ascii?Q?vOMooCH6QHVgZef741254zXaBVDIYET4v08vxJ8RRnOd7RagHEanElFrjGZI?=
 =?us-ascii?Q?TOFx5pf+UsREoKMtLZcX9/tzQl2KQ6ei4x8MN3PoZSK+tKmThSGComtFDA2M?=
 =?us-ascii?Q?jERNCNI+rojHQJ1tsTIHqK333VPXeotECS50vCXBFgehCHGRk3fbDEGlHn7N?=
 =?us-ascii?Q?r5622WmwaKxCBYD6qbc/cmMjZJlDd+4cT4XfKubkzfUMPoRCheQK9Ia0fT5J?=
 =?us-ascii?Q?Kc91o+VjyRYM+ltrxU7lp4804SSyu/15PmgaXmHb5cwNrzInstMLWnKKnYiT?=
 =?us-ascii?Q?2fVJ+h2/fQRqx/5gCzSHaGWYoXEjihRUZYoM9attLZ1GVsMWKUltJea9hzfe?=
 =?us-ascii?Q?dcppRtMla/rrBFOsQeBmfo5/o/itum5kzt934kk10VIddfe7NtvylncJ/lmW?=
 =?us-ascii?Q?SBTkHTLvNLa9zwTzIZcyyc90cXDI+cQN4eTxGKVggblKAn1S2Ak3L/3qoQ9O?=
 =?us-ascii?Q?TKQfIA/RQTJUKW84KVeN43Nm78PjdRB0QQcxX+g1nay0v5GEmNRG4udvPzJu?=
 =?us-ascii?Q?yer73e1kEaGdAnEWP+y0PBqrZEgebnw0gb30Z4Fr6ZFg9toSmgszPypj736u?=
 =?us-ascii?Q?/c3Mf8TE4pzLr0SZwGK0BZGJuFhYgBdJYoN9G5jsVuKHjAIJpu2ccDWiM1Qo?=
 =?us-ascii?Q?iOHNt3dtc5RJdl1Ipivh+uEQaoEFsJtWctnrB0TbrNAqs/xOwKDtmDPBJpim?=
 =?us-ascii?Q?GkNsB8icyH1ID5yPXDDeBrP4pMh9wlwQYbStcjB9N7ZGeSRWe5SsFiv7A7ie?=
 =?us-ascii?Q?8ZmZ/AAPkXcwjpHZMGlRM3uPqoIPTkILqzoGDUYFA7WTgXYXCzGpexR4fxlq?=
 =?us-ascii?Q?nK1b7L1aQZw5CsykkQyLRrZmdCyzeq+AsgPCv1kxVpI357y/UMgKqoxo4Axs?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GkAt70UZLtJeKgdS4SHz1eUG+UAM4q5vrPaz21x0W0AerLJ+40ai8Oyek4Nk1YN2xk4mJvPeI+rbkimBCecAOzThvIBfXttGNXXhTbyggL17Pd3OJQBk1XMenYVFHuTXEHgFf3/EsoU1MztP+jwxBR/0rnaSs77EqxEKUP9dgQSgcNN4kpibJ1vSK8IiGry73ZaNIaFu6//QEZLQLKLjANNkIKihSYgTFZAHoDMD5TQvo2DWioe10ACTWjyms+q3yHOIIvj6WKzEpwuqDNSR/BC5Nb5h71dsqF13C2Q3o4m1qFf33Kg+9KccOUZCrmghVGOtto1uov4YDcdtlsOGoNihb8yj82UZ5w52kRciqeGF2cz/Fv3AQYSgylCTRibdR4oki2MVEMrT6fydpSZ3bvPxSaVNvhzygd+JDkDASo6enT+IkiJ/eSkOF9Ia5Q0YWYuTDzifFAexZpUu2oWJ3oZiZ5njHOm4HI0hKf2s6xmzbJOtvOJaaZV3T/G3+DWKFq+h/2nZVpSOKq/xANtQMeE4leN0QHNs3IlEIxg9vNbr9DkVzgUgyhbD1586xw73FGDH6YqayMHv8ulIdWBWgGnwq0PSgP6TyRqbnAxdsJNFeVGvMido0CzkaLH/9cKgxrJpHWo9IdESKUfTWvQdCQqDHpekwO+uryy8A2KWKDXGsqGVFVUALlQjeOtCUXYq97UHob4lh9wGruKJJOpNCaTqZgbD6zJrDiYiKj+M+twGgJN0Nchiaywjcd1p4KDYkaB8kRvD1bKVQtKfuIoZsg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07dfff9-0339-4b04-8aea-08db9cdb30c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:29:03.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBRgZ5cE+3UQB92XJbxFGEXcrpmde4j60C62yM0Y9uY/n/NoKLiRzkcPE+0gHCHYlbGlk3zL4b6+AhbaHG1XsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140144
X-Proofpoint-ORIG-GUID: GlKPdn7Wf2soBaySQG3hTqr4rymOb8Se
X-Proofpoint-GUID: GlKPdn7Wf2soBaySQG3hTqr4rymOb8Se
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We never change the metadata_uuid; we only change the fsid.
So '%fsid_changed' flows more appropriately than '%uuid_changed'.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/change-metadata-uuid.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
index 83299f990b50..7bf30da4c3b0 100644
--- a/tune/change-metadata-uuid.c
+++ b/tune/change-metadata-uuid.c
@@ -31,14 +31,14 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 	struct btrfs_trans_handle *trans;
 	bool new_fsid = true;
 	u64 incompat_flags;
-	bool uuid_changed;
+	bool fsid_changed;
 	u64 super_flags;
 	int ret;
 
 	disk_super = root->fs_info->super_copy;
 	super_flags = btrfs_super_flags(disk_super);
 	incompat_flags = btrfs_super_incompat_flags(disk_super);
-	uuid_changed = incompat_flags & BTRFS_FEATURE_INCOMPAT_METADATA_UUID;
+	fsid_changed = incompat_flags & BTRFS_FEATURE_INCOMPAT_METADATA_UUID;
 
 	if (super_flags & BTRFS_SUPER_FLAG_SEEDING) {
 		error("cannot set metadata UUID on a seed device");
@@ -65,7 +65,7 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 	if (ret < 0)
 		return ret;
 
-	if (new_fsid && uuid_changed && memcmp(disk_super->metadata_uuid,
+	if (new_fsid && fsid_changed && memcmp(disk_super->metadata_uuid,
 					       fsid, BTRFS_FSID_SIZE) == 0) {
 		/*
 		 * Changing fsid to be the same as metadata uuid, so just
@@ -75,7 +75,7 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 		incompat_flags &= ~BTRFS_FEATURE_INCOMPAT_METADATA_UUID;
 		btrfs_set_super_incompat_flags(disk_super, incompat_flags);
 		memset(disk_super->metadata_uuid, 0, BTRFS_FSID_SIZE);
-	} else if (new_fsid && uuid_changed && memcmp(disk_super->metadata_uuid,
+	} else if (new_fsid && fsid_changed && memcmp(disk_super->metadata_uuid,
 						      fsid, BTRFS_FSID_SIZE)) {
 		/*
 		 * Changing fsid on an already changed FS, in this case we
@@ -83,7 +83,7 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 		 * has already the correct value
 		 */
 		memcpy(disk_super->fsid, &fsid, BTRFS_FSID_SIZE);
-	} else if (new_fsid && !uuid_changed) {
+	} else if (new_fsid && !fsid_changed) {
 		/*
 		 * First time changing the fsid, copy the fsid to metadata_uuid
 		 */
-- 
2.39.3

