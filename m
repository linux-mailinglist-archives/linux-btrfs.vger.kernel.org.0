Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5449E7389F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjFUPmw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 11:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjFUPmi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 11:42:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38931FFA
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 08:42:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDAhmQ030663
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 15:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=9kIjYlMub/Pm4u0cP09HksIgY5bNdu+fnBcO9RGyx9E=;
 b=fqV0amtqbRef7q2lz+omdBer1ywcUArI+NwD5ASHVJEu0ueawNPiQt+tOKMVhj0M30UG
 WjJCBYirMC9SD1iSf+t0p0MiRz6UApo0fT+px6o82n8QsAPmqu/G/fbHGLgc+V6n8/p/
 RGd+ToOQzNKf3f9S/8ykTSKSKVst5OybR+krnVekL7nIHN2qNomnAaWNpvBzcIuZOzJ1
 yvmU0UUKNiojFdEfokakRPUWma//s4pE1C3hRU8V2v79CgRfl4IMn49vLS8rEeGVAXvv
 wADSHMp1lomE+yQKFkCtxUklS99ruZXw+Xd6jn93FanZrbU4vxMOUtSm4HGoZlGiiwYY +g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qa7q26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 15:41:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LEnJ9n032924
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 15:41:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r939766ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 15:41:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIQAlZ/icC8SveyS3t/NuAbnLQpK2QoAemaXkNIc1Cr9uXPadXa8AD6c67p9sYFRVdjzmegv3CLboqi2u76TAG6RV9yU91ObVXnG/0lqQaPAqEb72V797Tz2ds9nMDYyna+rWvySZPp8p/SSdjgholzo1hriQ1fgyn4uTngZJ+fqxCpb8NGcNIIDwdcWd5tuKbczDA/5Suen1PclgNN1OTteI7X1OA66xeYIvTTp+ivP81vBcyD0nsfZ9RoqXZOUDnYikyLI67jkRI7e9HpRtl2DZAS066EUawSGhDARHRdjYo+jLw1/9P2EyFWRv/Ly52STqdJdUjiMHHx/HlK1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kIjYlMub/Pm4u0cP09HksIgY5bNdu+fnBcO9RGyx9E=;
 b=Abb2mVA6j3zfbzQV47Lwl/6l46AWnGoiPPGaNG7zlSZjcLPFszO3SnWIpKIwhtSAj6wPaYJ0D57JylXAhJB2i2yZcLippCzj3REygOGEa0UTcsM7xmT4NOp523RHfI+x7YD8rLP0EQfaR0+VUSTo7KeLiK2o859JB8gj77JyzaqtoVaNZ+vlfsHeN96/nfvSthnwuByDQMjeDYX39jv+zlvGilIIJsWn9A1F8ogqnb891XsISzpte4xFMtxom/JizMXEiRaPwKS8zqtI4cMfaSrgbGJ/pIhvktoxr+x6cmjcGImc0QpzZHzOBIVEfRYkea6cW8M/3BleWt4bv8UPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kIjYlMub/Pm4u0cP09HksIgY5bNdu+fnBcO9RGyx9E=;
 b=wqnWMHG010aGOoO7qrQqUkwfRsSP94aHYwhqhiyONC+/t6WlVtaESDcxe4Wm810O1l9Ed67wowQB3zKiwrNzRm+10piUGHBy3nJQnAo5ZWzYN/xxdvFwkZ7MK17KfSq91obJ5vh4ac4p2lwPAhaKPo20KIM3DfpR5tTR6DsW0Js=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7148.namprd10.prod.outlook.com (2603:10b6:930:71::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 15:41:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 15:41:43 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: dump-super: fix read beyond device size
Date:   Wed, 21 Jun 2023 23:41:20 +0800
Message-Id: <f7fed92047412c7e8f89e94c10ec80af564fe9cb.1687361649.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1687361649.git.anand.jain@oracle.com>
References: <cover.1687361649.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 042ad44c-65e5-44cb-1d7c-08db726e032b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjt4ibFOvj3n4NAsOsr1AM8X2R/wnhibb9Ai2u11eDo0lA6fa/AsYZSpON2LfSuPdbiFhsqZdC2n4Bpp6DfvmDRd6rL7S6pm7GKh+fQeIyilwlr6QeBWxncNxKVPTOu4/ZWWMfKhyO9tS5GAwOB/QwoY76ENh/iyoreiz2/Pr0a2zxgG8VD7PT/mFoRDgLAjHPklYHi7Oxg8kBta0cWdUqEuQu/fks9YWAXlaWcuPCkmUbSVAAw2luHJpCbfxlIB2m+UMEQAXkM++NqAMdt0mbyOc/oQZVp8LDz/wpe7PSU/FPwQgU911/9LdbfdUkslMMcjiBFnS6j6tAGdzx9EKsfHAhDYMzQxnCHxvSSwNNjrMZSA/NM3MOh31GILa54Cv56C8CHnw7xcj8TiZerxHfGaKJ/0Gs3zvzdhxfUv3CHOeDuyXZTwNpkYF1n1Su6hnbooe8OyKkoxkyDKA8BDBq2OMCSvtsgzVXYmo8veDaA4dnKTnkQx2Lj+kHW9QgwT/XhnjFnveCLDsWDPEoIOEyMwu+TleyVDDljE4ZY/UiD4U/DgM1XQ9JYHYbdVZ0o2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(478600001)(6486002)(6916009)(66556008)(66946007)(66476007)(36756003)(6666004)(316002)(86362001)(83380400001)(26005)(6512007)(6506007)(186003)(2616005)(38100700002)(5660300002)(2906002)(41300700001)(8676002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xo+wNlkswm4hrOUJPK7ILsej1ujcV4MLL7o4xV4NKRdq5YTdN+8lO6GFY20h?=
 =?us-ascii?Q?qdVNyk4T83Zk/kqDB0soer+YqEtnmIgnFWULJVNcKkG0sE03r767TJAHP9Qy?=
 =?us-ascii?Q?uhTHI6HzzSnCi6Ypbn1KnyIyVK+owl0iLCe59/eQKrunJbRM8kooG4kfYew3?=
 =?us-ascii?Q?qffRvH+dCn8MCV17CwWJNLNdqFCYY0no70A9zWOYR9CQfRZPqHeTcVdOSobm?=
 =?us-ascii?Q?Z95qC9HCIFyhVeSMtdhL6db1xJXASBWOZbu/ORYy8Om+QMSyOPEacdJl0+Wz?=
 =?us-ascii?Q?bwkPVbHT8KbQBAXjzvMECVHGY33XtQ2Hc8MugZ3Eix0Gaq9HIFGzhqadB1lW?=
 =?us-ascii?Q?teI5+6hrLIEGQ5uH6yYCS2ihqic2sKqBOnkyxmwl0Qwn4m2zCs6DxHVMxQKT?=
 =?us-ascii?Q?uMNtfbwAt4n1S3jeKOJwXg6oT7Cj3mo3UqD2JObYJ6s2Ukke5Iy3/WHkHEgi?=
 =?us-ascii?Q?//4O73sLqNfz02aX1EMuhPiQoUoHPq03q2r6Q8ezesdMQSiftjzSfzY7/IfZ?=
 =?us-ascii?Q?JfOfimXSgYMPZczcq9ocq+u7V43FwlhhdHIdPCtUolGq0z/MqeDRwdE7bJXM?=
 =?us-ascii?Q?no8FN1pYv/O5xXr7SK73YT6jnUVlk7y2chcALnds4/v5OJYCv04AGsZ6IAk9?=
 =?us-ascii?Q?qUhfVUTHDw3mLn5J1W4s7bxCLyemFBAGvmx8F3TOMq8eJ5epw8mgkeSn3eJk?=
 =?us-ascii?Q?dgt4BZdRLmiJPA3UCgf0MeCQxpKNAlRUEf/JTQORxf9Xxk1BQo/FAaMutY5w?=
 =?us-ascii?Q?DkUFSS+dnTD4WhuqTbki0r3aqJ+4kzqwqJdFVWvqwmKfrhWnqzqUIWutXOEW?=
 =?us-ascii?Q?8jt3jLXTs3LOylF9rs2mepCIpsszJqUCGqcTnqCgCneb3pCW+hqLSM4fueTi?=
 =?us-ascii?Q?O2xg2uRFbnOSvmbQqdBGlQmmOWLj0/NRPfbOzkm0qDa4wtTaz2DoR4ky9bn6?=
 =?us-ascii?Q?NbASOIHMIWrFf2zMQjTF2IAK1Rp9QxnEg11OAteDgfmTY26KACGE9T+6zsIw?=
 =?us-ascii?Q?hCz/7Tjkn+e78GkWmywxFya3Ul7oTbtP+2tyAakDe0Kt6YPHCtGzvNC2Er/w?=
 =?us-ascii?Q?O8puAlo+3d9TqTzWe+9QC4AqectvF00bYXhFqP8Tg/YVdRP8qRABHaI9SCNN?=
 =?us-ascii?Q?wbwqJqY+3QbLOwl8Zc8oCO6WXsQVbHchYDZALioWjfd1KRn11/LfUdgnzrRa?=
 =?us-ascii?Q?71ILAbMJDgG7qM0bwX3FzTv1kcNHSYp5LM40OiMMsSh0gHCxXeHAxi4hV1Hr?=
 =?us-ascii?Q?ol/gAsIRyS+qXRGVL9GO8t5Z6WM9bMJbhONNqmbirflx10/9Xb35+sNXt2Da?=
 =?us-ascii?Q?N7m2vz0H3A6XW0vAzmWO1/QJAccVq5QnMrTZ/sGppRSuCbb7ifSLai1RHVvQ?=
 =?us-ascii?Q?tw3saHGLAQm1GGO+iCa0kWPqbgrD6obwOzt5LoP1r7COdFi41kxdxCnsN4qm?=
 =?us-ascii?Q?uW5WZdBAACFkSTRiI7iGnnogn6jq5RuXFUXopjQ41+jPjqddFPGx3+Oxt39S?=
 =?us-ascii?Q?qezcbFFoS0uM/empiaB9yE8O5flHsdMHU62xiuz/Y3fxSb3MeCQdMMrVh38W?=
 =?us-ascii?Q?fszHM8F276y0kYjHvEOVAlO3GEJGrDzJSwsbLWPX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HnUeuubFurcO+ztYfUkJ6Rwe6HduZioXgjAyFoUGUQZQKSOR9FZvQx7GM42SLtUbiXAppEuqQbMH2cZ4UYuIbabPFJSguwlozDr5fxIKkN2zYnq0grlg3aVrXW1mzDh/zqs7HgFHGO+f2/rZekOGrcatXkkCwSpiYm3g9qEsNwSO93qxyR3b8dMsbQm/hHGCuRzT7vCcf7JQ8sjt/jwvm6dYB2IZ4EaleoREvuvc/pN94Vw5mf6Q1aD74733ucDyizQczQqOvhJVSOFY7qbTtyfSh5I4ciSdoPCnYQLS7gG/yl0bUMixTldj1orUVxNLxA8zhs66RuP3D12cgeakGIHuLbBaJ+UN4UU3xpMdQFGQKpFr1etyiiFd64uKHS7Er7bbBmPSEj1R0jKyEeKqGMqGkPUgzPK35kFbznomoBSs8K9/MdB3+18ZJ+tN5nA1vPLicx3fxJbCuT2Nov2JRkSA5WIJB1gcW+kqryXhsDJtye6ZKGuA5hTfezoBNAMiBXjtITYodyg9tvGkd0+rHFAOOF3FAOKVdkKSRMIg+CMjwi/dONGr2zfvVUhYqTFJVuG7eqYr5nXtiBfMiSHX4Lfwqk3PFp9PiSYzeFfw8HKxQ3bWzLTbzbKF34QFfIttmRNLtqGAQe54UXqpUCTutNCQ8TbiB9UwaVH8xVgMT8zPkOfk061P2yNfloPGRO7BLRV+aU8eKqL4Bd6uJAW2Es9Vo6ecUU6ewh243Dqx4QBTF6F5iQO3HoAs2PlU+LDV9/d+cdar4hW7sMppyCfBnQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042ad44c-65e5-44cb-1d7c-08db726e032b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 15:41:42.9430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptrcWog10dteaVQb6dL8AFgDolDFoR3lOqxLS4viD4VIwelf8HpH4z39mZO+/mAyWsQ+1qx/TdD68UpdEWn4Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210132
X-Proofpoint-GUID: Hfugp-wHmMoSj-HxjX0ReG-31688L_0e
X-Proofpoint-ORIG-GUID: Hfugp-wHmMoSj-HxjX0ReG-31688L_0e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On aarch64 systems with glibc 2.28, several btrfs-progs test cases are
failing because the command 'btrfs inspect dump-super -a <dev>' reports
an error when it attempts to read beyond the disk/file-image size.

  $ btrfs inspect dump-super /dev/vdb12
  <snap>
  ERROR: Failed to read the superblock on /dev/vdb12 at 274877906944
  ERROR: Error = 'No such file or directory', errno = 2

This is because `pread()` behaves differently on aarch64 and sets
`errno = 2` instead of the usual `errno = 0`.

To fix include `errno = 2` as the expected error and return success.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect-dump-super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 4529b2308d7e..1121d9af93b9 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -37,8 +37,12 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 
 	ret = sbread(fd, &sb, sb_bytenr);
 	if (ret != BTRFS_SUPER_INFO_SIZE) {
-		/* check if the disk if too short for further superblock */
-		if (ret == 0 && errno == 0)
+		/*
+		 * Check if the disk if too short for further superblock.
+		 * On aarch64 glibc 2.28, pread() would set errno = 2 if read
+		 * beyond the disk size.
+		 */
+		if (ret == 0 && (errno == 0 || errno == 2))
 			return 0;
 
 		error("Failed to read the superblock on %s at %llu read %llu/%d bytes",
-- 
2.31.1

