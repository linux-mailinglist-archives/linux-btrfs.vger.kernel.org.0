Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1B97A14B6
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 06:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjIOEOH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 00:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIOEOH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 00:14:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB86B2703
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 21:14:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EKxSuA032061;
        Fri, 15 Sep 2023 04:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=bRbozF+jKHcsgVAFl15nwrEOcEV2ZQfXxbp39kqWvAo=;
 b=owAK+nUAqxVOIPXl0mdcmlrS3fAz11EA0D3XN/BY2/B/M7i1ykpRiU2Ap9EQrvdJz4eV
 2983/IZ4xO5fIglXwlQ6c0S8U3E46LwMKaThgzfzafYZK2IOaSCAuTWjNIshKCvNTEXt
 HF89ankx081sNt4zu3HQ+4U6/Ri5T6Ja/fklTgrtSHxhJHYw4sY7k8AWeYz4j0j4zoOE
 YWMFrzXouYztqV4Na1cedzb9P7EoP/629lKAArWykqWFIow980MM32zm7n2g2ywaOGSQ
 iPG5Li7lIqXFPIKWxKvoyEgOit+5OlmD6YSJoSm7mi0aB+K1DCWcUwGBRud/Gwacb8RO OQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7hewmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 04:13:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38F46rYD008927;
        Fri, 15 Sep 2023 04:13:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f59tqf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 04:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKLjF56acCWf/iWj//5V5/FCVqnTzqePsF9SnaolbXfSlwXzUXlTtV0qRet68F7UloCJwOa90UxalDAh8CYQgm/cpG1X7VEa7km1hgaELr9kKEQWH5jevBKml93VyRNAPPMfO1HSWTBTfFl0BHnjvMU0Wskrs0FjWyjjQ+SlRX2qLcnH0s5rtVHASe4aLlBBXCYZgMK8AJ5SMJOXrk4NjzUJM8zrkq98GlD2YJRvQtm1Rh9IzFjsfERsOB11ZW4DvnToBRP+hduPu+CJd1KKp1/HZOr4MdixQMVYsblwpeX3SVZJeEVEE5sAKfaMn/kmVcjTv8+GzMxwWAhwafdlFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRbozF+jKHcsgVAFl15nwrEOcEV2ZQfXxbp39kqWvAo=;
 b=XsRMgTV+xHgpToO6w6gQdHh1ghXASiuCgXjkpStF5RHli3c7GGaps8riTc55x9IssOOhkEFKjCR9tRb4RmAS//5/s2AJM062N0jEKB0xoEWugbiAFjmFM3ZM7K7u3qB7U6pIs+koUSe+GGIODIXK7akUXRESjLC3r4ocQT6NbSk5xjydgIhPWtoj70CV7K/iOLfMwbotEpm2UWio8JJrZOmyEPN/yDdIWGAQvF1bXs/T+WyMHV2NZgXgbZ0AtL4kX51b7fsty85mmpuLfCssZC8E01QBjGath7c9VgpYBTWw6hpxSPKeQxEly7ADiEtowVGjYdy5xR+gsjc3EgzMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRbozF+jKHcsgVAFl15nwrEOcEV2ZQfXxbp39kqWvAo=;
 b=pUz7cWTqwtR+wKFQ5fkvi1PCrxq+jHzWQdD4DleWAMzmIXQiftGQ5w7cbfiKArGHim1MBbIzaI0AdP0kbPhSvgJLfRUfDMEnir6tumlpZ4OMevSiLVe2HWrzAVxhIl58NxSt4R4rFxIPYoloaOEQ3Q7l7XAizPuH0wFk9m6HWvk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6544.namprd10.prod.outlook.com (2603:10b6:806:2bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 04:13:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 04:13:40 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 1/4] btrfs-progs: tune use the latest bdev in fs_devices for super_copy
Date:   Fri, 15 Sep 2023 12:08:56 +0800
Message-Id: <f0c522ee29a3404271058f482233d55183ea5df8.1694749532.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1694749532.git.anand.jain@oracle.com>
References: <cover.1694749532.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b36553-7edb-45cc-d89f-08dbb5a22470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCTSl0j4DbgiR4BXfNRESpo5mUUiUXyAQo8J7rrPWgFAdOBTz8IU4ToDWJGjNlPmip2BQhe9CAomHj2EM9SKu8MSGjZEzqraPQFLDOx+KVto9aLa9IP/fBA0fjcAVFoBLDfFCYKqFdB+NR1hszQAebL5/st0JOJe5eWZNh2YBKKlwPRXqXv4dn5zS/N4DpS5i6aEvQ3KEGTmEeVwk3LCRv38acLYV9efC+rSlRp60EQXcHgX3JH3/MbAwTKf+GgTe9XfK2kaBJF7o+in7El4WAkn1octf889BWAO6TrjceepKqLbnsJBYzJAJl3zvY+FsQozV+ki9kkM64B0MJZXVI80ifOLNPpb81OdIDzs5gX22ucvXmMObkS7o9K2geJuiUGhTGDFFqc8ryQDkavz1ByEb0WI+iUo8AavQpPy3rRwFLRX5Q5oRiO7hRM9qXWwKbzxqD2PZhf6SLWASHkhOkSZ5V+MGBnnmulOz7d96Oh9N4XLJql50X48Y30U2brnOzsNWGmIDEAx/mSZDeX9MYAulGn6Un1fc9Vf3kCSQNfBRpEoJr2bRS0b9DAqM76q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199024)(1800799009)(186009)(36756003)(86362001)(5660300002)(6486002)(44832011)(83380400001)(8676002)(8936002)(41300700001)(6506007)(2616005)(6666004)(4326008)(26005)(6512007)(66476007)(66946007)(478600001)(2906002)(38100700002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YKRUfD47Rt3d9k6gz+9hO7HV6U7gnn92ji/HelXdk9zItd9FcYdRFOo4pHBK?=
 =?us-ascii?Q?VlUSo/ep9LQ7rLp0Zxd4X3ChzbM+3TE0oaYZVWLrJEc6Gnzq6rdal03Cx2ir?=
 =?us-ascii?Q?UwznYzeYtzVPzwjTXykUTxIqL59pJMhq28mG2T/25bEdyOipn1TYFAXAJfMZ?=
 =?us-ascii?Q?/CMvHc1BpiM3JEJX9uodGyLTwwMCC0i74vr0ZV0oHUKdmw3qWF/I+78ESP5q?=
 =?us-ascii?Q?2OVUvNkuiQYoSj8VK+u5I50wCdB/W4VnAOEsVZRuc7tq7ZLvBkNlYadn79Aq?=
 =?us-ascii?Q?DUKjVOkICO1Hl9LrYdhTx0xddKxJYdCi3m2X2M5tGHQGr8+6TmO20NM+cjiN?=
 =?us-ascii?Q?MMOaKIceOihbrml0p9tl4iLGn3QHZyYJkCYl/CiS5VpiyoIMj38cxU/Yii/6?=
 =?us-ascii?Q?a/z4JvTVzcM2QlduEBVPtYlxeOO9v9082btIg4R038Eb0SeFA3rK3u/KN6T7?=
 =?us-ascii?Q?61sT5luKrKimZOAm4wzqvRedl/16Ok5J2n9Ly+8j6GZr6SiHa44oHt9xpm3j?=
 =?us-ascii?Q?IifsK2xmbfRXvUoVqbUhUbNxpjZl8RhDqdZdMpXB5ReGy1fmSq5I5OG1cEmL?=
 =?us-ascii?Q?TaUCoE8x83zB8arUHUqgNAi8QvJBnnR5Vk+5os1AlGqca6F1LNzkNLBYIVOY?=
 =?us-ascii?Q?QhS1ELU+Q364vpLiSX0plTiS0kkQHyzty1ONaeppmbZqd0lB2Kp4+hOodMg0?=
 =?us-ascii?Q?qGbsMnDTKzbv9fUg2nHKVJIzhfgRkNtb3lPL7Al95S1HPSDFXRN2NYgSH7Vs?=
 =?us-ascii?Q?NOUAjGufzJ3ZY+RDoBZPBkycQTGzqMN1iQywZnb6AkygOafk9du2bPuXEhlj?=
 =?us-ascii?Q?rK0bg3nvHg/EyzIx2MyXxvwPfZDyB0Ilw7vrEq7Qt89XMV3fH64k2kUlM+2/?=
 =?us-ascii?Q?neR7sMqT9pT7P95w/CZ2+xK7M0NgKBbctavFx9laiNtK4lT9+apRgyvqa0aO?=
 =?us-ascii?Q?nfU1R+PJwcWa1uy4Le0A45kHcLxmeonBYNuq90WeDkHZ9fK3N54mFy+NIZEa?=
 =?us-ascii?Q?uz/O5gRrVW0pNg2QLLmvS26+IZF008JXfEUh3pBWNAKGzr7y66Jwd5rMDqh4?=
 =?us-ascii?Q?uAWVCAmXzVOPFz1maILEQhpWWRl4iwhvfpLV1jztdjRzqVR3Ipyq8MDFl2Wd?=
 =?us-ascii?Q?+dkNGRezTEQnJZSDjHwZowxgEgobszzkIFLA9T5PgY1rwny+k6DXnuPTfOyT?=
 =?us-ascii?Q?/HSjYEt+QJBGGe7wZ2e/1Lo+uJvzG+wUnslqnvgJbJfd1pkKJMx27GQ+pj4m?=
 =?us-ascii?Q?9beo3x4p8GOtvz/FY9wYLirZnh16lLwNQfgVofqFWECHCh4l/iVBClkAKebn?=
 =?us-ascii?Q?oivhdfcXtBIjeICiZNiYuiAjrdwcz/6L2Vq8dPLsGrVFmV1WBumZQCyfRamz?=
 =?us-ascii?Q?rQSA3S9/NSseZD0weGNFwkUTAY28YwzsFwePamdmo4B3RwDgTw7048B2KLeA?=
 =?us-ascii?Q?1MS0Ar6rA8liDww7dbwVutkk39xMR8Qx2WpfruzP7f9wCaupG1ai7/2M3sKr?=
 =?us-ascii?Q?sY3yZ4ATBtHDCd/PqTzS4PTRQU8B/z/CFBqnXUgAPLtyh4g3Pebvm9AN13qd?=
 =?us-ascii?Q?1rP5c26Vf4bV4RV07cv/DV5tY5bYcF7RXan+kOEuwX3DMMrPclUwgWMj9A50?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tawZehNlNq10wU3NIHGjlWf0tmBOSWG3waKI7ai9GGrVsSu6PRmseKbPYYR+qbDGl5cwRlaaxph3NCI8530uX4gs++pTRN7ARg2XSWTcZtjFFeVMVieHPxBSnnXAXROC9qbV1Qexj+aCAH7rCauY72b4Fv9j4wenRnwWhm10o6TNuV3aEQck8xZPZrvFupjxQQzgOi+kvmZG3hYxbbUcsKUPKxV8jpBS4N7oHLHFrNlFaYHm7tMsCwOJJbz95OG1sHWgVzS/vjCxdVpxM7HNSdenymrYCguGWG/ekkUsT6LwIdJp1X9oS5hOa+YZWbIIMhTTpN/e/xmlh4BlnuUgvycmJ5q2Xw3z7T3Y8uk7zHpZTFi969RmUiSO2J9eI/UuAHM22wP44BiO6oMEZIeRJoFJvYXsjdaG1JC+Jx/5YvomkUmNMIaRfCsCHZ1/TdoJAmi9H2Hi5RYfUzpYy/dIDQBIkX58gtEXH+DcFPxodpJO0TK6eXMFt1W2Pc74H3NbRPQOzh3UvuHmRUkQMdOEt1PsrXMvi4wMBoFkF2Q25g5h7WA9DpPhuX+B4SLd6EkIjvTqO0CiguPFzaIRR9QZNFEuKkqAVN2So8vliBZDZVCQHBFUAfoGKWiAkwuDbWt3GLnHoWVPZmg5b3J6w6eNUz0pn7v/Xg2t8+Q5v9djtAkjFVHM6V9uF5fos8Rfsbk//cVPMrAAo0Z6j0rUsu7ffN+6+IWLKZFB++tX9il9WsF0IClzU7Pg7qTXBXxeNUhoNeaRVYlucvTP8NDVfiU+b3x+1rt5ru8rfHG/q1VjXwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b36553-7edb-45cc-d89f-08dbb5a22470
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 04:13:40.5192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 644N4NjTHRG3BK0imc2NfKagEXRoHuj+EKBntVXxnHDLjyYQNg1jQjiiaGogAnu1j6A1QXxyqN7dUDu8/NJzCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_03,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150037
X-Proofpoint-ORIG-GUID: jgRzoUk6NLYg_Q2bisQqZNX3O-bJiV5h
X-Proofpoint-GUID: jgRzoUk6NLYg_Q2bisQqZNX3O-bJiV5h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, btrfstune relies on the superblock of the device specified
in the btrfstune argument for fs_info::super_copy. However, it should
use fs_devices::latest_bdev, as it points to the device with the highest
fs_devices::generation number. This will contain the superblock updates
that other devices may have missed and we can now support reuniting
devices following failures of btrfstune -m|M|u|U as in the patches:

   btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
   btrfs-progs: recover from the failed btrfstune -m|M

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tune/main.c b/tune/main.c
index 902c9d97956e..2d8f2b012caf 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -345,6 +345,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		goto free_out;
 	}
 
+	if (change_metadata_uuid || random_fsid || new_fsid_str)
+		ctree_flags |= OPEN_CTREE_USE_LATEST_BDEV;
+
 	root = open_ctree_fd(fd, device, 0, ctree_flags);
 
 	if (!root) {
-- 
2.38.1

