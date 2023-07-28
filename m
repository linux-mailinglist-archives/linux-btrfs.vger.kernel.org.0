Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7AB767054
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjG1PRD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 11:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjG1PRA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 11:17:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4986F11D
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 08:16:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SF4br0018529
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=tJAybxNMykSsIaZSr921iii12pHID17QoPcfTgtfsLo=;
 b=SwbzhkMD5T4fUWc4ASf/by5sJcsn/yyc4SjS0UqWJupAZ0j9TlZ+nvrExtJU737Cidl8
 4tzjNPz6sSDyLebfQwyKVc8OQKPbz0GZfp8k7EPC47eoK/nFbRdWYu1a6Dz4b9gMWYSK
 AP6DALNPNGwvY6/8AJ73oX3Zf4rxUE2JsniMWHC38dEe9sVto+Ha0zAJmAIg6TlEjFd8
 UYi3X5BEbg4YwZALBPCC31OewhIVZUYpDCpc2FP2oCExdp4yUEM2JGHavrSt2I1VNDLA
 jqNmM2ZlAyRBnCAswG2Id6Dbz/p5rWenM7qb8lPZRVmcUQXCb0OkhHF+IhJfniffUzYQ iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3v4h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SE5ZfL011704
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j9ec50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4bvyCKCOpOX3p2Z6Gmgt4XjR7Ici+7+OL8gtkPZBumJQ9q6Im2UIP22SU5ELJSnliAGSOaiwoZHMjJvlOlT/5hvQaqCl0D8ZPAtG5P6ZMO+0+B5T66UqHH1zhIRfXOf3+ElYsyeINs9d9AsjIaW5nAaUsyQ2KiaEiYqk3eX+C0rQ6X0zqeZLVvTFJBI5YoJvppqdPQ7Ro0mS/lldIbXbVzhpCJktgMzOPqXi9JvciWEvpdK4HINDxdWVeJUGen7FkDY2z7mN71lx8bYHNWnh1gFvnGzE6vA0dMOC+MMKZyBjm5bKTApIIUnhno0+LRczafxGvVmP9XdxbVWMz0soA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJAybxNMykSsIaZSr921iii12pHID17QoPcfTgtfsLo=;
 b=NVapV/km/LIRBFCnfiKhKBq9OswlFPqX8VwyvOfXfDJEfvNJEtHELbl4+0KT9QYxCawzNMuUaXdHLFsYGlzB9UKCRzfzTTWxKH48rhxIdBmckkWqRawkgezJ58no2qkp+/TYkqjsNXAt4mdCt0AuSYCbFFsW6JeKj5FTmNWnDo9Yx5WX911nnLlmrs7uAgy/cCFxzrrTf34TA6uDojCrMcx5IfjWgkTgiRGFUVerwGHYt49sIeOfehbCCEYKdUo7pNAHK51Fa8268t4cOyVF5NziCi5KvVhSp2HaR2OXVS2OmnWYwI18MaNBlhtLoTe7iRHoexoFlukM9zhetdw4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJAybxNMykSsIaZSr921iii12pHID17QoPcfTgtfsLo=;
 b=v8SJxmvbUaFu0F5CNN36Y0eHsIHV/EJXX7cDws5ZlnEdbzUCAQvUZ4Q/y/in+umpXhHBXLJk10Sh9l5/8zL4VNLMZNC0J36kROMv26EX2+SBILBdebMPEqs0zSJGzAGWLzbgbqHThZhiKj/6/CbXwEo2360AlQbrPSaHAhNDk78=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ1PR10MB5930.namprd10.prod.outlook.com (2603:10b6:a03:48b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 15:16:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 15:16:50 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 3/4] btrfs: fix metadata_uuid in btrfs_validate_super
Date:   Fri, 28 Jul 2023 23:16:16 +0800
Message-Id: <484851af56e2ec6a434a10c80ae336f22b45b305.1690541079.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690541079.git.anand.jain@oracle.com>
References: <cover.1690541079.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ1PR10MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b959f4c-81bc-4eb9-b794-08db8f7daafd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AncqB+TyNA9ZpMhHEGGm9gkp/3SB/745hVcOcyP6H0LNIlvr+c7tRUs+sjdox+JEFW2C1KeTasJ/SBQSewubmJMdT9cuhDZ8TLWyDLmdVn20diN6GUuB5/8905G2yGOrX99QSZVDmLnmAA7gi9m7/phZCbiMsTs8bqQkzGfQvu01lo2ODbtmi52be4UmpbEj7Ft4grJVuzF7I0ltaiE/YS47PJKNuX2mcGaut+KeqUOXysOVbO0VyOwser7TrFyajX+xb+UhKBap3EFiMoUE3JNz2NjZjhC2iV5B7HGcPBBeyyss60o8cIVhLSzwy9OUbWpYocsrWyiukVqkkSTaCqLYwPhSatI4bdtico5mw/6vN0J0+EUvn/G3jrquuiQ1fe2wMYtplwP06skEmKHgJpmID2vg6uZ8svqiaHX5ZaoqUL8xEu/IsaPem+/s5o/RPMTtIOP/LdPwSse2t+k9Fq+RjL1NC/0wGrOedk9qhOWmNSmiF+jgvN21skfyUSVK+h6/kOtu+xs4BejxIJNoTTipkDWw2jJvYu678JxoGoLEfqWeWlsHt1twwPaqQXp3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(83380400001)(26005)(2616005)(8936002)(8676002)(186003)(5660300002)(86362001)(6506007)(107886003)(41300700001)(6512007)(6666004)(478600001)(2906002)(66946007)(6486002)(36756003)(38100700002)(316002)(66556008)(6916009)(4326008)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ux+lzaI0JqRlvW+lb5IyBv3NBTeaQp1feDbtJ0FuUxjA+IYPx0ILGr+y9GbD?=
 =?us-ascii?Q?lBxsKQ/wZM/QiUqWpicDWCN9qm6/Ufb8XOvOyk9hUG/W4881TVwCD5IMzdqb?=
 =?us-ascii?Q?8cw8k53wiVdJ8fr3uBx2orJ0GNjssmpcLgbCIAXliifeMw8l1HpGj1wGxDY0?=
 =?us-ascii?Q?T6amIcATzdcr+R0K1r7Mmppi+vJyGmuVgWxDm4mbniexSGHog+NF6l7T7YkY?=
 =?us-ascii?Q?g4l4nL6isAeRmt54Yf2zrRqm82mYXNiOK4DR6ForB6ZHL1BRng42f8f0cVmE?=
 =?us-ascii?Q?VmI364Z/EfpSIZyafQOjq6wsqyS9PMln56MU9QYqwt1WabBCeVcdE05qSIHm?=
 =?us-ascii?Q?c+ll8/vrsCZnL+XpvEwzx5VGOA3s/4Zj7WtLraZRq4HmgOHqJ94FWrgF7RiE?=
 =?us-ascii?Q?pJT10ZQtKdDViKgEUMq4hKYR1CHAlx9efbMEEqtAwr28TR5V8+M7y+14J3LO?=
 =?us-ascii?Q?PStuigLjP4S/qnofqhsS/FmDo1OEmmlpPbHm8Z8lHEFcBQ197dzSoQUQvxq5?=
 =?us-ascii?Q?eePJCfNEh0tPART5UPsd3B0UfNMfXj6VEVDYDOQgMbLYqN2Q1l7gPdzLxBR6?=
 =?us-ascii?Q?x/27eHj30ZHyoQWu5noj4oBNgWhihRT87YS5iIrD8OuZjSUff/zf/H5eF9Xx?=
 =?us-ascii?Q?sr1rsAFJlZRADaq8RtvZDHFxvVm24s6kGYO+vtmJt59B0qPzCIGMOWph6KW3?=
 =?us-ascii?Q?AuwSOv2hyTrG3PaXr/N1mLawiF8hhHNogTlkG6nfI+1IHkRApulwpQtTBNAA?=
 =?us-ascii?Q?yI1e5GnCZ5nkxoK2tawJKHUV9mEDnK0hn3h/njl+NUQ56tTcnJXRtbJCfkOO?=
 =?us-ascii?Q?NuD5s2XEx0GPcELGgiecF02Yi1WTzIIXlBWshhXlEa3Yl7rQLbjFsNXWKW6D?=
 =?us-ascii?Q?8TCpw4ChvXSn61mJeXv9q/147L+PFSAKAXdsBCe1k8Efxb/6YEEZ+VKTlEec?=
 =?us-ascii?Q?rJWXAb/va4KorPEAePwhKnRYZqjdn6HfBldMD5XNWYC9LJfY6uns45gAtjxQ?=
 =?us-ascii?Q?rhMejBMHRmp2dgkn8UOF540tXR49TKw2CVGwZPGTviGRUiP08IZoq3NXaJBm?=
 =?us-ascii?Q?62lg1gCTB/FKGi7mwBwYn472+SYVWbaS/ISf0Yo53UWL32LRektt2rXLK6pt?=
 =?us-ascii?Q?8ymBOYCaF7mARg0FISAdtdZhIuU8bn2/F0Wtu8PGlfodUNWuEHfyDbelYv6y?=
 =?us-ascii?Q?Uvct5BefjkzjEibnXBjDBBxYT8tFKr+M44otwG4f1QDvxrgt4XKlqMWLMzqt?=
 =?us-ascii?Q?tR61hixFB4kXSJZzWD0LF9lX3Op5GDWUuPoB4yGTd5Ubwvw9znlNbJUyiQs2?=
 =?us-ascii?Q?6+wTHlrKIKdfJoSM7fDuFLrpXSR+eK5OYDWEJjf1XMhNoma/H/wHSjr+uIrO?=
 =?us-ascii?Q?Ik5RyG2SoAbfRLWZwKqg7yMWn8DAxpI60Jyv2uO2QAyuqjT0EVnUlmL+Nxkv?=
 =?us-ascii?Q?Yp0AVfOTRb83G5yClPOHp6XMNPpOHjO1n0yQolAhaVDP+XritoZmZYnIpr/6?=
 =?us-ascii?Q?ZSVjMvrTU/2x+o86T4KsE3nKc+svs4shTBczr/CjC9aRm6fWynkCv5YBWEBU?=
 =?us-ascii?Q?R6Z2yr8TBK34nGuPrnX5doeSJTWb1LdmVCX4ZNAJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 28OFerxxAPE/hp5yso8wZ1GcrA5tiXkWvbMTKp65Cp7xsXGLPW4GOHLQyGZZqh+bw2XT0Ux1TRd2mEhyQnIVzIlQCpcWbguVrmMQHrqfH80SBjqj43piXr9lkdjK2n+583QEPlxCWVpsFnTj8rBwdodQECFAQjd3mdrSIABPc51B/qwJGtLu9t+TFiH58YfUZxzywOcEd2GoYNotGQaxkKVDHPi1fMElHPcl/zWj+xqtcSIMC6qSEOgj4W8+sqgL6wH1ti13UmUMN1INLueJh5g+1/eyOgPvnb1qOUPyjG8G6TzJ6YaVyTu1eMJCBVOfCOls1d0WvX22wiF51KZldKWi+QMEuO8AJliFLt9/IhfPCGpjcAqqJe8otGilhD5M8IEwQL8VVw0GoJqoH7UlTH0FT+FYtFjbgvxJpQHq4YKGUYHH6do4kaeVRsstEEP0fqivbsv2J9a0Eegbe4RX7qwudwTVac57Kiht83gGcPIFrixBQHiGfpDbXRmBjO8RGWqP8LvRsDOqleQzUtUKjb4IPw29pNnBNmI6AHBdsgiUfuA+hj3i05xvN/uj4OOotk/LUm6UEi1gDKTVOwzGBWzEWVAmrXVaIy9hT+n3Hjaqff+5m7/W5uHHeYqWicoSuVaytBsQuomfT4xZo7BHMPazdKkI9JGrSEXYsN+uOcTVcKlH9dqOU2uxlC3j7MaC4iyB+dyVFNkAilPx2SaqTXjLtij5tHFo9i/nwvsClY588b6TAci3sXeenpWJVOm2uzT6iDaz39ISh3dm2YNppw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b959f4c-81bc-4eb9-b794-08db8f7daafd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 15:16:50.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KOHST7ESBYzgmZWjsz31qPtL4PPcd/tNtolQGhQeESBKtxfOZwLNeNwQge37bEp7u6roq04NUY2++i10x05ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280140
X-Proofpoint-GUID: 6azpUqfX0TX7DjYq8ajcMiXtLpYzitg_
X-Proofpoint-ORIG-GUID: 6azpUqfX0TX7DjYq8ajcMiXtLpYzitg_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_validate_super() should verify the metadata_uuid in
the provided superblock argument. Because, all its callers expects it to
do that.

Such as in the following stacks:

  write_all_supers()
   sb = fs_info->super_for_commit;
   btrfs_validate_write_super(.., sb)
     btrfs_validate_super(.., sb, ..)

  scrub_one_super()
	btrfs_validate_super(.., sb, ..)

And
   check_dev_super()
	btrfs_validate_super(.., sb, ..)

However, it currently verifies the fs_info::super_copy::metadata_uuid
instead.

Fix this using the correct metadata_uuid in the superblock argument.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f2279eb93370..8d6d7c23d37d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2278,6 +2278,14 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+static u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
+{
+	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
+				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+
+	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
+}
+
 /*
  * Real super block validation
  * NOTE: super csum type and incompat features will not be checked here.
@@ -2380,13 +2388,11 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	if (btrfs_fs_incompat(fs_info, METADATA_UUID) &&
-	    memcmp(fs_info->fs_devices->metadata_uuid,
-		   fs_info->super_copy->metadata_uuid, BTRFS_FSID_SIZE)) {
+	if (memcmp(fs_info->fs_devices->metadata_uuid, btrfs_sb_fsid_ptr(sb),
+		   BTRFS_FSID_SIZE)) {
 		btrfs_err(fs_info,
 "superblock metadata_uuid doesn't match metadata uuid of fs_devices: %pU != %pU",
-			fs_info->super_copy->metadata_uuid,
-			fs_info->fs_devices->metadata_uuid);
+			  sb->metadata_uuid, fs_info->fs_devices->metadata_uuid);
 		ret = -EINVAL;
 	}
 
-- 
2.38.1

